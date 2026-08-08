# paypal_tracking API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Nimbase CLI https://github.com/nimbase/nimbase
#
# Generated at: 2026-08-08T23:21:34+03:00
# License: MIT
import std/[asyncdispatch, options, json]
import unittest
import pkg/openparser/json as openjson
import paypal_tracking
import ./common

suite "trackers_batch serialization":
  test "round-trips TrackerCollection":
    let obj = newTrackerCollection()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_tracking.TrackerCollection)) == openjson.toJson(obj)

  test "round-trips BatchTrackerCollection":
    let obj = newBatchTrackerCollection()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_tracking.BatchTrackerCollection)) == openjson.toJson(obj)

  test "round-trips Error":
    let obj = newError()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_tracking.Error)) == openjson.toJson(obj)

suite "trackers_batch endpoints":
  test "POST /v1/shipping/trackers-batch":
    let client = initTrackingClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV1ShippingTrackersBatch(newTrackerCollection())

