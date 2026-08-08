#!/usr/bin/env bash
#
# Generate the PayPal REST API clients as a set of nested nimble packages.
#
# For each OpenAPI 3.x spec in specs/, runs `nimbase openapi.gen` into
# deps/paypal_<lib> WITHOUT moving or stripping anything from the generated
# package (src/, tests/, README and .nimble are kept). Package identity is
# renamed to `paypal_<lib>` (names only, no content moved).
#
# Then it wires the main `paypal` package so the inner packages can be imported:
#   - src/paypal/<lib>.nim   a shim module: `import paypal_<lib>` / `export ...`
#   - src/paypal.nim         imports + exports every shim
#   - config.nims (root)     autoloaded: adds `--path` to each inner package
#   - paypal.nimble          appends a `task test` running every inner test suite
#
# Usage:
#   scripts/gen.sh                # specs/ -> deps/
#   scripts/gen.sh --specs:<dir>  # use a different specs dir
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SPECS_DIR="$ROOT/specs"
DEPS_DIR="$ROOT/deps"
SHIMS_DIR="$ROOT/src/paypal"
AFTERSCRIPTS_DIR="$ROOT/afterscripts"

for arg in "$@"; do
  case "$arg" in
    --specs:*) SPECS_DIR="${arg#--specs:}" ;;
    --deps:*) DEPS_DIR="${arg#--deps:}" ;;
    *) echo "unknown argument: $arg" >&2; exit 1 ;;
  esac
done

if [ ! -d "$SPECS_DIR" ] || [ -z "$(ls "$SPECS_DIR"/*.json 2>/dev/null)" ]; then
  echo "no .json specs found in $SPECS_DIR" >&2
  exit 1
fi

# spec file -> lib name (defaults to the name nimbase derives from the title)
libName() {
  case "$(basename "$1")" in
    checkout_orders_v2.json) echo orders ;;
    payments_payment_v2.json) echo payments ;;
    billing_subscriptions_v1.json) echo subscriptions ;;
    invoicing_v2.json) echo invoices ;;
    customer_disputes_v1.json) echo disputes ;;
    payments_payouts_batch_v1.json) echo payouts ;;
    shipping_shipment_tracking_v1.json) echo tracking ;;
    catalogs_products_v1.json) echo catalog ;;
    notifications_webhooks_v1.json) echo webhooks ;;
    reporting_transactions_v1.json) echo reporting ;;
    vault_payment_tokens_v3.json) echo payment_tokens ;;
    payment-experience_web_experience_profiles_v1.json) echo payment_experience ;;
    customer_partner_referrals_v2.json) echo partner_referrals ;;
    *) echo "$2" ;;
  esac
}

echo "specs dir: $SPECS_DIR"
echo "deps dir: $DEPS_DIR"

# clean previous output
rm -rf "$DEPS_DIR"
rm -rf "$SHIMS_DIR"
rm -f "$ROOT/src/paypal.nim" "$ROOT/config.nims" "$ROOT/src/config.nims" "$ROOT/tests/test1.nim"
mkdir -p "$DEPS_DIR" "$SHIMS_DIR"

libs=()
for spec in "$SPECS_DIR"/*.json; do
  [ -f "$spec" ] || continue
  name="$(basename "$spec")"
  echo ">> generating $name"

  tmp="$(mktemp -d)"
  if ! nimbase openapi.gen "$spec" "$tmp" -y >/dev/null 2>&1; then
    echo "!! FAILED: $name" >&2
    rm -rf "$tmp"
    continue
  fi

  pkg="$(basename "$tmp"/src/*.nim)"
  pkg="${pkg%.nim}"
  lib="$(libName "$spec" "$pkg")"
  full="paypal_$lib"
  echo "   pkg=$pkg -> lib=$lib (package $full)"

  mv "$tmp" "$DEPS_DIR/$full"
  libs+=("$lib")

  # rename package identity (names only, nothing moved/stripped):
  # .nimble + main module + its src dir + import references
  mv "$DEPS_DIR/$full/$pkg.nimble" "$DEPS_DIR/$full/$full.nimble"
  mv "$DEPS_DIR/$full/src/$pkg.nim" "$DEPS_DIR/$full/src/$full.nim"
  mv "$DEPS_DIR/$full/src/$pkg" "$DEPS_DIR/$full/src/$full"
  sed -i '' "s#\./$pkg/\[#./$full/\[#" "$DEPS_DIR/$full/src/$full.nim"
  # patch the generated tests/common: `import $pkg` and pkg-qualified refs
  find "$DEPS_DIR/$full" -name '*.nim' -exec \
    sed -i '' -e "s/^import $pkg\$/import $full/" -e "s/$pkg\./$full./g" {} +

  # afterscript engine: enum collisions, digit-leading type names, client ident
  nimbase afterscripts.run "$DEPS_DIR/$full" --dir:"$AFTERSCRIPTS_DIR" || true
done

if [ "${#libs[@]}" -eq 0 ]; then
  echo "no libs generated" >&2
  exit 1
fi

# --- shim modules: src/paypal/<lib>.nim = import paypal_<lib> / export paypal_<lib> ---
for lib in "${libs[@]}"; do
  printf 'import paypal_%s\n\nexport paypal_%s\n' "$lib" "$lib" > "$SHIMS_DIR/$lib.nim"
done

# --- root link module: src/paypal.nim ---
wrapList() {
  local out="" line=""
  for n in "${libs[@]}"; do
    if [ -z "$line" ]; then
      line="$n"
    elif [ $(( ${#line} + ${#n} + 2 )) -gt 68 ]; then
      out="${out}${line},\n  "
      line="$n"
    else
      line="$line, $n"
    fi
  done
  printf '%b' "${out}${line}"
}

importBlock="$(wrapList)"
exportBlock="$(wrapList)"

{
  echo "# PayPal REST API clients for Nim."
  echo "#"
  echo "# This package bundles one auto-generated client per PayPal REST API."
  echo "# Each API is a nested nimble package under deps/; import the modules you need:"
  echo "#"
  echo "#   import paypal/orders"
  echo "#   import paypal/payments"
  echo
  echo "import ./paypal/["
  echo "$importBlock"
  echo "]"
  echo
  echo "export $exportBlock"
} > "$ROOT/src/paypal.nim"

# --- config.nims (root): autoloaded, adds each inner package's src to the path ---
{
  for lib in "${libs[@]}"; do
    echo "switch(\"path\", \"deps/paypal_$lib/src\")"
  done
  # openparser dev checkout (JSON parser fixes); drop once published
  echo "switch(\"path\", \"/Users/georgelemon/Development/packages/openparser/src\")"
} > "$ROOT/config.nims"

# --- paypal.nimble: append a `task test` that runs every inner package's
# --- generated test suite in its own `nim r` process (replaces any previous block)
if grep -q '^task test,' "$ROOT/paypal.nimble"; then
  line="$(grep -n '^task test,' "$ROOT/paypal.nimble" | head -1 | cut -d: -f1)"
  sed -i '' "$line,\$d" "$ROOT/paypal.nimble"
fi
{
  [ "$(tail -c 1 "$ROOT/paypal.nimble" 2>/dev/null | wc -l | tr -d ' ')" -eq 0 ] && echo
  echo 'task test, "Run all tests":'
  for lib in "${libs[@]}"; do
    for t in "$DEPS_DIR/paypal_$lib/tests"/test_*.nim; do
      [ -f "$t" ] || continue
      echo "  exec \"nim r ${t#"$ROOT"/}\""
    done
  done
} >> "$ROOT/paypal.nimble"

echo
echo "done. generated packages:"
printf '  deps/paypal_%s\n' "${libs[@]}"
