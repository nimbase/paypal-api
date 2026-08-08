# payment API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Clue CLI Assistant https://github.com/openpeeps/clue
#
# Generated at: 2026-08-08T20:01:03+03:00
# License: MIT
import std/[asyncdispatch, options, json]
import unittest
import pkg/openparser/json as openjson
import paypal_payment_experience
import ./common

suite "web_profiles serialization":
  test "round-trips WebProfile":
    let obj = newWebProfile()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_payment_experience.WebProfile)) == openjson.toJson(obj)

  test "round-trips Error":
    let obj = newError()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_payment_experience.Error)) == openjson.toJson(obj)

suite "web_profiles endpoints":
  test "GET /v1/payment-experience/web-profiles":
    let client = initPaymentExperienceClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getV1PaymentExperienceWebProfiles()

  test "POST /v1/payment-experience/web-profiles":
    let client = initPaymentExperienceClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV1PaymentExperienceWebProfiles(newWebProfile())

  test "GET /v1/payment-experience/web-profiles/{id}":
    let client = initPaymentExperienceClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getV1PaymentExperienceWebProfilesId("test")

  test "PUT /v1/payment-experience/web-profiles/{id}":
    let client = initPaymentExperienceClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.putV1PaymentExperienceWebProfilesId("test", newWebProfile())

  test "DELETE /v1/payment-experience/web-profiles/{id}":
    let client = initPaymentExperienceClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.deleteV1PaymentExperienceWebProfilesId("test")

