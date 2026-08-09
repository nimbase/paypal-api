# paypal_payouts API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Nimbase CLI https://github.com/nimbase/nimbase
#
# Generated at: 2026-08-09T17:24:06+03:00
# License: MIT
import std/[asyncdispatch]
import unittest
import pkg/openparser/json as openjson
import paypal_payouts
import ./common

suite "payouts serialization":
  test "round-trips Payout":
    let obj = newPayout()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_payouts.Payout)) == openjson.toJson(obj)

  test "round-trips PayoutBatch":
    let obj = newPayoutBatch()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_payouts.PayoutBatch)) == openjson.toJson(obj)

  test "round-trips CreatePayoutRequest":
    let obj = newCreatePayoutRequest()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_payouts.CreatePayoutRequest)) == openjson.toJson(obj)

  test "round-trips Error":
    let obj = newError()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_payouts.Error)) == openjson.toJson(obj)

suite "payouts endpoints":
  test "POST /v1/payments/payouts":
    let client = initPayoutsClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV1PaymentsPayouts(newCreatePayoutRequest())

  test "GET /v1/payments/payouts/{id}":
    let client = initPayoutsClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getV1PaymentsPayoutsId("test", "test", 1, 1, true)

