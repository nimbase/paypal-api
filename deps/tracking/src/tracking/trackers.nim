# shipment API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Clue CLI Assistant https://github.com/openpeeps/clue
#
# Generated at: 2026-08-08T18:16:14+03:00
# License: MIT
import std/[strformat, options, json]
import ./metaclient
import ./types


proc getV1ShippingTrackers*(client: TrackingClient, transactionId: string,
                            trackingNumber: string = default(string),
                            accountId: string = default(string)): Future[types.Tracker] {.async.} =
  ## Lists tracking information that meet search criteria. The tracking ID is
  ## required but the tracking number is optional.

  var q = initOrderedTable[string, string]()
  q["transaction_id"] = $transactionId
  q["tracking_number"] = $trackingNumber
  q["account_id"] = $accountId
  let res = await client.httpGET("/v1/shipping/trackers", q)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.Tracker)
  else:
    raise newException(TrackingClientError, body)

proc postV1ShippingTrackers*(client: TrackingClient,
                             body: types.TrackerCollection): Future[types.TrackerIdentifierCollection] {.async.} =
  ## Adds tracking information for a PayPal transaction.

  let res = await client.httpPOST("/v1/shipping/trackers", body)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.TrackerIdentifierCollection)
  else:
    raise newException(TrackingClientError, body)

proc getV1ShippingTrackersId*(client: TrackingClient, id: string,
                              accountId: string = default(string)): Future[types.Tracker] {.async.} =
  ## Shows tracking information, by tracker ID, for a PayPal transaction.

  var q = initOrderedTable[string, string]()
  q["account_id"] = $accountId
  let res = await client.httpGET(fmt"/v1/shipping/trackers/{id}", q)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.Tracker)
  else:
    raise newException(TrackingClientError, body)

proc putV1ShippingTrackersId*(client: TrackingClient, id: string,
                              body: types.Tracker): Future[AsyncResponse] {.async.} =
  ## Updates or cancels the tracking information for a PayPal transaction, by ID. To
  ## cancel tracking information, call this method and set the status to CANCELLED.
  ## For more information, see <ahref="/docs/tracking/tracking-api/integrate/#link-u
  ## pdateorcanceltrackinginformation">Update or cancel tracking information</a>.

  let res = await client.httpPUT(fmt"/v1/shipping/trackers/{id}", body)
  return res
