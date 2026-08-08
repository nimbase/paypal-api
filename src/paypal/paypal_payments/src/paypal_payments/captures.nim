# paypal_payments API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Nimbase CLI https://github.com/nimbase/nimbase
#
# Generated at: 2026-08-08T23:21:33+03:00
# License: MIT
import std/[strformat, options, json]
import ./private/metaclient
import ./private/types
import ./private/renames


proc getV2PaymentsCapturesCaptureId*(client: PaymentsClient,
                                     captureId: string): Future[types.Capture2] {.async.} =
  ## Shows details for a captured payment, by ID.

  let res = await client.httpGET(fmt"/v2/payments/captures/{captureId}")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.Capture2)
  else:
    raise newException(PaymentsClientError, body)

proc postV2PaymentsCapturesCaptureIdRefund*(client: PaymentsClient,
                                            captureId: string,
                                            body: types.RefundRequest): Future[types.Refund] {.async.} =
  ## Refunds a captured payment, by ID. For a full refund, include an empty payload
  ## in the JSON request body. For a partial refund, include an <code>amount</code>
  ## object in the JSON request body.

  let res = await client.httpPOST(fmt"/v2/payments/captures/{captureId}/refund", body)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.Refund)
  else:
    raise newException(PaymentsClientError, body)
