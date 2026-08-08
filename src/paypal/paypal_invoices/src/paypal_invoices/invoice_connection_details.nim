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


proc getV2InvoicingAccountingSyncInvoicesIdConnections*(client: InvoicesClient,
                                                        id: string): Future[types.InvoiceConnectionDetails] {.async.} =
  ## Lists connections to accounting platforms per invoice.

  let res = await client.httpGET(fmt"/v2/invoicing/accounting-sync/invoices/{id}/connections")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.InvoiceConnectionDetails)
  else:
    raise newException(InvoicesClientError, body)
