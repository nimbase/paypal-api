# orders API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Clue CLI Assistant https://github.com/openpeeps/clue
#
# Generated at: 2026-08-08T20:01:02+03:00
# License: MIT
import std/[asyncdispatch, options, json]
import unittest
import pkg/openparser/json as openjson
import paypal_orders
import ./common

suite "trackers serialization":
  test "round-trips Error":
    let obj = newError()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_orders.Error)) == openjson.toJson(obj)

suite "trackers endpoints":
  test "module has no sampleable endpoints":
    check true

