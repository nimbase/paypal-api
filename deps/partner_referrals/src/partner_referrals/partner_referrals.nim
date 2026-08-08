# partner API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Clue CLI Assistant https://github.com/openpeeps/clue
#
# Generated at: 2026-08-08T18:16:13+03:00
# License: MIT
import std/[strformat, options, json]
import ./metaclient
import ./types


proc postV2CustomerPartnerReferrals*(client: PartnerReferralsClient,
                                     body: types.ReferralData): Future[types.CreateReferralDataResponse] {.async.} =
  ## Creates a partner referral that is shared by the partner or API caller. The
  ## partner referral is used to onboard the seller, and contains the seller's
  ## personal, business, financial and operations.

  let res = await client.httpPOST("/v2/customer/partner-referrals", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, types.CreateReferralDataResponse)
  else:
    raise newException(PartnerReferralsClientError, body)

proc getV2CustomerPartnerReferralsPartnerReferralId*(client: PartnerReferralsClient,
                                                     partnerReferralId: string): Future[types.ReferralDataResponse] {.async.} =
  ## Shows details by ID for referral data that was shared by the partner or API
  ## caller.

  let res = await client.httpGET(fmt"/v2/customer/partner-referrals/{partnerReferralId}")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.ReferralDataResponse)
  else:
    raise newException(PartnerReferralsClientError, body)
