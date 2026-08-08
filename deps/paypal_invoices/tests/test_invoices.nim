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

suite "invoices serialization":
  test "round-trips InvoicesUpdate422":
    let obj = newInvoicesUpdate422()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.InvoicesUpdate422)) == openjson.toJson(obj)

  test "round-trips InvoicesRemind400":
    let obj = newInvoicesRemind400()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.InvoicesRemind400)) == openjson.toJson(obj)

  test "round-trips RefundDetail":
    let obj = newRefundDetail()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.RefundDetail)) == openjson.toJson(obj)

  test "round-trips InvoicesCancel400":
    let obj = newInvoicesCancel400()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.InvoicesCancel400)) == openjson.toJson(obj)

  test "round-trips Fetchtype":
    let obj = newFetchtype()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.Fetchtype)) == openjson.toJson(obj)

  test "round-trips Error422":
    let obj = newError422()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.Error422)) == openjson.toJson(obj)

  test "round-trips InvoicesPayments400":
    let obj = newInvoicesPayments400()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.InvoicesPayments400)) == openjson.toJson(obj)

  test "round-trips InvoicesGenerateQrCode400":
    let obj = newInvoicesGenerateQrCode400()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.InvoicesGenerateQrCode400)) == openjson.toJson(obj)

  test "round-trips Invoice":
    let obj = newInvoice()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.Invoice)) == openjson.toJson(obj)

  test "round-trips Error403":
    let obj = newError403()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.Error403)) == openjson.toJson(obj)

  test "round-trips InvoicesCreate400":
    let obj = newInvoicesCreate400()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.InvoicesCreate400)) == openjson.toJson(obj)

  test "round-trips InvoicesPayments422":
    let obj = newInvoicesPayments422()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.InvoicesPayments422)) == openjson.toJson(obj)

  test "round-trips Error404":
    let obj = newError404()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.Error404)) == openjson.toJson(obj)

  test "round-trips InvoicesCancel422":
    let obj = newInvoicesCancel422()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.InvoicesCancel422)) == openjson.toJson(obj)

  test "round-trips InvoiceNumber":
    let obj = newInvoiceNumber()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.InvoiceNumber)) == openjson.toJson(obj)

  test "round-trips Notification":
    let obj = newNotification()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.Notification)) == openjson.toJson(obj)

  test "round-trips Invoices":
    let obj = newInvoices()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.Invoices)) == openjson.toJson(obj)

  test "round-trips QrConfig":
    let obj = newQrConfig()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.QrConfig)) == openjson.toJson(obj)

  test "round-trips ErrorDefault":
    let obj = newErrorDefault()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.ErrorDefault)) == openjson.toJson(obj)

  test "round-trips Error500":
    let obj = newError500()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.Error500)) == openjson.toJson(obj)

  test "round-trips InvoicesRefunds400":
    let obj = newInvoicesRefunds400()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.InvoicesRefunds400)) == openjson.toJson(obj)

  test "round-trips PaymentDetail":
    let obj = newPaymentDetail()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.PaymentDetail)) == openjson.toJson(obj)

  test "round-trips 400":
    let obj = new400()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.Status400)) == openjson.toJson(obj)

  test "round-trips LinkDescription":
    let obj = newLinkDescription()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.LinkDescription)) == openjson.toJson(obj)

  test "round-trips InvoicesPaymentsDelete422":
    let obj = newInvoicesPaymentsDelete422()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.InvoicesPaymentsDelete422)) == openjson.toJson(obj)

  test "round-trips PaymentReference":
    let obj = newPaymentReference()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.PaymentReference)) == openjson.toJson(obj)

  test "round-trips 422":
    let obj = new422()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.Status422)) == openjson.toJson(obj)

  test "round-trips 403":
    let obj = new403()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.Status403)) == openjson.toJson(obj)

  test "round-trips InvoicesRefunds422":
    let obj = newInvoicesRefunds422()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.InvoicesRefunds422)) == openjson.toJson(obj)

  test "round-trips Error400":
    let obj = newError400()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.Error400)) == openjson.toJson(obj)

  test "round-trips InvoicesRemind422":
    let obj = newInvoicesRemind422()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.InvoicesRemind422)) == openjson.toJson(obj)

  test "round-trips InvoicesUpdate400":
    let obj = newInvoicesUpdate400()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.InvoicesUpdate400)) == openjson.toJson(obj)

  test "round-trips RefundReference":
    let obj = newRefundReference()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_invoices.RefundReference)) == openjson.toJson(obj)

suite "invoices endpoints":
  test "GET /v2/invoicing/invoices":
    let client = initInvoicesClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getV2InvoicingInvoices(1, 1, true, "test")

  test "POST /v2/invoicing/invoices":
    let client = initInvoicesClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV2InvoicingInvoices(newInvoice())

  test "POST /v2/invoicing/invoices/{invoice_id}/send":
    let client = initInvoicesClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV2InvoicingInvoicesInvoiceIdSend("test", newNotification())

  test "POST /v2/invoicing/invoices/{invoice_id}/remind":
    let client = initInvoicesClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV2InvoicingInvoicesInvoiceIdRemind("test", newNotification())

  test "POST /v2/invoicing/invoices/{invoice_id}/cancel":
    let client = initInvoicesClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV2InvoicingInvoicesInvoiceIdCancel("test", newNotification())

  test "POST /v2/invoicing/invoices/{invoice_id}/payments":
    let client = initInvoicesClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV2InvoicingInvoicesInvoiceIdPayments("test", newPaymentDetail())

  test "DELETE /v2/invoicing/invoices/{invoice_id}/payments/{transaction_id}":
    let client = initInvoicesClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.deleteV2InvoicingInvoicesInvoiceIdPaymentsTransactionId("test", "test")

  test "POST /v2/invoicing/invoices/{invoice_id}/refunds":
    let client = initInvoicesClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV2InvoicingInvoicesInvoiceIdRefunds("test", newRefundDetail())

  test "DELETE /v2/invoicing/invoices/{invoice_id}/refunds/{transaction_id}":
    let client = initInvoicesClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.deleteV2InvoicingInvoicesInvoiceIdRefundsTransactionId("test", "test")

  test "POST /v2/invoicing/invoices/{invoice_id}/generate-qr-code":
    let client = initInvoicesClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV2InvoicingInvoicesInvoiceIdGenerateQrCode("test", newQrConfig())

  test "POST /v2/invoicing/generate-next-invoice-number":
    let client = initInvoicesClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV2InvoicingGenerateNextInvoiceNumber(newFetchtype())

  test "GET /v2/invoicing/invoices/{invoice_id}":
    let client = initInvoicesClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getV2InvoicingInvoicesInvoiceId("test")

  test "PUT /v2/invoicing/invoices/{invoice_id}":
    let client = initInvoicesClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.putV2InvoicingInvoicesInvoiceId("test", true, true, newInvoice())

  test "DELETE /v2/invoicing/invoices/{invoice_id}":
    let client = initInvoicesClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.deleteV2InvoicingInvoicesInvoiceId("test")

