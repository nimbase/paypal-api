# paypal_orders API client for Nim
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


proc postV2CheckoutOrdersOrderUpdateCallback*(client: OrdersClient,
                                              body: types.OrderUpdateCallbackRequest): Future[types.OrderUpdateCallbackResponse] {.async.} =
  ## The documentation for this 'endpoint' is different from the other endpoints
  ## under v2 Orders. For this endpoint the role of client and server is reversed.
  ## The client sending the request is PayPal, and the server sending the response is
  ## the merchant. In the request, PayPal will send the buyer's redacted shipping
  ## address and selected shipping option to the callback URL defined the create
  ## order request. The response from the merchant will update the Orders resource.

  let res = await client.httpPOST("/v2/checkout/orders/order-update-callback", body)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.OrderUpdateCallbackResponse)
  else:
    raise newException(OrdersClientError, body)
