# paypal_invoices API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Nimbase CLI https://github.com/nimbase/nimbase
#
# Generated at: 2026-08-09T17:24:06+03:00
# License: MIT
import std/[strformat]
import ./private/metaclient
import ./private/types


proc getV2InvoicingTemplates*(client: InvoicesClient,
                              fields: string = "all", page: int64 = 1,
                              pageSize: int64 = 20): Future[types.Templates] {.async.} =
  ## Lists merchant-created templates with associated details. The associated details
  ## include the emails, addresses, and phone numbers from the user's PayPal
  ## profile.<br/>The user can select which values to show in the business
  ## information section of their template.

  var q = initOrderedTable[string, string]()
  q["fields"] = $fields
  q["page"] = $page
  q["page_size"] = $pageSize
  let res = await client.httpGET("/v2/invoicing/templates", q)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.Templates)
  else:
    raise newException(InvoicesClientError, body)

proc postV2InvoicingTemplates*(client: InvoicesClient,
                               body: types.Template): Future[types.Template] {.async.} =
  ## Creates an invoice template. You can use details from this template to create an
  ## invoice. You can create up to 50 templates.<blockquote><strong>Note:</strong>
  ## Every merchant starts with three PayPal system templates that are optimized for
  ## the unit type billed. The template includes `Quantity`, `Hours`, and
  ## `Amount`.</blockquote>

  let res = await client.httpPOST("/v2/invoicing/templates", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, types.Template)
  else:
    raise newException(InvoicesClientError, body)

proc getV2InvoicingTemplatesTemplateId*(client: InvoicesClient,
                                        templateId: string): Future[types.Template] {.async.} =
  ## Shows details for a template, by ID.

  let res = await client.httpGET(fmt"/v2/invoicing/templates/{templateId}")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.Template)
  else:
    raise newException(InvoicesClientError, body)

proc putV2InvoicingTemplatesTemplateId*(client: InvoicesClient,
                                        templateId: string, body: types.Template): Future[types.Template] {.async.} =
  ## Fully updates a template, by ID. In the JSON request body, include a complete
  ## `template` object. This call does not support partial updates.

  let res = await client.httpPUT(fmt"/v2/invoicing/templates/{templateId}", body)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, types.Template)
  else:
    raise newException(InvoicesClientError, body)

proc deleteV2InvoicingTemplatesTemplateId*(client: InvoicesClient,
                                           templateId: string): Future[AsyncResponse] {.async.} =
  ## Deletes a template, by ID.

  let res = await client.httpDELETE(fmt"/v2/invoicing/templates/{templateId}")
  return res
