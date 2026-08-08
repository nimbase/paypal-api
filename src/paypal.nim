# PayPal REST API clients for Nim.
#
# This package bundles one auto-generated client per PayPal REST API.
# Each API is a nested nimble package under deps/; import the modules you need:
#
#   import paypal/orders
#   import paypal/payments

import ./paypal/[
  catalog,
  disputes,
  invoices,
  orders,
  partner_referrals,
  payment_experience,
  payment_tokens,
  payments,
  payouts,
  reporting,
  subscriptions,
  tracking,
  webhooks
]

export catalog, disputes, invoices, orders, partner_referrals, payment_experience, payment_tokens, payments, payouts, reporting, subscriptions, tracking, webhooks
