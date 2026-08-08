#!/usr/bin/env bash
# Build the PayPal postscripts plugin (a kapsis shared library).
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
KAPSIS_SRC="${KAPSIS_SRC:-/Users/georgelemon/Development/packages/kapsis/src}"
cd "$ROOT/postscripts"
nim c --app:lib --path:"$KAPSIS_SRC" -o:libpaypal_postscripts.dylib postscripts.nim
echo "built $ROOT/postscripts/libpaypal_postscripts.dylib"
