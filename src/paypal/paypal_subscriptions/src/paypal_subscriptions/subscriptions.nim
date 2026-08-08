# paypal_subscriptions API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Clue CLI Assistant https://github.com/openpeeps/clue
#
# Generated at: 2026-08-08T21:40:15+03:00
# License: MIT
import std/[strformat, options, json]
import ./metaclient
import ./types


proc postV1BillingSubscriptions*(client: SubscriptionsClient,
                                 body: types.SubscriptionRequestPost): Future[types.Subscription] {.async.} =
  ## Creates a subscription.

  let res = await client.httpPOST("/v1/billing/subscriptions", body)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.Subscription)
  else:
    raise newException(SubscriptionsClientError, body)

proc getV1BillingSubscriptionsId*(client: SubscriptionsClient, id: string,
                                  fields: string = default(string)): Future[types.Subscription] {.async.} =
  ## Shows details for a subscription, by ID.

  var q = initOrderedTable[string, string]()
  q["fields"] = $fields
  let res = await client.httpGET(fmt"/v1/billing/subscriptions/{id}", q)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.Subscription)
  else:
    raise newException(SubscriptionsClientError, body)

proc patchV1BillingSubscriptionsId*(client: SubscriptionsClient,
                                    id: string, body: types.PatchRequest): Future[AsyncResponse] {.async.} =
  ## Updates a subscription which could be in <code>ACTIVE</code> or
  ## <code>SUSPENDED</code> status. You can override plan level default attributes by
  ## providing customised values for plan path in the patch request.<br /> <ul>
  ## <li>You cannot update attributes that have already completed (Example - trial
  ## cycles can’t be updated if completed).</li> <li>Once overridden, changes to plan
  ## resource will not impact subscription.</li> <li>Any price update will not impact
  ## billing cycles within next 10 days (Applicable only for subscriptions funded by
  ## PayPal account).</li> </ul> Following are the fields eligible for
  ## patch.<table><thead><tr><th>Attribute orobject</th><th>Operations</th></tr></th
  ## ead><tbody><tr><td><code>billing_info.outstanding_balance</code></td><td>replace
  ## </td></tr><tr><td><code>custom_id</code></td><td>add,replace</td></tr><tr><td><c
  ## ode>plan.billing_cycles[@sequence==n].<br/>pricing_scheme.fixed_price</code></td
  ## ><td>add,replace</td></tr><tr><td><code>plan.billing_cycles[@sequence==n].<br/>p
  ## ricing_scheme.tiers</code></td><td>replace</td></tr><tr><td><code>plan.billing_c
  ## ycles[@sequence==n].<br/>total_cycles</code></td><td>replace</td></tr><tr><td><c
  ## ode>plan.payment_preferences.<br/>auto_bill_outstanding</code></td><td>replace</
  ## td></tr><tr><td><code>plan.payment_preferences.<br/>payment_failure_threshold</c
  ## ode></td><td>replace</td></tr><tr><td><code>plan.taxes.inclusive</code></td><td>
  ## add,replace</td></tr><tr><td><code>plan.taxes.percentage</code></td><td>add,repl
  ## ace</td></tr><tr><td><code>shipping_amount</code></td><td>add,replace</td></tr><
  ## tr><td><code>start_time</code></td><td>replace</td></tr><tr><td><code>subscriber
  ## .shipping_address</code></td><td>add,replace</td></tr><tr><td><code>subscriber.p
  ## ayment_source (for subscriptions funded<br/>by card
  ## payments)</code></td><td>replace</td></tr></tbody></table>

  let res = await client.httpPATCH(fmt"/v1/billing/subscriptions/{id}", body)
  return res

proc postV1BillingSubscriptionsIdRevise*(client: SubscriptionsClient,
                                         id: string,
                                         body: types.SubscriptionReviseRequest): Future[types.SubscriptionReviseResponse] {.async.} =
  ## Updates the quantity of the product or service in a subscription. You can also
  ## use this method to switch the plan and update the `shipping_amount`,
  ## `shipping_address` values for the subscription. This type of update requires the
  ## buyer's consent.

  let res = await client.httpPOST(fmt"/v1/billing/subscriptions/{id}/revise", body)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.SubscriptionReviseResponse)
  else:
    raise newException(SubscriptionsClientError, body)

proc postV1BillingSubscriptionsIdSuspend*(client: SubscriptionsClient,
                                          id: string,
                                          body: types.SubscriptionSuspendRequest): Future[AsyncResponse] {.async.} =
  ## Suspends the subscription.

  let res = await client.httpPOST(fmt"/v1/billing/subscriptions/{id}/suspend", body)
  return res

proc postV1BillingSubscriptionsIdCancel*(client: SubscriptionsClient,
                                         id: string,
                                         body: types.SubscriptionCancelRequest): Future[AsyncResponse] {.async.} =
  ## Cancels the subscription.

  let res = await client.httpPOST(fmt"/v1/billing/subscriptions/{id}/cancel", body)
  return res

proc postV1BillingSubscriptionsIdActivate*(client: SubscriptionsClient,
                                           id: string,
                                           body: types.SubscriptionActivateRequest): Future[AsyncResponse] {.async.} =
  ## Activates the subscription.

  let res = await client.httpPOST(fmt"/v1/billing/subscriptions/{id}/activate", body)
  return res

proc postV1BillingSubscriptionsIdCapture*(client: SubscriptionsClient,
                                          id: string,
                                          body: types.SubscriptionCaptureRequest): Future[types.Transaction] {.async.} =
  ## Captures an authorized payment from the subscriber on the subscription.

  let res = await client.httpPOST(fmt"/v1/billing/subscriptions/{id}/capture", body)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.Transaction)
  else:
    raise newException(SubscriptionsClientError, body)

proc getV1BillingSubscriptionsIdTransactions*(client: SubscriptionsClient,
                                              id: string, startTime: string,
                                              endTime: string): Future[types.TransactionsList] {.async.} =
  ## Lists transactions for a subscription.

  var q = initOrderedTable[string, string]()
  q["start_time"] = $startTime
  q["end_time"] = $endTime
  let res = await client.httpGET(fmt"/v1/billing/subscriptions/{id}/transactions", q)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.TransactionsList)
  else:
    raise newException(SubscriptionsClientError, body)
