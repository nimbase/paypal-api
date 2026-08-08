# invoices API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Clue CLI Assistant https://github.com/openpeeps/clue
#
# Generated at: 2026-08-08T20:01:03+03:00
# License: MIT
import std/[asyncdispatch, options, json]
import unittest
import pkg/openparser/json as openjson
import paypal_invoices
import ./common

suite "search_invoices serialization":
  test "round-trips Error403":
    let obj = newError403()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.Error403)) == openjson.toJson(obj)

  test "round-trips SearchData":
    let obj = newSearchData()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.SearchData)) == openjson.toJson(obj)

  test "round-trips InvoicesSearchInvoices400":
    let obj = newInvoicesSearchInvoices400()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.InvoicesSearchInvoices400)) == openjson.toJson(obj)

  test "round-trips Invoices":
    let obj = newInvoices()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.Invoices)) == openjson.toJson(obj)

  test "round-trips ErrorDefault":
    let obj = newErrorDefault()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.ErrorDefault)) == openjson.toJson(obj)

  test "round-trips Error500":
    let obj = newError500()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.Error500)) == openjson.toJson(obj)

  test "round-trips Error400":
    let obj = newError400()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.Error400)) == openjson.toJson(obj)

suite "search_invoices endpoints":
  test "POST /v2/invoicing/search-invoices":
    let client = initInvoicesClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV2InvoicingSearchInvoices(1, 1, true, newSearchData())

