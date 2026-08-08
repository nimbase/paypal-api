import std/[options, json]

type
  AccountId* = string

  ApplePayPaymentTokenResponse* = ref object of RootObj
    ## A resource representing a response for Apple Pay.
    card*: Option[JsonNode]
      ## The payment card to be used to fund a payment. Can be a credit or debit card.

  BillingCycle* = ref object of RootObj
    ## The billing cycle providing details of the billing frequency, amount, duration
    ## and if the billing cycle is a free, discounted or regular billing cycle. The
    ## sequence of the billing cycle will be in the following order - free trial
    ## billing cycle(s), discounted trial billing cycle(s), regular billing cycle(s).
    tenure_type*: string
      ## The tenure type of the billing cycle identifies if the billing cycle is a
      ## trial(free or discounted) or regular billing cycle.
    pricing_scheme*: Option[PricingScheme]
    frequency*: Option[Frequency]
    total_cycles*: Option[int32]
      ## The number of times this billing cycle gets executed. Trial billing cycles can
      ## only be executed a finite number of times (value between <code>1</code> and
      ## <code>999</code> for <code>total_cycles</code>). Regular billing cycles can be
      ## executed infinite times (value of <code>0</code> for <code>total_cycles</code>)
      ## or a finite number of times (value between <code>1</code> and <code>999</code>
      ## for <code>total_cycles</code>).
    sequence*: Option[int32]
      ## The order in which this cycle is to run among other billing cycles. For example,
      ## a trial billing cycle has a `sequence` of `1` while a regular billing cycle has
      ## a `sequence` of `2`, so that trial cycle runs before the regular cycle.
    start_date*: Option[DateNoTime]

  BillingCycleList* = seq[BillingCycle]

  BinDetails* = ref object of RootObj
    ## Bank Identification Number (BIN) details used to fund a payment.
    bin*: Option[string]
      ## The Bank Identification Number (BIN) signifies the number that is being used to
      ## identify the granular level details (except the PII information) of the card.
    issuing_bank*: Option[string]
      ## The issuer of the card instrument.
    bin_country_code*: Option[CountryCode2]
    products*: Option[ProductsList]

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
    UNKNOWN = "UNKNOWN"

  CardResponse* = ref object of RootObj
    ## Full representation of a Card Payment Token including network token.
    name*: Option[string]
      ## The card holder's name as it appears on the card.
    last_digits*: Option[string]
      ## The last digits of the payment card.
    brand*: Option[CardBrand]
    expiry*: Option[DateYearMonth]
    billing_address*: Option[JsonNode]
      ## Address request details.
    verification_status*: Option[CardVerificationStatus]
    verification*: Option[CardVerificationDetails]
    network_transaction_reference*: Option[NetworkTransactionReferenceResponse]
    authentication_result*: Option[JsonNode]
      ## Results of Authentication such as 3D Secure.
    bin_details*: Option[BinDetails]
    `type`*: Option[CardType]
    network_token*: Option[NetworkTokenEntity]

  CardResponseEntity* = ref object of RootObj
    ## Full representation of a Card Payment Token.
    name*: Option[string]
      ## The card holder's name as it appears on the card.
    last_digits*: Option[string]
      ## The last digits of the payment card.
    brand*: Option[CardBrand]
    expiry*: Option[DateYearMonth]
    billing_address*: Option[JsonNode]
      ## Address request details.
    verification_status*: Option[CardVerificationStatus]
    verification*: Option[CardVerificationDetails]
    network_transaction_reference*: Option[NetworkTransactionReferenceResponse]
    authentication_result*: Option[JsonNode]
      ## Results of Authentication such as 3D Secure.
    bin_details*: Option[BinDetails]
    `type`*: Option[CardType]

  CardType* = enum
    ## Type of card. i.e Credit, Debit and so on.
    CREDIT = "CREDIT"
    DEBIT = "DEBIT"
    PREPAID = "PREPAID"
    STORE = "STORE"
    UNKNOWN2 = "UNKNOWN"

  CardVerificationDetails* = ref object of RootObj
    ## Card Verification details including the authorization details and 3D SECURE
    ## details.
    network_transaction_id*: Option[string]
      ## DEPRECATED. This field is DEPRECATED. Please find the network transaction id
      ## data in the 'id' field under the 'network_transaction_reference' object instead
      ## of the 'verification' object.
    date*: Option[string]
      ## DEPRECATED. This field is DEPRECATED. Please find the date data in the 'date'
      ## field under the 'network_transaction_reference' object instead of the
      ## 'verification' object.
    network*: Option[CardBrand]
    time*: Option[DateTime]
    amount*: Option[Money]
    processor_response*: Option[JsonNode]
      ## The processor response information for payment requests, such as direct credit
      ## card transactions.
    three_d_secure*: Option[JsonNode]
      ## DEPRECATED. This field is DEPRECATED. Please find the 3D secure authentication
      ## data in the 'three_d_secure' object under the 'authentication_result' object
      ## instead of the 'verification' object.

  CardVerificationMethod* = enum
    ## The verification method of the card.
    SCAWHENREQUIRED = "SCA_WHEN_REQUIRED"
    SCAALWAYS = "SCA_ALWAYS"

  CardVerificationStatus* = enum
    ## Verification status of Card.
    VERIFIED = "VERIFIED"
    FAILED = "FAILED"

  CountryCode* = string

  CountryCode2* = string

  CurrencyCode* = string

  Customer* = ref object of RootObj
    ## This object defines a customer in your system. Use it to manage customer
    ## profiles, save payment methods and contact details.
    id*: Option[MerchantPartnerCustomerId]
    merchant_customer_id*: Option[string]
      ## Merchants and partners may already have a data-store where their customer
      ## information is persisted. Use merchant_customer_id to associate the
      ## PayPal-generated customer.id to your representation of a customer.

  CustomerVaultPaymentTokensResponse* = ref object of RootObj
    ## Collection of payment tokens saved for a given customer.
    total_items*: Option[int64]
      ## Total number of items.
    total_pages*: Option[int64]
      ## Total number of pages.
    customer*: Option[JsonNode]
      ## This object defines a customer in your system. Use it to manage customer
      ## profiles, save payment methods and contact details.
    payment_tokens*: Option[PaymentTokenResponseList]
    links*: Option[LinkDescriptionList]

  DateNoTime* = string

  DateTime* = string

  DateYearMonth* = string

  DefinitionsLinkDescriptionList* = seq[LinkDescription]

  DefinitionsPaymentSource* = ref object of RootObj
    ## The payment method to vault with the instrument details.
    card*: Option[JsonNode]
      ## A Resource representing a request to vault a Card.
    token*: Option[TokenIdRequest]

  Email* = string

  Enrolled* = enum
    ## Status of Authentication eligibility.
    Y = "Y"
    N = "N"
    U = "U"
    B = "B"

  Error* = ref object of RootObj
    ## The error details.
    name*: string
      ## The human-readable, unique name of the error.
    message*: string
      ## The message that describes the error.
    debug_id*: string
      ## The PayPal internal ID. Used for correlation purposes.
    details*: Option[ErrorDetailsList]
    links*: Option[ErrorDefinitionsLinkDescriptionList]

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

  ErrorDefinitionsLinkDescriptionList* = seq[LinkDescription]

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

  ErrorDetails2* = ref object of RootObj
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
    links*: Option[DefinitionsLinkDescriptionList]
    description*: Option[string]
      ## The human-readable description for an issue. The description can change over the
      ## lifetime of an API, so clients must not depend on this value.

  ErrorDetailsList* = seq[ErrorDetails2]

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

  ExperienceContext* = ref object of RootObj
    ## Customizes the Vault creation flow experience for your customers.
    brand_name*: Option[string]
      ## The label that overrides the business name in the PayPal account on the PayPal
      ## site. The pattern is defined by an external party and supports Unicode.
    locale*: Option[Language]
    return_url*: Option[string]
      ## The URL where the customer is redirected after customer approves leaves the
      ## flow. It is a required field for contingency flows like PayPal wallet, 3DS.
    cancel_url*: Option[string]
      ## The URL where the customer is redirected after customer cancels or leaves the
      ## flow. It is a required field for contingency flows like PayPal wallet, 3DS.
    shipping_preference*: Option[string]
      ## The shipping preference. This only applies to PayPal payment source.
    vault_instruction*: Option[VaultInstruction]

  Frequency* = ref object of RootObj

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

  NetworkTokenEntity* = ref object of RootObj

  NetworkTransactionReferenceEntity* = ref object of RootObj
    ## Previous network transaction reference including id and network.
    id*: string
      ## Transaction reference id returned by the scheme. For Visa and Amex, this is the
      ## "Tran id" field in response. For MasterCard, this is the "BankNet reference id"
      ## field in response. For Discover, this is the "NRID" field in response. The
      ## pattern we expect for this field from Visa/Amex/CB/Discover is numeric,
      ## Mastercard/BNPP is alphanumeric and Paysecure is alphanumeric with special
      ## character -.
    date*: Option[string]
      ## The date that the transaction was authorized by the scheme. This field may not
      ## be returned for all networks. MasterCard refers to this field as "BankNet
      ## reference date.
    network*: Option[CardBrand]
    time*: Option[DateTime]

  NetworkTransactionReferenceRequest* = ref object of RootObj

  NetworkTransactionReferenceResponse* = ref object of RootObj
    ## Previous network transaction reference including id in response.
    id*: string
      ## Transaction reference id returned by the scheme. For Visa and Amex, this is the
      ## "Tran id" field in response. For MasterCard, this is the "BankNet reference id"
      ## field in response. For Discover, this is the "NRID" field in response. The
      ## pattern we expect for this field from Visa/Amex/CB/Discover is numeric,
      ## Mastercard/BNPP is alphanumeric and Paysecure is alphanumeric with special
      ## character -.
    date*: Option[string]
      ## The date that the transaction was authorized by the scheme. This field may not
      ## be returned for all networks. MasterCard refers to this field as "BankNet
      ## reference date.
    network*: Option[CardBrand]
    time*: Option[DateTime]

  OneTimeCharges* = ref object of RootObj
    ## The one-time charge info at the time of checkout.
    setup_fee*: Option[Money]
    shipping_amount*: Option[Money]
    taxes*: Option[Money]
    product_price*: Option[Money]
    subtotal*: Option[Money]
    total_amount*: Money

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

  PayerBase* = ref object of RootObj
    ## The customer who approves and pays for the order. The customer is also known as
    ## the payer.
    email_address*: Option[Email]
    payer_id*: Option[AccountId]

  PaymentSource* = ref object of RootObj
    ## The vaulted payment method details.
    card*: Option[CardResponse]
    paypal*: Option[PaypalWalletResponse]
    venmo*: Option[VenmoResponse]
    apple_pay*: Option[ApplePayPaymentTokenResponse]

  PaymentTokenRequest* = ref object of RootObj
    ## Payment Token Request where the `source` defines the type of instrument to be
    ## stored.
    customer*: Option[JsonNode]
      ## This object defines a customer in your system. Use it to manage customer
      ## profiles, save payment methods and contact details.
    payment_source*: DefinitionsPaymentSource

  PaymentTokenResponse* = ref object of RootObj
    ## Full representation of a saved payment token.
    id*: Option[VaultId]
    customer*: Option[Customer]
    payment_source*: Option[PaymentSource]
    links*: Option[LinkDescriptionList]

  PaymentTokenResponseList* = seq[PaymentTokenResponse]

  PaymentTokenStatus* = enum
    ## The status of the payment token.
    CREATED = "CREATED"
    PAYERACTIONREQUIRED = "PAYER_ACTION_REQUIRED"
    APPROVED = "APPROVED"
    VAULTED = "VAULTED"
    TOKENIZED = "TOKENIZED"

  PaypalWalletRequest* = ref object of RootObj
    ## A resource representing a request to vault PayPal Wallet.
    description*: Option[string]
      ## The description displayed to the consumer on the approval flow for a digital
      ## wallet, as well as on the merchant view of the payment token management
      ## experience. exp: PayPal.com.
    usage_pattern*: Option[string]
      ## Expected business/charge model for the billing agreement.
    shipping*: Option[JsonNode]
      ## The shipping details.
    permit_multiple_payment_tokens*: Option[bool]
      ## Create multiple payment tokens for the same payer, merchant/platform
      ## combination. Use this when the customer has not logged in at merchant/platform.
      ## The payment token thus generated, can then also be used to create the customer
      ## account at merchant/platform. Use this also when multiple payment tokens are
      ## required for the same payer, different customer at merchant/platform. This helps
      ## to identify customers distinctly even though they may share the same PayPal
      ## account. This only applies to PayPal payment source.
    usage_type*: Option[string]
      ## The usage type associated with a digital wallet payment token.
    customer_type*: Option[string]
      ## The customer type associated with a digital wallet payment token. This is to
      ## indicate whether the customer acting on the merchant / platform is either a
      ## business or a consumer.
    billing_plan*: Option[Plan]
    experience_context*: Option[ExperienceContext]

  PaypalWalletResponse* = ref object of RootObj
    description*: Option[string]
      ## The description displayed to the consumer on the approval flow for a digital
      ## wallet, as well as on the merchant view of the payment token management
      ## experience. exp: PayPal.com.
    usage_pattern*: Option[string]
      ## Expected business/charge model for the billing agreement.
    shipping*: Option[JsonNode]
      ## The shipping details.
    permit_multiple_payment_tokens*: Option[bool]
      ## Create multiple payment tokens for the same payer, merchant/platform
      ## combination. Use this when the customer has not logged in at merchant/platform.
      ## The payment token thus generated, can then also be used to create the customer
      ## account at merchant/platform. Use this also when multiple payment tokens are
      ## required for the same payer, different customer at merchant/platform. This helps
      ## to identify customers distinctly even though they may share the same PayPal
      ## account. This only applies to PayPal payment source.
    usage_type*: Option[string]
      ## The usage type associated with a digital wallet payment token.
    customer_type*: Option[string]
      ## The customer type associated with a digital wallet payment token. This is to
      ## indicate whether the customer acting on the merchant / platform is either a
      ## business or a consumer.
    email_address*: Option[Email]
    payer_id*: Option[AccountId]
    name*: Option[JsonNode]
      ## The name of the party.
    phone*: Option[PhoneWithType]
    address*: Option[JsonNode]
      ## The portable international postal address. Maps to[AddressValidationMetadata](h
      ## ttps://github.com/googlei18n/libaddressinput/wiki/AddressValidationMetadata) and
      ## HTML 5.1 [Autofilling form controls: the autocompleteattribute](https://www.w3.
      ## org/TR/html51/sec-forms.html#autofilling-form-controls-the-autocomplete-attribut
      ## e).
    account_id*: Option[AccountId]
    phone_number*: Option[Phone]

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
    ## The merchant level Recurring Billing plan metadata for the Billing Agreement.
    billing_cycles*: BillingCycleList
    product*: Option[ProductOverride]
    one_time_charges*: OneTimeCharges
    name*: Option[string]
      ## Name of the recurring plan.

  PricingScheme* = ref object of RootObj
    ## The pricing scheme details.
    price*: Option[Money]
    pricing_model*: string
      ## The pricing model for the billing cycle.
    reload_threshold_amount*: Option[Money]

  ProductOverride* = ref object of RootObj

  Products* = string

  ProductsList* = seq[Products]

  SetupTokenRequest* = ref object of RootObj
    ## Setup Token Request where the `source` defines the type of instrument to be
    ## stored.
    customer*: Option[JsonNode]
      ## This object defines a customer in your system. Use it to manage customer
      ## profiles, save payment methods and contact details.
    payment_source*: JsonNode
      ## The payment method to vault with the instrument details.

  SetupTokenResponse* = ref object of RootObj
    ## Minimal representation of a cached setup token.
    id*: Option[VaultId]
    customer*: Option[JsonNode]
      ## This object defines a customer in your system. Use it to manage customer
      ## profiles, save payment methods and contact details.
    status*: Option[PaymentTokenStatus]
    payment_source*: Option[JsonNode]
      ## The setup payment method details.
    links*: Option[LinkDescriptionList]

  ThreeDSecureAuthenticationResponse* = ref object of RootObj
    ## Results of 3D Secure Authentication.
    authentication_status*: Option[ParesStatus]
    enrollment_status*: Option[Enrolled]

  ThreeDSecureAuthenticationResponse2* = ref object of RootObj
    ## Results of 3D Secure Authentication.
    authentication_status*: Option[ParesStatus]
    enrollment_status*: Option[Enrolled]
    authentication_id*: Option[string]
      ## The externally received 3ds authentication id, to be returned in card
      ## detokenization response.

  TokenIdRequest* = ref object of RootObj
    ## The Tokenized Payment Source representing a Request to Vault a Token.
    id*: string
      ## The PayPal-generated ID for the token.
    `type`*: string
      ## The tokenization method that generated the ID.

  VaultId* = string

  VaultInstruction* = enum
    ## Vault Instruction on action to be performed after a successful payer approval.
    ONCREATEPAYMENTTOKENS = "ON_CREATE_PAYMENT_TOKENS"
    ONPAYERAPPROVAL = "ON_PAYER_APPROVAL"

  VenmoRequest* = ref object of RootObj
    description*: Option[string]
      ## The description displayed to the consumer on the approval flow for a digital
      ## wallet, as well as on the merchant view of the payment token management
      ## experience. exp: PayPal.com.
    usage_pattern*: Option[string]
      ## Expected business/charge model for the billing agreement.
    shipping*: Option[JsonNode]
      ## The shipping details.
    permit_multiple_payment_tokens*: Option[bool]
      ## Create multiple payment tokens for the same payer, merchant/platform
      ## combination. Use this when the customer has not logged in at merchant/platform.
      ## The payment token thus generated, can then also be used to create the customer
      ## account at merchant/platform. Use this also when multiple payment tokens are
      ## required for the same payer, different customer at merchant/platform. This helps
      ## to identify customers distinctly even though they may share the same PayPal
      ## account. This only applies to PayPal payment source.
    usage_type*: Option[string]
      ## The usage type associated with a digital wallet payment token.
    customer_type*: Option[string]
      ## The customer type associated with a digital wallet payment token. This is to
      ## indicate whether the customer acting on the merchant / platform is either a
      ## business or a consumer.
    experience_context*: Option[JsonNode]
      ## Customizes the Vault creation flow experience for your customers.

  VenmoResponse* = ref object of RootObj
    description*: Option[string]
      ## The description displayed to the consumer on the approval flow for a digital
      ## wallet, as well as on the merchant view of the payment token management
      ## experience. exp: PayPal.com.
    usage_pattern*: Option[string]
      ## Expected business/charge model for the billing agreement.
    shipping*: Option[JsonNode]
      ## The shipping details.
    permit_multiple_payment_tokens*: Option[bool]
      ## Create multiple payment tokens for the same payer, merchant/platform
      ## combination. Use this when the customer has not logged in at merchant/platform.
      ## The payment token thus generated, can then also be used to create the customer
      ## account at merchant/platform. Use this also when multiple payment tokens are
      ## required for the same payer, different customer at merchant/platform. This helps
      ## to identify customers distinctly even though they may share the same PayPal
      ## account. This only applies to PayPal payment source.
    usage_type*: Option[string]
      ## The usage type associated with a digital wallet payment token.
    customer_type*: Option[string]
      ## The customer type associated with a digital wallet payment token. This is to
      ## indicate whether the customer acting on the merchant / platform is either a
      ## business or a consumer.
    email_address*: Option[Email]
    payer_id*: Option[AccountId]
    name*: Option[JsonNode]
      ## The name of the party.
    phone*: Option[PhoneWithType]
    address*: Option[JsonNode]
      ## The portable international postal address. Maps to[AddressValidationMetadata](h
      ## ttps://github.com/googlei18n/libaddressinput/wiki/AddressValidationMetadata) and
      ## HTML 5.1 [Autofilling form controls: the autocompleteattribute](https://www.w3.
      ## org/TR/html51/sec-forms.html#autofilling-form-controls-the-autocomplete-attribut
      ## e).
    user_name*: Option[string]
      ## The Venmo username, as chosen by the user.

  WalletBase* = ref object of RootObj
    ## Resource consolidating common request and response attributes for vaulting a
    ## Digital Wallet.
    description*: Option[string]
      ## The description displayed to the consumer on the approval flow for a digital
      ## wallet, as well as on the merchant view of the payment token management
      ## experience. exp: PayPal.com.
    usage_pattern*: Option[string]
      ## Expected business/charge model for the billing agreement.
    shipping*: Option[JsonNode]
      ## The shipping details.
    permit_multiple_payment_tokens*: Option[bool]
      ## Create multiple payment tokens for the same payer, merchant/platform
      ## combination. Use this when the customer has not logged in at merchant/platform.
      ## The payment token thus generated, can then also be used to create the customer
      ## account at merchant/platform. Use this also when multiple payment tokens are
      ## required for the same payer, different customer at merchant/platform. This helps
      ## to identify customers distinctly even though they may share the same PayPal
      ## account. This only applies to PayPal payment source.
    usage_type*: Option[string]
      ## The usage type associated with a digital wallet payment token.
    customer_type*: Option[string]
      ## The customer type associated with a digital wallet payment token. This is to
      ## indicate whether the customer acting on the merchant / platform is either a
      ## business or a consumer.
