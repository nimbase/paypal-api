import std/[options, json]

type
  Status400* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  Status401* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  Status403* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  Status404* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  Status422* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  AccountId* = string

  AmountWithBreakdown* = ref object of RootObj
    ## The breakdown details for the amount. Includes the gross, tax, fee, and shipping
    ## amounts.
    gross_amount*: Money
    total_item_amount*: Option[Money]
    fee_amount*: Option[Money]
    shipping_amount*: Option[Money]
    tax_amount*: Option[Money]
    net_amount*: Option[Money]

  ApplicationContext* = ref object of RootObj
    ## The application context, which customizes the payer experience during the
    ## subscription approval process with PayPal.
    brand_name*: Option[string]
      ## The label that overrides the business name in the PayPal account on the PayPal
      ## site.
    locale*: Option[Language]
    shipping_preference*: Option[string]
      ## The location from which the shipping address is derived.
    user_action*: Option[string]
      ## Configures the label name to `Continue` or `Subscribe Now` for subscription
      ## consent experience.
    payment_method*: Option[JsonNode]
      ## The customer and merchant payment preferences.
    return_url*: string
      ## The URL where the customer is redirected after the customer approves the
      ## payment.
    cancel_url*: string
      ## The URL where the customer is redirected after the customer cancels the payment.

  AuthenticationResponse* = ref object of RootObj
    ## Results of Authentication such as 3D Secure.
    liability_shift*: Option[LiabilityShift]
    three_d_secure*: Option[ThreeDSecureAuthenticationResponse]

  BillingCycle* = ref object of RootObj
    ## The billing cycle details.
    pricing_scheme*: Option[PricingScheme]
    frequency*: Frequency
    tenure_type*: string
      ## The tenure type of the billing cycle. In case of a plan having trial cycle, only
      ## 2 trial cycles are allowed per plan.
    sequence*: int64
      ## The order in which this cycle is to run among other billing cycles. For example,
      ## a trial billing cycle has a `sequence` of `1` while a regular billing cycle has
      ## a `sequence` of `2`, so that trial cycle runs before the regular cycle.
    total_cycles*: Option[int64]
      ## The number of times this billing cycle gets executed. Trial billing cycles can
      ## only be executed a finite number of times (value between <code>1</code> and
      ## <code>999</code> for <code>total_cycles</code>). Regular billing cycles can be
      ## executed infinite times (value of <code>0</code> for <code>total_cycles</code>)
      ## or a finite number of times (value between <code>1</code> and <code>999</code>
      ## for <code>total_cycles</code>).

  BillingCycleList* = seq[BillingCycle]

  BillingCycleOverride* = ref object of RootObj
    ## The billing cycle details to override at subscription level. The subscription
    ## billing cycle definition has to adhere to the plan billing cycle definition.
    pricing_scheme*: Option[PricingScheme]
    sequence*: int64
      ## The order in which this cycle is to run among other billing cycles. For example,
      ## a trial billing cycle has a `sequence` of `1` while a regular billing cycle has
      ## a `sequence` of `2`, so that trial cycle runs before the regular cycle.
    total_cycles*: Option[int64]
      ## The number of times this billing cycle gets executed. Trial billing cycles can
      ## only be executed a finite number of times (value between <code>1</code> and
      ## <code>999</code> for <code>total_cycles</code>). Regular billing cycles can be
      ## executed infinite times (value of <code>0</code> for <code>total_cycles</code>)
      ## or a finite number of times (value between <code>1</code> and <code>999</code>
      ## for <code>total_cycles</code>).

  BillingCycleOverrideList* = seq[BillingCycleOverride]

  BinDetails* = ref object of RootObj
    ## Bank Identification Number (BIN) details used to fund a payment.
    bin*: Option[string]
      ## The Bank Identification Number (BIN) signifies the number that is being used to
      ## identify the granular level details (except the PII information) of the card.
    issuing_bank*: Option[string]
      ## The issuer of the card instrument.
    bin_country_code*: Option[CountryCode2]
    products*: Option[ProductsList]

  CardAttributes* = ref object of RootObj
    ## Additional attributes associated with the use of this card.
    customer*: Option[Customer]
    vault*: Option[VaultInstructionBase]
    verification*: Option[CardVerification]

  CardAttributesResponse* = ref object of RootObj
    ## Additional attributes associated with the use of this card.
    vault*: Option[VaultResponse]

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
    UNKNOWN = "UNKNOWN"

  CardBrandList* = seq[CardBrand]

  CardFromRequest* = ref object of RootObj
    ## Representation of card details as received in the request.
    expiry*: Option[DateYearMonth]
    last_digits*: Option[string]
      ## The last digits of the payment card.

  CardResponse* = ref object of RootObj
    ## The payment card to use to fund a payment. Card can be a credit or debit card.
    name*: Option[string]
      ## The card holder's name as it appears on the card.
    last_digits*: Option[string]
      ## The last digits of the payment card.
    brand*: Option[CardBrand]
    available_networks*: Option[CardBrandList]
    `type`*: Option[CardType]
    authentication_result*: Option[AuthenticationResponse]
    attributes*: Option[CardAttributesResponse]
    from_request*: Option[CardFromRequest]
    expiry*: Option[DateYearMonth]
    bin_details*: Option[BinDetails]

  CardResponseWithBillingAddress* = ref object of RootObj
    name*: Option[string]
      ## The card holder's name as it appears on the card.
    last_digits*: Option[string]
      ## The last digits of the payment card.
    brand*: Option[CardBrand]
    available_networks*: Option[CardBrandList]
    `type`*: Option[CardType]
    authentication_result*: Option[AuthenticationResponse]
    attributes*: Option[CardAttributesResponse]
    from_request*: Option[CardFromRequest]
    expiry*: Option[DateYearMonth]
    bin_details*: Option[BinDetails]
    billing_address*: Option[JsonNode]
      ## The portable international postal address. Maps to[AddressValidationMetadata](h
      ## ttps://github.com/googlei18n/libaddressinput/wiki/AddressValidationMetadata) and
      ## HTML 5.1 [Autofilling form controls: the autocompleteattribute](https://www.w3.
      ## org/TR/html51/sec-forms.html#autofilling-form-controls-the-autocomplete-attribut
      ## e).
    currency_code*: Option[CurrencyCode]

  CardType* = enum
    ## Type of card. i.e Credit, Debit and so on.
    CREDIT = "CREDIT"
    DEBIT = "DEBIT"
    PREPAID = "PREPAID"
    STORE = "STORE"
    UNKNOWN2 = "UNKNOWN"

  CardVerification* = ref object of RootObj
    ## The API caller can opt in to verify the card through PayPal offered verification
    ## services (e.g. Smart Dollar Auth, 3DS).
    `method`*: Option[string]
      ## The method used for card verification.

  CountryCode* = string

  CountryCode2* = string

  CurrencyCode* = string

  Customer* = ref object of RootObj
    ## The details about a customer in PayPal's system of record.
    id*: Option[MerchantPartnerCustomerId]
    email_address*: Option[Email]
    phone*: Option[PhoneWithType]

  CycleExecution* = ref object of RootObj
    ## The regular and trial execution details for a billing cycle.
    tenure_type*: string
      ## The type of the billing cycle.
    sequence*: int64
      ## The order in which to run this cycle among other billing cycles.
    cycles_completed*: int64
      ## The number of billing cycles that have completed.
    cycles_remaining*: Option[int64]
      ## For a finite billing cycle, cycles_remaining is the number of remaining cycles.
      ## For an infinite billing cycle, cycles_remaining is set as 0.
    current_pricing_scheme_version*: Option[int64]
      ## The active pricing scheme version for the billing cycle.
    total_cycles*: Option[int64]
      ## The number of times this billing cycle gets executed. Trial billing cycles can
      ## only be executed a finite number of times (value between <code>1</code> and
      ## <code>999</code> for <code>total_cycles</code>). Regular billing cycles can be
      ## executed infinite times (value of <code>0</code> for <code>total_cycles</code>)
      ## or a finite number of times (value between <code>1</code> and <code>999</code>
      ## for <code>total_cycles</code>).

  CycleExecutionList* = seq[CycleExecution]

  DateTime* = string

  DateYearMonth* = string

  DefinitionsLinkDescriptionList* = seq[LinkDescription]

  Email* = string

  EmailAddress* = string

  Enrolled* = enum
    ## Status of Authentication eligibility.
    Y = "Y"
    N = "N"
    U = "U"
    B = "B"

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

  FailedPaymentDetails* = ref object of RootObj
    ## The details for the failed payment of the subscription.
    amount*: Money
    time*: DateTime
    reason_code*: Option[string]
      ## The reason code for the payment failure.
    next_payment_retry_time*: Option[DateTime]

  Frequency* = ref object of RootObj
    ## The frequency of the billing cycle.
    interval_unit*: string
      ## The interval at which the subscription is charged or billed.
    interval_count*: Option[int64]
      ## The number of intervals after which a subscriber is billed. For example, if the
      ## `interval_unit` is `DAY` with an `interval_count` of  `2`, the subscription is
      ## billed once every two days. The following table lists the maximum allowed values
      ## for the `interval_count` for each
      ## `interval_unit`:<table><thead><tr><th><code>Interval unit</code></th><th>Maximum
      ## interval count</th></tr></thead><tbody><tr><td><code>DAY</code></td><td
      ## align="right">365</td></tr><tr><td><code>WEEK</code></td><td
      ## align="right">52</td></tr><tr><td><code>MONTH</code></td><td
      ## align="right">12</td></tr><tr><td><code>YEAR</code></td><td
      ## align="right">1</td></tr></tbody></table>

  Language* = string

  LastPaymentDetails* = ref object of RootObj
    ## The details for the last payment.
    amount*: Money
    time*: DateTime

  LiabilityShift* = enum
    ## Liability shift indicator. The outcome of the issuer's authentication.
    NO = "NO"
    POSSIBLE = "POSSIBLE"
    UNKNOWN3 = "UNKNOWN"

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

  MerchantInventory* = ref object of RootObj

  MerchantPartnerCustomerId* = string

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
    full_name*: Option[string]
      ## When the party is a person, the party's full name.

  ParesStatus* = enum
    ## Transactions status result identifier. The outcome of the issuer's
    ## authentication.
    Y2 = "Y"
    N2 = "N"
    U2 = "U"
    A = "A"
    C = "C"
    R = "R"
    D = "D"
    I = "I"

  Patch* = ref object of RootObj
    ## The JSON patch object to apply partial updates to resources.
    op*: string
      ## The operation.
    path*: Option[string]
      ## The <a href="https://tools.ietf.org/html/rfc6901">JSON Pointer</a> to the target
      ## document location at which to complete the operation.
    value*: Option[JsonNode]
      ## The value to apply. The <code>remove</code>, <code>copy</code>, and
      ## <code>move</code> operations do not require a value. Since <a
      ## href="https://www.rfc-editor.org/rfc/rfc69021">JSON Patch</a> allows any type
      ## for <code>value</code>, the <code>type</code> property is not specified.
    `from`*: Option[string]
      ## The <a href="https://tools.ietf.org/html/rfc6901">JSON Pointer</a> to the target
      ## document location from which to move the value. Required for the
      ## <code>move</code> operation.

  PatchRequest* = seq[Patch]

  PayeePaymentMethodPreference* = enum
    ## The merchant-preferred payment methods.
    UNRESTRICTED = "UNRESTRICTED"
    IMMEDIATEPAYMENTREQUIRED = "IMMEDIATE_PAYMENT_REQUIRED"

  PayerBase* = ref object of RootObj
    ## The customer who approves and pays for the order. The customer is also known as
    ## the payer.
    email_address*: Option[Email]
    payer_id*: Option[AccountId]

  PaymentPreferences* = ref object of RootObj
    ## The payment preferences for a subscription.
    auto_bill_outstanding*: Option[bool]
      ## Indicates whether to automatically bill the outstanding amount in the next
      ## billing cycle.
    setup_fee*: Option[Money]
    setup_fee_failure_action*: Option[string]
      ## The action to take on the subscription if the initial payment for the setup
      ## fails.
    payment_failure_threshold*: Option[int64]
      ## The maximum number of payment failures before a subscription is suspended. For
      ## example, if `payment_failure_threshold` is `2`, the subscription automatically
      ## updates to the `SUSPEND` state if two consecutive payments fail.

  PaymentPreferencesOverride* = ref object of RootObj
    ## The payment preferences to override at subscription level.
    auto_bill_outstanding*: Option[bool]
      ## Indicates whether to automatically bill the outstanding amount in the next
      ## billing cycle.
    setup_fee*: Option[Money]
    setup_fee_failure_action*: Option[string]
      ## The action to take on the subscription if the initial payment for the setup
      ## fails.
    payment_failure_threshold*: Option[int64]
      ## The maximum number of payment failures before a subscription is suspended. For
      ## example, if `payment_failure_threshold` is `2`, the subscription automatically
      ## updates to the `SUSPEND` state if two consecutive payments fail.

  PaymentSource* = ref object of RootObj
    ## The payment source definition. To be eligible to create subscription using debit
    ## or credit card, you will need to sign up here
    ## (https://www.paypal.com/bizsignup/entry/product/ppcp). Please note, its
    ## available only for non-3DS cards and for merchants in US and AU regions.
    card*: Option[JsonNode]
      ## The payment card to use to fund a payment. Can be a credit or debit card.

  PaymentSourceResponse* = ref object of RootObj
    ## The payment source used to fund the payment.
    card*: Option[CardResponseWithBillingAddress]

  Percentage* = string

  PhoneType* = enum
    ## The phone type.
    FAX = "FAX"
    HOME = "HOME"
    MOBILE = "MOBILE"
    OTHER = "OTHER"
    PAGER = "PAGER"

  PhoneWithType* = ref object of RootObj
    ## The phone information.
    phone_type*: Option[PhoneType]
    phone_number*: JsonNode
      ## The phone number, in its canonical international [E.164 numbering plan
      ## format](https://www.itu.int/rec/T-REC-E.164/en).

  Plan* = ref object of RootObj
    ## The plan details.
    id*: Option[string]
      ## The unique PayPal-generated ID for the plan.
    product_id*: Option[string]
      ## The ID for the product.
    name*: Option[string]
      ## The plan name.
    status*: Option[string]
      ## The plan status.
    description*: Option[string]
      ## The detailed description of the plan.
    billing_cycles*: Option[BillingCycleList]
    payment_preferences*: Option[PaymentPreferences]
    taxes*: Option[Taxes]
    quantity_supported*: Option[bool]
      ## Indicates whether you can subscribe to this plan by providing a quantity for the
      ## goods or service.
    create_time*: Option[DateTime]
    update_time*: Option[DateTime]
    links*: Option[LinkDescriptionList]

  PlanCollection* = ref object of RootObj
    ## The list of plans with details.
    plans*: Option[PlanList]
    total_items*: Option[int64]
      ## The total number of items.
    total_pages*: Option[int64]
      ## The total number of pages.
    links*: Option[LinkDescriptionList]

  PlanList* = seq[Plan]

  PlanOverride* = ref object of RootObj
    ## An inline plan object to customise the subscription. You can override plan level
    ## default attributes by providing customised values for the subscription in this
    ## object.
    billing_cycles*: Option[BillingCycleOverrideList]
    payment_preferences*: Option[PaymentPreferencesOverride]
    taxes*: Option[TaxesOverride]

  PlanRequestPOST* = ref object of RootObj
    ## The create plan request details.
    product_id*: string
      ## The ID of the product created through Catalog Products API.
    name*: string
      ## The plan name.
    status*: Option[string]
      ## The initial state of the plan. Allowed input values are CREATED and ACTIVE.
    description*: Option[string]
      ## The detailed description of the plan.
    billing_cycles*: BillingCycleList
    payment_preferences*: PaymentPreferences
    taxes*: Option[Taxes]
    quantity_supported*: Option[bool]
      ## Indicates whether you can subscribe to this plan by providing a quantity for the
      ## goods or service.

  PlansActivate422* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  PlansCreate400* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  PlansDeactivate422* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  PlansPatch400* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  PlansPatch422* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  PlansUpdatePricingSchemes400* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  PlansUpdatePricingSchemes422* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  PricingScheme* = ref object of RootObj
    ## The pricing scheme details.
    version*: Option[int64]
      ## The version of the pricing scheme.
    fixed_price*: Option[Money]
    pricing_model*: Option[string]
      ## The pricing model for tiered plan. The `tiers` parameter is required.
    tiers*: Option[PricingTierList]
    create_time*: Option[DateTime]
    update_time*: Option[DateTime]

  PricingTier* = ref object of RootObj
    ## The pricing tier details.
    starting_quantity*: string
      ## The starting quantity for the tier.
    ending_quantity*: Option[string]
      ## The ending quantity for the tier. Optional for the last tier.
    amount*: Money

  PricingTierList* = seq[PricingTier]

  Products* = string

  ProductsList* = seq[Products]

  ShippingDetail* = ref object of RootObj
    ## The shipping details.
    name*: Option[JsonNode]
      ## The name of the party.
    `type`*: Option[string]
      ## A classification for the method of purchase fulfillment (e.g shipping, in-store
      ## pickup, etc). Either `type` or `options` may be present, but not both.
    options*: Option[ShippingOptionList]
    address*: Option[JsonNode]
      ## The portable international postal address. Maps to[AddressValidationMetadata](h
      ## ttps://github.com/googlei18n/libaddressinput/wiki/AddressValidationMetadata) and
      ## HTML 5.1 [Autofilling form controls: the autocompleteattribute](https://www.w3.
      ## org/TR/html51/sec-forms.html#autofilling-form-controls-the-autocomplete-attribut
      ## e).

  ShippingOption* = ref object of RootObj
    ## The options that the payee or merchant offers to the payer to ship or pick up
    ## their items.
    id*: string
      ## A unique ID that identifies a payer-selected shipping option.
    label*: string
      ## A description that the payer sees, which helps them choose an appropriate
      ## shipping option. For example, `Free Shipping`, `USPS Priority Shipping`,
      ## `Expédition prioritaire USPS`, or `USPS yōuxiān fā huò`. Localize this
      ## description to the payer's locale.
    `type`*: Option[ShippingType]
    amount*: Option[Money]
    selected*: bool
      ## If the API request sets `selected = true`, it represents the shipping option
      ## that the payee or merchant expects to be pre-selected for the payer when they
      ## first view the `shipping.options` in the PayPal Checkout experience. As part of
      ## the response if a `shipping.option` contains `selected=true`, it represents the
      ## shipping option that the payer selected during the course of checkout with
      ## PayPal. Only one `shipping.option` can be set to `selected=true`.

  ShippingOptionList* = seq[ShippingOption]

  ShippingType* = enum
    ## A classification for the method of purchase fulfillment.
    SHIPPING = "SHIPPING"
    PICKUP = "PICKUP"
    PICKUPINSTORE = "PICKUP_IN_STORE"
    PICKUPFROMPERSON = "PICKUP_FROM_PERSON"

  StoreInVaultInstruction* = enum
    ## Defines how and when the payment source gets vaulted.
    ONSUCCESS = "ON_SUCCESS"

  Subscriber* = ref object of RootObj
    email_address*: Option[Email]
    payer_id*: Option[AccountId]
    name*: Option[JsonNode]
      ## The name of the party.
    phone*: Option[PhoneWithType]
    shipping_address*: Option[ShippingDetail]
    payment_source*: Option[PaymentSourceResponse]

  SubscriberRequest* = ref object of RootObj
    email_address*: Option[Email]
    payer_id*: Option[AccountId]
    name*: Option[JsonNode]
      ## The name of the party.
    phone*: Option[PhoneWithType]
    shipping_address*: Option[ShippingDetail]
    payment_source*: Option[PaymentSource]

  Subscription* = ref object of RootObj
    status*: Option[string]
      ## The status of the subscription.
    status_change_note*: Option[string]
      ## The reason or notes for the status of the subscription.
    status_update_time*: Option[DateTime]
    id*: Option[string]
      ## The PayPal-generated ID for the subscription.
    plan_id*: Option[string]
      ## The ID of the plan.
    start_time*: Option[DateTime]
    quantity*: Option[string]
      ## The quantity of the product in the subscription.
    shipping_amount*: Option[Money]
    subscriber*: Option[Subscriber]
    billing_info*: Option[SubscriptionBillingInfo]
    create_time*: Option[DateTime]
    update_time*: Option[DateTime]
    custom_id*: Option[string]
      ## The custom id for the subscription. Can be invoice id.
    plan_overridden*: Option[bool]
      ## Indicates whether the subscription has overridden any plan attributes.
    plan*: Option[JsonNode]
      ## The plan details.
    links*: Option[LinkDescriptionList]

  SubscriptionActivateRequest* = ref object of RootObj
    ## The activate subscription request details.
    reason*: Option[string]
      ## The reason for activation of a subscription. Required to reactivate the
      ## subscription.

  SubscriptionBillingInfo* = ref object of RootObj
    ## The billing details for the subscription. If the subscription was or is active,
    ## these fields are populated.
    outstanding_balance*: Money
    cycle_executions*: Option[CycleExecutionList]
    last_payment*: Option[LastPaymentDetails]
    next_billing_time*: Option[DateTime]
    final_payment_time*: Option[DateTime]
    failed_payments_count*: int64
      ## The number of consecutive payment failures. Resets to `0` after a successful
      ## payment. If this reaches the `payment_failure_threshold` value, the subscription
      ## updates to the `SUSPENDED` state.
    last_failed_payment*: Option[FailedPaymentDetails]

  SubscriptionCancelRequest* = ref object of RootObj
    ## The cancel subscription request details.
    reason*: string
      ## The reason for the cancellation of a subscription.

  SubscriptionCaptureRequest* = ref object of RootObj
    ## The charge amount from the subscriber.
    note*: string
      ## The reason or note for the subscription charge.
    capture_type*: string
      ## The type of capture.
    amount*: Money

  SubscriptionRequestPost* = ref object of RootObj
    ## The create subscription request details.
    plan_id*: string
      ## The ID of the plan.
    start_time*: Option[DateTime]
    quantity*: Option[string]
      ## The quantity of the product in the subscription.
    shipping_amount*: Option[Money]
    subscriber*: Option[SubscriberRequest]
    auto_renewal*: Option[bool]
      ## DEPRECATED. Indicates whether the subscription auto-renews after the billing
      ## cycles complete.
    application_context*: Option[ApplicationContext]
    custom_id*: Option[string]
      ## The custom id for the subscription. Can be invoice id.
    plan*: Option[PlanOverride]
    merchant_inventory*: Option[MerchantInventory]

  SubscriptionReviseRequest* = ref object of RootObj
    ## The request to update the quantity of the product or service in a subscription.
    ## You can also use this method to switch the plan and update the `shipping_amount`
    ## and `shipping_address` values for the subscription. This type of update requires
    ## the buyer's consent.
    plan_id*: Option[string]
      ## The unique PayPal-generated ID for the plan.
    quantity*: Option[string]
      ## The quantity of the product or service in the subscription.
    shipping_amount*: Option[Money]
    shipping_address*: Option[ShippingDetail]
    application_context*: Option[JsonNode]
      ## The application context, which customizes the payer experience during the
      ## subscription approval process with PayPal.
    plan*: Option[PlanOverride]

  SubscriptionReviseResponse* = ref object of RootObj
    ## The response to a request to update the quantity of the product or service in a
    ## subscription. You can also use this method to switch the plan and update the
    ## `shipping_amount` and `shipping_address` values for the subscription. This type
    ## of update requires the buyer's consent.
    plan_id*: Option[string]
      ## The unique PayPal-generated ID for the plan.
    quantity*: Option[string]
      ## The quantity of the product or service in the subscription.
    shipping_amount*: Option[Money]
    shipping_address*: Option[ShippingDetail]
    plan*: Option[PlanOverride]
    plan_overridden*: Option[bool]
      ## Indicates whether the subscription has overridden any plan attributes.
    links*: Option[SubscriptionReviseResponseDefinitionsLinkDescriptionList]

  SubscriptionReviseResponseDefinitionsLinkDescriptionList* = seq[LinkDescription]

  SubscriptionStatus* = ref object of RootObj
    ## The subscription status details.
    status*: Option[string]
      ## The status of the subscription.
    status_change_note*: Option[string]
      ## The reason or notes for the status of the subscription.
    status_update_time*: Option[DateTime]

  SubscriptionSuspendRequest* = ref object of RootObj
    ## The suspend subscription request details.
    reason*: string
      ## The reason for suspension of the Subscription.

  SubscriptionsActivate400* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  SubscriptionsActivate422* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  SubscriptionsCancel400* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  SubscriptionsCancel422* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  SubscriptionsCapture400* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  SubscriptionsCapture422* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  SubscriptionsCreate400* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  SubscriptionsCreate422* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  SubscriptionsPatch400* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  SubscriptionsPatch422* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  SubscriptionsRevise400* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  SubscriptionsRevise404* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  SubscriptionsRevise422* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  SubscriptionsSuspend400* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  SubscriptionsSuspend422* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  SubscriptionsTransactions400* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  Taxes* = ref object of RootObj
    ## The tax details.
    percentage*: Percentage
    inclusive*: Option[bool]
      ## Indicates whether the tax was already included in the billing amount.

  TaxesOverride* = ref object of RootObj
    ## The tax details.
    percentage*: Option[Percentage]
    inclusive*: Option[bool]
      ## Indicates whether the tax was already included in the billing amount.

  ThreeDSecureAuthenticationResponse* = ref object of RootObj
    ## Results of 3D Secure Authentication.
    authentication_status*: Option[ParesStatus]
    enrollment_status*: Option[Enrolled]

  Transaction* = ref object of RootObj
    ## The transaction details.
    status*: Option[string]
      ## The status of the captured payment.
    id*: string
      ## The PayPal-generated transaction ID.
    amount_with_breakdown*: AmountWithBreakdown
    payer_name*: Option[Name]
    payer_email*: Option[EmailAddress]
    time*: DateTime

  TransactionList* = seq[Transaction]

  TransactionsList* = ref object of RootObj
    ## The list transactions for a subscription request details.
    transactions*: Option[TransactionList]
    total_items*: Option[int64]
      ## The total number of items.
    total_pages*: Option[int64]
      ## The total number of pages.
    links*: Option[LinkDescriptionList]

  UpdatePricingSchemeRequest* = ref object of RootObj
    ## The update pricing scheme request details.
    billing_cycle_sequence*: int64
      ## The billing cycle sequence.
    pricing_scheme*: PricingScheme

  UpdatePricingSchemeRequestList* = seq[UpdatePricingSchemeRequest]

  UpdatePricingSchemesListRequest* = ref object of RootObj
    ## The update pricing scheme request details.
    pricing_schemes*: UpdatePricingSchemeRequestList

  VaultInstructionBase* = ref object of RootObj
    ## Basic vault instruction specification that can be extended by specific payment
    ## sources that supports vaulting.
    store_in_vault*: Option[StoreInVaultInstruction]

  VaultResponse* = ref object of RootObj
    ## The details about a saved payment source.
    id*: Option[string]
      ## The PayPal-generated ID for the saved payment source.
    status*: Option[string]
      ## The vault status.
    customer*: Option[JsonNode]
      ## The details about a customer in PayPal's system of record.
    links*: Option[DefinitionsLinkDescriptionList]
