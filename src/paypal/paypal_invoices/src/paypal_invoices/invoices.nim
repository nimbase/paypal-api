# paypal_invoices API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Clue CLI Assistant https://github.com/openpeeps/clue
#
# Generated at: 2026-08-08T21:40:16+03:00
# License: MIT
import std/[strformat, options, json]
import ./metaclient
import ./types


proc getV2InvoicingInvoices*(client: InvoicesClient, page: int64 = 1,
                             pageSize: int64 = 20, totalRequired: bool = false,
                             fields: string = "all"): Future[types.Invoices] {.async.} =
  ## Lists invoices. To filter the invoices that appear in the response, you can
  ## specify one or more optional query parameters.

  var q = initOrderedTable[string, string]()
  q["page"] = $page
  q["page_size"] = $pageSize
  q["total_required"] = $totalRequired
  q["fields"] = $fields
  let res = await client.httpGET("/v2/invoicing/invoices", q)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.Invoices)
  else:
    raise newException(InvoicesClientError, body)

proc postV2InvoicingInvoices*(client: InvoicesClient, body: types.Invoice): Future[types.Invoice] {.async.} =
  ## Creates a draft invoice. To move the invoice from a draft to payable state, you
  ## must <a href="#invoices_send">send the invoice</a>.<br/><br/>In the JSON request
  ## body, include invoice details including merchant information. The
  ## <code>invoice</code> object must include an <code>items</code>
  ## array.<blockquote><strong>Note:</strong> The merchant that you specify in an
  ## invoice must have a PayPal account in good standing.</blockquote>.

  let res = await client.httpPOST("/v2/invoicing/invoices", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, types.Invoice)
  else:
    raise newException(InvoicesClientError, body)

proc postV2InvoicingInvoicesInvoiceIdSend*(client: InvoicesClient,
                                           invoiceId: string,
                                           body: types.Notification): Future[types.LinkDescription] {.async.} =
  ## Sends or schedules an invoice, by ID, to be sent to a customer. The action
  ## depends on the invoice issue date:<ul><li>If the invoice issue date is current
  ## or in the past, sends the invoice immediately.</li><li>If the invoice issue date
  ## is in the future, schedules the invoice to be sent on that date.</li></ul>To
  ## suppress the merchant's email notification, set the `send_to_invoicer` body
  ## parameter to `false`. To send the invoice through a share link and not through
  ## PayPal, set the <code>send_to_recipient</code> parameter to <code>false</code>
  ## in the <code>notification</code> object. The <code>send_to_recipient</code>
  ## parameter does not apply to a future issue date because the invoice is scheduled
  ## to be sent through PayPal on that
  ## date.<blockquote><strong>Notes:</strong><ul><li>After you send an invoice,
  ## resending it has no effect.</li><li>To send a notification for updates, <a
  ## href="#invoices_update">update the invoice</a> and set the
  ## <code>send_to_recipient</code> body parameter to
  ## <code>true</code>.</li></ul></blockquote>

  let res = await client.httpPOST(fmt"/v2/invoicing/invoices/{invoiceId}/send", body)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.LinkDescription)
  else:
    raise newException(InvoicesClientError, body)

proc postV2InvoicingInvoicesInvoiceIdRemind*(client: InvoicesClient,
                                             invoiceId: string,
                                             body: types.Notification): Future[AsyncResponse] {.async.} =
  ## Sends a reminder to the payer about an invoice, by ID. In the JSON request body,
  ## include a `notification` object that defines the subject of the reminder and
  ## other details. <blockquote><strong>Notes:</strong><ul><li>API caller can send
  ## only 2 reminders in a day.</li></ul></blockquote>.

  let res = await client.httpPOST(fmt"/v2/invoicing/invoices/{invoiceId}/remind", body)
  return res

proc postV2InvoicingInvoicesInvoiceIdCancel*(client: InvoicesClient,
                                             invoiceId: string,
                                             body: types.Notification): Future[AsyncResponse] {.async.} =
  ## Cancels a sent invoice, by ID, and, optionally, sends a notification about the
  ## cancellation to the payer, merchant, and CC: emails.

  let res = await client.httpPOST(fmt"/v2/invoicing/invoices/{invoiceId}/cancel", body)
  return res

proc postV2InvoicingInvoicesInvoiceIdPayments*(client: InvoicesClient,
                                               invoiceId: string,
                                               body: types.PaymentDetail): Future[types.PaymentReference] {.async.} =
  ## Records a payment for the invoice. If no payment is due, the invoice is marked
  ## as `PAID`. Otherwise, the invoice is marked as `PARTIALLY PAID`.

  let res = await client.httpPOST(fmt"/v2/invoicing/invoices/{invoiceId}/payments", body)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.PaymentReference)
  else:
    raise newException(InvoicesClientError, body)

proc deleteV2InvoicingInvoicesInvoiceIdPaymentsTransactionId*(client: InvoicesClient,
                                                              invoiceId: string,
                                                              transactionId: string): Future[AsyncResponse] {.async.} =
  ## Deletes an external payment, by invoice ID and transaction ID.

  let res = await client.httpDELETE(fmt"/v2/invoicing/invoices/{invoiceId}/payments/{transactionId}")
  return res

proc postV2InvoicingInvoicesInvoiceIdRefunds*(client: InvoicesClient,
                                              invoiceId: string,
                                              body: types.RefundDetail): Future[types.RefundReference] {.async.} =
  ## Records a refund for the invoice. If all payments are refunded, the invoice is
  ## marked as `REFUNDED`. Otherwise, the invoice is marked as `PARTIALLY REFUNDED`.

  let res = await client.httpPOST(fmt"/v2/invoicing/invoices/{invoiceId}/refunds", body)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.RefundReference)
  else:
    raise newException(InvoicesClientError, body)

proc deleteV2InvoicingInvoicesInvoiceIdRefundsTransactionId*(client: InvoicesClient,
                                                             invoiceId: string,
                                                             transactionId: string): Future[AsyncResponse] {.async.} =
  ## Deletes an external refund, by invoice ID and transaction ID.

  let res = await client.httpDELETE(fmt"/v2/invoicing/invoices/{invoiceId}/refunds/{transactionId}")
  return res

proc postV2InvoicingInvoicesInvoiceIdGenerateQrCode*(client: InvoicesClient,
                                                     invoiceId: string,
                                                     body: types.QrConfig): Future[AsyncResponse] {.async.} =
  ## Generates a QR code for an invoice, by ID. The QR code is a PNG image in <a
  ## href="https://www.base64encode.org/">Base64-encoded</a> format that corresponds
  ## to the invoice ID. You can generate a QR code for an invoice and add it to a
  ## paper or PDF invoice. When customers use their mobile devices to scan the QR
  ## code, they are redirected to the PayPal mobile payment flow where they can view
  ## the invoice and pay online with PayPal or a credit card. Before you get a QR
  ## code, you must <a href="#invoices_create">create an invoice</a> and <a
  ## href="#invoices_send">send an invoice</a> to move the invoice from a draft to
  ## payable state. Do not include an email address if you do not want the invoice
  ## emailed.

  let res = await client.httpPOST(fmt"/v2/invoicing/invoices/{invoiceId}/generate-qr-code", body)
  return res

proc postV2InvoicingGenerateNextInvoiceNumber*(client: InvoicesClient,
                                               body: types.Fetchtype): Future[types.InvoiceNumber] {.async.} =
  ## Generates the next invoice number that is available to the merchant. The next
  ## invoice number uses the prefix and suffix from the last invoice number and
  ## increments the number by one. For example, the next invoice number after
  ## `INVOICE-1234` is `INVOICE-1235`.

  let res = await client.httpPOST("/v2/invoicing/generate-next-invoice-number", body)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.InvoiceNumber)
  else:
    raise newException(InvoicesClientError, body)

proc getV2InvoicingInvoicesInvoiceId*(client: InvoicesClient,
                                      invoiceId: string): Future[types.Invoice] {.async.} =
  ## Shows details for an invoice, by ID.

  let res = await client.httpGET(fmt"/v2/invoicing/invoices/{invoiceId}")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.Invoice)
  else:
    raise newException(InvoicesClientError, body)

proc putV2InvoicingInvoicesInvoiceId*(client: InvoicesClient,
                                      invoiceId: string,
                                      sendToRecipient: bool = true,
                                      sendToInvoicer: bool = true,
                                      body: types.Invoice): Future[types.Invoice] {.async.} =
  ## Fully updates an invoice, by ID. In the JSON request body, include a complete
  ## `invoice` object. This call does not support partial updates.
  ## <blockquote><strong>Notes:</strong><ul><li>API caller can change/modify
  ## recipient only 2 times in 72 hours.</li></ul></blockquote>.

  var q = initOrderedTable[string, string]()
  q["send_to_recipient"] = $sendToRecipient
  q["send_to_invoicer"] = $sendToInvoicer
  let res = await client.httpPUT(fmt"/v2/invoicing/invoices/{invoiceId}", q)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.Invoice)
  else:
    raise newException(InvoicesClientError, body)

proc deleteV2InvoicingInvoicesInvoiceId*(client: InvoicesClient,
                                         invoiceId: string): Future[AsyncResponse] {.async.} =
  ## Deletes a draft or scheduled invoice, by ID. Deletes invoices in the draft or
  ## scheduled state only. For invoices that have already been sent, you can <a
  ## href="/docs/api/invoicing/v2/#invoices_cancel">cancel the invoice</a>. After you
  ## delete a draft or scheduled invoice, you can no longer use it or show its
  ## details. However, you can reuse its invoice number.

  let res = await client.httpDELETE(fmt"/v2/invoicing/invoices/{invoiceId}")
  return res
