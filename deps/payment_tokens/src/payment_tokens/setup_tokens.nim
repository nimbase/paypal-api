# payment API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Clue CLI Assistant https://github.com/openpeeps/clue
#
# Generated at: 2026-08-08T18:16:14+03:00
# License: MIT
import std/[strformat, options, json]
import ./metaclient
import ./types


proc postV3VaultSetupTokens*(client: PaymentTokensClient,
                             body: types.SetupTokenRequest): Future[types.SetupTokenResponse] {.async.} =
  ## Creates a Setup Token from the given payment source and adds it to the Vault of
  ## the associated customer.

  let res = await client.httpPOST("/v3/vault/setup-tokens", body)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.SetupTokenResponse)
  else:
    raise newException(PaymentTokensClientError, body)

proc getV3VaultSetupTokensId*(client: PaymentTokensClient, id: string): Future[types.SetupTokenResponse] {.async.} =
  ## Returns a readable representation of temporarily vaulted payment source
  ## associated with the setup token id.

  let res = await client.httpGET(fmt"/v3/vault/setup-tokens/{id}")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.SetupTokenResponse)
  else:
    raise newException(PaymentTokensClientError, body)
