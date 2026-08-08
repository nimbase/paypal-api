# payment API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Clue CLI Assistant https://github.com/openpeeps/clue
#
# Generated at: 2026-08-08T20:42:35+03:00
# License: MIT
import std/[asyncdispatch, options, json]
import unittest
import pkg/openparser/json as openjson
import paypal_payment_tokens
import ./common

suite "payment_tokens serialization":
  test "round-trips PaymentTokenResponse":
    let obj = newPaymentTokenResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_payment_tokens.PaymentTokenResponse)) == openjson.toJson(obj)

  test "round-trips PaymentTokenRequest":
    let obj = newPaymentTokenRequest()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_payment_tokens.PaymentTokenRequest)) == openjson.toJson(obj)

  test "round-trips CustomerVaultPaymentTokensResponse":
    let obj = newCustomerVaultPaymentTokensResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_payment_tokens.CustomerVaultPaymentTokensResponse)) == openjson.toJson(obj)

  test "round-trips Error":
    let obj = newError()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_payment_tokens.Error)) == openjson.toJson(obj)

suite "payment_tokens endpoints":
  test "GET /v3/vault/payment-tokens":
    let client = initPaymentTokensClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getV3VaultPaymentTokens("test", 1, 1, true)

  test "POST /v3/vault/payment-tokens":
    let client = initPaymentTokensClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV3VaultPaymentTokens(newPaymentTokenRequest())

  test "GET /v3/vault/payment-tokens/{id}":
    let client = initPaymentTokensClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getV3VaultPaymentTokensId("test")

  test "DELETE /v3/vault/payment-tokens/{id}":
    let client = initPaymentTokensClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.deleteV3VaultPaymentTokensId("test")

