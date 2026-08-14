#!/usr/bin/env bash
#
# Generate the PayPal REST API clients as nested module trees inside the main
# `paypal` package.
#
# For each OpenAPI 3.x spec in specs/, runs `nimbase oapi.gen` into
# src/paypal/paypal_<lib>. `oapi.gen` automatically runs the package's
# prescripts (before) and postscripts (after); the postscripts rename the
# generated identity to paypal_<lib> (dropping the per-client .nimble), apply
# the Nim-specific fixes and wire the main paypal package (shims, src/paypal.nim,
# config.nims, nimble task test).
#
# The prescript/postscript plugins are built on the fly with plain `nim c`
# (deps resolved via the per-dir *.nimble); if specs/ is empty the specs are
# downloaded from paypal/paypal-rest-api-specifications, so this script works
# from a bare checkout (e.g. the nimbase-bot CI job).
#
# Usage:
#   scripts/gen.sh                # specs/ -> src/paypal/paypal_*/
#   scripts/gen.sh --specs:<dir>  # use a different specs dir
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SPECS_DIR="$ROOT/specs"
CHILDREN_DIR="$ROOT/src/paypal"
SPECS_BASE="https://raw.githubusercontent.com/paypal/paypal-rest-api-specifications/main/openapi"

for arg in "$@"; do
  case "$arg" in
    --specs:*) SPECS_DIR="${arg#--specs:}" ;;
    *) echo "unknown argument: $arg" >&2; exit 1 ;;
  esac
done

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

downloadSpecs() {
  mkdir -p "$SPECS_DIR"
  local specs=(
    billing_subscriptions_v1.json catalogs_products_v1.json checkout_orders_v2.json
    customer_disputes_v1.json customer_partner_referrals_v2.json invoicing_v2.json
    notifications_webhooks_v1.json payment-experience_web_experience_profiles_v1.json
    payments_payment_v2.json payments_payouts_batch_v1.json reporting_transactions_v1.json
    shipping_shipment_tracking_v1.json vault_payment_tokens_v3.json
  )
  for s in "${specs[@]}"; do
    echo ">> downloading $s"
    if ! curl -fsSL "$SPECS_BASE/$s" -o "$SPECS_DIR/$s"; then
      echo "!! failed to download $s" >&2
    fi
  done
}

buildPlugin() {
  local dir="$1"
  echo ">> building plugin in $dir"
  ( cd "$dir" && nimble install -Y >/dev/null 2>&1; nim c --app:lib --outdir:. "$(basename "$dir").nim" )
}

if [ ! -d "$SPECS_DIR" ] || [ -z "$(ls "$SPECS_DIR"/*.json 2>/dev/null)" ]; then
  echo "no .json specs found in $SPECS_DIR, downloading from $SPECS_BASE"
  downloadSpecs
fi

echo "specs dir: $SPECS_DIR"
echo "children dir: $CHILDREN_DIR"

cd "$ROOT"

# one-time setup: clean generated output, build the script plugins
rm -rf "$CHILDREN_DIR"
rm -f src/paypal.nim config.nims
buildPlugin "$ROOT/postscripts"
buildPlugin "$ROOT/prescripts"

libs=()
for spec in "$SPECS_DIR"/*.json; do
  [ -f "$spec" ] || continue
  name="$(basename "$spec")"
  echo ">> generating $name"

  lib="$(libName "$spec" "$name")"
  full="paypal_$lib"
  echo "   -> $full"

  if ! nimbase oapi.gen "$spec" "$CHILDREN_DIR/$full" -y 2>gen.err; then
    echo "!! FAILED: $name" >&2
    echo "--- nimbase oapi.gen stderr ---" >&2
    cat gen.err >&2
    echo "---" >&2
    rm -f gen.err
    continue
  fi
  rm -f gen.err
  libs+=("$lib")
done

if [ "${#libs[@]}" -eq 0 ]; then
  echo "no libs generated" >&2
  exit 1
fi

echo
echo "done. generated children:"
printf '  src/paypal/paypal_%s\n' "${libs[@]}"
