# paypal_payments API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Nimbase CLI https://github.com/nimbase/nimbase
#
# Generated at: 2026-08-08T22:36:56+03:00
# License: MIT
import std/[strformat, options, json]
import ./private/metaclient
import ./private/types
import ./private/renames


proc getV2PaymentsRefundsRefundId*(client: PaymentsClient,
                                   refundId: string): Future[types.Refund] {.async.} =
  ## Shows details for a refund, by ID.

  let res = await client.httpGET(fmt"/v2/payments/refunds/{refundId}")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.Refund)
  else:
    raise newException(PaymentsClientError, body)
