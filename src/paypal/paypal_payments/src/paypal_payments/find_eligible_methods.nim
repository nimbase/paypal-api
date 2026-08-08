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


proc postV2PaymentsFindEligibleMethods*(client: PaymentsClient,
                                        body: types.FindEligibleMethodsRequest): Future[types.FindEligibleMethodsResponse] {.async.} =
  ## Get a list of eligible payment methods based on the input parameters provided.

  let res = await client.httpPOST("/v2/payments/find-eligible-methods", body)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.FindEligibleMethodsResponse)
  else:
    raise newException(PaymentsClientError, body)
