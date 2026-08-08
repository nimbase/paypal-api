# PayPal postscripts - post-generation fixes and wiring for the Nim clients
#
# A kapsis plugin (shared library). Build with:
#   nim c --app:lib -o:libpaypal_postscripts.dylib postscripts.nim
#
# `nimbase oapi.gen` runs these automatically after generating a package
# (each command receives the generated package dir as `path`). Commands run in
# registration order: package identity rename, code fixes, then wiring.
#
# (c) 2026 George Lemon | MIT License

import std/[os, strutils, sets, re, algorithm]

import pkg/pluginkit
import pkg/kapsis/pluginapi

proc normIdent(s: string): string =
  ## Nim compares identifiers case- and underscore-insensitively.
  s.replace("_", "").toLowerAscii

proc pascalCase(s: string): string =
  ## foo_bar -> FooBar
  for part in s.split('_'):
    if part.len > 0:
      result.add(part[0].toUpperAscii)
      result.add(part[1 .. ^1])

proc libNameOf(dir: string): string =
  ## deps/paypal_catalog -> catalog
  var base = dir.splitFile.name
  if base.startsWith("paypal_"):
    base = base["paypal_".len .. ^1]
  base

proc findPkgRoot(start: string): string =
  ## Walk up from a lib dir until the paypal package root (paypal.nimble).
  var d = start
  while true:
    if fileExists(d / "paypal.nimble"):
      return d
    let p = parentDir(d)
    if p == d:
      return ""
    d = p

proc fixEnumCollisions(file: string): int =
  ## Deduplicate enum field identifiers that collide (style-insensitively)
  ## within a module. Nim enum fields share one namespace per scope, so values
  ## like "STAR_TRACK_EXPRESS" and "STARTRACKEXPRESS" both sanitize to
  ## `STARTRACKEXPRESS` and must be disambiguated. Wire string values are kept.
  let content = readFile(file)
  let lines = content.split('\n')

  var reserved = initHashSet[string]()
  for ln in lines:
    var caps = newSeq[string](1)
    if ln.match(re("^\\s{2}([A-Za-z_`][A-Za-z0-9_`]*)\\*?\\s*=\\s*"), caps):
      reserved.incl(normIdent(caps[0]))

  let enumStart = re("^\\s{2}[A-Za-z_`][A-Za-z0-9_`]*\\*?\\s*=\\s*enum\\s*$")
  let field = re("^(\\s{4,})([A-Za-z0-9_`]+)\\s*=\\s*\"")

  var
    outLines: seq[string]
    seen = initHashSet[string]()
    changed = 0
    i = 0
  while i < lines.len:
    let ln = lines[i]
    if ln.match(enumStart):
      outLines.add(ln)
      inc i
      while i < lines.len:
        let fld = lines[i]
        if fld.strip.startsWith("#"):
          outLines.add(fld)
          inc i
          continue
        var caps = newSeq[string](2)
        if not fld.match(field, caps):
          break
        var ident = caps[1]
        if normIdent(ident) in seen or normIdent(ident) in reserved:
          var k = 2
          while normIdent(ident & $k) in seen or normIdent(ident & $k) in reserved:
            inc k
          let newIdent = ident & $k
          let pos = fld.find(ident)
          outLines.add(fld[0 ..< pos] & newIdent & fld[pos + ident.len .. ^1])
          ident = newIdent
          inc changed
        else:
          outLines.add(fld)
        seen.incl(normIdent(ident))
        inc i
      continue
    outLines.add(ln)
    inc i

  if changed > 0:
    writeFile(file, outLines.join("\n"))
  changed

proc fixTypeIdents(dir: string): int =
  ## Rename type declarations that start with a digit (e.g. `400`) to a valid
  ## Nim identifier (`Status400`). Such schemas are PayPal error types. Names
  ## are collected across the whole package first, then every file is patched
  ## (declarations plus `pkg.400` / `types.400` qualified references).
  var names: seq[string]
  var seen = initHashSet[string]()
  for path in walkDirRec(dir):
    if path.splitFile.ext != ".nim":
      continue
    for ln in readFile(path).split('\n'):
      var caps = newSeq[string](1)
      if ln.match(re("^\\s{2}([0-9][A-Za-z0-9_]*)\\* = "), caps):
        let n = caps[0]
        if n notin seen:
          seen.incl(n)
          names.add(n)
  if names.len == 0:
    return

  let qualifiers = @[dir.splitFile.name, "types"]
  for path in walkDirRec(dir):
    if path.splitFile.ext != ".nim":
      continue
    let content = readFile(path)
    var patched = content
    var changed = false
    for n in names:
      let oldDecl = "  " & n & "* = "
      let newDecl = "  Status" & n & "* = "
      if patched.contains(oldDecl):
        patched = patched.replace(oldDecl, newDecl)
        changed = true
      for q in qualifiers:
        let oldQual = q & "." & n
        let newQual = q & ".Status" & n
        if patched.contains(oldQual):
          patched = patched.replace(oldQual, newQual)
          changed = true
    if changed:
      writeFile(path, patched)
      inc result

proc clientIdentOf(metaclient: string): string =
  ## The PascalCase prefix of the generated client type, e.g. `Payment` for
  ## `PaymentClient* = ref object of RootObj`.
  var caps = newSeq[string](1)
  if findBounds(readFile(metaclient),
      re("(?m)^\\s{2}([A-Za-z0-9_]+)Client\\* = ref object of RootObj"), caps)[0] != -1:
    result = caps[0]

proc findMetaclient(dir: string): string =
  ## Locate `metaclient.nim` anywhere under a generated package dir.
  for path in walkDirRec(dir):
    if path.splitFile.name == "metaclient":
      return path
  ""

proc fixQueryDefaults(dir: string): int =
  ## Fix query parameters that have an enum *and* a default value. The codegen
  ## types such a param `string = "APPLICATION"` but still emits set-iteration
  ## (`for v in param: q[...] = $v`) in the client and a `({})` call in the
  ## generated tests. Patch both to the plain string form.
  let loopRe = re("for v in ([A-Za-z_][A-Za-z0-9_]*): q\\[\"([^\"]+)\"\\] = \\$v")
  let procRe = re("proc ([A-Za-z_][A-Za-z0-9_]*)\\*\\(")
  var fixedProcs: seq[string]

  for path in walkDirRec(dir):
    if path.splitFile.ext != ".nim" or path.splitFile.dir.endsWith("tests"):
      continue
    let content = readFile(path)
    var patched = content
    var changed = false
    var start = 0
    while start < content.len:
      var caps = newSeq[string](2)
      let fb = findBounds(content, loopRe, caps, start)
      if fb[0] < 0:
        break
      let param = caps[0]
      let wire = caps[1]
      if content.contains(re(param & ": string = ")):
        let loopLine = "for v in " & param & ": q[\"" & wire & "\"] = $v"
        if patched.contains(loopLine):
          patched = patched.replace(loopLine, "q[\"" & wire & "\"] = " & param)
          changed = true
          # enclosing proc name: last `proc x*(` before this match
          let head = content[0 ..< fb[0]]
          var pstart = 0
          var lastProc = ""
          while pstart < head.len:
            var pcaps = newSeq[string](1)
            let pb = findBounds(head, procRe, pcaps, pstart)
            if pb[0] < 0:
              break
            lastProc = pcaps[0]
            pstart = pb[1]
          if lastProc.len > 0:
            fixedProcs.add(lastProc)
      start = fb[1]
    if changed:
      writeFile(path, patched)
      inc result

  for path in walkDirRec(dir):
    if path.splitFile.ext != ".nim" or not path.splitFile.dir.endsWith("tests"):
      continue
    let content = readFile(path)
    var patched = content
    var changed = false
    for p in fixedProcs:
      let broken = "client." & p & "({})"
      if patched.contains(broken):
        patched = patched.replace(broken, "client." & p & "()")
        changed = true
    if changed:
      writeFile(path, patched)
      inc result

proc renameClientIdent(dir: string): int =
  ## Rename the generated client type so it matches the lib directory name,
  ## e.g. the `payment` spec -> payment_tokens lib -> `PaymentTokensClient`.
  ## Covers `*Client`, `*ClientError` and `init*Client` across the lib.
  let metaclient = findMetaclient(dir)
  if not fileExists(metaclient):
    return
  let current = clientIdentOf(metaclient)
  let desired = pascalCase(libNameOf(dir))
  if current.len == 0 or normIdent(current) == normIdent(desired):
    return
  var changed = 0
  for path in walkDirRec(dir):
    if path.splitFile.ext != ".nim":
      continue
    let content = readFile(path)
    let patched = content.replace(current & "Client", desired & "Client")
    if patched != content:
      writeFile(path, patched)
      inc changed
  changed

proc patchPackageImports(dir, old, new: string) =
  ## Rewrite `import <old>` lines, `./<old>/[` module refs and `<old>.`
  ## qualified refs across a package after its identity rename.
  for path in walkDirRec(dir):
    if path.splitFile.ext != ".nim":
      continue
    var outLines: seq[string]
    for ln in readFile(path).split('\n'):
      var l = ln
      if l == "import " & old:
        l = "import " & new
      else:
        l = l.replace("./" & old & "/[", "./" & new & "/[")
        l = l.replace(old & ".", new & ".")
      outLines.add(l)
    writeFile(path, outLines.join("\n"))

proc renamePackage(dir: string): int =
  ## Rename the generated package identity from the nimbase-derived name to
  ## the `paypal_<lib>` package name (main module + src dir + imports). Always
  ## drops the `oapi.gen` artifacts: the per-client `.nimble` and the template
  ## `README.md` (the nested packages are modules of the root `paypal` package,
  ## not standalone nimble packages).
  let src = dir / "src"
  if not dirExists(src):
    return
  for f in walkFiles(dir / "*.nimble"):
    removeFile(f)
  if fileExists(dir / "README.md"):
    removeFile(dir / "README.md")
  var derived = ""
  for f in walkFiles(src / "*.nim"):
    derived = splitFile(f).name
    break
  if derived.len == 0:
    return
  let target = dir.splitFile.name  # e.g. paypal_catalog
  if derived == target:
    return  # idempotent
  moveFile(src / derived & ".nim", src / target & ".nim")
  if dirExists(src / derived):
    moveDir(src / derived, src / target)
  patchPackageImports(dir, derived, target)
  result = 1

proc writeShim(pkgRoot, lib: string) =
  let shimDir = pkgRoot / "src/paypal"
  createDir(shimDir)
  writeFile(shimDir / lib & ".nim",
    "import paypal_" & lib & "\n\nexport paypal_" & lib & "\n")

proc writePaypalNim(pkgRoot: string) =
  let shimsDir = pkgRoot / "src/paypal"
  var libs: seq[string]
  if dirExists(shimsDir):
    for f in walkFiles(shimsDir / "*.nim"):
      libs.add(splitFile(f).name)
  sort(libs)
  var content =
    "# PayPal REST API clients for Nim.\n" &
    "#\n" &
    "# This package bundles one auto-generated client per PayPal REST API.\n" &
    "# Each API is a nested nimble package under deps/; import the modules you need:\n" &
    "#\n" &
    "#   import paypal/orders\n" &
    "#   import paypal/payments\n\n"
  content.add("import ./paypal/[\n")
  for i, l in libs:
    content.add("  " & l)
    if i < libs.high:
      content.add(",")
    content.add("\n")
  content.add("]\n\nexport " & libs.join(", ") & "\n")
  writeFile(pkgRoot / "src/paypal.nim", content)

proc writeConfig(pkgRoot: string) =
  var lines: seq[string]
  let children = pkgRoot / "src/paypal"
  if dirExists(children):
    for d in walkDirs(children / "paypal_*"):
      let lib = splitFile(d).name
      lines.add("switch(\"path\", \"src/paypal/" & lib & "/src\")")
  sort(lines)
  lines.add("switch(\"path\", \"/Users/georgelemon/Development/packages/openparser/src\")")
  writeFile(pkgRoot / "config.nims", lines.join("\n") & "\n")

proc writeTestTask(pkgRoot: string) =
  let nb = pkgRoot / "paypal.nimble"
  var content =
    if fileExists(nb): readFile(nb)
    else: ""
  let idx = content.find("\ntask test,")
  if idx >= 0:
    content = content[0 ..< idx]
  if content.len > 0 and content[^1] != '\n':
    content.add("\n")
  content.add("\ntask test, \"Run all tests\":\n")
  var execLines: seq[string]
  let children = pkgRoot / "src/paypal"
  if dirExists(children):
    for d in walkDirs(children / "paypal_*"):
      let lib = splitFile(d).name
      for t in walkFiles(d / "tests/test_*.nim"):
        execLines.add("  exec \"nim r src/paypal/" & lib & "/tests/" & splitFile(t).name & ".nim\"")
  sort(execLines)
  for e in execLines:
    content.add(e & "\n")
  writeFile(nb, content)

plugin paypal_postscripts, {
  name: "PayPalPostscripts",
  author: "OpenPeeps",
  description: "Post-generation fixes and wiring for the PayPal Nim clients",
  license: "MIT",
  version: "0.1.0"
}:
  commands do:
    rename_package path.string:
      ## Rename the generated package identity to paypal_<lib>
      let dir = v.get("path").getStr
      if dirExists(dir):
        let n = renamePackage(dir)
        if n > 0:
          echo "renamed package identity -> ", dir.splitFile.name

    fix_enum_collisions path.string:
      ## Dedupe colliding enum field identifiers across a generated module
      let dir = v.get("path").getStr
      if not dirExists(dir):
        echo "target directory does not exist: ", dir
      else:
        var fixed = 0
        for path in walkDirRec(dir):
          if path.splitFile.ext == ".nim":
            fixed += fixEnumCollisions(path)
        echo "fixed ", fixed, " colliding enum field(s)"

    rename_client path.string:
      ## Rename the generated client ident to match the lib name
      let dir = v.get("path").getStr
      if dirExists(dir):
        let n = renameClientIdent(dir)
        if n > 0:
          echo "renamed client ident in ", n, " file(s)"

    fix_type_idents path.string:
      ## Rename digit-leading type declarations (e.g. 400 -> Status400)
      let dir = v.get("path").getStr
      if dirExists(dir):
        let n = fixTypeIdents(dir)
        echo "fixed ", n, " file(s) with digit-leading type names"

    fix_query_defaults path.string:
      ## Fix enum query params with defaults (string typed, set-iteration)
      let dir = v.get("path").getStr
      if dirExists(dir):
        let n = fixQueryDefaults(dir)
        echo "fixed ", n, " file(s) with enum-default query params"

    write_shims path.string:
      ## Write src/paypal/<lib>.nim shim for this package
      let pkg = findPkgRoot(v.get("path").getStr)
      if pkg.len > 0:
        writeShim(pkg, libNameOf(v.get("path").getStr))
        echo "wrote shim"

    write_paypal_nim path.string:
      ## Rebuild src/paypal.nim from the shims present
      let pkg = findPkgRoot(v.get("path").getStr)
      if pkg.len > 0:
        writePaypalNim(pkg)
        echo "wrote src/paypal.nim"

    write_config path.string:
      ## Rebuild the root config.nims from the deps present
      let pkg = findPkgRoot(v.get("path").getStr)
      if pkg.len > 0:
        writeConfig(pkg)
        echo "wrote config.nims"

    write_test_task path.string:
      ## Rebuild the `task test` in paypal.nimble from the deps present
      let pkg = findPkgRoot(v.get("path").getStr)
      if pkg.len > 0:
        writeTestTask(pkg)
        echo "wrote task test"
