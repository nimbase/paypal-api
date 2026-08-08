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
# Usage:
#   scripts/gen.sh                # specs/ -> src/paypal/paypal_*/
#   scripts/gen.sh --specs:<dir>  # use a different specs dir
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SPECS_DIR="$ROOT/specs"
CHILDREN_DIR="$ROOT/src/paypal"

for arg in "$@"; do
  case "$arg" in
    --specs:*) SPECS_DIR="${arg#--specs:}" ;;
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
echo "children dir: $CHILDREN_DIR"

cd "$ROOT"

# one-time setup: clean generated output, build the script plugins
rm -rf "$CHILDREN_DIR"
rm -f src/paypal.nim config.nims
"$ROOT/postscripts/build.sh" >/dev/null
"$ROOT/prescripts/build.sh" >/dev/null

libs=()
for spec in "$SPECS_DIR"/*.json; do
  [ -f "$spec" ] || continue
  name="$(basename "$spec")"
  echo ">> generating $name"

  lib="$(libName "$spec" "$name")"
  full="paypal_$lib"
  echo "   -> $full"

  if ! nimbase oapi.gen "$spec" "$CHILDREN_DIR/$full" -y >/dev/null 2>&1; then
    echo "!! FAILED: $name" >&2
    continue
  fi
  libs+=("$lib")
done

if [ "${#libs[@]}" -eq 0 ]; then
  echo "no libs generated" >&2
  exit 1
fi

echo
echo "done. generated children:"
printf '  src/paypal/paypal_%s\n' "${libs[@]}"
