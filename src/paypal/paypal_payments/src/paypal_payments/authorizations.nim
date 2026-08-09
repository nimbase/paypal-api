# paypal_payments API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Nimbase CLI https://github.com/nimbase/nimbase
#
# Generated at: 2026-08-09T17:24:06+03:00
# License: MIT
import std/[strformat]
import ./private/metaclient
import ./private/types


proc getV2PaymentsAuthorizationsAuthorizationId*(client: PaymentsClient,
                                                 authorizationId: string): Future[types.Authorization2] {.async.} =
  ## Shows details for an authorized payment, by ID.

  let res = await client.httpGET(fmt"/v2/payments/authorizations/{authorizationId}")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.Authorization2)
  else:
    raise newException(PaymentsClientError, body)

proc postV2PaymentsAuthorizationsAuthorizationIdCapture*(client: PaymentsClient,
                                                         authorizationId: string,
                                                         body: types.CaptureRequest): Future[types.Capture2] {.async.} =
  ## Captures an authorized payment, by ID.

  let res = await client.httpPOST(fmt"/v2/payments/authorizations/{authorizationId}/capture", body)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.Capture2)
  else:
    raise newException(PaymentsClientError, body)

proc postV2PaymentsAuthorizationsAuthorizationIdReauthorize*(client: PaymentsClient,
                                                             authorizationId: string,
                                                             body: types.ReauthorizeRequest): Future[types.Authorization2] {.async.} =
  ## Reauthorizes an authorized PayPal account payment, by ID. To ensure that funds
  ## are still available, reauthorize a payment after its initial three-day honor
  ## period expires. Within the 29-day authorization period, you can issue multiple
  ## re-authorizations after the honor period expires.<br/><br/>If 30 days have
  ## transpired since the date of the original authorization, you must create an
  ## authorized payment instead of reauthorizing the original authorized
  ## payment.<br/><br/>A reauthorized payment itself has a new honor period of three
  ## days.<br/><br/>You can reauthorize an authorized payment from 4 to 29 days after
  ## the 3-day honor period. The allowed amount depends on context and geography, for
  ## example in US it is up to 115% of the original authorized amount, not to exceed
  ## an increase of $75 USD.<br/><br/>Supports only the `amount` request parameter.

  let res = await client.httpPOST(fmt"/v2/payments/authorizations/{authorizationId}/reauthorize", body)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.Authorization2)
  else:
    raise newException(PaymentsClientError, body)

proc postV2PaymentsAuthorizationsAuthorizationIdVoid*(client: PaymentsClient,
                                                      authorizationId: string): Future[types.Authorization2] {.async.} =
  ## Voids, or cancels, an authorized payment, by ID. You cannot void an authorized
  ## payment that has been fully captured.

  let res = await client.httpPOST(fmt"/v2/payments/authorizations/{authorizationId}/void")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.Authorization2)
  else:
    raise newException(PaymentsClientError, body)
