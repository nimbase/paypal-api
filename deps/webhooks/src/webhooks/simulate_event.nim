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


proc postV1NotificationsSimulateEvent*(client: WebhooksClient,
                                       body: types.SimulateEvent): Future[types.Event] {.async.} =
  ## Simulates a webhook event. In the JSON request body, specify a sample
  ## payload.<br>You need to subscribe to the following webhook events for Pay uponI
  ## nvoice:<br><table><thead><tr><th>Event</th><th>Trigger</th></tr></thead><tbody><
  ## tr><td><code>PAYMENT.CAPTURE.COMPLETED</code></td><td>A payment capture
  ## completes.</td></tr><tr><td><code>PAYMENT.CAPTURE.DENIED</code></td><td>A
  ## payment capture isdenied.</td></tr><tr><td><code>CHECKOUT.PAYMENT-APPROVAL.REVE
  ## RSED</code></td><td>PayPal reverses a payment capture.</td></tr></tbody></table>

  let res = await client.httpPOST("/v1/notifications/simulate-event", body)
  let body = await res.body
  case res.code
  of Http202:
    result = fromJson(body, types.Event)
  else:
    raise newException(WebhooksClientError, body)
