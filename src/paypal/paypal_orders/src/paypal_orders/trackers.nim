# paypal_orders API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Nimbase CLI https://github.com/nimbase/nimbase
#
# Generated at: 2026-08-08T23:21:33+03:00
# License: MIT
import std/[strformat, options, json]
import ./private/metaclient
import ./private/types
import ./private/renames


proc patchV2CheckoutOrdersIdTrackersTrackerId*(client: OrdersClient,
                                               id: string, trackerId: string,
                                               body: types.PatchRequest): Future[AsyncResponse] {.async.} =
  ## Updates or cancels the tracking information for a PayPal order, by ID. Updatable
  ## attributes orobjects:<br/><br/><table><thead><th>Attribute</th><th>Op</th><th>N
  ## otes</th></thead><tbody></tr><tr><td><code>items</code></td><td>replace</td><td>
  ## Using replace op for <code>items</code> will replace the entire
  ## <code>items</code> object with the value sent in
  ## request.</td></tr><tr><td><code>notify_payer</code></td><td>replace,
  ## add</td><td></td></tr><tr><td><code>status</code></td><td>replace</td><td>Only
  ## patching status to CANCELLED is currently supported.</td></tr></tbody></table>

  let res = await client.httpPATCH(fmt"/v2/checkout/orders/{id}/trackers/{trackerId}", body)
  return res
