# webhooks API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Clue CLI Assistant https://github.com/openpeeps/clue
#
# Generated at: 2026-08-08T20:42:35+03:00
# License: MIT
import std/[asyncdispatch, options, json]
import unittest
import pkg/openparser/json as openjson
import paypal_webhooks
import ./common

suite "webhooks_lookup serialization":
  test "round-trips WebhookLookupList":
    let obj = newWebhookLookupList()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_webhooks.WebhookLookupList)) == openjson.toJson(obj)

  test "round-trips WebhooksLookup":
    let obj = newWebhooksLookup()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_webhooks.WebhooksLookup)) == openjson.toJson(obj)

  test "round-trips Error2":
    let obj = newError2()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_webhooks.Error2)) == openjson.toJson(obj)

suite "webhooks_lookup endpoints":
  test "GET /v1/notifications/webhooks-lookup":
    let client = initWebhooksClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getV1NotificationsWebhooksLookup()

  test "POST /v1/notifications/webhooks-lookup":
    let client = initWebhooksClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV1NotificationsWebhooksLookup()

  test "GET /v1/notifications/webhooks-lookup/{webhook_lookup_id}":
    let client = initWebhooksClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getV1NotificationsWebhooksLookupWebhookLookupId("test")

  test "DELETE /v1/notifications/webhooks-lookup/{webhook_lookup_id}":
    let client = initWebhooksClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.deleteV1NotificationsWebhooksLookupWebhookLookupId("test")

