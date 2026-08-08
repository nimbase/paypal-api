# invoices API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Clue CLI Assistant https://github.com/openpeeps/clue
#
# Generated at: 2026-08-08T18:16:13+03:00
# License: MIT
import std/[asyncdispatch, options, json]
import unittest
import pkg/openparser/json as openjson
import invoices
import ./common

suite "invoice_connection_details serialization":
  test "round-trips InvoiceConnectionDetails":
    let obj = newInvoiceConnectionDetails()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), invoices.InvoiceConnectionDetails)) == openjson.toJson(obj)

  test "round-trips Error403":
    let obj = newError403()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), invoices.Error403)) == openjson.toJson(obj)

  test "round-trips Error404":
    let obj = newError404()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), invoices.Error404)) == openjson.toJson(obj)

  test "round-trips ErrorDefault":
    let obj = newErrorDefault()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), invoices.ErrorDefault)) == openjson.toJson(obj)

  test "round-trips Error500":
    let obj = newError500()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), invoices.Error500)) == openjson.toJson(obj)

  test "round-trips Error400":
    let obj = newError400()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), invoices.Error400)) == openjson.toJson(obj)

suite "invoice_connection_details endpoints":
  test "GET /v2/invoicing/accounting-sync/invoices/{id}/connections":
    let client = initInvoicesClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getV2InvoicingAccountingSyncInvoicesIdConnections("test")

