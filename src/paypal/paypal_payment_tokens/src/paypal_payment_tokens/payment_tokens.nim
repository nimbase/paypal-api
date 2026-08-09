# paypal_payment_tokens API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Nimbase CLI https://github.com/nimbase/nimbase
#
# Generated at: 2026-08-09T17:24:07+03:00
# License: MIT
import std/[strformat]
import ./private/metaclient
import ./private/types


proc getV3VaultPaymentTokens*(client: PaymentTokensClient,
                              customerId: string, pageSize: int64 = 5,
                              page: int64 = 1, totalRequired: bool = false): Future[types.CustomerVaultPaymentTokensResponse] {.async.} =
  ## Returns all payment tokens for a customer.

  var q = initOrderedTable[string, string]()
  q["customer_id"] = $customerId
  q["page_size"] = $pageSize
  q["page"] = $page
  q["total_required"] = $totalRequired
  let res = await client.httpGET("/v3/vault/payment-tokens", q)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.CustomerVaultPaymentTokensResponse)
  else:
    raise newException(PaymentTokensClientError, body)

proc postV3VaultPaymentTokens*(client: PaymentTokensClient,
                               body: types.PaymentTokenRequest): Future[types.PaymentTokenResponse] {.async.} =
  ## Creates a Payment Token from the given payment source and adds it to the Vault
  ## of the associated customer.

  let res = await client.httpPOST("/v3/vault/payment-tokens", body)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.PaymentTokenResponse)
  else:
    raise newException(PaymentTokensClientError, body)

proc getV3VaultPaymentTokensId*(client: PaymentTokensClient, id: string): Future[types.PaymentTokenResponse] {.async.} =
  ## Returns a readable representation of vaulted payment source associated with the
  ## payment token id.

  let res = await client.httpGET(fmt"/v3/vault/payment-tokens/{id}")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.PaymentTokenResponse)
  else:
    raise newException(PaymentTokensClientError, body)

proc deleteV3VaultPaymentTokensId*(client: PaymentTokensClient, id: string): Future[AsyncResponse] {.async.} =
  ## Delete the payment token associated with the payment token id.

  let res = await client.httpDELETE(fmt"/v3/vault/payment-tokens/{id}")
  return res
