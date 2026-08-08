# paypal_orders API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Clue CLI Assistant https://github.com/openpeeps/clue
#
# Generated at: 2026-08-08T22:10:21+03:00
# License: MIT
import std/[asyncdispatch, options, json]
import unittest
import pkg/openparser/json as openjson
import paypal_orders
import ./common

suite "externalcallback serialization":
  test "round-trips OrderUpdateCallbackResponse":
    let obj = newOrderUpdateCallbackResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_orders.OrderUpdateCallbackResponse)) == openjson.toJson(obj)

  test "round-trips OrderUpdateCallbackErrorResponse":
    let obj = newOrderUpdateCallbackErrorResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_orders.OrderUpdateCallbackErrorResponse)) == openjson.toJson(obj)

  test "round-trips OrderUpdateCallbackRequest":
    let obj = newOrderUpdateCallbackRequest()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_orders.OrderUpdateCallbackRequest)) == openjson.toJson(obj)

  test "round-trips Error":
    let obj = newError()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_orders.Error)) == openjson.toJson(obj)

suite "externalcallback endpoints":
  test "POST /v2/checkout/orders/order-update-callback":
    let client = initOrdersClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV2CheckoutOrdersOrderUpdateCallback(newOrderUpdateCallbackRequest())

