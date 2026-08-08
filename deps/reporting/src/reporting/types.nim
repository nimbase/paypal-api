import std/[options, json]

type
  AccountId* = string

  Address* = ref object of RootObj
    ## A simple postal address with coarse-grained fields. Do not use for an
    ## international address. Use for backward compatibility only. Does not contain
    ## phone.
    line1*: string
      ## The first line of the address. For example, number or street.
    line2*: Option[string]
      ## The second line of the address. For example, suite or apartment number.
    city*: string
      ## The city name.
    state*: Option[string]
      ## The [code](/docs/api/reference/state-codes/) for a US state or the equivalent
      ## for other countries. Required for transactions if the address is in one of these
      ## countries: [Argentina](/docs/api/reference/state-codes/#argentina),
      ## [Brazil](/docs/api/reference/state-codes/#brazil),
      ## [Canada](/docs/api/reference/state-codes/#canada),
      ## [China](/docs/api/reference/state-codes/#china),
      ## [India](/docs/api/reference/state-codes/#india),
      ## [Italy](/docs/api/reference/state-codes/#italy),
      ## [Japan](/docs/api/reference/state-codes/#japan),
      ## [Mexico](/docs/api/reference/state-codes/#mexico),
      ## [Thailand](/docs/api/reference/state-codes/#thailand), or [United
      ## States](/docs/api/reference/state-codes/#usa). Maximum length is 40 single-byte
      ## characters.
    country_code*: CountryCode
    postal_code*: Option[string]
      ## The postal code, which is the zip code or equivalent. Typically required for
      ## countries with a postal code or an equivalent. See [postal
      ## code](https://en.wikipedia.org/wiki/Postal_code).

  AuctionInfo* = ref object of RootObj
    ## The auction information.
    auction_site*: Option[string]
      ## The name of the auction site.
    auction_item_site*: Option[string]
      ## The auction site URL.
    auction_buyer_id*: Option[string]
      ## The ID of the buyer who makes the purchase in the auction. This ID might be
      ## different from the payer ID provided for the payment.
    auction_closing_date*: Option[DateTime]

  BalanceDetail* = ref object of RootObj
    ## The Balance information.
    currency*: CurrencyCode
    primary*: Option[bool]
      ## Optional field representing if the currency is primary currency or not.
    total_balance*: Money
    available_balance*: Option[Money]
    withheld_balance*: Option[Money]

  BalanceDetailList* = seq[BalanceDetail]

  BalancesResponse* = ref object of RootObj
    ## The balances response information.
    balances*: Option[BalanceDetailList]
    account_id*: Option[AccountId]
    as_of_time*: Option[DateTime]
    last_refresh_time*: Option[DateTime]

  CartInfo* = ref object of RootObj
    ## The cart information.
    item_details*: Option[ItemDetailList]
    tax_inclusive*: Option[bool]
      ## Indicates whether the item amount or the shipping amount already includes tax.
    paypal_invoice_id*: Option[string]
      ## The ID of the invoice. Appears for only PayPal-generated invoices.

  CheckoutOption* = ref object of RootObj
    ## A checkout option as a name-and-value pair.
    checkout_option_name*: Option[string]
      ## The checkout option name, such as `color` or `texture`.
    checkout_option_value*: Option[string]
      ## The checkout option value. For example, the checkout option `color` might be
      ## `blue` or `red` while the checkout option `texture` might be `smooth` or
      ## `rippled`.

  CheckoutOptionList* = seq[CheckoutOption]

  CountryCode* = string

  CurrencyCode* = string

  DateTime* = string

  EmailAddress* = string

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

  IncentiveDetail* = ref object of RootObj
    ## The incentive details.
    incentive_type*: Option[string]
      ## The type of incentive, such as a special offer or coupon.
    incentive_code*: Option[string]
      ## The code that identifies an incentive, such as a coupon.
    incentive_amount*: Option[Money]
    incentive_program_code*: Option[string]
      ## The incentive program code that identifies a merchant loyalty or incentive
      ## program.

  IncentiveDetailList* = seq[IncentiveDetail]

  IncentiveInfo* = ref object of RootObj
    ## The incentive details.
    incentive_details*: Option[IncentiveDetailList]

  ItemDetail* = ref object of RootObj
    ## The item details.
    item_code*: Option[string]
      ## An item code that identifies a merchant's goods or service.
    item_name*: Option[string]
      ## The item name.
    item_description*: Option[string]
      ## The item description.
    item_options*: Option[string]
      ## The item options. Describes option choices on the purchase of the item in some
      ## detail.
    item_quantity*: Option[string]
      ## The number of purchased units of goods or a service.
    item_unit_price*: Option[Money]
    item_amount*: Option[Money]
    discount_amount*: Option[Money]
    adjustment_amount*: Option[Money]
    gift_wrap_amount*: Option[Money]
    tax_percentage*: Option[Percentage]
    tax_amounts*: Option[ItemDetailTaxAmountList]
    basic_shipping_amount*: Option[Money]
    extra_shipping_amount*: Option[Money]
    handling_amount*: Option[Money]
    insurance_amount*: Option[Money]
    total_item_amount*: Option[Money]
    invoice_number*: Option[string]
      ## The invoice number. An alphanumeric string that identifies a billing for a
      ## merchant.
    checkout_options*: Option[CheckoutOptionList]

  ItemDetailList* = seq[ItemDetail]

  ItemDetailTaxAmount* = ref object of RootObj
    ## The tax levied by a government on the purchase of goods or services.
    tax_amount*: Option[Money]

  ItemDetailTaxAmountList* = seq[ItemDetailTaxAmount]

  LinkDescription* = ref object of RootObj
    ## The request-related [HATEOAS
    ## link](/docs/api/reference/api-responses/#hateoas-links) information.
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

  Money* = ref object of RootObj
    ## The currency and amount for a financial transaction, such as a balance or
    ## payment due.
    currency_code*: CurrencyCode
    value*: string
      ## The value, which might be:<ul><li>An integer for currencies like `JPY` that are
      ## not typically fractional.</li><li>A decimal fraction for currencies like `TND`
      ## that are subdivided into thousandths.</li></ul>For the required number of
      ## decimal places for a currency code, see [Currency
      ## Codes](/docs/integration/direct/rest/currency-codes/).

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

  PayerInfo* = ref object of RootObj
    ## The payer information.
    account_id*: Option[string]
      ## The PayPal` customer account ID.
    email_address*: Option[EmailAddress]
    phone_number*: Option[Phone]
    address_status*: Option[string]
      ## The address status of the payer. Value is either:<ul><li><code>Y</code>.
      ## Verified.</li><li><code>N</code>. Not verified.</li></ul>
    payer_status*: Option[string]
      ## The status of the payer. Value is `Y` or `N`.
    payer_name*: Option[Name]
    country_code*: Option[CountryCode]
    address*: Option[Address]

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

  SearchResponse* = ref object of RootObj
    ## The search response information.
    transaction_details*: Option[TransactionDetailList]
    account_number*: Option[string]
      ## The merchant account number.
    start_date*: Option[DateTime]
    end_date*: Option[DateTime]
    last_refreshed_datetime*: Option[DateTime]
    page*: Option[int64]
      ## A zero-relative index of transactions.
    total_items*: Option[int64]
      ## The total number of transactions as an integer beginning with the specified
      ## `page` in the full result and not just in this response.
    total_pages*: Option[int64]
      ## The total number of pages, as an `integer`, when the `total_items` is divided
      ## into pages of the specified `page_size`.
    links*: Option[LinkDescriptionList]

  ShippingInfo* = ref object of RootObj
    ## The shipping information.
    name*: Option[string]
      ## The recipient's name.
    `method`*: Option[string]
      ## The shipping method that is associated with this order.
    address*: Option[Address]
    secondary_shipping_address*: Option[Address]

  StoreInfo* = ref object of RootObj
    ## The store information.
    store_id*: Option[string]
      ## The ID of a store for a merchant in the system of record.
    terminal_id*: Option[string]
      ## The terminal ID for the checkout stand in a merchant store.

  TransactionDetail* = ref object of RootObj
    ## The transaction details.
    transaction_info*: Option[TransactionInfo]
    payer_info*: Option[PayerInfo]
    shipping_info*: Option[ShippingInfo]
    cart_info*: Option[CartInfo]
    store_info*: Option[StoreInfo]
    auction_info*: Option[AuctionInfo]
    incentive_info*: Option[IncentiveInfo]

  TransactionDetailList* = seq[TransactionDetail]

  TransactionInfo* = ref object of RootObj
    ## The transaction information.
    paypal_account_id*: Option[string]
      ## The ID of the PayPal account of the counterparty.
    transaction_id*: Option[string]
      ## The PayPal-generated transaction ID.
    paypal_reference_id*: Option[string]
      ## The PayPal-generated base ID. PayPal exclusive. Cannot be altered. Defined as a
      ## related, pre-existing transaction or event.
    paypal_reference_id_type*: Option[string]
      ## The PayPal reference ID type.
    transaction_event_code*: Option[string]
      ## A five-digit transaction event code that classifies the transaction type based
      ## on money movement and debit or credit. For example, <code>T0001</code>. See
      ## [Transaction event
      ## codes](/docs/integration/direct/transaction-search/transaction-event-codes/).
    transaction_initiation_date*: Option[DateTime]
    transaction_updated_date*: Option[DateTime]
    transaction_amount*: Option[Money]
    fee_amount*: Option[Money]
    discount_amount*: Option[Money]
    insurance_amount*: Option[Money]
    sales_tax_amount*: Option[Money]
    shipping_amount*: Option[Money]
    shipping_discount_amount*: Option[Money]
    shipping_tax_amount*: Option[Money]
    other_amount*: Option[Money]
    tip_amount*: Option[Money]
    transaction_status*: Option[string]
      ## A code that indicates the transaction status. Valueis:<table><thead><tr><th>Sta
      ## tus&nbsp;code</th><th>Description</th></tr></thead><tbody><tr><td><code>D</code>
      ## </td><td>PayPal or merchant rules denied the
      ## reporting.</td></tr><tr><td><code>P</code></td><td>The transaction is pending.
      ## The transaction was created but waits for another payment process to complete,
      ## such as an ACH transaction, before the status changes to
      ## <code>S</code>.</td></tr><tr><td><code>S</code></td><td>The transaction
      ## successfully completed without a denial and after any pending
      ## statuses.</td></tr><tr><td><code>V</code></td><td>A successful transaction was
      ## fully reversed and funds were refunded to the original
      ## sender.</td></tr></tbody></table>
    transaction_subject*: Option[string]
      ## The subject of payment. The payer passes this value to the payee. The payer
      ## controls this data through the interface through which he or she sends the data.
    transaction_note*: Option[string]
      ## A special note that the payer passes to the payee. Might contain special
      ## customer requests, such as shipping instructions.
    payment_tracking_id*: Option[string]
      ## The payment tracking ID, which is a unique ID that partners specify to either
      ## get information about a payment or request a refund.
    bank_reference_id*: Option[string]
      ## The bank reference ID. The bank provides this value for an ACH reporting.
    ending_balance*: Option[Money]
    available_balance*: Option[Money]
    invoice_id*: Option[string]
      ## The invoice ID that is sent by the merchant with the
      ## reporting.<blockquote><strong>Note:</strong> If an invoice ID was sent with
      ## the capture request, the value is reported. Otherwise, the invoice ID of the
      ## authorizing transaction is reported.</blockquote>
    custom_field*: Option[string]
      ## The merchant-provided custom text.<blockquote><strong>Note:</strong> Usually,
      ## this field includes the unique ID for payments made with MassPay type
      ## reporting.</blockquote>
    protection_eligibility*: Option[string]
      ## Indicates whether the transaction is eligible for protection. Value
      ## is:<ul><li><code>01</code>. Eligible.</li><li><code>02</code>. Not
      ## eligible</li><li><code>03</code>. Partially eligible.</li></ul>
    credit_term*: Option[string]
      ## The credit term. The time span covered by the installment payments as expressed
      ## in the term length plus the length time unit code.
    credit_transactional_fee*: Option[Money]
    credit_promotional_fee*: Option[Money]
    annual_percentage_rate*: Option[Percentage]
    payment_method_type*: Option[string]
      ## The payment method that was used for a reporting. Value is <code>PUI</code>,
      ## <code>installment</code>, or
      ## <code>mEFT</code>.<blockquote><strong>Note:</strong> Appears only for pay upon
      ## invoice (PUI), installment, and mEFT transactions. Merchants and partners in the
      ## EMEA region can use this attribute to note transactions that attract turn-over
      ## tax.</blockquote>
    instrument_type*: Option[string]
      ## A high-level classification of the type of financial instrument that was used to
      ## fund a payment. The pattern is not provided because the value is defined by an
      ## external party. E.g. PAYPAL, CREDIT_CARD, DEBIT_CARD, APPLE_PAY, BANK , VENMO
      ## ,Pay Upon Invoice, Pay Later  or <ahref="https://developer.paypal.com/docs/chec
      ## kout/integration-features/alternative-payment-methods/" title="Link to available
      ## APM list">Alternative Payment Methods (APM)</a>.
    instrument_sub_type*: Option[string]
      ## A finer-grained classification of the financial instrument that was used to fund
      ## a payment. For example, `Visa card` or a `Mastercard` for a credit card,
      ## BANKCARD ,DISCOVER etc. The pattern is not provided because the value is defined
      ## by an external party.
