# paypal_webhooks API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Nimbase CLI https://github.com/nimbase/nimbase
#
# Generated at: 2026-08-08T23:06:08+03:00
# License: MIT
import std/[asyncdispatch, options, json]
import unittest
import pkg/openparser/json as openjson
import paypal_webhooks
import ./common

suite "simulate_event serialization":
  test "round-trips Event":
    let obj = newEvent()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_webhooks.Event)) == openjson.toJson(obj)

  test "round-trips SimulateEvent":
    let obj = newSimulateEvent()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_webhooks.SimulateEvent)) == openjson.toJson(obj)

  test "round-trips Error2":
    let obj = newError2()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_webhooks.Error2)) == openjson.toJson(obj)

suite "simulate_event endpoints":
  test "POST /v1/notifications/simulate-event":
    let client = initWebhooksClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV1NotificationsSimulateEvent(newSimulateEvent())

