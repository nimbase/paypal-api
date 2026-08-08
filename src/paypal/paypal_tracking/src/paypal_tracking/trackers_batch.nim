# shipment API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Clue CLI Assistant https://github.com/openpeeps/clue
#
# Generated at: 2026-08-08T20:42:35+03:00
# License: MIT
import std/[strformat, options, json]
import ./metaclient
import ./types


proc postV1ShippingTrackersBatch*(client: TrackingClient,
                                  body: types.TrackerCollection): Future[types.BatchTrackerCollection] {.async.} =
  ## <blockquote><strong>Deprecation notice:</strong> Adding tracking details for an
  ## order through <code>/v1/shipping/trackers-batch</code> is deprecated as its a
  ## legacy way of integration. Use the new <a
  ## href="/docs/tracking/orders-api/integrate/">Orders v2 API</a> to share tracking
  ## details with PayPal.</blockquote>Adds tracking information, with or without
  ## tracking numbers, for multiple PayPal transactions. Accepts up to 20 tracking
  ## IDs. For more information, see <ahref="/docs/tracking/tracking-api/integrate/#l
  ## ink-addtrackinginformationwithtrackingnumbers">Add tracking information with
  ## tracking numbers</a> and <ahref="/docs/tracking/tracking-api/integrate/#link-ad
  ## dtrackinginformationwithouttrackingnumbers">Add tracking information without
  ## tracking numbers</a>.

  let res = await client.httpPOST("/v1/shipping/trackers-batch", body)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.BatchTrackerCollection)
  else:
    raise newException(TrackingClientError, body)
