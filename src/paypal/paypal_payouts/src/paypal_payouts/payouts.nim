# paypal_payouts API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Clue CLI Assistant https://github.com/openpeeps/clue
#
# Generated at: 2026-08-08T21:40:16+03:00
# License: MIT
import std/[strformat, options, json]
import ./metaclient
import ./types


proc postV1PaymentsPayouts*(client: PayoutsClient,
                            body: types.CreatePayoutRequest): Future[types.Payout] {.async.} =
  ## Creates a batch payout. In the JSON request body, pass a `sender_batch_header`
  ## and an `items` array. The `sender_batch_header` defines how to handle the
  ## payout. The `items` array defines the payout items.<br/>You can make payouts to
  ## one or more recipients.<blockquote><strong>Notes:</strong> <ul><li><p>PayPal
  ## does not process duplicate payouts. If you specify a
  ## <code>sender_batch_id</code> that was used in the last 30 days, the API rejects
  ## the request with an error message that shows the duplicate
  ## <code>sender_batch_id</code> and includes a HATEOAS link to the original payout
  ## with the same <code>sender_batch_id</code>.</p><p>If you receive an HTTP
  ## <code>5<i>nn</i></code> status code, you can safely retry the request with the
  ## same <code>sender_batch_id</code>.</p></li><li><p>The Payouts API does not
  ## support build notation (BN) codes. In a future Payouts release, you can
  ## optionally provide BN codes in the <code>PayPal-Partner-Attribution-Id</code>
  ## request header.</p><p>For information about the
  ## <code>PayPal-Partner-Attribution-Id</code> header, see <a
  ## href="/api/rest/requests/#http-request-headers">HTTP request headers</a>. To
  ## learn about or request a BN code, contact your partner manager or see <a
  ## href="https://www.paypal.com/us/webapps/mpp/partner-program">PayPal Partner
  ## Program</a>.</p></li></ul></blockquote>

  let res = await client.httpPOST("/v1/payments/payouts", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, types.Payout)
  else:
    raise newException(PayoutsClientError, body)

proc getV1PaymentsPayoutsId*(client: PayoutsClient, id: string,
                             fields: string = default(string), page: int64 = 1,
                             pageSize: int64 = default(int64),
                             totalRequired: bool = false): Future[types.PayoutBatch] {.async.} =
  ## Shows the latest status of a batch payout. Includes the transaction status and
  ## other data for individual payout items.

  var q = initOrderedTable[string, string]()
  q["fields"] = $fields
  q["page"] = $page
  q["page_size"] = $pageSize
  q["total_required"] = $totalRequired
  let res = await client.httpGET(fmt"/v1/payments/payouts/{id}", q)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.PayoutBatch)
  else:
    raise newException(PayoutsClientError, body)
