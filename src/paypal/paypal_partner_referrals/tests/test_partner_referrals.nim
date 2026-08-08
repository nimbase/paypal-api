# paypal_partner_referrals API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Clue CLI Assistant https://github.com/openpeeps/clue
#
# Generated at: 2026-08-08T21:40:16+03:00
# License: MIT
import std/[asyncdispatch, options, json]
import unittest
import pkg/openparser/json as openjson
import paypal_partner_referrals
import ./common

suite "partner_referrals serialization":
  test "round-trips Error422":
    let obj = newError422()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_partner_referrals.Error422)) == openjson.toJson(obj)

  test "round-trips Error403":
    let obj = newError403()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_partner_referrals.Error403)) == openjson.toJson(obj)

  test "round-trips Error401":
    let obj = newError401()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_partner_referrals.Error401)) == openjson.toJson(obj)

  test "round-trips ReferralData":
    let obj = newReferralData()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_partner_referrals.ReferralData)) == openjson.toJson(obj)

  test "round-trips CreateReferralDataResponse":
    let obj = newCreateReferralDataResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_partner_referrals.CreateReferralDataResponse)) == openjson.toJson(obj)

  test "round-trips ErrorDefault":
    let obj = newErrorDefault()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_partner_referrals.ErrorDefault)) == openjson.toJson(obj)

  test "round-trips 401":
    let obj = new401()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_partner_referrals.Status401)) == openjson.toJson(obj)

  test "round-trips Error500":
    let obj = newError500()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_partner_referrals.Error500)) == openjson.toJson(obj)

  test "round-trips 400":
    let obj = new400()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_partner_referrals.Status400)) == openjson.toJson(obj)

  test "round-trips ReferralDataResponse":
    let obj = newReferralDataResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_partner_referrals.ReferralDataResponse)) == openjson.toJson(obj)

  test "round-trips 422":
    let obj = new422()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_partner_referrals.Status422)) == openjson.toJson(obj)

  test "round-trips 403":
    let obj = new403()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_partner_referrals.Status403)) == openjson.toJson(obj)

  test "round-trips Error400":
    let obj = newError400()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_partner_referrals.Error400)) == openjson.toJson(obj)

suite "partner_referrals endpoints":
  test "POST /v2/customer/partner-referrals":
    let client = initPartnerReferralsClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV2CustomerPartnerReferrals(newReferralData())

  test "GET /v2/customer/partner-referrals/{partner_referral_id}":
    let client = initPartnerReferralsClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getV2CustomerPartnerReferralsPartnerReferralId("test")

