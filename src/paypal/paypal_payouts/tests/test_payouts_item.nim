# paypal_payouts API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Clue CLI Assistant https://github.com/openpeeps/clue
#
# Generated at: 2026-08-08T21:40:16+03:00
# License: MIT
import std/[asyncdispatch, options, json]
import unittest
import pkg/openparser/json as openjson
import paypal_payouts
import ./common

suite "payouts_item serialization":
  test "round-trips PayoutItem":
    let obj = newPayoutItem()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_payouts.PayoutItem)) == openjson.toJson(obj)

  test "round-trips Error":
    let obj = newError()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_payouts.Error)) == openjson.toJson(obj)

suite "payouts_item endpoints":
  test "GET /v1/payments/payouts-item/{payout_item_id}":
    let client = initPayoutsClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getV1PaymentsPayoutsItemPayoutItemId("test")

  test "POST /v1/payments/payouts-item/{payout_item_id}/cancel":
    let client = initPayoutsClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV1PaymentsPayoutsItemPayoutItemIdCancel("test")

