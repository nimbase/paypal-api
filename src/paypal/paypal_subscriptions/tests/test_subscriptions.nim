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

suite "subscriptions serialization":
  test "round-trips SubscriptionsCreate400":
    let obj = newSubscriptionsCreate400()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.SubscriptionsCreate400)) == openjson.toJson(obj)

  test "round-trips SubscriptionCancelRequest":
    let obj = newSubscriptionCancelRequest()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.SubscriptionCancelRequest)) == openjson.toJson(obj)

  test "round-trips Error422":
    let obj = newError422()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.Error422)) == openjson.toJson(obj)

  test "round-trips SubscriptionReviseRequest":
    let obj = newSubscriptionReviseRequest()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.SubscriptionReviseRequest)) == openjson.toJson(obj)

  test "round-trips SubscriptionsPatch400":
    let obj = newSubscriptionsPatch400()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.SubscriptionsPatch400)) == openjson.toJson(obj)

  test "round-trips SubscriptionsCapture422":
    let obj = newSubscriptionsCapture422()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.SubscriptionsCapture422)) == openjson.toJson(obj)

  test "round-trips Error403":
    let obj = newError403()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.Error403)) == openjson.toJson(obj)

  test "round-trips SubscriptionsSuspend422":
    let obj = newSubscriptionsSuspend422()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.SubscriptionsSuspend422)) == openjson.toJson(obj)

  test "round-trips Error404":
    let obj = newError404()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.Error404)) == openjson.toJson(obj)

  test "round-trips SubscriptionsCreate422":
    let obj = newSubscriptionsCreate422()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.SubscriptionsCreate422)) == openjson.toJson(obj)

  test "round-trips Subscription":
    let obj = newSubscription()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.Subscription)) == openjson.toJson(obj)

  test "round-trips Error401":
    let obj = newError401()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.Error401)) == openjson.toJson(obj)

  test "round-trips Transaction":
    let obj = newTransaction()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.Transaction)) == openjson.toJson(obj)

  test "round-trips SubscriptionsSuspend400":
    let obj = newSubscriptionsSuspend400()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.SubscriptionsSuspend400)) == openjson.toJson(obj)

  test "round-trips SubscriptionsRevise404":
    let obj = newSubscriptionsRevise404()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.SubscriptionsRevise404)) == openjson.toJson(obj)

  test "round-trips ErrorDefault":
    let obj = newErrorDefault()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.ErrorDefault)) == openjson.toJson(obj)

  test "round-trips SubscriptionsRevise422":
    let obj = newSubscriptionsRevise422()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.SubscriptionsRevise422)) == openjson.toJson(obj)

  test "round-trips SubscriptionSuspendRequest":
    let obj = newSubscriptionSuspendRequest()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.SubscriptionSuspendRequest)) == openjson.toJson(obj)

  test "round-trips SubscriptionsActivate400":
    let obj = newSubscriptionsActivate400()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.SubscriptionsActivate400)) == openjson.toJson(obj)

  test "round-trips 401":
    let obj = new401()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.Status401)) == openjson.toJson(obj)

  test "round-trips Error500":
    let obj = newError500()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.Error500)) == openjson.toJson(obj)

  test "round-trips SubscriptionReviseResponse":
    let obj = newSubscriptionReviseResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.SubscriptionReviseResponse)) == openjson.toJson(obj)

  test "round-trips SubscriptionCaptureRequest":
    let obj = newSubscriptionCaptureRequest()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.SubscriptionCaptureRequest)) == openjson.toJson(obj)

  test "round-trips SubscriptionsPatch422":
    let obj = newSubscriptionsPatch422()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.SubscriptionsPatch422)) == openjson.toJson(obj)

  test "round-trips SubscriptionsCapture400":
    let obj = newSubscriptionsCapture400()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.SubscriptionsCapture400)) == openjson.toJson(obj)

  test "round-trips SubscriptionsTransactions400":
    let obj = newSubscriptionsTransactions400()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.SubscriptionsTransactions400)) == openjson.toJson(obj)

  test "round-trips SubscriptionActivateRequest":
    let obj = newSubscriptionActivateRequest()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.SubscriptionActivateRequest)) == openjson.toJson(obj)

  test "round-trips SubscriptionsRevise400":
    let obj = newSubscriptionsRevise400()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.SubscriptionsRevise400)) == openjson.toJson(obj)

  test "round-trips TransactionsList":
    let obj = newTransactionsList()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.TransactionsList)) == openjson.toJson(obj)

  test "round-trips 403":
    let obj = new403()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.Status403)) == openjson.toJson(obj)

  test "round-trips SubscriptionsCancel400":
    let obj = newSubscriptionsCancel400()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.SubscriptionsCancel400)) == openjson.toJson(obj)

  test "round-trips Error400":
    let obj = newError400()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.Error400)) == openjson.toJson(obj)

  test "round-trips SubscriptionRequestPost":
    let obj = newSubscriptionRequestPost()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.SubscriptionRequestPost)) == openjson.toJson(obj)

  test "round-trips SubscriptionsActivate422":
    let obj = newSubscriptionsActivate422()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.SubscriptionsActivate422)) == openjson.toJson(obj)

  test "round-trips 404":
    let obj = new404()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.Status404)) == openjson.toJson(obj)

  test "round-trips SubscriptionsCancel422":
    let obj = newSubscriptionsCancel422()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_subscriptions.SubscriptionsCancel422)) == openjson.toJson(obj)

suite "subscriptions endpoints":
  test "POST /v1/billing/subscriptions":
    let client = initSubscriptionsClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV1BillingSubscriptions(newSubscriptionRequestPost())

  test "GET /v1/billing/subscriptions/{id}":
    let client = initSubscriptionsClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getV1BillingSubscriptionsId("test", "test")

  test "POST /v1/billing/subscriptions/{id}/revise":
    let client = initSubscriptionsClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV1BillingSubscriptionsIdRevise("test", newSubscriptionReviseRequest())

  test "POST /v1/billing/subscriptions/{id}/suspend":
    let client = initSubscriptionsClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV1BillingSubscriptionsIdSuspend("test", newSubscriptionSuspendRequest())

  test "POST /v1/billing/subscriptions/{id}/cancel":
    let client = initSubscriptionsClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV1BillingSubscriptionsIdCancel("test", newSubscriptionCancelRequest())

  test "POST /v1/billing/subscriptions/{id}/activate":
    let client = initSubscriptionsClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV1BillingSubscriptionsIdActivate("test", newSubscriptionActivateRequest())

  test "POST /v1/billing/subscriptions/{id}/capture":
    let client = initSubscriptionsClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV1BillingSubscriptionsIdCapture("test", newSubscriptionCaptureRequest())

  test "GET /v1/billing/subscriptions/{id}/transactions":
    let client = initSubscriptionsClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getV1BillingSubscriptionsIdTransactions("test", "test", "test")

