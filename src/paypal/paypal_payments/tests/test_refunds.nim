# paypal_payments API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Clue CLI Assistant https://github.com/openpeeps/clue
#
# Generated at: 2026-08-08T21:40:16+03:00
# License: MIT
import std/[asyncdispatch, options, json]
import unittest
import pkg/openparser/json as openjson
import paypal_payments
import ./common

suite "refunds serialization":
  test "round-trips Refund":
    let obj = newRefund()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_payments.Refund)) == openjson.toJson(obj)

  test "round-trips Error":
    let obj = newError()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_payments.Error)) == openjson.toJson(obj)

suite "refunds endpoints":
  test "GET /v2/payments/refunds/{refund_id}":
    let client = initPaymentsClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getV2PaymentsRefundsRefundId("test")

