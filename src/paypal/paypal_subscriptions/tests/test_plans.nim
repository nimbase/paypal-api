# subscriptions API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Clue CLI Assistant https://github.com/openpeeps/clue
#
# Generated at: 2026-08-08T20:42:34+03:00
# License: MIT
import std/[asyncdispatch, options, json]
import unittest
import pkg/openparser/json as openjson
import paypal_subscriptions
import ./common

suite "plans serialization":
  test "round-trips Error422":
    let obj = newError422()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.Error422)) == openjson.toJson(obj)

  test "round-trips PlansActivate422":
    let obj = newPlansActivate422()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.PlansActivate422)) == openjson.toJson(obj)

  test "round-trips PlansUpdatePricingSchemes400":
    let obj = newPlansUpdatePricingSchemes400()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.PlansUpdatePricingSchemes400)) == openjson.toJson(obj)

  test "round-trips PlansPatch422":
    let obj = newPlansPatch422()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.PlansPatch422)) == openjson.toJson(obj)

  test "round-trips Error403":
    let obj = newError403()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.Error403)) == openjson.toJson(obj)

  test "round-trips Error404":
    let obj = newError404()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.Error404)) == openjson.toJson(obj)

  test "round-trips Error401":
    let obj = newError401()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.Error401)) == openjson.toJson(obj)

  test "round-trips Plan":
    let obj = newPlan()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.Plan)) == openjson.toJson(obj)

  test "round-trips PlanCollection":
    let obj = newPlanCollection()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.PlanCollection)) == openjson.toJson(obj)

  test "round-trips UpdatePricingSchemesListRequest":
    let obj = newUpdatePricingSchemesListRequest()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.UpdatePricingSchemesListRequest)) == openjson.toJson(obj)

  test "round-trips ErrorDefault":
    let obj = newErrorDefault()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.ErrorDefault)) == openjson.toJson(obj)

  test "round-trips PlanRequestPOST":
    let obj = newPlanRequestPOST()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.PlanRequestPOST)) == openjson.toJson(obj)

  test "round-trips 401":
    let obj = new401()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.Status401)) == openjson.toJson(obj)

  test "round-trips Error500":
    let obj = newError500()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.Error500)) == openjson.toJson(obj)

  test "round-trips 400":
    let obj = new400()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.Status400)) == openjson.toJson(obj)

  test "round-trips PlansPatch400":
    let obj = newPlansPatch400()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.PlansPatch400)) == openjson.toJson(obj)

  test "round-trips PlansUpdatePricingSchemes422":
    let obj = newPlansUpdatePricingSchemes422()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.PlansUpdatePricingSchemes422)) == openjson.toJson(obj)

  test "round-trips 422":
    let obj = new422()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.Status422)) == openjson.toJson(obj)

  test "round-trips 403":
    let obj = new403()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.Status403)) == openjson.toJson(obj)

  test "round-trips PlansDeactivate422":
    let obj = newPlansDeactivate422()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.PlansDeactivate422)) == openjson.toJson(obj)

  test "round-trips PlansCreate400":
    let obj = newPlansCreate400()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.PlansCreate400)) == openjson.toJson(obj)

  test "round-trips Error400":
    let obj = newError400()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.Error400)) == openjson.toJson(obj)

  test "round-trips 404":
    let obj = new404()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.Status404)) == openjson.toJson(obj)

suite "plans endpoints":
  test "GET /v1/billing/plans":
    let client = initSubscriptionsClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getV1BillingPlans("test", 1, 1, true)

  test "POST /v1/billing/plans":
    let client = initSubscriptionsClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV1BillingPlans(newPlanRequestPOST())

  test "GET /v1/billing/plans/{id}":
    let client = initSubscriptionsClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getV1BillingPlansId("test")

  test "POST /v1/billing/plans/{id}/activate":
    let client = initSubscriptionsClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV1BillingPlansIdActivate("test")

  test "POST /v1/billing/plans/{id}/deactivate":
    let client = initSubscriptionsClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV1BillingPlansIdDeactivate("test")

  test "POST /v1/billing/plans/{id}/update-pricing-schemes":
    let client = initSubscriptionsClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV1BillingPlansIdUpdatePricingSchemes("test", newUpdatePricingSchemesListRequest())

