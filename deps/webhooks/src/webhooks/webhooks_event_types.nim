# webhooks API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Clue CLI Assistant https://github.com/openpeeps/clue
#
# Generated at: 2026-08-08T18:16:14+03:00
# License: MIT
import std/[strformat, options, json]
import ./metaclient
import ./types


proc getV1NotificationsWebhooksEventTypes*(client: WebhooksClient): Future[types.EventTypeList] {.async.} =
  ## Lists available events to which any webhook can subscribe. For a list of
  ## supported events, see [Webhook event
  ## names](/docs/api/notifications/webhooks/event-names/).

  let res = await client.httpGET("/v1/notifications/webhooks-event-types")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.EventTypeList)
  else:
    raise newException(WebhooksClientError, body)
