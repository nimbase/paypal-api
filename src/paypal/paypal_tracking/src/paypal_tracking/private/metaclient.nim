# paypal_tracking API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# using the awesome [Nimbase CLI](https://github.com/nimbase/nimbase)
#
# Generated at: 2026-08-08T23:21:34+03:00
# License: MIT

import std/[asyncdispatch, httpclient, tables,
        strutils, sequtils, times, uri, options]

import pkg/oauth2
import pkg/openparser/json


export asyncdispatch, httpclient, json, options, times, oauth2, tables, sequtils

type
  TrackingClient* = ref object of RootObj
    baseUri*: string
    httpClient*: AsyncHttpClient
    accessToken*: Option[string]
    refreshToken*: Option[string]
    tokenExpiry*: Option[int]
    oauthClientId*: Option[string]
    oauthClientSecret*: Option[string]

  QueryTable* = OrderedTable[string, string]

  TrackingClientError* = object of CatchableError

const
  oauthTokenUrl* = "/v1/oauth2/token"
  oauthAuthUrl* = ""

proc `$`*(query: QueryTable): string =
  if query.len > 0:
    add result, "?"
    add result, join(query.keys.toSeq.mapIt(it & "=" & query[it]), "&")

proc initTrackingClient*: TrackingClient =
  new(result)
  result.baseUri = "https://api-m.sandbox.paypal.com/"
  result.httpClient = newAsyncHttpClient()
  result.httpClient.headers = newHttpHeaders({
    "Accept": "application/json"
  })

proc configureOAuth*(client: TrackingClient, clientId, clientSecret: string) =
  client.oauthClientId = some(clientId)
  client.oauthClientSecret = some(clientSecret)

proc setTokens*(client: TrackingClient, accessToken, refreshToken: string,
                expiresIn: Option[int] = none(int)) =
  client.accessToken = some(accessToken)
  if refreshToken.len > 0:
    client.refreshToken = some(refreshToken)
  client.tokenExpiry = expiresIn

proc canAutoRefresh*(client: TrackingClient): bool =
  client.refreshToken.isSome and
    client.oauthClientId.isSome and
    client.oauthClientSecret.isSome and
    oauthTokenUrl.len > 0

proc tryRefreshToken*(client: TrackingClient): Future[bool] {.async.} =
  if not client.canAutoRefresh:
    return false
  let resp = await refreshToken(
    client.httpClient,
    oauthTokenUrl,
    client.oauthClientId.get,
    client.oauthClientSecret.get,
    client.refreshToken.get
  )
  let body = await resp.body
  let json = parseJson(body)
  if not json.hasKey("access_token"):
    return false
  let newAccessToken = json["access_token"].getStr()
  let newRefreshToken =
    if json.hasKey("refresh_token"): json["refresh_token"].getStr()
    else: client.refreshToken.get
  client.setTokens(newAccessToken, newRefreshToken)
  return true

proc getAuthorizationUrl*(clientId, redirectUri: string,
                          scopes: openArray[string] = [],
                          state = ""): string =
  result = oauthAuthUrl & "?" &
    "client_id=" & clientId.encodeUrl & "&" &
    "redirect_uri=" & redirectUri.encodeUrl & "&" &
    "response_type=code"
  if scopes.len > 0:
    result.add("&scope=" & scopes.join(" ").encodeUrl)
  if state.len > 0:
    result.add("&state=" & state.encodeUrl)

proc exchangeCodeForToken*(clientId, clientSecret, code, redirectUri: string): Future[JsonNode] {.async.} =
  var http = newAsyncHttpClient()
  http.headers = newHttpHeaders({
    "Accept": "application/json",
    "Content-Type": "application/x-www-form-urlencoded"
  })
  let body =
    "client_id=" & clientId.encodeUrl &
    "&client_secret=" & clientSecret.encodeUrl &
    "&code=" & code.encodeUrl &
    "&grant_type=authorization_code" &
    "&redirect_uri=" & redirectUri.encodeUrl
  let resp = await http.post(oauthTokenUrl, body)
  result = parseJson(await resp.body)

proc authRequest(client: TrackingClient) =
  if client.accessToken.isSome:
    client.httpClient.headers["Authorization"] = "Bearer " & client.accessToken.get

proc httpGet*(client: TrackingClient,
  endpoint: string): Future[AsyncResponse] {.async.} =
  client.authRequest
  let url = client.baseUri & endpoint
  result = await client.httpClient.get(url)
  if result.code == Http401 and await client.tryRefreshToken:
    client.authRequest
    result = await client.httpClient.get(url)

proc httpGet*(client: TrackingClient,
  endpoint: string, query: QueryTable): Future[AsyncResponse] {.async.} =
  client.authRequest
  let url = client.baseUri & endpoint & $query
  result = await client.httpClient.get(url)
  if result.code == Http401 and await client.tryRefreshToken:
    client.authRequest
    result = await client.httpClient.get(url)

proc httpPost*[T](client: TrackingClient,
  endpoint: string, body: T): Future[AsyncResponse] {.async.} =
  client.authRequest
  let url = client.baseUri & endpoint
  result = await client.httpClient.post(url, toJson(body))
  if result.code == Http401 and await client.tryRefreshToken:
    client.authRequest
    result = await client.httpClient.post(url, toJson(body))

proc httpPost*(client: TrackingClient,
  endpoint: string): Future[AsyncResponse] {.async.} =
  client.authRequest
  let url = client.baseUri & endpoint
  result = await client.httpClient.post(url)
  if result.code == Http401 and await client.tryRefreshToken:
    client.authRequest
    result = await client.httpClient.post(url)

proc httpPost*(client: TrackingClient,
  endpoint: string, query: QueryTable): Future[AsyncResponse] {.async.} =
  client.authRequest
  let url = client.baseUri & endpoint & $query
  result = await client.httpClient.post(url)
  if result.code == Http401 and await client.tryRefreshToken:
    client.authRequest
    result = await client.httpClient.post(url)

proc httpPut*[T](client: TrackingClient,
  endpoint: string, body: T): Future[AsyncResponse] {.async.} =
  client.authRequest
  let url = client.baseUri & endpoint
  result = await client.httpClient.request(url, httpMethod = HttpPut,
    body = toJson(body))
  if result.code == Http401 and await client.tryRefreshToken:
    client.authRequest
    result = await client.httpClient.request(url, httpMethod = HttpPut,
      body = toJson(body))

proc httpPut*(client: TrackingClient,
  endpoint: string): Future[AsyncResponse] {.async.} =
  client.authRequest
  let url = client.baseUri & endpoint
  result = await client.httpClient.request(url, httpMethod = HttpPut)
  if result.code == Http401 and await client.tryRefreshToken:
    client.authRequest
    result = await client.httpClient.request(url, httpMethod = HttpPut)

proc httpPut*(client: TrackingClient,
  endpoint: string, query: QueryTable): Future[AsyncResponse] {.async.} =
  client.authRequest
  let url = client.baseUri & endpoint & $query
  result = await client.httpClient.request(url, httpMethod = HttpPut)
  if result.code == Http401 and await client.tryRefreshToken:
    client.authRequest
    result = await client.httpClient.request(url, httpMethod = HttpPut)

proc httpDelete*[T](client: TrackingClient,
  endpoint: string, body: T): Future[AsyncResponse] {.async.} =
  client.authRequest
  let url = client.baseUri & endpoint
  result = await client.httpClient.request(url, httpMethod = HttpDelete,
    body = toJson(body))
  if result.code == Http401 and await client.tryRefreshToken:
    client.authRequest
    result = await client.httpClient.request(url, httpMethod = HttpDelete,
      body = toJson(body))

proc httpDelete*(client: TrackingClient,
  endpoint: string): Future[AsyncResponse] {.async.} =
  client.authRequest
  let url = client.baseUri & endpoint
  result = await client.httpClient.request(url, httpMethod = HttpDelete)
  if result.code == Http401 and await client.tryRefreshToken:
    client.authRequest
    result = await client.httpClient.request(url, httpMethod = HttpDelete)

proc httpDelete*(client: TrackingClient,
  endpoint: string, query: QueryTable): Future[AsyncResponse] {.async.} =
  client.authRequest
  let url = client.baseUri & endpoint & $query
  result = await client.httpClient.request(url, httpMethod = HttpDelete)
  if result.code == Http401 and await client.tryRefreshToken:
    client.authRequest
    result = await client.httpClient.request(url, httpMethod = HttpDelete)

proc httpPatch*[T](client: TrackingClient,
  endpoint: string, body: T): Future[AsyncResponse] {.async.} =
  client.authRequest
  let url = client.baseUri & endpoint
  result = await client.httpClient.request(url, httpMethod = HttpPatch,
    body = toJson(body))
  if result.code == Http401 and await client.tryRefreshToken:
    client.authRequest
    result = await client.httpClient.request(url, httpMethod = HttpPatch,
      body = toJson(body))

proc httpPatch*(client: TrackingClient,
  endpoint: string): Future[AsyncResponse] {.async.} =
  client.authRequest
  let url = client.baseUri & endpoint
  result = await client.httpClient.request(url, httpMethod = HttpPatch)
  if result.code == Http401 and await client.tryRefreshToken:
    client.authRequest
    result = await client.httpClient.request(url, httpMethod = HttpPatch)
