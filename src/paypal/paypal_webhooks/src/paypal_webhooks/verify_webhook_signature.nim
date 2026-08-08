# paypal_webhooks API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Nimbase CLI https://github.com/nimbase/nimbase
#
# Generated at: 2026-08-08T23:06:08+03:00
# License: MIT
import std/[strformat, options, json]
import ./private/metaclient
import ./private/types


proc postV1NotificationsVerifyWebhookSignature*(client: WebhooksClient,
                                                body: types.VerifyWebhookSignature): Future[types.VerifyWebhookSignatureResponse] {.async.} =
  ## Verifies a webhook signature.

  let res = await client.httpPOST("/v1/notifications/verify-webhook-signature", body)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.VerifyWebhookSignatureResponse)
  else:
    raise newException(WebhooksClientError, body)
