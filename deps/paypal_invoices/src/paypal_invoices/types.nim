import std/[options, json]

type
  Status400* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  Status403* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  Status422* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  AddressDetails* = ref object of RootObj
    ## The non-portable additional address details that are sometimes needed for
    ## compliance, risk, or other scenarios where fine-grain address information might
    ## be needed. Not portable with common third party and open source. Redundant with
    ## core fields.<br/>For example, `address_portable.address_line_1` is usually a
    ## combination of `address_details.street_number`, `street_name`, and
    ## `street_type`.
    street_number*: Option[string]
      ## The street number.
    street_name*: Option[string]
      ## The street name. Just `Drury` in `Drury Lane`.
    street_type*: Option[string]
      ## The street type. For example, avenue, boulevard, road, or expressway.
    delivery_service*: Option[string]
      ## The delivery service. Post office box, bag number, or post office name.
    building_name*: Option[string]
      ## A named locations that represents the premise. Usually a building name or number
      ## or collection of buildings with a common name or number. For example,
      ## <code>Craven House</code>.
    sub_building*: Option[string]
      ## The first-order entity below a named building or location that represents the
      ## sub-premises. Usually a single building within a collection of buildings with a
      ## common name. Can be a flat, story, floor, room, or apartment.

  AddressPortable* = ref object of RootObj
    ## The portable international postal address. Maps to[AddressValidationMetadata](h
    ## ttps://github.com/googlei18n/libaddressinput/wiki/AddressValidationMetadata) and
    ## HTML 5.1 [Autofilling form controls: the autocompleteattribute](https://www.w3.
    ## org/TR/html51/sec-forms.html#autofilling-form-controls-the-autocomplete-attribut
    ## e).
    address_line_1*: Option[string]
      ## The first line of the address. For example, number or street. For example, `173
      ## Drury Lane`. Required for data entry and compliance and risk checks. Must
      ## contain the full address.
    address_line_2*: Option[string]
      ## The second line of the address. For example, suite or apartment number.
    address_line_3*: Option[string]
      ## The third line of the address, if needed. For example, a street complement for
      ## Brazil, direction text, such as `next to Walmart`, or a landmark in an Indian
      ## address.
    admin_area_4*: Option[string]
      ## The neighborhood, ward, or district. Smaller than `admin_area_level_3` or
      ## `sub_locality`. Value is:<ul><li>The postal sorting code for Guernsey and many
      ## French territories, such as French Guiana.</li><li>The fine-grained
      ## administrative levels in China.</li></ul>
    admin_area_3*: Option[string]
      ## A sub-locality, suburb, neighborhood, or district. Smaller than
      ## `admin_area_level_2`. Value is:<ul><li>Brazil. Suburb, bairro, or
      ## neighborhood.</li><li>India. Sub-locality or district. Street name information
      ## is not always available but a sub-locality or district can be a very small
      ## area.</li></ul>
    admin_area_2*: Option[string]
      ## A city, town, or village. Smaller than `admin_area_level_1`.
    admin_area_1*: Option[string]
      ## The highest level sub-division in a country, which is usually a province, state,
      ## or ISO-3166-2 subdivision. Format for postal delivery. For example, `CA` and not
      ## `California`. Value, by country, is:<ul><li>UK. A county.</li><li>US. A
      ## state.</li><li>Canada. A province.</li><li>Japan. A
      ## prefecture.</li><li>Switzerland. A kanton.</li></ul>
    postal_code*: Option[string]
      ## The postal code, which is the zip code or equivalent. Typically required for
      ## countries with a postal code or an equivalent. See [postal
      ## code](https://en.wikipedia.org/wiki/Postal_code).
    country_code*: CountryCode
    address_details*: Option[AddressDetails]

  AddressPortableList* = seq[AddressPortable]

  AggregatedDiscount* = ref object of RootObj
    ## The discount. Can be an item- or invoice-level discount, or both. Can be applied
    ## as a percent or amount. If you provide both amount and percent, amount takes
    ## precedent.
    invoice_discount*: Option[Discount]
    item_discount*: Option[Money]

  AmountRange* = ref object of RootObj
    ## The amount range.
    lower_amount*: Money
    upper_amount*: Money

  AmountSummaryDetail* = ref object of RootObj
    ## The invoice amount summary of item total, discount, tax total, and shipping.
    currency_code*: Option[CurrencyCode]
    value*: Option[string]
      ## The value, which might be:<ul><li>An integer for currencies like `JPY` that are
      ## not typically fractional.</li><li>A decimal fraction for currencies like `TND`
      ## that are subdivided into thousandths.</li></ul>For the required number of
      ## decimal places for a currency code, see [Currency
      ## Codes](/docs/integration/direct/rest/currency-codes/).
    breakdown*: Option[AmountWithBreakdown]

  AmountWithBreakdown* = ref object of RootObj
    ## The breakdown of the amount. Includes total item amount, total tax amount,
    ## custom amount, and shipping and discounts, if any.
    item_total*: Option[Money]
    discount*: Option[AggregatedDiscount]
    tax_total*: Option[Money]
    shipping*: Option[ShippingCost]
    custom*: Option[CustomAmount]

  BillingInfo* = ref object of RootObj
    ## The billing information of the invoice recipient. Includes name, address, email,
    ## phone, and language.
    business_name*: Option[string]
      ## Required. The business name of the party.
    name*: Option[Name]
    address*: Option[AddressPortable]
    email_address*: Option[RestrictiveEmailAddress]
    phones*: Option[DefinitionsPhoneDetailList]
    additional_info*: Option[string]
      ## Any additional information about the recipient.
    language*: Option[Language]

  BusinessName* = ref object of RootObj
    ## The business name of the party.
    business_name*: Option[string]
      ## Required. The business name of the party.

  Configuration* = ref object of RootObj
    ## The invoice configuration details. Includes partial payment, tip, and tax
    ## calculated after discount.
    tax_calculated_after_discount*: Option[bool]
      ## Indicates whether the tax is calculated before or after a discount. If `false`,
      ## the tax is calculated before a discount. If `true`, the tax is calculated after
      ## a discount.
    tax_inclusive*: Option[bool]
      ## Indicates whether the unit price includes tax.
    allow_tip*: Option[bool]
      ## Indicates whether the invoice enables the customer to enter a tip amount during
      ## payment. If `true`, the invoice shows a tip amount field so that the customer
      ## can enter a tip amount. If `false`, the invoice does not show a tip amount
      ## field.<blockquote><strong>Note:</strong> This feature is not available for users
      ## in `Hong Kong`, `Taiwan`, `India`, or `Japan`.</blockquote>
    partial_payment*: Option[PartialPayment]
    has_conditional_rule*: Option[bool]
      ## Indicates whether conditional pricing rules are applied to the invoice. If
      ## `true`, pricing rules (such as discounts or surcharges based on specific
      ## conditions) are applied. If `false`, no conditional pricing rules are applied.
    template_id*: Option[string]
      ## The template ID. The template determines the layout of the invoice. Includes
      ## which fields to show and hide.<blockquote><strong>Note:</strong> This is an
      ## optional field. If you wish to customize the invoice layout using a specific
      ## template, provide a valid template ID here. You can either use an existing
      ## template ID or create a new template via the create template API and then use
      ## the newly created template's ID.</blockquote>

  Connection* = ref object of RootObj
    ## This lists last sync status and connection platform name.
    platform_name*: Option[string]
      ## The name of the platform. This property supports Unicode. The pattern is not
      ## provided because the value is defined by an external party.
    last_sync_time*: Option[DateTime]
    last_sync_status*: Option[string]
      ## The status of the last sync. This property supports Unicode.

  ConnectionList* = seq[Connection]

  Connections* = ref object of RootObj
    ## This object contains an array of connection details. It is used to load sync
    ## status for a user.
    connections*: Option[ConnectionList]

  ConnectionsList* = seq[Connections]

  ContactNameAddress* = ref object of RootObj
    ## The contact information of the user. Includes name and address.
    business_name*: Option[string]
      ## Required. The business name of the party.
    name*: Option[Name]
    address*: Option[AddressPortable]

  CountryCode* = string

  CurrencyCode* = string

  CustomAmount* = ref object of RootObj
    ## The custom amount to apply to an invoice. If you include a label, you must
    ## include a custom amount.
    label*: string
      ## The label to the custom amount of the invoice.
    amount*: Option[Money]

  DateNoTime* = string

  DateRange* = ref object of RootObj
    ## The date range. Filters invoices by creation date, invoice date, due date, and
    ## payment date.
    start*: DateNoTime
    `end`*: DateNoTime

  DateTime* = string

  DateTimeRange* = ref object of RootObj
    ## The date and time range. Filters invoices by creation date, invoice date, due
    ## date, and payment date.
    start*: DateTime
    `end`*: DateTime

  DefinitionsItemList* = seq[Item]

  DefinitionsPhoneDetailList* = seq[PhoneDetail]

  DefinitionsRecipientInfoList* = seq[RecipientInfo]

  Detail* = ref object of RootObj
    ## The details of the invoice like notes, terms and conditions, memo, attachments.
    reference*: Option[string]
      ## The reference data. Includes a Purchase Order (PO) number.
    currency_code*: CurrencyCode
    note*: Option[string]
      ## A note to the invoice recipient. Also appears on the invoice notification email.
    terms_and_conditions*: Option[string]
      ## The general terms of the invoice. Can include return or cancellation policy and
      ## other terms and conditions.
    memo*: Option[string]
      ## A private bookkeeping memo for the user.
    attachments*: Option[FileReferenceList]

  Discount* = ref object of RootObj
    ## The discount as a percent or amount at invoice level. The invoice discount
    ## amount is subtracted from the item total.
    percent*: Option[Percentage]
    amount*: Option[Money]

  EmailAddress* = string

  EmailAddressList* = seq[EmailAddress]

  Error400* = ref object of RootObj
    ## Request is not well-formed, syntactically incorrect, or violates schema.
    name*: Option[string]
    message*: Option[string]
    details*: Option[seq[ErrorDetails]]
    debug_id*: Option[string]
      ## The PayPal internal ID. Used for correlation purposes.
    links*: Option[seq[ErrorLinkDescription]]
      ## An array of request-related [HATEOAS
      ## links](https://en.wikipedia.org/wiki/HATEOAS).

  Error401* = ref object of RootObj
    ## Authentication failed due to missing Authorization header, or invalid
    ## authentication credentials.
    name*: Option[string]
    message*: Option[string]
    details*: Option[seq[ErrorDetails]]
    debug_id*: Option[string]
      ## The PayPal internal ID. Used for correlation purposes.
    links*: Option[seq[ErrorLinkDescription]]
      ## An array of request-related [HATEOAS
      ## links](https://en.wikipedia.org/wiki/HATEOAS).

  Error403* = ref object of RootObj
    ## The client is not authorized to access this resource, although it may have valid
    ## credentials.
    name*: Option[string]
    message*: Option[string]
    details*: Option[seq[ErrorDetails]]
    debug_id*: Option[string]
      ## The PayPal internal ID. Used for correlation purposes.
    links*: Option[seq[ErrorLinkDescription]]
      ## An array of request-related [HATEOAS
      ## links](https://en.wikipedia.org/wiki/HATEOAS).

  Error404* = ref object of RootObj
    ## The server has not found anything matching the request URI. This either means
    ## that the URI is incorrect or the resource is not available.
    name*: Option[string]
    message*: Option[string]
    details*: Option[seq[ErrorDetails]]
    debug_id*: Option[string]
      ## The PayPal internal ID. Used for correlation purposes.
    links*: Option[seq[ErrorLinkDescription]]
      ## An array of request-related [HATEOAS
      ## links](https://en.wikipedia.org/wiki/HATEOAS).

  Error409* = ref object of RootObj
    ## The server has detected a conflict while processing this request.
    name*: Option[string]
    message*: Option[string]
    details*: Option[seq[ErrorDetails]]
    debug_id*: Option[string]
      ## The PayPal internal ID. Used for correlation purposes.
    links*: Option[seq[ErrorLinkDescription]]
      ## An array of request-related [HATEOAS
      ## links](https://en.wikipedia.org/wiki/HATEOAS).

  Error415* = ref object of RootObj
    ## The server does not support the request payload's media type.
    name*: Option[string]
    message*: Option[string]
    details*: Option[seq[ErrorDetails]]
    debug_id*: Option[string]
      ## The PayPal internal ID. Used for correlation purposes.
    links*: Option[seq[ErrorLinkDescription]]
      ## An array of request-related [HATEOAS
      ## links](https://en.wikipedia.org/wiki/HATEOAS).

  Error422* = ref object of RootObj
    ## The requested action cannot be performed and may require interaction with APIs
    ## or processes outside of the current request. This is distinct from a 500
    ## response in that there are no systemic problems limiting the API from performing
    ## the request.
    name*: Option[string]
    message*: Option[string]
    details*: Option[seq[ErrorDetails]]
    debug_id*: Option[string]
      ## The PayPal internal ID. Used for correlation purposes.
    links*: Option[seq[ErrorLinkDescription]]
      ## An array of request-related [HATEOAS
      ## links](https://en.wikipedia.org/wiki/HATEOAS).

  Error500* = ref object of RootObj
    ## This is either a system or application error, and generally indicates that
    ## although the client appeared to provide a correct request, something unexpected
    ## has gone wrong on the server.
    name*: Option[string]
    message*: Option[string]
    debug_id*: Option[string]
      ## The PayPal internal ID. Used for correlation purposes.
    links*: Option[seq[ErrorLinkDescription]]
      ## An array of request-related [HATEOAS
      ## links](https://en.wikipedia.org/wiki/HATEOAS).

  Error503* = ref object of RootObj
    ## The server is temporarily unable to handle the request, for example, because of
    ## planned maintenance or downtime.
    name*: Option[string]
    message*: Option[string]
    debug_id*: Option[string]
      ## The PayPal internal ID. Used for correlation purposes.
    links*: Option[seq[ErrorLinkDescription]]
      ## An array of request-related [HATEOAS
      ## links](https://en.wikipedia.org/wiki/HATEOAS).

  ErrorDefault* = ref object of RootObj
    ## The default error response.

  ErrorDetails* = ref object of RootObj
    ## The error details. Required for client-side `4XX` errors.
    field*: Option[string]
      ## The field that caused the error. If this field is in the body, set this value to
      ## the field's JSON pointer value. Required for client-side errors.
    value*: Option[string]
      ## The value of the field that caused the error.
    location*: Option[ErrorLocation]
    issue*: string
      ## The unique, fine-grained application-level error code.
    description*: Option[string]
      ## The human-readable description for an issue. The description can change over the
      ## lifetime of an API, so clients must not depend on this value.

  ErrorLinkDescription* = ref object of RootObj
    ## The request-related [HATEOAS link](/api/rest/responses/#hateoas-links)
    ## information.
    href*: string
      ## The complete target URL. To make the related call, combine the method with this
      ## [URI Template-formatted](https://tools.ietf.org/html/rfc6570) link. For
      ## pre-processing, include the `$`, `(`, and `)` characters. The `href` is the key
      ## HATEOAS component that links a completed call with a subsequent call.
    rel*: string
      ## The [link relation type](https://tools.ietf.org/html/rfc5988#section-4), which
      ## serves as an ID for a link that unambiguously describes the semantics of the
      ## link. See [LinkRelations](https://www.iana.org/assignments/link-relations/link-
      ## relations.xhtml).
    `method`*: Option[string]
      ## The HTTP method required to make the related call.

  ErrorLocation* = enum
    ## The location of the field that caused the error. Value is `body`, `path`, or
    ## `query`.
    body = "body"
    path = "path"
    query = "query"

  Fetchtype* = ref object of RootObj
    ## Is the fetch type invoice number or id.
    fetch_id*: Option[bool]
      ## Optional to decide the number or ID.

  Fields* = string

  FieldsList* = seq[Fields]

  FileReference* = ref object of RootObj
    ## The file reference. Can be a file in PayPal MediaServ, PayPal DMS, or other
    ## custom store.
    id*: Option[string]
      ## The ID of the referenced file.
    reference_url*: Option[string]
      ## The reference URL for the file.
    content_type*: Option[string]
      ## The [Internet Assigned Numbers Authority (IANA) media type of the
      ## file](https://www.iana.org/assignments/media-types/media-types.xhtml).
    create_time*: Option[DateTime]
    size*: Option[string]
      ## The size of the file, in bytes.

  FileReferenceList* = seq[FileReference]

  Invoice* = ref object of RootObj
    ## The invoice details which includes all information of the invoice like items,
    ## billing information.
    id*: Option[string]
      ## The ID of the invoice.
    parent_id*: Option[string]
      ## The parent ID to an invoice that defines the group invoice to which the invoice
      ## is related.
    status*: Option[InvoiceStatus]
    detail*: InvoiceDetail
    invoicer*: Option[InvoicerInfo]
    primary_recipients*: Option[RecipientInfoList]
    additional_recipients*: Option[EmailAddressList]
    items*: Option[ItemList]
    configuration*: Option[Configuration]
    amount*: Option[AmountSummaryDetail]
    due_amount*: Option[Money]
    gratuity*: Option[Money]
    payments*: Option[Payments]
    refunds*: Option[Refunds]
    links*: Option[LinkDescriptionList]

  InvoiceConnectionDetails* = ref object of RootObj
    ## Returns invoice connection status with timestamp per invoice.
    id*: Option[string]
      ## The ID of the invoice. This property supports Unicode.
    connection_status*: Option[ConnectionsList]

  InvoiceCreationFlow* = enum
    ## The frequency at which the invoice is sent:<ul><li>Multiple recipient. Sent to
    ## multiple recipients.</li><li>Batch. Sent in a batch.</li><li>Regular single.
    ## Sent one time to a single recipient.</li></ul>
    MULTIPLERECIPIENTSGROUP = "MULTIPLE_RECIPIENTS_GROUP"
    BATCH = "BATCH"
    REGULARSINGLE = "REGULAR_SINGLE"

  InvoiceDetail* = ref object of RootObj
    ## The details of the invoice. Includes invoice number, date, payment terms, and
    ## audit metadata.
    reference*: Option[string]
      ## The reference data. Includes a Purchase Order (PO) number.
    currency_code*: CurrencyCode
    note*: Option[string]
      ## A note to the invoice recipient. Also appears on the invoice notification email.
    terms_and_conditions*: Option[string]
      ## The general terms of the invoice. Can include return or cancellation policy and
      ## other terms and conditions.
    memo*: Option[string]
      ## A private bookkeeping memo for the user.
    attachments*: Option[FileReferenceList]
    invoice_number*: Option[string]
      ## The invoice number. Default is the number that is auto-incremented number from
      ## the last number.
    invoice_date*: Option[DateNoTime]
    payment_term*: Option[InvoicePaymentTerm]
    metadata*: Option[Metadata]

  InvoiceList* = seq[Invoice]

  InvoiceNumber* = ref object of RootObj
    ## The invoice number.
    invoice_number*: Option[string]
      ## The invoice number. If you omit this value, the default is the auto-incremented
      ## number from the last number.
    invoice_id*: Option[string]
      ## Resource Id.

  InvoicePaymentTerm* = ref object of RootObj
    ## The payment term of the invoice. Payment can be due upon receipt, a specified
    ## date, or in a set number of days.
    term_type*: Option[PaymentTermType]
    due_date*: Option[DateNoTime]

  InvoiceStatus* = enum
    ## The status of the invoice.
    DRAFT = "DRAFT"
    SENT = "SENT"
    SCHEDULED = "SCHEDULED"
    PAID = "PAID"
    MARKEDASPAID = "MARKED_AS_PAID"
    CANCELLED = "CANCELLED"
    REFUNDED = "REFUNDED"
    PARTIALLYPAID = "PARTIALLY_PAID"
    PARTIALLYREFUNDED = "PARTIALLY_REFUNDED"
    MARKEDASREFUNDED = "MARKED_AS_REFUNDED"
    UNPAID = "UNPAID"
    PAYMENTPENDING = "PAYMENT_PENDING"
    AUTOCANCELLED = "AUTO_CANCELLED"
    PAIDEXTERNAL = "PAID_EXTERNAL"
    REFUNDEDEXTERNAL = "REFUNDED_EXTERNAL"
    SHARED = "SHARED"

  InvoiceStatusList* = seq[InvoiceStatus]

  InvoicerInfo* = ref object of RootObj
    ## The invoicer business information that appears on the invoice.
    business_name*: Option[string]
      ## Required. The business name of the party.
    name*: Option[Name]
    address*: Option[AddressPortable]
    email_address*: Option[RestrictiveEmailAddress]
    phones*: Option[PhoneDetailList]
    website*: Option[string]
      ## The invoicer's website.
    tax_id*: Option[string]
      ## The invoicer's tax ID.
    additional_notes*: Option[string]
      ## Any additional information. Includes business hours.
    logo_url*: Option[string]
      ## The full URL to an external logo image. The logo image must not be larger than
      ## 250 pixels wide by 90 pixels high.

  Invoices* = ref object of RootObj
    ## An array of merchant paypal_invoices. Includes the total invoices count and [HATEOAS
    ## links](/docs/api/reference/api-responses/#hateoas-links) for navigation.
    total_pages*: Option[int64]
      ## The total number of pages that are available for the search criteria.
      ## <blockquote><strong>Note:</strong> Clients MUST NOT assume that the value of
      ## total_pages is constant. The value MAY change from one request to the
      ## next</blockquote>
    total_items*: Option[int64]
      ## The total number of invoices that match the search
      ## criteria.<blockquote><strong>Note:</strong> Clients MUST NOT assume that the
      ## value of <code>total_items</code> is constant. The value MAY change from one
      ## request to the next.</blockquote>
    items*: Option[InvoiceList]
    links*: Option[LinkDescriptionList]

  InvoicesCancel400* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  InvoicesCancel422* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  InvoicesCreate400* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  InvoicesGenerateQrCode400* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  InvoicesPayments400* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  InvoicesPayments422* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  InvoicesPaymentsDelete422* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  InvoicesRefunds400* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  InvoicesRefunds422* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  InvoicesRemind400* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  InvoicesRemind422* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  InvoicesSearchInvoices400* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  InvoicesUpdate400* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  InvoicesUpdate422* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  Item* = ref object of RootObj
    ## An array of invoice line item information. The maximum items for an invoice is
    ## `100`.
    id*: Option[string]
      ## The ID of the invoice line item.
    name*: string
      ## The item name for the invoice line item.
    description*: Option[string]
      ## The item description for the invoice line item.
    quantity*: string
      ## The quantity of the item that the invoicer provides to the payer. Value is from
      ## `-1000000` to `1000000`. Supports up to five decimal places.
    unit_amount*: Money
    tax*: Option[Tax]
    item_date*: Option[DateNoTime]
    discount*: Option[Discount]
    unit_of_measure*: Option[UnitOfMeasure]

  ItemList* = seq[Item]

  Language* = string

  LinkDescription* = ref object of RootObj
    ## The request-related [HATEOAS link](/api/rest/responses/#hateoas-links)
    ## information.
    href*: string
      ## The complete target URL. To make the related call, combine the method with this
      ## [URI Template-formatted](https://tools.ietf.org/html/rfc6570) link. For
      ## pre-processing, include the `$`, `(`, and `)` characters. The `href` is the key
      ## HATEOAS component that links a completed call with a subsequent call.
    rel*: string
      ## The [link relation type](https://tools.ietf.org/html/rfc5988#section-4), which
      ## serves as an ID for a link that unambiguously describes the semantics of the
      ## link. See [LinkRelations](https://www.iana.org/assignments/link-relations/link-
      ## relations.xhtml).
    `method`*: Option[string]
      ## The HTTP method required to make the related call.

  LinkDescriptionList* = seq[LinkDescription]

  Metadata* = ref object of RootObj
    ## The audit metadata. Captures all invoicing actions on create, send, update, and
    ## cancel.
    create_time*: Option[DateTime]
    created_by*: Option[string]
      ## The email address of the account that created the resource.
    last_update_time*: Option[DateTime]
    last_updated_by*: Option[string]
      ## The email address of the account that last edited the resource.
    cancel_time*: Option[DateTime]
    cancelled_by*: Option[string]
      ## The actor who canceled the resource.
    first_sent_time*: Option[DateTime]
    last_sent_time*: Option[DateTime]
    last_sent_by*: Option[string]
      ## The email address of the account that last sent the resource.
    created_by_flow*: Option[InvoiceCreationFlow]
    recipient_view_url*: Option[string]
      ## The URL for the invoice payer view hosted on paypal.com.
    invoicer_view_url*: Option[string]
      ## The URL for the invoice merchant view hosted on paypal.com.

  Money* = ref object of RootObj
    ## The currency and amount for a financial transaction, such as a balance or
    ## payment due.
    currency_code*: CurrencyCode
    value*: string
      ## The value, which might be:<ul><li>An integer for currencies like `JPY` that are
      ## not typically fractional.</li><li>A decimal fraction for currencies like `TND`
      ## that are subdivided into thousandths.</li></ul>For the required number of
      ## decimal places for a currency code, see [Currency
      ## Codes](/api/rest/reference/currency-codes/).

  Name* = ref object of RootObj
    ## The name of the party.
    prefix*: Option[string]
      ## The prefix, or title, to the party's name.
    given_name*: Option[string]
      ## When the party is a person, the party's given, or first, name.
    surname*: Option[string]
      ## When the party is a person, the party's surname or family name. Also known as
      ## the last name. Required when the party is a person. Use also to store multiple
      ## surnames including the matronymic, or mother's, surname.
    middle_name*: Option[string]
      ## When the party is a person, the party's middle name. Use also to store multiple
      ## middle names including the patronymic, or father's, middle name.
    suffix*: Option[string]
      ## The suffix for the party's name.
    alternate_full_name*: Option[string]
      ## DEPRECATED. The party's alternate name. Can be a business name, nickname, or any
      ## other name that cannot be split into first, last name. Required when the party
      ## is a business.
    full_name*: Option[string]
      ## When the party is a person, the party's full name.

  Notification* = ref object of RootObj
    ## The email or SMS notification to send to the invoicer or payer on sending an
    ## invoice.
    subject*: Option[string]
      ## The subject of the email that is sent as a notification to the
      ## recipient.<blockquote><strong>Note:</strong> User-provided values for this field
      ## will not be honored and the subject will always be defaulted to a system-defined
      ## value.</blockquote>
    note*: Option[string]
      ## A note to the payer.<blockquote><strong>Note:</strong> User-provided values for
      ## this field will not be honored and the note will always be defaulted to a
      ## system-defined value.</blockquote>
    send_to_invoicer*: Option[bool]
      ## Indicates whether to send a copy of the email to the merchant.
    send_to_recipient*: Option[bool]
      ## Indicates whether to send a copy of the email to the recipient.
    additional_recipients*: Option[EmailAddressList]

  PartialPayment* = ref object of RootObj
    ## The partial payment details. Includes the minimum amount that the invoicer
    ## expects from the payer.
    allow_partial_payment*: Option[bool]
      ## Indicates whether the invoice allows a partial payment. If `false`, the invoice
      ## must be paid in full. If `true`, the invoice allows partial
      ## payments.<blockquote><strong>Note:</strong> This feature is not available for
      ## users in `India`, `Brazil`, or `Israel`.</blockquote>
    minimum_amount_due*: Option[Money]

  PaymentDetail* = ref object of RootObj
    ## The payment details of the invoice. Includes payment type, method, date,
    ## discount, and transaction type.
    `type`*: Option[PaymentType]
    payment_id*: Option[string]
      ## The ID for a PayPal payment transaction. Required for the `PAYPAL` payment type.
    payment_date*: Option[DateNoTime]
    `method`*: PaymentMethod
    note*: Option[string]
      ## A note associated with an external cash or check payment.
    amount*: Option[Money]
    shipping_info*: Option[ContactNameAddress]

  PaymentDetailList* = seq[PaymentDetail]

  PaymentMethod* = enum
    ## The payment mode or method through which the invoicer can accept the payments.
    BANKTRANSFER = "BANK_TRANSFER"
    CASH = "CASH"
    CHECK = "CHECK"
    CREDITCARD = "CREDIT_CARD"
    DEBITCARD = "DEBIT_CARD"
    PAYPAL = "PAYPAL"
    WIRETRANSFER = "WIRE_TRANSFER"
    OTHER = "OTHER"

  PaymentReference* = ref object of RootObj
    ## The reference to the payment detail.
    payment_id*: Option[string]
      ## The ID for the invoice payment.

  PaymentTerm* = ref object of RootObj
    ## The payment term of the invoice. Payment can be due upon receipt, a specified
    ## date, or in a set number of days.
    term_type*: Option[PaymentTermType]

  PaymentTermType* = enum
    ## The payment term. Payment can be due upon receipt, a specified date, or in a set
    ## number of days.
    DUEONRECEIPT = "DUE_ON_RECEIPT"
    DUEONDATESPECIFIED = "DUE_ON_DATE_SPECIFIED"
    NET10 = "NET_10"
    NET15 = "NET_15"
    NET30 = "NET_30"
    NET45 = "NET_45"
    NET60 = "NET_60"
    NET90 = "NET_90"
    NODUEDATE = "NO_DUE_DATE"

  PaymentType* = enum
    ## The payment type. Can be PayPal or an external payment. Includes cash or a
    ## check.
    PAYPAL2 = "PAYPAL"
    EXTERNAL = "EXTERNAL"

  Payments* = ref object of RootObj
    ## An array of payments registered against the invoice.
    paid_amount*: Option[Money]
    transactions*: Option[PaymentDetailList]

  Percentage* = string

  Phone* = ref object of RootObj
    ## The phone number, in its canonical international [E.164 numbering plan
    ## format](https://www.itu.int/rec/T-REC-E.164/en).
    country_code*: string
      ## The country calling code (CC), in its canonical international [E.164 numbering
      ## plan format](https://www.itu.int/rec/T-REC-E.164/en). The combined length of the
      ## CC and the national number must not be greater than 15 digits. The national
      ## number consists of a national destination code (NDC) and subscriber number (SN).
    national_number*: string
      ## The national number, in its canonical international [E.164 numbering plan
      ## format](https://www.itu.int/rec/T-REC-E.164/en). The combined length of the
      ## country calling code (CC) and the national number must not be greater than 15
      ## digits. The national number consists of a national destination code (NDC) and
      ## subscriber number (SN).
    extension_number*: Option[string]
      ## The extension number.

  PhoneDetail* = ref object of RootObj
    ## The phone details. Includes the phone number and type.
    country_code*: string
      ## The country calling code (CC), in its canonical international [E.164 numbering
      ## plan format](https://www.itu.int/rec/T-REC-E.164/en). The combined length of the
      ## CC and the national number must not be greater than 15 digits. The national
      ## number consists of a national destination code (NDC) and subscriber number (SN).
    national_number*: string
      ## The national number, in its canonical international [E.164 numbering plan
      ## format](https://www.itu.int/rec/T-REC-E.164/en). The combined length of the
      ## country calling code (CC) and the national number must not be greater than 15
      ## digits. The national number consists of a national destination code (NDC) and
      ## subscriber number (SN).
    extension_number*: Option[string]
      ## The extension number.
    phone_type*: PhoneType

  PhoneDetailList* = seq[PhoneDetail]

  PhoneType* = enum
    ## The phone type.
    FAX = "FAX"
    HOME = "HOME"
    MOBILE = "MOBILE"
    OTHER2 = "OTHER"
    PAGER = "PAGER"

  QrConfig* = ref object of RootObj
    ## The configuration for a QR code.
    width*: Option[int64]
      ## The width, in pixels, of the QR code image. Value is from `150` to `500`.
    height*: Option[int64]
      ## The height, in pixels, of the QR code image. Value is from `150` to `500`.
    action*: Option[string]
      ## The type of URL for which to generate a QR code. Valid values are `pay` and
      ## `details`.

  RecipientInfo* = ref object of RootObj
    ## The billing and shipping information. Includes name, email, address, phone, and
    ## language.
    billing_info*: Option[BillingInfo]
    shipping_info*: Option[ContactNameAddress]

  RecipientInfoList* = seq[RecipientInfo]

  RefundDetail* = ref object of RootObj
    ## The refund details of the invoice. Includes the refund type, date, amount, and
    ## method.
    `type`*: Option[PaymentType]
    refund_id*: Option[string]
      ## The ID for a PayPal payment transaction. Required for the `PAYPAL` payment type.
    refund_date*: Option[DateNoTime]
    amount*: Option[Money]
    `method`*: PaymentMethod

  RefundDetailList* = seq[RefundDetail]

  RefundReference* = ref object of RootObj
    ## The reference to the refund payment detail.
    refund_id*: Option[string]
      ## The ID of the refund of an invoice payment.

  Refunds* = ref object of RootObj
    ## The invoicing refund details. Includes the refund type, date, amount, and
    ## method.
    refund_amount*: Option[Money]
    transactions*: Option[RefundDetailList]

  RestrictiveEmailAddress* = string

  SearchData* = ref object of RootObj
    ## The invoice search parameters.
    recipient_email*: Option[string]
      ## Filters the search by the email address.
    recipient_first_name*: Option[string]
      ## Filters the search by the recipient first name.
    recipient_last_name*: Option[string]
      ## Filters the search by the recipient last name.
    recipient_business_name*: Option[string]
      ## Filters the search by the recipient business name.
    invoice_number*: Option[string]
      ## Filters the search by the invoice number.
    status*: Option[InvoiceStatusList]
    reference*: Option[string]
      ## The reference data. Includes a Purchase Order (PO) number.
    currency_code*: Option[CurrencyCode]
    memo*: Option[string]
      ## A private bookkeeping memo for the user.
    total_amount_range*: Option[AmountRange]
    invoice_date_range*: Option[DateRange]
    due_date_range*: Option[DateRange]
    payment_date_range*: Option[DateTimeRange]
    creation_date_range*: Option[DateTimeRange]
    archived*: Option[bool]
      ## Indicates whether to list merchant-archived invoices in the response. Value
      ## is:<ul><li><code>true</code>. Response lists only merchant-archived
      ## paypal_invoices.</li><li><code>false</code>. Response lists only unarchived
      ## paypal_invoices.</li><li><code>null</code>. Response lists all paypal_invoices.</li></ul>
    fields*: Option[FieldsList]

  ShippingCost* = ref object of RootObj
    ## The shipping fee for all items. Includes tax on shipping.
    amount*: Option[Money]
    tax*: Option[Tax]

  Tax* = ref object of RootObj
    ## The tax information. Includes the tax name and tax rate of invoice items. The
    ## tax amount is added to the item total.
    name*: string
      ## The name of the tax applied on the invoice items.
    percent*: Percentage
    amount*: Option[Money]
    tax_note*: Option[string]
      ## The tax note used to track the tax related data.

  Template* = ref object of RootObj
    ## The template with invoice details to load with all captured fields.
    id*: Option[string]
      ## The ID of the template.
    name*: Option[string]
      ## The template name.<blockquote><strong>Note:</strong> The template name must be
      ## unique.</blockquote>
    default_template*: Option[bool]
      ## Indicates whether this template is the default template. A invoicer can have one
      ## default template.
    template_info*: Option[TemplateInfo]
    settings*: Option[TemplateSettings]
    unit_of_measure*: Option[UnitOfMeasure]
    standard_template*: Option[bool]
      ## Indicates whether this template is a invoicer-created custom template. The
      ## system generates non-custom templates.
    links*: Option[LinkDescriptionList]

  TemplateConfiguration* = ref object of RootObj
    ## The template configuration details. Includes tax information, tip, and partial
    ## payment.
    tax_calculated_after_discount*: Option[bool]
      ## Indicates whether the tax is calculated before or after a discount. If `false`,
      ## the tax is calculated before a discount. If `true`, the tax is calculated after
      ## a discount.
    tax_inclusive*: Option[bool]
      ## Indicates whether the unit price includes tax.
    allow_tip*: Option[bool]
      ## Indicates whether the invoice enables the customer to enter a tip amount during
      ## payment. If `true`, the invoice shows a tip amount field so that the customer
      ## can enter a tip amount. If `false`, the invoice does not show a tip amount
      ## field.<blockquote><strong>Note:</strong> This feature is not available for users
      ## in `Hong Kong`, `Taiwan`, `India`, or `Japan`.</blockquote>
    partial_payment*: Option[PartialPayment]
    has_conditional_rule*: Option[bool]
      ## Indicates whether conditional pricing rules are applied to the invoice. If
      ## `true`, pricing rules (such as discounts or surcharges based on specific
      ## conditions) are applied. If `false`, no conditional pricing rules are applied.

  TemplateDetail* = ref object of RootObj
    ## The template-related details. Includes notes, terms and conditions, memo, and
    ## attachments.
    reference*: Option[string]
      ## The reference data. Includes a Purchase Order (PO) number.
    currency_code*: CurrencyCode
    note*: Option[string]
      ## A note to the invoice recipient. Also appears on the invoice notification email.
    terms_and_conditions*: Option[string]
      ## The general terms of the invoice. Can include return or cancellation policy and
      ## other terms and conditions.
    memo*: Option[string]
      ## A private bookkeeping memo for the user.
    attachments*: Option[FileReferenceList]
    payment_term*: Option[PaymentTerm]
    metadata*: Option[TemplateMetadata]

  TemplateDisplayPreference* = ref object of RootObj
    ## The template display preference.
    hidden*: Option[bool]
      ## Indicates whether to show or hide this field.

  TemplateInfo* = ref object of RootObj
    ## The template details. Includes invoicer business information, invoice
    ## recipients, items, and configuration.
    detail*: Option[TemplateDetail]
    invoicer*: Option[InvoicerInfo]
    primary_recipients*: Option[DefinitionsRecipientInfoList]
    additional_recipients*: Option[EmailAddressList]
    items*: Option[DefinitionsItemList]
    configuration*: Option[TemplateConfiguration]
    amount*: Option[AmountSummaryDetail]
    due_amount*: Option[Money]

  TemplateItemField* = enum
    ## The field names for the invoice line items in the template.
    ITEMSQUANTITY = "ITEMS_QUANTITY"
    ITEMSDESCRIPTION = "ITEMS_DESCRIPTION"
    ITEMSDATE = "ITEMS_DATE"
    ITEMSDISCOUNT = "ITEMS_DISCOUNT"
    ITEMSTAX = "ITEMS_TAX"

  TemplateItemSetting* = ref object of RootObj
    ## The template item setting. Sets a template as the default template or edit
    ## template.
    field_name*: Option[TemplateItemField]
    display_preference*: Option[TemplateDisplayPreference]

  TemplateItemSettingList* = seq[TemplateItemSetting]

  TemplateList* = seq[Template]

  TemplateMetadata* = ref object of RootObj
    ## The audit metadata. Captures all template actions on create and update.
    create_time*: Option[DateTime]
    created_by*: Option[string]
      ## The email address of the account that created the resource.
    last_update_time*: Option[DateTime]
    last_updated_by*: Option[string]
      ## The email address of the account that last edited the resource.

  TemplateSettings* = ref object of RootObj
    ## The template settings. Sets a template as the default template or edit template.
    template_item_settings*: Option[TemplateItemSettingList]
    template_subtotal_settings*: Option[TemplateSubtotalSettingList]

  TemplateSubtotalField* = enum
    ## The field names in the template for discount, shipping, and custom amounts.
    DISCOUNT2 = "DISCOUNT"
    SHIPPING = "SHIPPING"
    CUSTOM = "CUSTOM"

  TemplateSubtotalSetting* = ref object of RootObj
    ## The template subtotal setting. Includes the field name and display preference.
    field_name*: Option[TemplateSubtotalField]
    display_preference*: Option[TemplateDisplayPreference]

  TemplateSubtotalSettingList* = seq[TemplateSubtotalSetting]

  Templates* = ref object of RootObj
    ## An array of merchant-created templates with associated details that include the
    ## emails, addresses, and phone numbers from the user's PayPal profile.
    addresses*: Option[AddressPortableList]
    emails*: Option[EmailAddress]
    phones*: Option[TemplatesDefinitionsPhoneDetailList]
    templates*: Option[TemplateList]
    links*: Option[LinkDescriptionList]

  TemplatesCreate400* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  TemplatesCreate422* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  TemplatesDelete403* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  TemplatesGet403* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  TemplatesUpdate400* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  TemplatesDefinitionsPhoneDetailList* = seq[PhoneDetail]

  UnitOfMeasure* = enum
    ## The unit of measure for the invoiced item.
    QUANTITY = "QUANTITY"
    HOURS = "HOURS"
    AMOUNT = "AMOUNT"
