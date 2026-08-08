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


proc getV1NotificationsWebhooksLookup*(client: WebhooksClient): Future[types.WebhookLookupList] {.async.} =
  ## Lists webhook lookups.

  let res = await client.httpGET("/v1/notifications/webhooks-lookup")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.WebhookLookupList)
  else:
    raise newException(WebhooksClientError, body)

proc postV1NotificationsWebhooksLookup*(client: WebhooksClient): Future[types.WebhooksLookup] {.async.} =
  ## Creates a webhook lookup. A webhook lookup ties the API caller's REST API app to
  ## the subject account (or, if no subject is specified, to the API caller's
  ## account). If a webhook event is generated for an event that is tied to the
  ## account but not to a particular REST API app (for example, payments initiated
  ## with the NVP/SOAP APIs or through the user interface on PayPal.com), those
  ## webhook events will treated as if they were intended for the REST API app
  ## registered in the webhook lookup instead. Webhook events will then be delivered
  ## to any webhooks registered to that REST API app.

  let res = await client.httpPOST("/v1/notifications/webhooks-lookup")
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, types.WebhooksLookup)
  else:
    raise newException(WebhooksClientError, body)

proc getV1NotificationsWebhooksLookupWebhookLookupId*(client: WebhooksClient,
                                                      webhookLookupId: string): Future[types.WebhooksLookup] {.async.} =
  ## Shows details for a webhook lookup, by ID.

  let res = await client.httpGET(fmt"/v1/notifications/webhooks-lookup/{webhookLookupId}")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.WebhooksLookup)
  else:
    raise newException(WebhooksClientError, body)

proc deleteV1NotificationsWebhooksLookupWebhookLookupId*(client: WebhooksClient,
                                                         webhookLookupId: string): Future[AsyncResponse] {.async.} =
  ## Deletes a webhook lookup, by ID.

  let res = await client.httpDELETE(fmt"/v1/notifications/webhooks-lookup/{webhookLookupId}")
  return res
