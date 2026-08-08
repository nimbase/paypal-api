# disputes API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Clue CLI Assistant https://github.com/openpeeps/clue
#
# Generated at: 2026-08-08T19:13:20+03:00
# License: MIT
import std/[strformat, options, json]
import ./metaclient
import ./types


proc getV1CustomerDisputes*(client: DisputesClient,
                            startTime: string = "Current date and time",
                            disputedTransactionId: string = default(string),
                            pageSize: int64 = 10,
                            nextPageToken: string = "The first page of data",
                            disputeState: string = default(string),
                            updateTimeBefore: string = default(string),
                            updateTimeAfter: string = default(string)): Future[types.DisputeSearch] {.async.} =
  ## Lists disputes with a summary set of details, which shows the
  ## <code>dispute_id</code>, <code>reason</code>, <code>status</code>,
  ## <code>dispute_state</code>, <code>dispute_life_cycle_stage</code>,
  ## <code>dispute_channel</code>, <code>dispute_amount</code>,
  ## <code>create_time</code> and <code>update_time</code> fields.<br/><br/>To filter
  ## the disputes in the response, specify one or more optional query parameters. To
  ## limit the number of disputes in the response, specify the <code>page_size</code>
  ## query parameter.<br/><br/>To list multiple disputes, set these query parameters
  ## in the request:<ul><li><code>page_size=2</code></li><li><code>start_time</code>
  ## instead of <code>disputed_transaction_id</code></li></ul><br/>If the response
  ## contains more than two disputes, it lists two disputes and includes a HATEOAS
  ## link to the next page of results.

  var q = initOrderedTable[string, string]()
  q["start_time"] = $startTime
  q["disputed_transaction_id"] = $disputedTransactionId
  q["page_size"] = $pageSize
  q["next_page_token"] = $nextPageToken
  q["dispute_state"] = $disputeState
  q["update_time_before"] = $updateTimeBefore
  q["update_time_after"] = $updateTimeAfter
  let res = await client.httpGET("/v1/customer/disputes", q)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.DisputeSearch)
  else:
    raise newException(DisputesClientError, body)

proc getV1CustomerDisputesId*(client: DisputesClient, id: string): Future[types.Dispute] {.async.} =
  ## Shows details for a dispute, by ID.<blockquote><strong>Note:</strong> The fields
  ## that appear in the response depend on the access. For example, if the merchant
  ## requests shows dispute details, the customer's email ID does not
  ## appear.</blockquote>

  let res = await client.httpGET(fmt"/v1/customer/disputes/{id}")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.Dispute)
  else:
    raise newException(DisputesClientError, body)

proc patchV1CustomerDisputesId*(client: DisputesClient, id: string,
                                body: types.PatchRequest): Future[types.SubsequentAction] {.async.} =
  ## Partially updates a dispute, by ID. Seller can update the `communication_detail`
  ## value or The partner can add the `partner action` information.

  let res = await client.httpPATCH(fmt"/v1/customer/disputes/{id}", body)
  let body = await res.body
  case res.code
  of Http202:
    result = fromJson(body, types.SubsequentAction)
  else:
    raise newException(DisputesClientError, body)
