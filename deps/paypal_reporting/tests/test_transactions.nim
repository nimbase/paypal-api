# transaction API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Clue CLI Assistant https://github.com/openpeeps/clue
#
# Generated at: 2026-08-08T19:13:20+03:00
# License: MIT
import std/[asyncdispatch, options, json]
import unittest
import pkg/openparser/json as openjson
import paypal_reporting
import ./common

suite "transactions serialization":
  test "round-trips SearchResponse":
    let obj = newSearchResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_reporting.SearchResponse)) == openjson.toJson(obj)

  test "round-trips ErrorDefault":
    let obj = newErrorDefault()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_reporting.ErrorDefault)) == openjson.toJson(obj)

suite "transactions endpoints":
  test "GET /v1/reporting/transactions":
    let client = initReportingClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getV1ReportingTransactions("test", "test", "test", "test", "test", "test", "test", "test", "test", "test", "test", "test", 1, 1)

