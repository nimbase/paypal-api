# payments API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Clue CLI Assistant https://github.com/openpeeps/clue
#
# Generated at: 2026-08-08T20:42:35+03:00
# License: MIT
import std/[strformat, options, json]
import ./metaclient
import ./types
import ./renames


proc getV2PaymentsRefundsRefundId*(client: PaymentsClient, refundId: string): Future[types.Refund] {.async.} =
  ## Shows details for a refund, by ID.

  let res = await client.httpGET(fmt"/v2/payments/refunds/{refundId}")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.Refund)
  else:
    raise newException(PaymentsClientError, body)
