# webhooks API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Clue CLI Assistant https://github.com/openpeeps/clue
#
# Generated at: 2026-08-08T20:42:35+03:00
# License: MIT
import std/[strformat, options, json]
import ./metaclient
import ./types

type
  WebhookAnchorTypeOption* = enum
    anchorTypeAPPLICATION = "APPLICATION"
    anchorTypeACCOUNT = "ACCOUNT"


proc getV1NotificationsWebhooks*(client: WebhooksClient,
                                 anchorType: string = "APPLICATION"): Future[types.WebhookList] {.async.} =
  ## Lists webhooks for an app.

  var q = initOrderedTable[string, string]()
  q["anchor_type"] = anchorType
  let res = await client.httpGET("/v1/notifications/webhooks", q)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.WebhookList)
  else:
    raise newException(WebhooksClientError, body)

proc postV1NotificationsWebhooks*(client: WebhooksClient, body: types.Webhook): Future[types.Webhook] {.async.} =
  ## Subscribes your webhook listener to events.

  let res = await client.httpPOST("/v1/notifications/webhooks", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, types.Webhook)
  else:
    raise newException(WebhooksClientError, body)

proc getV1NotificationsWebhooksWebhookId*(client: WebhooksClient,
                                          webhookId: string): Future[types.Webhook] {.async.} =
  ## Shows details for a webhook, by ID.

  let res = await client.httpGET(fmt"/v1/notifications/webhooks/{webhookId}")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.Webhook)
  else:
    raise newException(WebhooksClientError, body)

proc deleteV1NotificationsWebhooksWebhookId*(client: WebhooksClient,
                                             webhookId: string): Future[AsyncResponse] {.async.} =
  ## Deletes a webhook, by ID.

  let res = await client.httpDELETE(fmt"/v1/notifications/webhooks/{webhookId}")
  return res

proc patchV1NotificationsWebhooksWebhookId*(client: WebhooksClient,
                                            webhookId: string,
                                            body: types.PatchRequest): Future[types.Webhook] {.async.} =
  ## Updates a webhook to replace webhook fields with new values. Supports only the
  ## `replace` operation. Pass a `json_patch` object with `replace` operation and
  ## `path`, which is `/url` for a URL or `/event_types` for events. The `value` is
  ## either the URL or a list of events.

  let res = await client.httpPATCH(fmt"/v1/notifications/webhooks/{webhookId}", body)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.Webhook)
  else:
    raise newException(WebhooksClientError, body)

proc getV1NotificationsWebhooksWebhookIdEventTypes*(client: WebhooksClient,
                                                    webhookId: string): Future[types.EventTypeList] {.async.} =
  ## Lists event subscriptions for a webhook, by ID.

  let res = await client.httpGET(fmt"/v1/notifications/webhooks/{webhookId}/event-types")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.EventTypeList)
  else:
    raise newException(WebhooksClientError, body)
