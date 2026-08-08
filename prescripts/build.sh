#!/usr/bin/env bash
# Build the PayPal prescripts plugin (a kapsis shared library).
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
KAPSIS_SRC="${KAPSIS_SRC:-/Users/georgelemon/Development/packages/kapsis/src}"
cd "$ROOT/prescripts"
nim c --app:lib --path:"$KAPSIS_SRC" -o:libpaypal_prescripts.dylib prescripts.nim
echo "built $ROOT/prescripts/libpaypal_prescripts.dylib"
