# PayPal REST API clients for Nim.
#
# This package bundles one auto-generated client per PayPal REST API.
# Each API is a nested nimble package under deps/; import the modules you need:
#
#   import paypal/orders
#   import paypal/payments

import ./paypal/[
subscriptions, catalog, orders, disputes, partner_referrals,
  invoices, webhooks, payment_experience, payments, payouts, reporting,
  tracking, payment_tokens
]

export subscriptions, catalog, orders, disputes, partner_referrals,
  invoices, webhooks, payment_experience, payments, payouts, reporting,
  tracking, payment_tokens
