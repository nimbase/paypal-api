# payments API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Clue CLI Assistant https://github.com/openpeeps/clue
#
# Generated at: 2026-08-08T18:16:14+03:00
# License: MIT
import std/[asyncdispatch, options, json]
import unittest
import pkg/openparser/json as openjson
import payments
import ./common

suite "authorizations serialization":
  test "round-trips ReauthorizeRequest":
    let obj = newReauthorizeRequest()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), payments.ReauthorizeRequest)) == openjson.toJson(obj)

  test "round-trips Capture2":
    let obj = newCapture2()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), payments.Capture2)) == openjson.toJson(obj)

  test "round-trips CaptureRequest":
    let obj = newCaptureRequest()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), payments.CaptureRequest)) == openjson.toJson(obj)

  test "round-trips Authorization2":
    let obj = newAuthorization2()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), payments.Authorization2)) == openjson.toJson(obj)

  test "round-trips Error":
    let obj = newError()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), payments.Error)) == openjson.toJson(obj)

suite "authorizations endpoints":
  test "GET /v2/payments/authorizations/{authorization_id}":
    let client = initPaymentsClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getV2PaymentsAuthorizationsAuthorizationId("test")

  test "POST /v2/payments/authorizations/{authorization_id}/capture":
    let client = initPaymentsClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV2PaymentsAuthorizationsAuthorizationIdCapture("test", newCaptureRequest())

  test "POST /v2/payments/authorizations/{authorization_id}/reauthorize":
    let client = initPaymentsClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV2PaymentsAuthorizationsAuthorizationIdReauthorize("test", newReauthorizeRequest())

  test "POST /v2/payments/authorizations/{authorization_id}/void":
    let client = initPaymentsClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV2PaymentsAuthorizationsAuthorizationIdVoid("test")

