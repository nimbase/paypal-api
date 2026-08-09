# paypal_webhooks API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Nimbase CLI https://github.com/nimbase/nimbase
#
# Generated at: 2026-08-09T17:24:06+03:00
# License: MIT
import std/[asyncdispatch]
import unittest
import pkg/openparser/json as openjson
import paypal_webhooks
import ./common

suite "webhooks_event_types serialization":
  test "round-trips Error2":
    let obj = newError2()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_webhooks.Error2)) == openjson.toJson(obj)

  test "round-trips EventTypeList":
    let obj = newEventTypeList()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_webhooks.EventTypeList)) == openjson.toJson(obj)

suite "webhooks_event_types endpoints":
  test "GET /v1/notifications/webhooks-event-types":
    let client = initWebhooksClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getV1NotificationsWebhooksEventTypes()

