# invoices API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Clue CLI Assistant https://github.com/openpeeps/clue
#
# Generated at: 2026-08-08T18:16:13+03:00
# License: MIT
import std/[strformat, options, json]
import ./metaclient
import ./types


proc getV2InvoicingAccountingSyncMerchantConnections*(client: InvoicesClient): Future[types.Connections] {.async.} =
  ## Lists connections to accounting platforms per merchant.

  let res = await client.httpGET("/v2/invoicing/accounting-sync/merchant/connections")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.Connections)
  else:
    raise newException(InvoicesClientError, body)
