# webhooks API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Clue CLI Assistant https://github.com/openpeeps/clue
#
# Generated at: 2026-08-08T18:16:14+03:00
# License: MIT
import std/[asyncdispatch, options, json]
import unittest
import pkg/openparser/json as openjson
import webhooks
import ./common

suite "simulate_event serialization":
  test "round-trips Event":
    let obj = newEvent()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), webhooks.Event)) == openjson.toJson(obj)

  test "round-trips SimulateEvent":
    let obj = newSimulateEvent()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), webhooks.SimulateEvent)) == openjson.toJson(obj)

  test "round-trips Error2":
    let obj = newError2()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), webhooks.Error2)) == openjson.toJson(obj)

suite "simulate_event endpoints":
  test "POST /v1/notifications/simulate-event":
    let client = initWebhooksClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV1NotificationsSimulateEvent(newSimulateEvent())

