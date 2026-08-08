# paypal_webhooks API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Clue CLI Assistant https://github.com/openpeeps/clue
#
# Generated at: 2026-08-08T21:40:16+03:00
# License: MIT
import std/[asyncdispatch, options, json]
import unittest
import pkg/openparser/json as openjson
import paypal_webhooks
import ./common

suite "verify_webhook_signature serialization":
  test "round-trips VerifyWebhookSignatureResponse":
    let obj = newVerifyWebhookSignatureResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_webhooks.VerifyWebhookSignatureResponse)) == openjson.toJson(obj)

  test "round-trips VerifyWebhookSignature":
    let obj = newVerifyWebhookSignature()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_webhooks.VerifyWebhookSignature)) == openjson.toJson(obj)

  test "round-trips Error2":
    let obj = newError2()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_webhooks.Error2)) == openjson.toJson(obj)

suite "verify_webhook_signature endpoints":
  test "POST /v1/notifications/verify-webhook-signature":
    let client = initWebhooksClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV1NotificationsVerifyWebhookSignature(newVerifyWebhookSignature())

