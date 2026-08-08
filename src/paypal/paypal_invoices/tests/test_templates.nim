# paypal_invoices API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Nimbase CLI https://github.com/nimbase/nimbase
#
# Generated at: 2026-08-08T22:36:56+03:00
# License: MIT
import std/[asyncdispatch, options, json]
import unittest
import pkg/openparser/json as openjson
import paypal_invoices
import ./common

suite "templates serialization":
  test "round-trips Template":
    let obj = newTemplate()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.Template)) == openjson.toJson(obj)

  test "round-trips Error422":
    let obj = newError422()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.Error422)) == openjson.toJson(obj)

  test "round-trips TemplatesCreate422":
    let obj = newTemplatesCreate422()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.TemplatesCreate422)) == openjson.toJson(obj)

  test "round-trips Error403":
    let obj = newError403()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.Error403)) == openjson.toJson(obj)

  test "round-trips Error404":
    let obj = newError404()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.Error404)) == openjson.toJson(obj)

  test "round-trips TemplatesCreate400":
    let obj = newTemplatesCreate400()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.TemplatesCreate400)) == openjson.toJson(obj)

  test "round-trips TemplatesGet403":
    let obj = newTemplatesGet403()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.TemplatesGet403)) == openjson.toJson(obj)

  test "round-trips Templates":
    let obj = newTemplates()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.Templates)) == openjson.toJson(obj)

  test "round-trips TemplatesUpdate400":
    let obj = newTemplatesUpdate400()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.TemplatesUpdate400)) == openjson.toJson(obj)

  test "round-trips ErrorDefault":
    let obj = newErrorDefault()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.ErrorDefault)) == openjson.toJson(obj)

  test "round-trips Error500":
    let obj = newError500()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.Error500)) == openjson.toJson(obj)

  test "round-trips 400":
    let obj = new400()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.Status400)) == openjson.toJson(obj)

  test "round-trips 403":
    let obj = new403()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.Status403)) == openjson.toJson(obj)

  test "round-trips Error400":
    let obj = newError400()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.Error400)) == openjson.toJson(obj)

  test "round-trips TemplatesDelete403":
    let obj = newTemplatesDelete403()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.TemplatesDelete403)) == openjson.toJson(obj)

suite "templates endpoints":
  test "GET /v2/invoicing/templates":
    let client = initInvoicesClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getV2InvoicingTemplates("test", 1, 1)

  test "POST /v2/invoicing/templates":
    let client = initInvoicesClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV2InvoicingTemplates(newTemplate())

  test "GET /v2/invoicing/templates/{template_id}":
    let client = initInvoicesClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getV2InvoicingTemplatesTemplateId("test")

  test "PUT /v2/invoicing/templates/{template_id}":
    let client = initInvoicesClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.putV2InvoicingTemplatesTemplateId("test", newTemplate())

  test "DELETE /v2/invoicing/templates/{template_id}":
    let client = initInvoicesClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.deleteV2InvoicingTemplatesTemplateId("test")

