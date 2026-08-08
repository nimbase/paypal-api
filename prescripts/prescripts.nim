# PayPal prescripts - pre-generation hooks for the generated Nim clients
#
# A kapsis plugin (shared library). Build with:
#   nim c --app:lib -o:libpaypal_prescripts.dylib prescripts.nim
#
# `nimbase oapi.gen` runs these automatically before generating a package.
# Each command receives the output dir as `path` and, when declared, the
# OpenAPI spec as `spec`.
#
# (c) 2026 George Lemon | MIT License

import std/[os]

import pkg/pluginkit
import pkg/kapsis/pluginapi

plugin paypal_prescripts, {
  name: "PayPalPrescripts",
  author: "OpenPeeps",
  description: "Pre-generation hooks for the PayPal Nim clients",
  license: "MIT",
  version: "0.1.0"
}:
  commands do:
    validate_spec spec.string:
      ## Ensure the OpenAPI spec file exists
      let spec = v.get("spec").getStr
      if not fileExists(spec):
        echo "spec not found: ", spec
      else:
        echo "validated ", spec
