# paypal_reporting API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Nimbase CLI https://github.com/nimbase/nimbase
#
# Generated at: 2026-08-08T23:21:33+03:00
# License: MIT
import std/[strformat, options, json]
import ./private/metaclient
import ./private/types


proc getV1ReportingTransactions*(client: ReportingClient,
                                 transactionId: string = default(string),
                                 transactionType: string = default(string),
                                 transactionStatus: string = default(string),
                                 transactionAmount: string = default(string),
                                 transactionCurrency: string = default(string),
                                 startDate: string, endDate: string,
                                 paymentInstrumentType: string = default(string),
                                 storeId: string = default(string),
                                 terminalId: string = default(string),
                                 fields: string = "transaction_info",
                                 balanceAffectingRecordsOnly: string = "Y",
                                 pageSize: int64 = 100, page: int64 = 1): Future[types.SearchResponse] {.async.} =
  ## Lists transactions. Specify one or more query parameters to filter the
  ## transaction that appear in the response.<blockquote><strong>Notes:</strong>
  ## <ul><li>If you specify one or more optional query parameters, the
  ## <code>ending_balance</code> response field is empty.</li><li>It takes a maximum
  ## of three hours for executed transactions to appear in the list transactions
  ## call.</li><li>This call lists transaction for the previous three
  ## years.</li></ul></blockquote>

  var q = initOrderedTable[string, string]()
  q["transaction_id"] = $transactionId
  q["transaction_type"] = $transactionType
  q["transaction_status"] = $transactionStatus
  q["transaction_amount"] = $transactionAmount
  q["transaction_currency"] = $transactionCurrency
  q["start_date"] = $startDate
  q["end_date"] = $endDate
  q["payment_instrument_type"] = $paymentInstrumentType
  q["store_id"] = $storeId
  q["terminal_id"] = $terminalId
  q["fields"] = $fields
  q["balance_affecting_records_only"] = $balanceAffectingRecordsOnly
  q["page_size"] = $pageSize
  q["page"] = $page
  let res = await client.httpGET("/v1/reporting/transactions", q)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.SearchResponse)
  else:
    raise newException(ReportingClientError, body)
