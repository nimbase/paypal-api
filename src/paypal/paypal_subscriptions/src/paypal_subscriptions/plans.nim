# paypal_subscriptions API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Nimbase CLI https://github.com/nimbase/nimbase
#
# Generated at: 2026-08-08T23:06:07+03:00
# License: MIT
import std/[strformat, options, json]
import ./private/metaclient
import ./private/types


proc getV1BillingPlans*(client: SubscriptionsClient,
                        productId: string = default(string),
                        pageSize: int64 = 10, page: int64 = 1,
                        totalRequired: bool = false): Future[types.PlanCollection] {.async.} =
  ## Lists billing plans.

  var q = initOrderedTable[string, string]()
  q["product_id"] = $productId
  q["page_size"] = $pageSize
  q["page"] = $page
  q["total_required"] = $totalRequired
  let res = await client.httpGET("/v1/billing/plans", q)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.PlanCollection)
  else:
    raise newException(SubscriptionsClientError, body)

proc postV1BillingPlans*(client: SubscriptionsClient,
                         body: types.PlanRequestPOST): Future[types.Plan] {.async.} =
  ## Creates a plan that defines pricing and billing cycle details for subscriptions.

  let res = await client.httpPOST("/v1/billing/plans", body)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.Plan)
  else:
    raise newException(SubscriptionsClientError, body)

proc getV1BillingPlansId*(client: SubscriptionsClient, id: string): Future[types.Plan] {.async.} =
  ## Shows details for a plan, by ID.

  let res = await client.httpGET(fmt"/v1/billing/plans/{id}")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.Plan)
  else:
    raise newException(SubscriptionsClientError, body)

proc patchV1BillingPlansId*(client: SubscriptionsClient, id: string,
                            body: types.PatchRequest): Future[AsyncResponse] {.async.} =
  ## Updates a plan with the `CREATED` or `ACTIVE` status. For an `INACTIVE` plan,
  ## you can make only status updates.<br/>You can patch these attributes and
  ## objects:<table><thead><tr><th>Attribute orobject</th><th>Operations</th></tr></
  ## thead><tbody><tr><td><code>description</code></td><td>replace</td></tr><tr><td><
  ## code>payment_preferences.auto_bill_outstanding</code></td><td>replace</td></tr><
  ## tr><td><code>taxes.percentage</code></td><td>replace</td></tr><tr><td><code>paym
  ## ent_preferences.payment_failure_threshold</code></td><td>replace</td></tr><tr><t
  ## d><code>payment_preferences.setup_fee</code></td><td>replace</td></tr><tr><td><c
  ## ode>payment_preferences.setup_fee_failure_action</code></td><td>replace</td></tr
  ## ><tr><td><code>name</code></td><td>replace</td></tr></tbody></table>

  let res = await client.httpPATCH(fmt"/v1/billing/plans/{id}", body)
  return res

proc postV1BillingPlansIdActivate*(client: SubscriptionsClient, id: string): Future[AsyncResponse] {.async.} =
  ## Activates a plan, by ID.

  let res = await client.httpPOST(fmt"/v1/billing/plans/{id}/activate")
  return res

proc postV1BillingPlansIdDeactivate*(client: SubscriptionsClient,
                                     id: string): Future[AsyncResponse] {.async.} =
  ## Deactivates a plan, by ID.

  let res = await client.httpPOST(fmt"/v1/billing/plans/{id}/deactivate")
  return res

proc postV1BillingPlansIdUpdatePricingSchemes*(client: SubscriptionsClient,
                                               id: string,
                                               body: types.UpdatePricingSchemesListRequest): Future[AsyncResponse] {.async.} =
  ## Updates pricing for a plan. For example, you can update a regular billing cycle
  ## from $5 per month to $7 per month.

  let res = await client.httpPOST(fmt"/v1/billing/plans/{id}/update-pricing-schemes", body)
  return res
