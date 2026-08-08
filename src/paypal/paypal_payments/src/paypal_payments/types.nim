import std/[options, json]

type
  StandardHeaderSchema* = string

  EmailAddress* = string

  CardBrand* = enum
    ## The card network or brand. Applies to credit, debit, gift, and payment cards.
    VISA = "VISA"
    MASTERCARD = "MASTERCARD"
    DISCOVER = "DISCOVER"
    AMEX = "AMEX"
    SOLO = "SOLO"
    JCB = "JCB"
    STAR = "STAR"
    DELTA = "DELTA"
    SWITCH = "SWITCH"
    MAESTRO = "MAESTRO"
    CBNATIONALE = "CB_NATIONALE"
    CONFIGOGA = "CONFIGOGA"
    CONFIDIS = "CONFIDIS"
    ELECTRON = "ELECTRON"
    CETELEM = "CETELEM"
    CHINAUNIONPAY = "CHINA_UNION_PAY"
    DINERS = "DINERS"
    ELO = "ELO"
    HIPER = "HIPER"
    HIPERCARD = "HIPERCARD"
    RUPAY = "RUPAY"
    GE = "GE"
    SYNCHRONY = "SYNCHRONY"
    EFTPOS = "EFTPOS"
    CARTEBANCAIRE = "CARTE_BANCAIRE"
    STARACCESS = "STAR_ACCESS"
    PULSE = "PULSE"
    NYCE = "NYCE"
    ACCEL = "ACCEL"
    UNKNOWN = "UNKNOWN"

  Email* = string

  NetworkTransaction* = ref object of RootObj
    ## Reference values used by the card network to identify a transaction.
    id*: Option[string]
      ## Transaction reference id returned by the scheme. For Visa and Amex, this is the
      ## "Tran id" field in response. For MasterCard, this is the "BankNet reference id"
      ## field in response. For Discover, this is the "NRID" field in response. The
      ## pattern we expect for this field from Visa/Amex/CB/Discover is numeric,
      ## Mastercard/BNPP is alphanumeric and Paysecure is alphanumeric with special
      ## character -.
    date*: Option[string]
      ## The date that the transaction was authorized by the scheme. This field may not
      ## be returned for all networks. MasterCard refers to this field as "BankNet
      ## reference date". For some specific networks, such as MasterCard and Discover,
      ## this date field is mandatory when the
      ## `previous_network_transaction_reference_id` is passed.
    network*: Option[JsonNode]
    acquirer_reference_number*: Option[string]
      ## Reference ID issued for the card transaction. This ID can be used to track the
      ## transaction across processors, card brands and issuing banks.

  CurrencyCode* = string

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

  DateTime* = string

  CountryCode2* = string

  Phone2* = ref object of RootObj
    ## The phone number in its canonical international [E.164 numbering plan
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

  DiscountWithBreakdown* = ref object of RootObj
    ## The discount amount and currency code. For list of supported currencies and
    ## decimal precision, see the PayPal REST APIs <a
    ## href="/docs/integration/direct/rest/currency-codes/">Currency Codes</a>.
    currency_code*: CurrencyCode
    value*: string
      ## The value, which might be:<ul><li>An integer for currencies like `JPY` that are
      ## not typically fractional.</li><li>A decimal fraction for currencies like `TND`
      ## that are subdivided into thousandths.</li></ul>For the required number of
      ## decimal places for a currency code, see [Currency
      ## Codes](/api/rest/reference/currency-codes/).

  AmountBreakdown* = ref object of RootObj
    ## The breakdown of the amount. Breakdown provides details such as total item
    ## amount, total tax amount, shipping, handling, insurance, and discounts, if any.
    item_total*: Option[JsonNode]
    shipping*: Option[JsonNode]
    handling*: Option[JsonNode]
    tax_total*: Option[JsonNode]
    insurance*: Option[JsonNode]
    shipping_discount*: Option[JsonNode]
    discount*: Option[JsonNode]

  AmountWithBreakdown* = ref object of RootObj
    ## The total order amount with an optional breakdown that provides details, such as
    ## the total item amount, total tax amount, shipping, handling, insurance, and
    ## discounts, if any.<br/>If you specify `amount.breakdown`, the amount equals
    ## `item_total` plus `tax_total` plus `shipping` plus `handling` plus `insurance`
    ## minus `shipping_discount` minus discount.<br/>The amount must be a positive
    ## number. For listed of supported currencies and decimal precision, see the PayPal
    ## REST APIs <a href="/docs/integration/direct/rest/currency-codes/">Currency
    ## Codes</a>.
    currency_code*: CurrencyCode
    value*: string
      ## The value, which might be:<ul><li>An integer for currencies like `JPY` that are
      ## not typically fractional.</li><li>A decimal fraction for currencies like `TND`
      ## that are subdivided into thousandths.</li></ul>For the required number of
      ## decimal places for a currency code, see [Currency
      ## Codes](/api/rest/reference/currency-codes/).
    breakdown*: Option[AmountBreakdown]

  AccountId2* = string

  PayeeBase* = ref object of RootObj
    ## The details for the merchant who receives the funds and fulfills the order. The
    ## merchant is also known as the payee.
    email_address*: Option[JsonNode]
    merchant_id*: Option[JsonNode]

  Payee* = ref object of RootObj
    ## The merchant who receives the funds and fulfills the order. The merchant is also
    ## known as the payee.
    email_address*: Option[JsonNode]
    merchant_id*: Option[JsonNode]

  LinkSchema* = ref object of RootObj
    ## The request data or link target.
    additional_items*: Option[JsonNode]
      ## Any additional items.
    dependencies*: Option[JsonNode]
      ## The dependencies.
    items*: Option[JsonNode]
      ## An item.
    definitions*: Option[JsonNode]
      ## Definitions.
    pattern_properties*: Option[JsonNode]
      ## The pattern properties.
    properties*: Option[JsonNode]
      ## The properties.
    all_of*: Option[seq[JsonNode]]
      ## An array of sub-schemas. The data must validate against all sub-schemas.
    any_of*: Option[seq[JsonNode]]
      ## An array of sub-schemas. The data must validate against one or more sub-schemas.
    one_of*: Option[seq[JsonNode]]
      ## An array of sub-schemas. The data must validate against one sub-schema.
    `not`*: Option[JsonNode]
      ## Not.
    links*: Option[seq[JsonNode]]
      ## An array of links.
    fragment_resolution*: Option[string]
      ## The fragment resolution.
    media*: Option[JsonNode]
      ## The media type and context-encoding scheme.
    path_start*: Option[string]
      ## To apply this schema to the instances' URIs, start the URIs with this value.

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
    title*: Option[string]
      ## The link title.
    media_type*: Option[string]
      ## The media type, as defined by [RFC 2046](https://www.ietf.org/rfc/rfc2046.txt).
      ## Describes the link target.
    enc_type*: Option[string]
      ## The media type in which to submit the request data.
    schema*: Option[JsonNode]
    target_schema*: Option[JsonNode]

  ErrorDetails* = ref object of RootObj
    ## The error details. Required for client-side `4XX` errors.
    field*: Option[string]
      ## The field that caused the error. If this field is in the body, set this value to
      ## the field's JSON pointer value. Required for client-side errors.
    value*: Option[string]
      ## The value of the field that caused the error.
    location*: Option[string]
      ## The location of the field that caused the error. Value is `body`, `path`, or
      ## `query`.
    issue*: string
      ## The unique, fine-grained application-level error code.
    links*: Option[seq[JsonNode]]
      ## An array of request-related [HATEOAS links](/api/rest/responses/#hateoas-links)
      ## that are either relevant to the issue by providing additional information or
      ## offering potential resolutions.
    description*: Option[string]
      ## The human-readable description for an issue. The description can change over the
      ## lifetime of an API, so clients must not depend on this value.

  Error* = ref object of RootObj
    ## The error details.
    name*: string
      ## The human-readable, unique name of the error.
    message*: string
      ## The message that describes the error.
    debug_id*: string
      ## The PayPal internal ID. Used for correlation purposes.
    details*: Option[seq[JsonNode]]
      ## An array of additional details about the error.
    links*: Option[seq[JsonNode]]
      ## An array of request-related [HATEOAS links](/api/rest/responses/#hateoas-links).

  AuthorizationStatusDetails* = ref object of RootObj
    ## The details of the authorized payment status.
    reason*: Option[string]
      ## The reason why the authorized status is `PENDING`.

  AuthorizationStatus* = ref object of RootObj
    ## The status fields and status details for an authorized payment.
    status*: Option[string]
      ## The status for the authorized payment.
    status_details*: Option[JsonNode]

  SellerProtection* = ref object of RootObj
    ## The level of protection offered as defined by [PayPal Seller Protection for
    ## Merchants](https://www.paypal.com/us/webapps/mpp/security/seller-protection).
    status*: Option[string]
      ## Indicates whether the transaction is eligible for seller protection. For
      ## information, see [PayPal Seller Protection for
      ## Merchants](https://www.paypal.com/us/webapps/mpp/security/seller-protection).
    dispute_categories*: Option[seq[string]]
      ## An array of conditions that are covered for the transaction.

  LinkSchema2* = ref object of RootObj
    ## The request data or link target.
    additional_items*: Option[JsonNode]
      ## Any additional items.
    dependencies*: Option[JsonNode]
      ## Any Dependencies.
    items*: Option[JsonNode]
      ## An item.
    definitions*: Option[JsonNode]
      ## Definitions.
    pattern_properties*: Option[JsonNode]
      ## The pattern properties.
    properties*: Option[JsonNode]
      ## Properties.
    all_of*: Option[seq[JsonNode]]
      ## An array of sub-schemas. The data must validate against all sub-schemas.
    any_of*: Option[seq[JsonNode]]
      ## An array of sub-schemas. The data must validate against one or more sub-schemas.
    one_of*: Option[seq[JsonNode]]
      ## An array of sub-schemas. The data must validate against one sub-schema.
    `not`*: Option[JsonNode]
      ## Not.
    links*: Option[seq[JsonNode]]
      ## An array of links.
    fragment_resolution*: Option[string]
      ## The fragment resolution.
    media*: Option[JsonNode]
      ## The media type and context-encoding scheme.
    path_start*: Option[string]
      ## To apply this schema to the instances' URIs, start the URIs with this value.

  LinkDescription2* = ref object of RootObj
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
    title*: Option[string]
      ## The link title.
    media_type*: Option[string]
      ## The media type, as defined by [RFC 2046](https://www.ietf.org/rfc/rfc2046.txt).
      ## Describes the link target.
    enc_type*: Option[string]
      ## The media type in which to submit the request data.
    schema*: Option[JsonNode]
    target_schema*: Option[JsonNode]

  ActivityTimestamps* = ref object of RootObj
    ## The date and time stamps that are common to authorized payment, captured
    ## payment, and refund transactions.
    create_time*: Option[JsonNode]
    update_time*: Option[JsonNode]

  Authorization* = ref object of RootObj
    ## The authorized payment transaction.
    status*: Option[string]
      ## The status for the authorized payment.
    status_details*: Option[JsonNode]
    id*: Option[string]
      ## The PayPal-generated ID for the authorized payment.
    amount*: Option[JsonNode]
    invoice_id*: Option[string]
      ## The API caller-provided external invoice number for this order. Appears in both
      ## the payer's transaction history and the emails that the payer receives.
    custom_id*: Option[string]
      ## The API caller-provided external ID. Used to reconcile API caller-initiated
      ## transactions with PayPal transactions. Appears in transaction and settlement
      ## reports.
    network_transaction_reference*: Option[JsonNode]
    seller_protection*: Option[JsonNode]
    expiration_time*: Option[JsonNode]
    links*: Option[seq[JsonNode]]
      ## An array of related [HATEOAS
      ## links](/docs/api/reference/api-responses/#hateoas-links).
    create_time*: Option[JsonNode]
    update_time*: Option[JsonNode]

  RelatedIds* = ref object of RootObj
    ## Identifiers related to a specific resource.
    order_id*: Option[string]
      ## Order ID related to the resource.
    authorization_id*: Option[string]
      ## Authorization ID related to the resource.
    capture_id*: Option[string]
      ## Capture ID related to the resource.

  SupplementaryData* = ref object of RootObj
    ## The supplementary data.
    related_ids*: Option[JsonNode]

  Authorization2* = ref object of RootObj
    ## The authorized payment transaction.
    status*: Option[string]
      ## The status for the authorized payment.
    status_details*: Option[JsonNode]
    id*: Option[string]
      ## The PayPal-generated ID for the authorized payment.
    amount*: Option[JsonNode]
    invoice_id*: Option[string]
      ## The API caller-provided external invoice number for this order. Appears in both
      ## the payer's transaction history and the emails that the payer receives.
    custom_id*: Option[string]
      ## The API caller-provided external ID. Used to reconcile API caller-initiated
      ## transactions with PayPal transactions. Appears in transaction and settlement
      ## reports.
    network_transaction_reference*: Option[JsonNode]
    seller_protection*: Option[JsonNode]
    expiration_time*: Option[JsonNode]
    links*: Option[seq[JsonNode]]
      ## An array of related [HATEOAS
      ## links](/docs/api/reference/api-responses/#hateoas-links).
    create_time*: Option[JsonNode]
    update_time*: Option[JsonNode]
    supplementary_data*: Option[JsonNode]
    payee*: Option[JsonNode]

  SupplementaryPurchaseData* = ref object of RootObj
    ## The capture identification-related fields. Includes the invoice ID, custom ID,
    ## note to payer, and soft descriptor.
    invoice_id*: Option[string]
      ## The API caller-provided external invoice number for this order. Appears in both
      ## the payer's transaction history and the emails that the payer receives.
    note_to_payer*: Option[string]
      ## An informational note about this settlement. Appears in both the payer's
      ## transaction history and the emails that the payer receives.

  PlatformFee* = ref object of RootObj
    ## The platform or partner fee, commission, or brokerage fee that is associated
    ## with the transaction. Not a separate or isolated transaction leg from the
    ## external perspective. The platform fee is limited in scope and is always
    ## associated with the original payment for the purchase unit.
    amount*: JsonNode
    payee*: Option[JsonNode]

  DisbursementMode* = enum
    ## The funds that are held on behalf of the merchant.
    INSTANT = "INSTANT"
    DELAYED = "DELAYED"

  PaymentInstruction* = ref object of RootObj
    ## Any additional payment instructions to be consider during payment processing.
    ## This processing instruction is applicable for Capturing an order or Authorizing
    ## an Order.
    platform_fees*: Option[seq[JsonNode]]
      ## An array of various fees, commissions, tips, or donations. This field is only
      ## applicable to merchants that been enabled for PayPal Complete Payments Platform
      ## for Marketplaces and Platforms capability.
    disbursement_mode*: Option[JsonNode]
    payee_pricing_tier_id*: Option[string]
      ## This field is only enabled for selected merchants/partners to use and provides
      ## the ability to trigger a specific pricing rate/plan for a payment transaction.
      ## The list of eligible 'payee_pricing_tier_id' would be provided to you by your
      ## Account Manager. Specifying values other than the one provided to you by your
      ## account manager would result in an error.
    payee_receivable_fx_rate_id*: Option[string]
      ## FX identifier generated returned by PayPal to be used for payment processing in
      ## order to honor FX rate (for eligible integrations) to be used when amount is
      ## settled/received into the payee account.

  CaptureRequest* = ref object of RootObj
    ## Captures either a portion or the full authorized amount of an authorized
    ## payment.
    invoice_id*: Option[string]
      ## The API caller-provided external invoice number for this order. Appears in both
      ## the payer's transaction history and the emails that the payer receives.
    note_to_payer*: Option[string]
      ## An informational note about this settlement. Appears in both the payer's
      ## transaction history and the emails that the payer receives.
    amount*: Option[JsonNode]
    final_capture*: Option[bool]
      ## Indicates whether you can make additional captures against the authorized
      ## payment. Set to `true` if you do not intend to capture additional payments
      ## against the authorization. Set to `false` if you intend to capture additional
      ## payments against the authorization.
    payment_instruction*: Option[JsonNode]
    soft_descriptor*: Option[string]
      ## The payment descriptor on the payer's account statement.

  CaptureStatusDetails* = ref object of RootObj
    ## The details of the captured payment status.
    reason*: Option[string]
      ## The reason why the captured payment status is `PENDING` or `DENIED`.

  CaptureStatus* = ref object of RootObj
    ## The status and status details of a captured payment.
    status*: Option[string]
      ## The status of the captured payment.
    status_details*: Option[JsonNode]

  ExchangeRate* = ref object of RootObj
    ## The exchange rate that determines the amount to convert from one currency to
    ## another currency.
    source_currency*: Option[JsonNode]
    target_currency*: Option[JsonNode]
    value*: Option[string]
      ## The target currency amount. Equivalent to one unit of the source currency.
      ## Formatted as integer or decimal value with one to 15 digits to the right of the
      ## decimal point.

  SellerReceivableBreakdown* = ref object of RootObj
    ## The detailed breakdown of the capture activity. This is not available for
    ## transactions that are in pending state.
    gross_amount*: JsonNode
    paypal_fee*: Option[JsonNode]
    paypal_fee_in_receivable_currency*: Option[JsonNode]
    net_amount*: Option[JsonNode]
    receivable_amount*: Option[JsonNode]
    exchange_rate*: Option[JsonNode]
    platform_fees*: Option[seq[JsonNode]]
      ## An array of platform or partner fees, commissions, or brokerage fees that
      ## associated with the captured payment.

  ProcessorResponse* = ref object of RootObj
    ## The processor response information for payment requests, such as direct credit
    ## card transactions.
    avs_code*: Option[string]
      ## The address verification code for Visa, Discover, Mastercard, or American
      ## Express transactions.
    cvv_code*: Option[string]
      ## The card verification value code for for Visa, Discover, Mastercard, or American
      ## Express.
    response_code*: Option[string]
      ## Processor response code for the non-PayPal payment processor errors.
    payment_advice_code*: Option[string]
      ## The declined payment transactions might have payment advice codes. The card
      ## networks, like Visa and Mastercard, return payment advice codes.

  Capture* = ref object of RootObj
    ## A captured payment.
    status*: Option[string]
      ## The status of the captured payment.
    status_details*: Option[JsonNode]
    id*: Option[string]
      ## The PayPal-generated ID for the captured payment.
    amount*: Option[JsonNode]
    invoice_id*: Option[string]
      ## The API caller-provided external invoice number for this order. Appears in both
      ## the payer's transaction history and the emails that the payer receives.
    custom_id*: Option[string]
      ## The API caller-provided external ID. Used to reconcile API caller-initiated
      ## transactions with PayPal transactions. Appears in transaction and settlement
      ## reports.
    network_transaction_reference*: Option[JsonNode]
    seller_protection*: Option[JsonNode]
    final_capture*: Option[bool]
      ## Indicates whether you can make additional captures against the authorized
      ## payment. Set to `true` if you do not intend to capture additional payments
      ## against the authorization. Set to `false` if you intend to capture additional
      ## payments against the authorization.
    seller_receivable_breakdown*: Option[JsonNode]
    disbursement_mode*: Option[JsonNode]
    links*: Option[seq[JsonNode]]
      ## An array of related [HATEOAS
      ## links](/docs/api/reference/api-responses/#hateoas-links).
    processor_response*: Option[JsonNode]
    create_time*: Option[JsonNode]
    update_time*: Option[JsonNode]

  Capture2* = ref object of RootObj
    ## A captured payment.
    status*: Option[string]
      ## The status of the captured payment.
    status_details*: Option[JsonNode]
    id*: Option[string]
      ## The PayPal-generated ID for the captured payment.
    amount*: Option[JsonNode]
    invoice_id*: Option[string]
      ## The API caller-provided external invoice number for this order. Appears in both
      ## the payer's transaction history and the emails that the payer receives.
    custom_id*: Option[string]
      ## The API caller-provided external ID. Used to reconcile API caller-initiated
      ## transactions with PayPal transactions. Appears in transaction and settlement
      ## reports.
    network_transaction_reference*: Option[JsonNode]
    seller_protection*: Option[JsonNode]
    final_capture*: Option[bool]
      ## Indicates whether you can make additional captures against the authorized
      ## payment. Set to `true` if you do not intend to capture additional payments
      ## against the authorization. Set to `false` if you intend to capture additional
      ## payments against the authorization.
    seller_receivable_breakdown*: Option[JsonNode]
    disbursement_mode*: Option[JsonNode]
    links*: Option[seq[JsonNode]]
      ## An array of related [HATEOAS
      ## links](/docs/api/reference/api-responses/#hateoas-links).
    processor_response*: Option[JsonNode]
    create_time*: Option[JsonNode]
    update_time*: Option[JsonNode]
    supplementary_data*: Option[JsonNode]
    payee*: Option[JsonNode]

  ReauthorizeRequest* = ref object of RootObj
    ## Reauthorizes an authorized PayPal account payment, by ID. To ensure that funds
    ## are still available, reauthorize a payment after its initial three-day honor
    ## period expires. You can reauthorize a payment only once from days four to
    ## 29.<br/><br/>If 30 days have transpired since the date of the original
    ## authorization, you must create an authorized payment instead of reauthorizing
    ## the original authorized payment.<br/><br/>A reauthorized payment itself has a
    ## new honor period of three days.<br/><br/>You can reauthorize an authorized
    ## payment once. The allowed amount depends on context and geography, for example
    ## in US it is up to 115% of the original authorized amount, not to exceed an
    ## increase of $75 USD.<br/><br/>Supports only the `amount` request parameter.
    amount*: Option[JsonNode]

  PaymentInstruction2* = ref object of RootObj
    ## Any additional payments instructions during refund payment processing. This
    ## object is only applicable to merchants that have been enabled for PayPal
    ## Commerce Platform for Marketplaces and Platforms capability. Please speak to
    ## your account manager if you want to use this capability.
    platform_fees*: Option[seq[JsonNode]]
      ## Specifies the amount that the API caller will contribute to the refund being
      ## processed. The amount needs to be lower than platform_fees amount originally
      ## captured or the amount that is remaining if multiple refunds have been
      ## processed. This field is only applicable to merchants that have been enabled for
      ## PayPal Commerce Platform for Marketplaces and Platforms capability. Please speak
      ## to your account manager if you want to use this capability.

  RefundRequest* = ref object of RootObj
    ## Refunds a captured payment, by ID. For a full refund, include an empty request
    ## body. For a partial refund, include an <code>amount</code> object in the request
    ## body.
    amount*: Option[JsonNode]
    custom_id*: Option[string]
      ## The API caller-provided external ID. Used to reconcile API caller-initiated
      ## transactions with PayPal transactions. Appears in transaction and settlement
      ## reports. The pattern is defined by an external party and supports Unicode.
    invoice_id*: Option[string]
      ## The API caller-provided external invoice ID for this order. The pattern is
      ## defined by an external party and supports Unicode.
    note_to_payer*: Option[string]
      ## The reason for the refund. Appears in both the payer's transaction history and
      ## the emails that the payer receives. The pattern is defined by an external party
      ## and supports Unicode.
    payment_instruction*: Option[JsonNode]

  RefundStatusDetails* = ref object of RootObj
    ## The details of the refund status.
    reason*: Option[string]
      ## The reason why the refund has the `PENDING` or `FAILED` status.

  RefundStatus* = ref object of RootObj
    ## The refund status with details.
    status*: Option[string]
      ## The status of the refund.
    status_details*: Option[JsonNode]

  NetAmountBreakdownItem* = ref object of RootObj
    ## The net amount. Returned when the currency of the refund is different from the
    ## currency of the PayPal account where the merchant holds their funds.
    payable_amount*: Option[JsonNode]
    converted_amount*: Option[JsonNode]
    exchange_rate*: Option[JsonNode]

  Refund* = ref object of RootObj
    ## The refund information.
    status*: Option[string]
      ## The status of the refund.
    status_details*: Option[JsonNode]
    id*: Option[string]
      ## The PayPal-generated ID for the refund.
    amount*: Option[JsonNode]
    invoice_id*: Option[string]
      ## The API caller-provided external invoice number for this order. Appears in both
      ## the payer's transaction history and the emails that the payer receives.
    custom_id*: Option[string]
      ## The API caller-provided external ID. Used to reconcile API caller-initiated
      ## transactions with PayPal transactions. Appears in transaction and settlement
      ## reports.
    acquirer_reference_number*: Option[string]
      ## Reference ID issued for the card transaction. This ID can be used to track the
      ## transaction across processors, card brands and issuing banks.
    note_to_payer*: Option[string]
      ## The reason for the refund. Appears in both the payer's transaction history and
      ## the emails that the payer receives.
    seller_payable_breakdown*: Option[JsonNode]
      ## The breakdown of the refund.
    payer*: Option[JsonNode]
    links*: Option[seq[JsonNode]]
      ## An array of related [HATEOAS
      ## links](/docs/api/reference/api-responses/#hateoas-links).
    create_time*: Option[JsonNode]
    update_time*: Option[JsonNode]

  Guid* = string

  FindEligibleMethodsRequestCustomerChannel* = ref object of RootObj
    ## Channel through which the request is being posted.
    browser_type*: Option[string]
      ## The browser used by the customer. Example: Safari, Chrome, etc.
    client_os*: Option[string]
      ## The operating system on the device used by the customer. Example: iOS 16.5,
      ## Android 30, etc.
    device_type*: Option[string]
      ## The type of device used by the customer. Example: Mobile, Desktop, Tablet, etc.

  FindEligibleMethodsRequestCustomer* = ref object of RootObj
    ## Customer who is making a purchase from the merchant/partner.
    country_code*: Option[JsonNode]
    channel*: Option[JsonNode]
    id*: Option[string]
      ## The unique ID for a customer in merchant's or partner's system of records.
    email*: Option[EmailAddress]
    phone*: Option[JsonNode]

  EligibilityPurchaseUnitRequest* = ref object of RootObj
    ## Purchase unit for payment eligibility.
    amount*: Option[AmountWithBreakdown]
    payee*: Option[Payee]

  PaymentMethod* = enum
    ## Set of unique payment methods.
    PAYPAL2 = "PAYPAL"
    VENMO2 = "VENMO"
    PAYPALCREDIT = "PAYPAL_CREDIT"
    PAYPALPAYLATER = "PAYPAL_PAY_LATER"

  FindEligibleMethodsRequestPreferences* = ref object of RootObj
    ## Preferences of merchant/partner consuming the API.
    payment_flow*: Option[string]
      ## This field specifies the payment flow, expected to provide a hint about which
      ## payment action the customer is intending to perform.
    include_account_details*: Option[bool]
      ## If this value is set to true, response will include confirmation if the customer
      ## has PayPal and/or Venmo accounts if they are eligible payment methods. Value
      ## defaults to false.
    include_vault_tokens*: Option[bool]
      ## If this value is set to true, response will include vaulted token information if
      ## the eligible funding source has any instrument vaulted for the customer. Value
      ## defaults to false.
    payment_source_constraint*: Option[JsonNode]
      ## Payment source constraint defines the payment methods that needs to be
      ## included/excluded for eligibility assessment. If not passed, all payment methods
      ## will be assessed for eligibility.

  FindEligibleMethodsRequest* = ref object of RootObj
    ## Request to get list of eligible payment methods.
    customer*: Option[FindEligibleMethodsRequestCustomer]
    purchase_units*: Option[seq[EligibilityPurchaseUnitRequest]]
      ## Array of purchase units.
    preferences*: Option[FindEligibleMethodsRequestPreferences]

  CreditProductButtonCode* = enum
    ## The button code corresponding to a particular product or set of products. The
    ## values followed are defined by the SDK team.
    CREDIT = "CREDIT"
    PAYLATER = "PAYLATER"
    PAYIN3 = "PAY_IN_3"
    PAYIN4 = "PAY_IN_4"

  PaymentMethodCommon* = ref object of RootObj
    ## Common response fields for all payment methods.
    can_be_vaulted*: Option[bool]
      ## Indicates if the payment method can be vaulted or not. A true value indicates
      ## the payment method can be vaulted using our vaults product. If false, vaulting
      ## is not currently supported for this payment method.
    country_code*: Option[JsonNode]
    product_code*: Option[JsonNode]

  PaymentMethodEligibleInPaypalNetwork* = bool

  Paypal* = ref object of RootObj
    ## Response for PayPal.
    can_be_vaulted*: Option[bool]
      ## Indicates if the payment method can be vaulted or not. A true value indicates
      ## the payment method can be vaulted using our vaults product. If false, vaulting
      ## is not currently supported for this payment method.
    country_code*: Option[JsonNode]
    product_code*: Option[JsonNode]
    eligible_in_paypal_network*: Option[PaymentMethodEligibleInPaypalNetwork]
    recommended*: Option[bool]
      ## Indicates if the payment method is recommended or not. A true value indicates
      ## the customer is payment ready and this payment method may be presented upfront.
    recommended_priority*: Option[int64]
      ## This value is included in the response when recommended is true for a payment
      ## method. It indicates the priority of recommendation for payment readiness of
      ## eligible payment methods with lowest number taking the highest precedence.

  Venmo* = ref object of RootObj
    ## Response for Venmo.
    can_be_vaulted*: Option[bool]
      ## Indicates if the payment method can be vaulted or not. A true value indicates
      ## the payment method can be vaulted using our vaults product. If false, vaulting
      ## is not currently supported for this payment method.
    country_code*: Option[JsonNode]
    product_code*: Option[JsonNode]
    eligible_in_paypal_network*: Option[PaymentMethodEligibleInPaypalNetwork]
    recommended*: Option[bool]
      ## Indicates if the payment method is recommended or not. A true value indicates
      ## the customer is payment ready and this payment method may be presented upfront.
    recommended_priority*: Option[int64]
      ## This value is included in the response when recommended is true for a payment
      ## method. It indicates the priority of recommendation for payment readiness of
      ## eligible payment methods with lowest number taking the highest precedence.

  PaymentMethods* = ref object of RootObj
    ## List of payment methods.
    paypal*: Option[JsonNode]
    venmo*: Option[JsonNode]
    paypal_credit*: Option[JsonNode]
    paypal_pay_later*: Option[JsonNode]

  PayerBase* = ref object of RootObj
    ## The customer who approves and pays for the order. The customer is also known as
    ## the payer.
    email_address*: Option[JsonNode]
    payer_id*: Option[JsonNode]

  VenmoPaymentTokenInfo* = ref object of RootObj
    ## Payment Token info for Venmo payment source.
    user_name*: Option[string]
      ## The Venmo username, as chosen by the user.

  PaymentToken* = ref object of RootObj
    ## Vaulted instrument for a payment-method.
    id*: Option[string]
      ## The PayPal-generated ID for the vault token.
    payment_source*: Option[JsonNode]
      ## The vaulted payment method details.
    links*: Option[seq[LinkDescription]]
      ## An array of related [HATEOAS links](/api/rest/responses/#hateoas).

  FindEligibleMethodsResponse* = ref object of RootObj
    ## Eligible payment methods along with applicable vault tokens, if requested.
    eligible_methods*: Option[JsonNode]
    payment_tokens*: Option[seq[JsonNode]]
      ## Payment tokens for vaulted instruments, if available. This object will be
      ## included only if include_vault_tokens is set to true in the request.
