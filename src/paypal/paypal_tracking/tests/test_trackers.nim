# paypal_tracking API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Clue CLI Assistant https://github.com/openpeeps/clue
#
# Generated at: 2026-08-08T21:40:17+03:00
# License: MIT
import std/[asyncdispatch, options, json]
import unittest
import pkg/openparser/json as openjson
import paypal_tracking
import ./common

suite "trackers serialization":
  test "round-trips TrackerCollection":
    let obj = newTrackerCollection()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_tracking.TrackerCollection)) == openjson.toJson(obj)

  test "round-trips Tracker":
    let obj = newTracker()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_tracking.Tracker)) == openjson.toJson(obj)

  test "round-trips TrackerIdentifierCollection":
    let obj = newTrackerIdentifierCollection()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_tracking.TrackerIdentifierCollection)) == openjson.toJson(obj)

  test "round-trips Error":
    let obj = newError()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_tracking.Error)) == openjson.toJson(obj)

suite "trackers endpoints":
  test "GET /v1/shipping/trackers":
    let client = initTrackingClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getV1ShippingTrackers("test", "test", "test")

  test "POST /v1/shipping/trackers":
    let client = initTrackingClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV1ShippingTrackers(newTrackerCollection())

  test "GET /v1/shipping/trackers/{id}":
    let client = initTrackingClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getV1ShippingTrackersId("test", "test")

  test "PUT /v1/shipping/trackers/{id}":
    let client = initTrackingClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.putV1ShippingTrackersId("test", newTracker())

