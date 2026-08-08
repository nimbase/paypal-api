# disputes API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Clue CLI Assistant https://github.com/openpeeps/clue
#
# Generated at: 2026-08-08T20:42:34+03:00
# License: MIT
import std/[asyncdispatch, options, json]
import unittest
import pkg/openparser/json as openjson
import paypal_disputes
import ./common

suite "disputes_actions serialization":
  test "round-trips EscalateResponse":
    let obj = newEscalateResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_disputes.EscalateResponse)) == openjson.toJson(obj)

  test "round-trips Adjudicate":
    let obj = newAdjudicate()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_disputes.Adjudicate)) == openjson.toJson(obj)

  test "round-trips DenyOffer":
    let obj = newDenyOffer()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_disputes.DenyOffer)) == openjson.toJson(obj)

  test "round-trips SubsequentAction":
    let obj = newSubsequentAction()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_disputes.SubsequentAction)) == openjson.toJson(obj)

  test "round-trips AcceptOffer":
    let obj = newAcceptOffer()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_disputes.AcceptOffer)) == openjson.toJson(obj)

  test "round-trips Escalate":
    let obj = newEscalate()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_disputes.Escalate)) == openjson.toJson(obj)

  test "round-trips MakeOffer":
    let obj = newMakeOffer()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_disputes.MakeOffer)) == openjson.toJson(obj)

  test "round-trips RequireEvidence":
    let obj = newRequireEvidence()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_disputes.RequireEvidence)) == openjson.toJson(obj)

  test "round-trips Error":
    let obj = newError()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_disputes.Error)) == openjson.toJson(obj)

suite "disputes_actions endpoints":
  test "POST /v1/customer/disputes/{id}/provide-evidence":
    let client = initDisputesClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV1CustomerDisputesIdProvideEvidence("test")

  test "POST /v1/customer/disputes/{id}/appeal":
    let client = initDisputesClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV1CustomerDisputesIdAppeal("test")

  test "POST /v1/customer/disputes/{id}/accept-claim":
    let client = initDisputesClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV1CustomerDisputesIdAcceptClaim("test")

  test "POST /v1/customer/disputes/{id}/adjudicate":
    let client = initDisputesClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV1CustomerDisputesIdAdjudicate("test", newAdjudicate())

  test "POST /v1/customer/disputes/{id}/require-evidence":
    let client = initDisputesClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV1CustomerDisputesIdRequireEvidence("test", newRequireEvidence())

  test "POST /v1/customer/disputes/{id}/escalate":
    let client = initDisputesClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV1CustomerDisputesIdEscalate("test", newEscalate())

  test "POST /v1/customer/disputes/{id}/send-message":
    let client = initDisputesClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV1CustomerDisputesIdSendMessage("test")

  test "POST /v1/customer/disputes/{id}/make-offer":
    let client = initDisputesClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV1CustomerDisputesIdMakeOffer("test", newMakeOffer())

  test "POST /v1/customer/disputes/{id}/accept-offer":
    let client = initDisputesClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV1CustomerDisputesIdAcceptOffer("test", newAcceptOffer())

  test "POST /v1/customer/disputes/{id}/deny-offer":
    let client = initDisputesClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV1CustomerDisputesIdDenyOffer("test", newDenyOffer())

  test "POST /v1/customer/disputes/{id}/acknowledge-return-item":
    let client = initDisputesClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV1CustomerDisputesIdAcknowledgeReturnItem("test")

  test "POST /v1/customer/disputes/{id}/provide-supporting-info":
    let client = initDisputesClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV1CustomerDisputesIdProvideSupportingInfo("test")

