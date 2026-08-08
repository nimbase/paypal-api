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

suite "webhooks serialization":
  test "round-trips WebhookList":
    let obj = newWebhookList()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_webhooks.WebhookList)) == openjson.toJson(obj)

  test "round-trips Webhook":
    let obj = newWebhook()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_webhooks.Webhook)) == openjson.toJson(obj)

  test "round-trips Error2":
    let obj = newError2()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_webhooks.Error2)) == openjson.toJson(obj)

  test "round-trips EventTypeList":
    let obj = newEventTypeList()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_webhooks.EventTypeList)) == openjson.toJson(obj)

suite "webhooks endpoints":
  test "GET /v1/notifications/webhooks":
    let client = initWebhooksClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getV1NotificationsWebhooks()

  test "POST /v1/notifications/webhooks":
    let client = initWebhooksClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV1NotificationsWebhooks(newWebhook())

  test "GET /v1/notifications/webhooks/{webhook_id}":
    let client = initWebhooksClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getV1NotificationsWebhooksWebhookId("test")

  test "DELETE /v1/notifications/webhooks/{webhook_id}":
    let client = initWebhooksClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.deleteV1NotificationsWebhooksWebhookId("test")

  test "GET /v1/notifications/webhooks/{webhook_id}/event-types":
    let client = initWebhooksClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getV1NotificationsWebhooksWebhookIdEventTypes("test")

