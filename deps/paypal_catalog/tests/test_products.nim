# catalog API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Clue CLI Assistant https://github.com/openpeeps/clue
#
# Generated at: 2026-08-08T20:01:02+03:00
# License: MIT
import std/[asyncdispatch, options, json]
import unittest
import pkg/openparser/json as openjson
import paypal_catalog
import ./common

suite "products serialization":
  test "round-trips ProductsPatch400":
    let obj = newProductsPatch400()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_catalog.ProductsPatch400)) == openjson.toJson(obj)

  test "round-trips ProductRequestPOST":
    let obj = newProductRequestPOST()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_catalog.ProductRequestPOST)) == openjson.toJson(obj)

  test "round-trips Error422":
    let obj = newError422()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_catalog.Error422)) == openjson.toJson(obj)

  test "round-trips Error403":
    let obj = newError403()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_catalog.Error403)) == openjson.toJson(obj)

  test "round-trips Error404":
    let obj = newError404()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_catalog.Error404)) == openjson.toJson(obj)

  test "round-trips Error401":
    let obj = newError401()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_catalog.Error401)) == openjson.toJson(obj)

  test "round-trips ErrorDefault":
    let obj = newErrorDefault()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_catalog.ErrorDefault)) == openjson.toJson(obj)

  test "round-trips ProductCollection":
    let obj = newProductCollection()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_catalog.ProductCollection)) == openjson.toJson(obj)

  test "round-trips 401":
    let obj = new401()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_catalog.Status401)) == openjson.toJson(obj)

  test "round-trips Error500":
    let obj = newError500()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_catalog.Error500)) == openjson.toJson(obj)

  test "round-trips ProductsCreate400":
    let obj = newProductsCreate400()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_catalog.ProductsCreate400)) == openjson.toJson(obj)

  test "round-trips ProductsPatch422":
    let obj = newProductsPatch422()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_catalog.ProductsPatch422)) == openjson.toJson(obj)

  test "round-trips Product":
    let obj = newProduct()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_catalog.Product)) == openjson.toJson(obj)

  test "round-trips 400":
    let obj = new400()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_catalog.Status400)) == openjson.toJson(obj)

  test "round-trips 422":
    let obj = new422()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_catalog.Status422)) == openjson.toJson(obj)

  test "round-trips 403":
    let obj = new403()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_catalog.Status403)) == openjson.toJson(obj)

  test "round-trips Error400":
    let obj = newError400()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_catalog.Error400)) == openjson.toJson(obj)

  test "round-trips 404":
    let obj = new404()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), paypal_catalog.Status404)) == openjson.toJson(obj)

suite "products endpoints":
  test "GET /v1/catalogs/products":
    let client = initCatalogClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getV1CatalogsProducts(1, 1, true)

  test "POST /v1/catalogs/products":
    let client = initCatalogClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postV1CatalogsProducts(newProductRequestPOST())

  test "GET /v1/catalogs/products/{product_id}":
    let client = initCatalogClient()
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getV1CatalogsProductsProductId("test")

