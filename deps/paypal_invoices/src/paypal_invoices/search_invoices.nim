# invoices API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Clue CLI Assistant https://github.com/openpeeps/clue
#
# Generated at: 2026-08-08T20:01:03+03:00
# License: MIT
import std/[strformat, options, json]
import ./metaclient
import ./types


proc postV2InvoicingSearchInvoices*(client: InvoicesClient, page: int64 = 1,
                                    pageSize: int64 = 20,
                                    totalRequired: bool = false,
                                    body: types.SearchData): Future[types.Invoices] {.async.} =
  ## Searches for and lists invoices that match search criteria. If you pass multiple
  ## criteria, the response lists invoices that match all criteria.

  var q = initOrderedTable[string, string]()
  q["page"] = $page
  q["page_size"] = $pageSize
  q["total_required"] = $totalRequired
  let res = await client.httpPOST("/v2/invoicing/search-invoices", q)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.Invoices)
  else:
    raise newException(InvoicesClientError, body)
