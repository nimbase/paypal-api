# paypal_catalog API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Nimbase CLI https://github.com/nimbase/nimbase
#
# Generated at: 2026-08-08T23:21:33+03:00
# License: MIT
import std/[strformat, options, json]
import ./private/metaclient
import ./private/types


proc getV1CatalogsProducts*(client: CatalogClient, pageSize: int64 = 10,
                            page: int64 = 1, totalRequired: bool = false): Future[types.ProductCollection] {.async.} =
  ## Lists products.

  var q = initOrderedTable[string, string]()
  q["page_size"] = $pageSize
  q["page"] = $page
  q["total_required"] = $totalRequired
  let res = await client.httpGET("/v1/catalogs/products", q)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.ProductCollection)
  else:
    raise newException(CatalogClientError, body)

proc postV1CatalogsProducts*(client: CatalogClient,
                             body: types.ProductRequestPOST): Future[types.Product] {.async.} =
  ## Creates a product.

  let res = await client.httpPOST("/v1/catalogs/products", body)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.Product)
  else:
    raise newException(CatalogClientError, body)

proc getV1CatalogsProductsProductId*(client: CatalogClient,
                                     productId: string): Future[types.Product] {.async.} =
  ## Shows details for a product, by ID.

  let res = await client.httpGET(fmt"/v1/catalogs/products/{productId}")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.Product)
  else:
    raise newException(CatalogClientError, body)

proc patchV1CatalogsProductsProductId*(client: CatalogClient,
                                       productId: string,
                                       body: types.PatchRequest): Future[AsyncResponse] {.async.} =
  ## Updates a product, by ID. You can patch these attributes and
  ## objects:<table><thead><tr><th>Attribute orobject</th><th>Operations</th></tr></
  ## thead><tbody><tr><td><code>description</code></td><td>add, replace,
  ## remove</td></tr><tr><td><code>category</code></td><td>add, replace,
  ## remove</td></tr><tr><td><code>image_url</code></td><td>add, replace,
  ## remove</td></tr><tr><td><code>home_url</code></td><td>add, replace,
  ## remove</td></tr></tbody></table>

  let res = await client.httpPATCH(fmt"/v1/catalogs/products/{productId}", body)
  return res
