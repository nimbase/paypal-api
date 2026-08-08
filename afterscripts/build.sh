#!/usr/bin/env bash
# Build the PayPal afterscript plugin (a kapsis shared library).
#
# Requires the dev kapsis checkout (plugin system) on the compiler path.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
KAPSIS_SRC="${KAPSIS_SRC:-/Users/georgelemon/Development/packages/kapsis/src}"

cd "$ROOT/afterscripts"
nim c --app:lib --path:"$KAPSIS_SRC" \
  -o:libpaypal_afterscripts.dylib afterscripts.nim
echo "built $ROOT/afterscripts/libpaypal_afterscripts.dylib"
