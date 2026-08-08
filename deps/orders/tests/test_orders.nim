# orders API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Clue CLI Assistant https://github.com/openpeeps/clue
#
# Generated at: 2026-08-08T18:16:13+03:00
# License: MIT
import std/[asyncdispatch, options, json]
import unittest
import pkg/openparser/json as openjson
import orders
import ./common

suite "orders serialization":
  test "round-trips OrderCaptureRequest":
    let obj = newOrderCaptureRequest()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), orders.OrderCaptureRequest)) == openjson.toJson(obj)

  test "round-trips ConfirmOrderRequest":
    let obj = newConfirmOrderRequest()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), orders.ConfirmOrderRequest)) == openjson.toJson(obj)

  test "round-trips OrderRequest":
    let obj = newOrderRequest()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), orders.OrderRequest)) == openjson.toJson(obj)

  test "round-trips Order":
    let obj = newOrder()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), orders.Order)) == openjson.toJson(obj)

  test "round-trips OrderAuthorizeResponse":
    let obj = newOrderAuthorizeResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), orders.OrderAuthorizeResponse)) == openjson.toJson(obj)

  test "round-trips OrderTrackerRequest":
    let obj = newOrderTrackerRequest()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), orders.OrderTrackerRequest)) == openjson.toJson(obj)

  test "round-trips OrderAuthorizeRequest":
    let obj = newOrderAuthorizeRequest()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), orders.OrderAuthorizeRequest)) == openjson.toJson(obj)

  test "round-trips Error":
    let obj = newError()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), orders.Error)) == openjson.toJson(obj)

suite "orders endpoints":
  test "POST /v2/checkout/orders":
    let client = initOrdersClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV2CheckoutOrders(newOrderRequest())

  test "GET /v2/checkout/orders/{id}":
    let client = initOrdersClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getV2CheckoutOrdersId("test", "test")

  test "POST /v2/checkout/orders/{id}/confirm-payment-source":
    let client = initOrdersClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV2CheckoutOrdersIdConfirmPaymentSource("test", newConfirmOrderRequest())

  test "POST /v2/checkout/orders/{id}/authorize":
    let client = initOrdersClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV2CheckoutOrdersIdAuthorize("test", newOrderAuthorizeRequest())

  test "POST /v2/checkout/orders/{id}/capture":
    let client = initOrdersClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV2CheckoutOrdersIdCapture("test", newOrderCaptureRequest())

  test "POST /v2/checkout/orders/{id}/track":
    let client = initOrdersClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV2CheckoutOrdersIdTrack("test", newOrderTrackerRequest())

