# payments API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Clue CLI Assistant https://github.com/openpeeps/clue
#
# Generated at: 2026-08-08T20:01:03+03:00
# License: MIT
import std/[strformat, options, json]
import ./metaclient
import ./types
import ./renames


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
