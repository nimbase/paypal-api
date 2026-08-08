# paypal_disputes API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Clue CLI Assistant https://github.com/openpeeps/clue
#
# Generated at: 2026-08-08T21:40:16+03:00
# License: MIT
import std/[asyncdispatch, options, json]
import unittest
import pkg/openparser/json as openjson
import paypal_disputes
import ./common

suite "disputes serialization":
  test "round-trips Dispute":
    let obj = newDispute()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_disputes.Dispute)) == openjson.toJson(obj)

  test "round-trips SubsequentAction":
    let obj = newSubsequentAction()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_disputes.SubsequentAction)) == openjson.toJson(obj)

  test "round-trips DisputeSearch":
    let obj = newDisputeSearch()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_disputes.DisputeSearch)) == openjson.toJson(obj)

  test "round-trips Error":
    let obj = newError()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_disputes.Error)) == openjson.toJson(obj)

suite "disputes endpoints":
  test "GET /v1/customer/disputes":
    let client = initDisputesClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getV1CustomerDisputes("test", "test", 1, "test", "test", "test", "test")

  test "GET /v1/customer/disputes/{id}":
    let client = initDisputesClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getV1CustomerDisputesId("test")

