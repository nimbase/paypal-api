# paypal_payment_experience API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Nimbase CLI https://github.com/nimbase/nimbase
#
# Generated at: 2026-08-08T23:06:08+03:00
# License: MIT
import std/[strformat, options, json]
import ./private/metaclient
import ./private/types


proc getV1PaymentExperienceWebProfiles*(client: PaymentExperienceClient): Future[types.WebProfileList] {.async.} =
  ## Lists the latest 20 web experience profiles for a merchant or subject. To show
  ## details for these or additional profiles, you can show web experience profile
  ## details by ID.

  let res = await client.httpGET("/v1/payment-experience/web-profiles")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.WebProfileList)
  else:
    raise newException(PaymentExperienceClientError, body)

proc postV1PaymentExperienceWebProfiles*(client: PaymentExperienceClient,
                                         body: types.WebProfile): Future[types.WebProfile] {.async.} =
  ## Creates a web experience profile. In the JSON request body, specify the profile
  ## name and details.

  let res = await client.httpPOST("/v1/payment-experience/web-profiles", body)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.WebProfile)
  else:
    raise newException(PaymentExperienceClientError, body)

proc getV1PaymentExperienceWebProfilesId*(client: PaymentExperienceClient,
                                          id: string): Future[types.WebProfile] {.async.} =
  ## Shows details for a web experience profile, by ID.

  let res = await client.httpGET(fmt"/v1/payment-experience/web-profiles/{id}")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.WebProfile)
  else:
    raise newException(PaymentExperienceClientError, body)

proc putV1PaymentExperienceWebProfilesId*(client: PaymentExperienceClient,
                                          id: string, body: types.WebProfile): Future[AsyncResponse] {.async.} =
  ## Updates a web experience profile, by ID. In the JSON request body, specify the
  ## profile details. If your request omits any profile parameters, any previously
  ## set values for those parameters are removed.

  let res = await client.httpPUT(fmt"/v1/payment-experience/web-profiles/{id}", body)
  return res

proc deleteV1PaymentExperienceWebProfilesId*(client: PaymentExperienceClient,
                                             id: string): Future[AsyncResponse] {.async.} =
  ## Deletes a web experience profile, by ID.

  let res = await client.httpDELETE(fmt"/v1/payment-experience/web-profiles/{id}")
  return res

proc patchV1PaymentExperienceWebProfilesId*(client: PaymentExperienceClient,
                                            id: string, body: types.PatchRequest): Future[AsyncResponse] {.async.} =
  ## Partially-updates a web experience profile, by ID. In the JSON request body,
  ## specify a patch object, the path of the profile location to update, and a new
  ## value.

  let res = await client.httpPATCH(fmt"/v1/payment-experience/web-profiles/{id}", body)
  return res
