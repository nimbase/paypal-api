# paypal_orders API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Clue CLI Assistant https://github.com/openpeeps/clue
#
# Generated at: 2026-08-08T22:10:21+03:00
# License: MIT
import std/[strformat, options, json]
import ./metaclient
import ./types
import ./renames


proc postV2CheckoutOrders*(client: OrdersClient, body: types.OrderRequest): Future[types.Order] {.async.} =
  ## Creates an order. Merchants and partners can add Level 2 and 3 data to payments
  ## to reduce risk and payment processing costs. For more information about
  ## processing payments, see <ahref="https://developer.paypal.com/docs/checkout/adv
  ## anced/processing/">checkout</a> or <ahref="https://developer.paypal.com/docs/mu
  ## ltiparty/checkout/advanced/processing/">multiparty
  ## checkout</a>.<blockquote><strong>Note:</strong> For error handling and
  ## troubleshooting, see <ahref="https://developer.paypal.com/api/rest/reference/or
  ## ders/v2/errors/#create-order">Orders v2 errors</a>.</blockquote>

  let res = await client.httpPOST("/v2/checkout/orders", body)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.Order)
  else:
    raise newException(OrdersClientError, body)

proc getV2CheckoutOrdersId*(client: OrdersClient, id: string,
                            fields: string = default(string)): Future[types.Order] {.async.} =
  ## Shows details for an order, by ID.<blockquote><strong>Note:</strong> For error
  ## handling and troubleshooting, see <ahref="https://developer.paypal.com/api/rest
  ## /reference/orders/v2/errors/#get-order">Orders v2 errors</a>.</blockquote>

  var q = initOrderedTable[string, string]()
  q["fields"] = $fields
  let res = await client.httpGET(fmt"/v2/checkout/orders/{id}", q)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.Order)
  else:
    raise newException(OrdersClientError, body)

proc patchV2CheckoutOrdersId*(client: OrdersClient, id: string,
                              body: types.PatchRequest): Future[AsyncResponse] {.async.} =
  ## Updates an order with a `CREATED` or `APPROVED` status. You cannot update an
  ## order with the `COMPLETED` status.<br/><br/>To make an update, you must provide
  ## a `reference_id`. If you omit this value with an order that contains only one
  ## purchase unit, PayPal sets the value to `default` which enables you to use the
  ## path:
  ## <code>\"/purchase_units/@reference_id=='default'/{attribute-or-object}\"</code>.
  ## Merchants and partners can add Level 2 and 3 data to payments to reduce risk and
  ## payment processing costs. For more information about processing payments, see <a
  ## href="https://developer.paypal.com/docs/checkout/advanced/processing/">checkout<
  ## /a> or <ahref="https://developer.paypal.com/docs/multiparty/checkout/advanced/p
  ## rocessing/">multiparty checkout</a>.<blockquote><strong>Note:</strong> For error
  ## handling and troubleshooting, see <ahref="https://developer.paypal.com/api/rest
  ## /reference/orders/v2/errors/#patch-order">Orders v2
  ## errors</a>.</blockquote>Patchable attributes orobjects:<br/><br/><table><thead>
  ## <th>Attribute</th><th>Op</th><th>Notes</th></thead><tbody><tr><td><code>intent</
  ## code></td><td>replace</td><td></td></tr><tr><td><code>payer</code></td><td>repla
  ## ce, add</td><td>Using replace op for <code>payer</code> will replace the whole
  ## <code>payer</code> object with the value sent in
  ## request.</td></tr><tr><td><code>purchase_units</code></td><td>replace,add</td><
  ## td></td></tr><tr><td><code>purchase_units[].custom_id</code></td><td>replace,
  ## add,remove</td><td></td></tr><tr><td><code>purchase_units[].description</code><
  ## /td><td>replace, add,remove</td><td></td></tr><tr><td><code>purchase_units[].pa
  ## yee.email</code></td><td>replace</td><td></td></tr><tr><td><code>purchase_units[
  ## ].shipping.name</code></td><td>replace,add</td><td></td></tr><tr><td><code>purc
  ## hase_units[].shipping.email_address</code></td><td>replace,add</td><td></td></t
  ## r><tr><td><code>purchase_units[].shipping.phone_number</code></td><td>replace,a
  ## dd</td><td></td></tr><tr><td><code>purchase_units[].shipping.options</code></td>
  ## <td>replace,add</td><td></td></tr><tr><td><code>purchase_units[].shipping.addre
  ## ss</code></td><td>replace,add</td><td></td></tr><tr><td><code>purchase_units[].
  ## shipping.type</code></td><td>replace,add</td><td></td></tr><tr><td><code>purcha
  ## se_units[].soft_descriptor</code></td><td>replace,remove</td><td></td></tr><tr>
  ## <td><code>purchase_units[].amount</code></td><td>replace</td><td></td></tr><tr><
  ## td><code>purchase_units[].items</code></td><td>replace, add,remove</td><td></td
  ## ></tr><tr><td><code>purchase_units[].invoice_id</code></td><td>replace, add,rem
  ## ove</td><td></td></tr><tr><td><code>purchase_units[].payment_instruction</code><
  ## /td><td>replace</td><td></td></tr><tr><td><code>purchase_units[].payment_instruc
  ## tion.disbursement_mode</code></td><td>replace</td><td>By default,
  ## <code>disbursement_mode</code> is<code>INSTANT</code>.</td></tr><tr><td><code>p
  ## urchase_units[].payment_instruction.payee_receivable_fx_rate_id</code></td><td>r
  ## eplace, add,remove</td><td></td></tr><tr><td><code>purchase_units[].payment_ins
  ## truction.platform_fees</code></td><td>replace, add,remove</td><td></td></tr><tr
  ## ><td><code>purchase_units[].supplementary_data.airline</code></td><td>replace,
  ## add,remove</td><td></td></tr><tr><td><code>purchase_units[].supplementary_data.
  ## card</code></td><td>replace, add,remove</td><td></td></tr><tr><td><code>applica
  ## tion_context.client_configuration</code></td><td>replace,
  ## add</td><td></td></tr></tbody></table>

  let res = await client.httpPATCH(fmt"/v2/checkout/orders/{id}", body)
  return res

proc postV2CheckoutOrdersIdConfirmPaymentSource*(client: OrdersClient,
                                                 id: string,
                                                 body: types.ConfirmOrderRequest): Future[types.Order] {.async.} =
  ## Payer confirms their intent to pay for the the Order with the given payment
  ## source.

  let res = await client.httpPOST(fmt"/v2/checkout/orders/{id}/confirm-payment-source", body)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.Order)
  else:
    raise newException(OrdersClientError, body)

proc postV2CheckoutOrdersIdAuthorize*(client: OrdersClient, id: string,
                                      body: types.OrderAuthorizeRequest): Future[types.OrderAuthorizeResponse] {.async.} =
  ## Authorizes payment for an order. To successfully authorize payment for an order,
  ## the buyer must first approve the order or a valid payment_source must be
  ## provided in the request. A buyer can approve the order upon being redirected to
  ## the rel:approve URL that was returned in the HATEOAS links in the create order
  ## response.<blockquote><strong>Note:</strong> For error handling and
  ## troubleshooting, see <ahref="https://developer.paypal.com/api/rest/reference/or
  ## ders/v2/errors/#authorize-order">Orders v2 errors</a>.</blockquote>

  let res = await client.httpPOST(fmt"/v2/checkout/orders/{id}/authorize", body)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.OrderAuthorizeResponse)
  else:
    raise newException(OrdersClientError, body)

proc postV2CheckoutOrdersIdCapture*(client: OrdersClient, id: string,
                                    body: types.OrderCaptureRequest): Future[types.Order] {.async.} =
  ## Captures payment for an order. To successfully capture payment for an order, the
  ## buyer must first approve the order or a valid payment_source must be provided in
  ## the request. A buyer can approve the order upon being redirected to the
  ## rel:approve URL that was returned in the HATEOAS links in the create order
  ## response.<blockquote><strong>Note:</strong> For error handling and
  ## troubleshooting, see <ahref="https://developer.paypal.com/api/rest/reference/or
  ## ders/v2/errors/#capture-order">Orders v2 errors</a>.</blockquote>

  let res = await client.httpPOST(fmt"/v2/checkout/orders/{id}/capture", body)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.Order)
  else:
    raise newException(OrdersClientError, body)

proc postV2CheckoutOrdersIdTrack*(client: OrdersClient, id: string,
                                  body: types.OrderTrackerRequest): Future[types.Order] {.async.} =
  ## Adds tracking information for an Order.

  let res = await client.httpPOST(fmt"/v2/checkout/orders/{id}/track", body)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.Order)
  else:
    raise newException(OrdersClientError, body)
