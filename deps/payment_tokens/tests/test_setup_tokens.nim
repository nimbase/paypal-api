# payment API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Clue CLI Assistant https://github.com/openpeeps/clue
#
# Generated at: 2026-08-08T18:16:14+03:00
# License: MIT
import std/[asyncdispatch, options, json]
import unittest
import pkg/openparser/json as openjson
import payment_tokens
import ./common

suite "setup_tokens serialization":
  test "round-trips SetupTokenResponse":
    let obj = newSetupTokenResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), payment_tokens.SetupTokenResponse)) == openjson.toJson(obj)

  test "round-trips SetupTokenRequest":
    let obj = newSetupTokenRequest()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), payment_tokens.SetupTokenRequest)) == openjson.toJson(obj)

  test "round-trips Error":
    let obj = newError()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), payment_tokens.Error)) == openjson.toJson(obj)

suite "setup_tokens endpoints":
  test "POST /v3/vault/setup-tokens":
    let client = initPaymentTokensClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV3VaultSetupTokens(newSetupTokenRequest())

  test "GET /v3/vault/setup-tokens/{id}":
    let client = initPaymentTokensClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getV3VaultSetupTokensId("test")

