# transaction API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Clue CLI Assistant https://github.com/openpeeps/clue
#
# Generated at: 2026-08-08T20:01:03+03:00
# License: MIT
import std/[asyncdispatch, options, json]
import unittest
import pkg/openparser/json as openjson
import paypal_reporting
import ./common

suite "balances serialization":
  test "round-trips Error403":
    let obj = newError403()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_reporting.Error403)) == openjson.toJson(obj)

  test "round-trips ErrorDefault":
    let obj = newErrorDefault()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_reporting.ErrorDefault)) == openjson.toJson(obj)

  test "round-trips Error500":
    let obj = newError500()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_reporting.Error500)) == openjson.toJson(obj)

  test "round-trips Error400":
    let obj = newError400()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_reporting.Error400)) == openjson.toJson(obj)

  test "round-trips BalancesResponse":
    let obj = newBalancesResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_reporting.BalancesResponse)) == openjson.toJson(obj)

suite "balances endpoints":
  test "GET /v1/reporting/balances":
    let client = initReportingClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getV1ReportingBalances("test", "test")

