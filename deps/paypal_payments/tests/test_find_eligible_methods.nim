# payments API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Clue CLI Assistant https://github.com/openpeeps/clue
#
# Generated at: 2026-08-08T20:01:03+03:00
# License: MIT
import std/[asyncdispatch, options, json]
import unittest
import pkg/openparser/json as openjson
import paypal_payments
import ./common

suite "find_eligible_methods serialization":
  test "round-trips FindEligibleMethodsRequest":
    let obj = newFindEligibleMethodsRequest()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_payments.FindEligibleMethodsRequest)) == openjson.toJson(obj)

  test "round-trips FindEligibleMethodsResponse":
    let obj = newFindEligibleMethodsResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_payments.FindEligibleMethodsResponse)) == openjson.toJson(obj)

  test "round-trips Error":
    let obj = newError()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_payments.Error)) == openjson.toJson(obj)

suite "find_eligible_methods endpoints":
  test "POST /v2/payments/find-eligible-methods":
    let client = initPaymentsClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV2PaymentsFindEligibleMethods(newFindEligibleMethodsRequest())

