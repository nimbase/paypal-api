# paypal_webhooks API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Nimbase CLI https://github.com/nimbase/nimbase
#
# Generated at: 2026-08-08T22:36:56+03:00
# License: MIT
import std/[strformat, options, json]
import ./private/metaclient
import ./private/types


proc getV1NotificationsWebhooksEvents*(client: WebhooksClient,
                                       pageSize: int64 = 10,
                                       startTime: string = default(string),
                                       endTime: string = default(string),
                                       transactionId: string = default(string),
                                       eventType: string = default(string)): Future[types.EventList] {.async.} =
  ## Lists webhooks event notifications. Use query parameters to filter the response.

  var q = initOrderedTable[string, string]()
  q["page_size"] = $pageSize
  q["start_time"] = $startTime
  q["end_time"] = $endTime
  q["transaction_id"] = $transactionId
  q["event_type"] = $eventType
  let res = await client.httpGET("/v1/notifications/webhooks-events", q)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.EventList)
  else:
    raise newException(WebhooksClientError, body)

proc getV1NotificationsWebhooksEventsEventId*(client: WebhooksClient,
                                              eventId: string): Future[types.Event] {.async.} =
  ## Shows details for a webhooks event notification, by ID.

  let res = await client.httpGET(fmt"/v1/notifications/webhooks-events/{eventId}")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.Event)
  else:
    raise newException(WebhooksClientError, body)

proc postV1NotificationsWebhooksEventsEventIdResend*(client: WebhooksClient,
                                                     eventId: string,
                                                     body: types.EventResend): Future[types.Event] {.async.} =
  ## Resends a webhook event notification, by ID. Any pending notifications are not
  ## resent.

  let res = await client.httpPOST(fmt"/v1/notifications/webhooks-events/{eventId}/resend", body)
  let body = await res.body
  case res.code
  of Http202:
    result = fromJson(body, types.Event)
  else:
    raise newException(WebhooksClientError, body)
