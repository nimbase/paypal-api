# paypal_reporting API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Nimbase CLI https://github.com/nimbase/nimbase
#
# Generated at: 2026-08-08T22:36:56+03:00
# License: MIT
import std/[strformat, options, json]
import ./private/metaclient
import ./private/types


proc getV1ReportingBalances*(client: ReportingClient,
                             asOfTime: string = default(string),
                             currencyCode: string = default(string)): Future[types.BalancesResponse] {.async.} =
  ## List all balances. Specify date time to list balances for that time that appear
  ## in the response.<blockquote><strong>Notes:</strong> <ul><li>It takes a maximum
  ## of three hours for balances to appear in the list balances call.</li><li>This
  ## call lists balances upto the previous three years.</li></ul></blockquote>

  var q = initOrderedTable[string, string]()
  q["as_of_time"] = $asOfTime
  q["currency_code"] = $currencyCode
  let res = await client.httpGET("/v1/reporting/balances", q)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.BalancesResponse)
  else:
    raise newException(ReportingClientError, body)
