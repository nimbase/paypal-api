# paypal_disputes API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Nimbase CLI https://github.com/nimbase/nimbase
#
# Generated at: 2026-08-09T17:24:06+03:00
# License: MIT
import std/[strformat]
import ./private/metaclient
import ./private/types


proc postV1CustomerDisputesIdProvideEvidence*(client: DisputesClient,
                                              id: string): Future[types.SubsequentAction] {.async.} =
  ## Provides evidence for a dispute, by ID. A merchant can provide evidence for
  ## disputes with the <code>WAITING_FOR_SELLER_RESPONSE</code> status while
  ## customers can provide evidence for disputes with the
  ## <code>WAITING_FOR_BUYER_RESPONSE</code> status. Evidence can be a proof of
  ## delivery or proof of refund document or notes, which can include logs. A proof
  ## of delivery document includes a tracking number while a proof of refund document
  ## includes a refund ID. For other evidence type, notes and documents can be given.
  ## Evidences requested from you can be found by checking the type of evidence for
  ## the corresponding source under the evidence section of the <a
  ## href="/docs/api/customer-disputes/v1/#disputes_get">show dispute details</a>
  ## response. The source will be <code>REQUESTED_FROM_SELLER</code> for evidences
  ## requested from the merchant while it will be <code>REQUESTED_FROM_BUYER</code>
  ## for evidences requested from the customer. For constraints and rules regarding
  ## documents, see <ahref="/docs/integration/direct/customer-disputes/integration-g
  ## uide/#documents">documents</a>.<br/>To make this request, specify the evidence
  ## in the JSON request body and use the <code>provide-evidence</code> link in the
  ## <a href="/docs/api/reference/api-responses/#hateoas-links/">HATEOAS links</a> of
  ## the <a href="/docs/api/customer-disputes/v1/#disputes_get">show dispute
  ## details</a> response. In case the link is not present in the response, you can't
  ## provide evidence for the dispute. For information about dispute reasons, see <a
  ## href="/docs/integration/direct/customer-disputes/integration-guide/#dispute-reas
  ## ons">dispute reasons</a>.

  let res = await client.httpPOST(fmt"/v1/customer/disputes/{id}/provide-evidence")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.SubsequentAction)
  else:
    raise newException(DisputesClientError, body)

proc postV1CustomerDisputesIdAppeal*(client: DisputesClient, id: string): Future[types.SubsequentAction] {.async.} =
  ## Appeals a dispute, by ID. To appeal a dispute, use the <code>appeal</code> link
  ## in the <a href="/docs/api/reference/api-responses/#hateoas-links/">HATEOAS
  ## links</a> from the show dispute details response. If this link does not appear,
  ## you cannot appeal the dispute. Submit new evidence as a document or notes in the
  ## JSON request body. For constraints and rules regarding documents, see <ahref="/
  ## docs/integration/direct/customer-disputes/integration-guide/#documents">document
  ## s</a>.<br/>To make this request, specify the dispute ID in the URI and specify
  ## the evidence in the JSON request body. For information about dispute reasons,
  ## see <ahref="/docs/integration/direct/customer-disputes/integration-guide/#dispu
  ## te-reasons">dispute reasons</a>.

  let res = await client.httpPOST(fmt"/v1/customer/disputes/{id}/appeal")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.SubsequentAction)
  else:
    raise newException(DisputesClientError, body)

proc postV1CustomerDisputesIdAcceptClaim*(client: DisputesClient,
                                          id: string): Future[types.SubsequentAction] {.async.} =
  ## Accepts liability for a claim, by ID. When you accept liability for a claim, the
  ## dispute closes in the customer’s favor and PayPal automatically refunds money to
  ## the customer from the merchant's account. Allowed accept_claim_type values for
  ## the request is available in dispute details <ahref="/docs/api/customer-disputes
  ## /v1/#definition-allowed_response_options">allowed response options</a> object.

  let res = await client.httpPOST(fmt"/v1/customer/disputes/{id}/accept-claim")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.SubsequentAction)
  else:
    raise newException(DisputesClientError, body)

proc postV1CustomerDisputesIdAdjudicate*(client: DisputesClient,
                                         id: string, body: types.Adjudicate): Future[types.SubsequentAction] {.async.} =
  ## <blockquote><strong>Important:</strong> This method is for sandbox use
  ## only.</blockquote> Settles a dispute in either the customer's or merchant's
  ## favor. Merchants can make this call in the sandbox to complete end-to-end
  ## dispute resolution testing, which mimics the dispute resolution that PayPal
  ## agents normally complete. To make this call, the dispute <code>status</code>
  ## must be <code>UNDER_REVIEW</code> and <code>adjudicate</code> link  should be
  ## available in the <ahref="/docs/api/customer-disputes/v1/#disputes_get!c=200&pat
  ## h=links&t=response/">HATEOAS links</a> of the <a
  ## href="/docs/api/customer-disputes/v1/#disputes_get">show dispute details</a>
  ## response.

  let res = await client.httpPOST(fmt"/v1/customer/disputes/{id}/adjudicate", body)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.SubsequentAction)
  else:
    raise newException(DisputesClientError, body)

proc postV1CustomerDisputesIdRequireEvidence*(client: DisputesClient,
                                              id: string,
                                              body: types.RequireEvidence): Future[types.SubsequentAction] {.async.} =
  ## <blockquote><strong>Important:</strong> This method is for sandbox use
  ## only.</blockquote> Updates the status of a dispute, by ID, from
  ## <code>UNDER_REVIEW</code> toeither:<ul><li><code>WAITING_FOR_BUYER_RESPONSE</co
  ## de></li><li><code>WAITING_FOR_SELLER_RESPONSE</code></li></ul>This status change
  ## enables either the customer or merchant to submit evidence for the dispute. To
  ## make this call, the dispute <code>status</code> must be
  ## <code>UNDER_REVIEW</code> and <code>require-evidence</code> link  should be
  ## available in the <ahref="/docs/api/customer-disputes/v1/#disputes_get!c=200&pat
  ## h=links&t=response/">HATEOAS links</a> of the <a
  ## href="/docs/api/customer-disputes/v1/#disputes_get">show dispute details</a>
  ## response. Specify an <code>action</code> value in the JSON request body to
  ## indicate whether the status change enables the customer or merchant to submit
  ## evidence:<table><thead><tr align="left"><th>If <code>action</code>
  ## is</th><th>The <code>status</code> updates
  ## to</th></tr></thead><tbody><tr><td><code>BUYER_EVIDENCE</code></td><td><code>WA
  ## ITING_FOR_BUYER_RESPONSE</code></td></tr><tr><td><code>SELLER_EVIDENCE</code></t
  ## d><td> <code>WAITING_FOR_SELLER_RESPONSE</code></td></tr></tbody></table>.

  let res = await client.httpPOST(fmt"/v1/customer/disputes/{id}/require-evidence", body)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.SubsequentAction)
  else:
    raise newException(DisputesClientError, body)

proc postV1CustomerDisputesIdEscalate*(client: DisputesClient, id: string,
                                       body: types.Escalate): Future[types.EscalateResponse] {.async.} =
  ## Escalates the dispute, by ID, to a PayPal claim. To make this call, the stage in
  ## the dispute lifecycle must be `INQUIRY`.

  let res = await client.httpPOST(fmt"/v1/customer/disputes/{id}/escalate", body)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.EscalateResponse)
  else:
    raise newException(DisputesClientError, body)

proc postV1CustomerDisputesIdSendMessage*(client: DisputesClient,
                                          id: string): Future[types.SubsequentAction] {.async.} =
  ## Sends a message about a dispute, by ID, to the other party in the dispute.
  ## Merchants and customers can only send messages if the `dispute_life_cycle_stage`
  ## value is `INQUIRY`. For constraints and rules regarding documents that can be
  ## attached as part of the message, see <ahref="/docs/integration/direct/customer-
  ## disputes/integration-guide/#documents">documents</a>. To send a message, use the
  ## <code>send-message</code> link in the <a
  ## href="/docs/api/reference/api-responses/#hateoas-links/">HATEOAS links</a> of
  ## the <a href="/docs/api/customer-disputes/v1/#disputes_get">show dispute
  ## details</a> response and specify the message in the JSON request body. In case
  ## the link is not present in the response you can't send a message on the dispute.

  let res = await client.httpPOST(fmt"/v1/customer/disputes/{id}/send-message")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.SubsequentAction)
  else:
    raise newException(DisputesClientError, body)

proc postV1CustomerDisputesIdMakeOffer*(client: DisputesClient, id: string,
                                        body: types.MakeOffer): Future[types.SubsequentAction] {.async.} =
  ## Makes an offer to the other party to resolve a dispute, by ID. To make this
  ## call, the stage in the dispute lifecycle must be `INQUIRY`. If the customer
  ## accepts the offer, PayPal automatically makes a refund. Allowed offer_type
  ## values for the request is available in dispute details <ahref="/docs/api/custom
  ## er-disputes/v1/#definition-allowed_response_options">allowed response
  ## options</a> object.

  let res = await client.httpPOST(fmt"/v1/customer/disputes/{id}/make-offer", body)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.SubsequentAction)
  else:
    raise newException(DisputesClientError, body)

proc postV1CustomerDisputesIdAcceptOffer*(client: DisputesClient,
                                          id: string, body: types.AcceptOffer): Future[types.SubsequentAction] {.async.} =
  ## The customer accepts the offer from merchant to resolve a dispute, by ID. PayPal
  ## automatically refunds the amount proposed by merchant to the customer.

  let res = await client.httpPOST(fmt"/v1/customer/disputes/{id}/accept-offer", body)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.SubsequentAction)
  else:
    raise newException(DisputesClientError, body)

proc postV1CustomerDisputesIdDenyOffer*(client: DisputesClient, id: string,
                                        body: types.DenyOffer): Future[types.SubsequentAction] {.async.} =
  ## Denies an offer that the merchant proposes for a dispute, by ID.

  let res = await client.httpPOST(fmt"/v1/customer/disputes/{id}/deny-offer", body)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.SubsequentAction)
  else:
    raise newException(DisputesClientError, body)

proc postV1CustomerDisputesIdAcknowledgeReturnItem*(client: DisputesClient,
                                                    id: string): Future[types.SubsequentAction] {.async.} =
  ## Acknowledges that the customer returned an item for a dispute, by ID. A merchant
  ## can make this request for disputes with the
  ## `MERCHANDISE_OR_SERVICE_NOT_AS_DESCRIBED` reason. Allowed acknowledgement_type
  ## values for the request is available in dispute details <ahref="/docs/api/custom
  ## er-disputes/v1/#definition-allowed_response_options">allowed response
  ## options</a> object. For constraints and rules regarding documents, see <ahref="
  ## /docs/integration/direct/customer-disputes/integration-guide/#documents">documen
  ## ts</a>.

  let res = await client.httpPOST(fmt"/v1/customer/disputes/{id}/acknowledge-return-item")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.SubsequentAction)
  else:
    raise newException(DisputesClientError, body)

proc postV1CustomerDisputesIdProvideSupportingInfo*(client: DisputesClient,
                                                    id: string): Future[types.SubsequentAction] {.async.} =
  ## Provides supporting information for a dispute, by ID. A merchant or buyer can
  ## make this request for disputes if they find the `provide-supporting-info` link
  ## in the HATEOAS links in the list disputes response. The party can provide the
  ## supporting information to PayPal to defend themselves only when the
  ## `dispute_life_cycle_stage` is `CHARGEBACK`, `PRE_ARBITRATION`, or `ARBITRATION`.
  ## They can provide a note that describes their part with details or upload any
  ## supporting documents to support their side. For constraints and rules regarding
  ## documents, see <ahref="/docs/integration/direct/customer-disputes/integration-g
  ## uide/#documents">documents</a>.<br/>To make this request, specify the dispute ID
  ## in the URI and specify the notes in the JSON request body. This method differs
  ## from the provide evidence method which supports only multipart request, where
  ## PayPal asks the concerned party for evidence.

  let res = await client.httpPOST(fmt"/v1/customer/disputes/{id}/provide-supporting-info")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.SubsequentAction)
  else:
    raise newException(DisputesClientError, body)
