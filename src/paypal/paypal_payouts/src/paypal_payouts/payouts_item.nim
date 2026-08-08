# paypal_payouts API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Nimbase CLI https://github.com/nimbase/nimbase
#
# Generated at: 2026-08-08T23:21:33+03:00
# License: MIT
import std/[strformat, options, json]
import ./private/metaclient
import ./private/types


proc getV1PaymentsPayoutsItemPayoutItemId*(client: PayoutsClient,
                                           payoutItemId: string): Future[types.PayoutItem] {.async.} =
  ## Shows details for a payout item, by ID. A <code>payout_item_id</code> helps you
  ## identify denied payments. If a payment is denied, you can use the
  ## <code>payout_item_id</code> to identify the payment even if it lacks a
  ## <code>transaction_id</code>.

  let res = await client.httpGET(fmt"/v1/payments/payouts-item/{payoutItemId}")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.PayoutItem)
  else:
    raise newException(PayoutsClientError, body)

proc postV1PaymentsPayoutsItemPayoutItemIdCancel*(client: PayoutsClient,
                                                  payoutItemId: string): Future[types.PayoutItem] {.async.} =
  ## Cancels an unclaimed payout item, by ID. If no one claims the unclaimed item
  ## within 30 days, the API automatically returns the funds to the sender. Use this
  ## call to cancel the unclaimed item before the automatic 30-day refund. You can
  ## cancel payout items with a <code>transaction_status</code> of
  ## <code>UNCLAIMED</code>.

  let res = await client.httpPOST(fmt"/v1/payments/payouts-item/{payoutItemId}/cancel")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.PayoutItem)
  else:
    raise newException(PayoutsClientError, body)
