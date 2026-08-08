import std/[options, json]

type
  Guid* = string

  StandardHeaderSchema* = string

  CheckoutPaymentIntent* = enum
    ## The intent to either capture payment immediately or authorize a payment for an
    ## order after order creation.
    CAPTURE2 = "CAPTURE"
    AUTHORIZE = "AUTHORIZE"

  Email* = string

  AccountId* = string

  PayerBase* = ref object of RootObj
    ## The customer who approves and pays for the order. The customer is also known as
    ## the payer.
    email_address*: Option[JsonNode]
    payer_id*: Option[JsonNode]

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

  PhoneType* = enum
    ## The phone type.
    FAX = "FAX"
    HOME = "HOME"
    MOBILE = "MOBILE"
    OTHER = "OTHER"
    PAGER = "PAGER"

  PhoneNumberWithoutCountryCode* = ref object of RootObj
    ## A structured representation of a phone number conforming to the international
    ## [E.164 numbering plan format](https://www.itu.int/rec/T-REC-E.164/en),requiring
    ## only the national_number field.
    national_number*: string
      ## The national number, in its canonical international [E.164 numbering plan
      ## format](https://www.itu.int/rec/T-REC-E.164/en). The combined length of the
      ## country calling code (CC) and the national number must not be greater than 15
      ## digits. The national number consists of a national destination code (NDC) and
      ## subscriber number (SN).

  PhoneWithType* = ref object of RootObj
    ## The phone information.
    phone_type*: Option[PhoneType]
    phone_number*: JsonNode

  DateNoTime* = string

  TaxInfo* = ref object of RootObj
    ## The tax ID of the customer. The customer is also known as the payer. Both
    ## `tax_id` and `tax_id_type` are required.
    tax_id*: string
      ## The customer's tax ID value.
    tax_id_type*: string
      ## The customer's tax ID type.

  CountryCode* = string

  AddressPortable* = ref object of RootObj
    ## The portable international postal address. Maps to[AddressValidationMetadata](h
    ## ttps://github.com/googlei18n/libaddressinput/wiki/AddressValidationMetadata) and
    ## HTML 5.1 [Autofilling form controls: the autocompleteattribute](https://www.w3.
    ## org/TR/html51/sec-forms.html#autofilling-form-controls-the-autocomplete-attribut
    ## e).
    address_line_1*: Option[string]
      ## The first line of the address, such as number and street, for example, `173
      ## Drury Lane`. Needed for data entry, and Compliance and Risk checks. This field
      ## needs to pass the full address.
    address_line_2*: Option[string]
      ## The second line of the address, for example, a suite or apartment number.
    address_line_3*: Option[string]
      ## The third line of the address, if needed. Examples include a street complement
      ## for Brazil, direction text, such as `next to Walmart`, or a landmark in an
      ## Indian address.
    admin_area_4*: Option[string]
      ## The neighborhood, ward, or district. This is smaller than `admin_area_level_3`
      ## or `sub_locality`. Value is:<ul><li>The postal sorting code that is used in
      ## Guernsey and many French territories, such as French Guiana.</li><li>The
      ## fine-grained administrative levels in China.</li></ul>
    admin_area_3*: Option[string]
      ## The sub-locality, suburb, neighborhood, or district. This is smaller than
      ## `admin_area_level_2`. Value is:<ul><li>Brazil. Suburb, *bairro*, or
      ## neighborhood.</li><li>India. Sub-locality or district. Street name information
      ## isn't always available, but a sub-locality or district can be a very small
      ## area.</li></ul>
    admin_area_2*: Option[string]
      ## A city, town, or village. Smaller than `admin_area_level_1`.
    admin_area_1*: Option[string]
      ## The highest-level sub-division in a country, which is usually a province, state,
      ## or ISO-3166-2 subdivision. This data is formatted for postal delivery, for
      ## example, `CA` and not `California`. Value, by country, is:<ul><li>UK. A
      ## county.</li><li>US. A state.</li><li>Canada. A province.</li><li>Japan. A
      ## prefecture.</li><li>Switzerland. A *kanton*.</li></ul>
    postal_code*: Option[string]
      ## The postal code, which is the ZIP code or equivalent. Typically required for
      ## countries with a postal code or an equivalent. See [postal
      ## code](https://en.wikipedia.org/wiki/Postal_code).
    country_code*: CountryCode
    address_details*: Option[JsonNode]
      ## The non-portable additional address details include fine-grain address
      ## information for Compliance, Risk, and other scenarios. This isn't portable with
      ## common third-party and open source applications. This can include data that is
      ## redundant with core fields. For example, `address_portable.address_line_1` is
      ## usually a combination of `address_details.street_number`, `street_name`, and
      ## `street_type`.

  CountryCode2* = string

  Payer* = ref object of RootObj
    ## The customer who approves and pays for the order. The customer is also known as
    ## the payer.
    email_address*: Option[JsonNode]
    payer_id*: Option[JsonNode]
    name*: Option[JsonNode]
    phone*: Option[JsonNode]
    birth_date*: Option[JsonNode]
    tax_info*: Option[JsonNode]
    address*: Option[JsonNode]

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

  PayeeBase* = ref object of RootObj
    ## The details for the merchant who receives the funds and fulfills the order. The
    ## merchant is also known as the payee.
    email_address*: Option[JsonNode]
    merchant_id*: Option[JsonNode]

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

  Payee* = ref object of RootObj
    ## The merchant who receives the funds and fulfills the order. The merchant is also
    ## known as the payee.
    email_address*: Option[JsonNode]
    merchant_id*: Option[JsonNode]

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

  UniversalProductCode* = ref object of RootObj
    ## The Universal Product Code of the item.
    `type`*: string
      ## The Universal Product Code type.
    code*: string
      ## The UPC product code of the item.

  PricingScheme* = ref object of RootObj
    ## The pricing scheme details.
    price*: Option[JsonNode]
    pricing_model*: string
      ## The pricing model for the billing cycle.
    reload_threshold_amount*: Option[JsonNode]

  BillingCycle* = ref object of RootObj
    ## The billing cycle providing details of the billing frequency, amount, duration
    ## and if the billing cycle is a free, discounted or regular billing cycle. The
    ## sequence of the billing cycle will be in the following order - free trial
    ## billing cycle(s), discounted trial billing cycle(s), regular billing cycle(s).
    tenure_type*: string
      ## The tenure type of the billing cycle identifies if the billing cycle is a
      ## trial(free or discounted) or regular billing cycle.
    pricing_scheme*: Option[JsonNode]
    total_cycles*: Option[int64]
      ## The number of times this billing cycle gets executed. Trial billing cycles can
      ## only be executed a finite number of times (value between <code>1</code> and
      ## <code>999</code> for <code>total_cycles</code>). Regular billing cycles can be
      ## executed infinite times (value of <code>0</code> for <code>total_cycles</code>)
      ## or a finite number of times (value between <code>1</code> and <code>999</code>
      ## for <code>total_cycles</code>).
    sequence*: Option[int64]
      ## The order in which this cycle is to run among other billing cycles. For example,
      ## a trial billing cycle has a `sequence` of `1` while a regular billing cycle has
      ## a `sequence` of `2`, so that trial cycle runs before the regular cycle.
    start_date*: Option[JsonNode]

  OrderBillingPlan* = ref object of RootObj
    ## Metadata for merchant-managed recurring billing plans. Valid only during the
    ## saved payment method token or billing agreement creation.
    billing_cycles*: seq[BillingCycle]
      ## An array of billing cycles for trial billing and regular billing. A plan can
      ## have at most two trial cycles and only one regular cycle.
    setup_fee*: Option[JsonNode]
    name*: Option[string]
      ## Name of the recurring plan.

  ItemRequest* = ref object of RootObj
    ## The details for the items to be purchased.
    name*: string
      ## The item name or title. <blockquote>This field supports up to 3000 characters,
      ## but <strong>any content beyond 127 characters (including spaces) will be
      ## truncated. The 127 character limit is reflected in the response</strong>
      ## representation of this field</blockquote>.
    unit_amount*: JsonNode
    tax*: Option[JsonNode]
    quantity*: string
      ## The item quantity. Must be a whole number.
    description*: Option[string]
      ## <blockquote>This field supports up to 4000 characters, but <strong>any content
      ## beyond 2048 characters (including spaces) will be truncated. The 2048 character
      ## limit is reflected in the response</strong> representation of this
      ## field</blockquote>.
    sku*: Option[string]
      ## The stock keeping unit (SKU) for the item.
    url*: Option[string]
      ## The URL to the item being purchased. Visible to buyer and used in buyer
      ## experiences.
    category*: Option[string]
      ## The item category type.
    image_url*: Option[string]
      ## The URL of the item's image. File type and size restrictions apply. An image
      ## that violates these restrictions will not be honored.
    upc*: Option[JsonNode]
    billing_plan*: Option[OrderBillingPlan]

  EmailAddress* = string

  ShippingType* = enum
    ## A classification for the method of purchase fulfillment.
    SHIPPING = "SHIPPING"
    PICKUP = "PICKUP"
    PICKUPINSTORE = "PICKUP_IN_STORE"
    PICKUPFROMPERSON = "PICKUP_FROM_PERSON"

  DateTime* = string

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
    `type`*: Option[JsonNode]
    amount*: Option[JsonNode]
    selected*: bool
      ## If the API request sets `selected = true`, it represents the shipping option
      ## that the payee or merchant expects to be pre-selected for the payer when they
      ## first view the `shipping.options` in the PayPal Checkout experience. As part of
      ## the response if a `shipping.option` contains `selected=true`, it represents the
      ## shipping option that the payer selected during the course of checkout with
      ## PayPal. Only one `shipping.option` can be set to `selected=true`.

  ShippingDetail* = ref object of RootObj
    ## The shipping details.
    name*: Option[JsonNode]
    email_address*: Option[JsonNode]
    phone_number*: Option[JsonNode]
    `type`*: Option[string]
      ## A classification for the method of purchase fulfillment (e.g shipping, in-store
      ## pickup, etc). Either `type` or `options` may be present, but not both.
    options*: Option[seq[JsonNode]]
      ## An array of shipping options that the payee or merchant offers to the payer to
      ## ship or pick up their items.
    address*: Option[JsonNode]

  Level2CardProcessingData* = ref object of RootObj
    ## The level 2 card processing data collections. If your merchant account has been
    ## configured for Level 2 processing this field will be passed to the processor on
    ## your behalf. Please contact your PayPal Technical Account Manager to define
    ## level 2 data for your business.
    invoice_id*: Option[string]
      ## Use this field to pass a purchase identification value of up to 127 ASCII
      ## characters. The length of this field will be adjusted to meet network
      ## specifications (25chars for Visa and Mastercard, 17chars for Amex), and the
      ## original invoice ID will still be displayed in your existing reports.
    tax_total*: Option[JsonNode]

  ItemWithoutCategoryTaxOrAmount* = ref object of RootObj
    ## The details for the items to be purchased.
    name*: string
      ## The item name or title.
    quantity*: string
      ## The item quantity. Must be a whole number.
    description*: Option[string]
      ## The detailed item description.
    sku*: Option[string]
      ## The stock keeping unit (SKU) for the item.
    url*: Option[string]
      ## The URL to the item being purchased. Visible to buyer and used in buyer
      ## experiences.
    image_url*: Option[string]
      ## The URL of the item's image. File type and size restrictions apply. An image
      ## that violates these restrictions will not be honored.
    upc*: Option[JsonNode]
    billing_plan*: Option[OrderBillingPlan]

  LineItem* = ref object of RootObj
    ## The line items for this purchase. If your merchant account has been configured
    ## for Level 3 processing this field will be passed to the processor on your
    ## behalf.
    name*: string
      ## The item name or title.
    quantity*: string
      ## The item quantity. Must be a whole number.
    description*: Option[string]
      ## The detailed item description.
    sku*: Option[string]
      ## The stock keeping unit (SKU) for the item.
    url*: Option[string]
      ## The URL to the item being purchased. Visible to buyer and used in buyer
      ## experiences.
    image_url*: Option[string]
      ## The URL of the item's image. File type and size restrictions apply. An image
      ## that violates these restrictions will not be honored.
    upc*: Option[JsonNode]
    billing_plan*: Option[OrderBillingPlan]
    unit_amount*: Option[JsonNode]
    tax*: Option[JsonNode]
    commodity_code*: Option[string]
      ## Code used to classify items purchased and track the total amount spent across
      ## various categories of products and services. Different corporate purchasing
      ## organizations may use different standards, but the United Nations Standard
      ## Products and Services Code (UNSPSC) is frequently used.
    discount_amount*: Option[JsonNode]
    total_amount*: Option[JsonNode]
    unit_of_measure*: Option[string]
      ## Unit of measure is a standard used to express the magnitude of a quantity in
      ## international trade. Most commonly used (but not limited to) examples are: Acre
      ## (ACR), Ampere (AMP), Centigram (CGM), Centimetre (CMT), Cubic inch (INQ), Cubic
      ## metre (MTQ), Fluid ounce (OZA), Foot (FOT), Hour (HUR), Item (ITM), Kilogram
      ## (KGM), Kilometre (KMT), Kilowatt (KWT), Liquid gallon (GLL), Liter (LTR), Pounds
      ## (LBS), Square foot (FTK).

  Level3CardProcessingData* = ref object of RootObj
    ## The level 3 card processing data collections, If your merchant account has been
    ## configured for Level 3 processing this field will be passed to the processor on
    ## your behalf. Please contact your PayPal Technical Account Manager to define
    ## level 3 data for your business.
    shipping_amount*: Option[JsonNode]
    duty_amount*: Option[JsonNode]
    discount_amount*: Option[JsonNode]
    shipping_address*: Option[JsonNode]
    ships_from_postal_code*: Option[string]
      ## Use this field to specify the postal code of the shipping location.
    line_items*: Option[seq[JsonNode]]
      ## A list of the items that were purchased with this payment. If your merchant
      ## account has been configured for Level 3 processing this field will be passed to
      ## the processor on your behalf.

  CardSupplementaryData* = ref object of RootObj
    ## Merchants and partners can add Level 2 and 3 data to payments to reduce risk and
    ## payment processing costs. For more information about processing payments, see <a
    ## href="https://developer.paypal.com/docs/checkout/advanced/processing/">checkout<
    ## /a> or <ahref="https://developer.paypal.com/docs/multiparty/checkout/advanced/p
    ## rocessing/">multiparty checkout</a>.
    level_2*: Option[Level2CardProcessingData]
    level_3*: Option[Level3CardProcessingData]

  IpAddress* = string

  ParticipantMetadata* = ref object of RootObj
    ## Profile information of the sender or receiver.
    ip_address*: Option[JsonNode]

  RiskSupplementaryData* = ref object of RootObj
    ## Additional information necessary to evaluate the risk profile of a transaction.
    customer*: Option[ParticipantMetadata]

  SupplementaryData* = ref object of RootObj
    ## Supplementary data about a payment. This object passes information that can be
    ## used to improve risk assessments and processing costs, for example, by providing
    ## Level 2 and Level 3 payment data.
    card*: Option[JsonNode]
    risk*: Option[JsonNode]

  PurchaseUnitRequest* = ref object of RootObj
    ## The purchase unit request. Includes required information for the payment
    ## contract.
    reference_id*: Option[string]
      ## The API caller-provided external ID for the purchase unit. Required for multiple
      ## purchase units when you must update the order through `PATCH`. If you omit this
      ## value and the order contains only one purchase unit, PayPal sets this value to
      ## `default`.
    amount*: JsonNode
    payee*: Option[JsonNode]
    payment_instruction*: Option[PaymentInstruction]
    description*: Option[string]
      ## <blockquote>This field supports up to 3,000 characters, but <strong>any content
      ## beyond 127 characters (including spaces) will be truncated. The 127 character
      ## limit is reflected in the response</strong> representation of this
      ## field.</blockquote>The purchase description. The maximum length of the character
      ## is dependent on the type of characters used. The character length is specified
      ## assuming a US ASCII character. Depending on type of character; (e.g. accented
      ## character, Japanese characters) the number of characters that that can be
      ## specified as input might not equal the permissible max length.
    custom_id*: Option[string]
      ## The API caller-provided external ID. Used to reconcile client transactions with
      ## PayPal transactions. Appears in transaction and settlement reports but is not
      ## visible to the payer.
    invoice_id*: Option[string]
      ## The API caller-provided external invoice number for this order. Appears in both
      ## the payer's transaction history and the emails that the payer receives.
      ## invoice_id values are required to be unique within each merchant account by
      ## default. Although the uniqueness validation is configurable, disabling this
      ## behavior will remove the account's ability to use invoice_id in other APIs as an
      ## identifier. It is highly recommended to keep a unique invoice_id for each Order.
    soft_descriptor*: Option[string]
      ## <blockquote>This field supports up to 127 characters, but <strong>any content
      ## beyond 22 characters (including spaces) will be truncated. The 22 character
      ## limit is reflected in the response</strong> representation of this
      ## field.</blockquote>The soft descriptor is the dynamic text used to construct the
      ## statement descriptor that appears on a payer's card statement.<br><br>If an
      ## Order is paid using the "PayPal Wallet", the statement descriptor will appear in
      ## following format on the payer's card statement:
      ## <code><var>PAYPAL_prefix</var>+(space)+<var>merchant_descriptor</var>+(space)+
      ## <var>soft_descriptor</var></code><blockquote><strong>Note:</strong> The merchant
      ## descriptor is the descriptor of the merchant’s payment receiving preferences
      ## which can be seen by logging into the merchant accounthttps://www.sandbox.paypa
      ## l.com/businessprofile/settings/info/edit</blockquote>The <code>PAYPAL</code>
      ## prefix uses 8 characters. Only the first 22 characters will be displayed in the
      ## statement. <br>For example, if:<ul><li>The PayPal prefix toggle is <code>PAYPAL
      ## *</code>.</li><li>The merchant descriptor in the profile is <code>Janes
      ## Gift</code>.</li><li>The soft descriptor is
      ## <code>800-123-1234</code>.</li></ul>Then, the statement descriptor on the card
      ## is <code>PAYPAL * Janes Gift 80</code>.
    items*: Option[seq[JsonNode]]
      ## An array of items that the customer purchases from the merchant.
    shipping*: Option[JsonNode]
    supplementary_data*: Option[JsonNode]

  Language* = string

  Url* = string

  ExperienceContextBase* = ref object of RootObj
    ## Customizes the payer experience during the approval process for the payment.
    brand_name*: Option[string]
      ## The label that overrides the business name in the PayPal account on the PayPal
      ## site. The pattern is defined by an external party and supports Unicode.
    locale*: Option[JsonNode]
    shipping_preference*: Option[string]
      ## The location from which the shipping address is derived.
    return_url*: Option[JsonNode]
    cancel_url*: Option[JsonNode]

  InstrumentId* = string

  DateYearMonth* = string

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

  CardType* = enum
    ## Type of card. i.e Credit, Debit and so on.
    CREDIT = "CREDIT"
    DEBIT = "DEBIT"
    PREPAID = "PREPAID"
    STORE = "STORE"
    UNKNOWN2 = "UNKNOWN"

  EciFlag* = enum
    ## Electronic Commerce Indicator (ECI). The ECI value is part of the 2 data
    ## elements that indicate the transaction was processed electronically. This should
    ## be passed on the authorization transaction to the Gateway/Processor.
    MASTERCARDNON3DSECURETRANSACTION = "MASTERCARD_NON_3D_SECURE_TRANSACTION"
    MASTERCARDATTEMPTEDAUTHENTICATIONTRANSACTION = "MASTERCARD_ATTEMPTED_AUTHENTICATION_TRANSACTION"
    MASTERCARDFULLYAUTHENTICATEDTRANSACTION = "MASTERCARD_FULLY_AUTHENTICATED_TRANSACTION"
    FULLYAUTHENTICATEDTRANSACTION = "FULLY_AUTHENTICATED_TRANSACTION"
    ATTEMPTEDAUTHENTICATIONTRANSACTION = "ATTEMPTED_AUTHENTICATION_TRANSACTION"
    NON3DSECURETRANSACTION = "NON_3D_SECURE_TRANSACTION"

  Enrolled* = enum
    ## Status of Authentication eligibility.
    Y = "Y"
    N = "N"
    U = "U"
    B = "B"

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

  MerchantPartnerCustomerId* = string

  Customer* = ref object of RootObj
    ## This object represents a merchant’s customer, allowing them to store contact
    ## details, and track all payments associated with the same customer.
    id*: Option[MerchantPartnerCustomerId]
    email_address*: Option[JsonNode]
    phone*: Option[JsonNode]
    name*: Option[JsonNode]

  CardCustomer* = ref object of RootObj
    ## The details about a customer in PayPal's system of record.
    id*: Option[MerchantPartnerCustomerId]
    email_address*: Option[JsonNode]
    phone*: Option[JsonNode]
    name*: Option[JsonNode]
    merchant_customer_id*: Option[string]
      ## Merchants and partners may already have a data-store where their customer
      ## information is persisted. Use merchant_customer_id to associate the
      ## PayPal-generated customer.id to your representation of a customer.

  StoreInVaultInstruction* = enum
    ## Defines how and when the payment source gets vaulted.
    ONSUCCESS = "ON_SUCCESS"

  VaultInstructionBase* = ref object of RootObj
    ## Basic vault instruction specification that can be extended by specific payment
    ## sources that supports vaulting.
    store_in_vault*: Option[StoreInVaultInstruction]

  CardVerification* = ref object of RootObj
    ## The API caller can opt in to verify the card through PayPal offered verification
    ## services (e.g. Smart Dollar Auth, 3DS).
    `method`*: Option[string]
      ## The method used for card verification.

  CardAttributes* = ref object of RootObj
    ## Additional attributes associated with the use of this card.
    customer*: Option[CardCustomer]
    vault*: Option[JsonNode]
    verification*: Option[JsonNode]

  Card* = ref object of RootObj
    ## The payment card to use to fund a payment. Can be a credit or debit card.
    id*: Option[JsonNode]
    name*: Option[string]
      ## The card holder's name as it appears on the card.
    number*: Option[string]
      ## The primary account number (PAN) for the payment card.
    expiry*: Option[JsonNode]
    security_code*: Option[string]
      ## The three- or four-digit security code of the card. Also known as the CVV, CVC,
      ## CVN, CVE, or CID. This parameter cannot be present in the request when
      ## `payment_initiator=MERCHANT`.
    last_digits*: Option[string]
      ## The last digits of the payment card.
    card_type*: Option[JsonNode]
    `type`*: Option[JsonNode]
    brand*: Option[JsonNode]
    billing_address*: Option[JsonNode]
    attributes*: Option[JsonNode]

  VaultId* = string

  SingleUseToken* = string

  PaymentInitiator* = enum
    ## The person or party who initiated or triggered the payment.
    CUSTOMER2 = "CUSTOMER"
    MERCHANT = "MERCHANT"

  StoredPaymentSourcePaymentType* = enum
    ## Indicates the type of the stored payment_source payment.
    ONETIME = "ONE_TIME"
    RECURRING = "RECURRING"
    UNSCHEDULED = "UNSCHEDULED"

  StoredPaymentSourceUsageType* = enum
    ## Indicates if this is a `first` or `subsequent` payment using a stored payment
    ## source (also referred to as stored credential or card on file).
    FIRST = "FIRST"
    SUBSEQUENT = "SUBSEQUENT"
    DERIVED = "DERIVED"

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

  NetworkTransactionReference* = ref object of RootObj
    ## Reference values used by the card network to identify a transaction.
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
      ## reference date". For some specific networks, such as MasterCard and Discover,
      ## this date field is mandatory when the
      ## `previous_network_transaction_reference_id` is passed.
    network*: Option[JsonNode]
    acquirer_reference_number*: Option[string]
      ## Reference ID issued for the card transaction. This ID can be used to track the
      ## transaction across processors, card brands and issuing banks.

  CardStoredCredential* = ref object of RootObj
    ## Provides additional details to process a payment using a `card` that has been
    ## stored or is intended to be stored (also referred to as stored_credential or
    ## card-on-file).<br/>Parameter compatibility:<br/><ul><li>`payment_type=ONE_TIME`
    ## is compatible only with `payment_initiator=CUSTOMER`.</li><li>`usage=FIRST` is
    ## compatible only with
    ## `payment_initiator=CUSTOMER`.</li><li>`previous_transaction_reference` or
    ## `previous_network_transaction_reference` is compatible only with
    ## `payment_initiator=MERCHANT`.</li><li>Only one of the parameters -
    ## `previous_transaction_reference` and `previous_network_transaction_reference` -
    ## can be present in the request.</li></ul>
    payment_initiator*: PaymentInitiator
    payment_type*: StoredPaymentSourcePaymentType
    usage*: Option[StoredPaymentSourceUsageType]
    previous_network_transaction_reference*: Option[NetworkTransactionReference]

  NetworkTokenRequest* = ref object of RootObj
    ## The Third Party Network token used to fund a payment.
    number*: string
      ## Third party network token number.
    expiry*: JsonNode
    cryptogram*: Option[string]
      ## An Encrypted one-time use value that's sent along with Network Token. This field
      ## is not required to be present for recurring transactions.
    eci_flag*: Option[EciFlag]
    token_requestor_id*: Option[string]
      ## A TRID, or a Token Requestor ID, is an identifier used by merchants to request
      ## network tokens from card networks. A TRID is a precursor to obtaining a network
      ## token for a credit card primary account number (PAN), and will aid in enabling
      ## secure card on file (COF) payments and reducing fraud.

  CardExperienceContext* = ref object of RootObj
    ## Customizes the payer experience during the 3DS Approval for payment.
    return_url*: Option[JsonNode]
    cancel_url*: Option[JsonNode]

  CardRequest* = ref object of RootObj
    ## The payment card to use to fund a payment. Can be a credit or debit
    ## card.<blockquote><strong>Note:</strong> Passing card number, cvv and expiry
    ## directly via the API requires <ahref="https://www.pcisecuritystandards.org/pci_
    ## security/completing_self_assessment"> PCI SAQ D compliance</a>. <br>*PayPal
    ## offers a mechanism by which you do not have to take on the <strong>PCI SAQ
    ## D</strong> burden by using hosted fields - refer to <a
    ## href="https://developer.paypal.com/docs/checkout/advanced/integrate/">this
    ## Integration Guide</a>*.</blockquote>
    id*: Option[JsonNode]
    name*: Option[string]
      ## The card holder's name as it appears on the card.
    number*: Option[string]
      ## The primary account number (PAN) for the payment card.
    expiry*: Option[JsonNode]
    security_code*: Option[string]
      ## The three- or four-digit security code of the card. Also known as the CVV, CVC,
      ## CVN, CVE, or CID. This parameter cannot be present in the request when
      ## `payment_initiator=MERCHANT`.
    last_digits*: Option[string]
      ## The last digits of the payment card.
    card_type*: Option[JsonNode]
    `type`*: Option[JsonNode]
    brand*: Option[JsonNode]
    billing_address*: Option[JsonNode]
    attributes*: Option[JsonNode]
    vault_id*: Option[JsonNode]
    single_use_token*: Option[JsonNode]
    stored_credential*: Option[CardStoredCredential]
    network_token*: Option[JsonNode]
    experience_context*: Option[JsonNode]

  Token* = ref object of RootObj
    ## The tokenized payment source to fund a payment.
    id*: string
      ## The PayPal-generated ID for the token.
    `type`*: string
      ## The tokenization method that generated the ID.

  V3VaultInstructionBase* = ref object of RootObj
    ## Base vaulting specification. The object can be extended for specific use cases
    ## within each payment_source that supports vaulting.
    store_in_vault*: StoreInVaultInstruction

  PayeePaymentMethodPreference* = enum
    ## The merchant-preferred payment methods.
    UNRESTRICTED = "UNRESTRICTED"
    IMMEDIATEPAYMENTREQUIRED = "IMMEDIATE_PAYMENT_REQUIRED"

  PaypalWalletCustomer* = ref object of RootObj
    ## The details about a customer in PayPal's system of record.
    id*: Option[MerchantPartnerCustomerId]
    email_address*: Option[JsonNode]
    phone*: Option[JsonNode]
    name*: Option[JsonNode]
    merchant_customer_id*: Option[string]
      ## Merchants and partners may already have a data-store where their customer
      ## information is persisted. Use merchant_customer_id to associate the
      ## PayPal-generated customer.id to your representation of a customer.

  AccountId2* = string

  VaultPaypalWalletBase* = ref object of RootObj
    ## Resource consolidating common request and response attributes for vaulting
    ## PayPal Wallet.
    store_in_vault*: Option[StoreInVaultInstruction]
    description*: Option[string]
      ## The description displayed to PayPal consumer on the approval flow for PayPal, as
      ## well as on the PayPal payment token management experience on PayPal.com.
    usage_pattern*: Option[string]
      ## Expected business/pricing model for the billing agreement.
    shipping*: Option[JsonNode]
    usage_type*: string
      ## The usage type associated with the PayPal payment token.
    customer_type*: Option[string]
      ## The customer type associated with the PayPal payment token. This is to indicate
      ## whether the customer acting on the merchant / platform is either a business or a
      ## consumer.
    permit_multiple_payment_tokens*: Option[bool]
      ## Create multiple payment tokens for the same payer, merchant/platform
      ## combination. Use this when the customer has not logged in at merchant/platform.
      ## The payment token thus generated, can then also be used to create the customer
      ## account at merchant/platform. Use this also when multiple payment tokens are
      ## required for the same payer, different customer at merchant/platform. This helps
      ## to identify customers distinctly even though they may share the same PayPal
      ## account. This only applies to PayPal payment source.

  ChargePattern* = enum
    ## Expected business/pricing model for the billing agreement.
    IMMEDIATE = "IMMEDIATE"
    DEFERRED = "DEFERRED"
    RECURRINGPREPAID = "RECURRING_PREPAID"
    RECURRINGPOSTPAID = "RECURRING_POSTPAID"
    THRESHOLDPREPAID = "THRESHOLD_PREPAID"
    THRESHOLDPOSTPAID = "THRESHOLD_POSTPAID"
    SUBSCRIPTIONPREPAID = "SUBSCRIPTION_PREPAID"
    SUBSCRIPTIONPOSTPAID = "SUBSCRIPTION_POSTPAID"
    UNSCHEDULEDPREPAID = "UNSCHEDULED_PREPAID"
    UNSCHEDULEDPOSTPAID = "UNSCHEDULED_POSTPAID"
    INSTALLMENTPREPAID = "INSTALLMENT_PREPAID"
    INSTALLMENTPOSTPAID = "INSTALLMENT_POSTPAID"

  PaypalWalletAttributes* = ref object of RootObj
    ## Additional attributes associated with the use of this PayPal Wallet.
    customer*: Option[PaypalWalletCustomer]
    vault*: Option[JsonNode]

  NativeAppContext* = ref object of RootObj
    ## Merchant provided, buyer's native app preferences to app switch to the PayPal
    ## consumer app.
    os_type*: Option[string]
      ## Operating System type of the device that the buyer is using.
    os_version*: Option[string]
      ## Operating System version of the device that the buyer is using.

  MobileWebContext* = ref object of RootObj
    ## Buyer's mobile web browser context to app switch to the PayPal consumer app.
    return_flow*: Option[string]
      ## Merchant preference on how the buyer can navigate back to merchant website post
      ## approving the transaction on the PayPal App.
    buyer_user_agent*: Option[string]
      ## User agent from the request originating from the buyer's device. This will be
      ## used to identify the buyer's operating system and browser versions. NOTE:
      ## Merchants must not alter or modify the buyer's device user agent.

  AppSwitchContext* = ref object of RootObj
    ## Merchant provided details of the native app or mobile web browser to facilitate
    ## buyer's app switch to the PayPal consumer app.
    native_app*: Option[NativeAppContext]
    mobile_web*: Option[MobileWebContext]

  BillingAgreementId* = string

  CallbackConfiguration* = ref object of RootObj
    ## CallBack Configuration that the merchant can provide to PayPal/Venmo.
    callback_events*: seq[string]
      ## An array of callback events merchant can subscribe to for the corresponding
      ## callback url.
    callback_url*: string
      ## Merchant provided CallBack url.PayPal/Venmo will use this url to call the
      ## merchant back when the events occur .PayPal/Venmo expects a secured url usually
      ## in the https format.merchant can append the cart id or other params part of the
      ## url as query or path params.

  PaypalWalletExperienceContext* = ref object of RootObj
    ## Customizes the payer experience during the approval process for payment with
    ## PayPal.<blockquote><strong>Note:</strong> Partners and Marketplaces might
    ## configure <code>brand_name</code> and <code>shipping_preference</code> during
    ## partner account setup, which overrides the request values.</blockquote>
    brand_name*: Option[string]
      ## The label that overrides the business name in the PayPal account on the PayPal
      ## site. The pattern is defined by an external party and supports Unicode.
    locale*: Option[JsonNode]
    shipping_preference*: Option[string]
      ## The location from which the shipping address is derived.
    contact_preference*: Option[string]
      ## The preference to display the contact information (buyer’s shipping email &
      ## phone number) on PayPal's checkout for easy merchant-buyer communication.
    return_url*: Option[JsonNode]
    cancel_url*: Option[JsonNode]
    app_switch_context*: Option[JsonNode]
    landing_page*: Option[string]
      ## The type of landing page to show on the PayPal site for customer checkout.
    user_action*: Option[string]
      ## Configures a <strong>Continue</strong> or <strong>Pay Now</strong> checkout
      ## flow.
    payment_method_preference*: Option[string]
      ## The merchant-preferred payment methods.
    order_update_callback_config*: Option[JsonNode]

  PaypalWalletStoredCredential* = ref object of RootObj
    ## Provides additional details to process a payment using the PayPal wallet billing
    ## agreement or a vaulted payment method that has been stored or is intended to be
    ## stored.
    payment_initiator*: PaymentInitiator
    charge_pattern*: Option[JsonNode]
    usage_pattern*: Option[ChargePattern]
    usage*: Option[StoredPaymentSourceUsageType]

  PaypalWallet* = ref object of RootObj
    ## A resource that identifies a PayPal Wallet is used for payment.
    vault_id*: Option[JsonNode]
    email_address*: Option[JsonNode]
    name*: Option[JsonNode]
    phone*: Option[JsonNode]
    birth_date*: Option[JsonNode]
    tax_info*: Option[JsonNode]
    address*: Option[JsonNode]
    attributes*: Option[JsonNode]
    experience_context*: Option[PaypalWalletExperienceContext]
    billing_agreement_id*: Option[BillingAgreementId]
    stored_credential*: Option[PaypalWalletStoredCredential]

  FullName* = string

  BancontactRequest* = ref object of RootObj
    ## Information needed to pay using Bancontact.
    name*: JsonNode
    country_code*: JsonNode
    experience_context*: Option[JsonNode]

  BlikExperienceContext* = ref object of RootObj
    ## Customizes the payer experience during the approval process for the BLIK
    ## payment.
    brand_name*: Option[string]
      ## The label that overrides the business name in the PayPal account on the PayPal
      ## site. The pattern is defined by an external party and supports Unicode.
    locale*: Option[JsonNode]
    shipping_preference*: Option[string]
      ## The location from which the shipping address is derived.
    return_url*: Option[JsonNode]
    cancel_url*: Option[JsonNode]
    consumer_ip*: Option[JsonNode]
    consumer_user_agent*: Option[string]
      ## The payer's User Agent. For example, Mozilla/5.0 (Macintosh; Intel Mac OS X x.y;
      ## rv:42.0).

  BlikSeamless* = ref object of RootObj
    ## Information used to pay using BLIK level_0 flow.
    auth_code*: string
      ## The 6-digit code used to authenticate a consumer within BLIK.

  BlikOneClick* = ref object of RootObj
    ## Information used to pay using BLIK one-click flow.
    auth_code*: Option[string]
      ## The 6-digit code used to authenticate a consumer within BLIK.
    consumer_reference*: string
      ## The merchant generated, unique reference serving as a primary identifier for
      ## accounts connected between Blik and a merchant.
    alias_label*: Option[string]
      ## A bank defined identifier used as a display name to allow the payer to
      ## differentiate between multiple registered bank accounts.
    alias_key*: Option[string]
      ## A Blik-defined identifier for a specific Blik-enabled bank account that is
      ## associated with a given merchant. Used only in conjunction with a Consumer
      ## Reference.

  BlikRequest* = ref object of RootObj
    ## Information needed to pay using BLIK.
    name*: JsonNode
    country_code*: JsonNode
    email*: Option[JsonNode]
    experience_context*: Option[JsonNode]
    level_0*: Option[JsonNode]
    one_click*: Option[JsonNode]

  EpsRequest* = ref object of RootObj
    ## Information needed to pay using eps.
    name*: JsonNode
    country_code*: JsonNode
    experience_context*: Option[JsonNode]

  GiropayRequest* = ref object of RootObj
    ## Information needed to pay using giropay.
    name*: JsonNode
    country_code*: JsonNode
    experience_context*: Option[JsonNode]

  Bic* = string

  IdealRequest* = ref object of RootObj
    ## Information needed to pay using iDEAL.
    name*: JsonNode
    country_code*: JsonNode
    bic*: Option[JsonNode]
    experience_context*: Option[JsonNode]

  MybankRequest* = ref object of RootObj
    ## Information needed to pay using MyBank.
    name*: JsonNode
    country_code*: JsonNode
    experience_context*: Option[JsonNode]

  P24Request* = ref object of RootObj
    ## Information needed to pay using P24 (Przelewy24).
    name*: JsonNode
    email*: JsonNode
    country_code*: JsonNode
    experience_context*: Option[JsonNode]

  SofortRequest* = ref object of RootObj
    ## Information needed to pay using Sofort.
    name*: JsonNode
    country_code*: JsonNode
    experience_context*: Option[JsonNode]

  TrustlyRequest* = ref object of RootObj
    ## Information needed to pay using Trustly.
    name*: JsonNode
    country_code*: JsonNode
    email*: JsonNode
    experience_context*: Option[JsonNode]

  ApplePayPaymentData* = ref object of RootObj
    ## Information about the decrypted apple pay payment data for the token like
    ## cryptogram, eci indicator.
    cryptogram*: Option[string]
      ## Online payment cryptogram, as defined by 3D Secure. The pattern is defined by an
      ## external party and supports Unicode.
    eci_indicator*: Option[string]
      ## ECI indicator, as defined by 3- Secure. The pattern is defined by an external
      ## party and supports Unicode.
    emv_data*: Option[string]
      ## Encoded Apple Pay EMV Payment Structure used for payments in China. The pattern
      ## is defined by an external party and supports Unicode.
    pin*: Option[string]
      ## Bank Key encrypted Apple Pay PIN. The pattern is defined by an external party
      ## and supports Unicode.

  ApplePayDecryptedTokenData* = ref object of RootObj
    ## Information about the Payment data obtained by decrypting Apple Pay token.
    transaction_amount*: Option[JsonNode]
    tokenized_card*: JsonNode
    device_manufacturer_id*: Option[string]
      ## Apple Pay Hex-encoded device manufacturer identifier. The pattern is defined by
      ## an external party and supports Unicode.
    payment_data_type*: Option[string]
      ## Indicates the type of payment data passed, in case of Non China the payment data
      ## is 3DSECURE and for China it is EMV.
    payment_data*: Option[JsonNode]

  ApplePayAttributes* = ref object of RootObj
    ## Additional attributes associated with apple pay.
    customer*: Option[Customer]
    vault*: Option[V3VaultInstructionBase]

  ApplePayExperienceContext* = ref object of RootObj
    ## Customizes the payer experience during the approval process for the payment.
    return_url*: JsonNode
    cancel_url*: JsonNode

  ApplePayRequest* = ref object of RootObj
    ## Information needed to pay using ApplePay.
    id*: Option[string]
      ## ApplePay transaction identifier, this will be the unique identifier for this
      ## transaction provided by Apple. The pattern is defined by an external party and
      ## supports Unicode.
    name*: Option[JsonNode]
    email_address*: Option[JsonNode]
    phone_number*: Option[JsonNode]
    decrypted_token*: Option[JsonNode]
    stored_credential*: Option[CardStoredCredential]
    vault_id*: Option[JsonNode]
    attributes*: Option[ApplePayAttributes]
    experience_context*: Option[ApplePayExperienceContext]

  PhoneWithNationalRequiredAndCountryCode* = ref object of RootObj
    ## A structured representation of a phone number conforming to the international
    ## [E.164 numbering plan format](https://www.itu.int/rec/T-REC-E.164/en),requiring
    ## the national_number field and optionally supporting the country_code.
    country_code*: Option[string]
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

  GooglePayCard* = ref object of RootObj
    ## The payment card used to fund a Google Pay payment. Can be a credit or debit
    ## card.
    name*: Option[string]
      ## The card holder's name as it appears on the card.
    number*: Option[string]
      ## The primary account number (PAN) for the payment card.
    expiry*: Option[JsonNode]
    last_digits*: Option[string]
      ## The last digits of the payment card.
    `type`*: Option[JsonNode]
    brand*: Option[JsonNode]
    billing_address*: Option[JsonNode]

  GooglePayDecryptedTokenData* = ref object of RootObj
    ## Details shared by Google for the merchant to be shared with PayPal. This is
    ## required to process the transaction using the Google Pay payment method.
    message_id*: Option[string]
      ## A unique ID that identifies the message in case it needs to be revoked or
      ## located at a later time.
    message_expiration*: Option[string]
      ## Date and time at which the message expires as UTC milliseconds since epoch.
      ## Integrators should reject any message that's expired.
    payment_method*: string
      ## The type of the payment credential. Currently, only CARD is supported.
    card*: JsonNode
      ## Google Pay tokenized credit card used to pay.
    authentication_method*: string
      ## Authentication Method which is used for the card transaction.
    cryptogram*: Option[string]
      ## Base-64 cryptographic identifier used by card schemes to validate the token
      ## verification result. This is a conditionally required field if
      ## authentication_method is CRYPTOGRAM_3DS.
    eci_indicator*: Option[string]
      ## Electronic Commerce Indicator may not always be present. It is only returned for
      ## tokens on the Visa card network. This value is passed through in the payment
      ## authorization request.

  AssuranceDetails* = ref object of RootObj
    ## Information about cardholder possession validation and cardholder identification
    ## and verifications (ID&V).
    account_verified*: Option[bool]
      ## If true, indicates that Cardholder possession validation has been performed on
      ## returned payment credential.
    card_holder_authenticated*: Option[bool]
      ## If true, indicates that identification and verifications (ID&V) was performed on
      ## the returned payment credential.If false, the same risk-based authentication can
      ## be performed as you would for card transactions. This risk-based authentication
      ## can include, but not limited to, step-up with 3D Secure protocol if applicable.

  GooglePayExperienceContext* = ref object of RootObj
    ## Customizes the payer experience during the approval process for the payment.
    return_url*: JsonNode
    cancel_url*: JsonNode

  GooglePayRequest* = ref object of RootObj
    ## Information needed to pay using Google Pay.
    name*: Option[JsonNode]
    email_address*: Option[JsonNode]
    phone_number*: Option[JsonNode]
    card*: Option[JsonNode]
    decrypted_token*: Option[JsonNode]
    assurance_details*: Option[JsonNode]
    experience_context*: Option[GooglePayExperienceContext]

  VenmoWalletExperienceContext* = ref object of RootObj
    ## Customizes the buyer experience during the approval process for payment with
    ## Venmo.<blockquote><strong>Note:</strong> Partners and Marketplaces might
    ## configure <code>shipping_preference</code> during partner account setup, which
    ## overrides the request values.</blockquote>
    brand_name*: Option[string]
      ## The business name of the merchant. The pattern is defined by an external party
      ## and supports Unicode.
    shipping_preference*: Option[string]
      ## The location from which the shipping address is derived.
    order_update_callback_config*: Option[JsonNode]
    user_action*: Option[string]
      ## Configures a <strong>Continue</strong> or <strong>Pay Now</strong> checkout
      ## flow.

  VenmoWalletCustomer* = ref object of RootObj
    ## This object represents a merchant’s customer, allowing them to store contact
    ## details, and track all payments associated with the same customer.
    id*: Option[MerchantPartnerCustomerId]
    email_address*: Option[JsonNode]
    phone*: Option[JsonNode]
    name*: Option[JsonNode]

  VaultVenmoWalletBase* = ref object of RootObj
    ## Resource consolidating common request and response attirbutes for vaulting Venmo
    ## Wallet.
    store_in_vault*: StoreInVaultInstruction
    description*: Option[string]
      ## The description displayed to Venmo consumer on the approval flow for Venmo, as
      ## well as on the Venmo payment token management experience on Venmo.com.
    usage_pattern*: Option[string]
      ## Expected business/pricing model for the billing agreement.
    usage_type*: string
      ## The usage type associated with the Venmo payment token.
    customer_type*: Option[string]
      ## The customer type associated with the Venmo payment token. This is to indicate
      ## whether the customer acting on the merchant / platform is either a business or a
      ## consumer.
    permit_multiple_payment_tokens*: Option[bool]
      ## Create multiple payment tokens for the same payer, merchant/platform
      ## combination. Use this when the customer has not logged in at merchant/platform.
      ## The payment token thus generated, can then also be used to create the customer
      ## account at merchant/platform. Use this also when multiple payment tokens are
      ## required for the same payer, different customer at merchant/platform. This helps
      ## to identify customers distinctly even though they may share the same Venmo
      ## account.

  VenmoWalletAttributes* = ref object of RootObj
    ## Additional attributes associated with the use of this Venmo Wallet.
    customer*: Option[VenmoWalletCustomer]
    vault*: Option[JsonNode]

  VenmoWalletRequest* = ref object of RootObj
    ## Information needed to pay using Venmo.
    vault_id*: Option[JsonNode]
    email_address*: Option[JsonNode]
    experience_context*: Option[VenmoWalletExperienceContext]
    attributes*: Option[JsonNode]

  CryptoAccountHolderName* = ref object of RootObj
    ## Crypto account holder name.
    prefix*: Option[string]
      ## The prefix, or title, to the account holder's name.
    given_name*: string
      ## When the account holder is a person, the account holder's given, or first, name.
    surname*: string
      ## When the account holder is a person, the account holder's surname or family
      ## name. Also known as the last name. Required when the account holder is a person.
      ## Use also to store multiple surnames including the matronymic, or mother's,
      ## surname.
    middle_name*: Option[string]
      ## When the account holder is a person, the account holder's middle name. Use also
      ## to store multiple middle names including the patronymic, or father's, middle
      ## name.

  ExperienceContextBaseWithoutBrandShipping* = ref object of RootObj
    ## Customizes the payer experience during the approval process for the payment.
    locale*: Option[JsonNode]
    return_url*: JsonNode
    cancel_url*: JsonNode

  CryptoRequest* = ref object of RootObj
    ## Crypto payment used to fund the transaction.
    country_code*: JsonNode
    name*: JsonNode
    experience_context*: JsonNode

  PaymentSource* = ref object of RootObj
    ## The payment source definition.
    card*: Option[CardRequest]
    token*: Option[Token]
    paypal*: Option[JsonNode]
    bancontact*: Option[JsonNode]
    blik*: Option[JsonNode]
    eps*: Option[JsonNode]
    giropay*: Option[JsonNode]
    ideal*: Option[JsonNode]
    mybank*: Option[JsonNode]
    p24*: Option[JsonNode]
    sofort*: Option[JsonNode]
    trustly*: Option[JsonNode]
    apple_pay*: Option[JsonNode]
    google_pay*: Option[JsonNode]
    venmo*: Option[JsonNode]
    crypto*: Option[JsonNode]

  PaymentMethod* = ref object of RootObj
    ## The customer and merchant payment preferences.
    payee_preferred*: Option[PayeePaymentMethodPreference]
    standard_entry_class_code*: Option[string]
      ## NACHA (the regulatory body governing the ACH network) requires that API callers
      ## (merchants, partners) obtain the consumer’s explicit authorization before
      ## initiating a transaction. To stay compliant, you’ll need to make sure that you
      ## retain a compliant authorization for each transaction that you originate to the
      ## ACH Network using this API. ACH transactions are categorized (using SEC codes)
      ## by how you capture authorization from the Receiver (the person whose bank
      ## account is being debited or credited). PayPal supports the following SEC codes.

  StoredPaymentSource* = ref object of RootObj
    ## Provides additional details to process a payment using a `payment_source` that
    ## has been stored or is intended to be stored (also referred to as
    ## stored_credential or card-on-file).<br/>Parameter
    ## compatibility:<br/><ul><li>`payment_type=ONE_TIME` is compatible only with
    ## `payment_initiator=CUSTOMER`.</li><li>`usage=FIRST` is compatible only with
    ## `payment_initiator=CUSTOMER`.</li><li>`previous_transaction_reference` or
    ## `previous_network_transaction_reference` is compatible only with
    ## `payment_initiator=MERCHANT`.</li><li>Only one of the parameters -
    ## `previous_transaction_reference` and `previous_network_transaction_reference` -
    ## can be present in the request.</li></ul>
    payment_initiator*: PaymentInitiator
    payment_type*: StoredPaymentSourcePaymentType
    usage*: Option[StoredPaymentSourceUsageType]
    previous_network_transaction_reference*: Option[NetworkTransactionReference]

  OrderApplicationContext* = ref object of RootObj
    ## Customizes the payer experience during the approval process for the payment with
    ## PayPal.<blockquote><strong>Note:</strong> Partners and Marketplaces might
    ## configure <code>brand_name</code> and <code>shipping_preference</code> during
    ## partner account setup, which overrides the request values.</blockquote>
    brand_name*: Option[string]
      ## DEPRECATED. The label that overrides the business name in the PayPal account on
      ## the PayPal site. The fields in `application_context` are now available in the
      ## `experience_context` object under the `payment_source` which supports them (eg.
      ## `payment_source.paypal.experience_context.brand_name`). Please specify this
      ## field in the `experience_context` object instead of the `application_context`
      ## object.
    locale*: Option[JsonNode]
    landing_page*: Option[string]
      ## DEPRECATED. DEPRECATED. The type of landing page to show on the PayPal site for
      ## customer checkout.  The fields in `application_context` are now available in the
      ## `experience_context` object under the `payment_source` which supports them (eg.
      ## `payment_source.paypal.experience_context.landing_page`). Please specify this
      ## field in the `experience_context` object instead of the `application_context`
      ## object. <b>DEPRECATED</b><br><table><tr><th>See</th><th>SinceVersion</th></tr><
      ## tr><td>payment_source.paypal.experience_context.landing_page</td><td>2.9</td></t
      ## r></table>
    shipping_preference*: Option[string]
      ## DEPRECATED. DEPRECATED. The shipping preference:<ul><li>Displays the shipping
      ## address to the customer.</li><li>Enables the customer to choose an address on
      ## the PayPal site.</li><li>Restricts the customer from changing the address during
      ## the payment-approval process.</li></ul>.  The fields in `application_context`
      ## are now available in the `experience_context` object under the `payment_source`
      ## which supports them (eg.
      ## `payment_source.paypal.experience_context.shipping_preference`). Please specify
      ## this field in the `experience_context` object instead of the
      ## `application_context` object.
      ## <b>DEPRECATED</b><br><table><tr><th>See</th><th>SinceVersion</th></tr><tr><td>p
      ## ayment_source.paypal.experience_context.shipping_preference</td><td>2.9</td></tr
      ## ></table>
    user_action*: Option[string]
      ## DEPRECATED. Configures a <strong>Continue</strong> or <strong>Pay Now</strong>
      ## checkout flow.  The fields in `application_context` are now available in the
      ## `experience_context` object under the `payment_source` which supports them (eg.
      ## `payment_source.paypal.experience_context.user_action`). Please specify this
      ## field in the `experience_context` object instead of the `application_context`
      ## object.
    payment_method*: Option[JsonNode]
    return_url*: Option[string]
      ## DEPRECATED. The URL where the customer is redirected after the customer approves
      ## the payment. The fields in `application_context` are now available in the
      ## `experience_context` object under the `payment_source` which supports them (eg.
      ## `payment_source.paypal.experience_context.return_url`). Please specify this
      ## field in the `experience_context` object instead of the `application_context`
      ## object.
    cancel_url*: Option[string]
      ## DEPRECATED. The URL where the customer is redirected after the customer cancels
      ## the payment. The fields in `application_context` are now available in the
      ## `experience_context` object under the `payment_source` which supports them (eg.
      ## `payment_source.paypal.experience_context.cancel_url`). Please specify this
      ## field in the `experience_context` object instead of the `application_context`
      ## object.
    stored_payment_source*: Option[JsonNode]

  OrderRequest* = ref object of RootObj
    ## The order request details.
    intent*: CheckoutPaymentIntent
    payer*: Option[JsonNode]
    purchase_units*: seq[JsonNode]
      ## An array of purchase units. Each purchase unit establishes a contract between a
      ## payer and the payee. Each purchase unit represents either a full or partial
      ## order that the payer intends to purchase from the payee.
    payment_source*: Option[PaymentSource]
    application_context*: Option[JsonNode]

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

  ActivityTimestamps* = ref object of RootObj
    ## The date and time stamps that are common to authorized payment, captured
    ## payment, and refund transactions.
    create_time*: Option[JsonNode]
    update_time*: Option[JsonNode]

  LiabilityShift* = enum
    ## Liability shift indicator. The outcome of the issuer's authentication.
    NO = "NO"
    POSSIBLE = "POSSIBLE"
    UNKNOWN3 = "UNKNOWN"

  ThreeDSecureAuthenticationResponse* = ref object of RootObj
    ## Results of 3D Secure Authentication.
    authentication_status*: Option[JsonNode]
    enrollment_status*: Option[JsonNode]

  AuthenticationResponse* = ref object of RootObj
    ## Results of Authentication such as 3D Secure.
    liability_shift*: Option[LiabilityShift]
    three_d_secure*: Option[ThreeDSecureAuthenticationResponse]

  VaultResponse* = ref object of RootObj
    ## The details about a saved payment source.
    id*: Option[string]
      ## The PayPal-generated ID for the saved payment source.
    status*: Option[string]
      ## The vault status.
    customer*: Option[JsonNode]
    links*: Option[seq[JsonNode]]
      ## An array of request-related HATEOAS links.

  CardVaultResponse* = ref object of RootObj
    ## The details about a saved Card payment source.
    id*: Option[string]
      ## The PayPal-generated ID for the saved payment source.
    status*: Option[string]
      ## The vault status.
    customer*: Option[JsonNode]
    links*: Option[seq[JsonNode]]
      ## An array of request-related HATEOAS links.

  CardAttributesResponse* = ref object of RootObj
    ## Additional attributes associated with the use of this card.
    vault*: Option[CardVaultResponse]

  CardFromRequest* = ref object of RootObj
    ## Representation of card details as received in the request.
    expiry*: Option[JsonNode]
    last_digits*: Option[string]
      ## The last digits of the payment card.

  BinDetails* = ref object of RootObj
    ## Bank Identification Number (BIN) details used to fund a payment.
    bin*: Option[string]
      ## The Bank Identification Number (BIN) signifies the number that is being used to
      ## identify the granular level details (except the PII information) of the card.
    issuing_bank*: Option[string]
      ## The issuer of the card instrument.
    bin_country_code*: Option[JsonNode]
    products*: Option[seq[string]]
      ## The type of card product assigned to the BIN by the issuer. These values are
      ## defined by the issuer and may change over time. Some examples include:
      ## PREPAID_GIFT, CONSUMER, CORPORATE.

  CardResponse* = ref object of RootObj
    ## The payment card to use to fund a payment. Card can be a credit or debit card.
    name*: Option[string]
      ## The card holder's name as it appears on the card.
    last_digits*: Option[string]
      ## The last digits of the payment card.
    brand*: Option[JsonNode]
    available_networks*: Option[seq[JsonNode]]
      ## Array of brands or networks associated with the card.
    `type`*: Option[JsonNode]
    authentication_result*: Option[AuthenticationResponse]
    attributes*: Option[CardAttributesResponse]
    from_request*: Option[CardFromRequest]
    expiry*: Option[JsonNode]
    bin_details*: Option[JsonNode]
    stored_credential*: Option[CardStoredCredential]

  Phone3* = ref object of RootObj
    ## The phone number in its canonical international [E.164 numbering plan
    ## format](https://www.itu.int/rec/T-REC-E.164/en).
    national_number*: string
      ## The national number, in its canonical international [E.164 numbering plan
      ## format](https://www.itu.int/rec/T-REC-E.164/en). The combined length of the
      ## country calling code (CC) and the national number must not be greater than 15
      ## digits. The national number consists of a national destination code (NDC) and
      ## subscriber number (SN).

  PaypalWalletVaultResponse* = ref object of RootObj
    ## The details about a saved PayPal Wallet payment source.
    id*: Option[string]
      ## The PayPal-generated ID for the saved payment source.
    status*: Option[string]
      ## The vault status.
    customer*: Option[PaypalWalletCustomer]
    links*: Option[seq[JsonNode]]
      ## An array of request-related HATEOAS links.

  CobrandedCard* = ref object of RootObj
    ## Details about the merchant cobranded card used for order purchase.
    labels*: Option[seq[string]]
      ## Array of labels for the cobranded card.
    payee*: Option[JsonNode]
    amount*: Option[JsonNode]

  PaypalWalletAttributesResponse* = ref object of RootObj
    ## Additional attributes associated with the use of a PayPal Wallet.
    vault*: Option[PaypalWalletVaultResponse]
    cobranded_cards*: Option[seq[JsonNode]]
      ## An array of merchant cobranded cards used by buyer to complete an order. This
      ## array will be present if a merchant has onboarded their cobranded card with
      ## PayPal and provided corresponding label(s).

  PaypalWalletResponse* = ref object of RootObj
    ## The PayPal Wallet response.
    email_address*: Option[JsonNode]
    account_id*: Option[JsonNode]
    account_status*: Option[string]
      ## The account status indicates whether the buyer has verified the financial
      ## details associated with their PayPal account.
    name*: Option[JsonNode]
    phone_type*: Option[PhoneType]
    phone_number*: Option[JsonNode]
    birth_date*: Option[JsonNode]
    business_name*: Option[string]
      ## The business name of the PayPal account holder (populated for business accounts
      ## only)
    tax_info*: Option[JsonNode]
    address*: Option[JsonNode]
    attributes*: Option[PaypalWalletAttributesResponse]
    stored_credential*: Option[PaypalWalletStoredCredential]
    experience_status*: Option[string]
      ## This field indicates the status of PayPal's Checkout experience throughout the
      ## order lifecycle. The values reflect the current stage of the checkout process.

  ApplePayCardResponse* = ref object of RootObj
    ## The Card from Apple Pay Wallet used to fund the payment.
    name*: Option[string]
      ## The card holder's name as it appears on the card.
    last_digits*: Option[string]
      ## The last digits of the payment card.
    brand*: Option[JsonNode]
    available_networks*: Option[seq[JsonNode]]
      ## Array of brands or networks associated with the card.
    `type`*: Option[JsonNode]
    authentication_result*: Option[AuthenticationResponse]
    attributes*: Option[CardAttributesResponse]
    from_request*: Option[CardFromRequest]
    expiry*: Option[JsonNode]
    bin_details*: Option[JsonNode]
    stored_credential*: Option[CardStoredCredential]
    billing_address*: Option[JsonNode]
    country_code*: Option[JsonNode]

  IbanLastChars* = string

  Bancontact* = ref object of RootObj
    ## Information used to pay Bancontact.
    name*: Option[JsonNode]
    country_code*: Option[JsonNode]
    bic*: Option[JsonNode]
    iban_last_chars*: Option[IbanLastChars]
    card_last_digits*: Option[string]
      ## The last digits of the card used to fund the Bancontact payment.

  BlikOneClickResponse* = ref object of RootObj
    ## Information used to pay using BLIK one-click flow.
    consumer_reference*: Option[string]
      ## The merchant generated, unique reference serving as a primary identifier for
      ## accounts connected between Blik and a merchant.

  Blik* = ref object of RootObj
    ## Information used to pay using BLIK.
    name*: Option[JsonNode]
    country_code*: Option[JsonNode]
    email*: Option[JsonNode]
    one_click*: Option[JsonNode]

  Eps* = ref object of RootObj
    ## Information used to pay using eps.
    name*: Option[JsonNode]
    country_code*: Option[JsonNode]
    bic*: Option[JsonNode]

  Giropay* = ref object of RootObj
    ## Information needed to pay using giropay.
    name*: Option[JsonNode]
    country_code*: Option[JsonNode]
    bic*: Option[JsonNode]

  Ideal* = ref object of RootObj
    ## Information used to pay using iDEAL.
    name*: Option[JsonNode]
    country_code*: Option[JsonNode]
    bic*: Option[JsonNode]
    iban_last_chars*: Option[IbanLastChars]

  Mybank* = ref object of RootObj
    ## Information used to pay using MyBank.
    name*: Option[JsonNode]
    country_code*: Option[JsonNode]
    bic*: Option[JsonNode]
    iban_last_chars*: Option[IbanLastChars]

  P24* = ref object of RootObj
    ## Information used to pay using P24(Przelewy24).
    name*: Option[JsonNode]
    email*: Option[JsonNode]
    country_code*: Option[JsonNode]
    payment_descriptor*: Option[string]
      ## P24 generated payment description.
    method_id*: Option[string]
      ## Numeric identifier of the payment scheme or bank used for the payment.
    method_description*: Option[string]
      ## Friendly name of the payment scheme or bank used for the payment.

  Sofort* = ref object of RootObj
    ## Information used to pay using Sofort.
    name*: Option[JsonNode]
    country_code*: Option[JsonNode]
    bic*: Option[JsonNode]
    iban_last_chars*: Option[IbanLastChars]

  Trustly* = ref object of RootObj
    ## Information needed to pay using Trustly.
    name*: Option[JsonNode]
    country_code*: Option[JsonNode]
    email*: Option[JsonNode]
    bic*: Option[JsonNode]
    iban_last_chars*: Option[IbanLastChars]

  ApplePayAttributesResponse* = ref object of RootObj
    ## Additional attributes associated with the use of Apple Pay.
    vault*: Option[VaultResponse]

  ApplePay* = ref object of RootObj
    ## Information needed to pay using ApplePay.
    id*: Option[string]
      ## ApplePay transaction identifier, this will be the unique identifier for this
      ## transaction provided by Apple. The pattern is defined by an external party and
      ## supports Unicode.
    token*: Option[string]
      ## Encrypted ApplePay token, containing card information. This token would be
      ## base64encoded. The pattern is defined by an external party and supports Unicode.
    name*: Option[JsonNode]
    email_address*: Option[JsonNode]
    phone_number*: Option[JsonNode]
    card*: Option[JsonNode]
    attributes*: Option[JsonNode]
    stored_credential*: Option[CardStoredCredential]

  GooglePayCardResponse* = ref object of RootObj
    ## The payment card to use to fund a Google Pay payment response. Can be a credit
    ## or debit card.
    name*: Option[string]
      ## The card holder's name as it appears on the card.
    last_digits*: Option[string]
      ## The last digits of the payment card.
    `type`*: Option[JsonNode]
    brand*: Option[JsonNode]
    billing_address*: Option[JsonNode]
    authentication_result*: Option[AuthenticationResponse]

  GooglePay* = ref object of RootObj
    ## Google Pay Wallet payment data.
    name*: Option[JsonNode]
    email_address*: Option[JsonNode]
    phone_number*: Option[JsonNode]
    card*: Option[JsonNode]

  VenmoVaultResponse* = ref object of RootObj
    ## The details about a saved venmo payment source.
    id*: Option[string]
      ## The PayPal-generated ID for the saved payment source.
    status*: Option[string]
      ## The vault status.
    customer*: Option[JsonNode]
    links*: Option[seq[JsonNode]]
      ## An array of request-related HATEOAS links.

  VenmoWalletAttributesResponse* = ref object of RootObj
    ## Additional attributes associated with the use of a Venmo Wallet.
    vault*: Option[VenmoVaultResponse]

  VenmoWalletResponse* = ref object of RootObj
    ## Venmo wallet response.
    email_address*: Option[JsonNode]
    account_id*: Option[JsonNode]
    user_name*: Option[string]
      ## The Venmo user name chosen by the user, also know as a Venmo handle.
    name*: Option[JsonNode]
    phone_number*: Option[JsonNode]
    address*: Option[JsonNode]
    return_flow*: Option[string]
      ## Merchant preference on how the buyer can navigate back to merchant website post
      ## approving the transaction on the Venmo App.
    attributes*: Option[VenmoWalletAttributesResponse]

  Crypto* = ref object of RootObj
    ## Pay With Crypto details response object.
    country_code*: Option[JsonNode]
    name*: Option[JsonNode]
    experience_context*: Option[JsonNode]

  PaymentSourceResponse* = ref object of RootObj
    ## The payment source used to fund the payment.
    card*: Option[CardResponse]
    paypal*: Option[PaypalWalletResponse]
    bancontact*: Option[Bancontact]
    blik*: Option[Blik]
    eps*: Option[Eps]
    giropay*: Option[Giropay]
    ideal*: Option[Ideal]
    mybank*: Option[Mybank]
    p24*: Option[P24]
    sofort*: Option[Sofort]
    trustly*: Option[Trustly]
    apple_pay*: Option[ApplePay]
    google_pay*: Option[GooglePay]
    venmo*: Option[VenmoWalletResponse]
    crypto*: Option[Crypto]

  Item* = ref object of RootObj
    ## The details for the items to be purchased.
    name*: string
      ## The item name or title.
    unit_amount*: JsonNode
    tax*: Option[JsonNode]
    quantity*: string
      ## The item quantity. Must be a whole number.
    description*: Option[string]
      ## The detailed item description.
    sku*: Option[string]
      ## The stock keeping unit (SKU) for the item.
    url*: Option[string]
      ## The URL to the item being purchased. Visible to buyer and used in buyer
      ## experiences.
    category*: Option[string]
      ## The item category type.
    image_url*: Option[string]
      ## The URL of the item's image. File type and size restrictions apply. An image
      ## that violates these restrictions will not be honored.
    upc*: Option[JsonNode]
    billing_plan*: Option[OrderBillingPlan]

  TrackerStatus* = enum
    ## The status of the item shipment.
    CANCELLED = "CANCELLED"
    SHIPPED = "SHIPPED"

  TrackerItem* = ref object of RootObj
    ## The details of the items in the shipment.
    name*: Option[string]
      ## The item name or title.
    quantity*: Option[string]
      ## The item quantity. Must be a whole number.
    sku*: Option[string]
      ## The stock keeping unit (SKU) for the item. This can contain unicode characters.
    url*: Option[string]
      ## The URL to the item being purchased. Visible to buyer and used in buyer
      ## experiences.
    image_url*: Option[string]
      ## The URL of the item's image. File type and size restrictions apply. An image
      ## that violates these restrictions will not be honored.
    upc*: Option[JsonNode]

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

  Tracker* = ref object of RootObj
    ## The tracking response on creation of tracker.
    id*: Option[string]
      ## The tracker id.
    status*: Option[TrackerStatus]
    items*: Option[seq[JsonNode]]
      ## An array of details of items in the shipment.
    links*: Option[seq[JsonNode]]
      ## An array of request-related HATEOAS links.
    create_time*: Option[JsonNode]
    update_time*: Option[JsonNode]

  ShippingWithTrackingDetails* = ref object of RootObj
    ## The order shipping details.
    name*: Option[JsonNode]
    email_address*: Option[JsonNode]
    phone_number*: Option[JsonNode]
    `type`*: Option[string]
      ## A classification for the method of purchase fulfillment (e.g shipping, in-store
      ## pickup, etc). Either `type` or `options` may be present, but not both.
    options*: Option[seq[JsonNode]]
      ## An array of shipping options that the payee or merchant offers to the payer to
      ## ship or pick up their items.
    address*: Option[JsonNode]
    trackers*: Option[seq[Tracker]]
      ## An array of trackers for a transaction.

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

  AuthorizationWithAdditionalData* = ref object of RootObj
    ## The authorization with additional payment details, such as risk assessment and
    ## processor response. These details are populated only for certain payment
    ## methods.
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
    processor_response*: Option[JsonNode]

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

  PaymentCollection* = ref object of RootObj
    ## The collection of payments, or transactions, for a purchase unit in an order.
    ## For example, authorized payments, captured payments, and refunds.
    authorizations*: Option[seq[JsonNode]]
      ## An array of authorized payments for a purchase unit. A purchase unit can have
      ## zero or more authorized payments.
    captures*: Option[seq[JsonNode]]
      ## An array of captured payments for a purchase unit. A purchase unit can have zero
      ## or more captured payments.
    refunds*: Option[seq[JsonNode]]
      ## An array of refunds for a purchase unit. A purchase unit can have zero or more
      ## refunds.

  PurchaseUnit* = ref object of RootObj
    ## The purchase unit details. Used to capture required information for the payment
    ## contract.
    reference_id*: Option[string]
      ## The API caller-provided external ID for the purchase unit. Required for multiple
      ## purchase units when you must update the order through `PATCH`. If you omit this
      ## value and the order contains only one purchase unit, PayPal sets this value to
      ## `default`. <blockquote><strong>Note:</strong> If there are multiple purchase
      ## units, <code>reference_id</code> is required for each purchase
      ## unit.</blockquote>
    amount*: Option[AmountWithBreakdown]
    payee*: Option[JsonNode]
    payment_instruction*: Option[PaymentInstruction]
    description*: Option[string]
      ## The purchase description.
    custom_id*: Option[string]
      ## The API caller-provided external ID. Used to reconcile API caller-initiated
      ## transactions with PayPal transactions. Appears in transaction and settlement
      ## reports.
    invoice_id*: Option[string]
      ## The API caller-provided external invoice ID for this order.
    id*: Option[string]
      ## The PayPal-generated ID for the purchase unit. This ID appears in both the
      ## payer's transaction history and the emails that the payer receives. In addition,
      ## this ID is available in transaction and settlement reports that merchants and
      ## API callers can use to reconcile transactions. This ID is only available when an
      ## order is saved by calling <code>v2/checkout/orders/id/save</code>.
    soft_descriptor*: Option[string]
      ## The payment descriptor on account transactions on the customer's credit card
      ## statement, that PayPal sends to processors. The maximum length of the soft
      ## descriptor information that you can pass in the API field is 22 characters, in
      ## the following format:<code>22 - len(PAYPAL * (8)) - len(<var>Descriptor in
      ## Payment Receiving Preferences of Merchant account</var> + 1)</code>The PAYPAL
      ## prefix uses 8 characters.<br/><br/>The soft descriptor supports the following
      ## ASCII characters:<ul><li>Alphanumeric
      ## characters</li><li>Dashes</li><li>Asterisks</li><li>Periods
      ## (.)</li><li>Spaces</li></ul>For Wallet payments marketplace
      ## integrations:<ul><li>The merchant descriptor in the Payment Receiving
      ## Preferences must be the marketplace name.</li><li>You can't use the remaining
      ## space to show the customer service number.</li><li>The remaining spaces can be a
      ## combination of seller name and country.</li></ul><br/>For unbranded payments
      ## (Direct Card) marketplace integrations, use a combination of the seller name and
      ## phone number.
    items*: Option[seq[JsonNode]]
      ## An array of items that the customer purchases from the merchant.
    shipping*: Option[JsonNode]
    supplementary_data*: Option[JsonNode]
    payments*: Option[JsonNode]

  OrderStatus* = enum
    ## The order status.
    CREATED = "CREATED"
    SAVED = "SAVED"
    APPROVED = "APPROVED"
    VOIDED = "VOIDED"
    COMPLETED = "COMPLETED"
    PAYERACTIONREQUIRED = "PAYER_ACTION_REQUIRED"

  Order* = ref object of RootObj
    ## The order details.
    create_time*: Option[JsonNode]
    update_time*: Option[JsonNode]
    id*: Option[string]
      ## The ID of the order.
    payment_source*: Option[JsonNode]
    intent*: Option[JsonNode]
    payer*: Option[JsonNode]
    purchase_units*: Option[seq[JsonNode]]
      ## An array of purchase units. Each purchase unit establishes a contract between a
      ## customer and merchant. Each purchase unit represents either a full or partial
      ## order that the customer intends to purchase from the merchant.
    status*: Option[JsonNode]
    links*: Option[seq[JsonNode]]
      ## An array of request-related HATEOAS links. To complete payer approval, use the
      ## `approve` link to redirect the payer. The API caller has 6 hours (default
      ## setting, this which can be changed by your account manager to 24/48/72 hours to
      ## accommodate your use case) from the time the order is created, to redirect your
      ## payer. Once redirected, the API caller has 6 hours for the payer to approve the
      ## order and either authorize or capture the order. If you are not using the PayPal
      ## JavaScript SDK to initiate PayPal Checkout (in context) ensure that you include
      ## `application_context.return_url` is specified or you will get "We're sorry,
      ## Things don't appear to be working at the moment" after the payer approves the
      ## payment.

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
      ## href="https://www.rfc-editor.org/rfc/rfc6902">JSON Patch</a> allows any type for
      ## <code>value</code>, the <code>type</code> property is not specified.
    `from`*: Option[string]
      ## The <a href="https://tools.ietf.org/html/rfc6901">JSON Pointer</a> to the target
      ## document location from which to move the value. Required for the
      ## <code>move</code> operation.

  PatchRequest* = seq[JsonNode]

  OrderConfirmApplicationContext* = ref object of RootObj
    ## Customizes the payer confirmation experience.
    brand_name*: Option[string]
      ## Label to present to your payer as part of the PayPal hosted web experience.
    locale*: Option[JsonNode]
    return_url*: Option[string]
      ## The URL where the customer is redirected after the customer approves the
      ## payment.
    cancel_url*: Option[string]
      ## The URL where the customer is redirected after the customer cancels the payment.
    stored_payment_source*: Option[StoredPaymentSource]

  ConfirmOrderRequest* = ref object of RootObj
    ## Payer confirms the intent to pay for the Order using the provided payment
    ## source.
    payment_source*: PaymentSource
    application_context*: Option[OrderConfirmApplicationContext]

  OrderAuthorizeRequest* = ref object of RootObj
    ## The authorization of an order request.
    payment_source*: Option[JsonNode]

  OrderAuthorizeResponse* = ref object of RootObj
    ## The order authorize response.
    create_time*: Option[JsonNode]
    update_time*: Option[JsonNode]
    id*: Option[string]
      ## The ID of the order.
    payment_source*: Option[JsonNode]
    intent*: Option[JsonNode]
    payer*: Option[JsonNode]
    purchase_units*: Option[seq[JsonNode]]
      ## An array of purchase units. Each purchase unit establishes a contract between a
      ## customer and merchant. Each purchase unit represents either a full or partial
      ## order that the customer intends to purchase from the merchant.
    status*: Option[JsonNode]
    links*: Option[seq[JsonNode]]
      ## An array of request-related HATEOAS links. To complete payer approval, use the
      ## `approve` link to redirect the payer. The API caller has 6 hours (default
      ## setting, this which can be changed by your account manager to 24/48/72 hours to
      ## accommodate your use case) from the time the order is created, to redirect your
      ## payer. Once redirected, the API caller has 6 hours for the payer to approve the
      ## order and either authorize or capture the order. If you are not using the PayPal
      ## JavaScript SDK to initiate PayPal Checkout (in context) ensure that you include
      ## `application_context.return_url` is specified or you will get "We're sorry,
      ## Things don't appear to be working at the moment" after the payer approves the
      ## payment.

  OrderCaptureRequest* = ref object of RootObj
    ## Completes an capture payment for an order.
    payment_source*: Option[JsonNode]

  ShipmentCarrier* = enum
    ## The carrier for the shipment. Some carriers have a global version as well as
    ## local subsidiaries. The subsidiaries are repeated over many countries and might
    ## also have an entry in the global list. Choose the carrier for your country. If
    ## the carrier is not available for your country, choose the global version of the
    ## carrier. If your carrier name is not in the list, set `carrier` to `OTHER` and
    ## set carrier name in `carrier_name_other`. For allowed values, see <a
    ## href="/docs/tracking/reference/carriers/">Carriers</a>.
    DPDRU = "DPD_RU"
    BGBULGARIANPOST = "BG_BULGARIAN_POST"
    KRKOREAPOST = "KR_KOREA_POST"
    ZACOURIERIT = "ZA_COURIERIT"
    FREXAPAQ = "FR_EXAPAQ"
    AREEMIRATESPOST = "ARE_EMIRATES_POST"
    GAC = "GAC"
    GEIS = "GEIS"
    SFEX = "SF_EX"
    PAGO = "PAGO"
    MYHERMES = "MYHERMES"
    DIAMONDEUROGISTICS = "DIAMOND_EUROGISTICS"
    CORPORATECOURIERSWEBHOOK = "CORPORATECOURIERS_WEBHOOK"
    BOND = "BOND"
    OMNIPARCEL = "OMNIPARCEL"
    SKPOSTA = "SK_POSTA"
    PUROLATOR = "PUROLATOR"
    FETCHRWEBHOOK = "FETCHR_WEBHOOK"
    THEDELIVERYGROUP = "THEDELIVERYGROUP"
    CELLOSQUARE = "CELLO_SQUARE"
    TARRIVE = "TARRIVE"
    COLLIVERY = "COLLIVERY"
    MAINFREIGHT = "MAINFREIGHT"
    INDFIRSTFLIGHT = "IND_FIRSTFLIGHT"
    ACSWORLDWIDE = "ACSWORLDWIDE"
    AMSTAN = "AMSTAN"
    OKAYPARCEL = "OKAYPARCEL"
    ENVIALIAREFERENCE = "ENVIALIA_REFERENCE"
    SEURES = "SEUR_ES"
    CONTINENTAL = "CONTINENTAL"
    FDSEXPRESS = "FDSEXPRESS"
    AMAZONFBASWISHIP = "AMAZON_FBA_SWISHIP"
    WYNGS = "WYNGS"
    DHLACTIVETRACING = "DHL_ACTIVE_TRACING"
    ZYLLEM = "ZYLLEM"
    RUSTON = "RUSTON"
    XPOST = "XPOST"
    CORREOSES = "CORREOS_ES"
    DHLFR = "DHL_FR"
    PANASIA = "PAN_ASIA"
    BRTIT = "BRT_IT"
    SREKOREA = "SRE_KOREA"
    SPEEDEE = "SPEEDEE"
    TNTUK = "TNT_UK"
    VENIPAK = "VENIPAK"
    SHREENANDANCOURIER = "SHREENANDANCOURIER"
    CROSHOT = "CROSHOT"
    NIPOSTNG = "NIPOST_NG"
    EPSTGLBL = "EPST_GLBL"
    NEWGISTICS = "NEWGISTICS"
    POSTSLOVENIA = "POST_SLOVENIA"
    JERSEYPOST = "JERSEY_POST"
    BOMBINOEXP = "BOMBINOEXP"
    WMG = "WMG"
    XQEXPRESS = "XQ_EXPRESS"
    FURDECO = "FURDECO"
    LHTEXPRESS = "LHT_EXPRESS"
    SOUTHAFRICANPOSTOFFICE = "SOUTH_AFRICAN_POST_OFFICE"
    SPOTON = "SPOTON"
    DIMERCO = "DIMERCO"
    CYPRUSPOSTCYP = "CYPRUS_POST_CYP"
    ABCUSTOM = "ABCUSTOM"
    INDDELIVREE = "IND_DELIVREE"
    CNBESTEXPRESS = "CN_BESTEXPRESS"
    DXSFTP = "DX_SFTP"
    PICKUPPMYS = "PICKUPP_MYS"
    FMX = "FMX"
    HELLMANN = "HELLMANN"
    SHIPITASIA = "SHIP_IT_ASIA"
    KERRYECOMMERCE = "KERRY_ECOMMERCE"
    FRETERAPIDO = "FRETERAPIDO"
    PITNEYBOWES = "PITNEY_BOWES"
    XPRESSENDK = "XPRESSEN_DK"
    SEURSPAPI = "SEUR_SP_API"
    DELIVERYONTIME = "DELIVERYONTIME"
    JINSUNG = "JINSUNG"
    TRANSKARGO = "TRANS_KARGO"
    SWISHIPDE = "SWISHIP_DE"
    IVOYWEBHOOK = "IVOY_WEBHOOK"
    AIRMEEWEBHOOK = "AIRMEE_WEBHOOK"
    DHLBENELUX = "DHL_BENELUX"
    FIRSTMILE = "FIRSTMILE"
    FASTWAYIR = "FASTWAY_IR"
    HHEXP = "HH_EXP"
    MYSMYPOSTONLINE = "MYS_MYPOST_ONLINE"
    TNTNL = "TNT_NL"
    TIPSA = "TIPSA"
    TAQBINMY = "TAQBIN_MY"
    KGMHUB = "KGMHUB"
    INTEXPRESS = "INTEXPRESS"
    OVERSEEXP = "OVERSE_EXP"
    ONECLICK = "ONECLICK"
    ROADRUNNERFREIGHT = "ROADRUNNER_FREIGHT"
    GLSCROTIA = "GLS_CROTIA"
    MRWFTP = "MRW_FTP"
    BLUEX = "BLUEX"
    DYLT = "DYLT"
    DPDIR = "DPD_IR"
    SINGLBL = "SIN_GLBL"
    TUFFNELLSREFERENCE = "TUFFNELLS_REFERENCE"
    CJPACKET = "CJPACKET"
    MILKMAN = "MILKMAN"
    ASIGNA = "ASIGNA"
    ONEWORLDEXPRESS = "ONEWORLDEXPRESS"
    ROYALMAIL = "ROYAL_MAIL"
    VIAEXPRESS = "VIA_EXPRESS"
    TIGFREIGHT = "TIGFREIGHT"
    ZTOEXPRESS = "ZTO_EXPRESS"
    TWOGO = "TWO_GO"
    IML = "IML"
    INTELVALLEY = "INTEL_VALLEY"
    EFS = "EFS"
    UKUKMAIL = "UK_UK_MAIL"
    RAM = "RAM"
    ALLIEDEXPRESS = "ALLIEDEXPRESS"
    APCOVERNIGHT = "APC_OVERNIGHT"
    SHIPPIT = "SHIPPIT"
    TFM = "TFM"
    MXPRESS = "M_XPRESS"
    HDBBOX = "HDB_BOX"
    CLEVYLINKS = "CLEVY_LINKS"
    IBEONE = "IBEONE"
    FIEGENL = "FIEGE_NL"
    KWEGLOBAL = "KWE_GLOBAL"
    CTCEXPRESS = "CTC_EXPRESS"
    AMAZON = "AMAZON"
    MORELINK = "MORE_LINK"
    JX = "JX"
    EASYMAIL = "EASY_MAIL"
    ADUIEPYLE = "ADUIEPYLE"
    GBPANTHER = "GB_PANTHER"
    EXPRESSSALE = "EXPRESSSALE"
    SGDETRACK = "SG_DETRACK"
    TRUNKRSWEBHOOK = "TRUNKRS_WEBHOOK"
    MATDESPATCH = "MATDESPATCH"
    DICOM = "DICOM"
    MBW = "MBW"
    KHMCAMBODIAPOST = "KHM_CAMBODIA_POST"
    SINOTRANS = "SINOTRANS"
    BRTITPARCELID = "BRT_IT_PARCELID"
    DHLSUPPLYCHAIN = "DHL_SUPPLY_CHAIN"
    DHLPL = "DHL_PL"
    TOPYOU = "TOPYOU"
    PALEXPRESS = "PALEXPRESS"
    DHLSG = "DHL_SG"
    CNWEDO = "CN_WEDO"
    FULFILLME = "FULFILLME"
    DPDDELISTRACK = "DPD_DELISTRACK"
    UPSREFERENCE = "UPS_REFERENCE"
    CARIBOU = "CARIBOU"
    LOCUSWEBHOOK = "LOCUS_WEBHOOK"
    DSV = "DSV"
    P2PTRC = "P2P_TRC"
    DIRECTPARCELS = "DIRECTPARCELS"
    NOVAPOSHTAINT = "NOVA_POSHTA_INT"
    FEDEXPOLAND = "FEDEX_POLAND"
    CNJCEX = "CN_JCEX"
    FARINTERNATIONAL = "FAR_INTERNATIONAL"
    IDEXPRESS = "IDEXPRESS"
    GANGBAO = "GANGBAO"
    NEWAY = "NEWAY"
    POSTNLINT3S = "POSTNL_INT_3_S"
    RPXID = "RPX_ID"
    DESIGNERTRANSPORTWEBHOOK = "DESIGNERTRANSPORT_WEBHOOK"
    GLSSLOVEN = "GLS_SLOVEN"
    PARCELLEDIN = "PARCELLED_IN"
    GSIEXPRESS = "GSI_EXPRESS"
    CONWAY = "CON_WAY"
    BROUWERTRANSPORT = "BROUWER_TRANSPORT"
    CPEX = "CPEX"
    ISRAELPOST = "ISRAEL_POST"
    DTDCIN = "DTDC_IN"
    PTTPOST = "PTT_POST"
    XDEWEBHOOK = "XDE_WEBHOOK"
    TOLOS = "TOLOS"
    GIAOHANG = "GIAO_HANG"
    GEODISESPACE = "GEODIS_ESPACE"
    MAGYARHU = "MAGYAR_HU"
    DOORDASHWEBHOOK = "DOORDASH_WEBHOOK"
    TIKIID = "TIKI_ID"
    CJHKINTERNATIONAL = "CJ_HK_INTERNATIONAL"
    STARTRACKEXPRESS = "STAR_TRACK_EXPRESS"
    HELTHJEM = "HELTHJEM"
    SFB2C = "SFB2C"
    FREIGHTQUOTE = "FREIGHTQUOTE"
    LANDMARKGLOBALREFERENCE = "LANDMARK_GLOBAL_REFERENCE"
    PARCEL2GO = "PARCEL2GO"
    DELNEXT = "DELNEXT"
    RCL = "RCL"
    CGSEXPRESS = "CGS_EXPRESS"
    HKPOST = "HK_POST"
    SAPEXPRESS = "SAP_EXPRESS"
    PARCELPOSTSG = "PARCELPOST_SG"
    HERMES = "HERMES"
    INDSAFEEXPRESS = "IND_SAFEEXPRESS"
    TOPHATTEREXPRESS = "TOPHATTEREXPRESS"
    MGLOBAL = "MGLOBAL"
    AVERITT = "AVERITT"
    LEADER = "LEADER"
    f2EBOX = "_2EBOX"
    SGSPEEDPOST = "SG_SPEEDPOST"
    DBSCHENKERSE = "DBSCHENKER_SE"
    ISRPOSTDOMESTIC = "ISR_POST_DOMESTIC"
    BESTWAYPARCEL = "BESTWAYPARCEL"
    ASENDIADE = "ASENDIA_DE"
    NIGHTLINEUK = "NIGHTLINE_UK"
    TAQBINSG = "TAQBIN_SG"
    TCKEXPRESS = "TCK_EXPRESS"
    ENDEAVOURDELIVERY = "ENDEAVOUR_DELIVERY"
    NANJINGWOYUAN = "NANJINGWOYUAN"
    HEPPNERFR = "HEPPNER_FR"
    EMPSCN = "EMPS_CN"
    FONSEN = "FONSEN"
    PICKRR = "PICKRR"
    APCOVERNIGHTCONNUM = "APC_OVERNIGHT_CONNUM"
    STARTRACKNEXTFLIGHT = "STAR_TRACK_NEXT_FLIGHT"
    DAJIN = "DAJIN"
    UPSFREIGHT = "UPS_FREIGHT"
    POSTAPLUS = "POSTA_PLUS"
    CEVA = "CEVA"
    ANSERX = "ANSERX"
    JSEXPRESS = "JS_EXPRESS"
    PADTF = "PADTF"
    UPSMAILINNOVATIONS = "UPS_MAIL_INNOVATIONS"
    SYPOST = "SYPOST"
    AMAZONSHIPMCF = "AMAZON_SHIP_MCF"
    YUSEN = "YUSEN"
    BRING = "BRING"
    SDAIT = "SDA_IT"
    GBA = "GBA"
    NEWEGGEXPRESS = "NEWEGGEXPRESS"
    SPEEDCOURIERSGR = "SPEEDCOURIERS_GR"
    FORRUN = "FORRUN"
    PICKUP2 = "PICKUP"
    ECMS = "ECMS"
    INTELIPOST = "INTELIPOST"
    FLASHEXPRESS = "FLASHEXPRESS"
    CNSTO = "CN_STO"
    SEKOSFTP = "SEKO_SFTP"
    HOMEDELIVERYSOLUTIONS = "HOME_DELIVERY_SOLUTIONS"
    DPDHGRY = "DPD_HGRY"
    KERRYTTCVN = "KERRYTTC_VN"
    JOYINGBOX = "JOYING_BOX"
    TOTALEXPRESS = "TOTAL_EXPRESS"
    ZJSEXPRESS = "ZJS_EXPRESS"
    STARKEN = "STARKEN"
    DEMANDSHIP = "DEMANDSHIP"
    CNDPEX = "CN_DPEX"
    AUPOSTCN = "AUPOST_CN"
    LOGISTERS = "LOGISTERS"
    GOGLOBALPOST = "GOGLOBALPOST"
    GLSCZ = "GLS_CZ"
    PAACKWEBHOOK = "PAACK_WEBHOOK"
    GRABWEBHOOK = "GRAB_WEBHOOK"
    PARCELPOINT = "PARCELPOINT"
    ICUMULUS = "ICUMULUS"
    DAIGLOBALTRACK = "DAIGLOBALTRACK"
    GLOBALIPARCEL = "GLOBAL_IPARCEL"
    YURTICIKARGO = "YURTICI_KARGO"
    CNPAYPALPACKAGE = "CN_PAYPAL_PACKAGE"
    PARCEL2POST = "PARCEL_2_POST"
    GLSIT = "GLS_IT"
    PILLOGISTICS = "PIL_LOGISTICS"
    HEPPNER = "HEPPNER"
    GENERALOVERNIGHT = "GENERAL_OVERNIGHT"
    HAPPY2POINT = "HAPPY2POINT"
    CHITCHATS = "CHITCHATS"
    SMOOTH = "SMOOTH"
    CLELOGISTICS = "CLE_LOGISTICS"
    FIEGE = "FIEGE"
    MXCARGO = "MX_CARGO"
    ZIINGFINALMILE = "ZIINGFINALMILE"
    DAYTONFREIGHT = "DAYTON_FREIGHT"
    TCS = "TCS"
    AEX = "AEX"
    HERMESDE = "HERMES_DE"
    ROUTIFICWEBHOOK = "ROUTIFIC_WEBHOOK"
    GLOBAVEND = "GLOBAVEND"
    CJLOGISTICS = "CJ_LOGISTICS"
    PALLETNETWORK = "PALLET_NETWORK"
    RAFPH = "RAF_PH"
    UKXDP = "UK_XDP"
    PAPEREXPRESS = "PAPER_EXPRESS"
    LAPOSTESUIVI = "LA_POSTE_SUIVI"
    PAQUETEXPRESS = "PAQUETEXPRESS"
    LIEFERY = "LIEFERY"
    STRECKTRANSPORT = "STRECK_TRANSPORT"
    PONYEXPRESS = "PONY_EXPRESS"
    ALWAYSEXPRESS = "ALWAYS_EXPRESS"
    GBSBROKER = "GBS_BROKER"
    CITYLINKMY = "CITYLINK_MY"
    ALLJOY = "ALLJOY"
    YODEL = "YODEL"
    YODELDIR = "YODEL_DIR"
    STONE3PL = "STONE3PL"
    PARCELPALWEBHOOK = "PARCELPAL_WEBHOOK"
    DHLECOMERCEASA = "DHL_ECOMERCE_ASA"
    SIMPLYPOST = "SIMPLYPOST"
    KYEXPRESS = "KY_EXPRESS"
    SHENZHEN = "SHENZHEN"
    USLASERSHIP = "US_LASERSHIP"
    UCEXPRE = "UC_EXPRE"
    DIDADI = "DIDADI"
    CJKR = "CJ_KR"
    DBSCHENKERB2B = "DBSCHENKER_B2B"
    MXE = "MXE"
    CAEDELIVERS = "CAE_DELIVERS"
    PFCEXPRESS = "PFCEXPRESS"
    WHISTL = "WHISTL"
    WEPOST = "WEPOST"
    DHLPARCELES = "DHL_PARCEL_ES"
    DDEXPRESS = "DDEXPRESS"
    ARAMEXAU = "ARAMEX_AU"
    BNEED = "BNEED"
    HKTGX = "HK_TGX"
    LATVIJASPASTS = "LATVIJAS_PASTS"
    VIAEUROPE = "VIAEUROPE"
    CORREOUY = "CORREO_UY"
    CHRONOPOSTFR = "CHRONOPOST_FR"
    JNET = "J_NET"
    f6LS = "_6LS"
    BLRBELPOST = "BLR_BELPOST"
    BIRDSYSTEM = "BIRDSYSTEM"
    DOBROPOST = "DOBROPOST"
    WAHANAID = "WAHANA_ID"
    WEASHIP = "WEASHIP"
    SONICTL = "SONICTL"
    KWT = "KWT"
    AFLLOGFTP = "AFLLOG_FTP"
    SKYNETWORLDWIDE = "SKYNET_WORLDWIDE"
    NOVAPOSHTA = "NOVA_POSHTA"
    SEINO = "SEINO"
    SZENDEX = "SZENDEX"
    BPOSTINT = "BPOST_INT"
    DBSCHENKERSV = "DBSCHENKER_SV"
    AODEUTSCHLAND = "AO_DEUTSCHLAND"
    EUFLEETSOLUTIONS = "EU_FLEET_SOLUTIONS"
    PCFCORP = "PCFCORP"
    LINKBRIDGE = "LINKBRIDGE"
    PRIMAMULTICIPTA = "PRIMAMULTICIPTA"
    COUREX = "COUREX"
    ZAJILEXPRESS = "ZAJIL_EXPRESS"
    COLLECTCO = "COLLECTCO"
    JTEXPRESS = "JTEXPRESS"
    FEDEXUK = "FEDEX_UK"
    USHIP = "USHIP"
    PIXSELL = "PIXSELL"
    SHIPTOR = "SHIPTOR"
    CDEK = "CDEK"
    VNMVIETTELPOST = "VNM_VIETTELPOST"
    CJCENTURY = "CJ_CENTURY"
    GSO = "GSO"
    VIWO = "VIWO"
    SKYBOX = "SKYBOX"
    KERRYTJ = "KERRYTJ"
    NTLOGISTICSVN = "NTLOGISTICS_VN"
    SDHSCM = "SDH_SCM"
    ZINC = "ZINC"
    DPESOUTHAFRC = "DPE_SOUTH_AFRC"
    CESKACZ = "CESKA_CZ"
    ACSGR = "ACS_GR"
    DEALERSEND = "DEALERSEND"
    JOCOM = "JOCOM"
    CSE = "CSE"
    TFORCEFINALMILE = "TFORCE_FINALMILE"
    SHIPGATE = "SHIP_GATE"
    SHIPTER = "SHIPTER"
    NATIONALSAMEDAY = "NATIONAL_SAMEDAY"
    YUNEXPRESS = "YUNEXPRESS"
    CAINIAO = "CAINIAO"
    DMSMATRIX = "DMS_MATRIX"
    DIRECTLOG = "DIRECTLOG"
    ASENDIAUS = "ASENDIA_US"
    f3JMSLOGISTICS = "_3JMSLOGISTICS"
    LICCARDIEXPRESS = "LICCARDI_EXPRESS"
    SKYPOSTAL = "SKY_POSTAL"
    CNWANGTONG = "CNWANGTONG"
    POSTNORDLOGISTICSDK = "POSTNORD_LOGISTICS_DK"
    LOGISTIKA = "LOGISTIKA"
    CELERITAS = "CELERITAS"
    PRESSIODE = "PRESSIODE"
    SHREEMARUTI = "SHREE_MARUTI"
    LOGISTICSWORLDWIDEHK = "LOGISTICSWORLDWIDE_HK"
    EFEX = "EFEX"
    LOTTE = "LOTTE"
    LONESTAR = "LONESTAR"
    APRISAEXPRESS = "APRISAEXPRESS"
    BELRS = "BEL_RS"
    OSMWORLDWIDE = "OSM_WORLDWIDE"
    WESTGATEGL = "WESTGATE_GL"
    FASTRACK = "FASTRACK"
    DTDEXPR = "DTD_EXPR"
    ALFATREX = "ALFATREX"
    PROMEDDELIVERY = "PROMEDDELIVERY"
    THABITLOGISTICS = "THABIT_LOGISTICS"
    HCTLOGISTICS = "HCT_LOGISTICS"
    CARRYFLAP = "CARRY_FLAP"
    USOLDDOMINION = "US_OLD_DOMINION"
    ANICAMBOX = "ANICAM_BOX"
    WANBEXPRESS = "WANBEXPRESS"
    ANPOST = "AN_POST"
    DPDLOCAL = "DPD_LOCAL"
    STALLIONEXPRESS = "STALLIONEXPRESS"
    RAIDEREX = "RAIDEREX"
    SHOPFANS = "SHOPFANS"
    KYUNGDONGPARCEL = "KYUNGDONG_PARCEL"
    CHAMPIONLOGISTICS = "CHAMPION_LOGISTICS"
    PICKUPPSGP = "PICKUPP_SGP"
    MORNINGEXPRESS = "MORNING_EXPRESS"
    NACEX = "NACEX"
    THENILEWEBHOOK = "THENILE_WEBHOOK"
    HOLISOL = "HOLISOL"
    LBCEXPRESSFTP = "LBCEXPRESS_FTP"
    KURASI = "KURASI"
    USFREDDAWAY = "USF_REDDAWAY"
    APG = "APG"
    CNBOXC = "CN_BOXC"
    ECOSCOOTING = "ECOSCOOTING"
    MAINWAY = "MAINWAY"
    PAPERFLY = "PAPERFLY"
    HOUNDEXPRESS = "HOUNDEXPRESS"
    BOXBERRY = "BOX_BERRY"
    EPBOX = "EP_BOX"
    PLUSLOGUK = "PLUS_LOG_UK"
    FULFILLA = "FULFILLA"
    ASE = "ASE"
    MAILPLUS = "MAIL_PLUS"
    XPOLOGISTICS = "XPO_LOGISTICS"
    WNDIRECT = "WNDIRECT"
    CLOUDWISHASIA = "CLOUDWISH_ASIA"
    ZELERIS = "ZELERIS"
    GIOEXPRESS = "GIO_EXPRESS"
    OCSWORLDWIDE = "OCS_WORLDWIDE"
    ARKLOGISTICS = "ARK_LOGISTICS"
    AQUILINE = "AQUILINE"
    PILOTFREIGHT = "PILOT_FREIGHT"
    QWINTRY = "QWINTRY"
    DANSKEFRAGT = "DANSKE_FRAGT"
    CARRIERS = "CARRIERS"
    AIRCANADAGLOBAL = "AIR_CANADA_GLOBAL"
    PRESIDENTTRANS = "PRESIDENT_TRANS"
    STEPFORWARDFS = "STEPFORWARDFS"
    SKYNETUK = "SKYNET_UK"
    PITTOHIO = "PITTOHIO"
    CORREOSEXPRESS = "CORREOS_EXPRESS"
    RLUS = "RL_US"
    DESTINY = "DESTINY"
    UKYODEL = "UK_YODEL"
    COMETTECH = "COMET_TECH"
    DHLPARCELRU = "DHL_PARCEL_RU"
    TNTREFR = "TNT_REFR"
    SHREEANJANICOURIER = "SHREE_ANJANI_COURIER"
    MIKROPAKKETBE = "MIKROPAKKET_BE"
    ETSEXPRESS = "ETS_EXPRESS"
    COLISPRIVE = "COLIS_PRIVE"
    CNYUNDA = "CN_YUNDA"
    AAACOOPER = "AAA_COOPER"
    ROCKETPARCEL = "ROCKET_PARCEL"
    f360LION = "_360LION"
    PANDU = "PANDU"
    PROFESSIONALCOURIERS = "PROFESSIONAL_COURIERS"
    FLYTEXPRESS = "FLYTEXPRESS"
    LOGISTICSWORLDWIDEMY = "LOGISTICSWORLDWIDE_MY"
    CORREOSDEESPANA = "CORREOS_DE_ESPANA"
    IMX = "IMX"
    FOURPXEXPRESS = "FOUR_PX_EXPRESS"
    XPRESSBEES = "XPRESSBEES"
    PICKUPPVNM = "PICKUPP_VNM"
    FRCOLISSIMO = "FR_COLISSIMO"
    NACEXSPAINREFERENCE = "NACEX_SPAIN_REFERENCE"
    DHLSUPPLYCHAINAU = "DHL_SUPPLY_CHAIN_AU"
    ESHIPPING = "ESHIPPING"
    SHREETIRUPATI = "SHREETIRUPATI"
    HXEXPRESS = "HX_EXPRESS"
    INDOPAKET = "INDOPAKET"
    CN17POST = "CN_17POST"
    K1EXPRESS = "K1_EXPRESS"
    CJGLS = "CJ_GLS"
    MYSGDEX = "MYS_GDEX"
    NATIONEX = "NATIONEX"
    ANJUN = "ANJUN"
    FARGOOD = "FARGOOD"
    SMGEXPRESS = "SMG_EXPRESS"
    RZYEXPRESS = "RZYEXPRESS"
    SEFL = "SEFL"
    TNTCLICKIT = "TNT_CLICK_IT"
    HDB = "HDB"
    HIPSHIPPER = "HIPSHIPPER"
    RPXLOGISTICS = "RPXLOGISTICS"
    KUEHNE = "KUEHNE"
    ITNEXIVE = "IT_NEXIVE"
    PTS = "PTS"
    SWISSPOSTFTP = "SWISS_POST_FTP"
    FASTRKSERV = "FASTRK_SERV"
    f472 = "_4_72"
    USYRC = "US_YRC"
    POSTNLINTL3S = "POSTNL_INTL_3S"
    ELIANPOST = "ELIAN_POST"
    CUBYN = "CUBYN"
    SAUSAUDIPOST = "SAU_SAUDI_POST"
    ABXEXPRESSMY = "ABXEXPRESS_MY"
    HUAHANEXPRESS = "HUAHAN_EXPRESS"
    ZESEXPRESS = "ZES_EXPRESS"
    ZEPTOEXPRESS = "ZEPTO_EXPRESS"
    SKYNETZA = "SKYNET_ZA"
    ZEEK2DOOR = "ZEEK_2_DOOR"
    BLINKLASTMILE = "BLINKLASTMILE"
    POSTAUKR = "POSTA_UKR"
    CHROBINSON = "CHROBINSON"
    CNPOST56 = "CN_POST56"
    COURANTPLUS = "COURANT_PLUS"
    SCUDEXEXPRESS = "SCUDEX_EXPRESS"
    SHIPENTEGRA = "SHIPENTEGRA"
    BTWOCEUROPE = "B_TWO_C_EUROPE"
    COPE = "COPE"
    INDGATI = "IND_GATI"
    CNWISHPOST = "CN_WISHPOST"
    NACEXES = "NACEX_ES"
    TAQBINHK = "TAQBIN_HK"
    GLOBALTRANZ = "GLOBALTRANZ"
    HKD = "HKD"
    BJSHOMEDELIVERY = "BJSHOMEDELIVERY"
    OMNIVA = "OMNIVA"
    SUTTON = "SUTTON"
    PANTHERREFERENCE = "PANTHER_REFERENCE"
    SFCSERVICE = "SFCSERVICE"
    LTL = "LTL"
    PARKNPARCEL = "PARKNPARCEL"
    SPRINGGDS = "SPRING_GDS"
    ECEXPRESS = "ECEXPRESS"
    INTERPARCELAU = "INTERPARCEL_AU"
    AGILITY = "AGILITY"
    XLEXPRESS = "XL_EXPRESS"
    ADERONLINE = "ADERONLINE"
    DIRECTCOURIERS = "DIRECTCOURIERS"
    PLANZER = "PLANZER"
    SENDING = "SENDING"
    NINJAVANWB = "NINJAVAN_WB"
    NATIONWIDEMY = "NATIONWIDE_MY"
    SENDIT = "SENDIT"
    GBARROW = "GB_ARROW"
    INDGOJAVAS = "IND_GOJAVAS"
    KPOST = "KPOST"
    DHLFREIGHT = "DHL_FREIGHT"
    BLUECARE = "BLUECARE"
    JINDOUYUN = "JINDOUYUN"
    TRACKON = "TRACKON"
    GBTUFFNELLS = "GB_TUFFNELLS"
    TRUMPCARD = "TRUMPCARD"
    ETOTAL = "ETOTAL"
    SFPLUSWEBHOOK = "SFPLUS_WEBHOOK"
    SEKOLOGISTICS = "SEKOLOGISTICS"
    HERMES2MANNHANDLING = "HERMES_2MANN_HANDLING"
    DPDLOCALREF = "DPD_LOCAL_REF"
    UDS = "UDS"
    ZASPECIALISEDFREIGHT = "ZA_SPECIALISED_FREIGHT"
    THAKERRY = "THA_KERRY"
    PRTINTSEUR = "PRT_INT_SEUR"
    BRACORREIOS = "BRA_CORREIOS"
    NZNZPOST = "NZ_NZ_POST"
    CNEQUICK = "CN_EQUICK"
    MYSEMS = "MYS_EMS"
    GBNORSK = "GB_NORSK"
    ESPMRW = "ESP_MRW"
    ESPPACKLINK = "ESP_PACKLINK"
    KANGAROOMY = "KANGAROO_MY"
    RPX = "RPX"
    XDPUKREFERENCE = "XDP_UK_REFERENCE"
    NINJAVANMY = "NINJAVAN_MY"
    ADICIONAL = "ADICIONAL"
    ROADBULL = "ROADBULL"
    YAKIT = "YAKIT"
    MAILAMERICAS = "MAILAMERICAS"
    MIKROPAKKET = "MIKROPAKKET"
    DYNALOGIC = "DYNALOGIC"
    DHLES = "DHL_ES"
    DHLPARCELNL = "DHL_PARCEL_NL"
    DHLGLOBALMAILASIA = "DHL_GLOBAL_MAIL_ASIA"
    DAWNWING = "DAWN_WING"
    GENIKIGR = "GENIKI_GR"
    HERMESWORLDUK = "HERMESWORLD_UK"
    ALPHAFAST = "ALPHAFAST"
    BUYLOGIC = "BUYLOGIC"
    EKART = "EKART"
    MEXSENDA = "MEX_SENDA"
    SFCLOGISTICS = "SFC_LOGISTICS"
    POSTSERBIA = "POST_SERBIA"
    INDDELHIVERY = "IND_DELHIVERY"
    DEDPDDELISTRACK = "DE_DPD_DELISTRACK"
    RPD2MAN = "RPD2MAN"
    CNSFEXPRESS = "CN_SF_EXPRESS"
    YANWEN = "YANWEN"
    MYSSKYNET = "MYS_SKYNET"
    CORREOSDEMEXICO = "CORREOS_DE_MEXICO"
    CBLLOGISTICA = "CBL_LOGISTICA"
    MEXESTAFETA = "MEX_ESTAFETA"
    AUAUSTRIANPOST = "AU_AUSTRIAN_POST"
    RINCOS = "RINCOS"
    NLDDHL = "NLD_DHL"
    RUSSIANPOST = "RUSSIAN_POST"
    COURIERSPLEASE = "COURIERS_PLEASE"
    POSTNORDLOGISTICS = "POSTNORD_LOGISTICS"
    FEDEX = "FEDEX"
    DPEEXPRESS = "DPE_EXPRESS"
    DPD = "DPD"
    ADSONE = "ADSONE"
    IDNJNE = "IDN_JNE"
    THECOURIERGUY = "THECOURIERGUY"
    CNEXPS = "CNEXPS"
    PRTCHRONOPOST = "PRT_CHRONOPOST"
    LANDMARKGLOBAL = "LANDMARK_GLOBAL"
    ITDHLECOMMERCE = "IT_DHL_ECOMMERCE"
    ESPNACEX = "ESP_NACEX"
    PRTCTT = "PRT_CTT"
    BEKIALA = "BE_KIALA"
    ASENDIAUK = "ASENDIA_UK"
    GLOBALTNT = "GLOBAL_TNT"
    POSTURIS = "POSTUR_IS"
    EPARCELKR = "EPARCEL_KR"
    INPOSTPACZKOMATY = "INPOST_PACZKOMATY"
    ITPOSTEITALIA = "IT_POSTE_ITALIA"
    BEBPOST = "BE_BPOST"
    PLPOCZTAPOLSKA = "PL_POCZTA_POLSKA"
    MYSMYSPOST = "MYS_MYS_POST"
    SGSGPOST = "SG_SG_POST"
    THATHAILANDPOST = "THA_THAILAND_POST"
    LEXSHIP = "LEXSHIP"
    FASTWAYNZ = "FASTWAY_NZ"
    DHLAU = "DHL_AU"
    COSTMETICSNOW = "COSTMETICSNOW"
    PFLOGISTICS = "PFLOGISTICS"
    LOOMISEXPRESS = "LOOMIS_EXPRESS"
    GLSITALY = "GLS_ITALY"
    LINE = "LINE"
    GELEXPRESS = "GEL_EXPRESS"
    HUODULL = "HUODULL"
    NINJAVANSG = "NINJAVAN_SG"
    JANIO = "JANIO"
    AOCOURIER = "AO_COURIER"
    BRTITSENDERREF = "BRT_IT_SENDER_REF"
    SAILPOST = "SAILPOST"
    LALAMOVE = "LALAMOVE"
    NEWZEALANDCOURIERS = "NEWZEALAND_COURIERS"
    ETOMARS = "ETOMARS"
    VIRTRANSPORT = "VIRTRANSPORT"
    WIZMO = "WIZMO"
    PALLETWAYS = "PALLETWAYS"
    IDIKA = "I_DIKA"
    CFLLOGISTICS = "CFL_LOGISTICS"
    GEMWORLDWIDE = "GEMWORLDWIDE"
    GLOBALEXPRESS = "GLOBAL_EXPRESS"
    LOGISTYXTRANSGROUP = "LOGISTYX_TRANSGROUP"
    WESTBANKCOURIER = "WESTBANK_COURIER"
    ARCOSPEDIZIONI = "ARCO_SPEDIZIONI"
    YDHEXPRESS = "YDH_EXPRESS"
    PARCELINKLOGISTICS = "PARCELINKLOGISTICS"
    CNDEXPRESS = "CNDEXPRESS"
    NOXNIGHTTIMEEXPRESS = "NOX_NIGHT_TIME_EXPRESS"
    AERONET = "AERONET"
    LTIANEXP = "LTIANEXP"
    INTEGRA2FTP = "INTEGRA2_FTP"
    PARCELONE = "PARCELONE"
    NOXNACHTEXPRESS = "NOX_NACHTEXPRESS"
    CNCHINAPOSTEMS = "CN_CHINA_POST_EMS"
    CHUKOU1 = "CHUKOU1"
    GLSSLOV = "GLS_SLOV"
    ORANGEDS = "ORANGE_DS"
    JOOMLOGIS = "JOOM_LOGIS"
    AUSSTARTRACK = "AUS_STARTRACK"
    DHL = "DHL"
    GBAPC = "GB_APC"
    BONDSCOURIERS = "BONDSCOURIERS"
    JPNJAPANPOST = "JPN_JAPAN_POST"
    USPS = "USPS"
    WINIT = "WINIT"
    ARGOCA = "ARG_OCA"
    TWTAIWANPOST = "TW_TAIWAN_POST"
    DMMNETWORK = "DMM_NETWORK"
    TNT = "TNT"
    BHPOSTA = "BH_POSTA"
    SWEPOSTNORD = "SWE_POSTNORD"
    CACANADAPOST = "CA_CANADA_POST"
    WISELOADS = "WISELOADS"
    ASENDIAHK = "ASENDIA_HK"
    NLDGLS = "NLD_GLS"
    MEXREDPACK = "MEX_REDPACK"
    JETSHIP = "JET_SHIP"
    DEDHLEXPRESS = "DE_DHL_EXPRESS"
    NINJAVANTHAI = "NINJAVAN_THAI"
    RABENGROUP = "RABEN_GROUP"
    ESPASM = "ESP_ASM"
    HRVHRVATSKA = "HRV_HRVATSKA"
    GLOBALESTES = "GLOBAL_ESTES"
    LTULIETUVOS = "LTU_LIETUVOS"
    BELDHL = "BEL_DHL"
    AUAUPOST = "AU_AU_POST"
    SPEEDEXCOURIER = "SPEEDEXCOURIER"
    FRCOLIS = "FR_COLIS"
    ARAMEX = "ARAMEX"
    DPEX = "DPEX"
    MYSAIRPAK = "MYS_AIRPAK"
    CUCKOOEXPRESS = "CUCKOOEXPRESS"
    DPDPOLAND = "DPD_POLAND"
    NLDPOSTNL = "NLD_POSTNL"
    NIMEXPRESS = "NIM_EXPRESS"
    QUANTIUM = "QUANTIUM"
    SENDLE = "SENDLE"
    ESPREDUR = "ESP_REDUR"
    MATKAHUOLTO = "MATKAHUOLTO"
    CPACKET = "CPACKET"
    POSTI = "POSTI"
    HUNTEREXPRESS = "HUNTER_EXPRESS"
    CHOIREXP = "CHOIR_EXP"
    LEGIONEXPRESS = "LEGION_EXPRESS"
    AUSTRIANPOSTEXPRESS = "AUSTRIAN_POST_EXPRESS"
    GRUPO = "GRUPO"
    POSTARO = "POSTA_RO"
    INTERPARCELUK = "INTERPARCEL_UK"
    GLOBALABF = "GLOBAL_ABF"
    POSTENNORGE = "POSTEN_NORGE"
    XPERTDELIVERY = "XPERT_DELIVERY"
    DHLREFR = "DHL_REFR"
    DHLHK = "DHL_HK"
    SKYNETUAE = "SKYNET_UAE"
    GOJEK = "GOJEK"
    YODELINTNL = "YODEL_INTNL"
    JANCO = "JANCO"
    YTO = "YTO"
    WISEEXPRESS = "WISE_EXPRESS"
    JTEXPRESSVN = "JTEXPRESS_VN"
    FEDEXINTLMLSERV = "FEDEX_INTL_MLSERV"
    VAMOX = "VAMOX"
    AMSGRP = "AMS_GRP"
    DHLJP = "DHL_JP"
    HRPARCEL = "HRPARCEL"
    GESWL = "GESWL"
    BLUESTAR = "BLUESTAR"
    CDEKTR = "CDEK_TR"
    DESCARTES = "DESCARTES"
    DELTECUK = "DELTEC_UK"
    DTDCEXPRESS = "DTDC_EXPRESS"
    TOURLINE = "TOURLINE"
    BHWORLDWIDE = "BH_WORLDWIDE"
    OCS = "OCS"
    YINGNUOLOGISTICS = "YINGNUO_LOGISTICS"
    UPS = "UPS"
    TOLL = "TOLL"
    PRTSEUR = "PRT_SEUR"
    DTDCAU = "DTDC_AU"
    THADYNAMICLOGISTICS = "THA_DYNAMIC_LOGISTICS"
    UBILOGISTICS = "UBI_LOGISTICS"
    FEDEXCROSSBORDER = "FEDEX_CROSSBORDER"
    A1POST = "A1POST"
    TAZMANIANFREIGHT = "TAZMANIAN_FREIGHT"
    CJINTMY = "CJ_INT_MY"
    SAIAFREIGHT = "SAIA_FREIGHT"
    SGQXPRESS = "SG_QXPRESS"
    NHANSSOLUTIONS = "NHANS_SOLUTIONS"
    DPDFR = "DPD_FR"
    COORDINADORA = "COORDINADORA"
    ANDREANI = "ANDREANI"
    DOORA = "DOORA"
    INTERPARCELNZ = "INTERPARCEL_NZ"
    PHLJAMEXPRESS = "PHL_JAMEXPRESS"
    BELBELGIUMPOST = "BEL_BELGIUM_POST"
    USAPC = "US_APC"
    IDNPOS = "IDN_POS"
    FRMONDIAL = "FR_MONDIAL"
    DEDHL = "DE_DHL"
    HKRPX = "HK_RPX"
    DHLPIECEID = "DHL_PIECEID"
    VNPOSTEMS = "VNPOST_EMS"
    RRDONNELLEY = "RRDONNELLEY"
    DPDDE = "DPD_DE"
    DELCARTIN = "DELCART_IN"
    IMEXGLOBALSOLUTIONS = "IMEXGLOBALSOLUTIONS"
    ACOMMERCE = "ACOMMERCE"
    EURODIS = "EURODIS"
    CANPAR = "CANPAR"
    GLS = "GLS"
    INDECOM = "IND_ECOM"
    ESPENVIALIA = "ESP_ENVIALIA"
    DHLUK = "DHL_UK"
    SMSAEXPRESS = "SMSA_EXPRESS"
    TNTFR = "TNT_FR"
    DEXI = "DEX_I"
    BUDBEEWEBHOOK = "BUDBEE_WEBHOOK"
    COPACOURIER = "COPA_COURIER"
    VNMVIETNAMPOST = "VNM_VIETNAM_POST"
    DPDHK = "DPD_HK"
    TOLLNZ = "TOLL_NZ"
    ECHO = "ECHO"
    FEDEXFR = "FEDEX_FR"
    BORDEREXPRESS = "BORDEREXPRESS"
    MAILPLUSJPN = "MAILPLUS_JPN"
    TNTUKREFR = "TNT_UK_REFR"
    KEC = "KEC"
    DPDRO = "DPD_RO"
    TNTJP = "TNT_JP"
    THCJ = "TH_CJ"
    ECCN = "EC_CN"
    FASTWAYUK = "FASTWAY_UK"
    FASTWAYUS = "FASTWAY_US"
    GLSDE = "GLS_DE"
    GLSES = "GLS_ES"
    GLSFR = "GLS_FR"
    MONDIALBE = "MONDIAL_BE"
    SGTIT = "SGT_IT"
    TNTCN = "TNT_CN"
    TNTDE = "TNT_DE"
    TNTES = "TNT_ES"
    TNTPL = "TNT_PL"
    PARCELFORCE = "PARCELFORCE"
    SWISSPOST = "SWISS_POST"
    TOLLIPEC = "TOLL_IPEC"
    AIR21 = "AIR_21"
    AIRSPEED = "AIRSPEED"
    BERT = "BERT"
    BLUEDART = "BLUEDART"
    COLLECTPLUS = "COLLECTPLUS"
    COURIERPLUS = "COURIERPLUS"
    COURIERPOST = "COURIER_POST"
    DHLGLOBALMAIL = "DHL_GLOBAL_MAIL"
    DPDUK = "DPD_UK"
    DELTECDE = "DELTEC_DE"
    DEUTSCHEDE = "DEUTSCHE_DE"
    DOTZOT = "DOTZOT"
    ELTAGR = "ELTA_GR"
    EMSCN = "EMS_CN"
    ECARGO = "ECARGO"
    ENSENDA = "ENSENDA"
    FERCAMIT = "FERCAM_IT"
    FASTWAYZA = "FASTWAY_ZA"
    FASTWAYAU = "FASTWAY_AU"
    FIRSTLOGISITCS = "FIRST_LOGISITCS"
    GEODIS = "GEODIS"
    GLOBEGISTICS = "GLOBEGISTICS"
    GREYHOUND = "GREYHOUND"
    JETSHIPMY = "JETSHIP_MY"
    LIONPARCEL = "LION_PARCEL"
    AEROFLASH = "AEROFLASH"
    ONTRAC = "ONTRAC"
    SAGAWA = "SAGAWA"
    SIODEMKA = "SIODEMKA"
    STARTRACK = "STARTRACK"
    TNTAU = "TNT_AU"
    TNTIT = "TNT_IT"
    TRANSMISSION = "TRANSMISSION"
    YAMATO = "YAMATO"
    DHLIT = "DHL_IT"
    DHLAT = "DHL_AT"
    LOGISTICSWORLDWIDEKR = "LOGISTICSWORLDWIDE_KR"
    GLSSPAIN = "GLS_SPAIN"
    AMAZONUKAPI = "AMAZON_UK_API"
    DPDFRREFERENCE = "DPD_FR_REFERENCE"
    DHLPARCELUK = "DHLPARCEL_UK"
    MEGASAVE = "MEGASAVE"
    QUALITYPOST = "QUALITYPOST"
    IDSLOGISTICS = "IDS_LOGISTICS"
    PANTHERORDERNUMBER = "PANTHER_ORDER_NUMBER"
    WATKINSSHEPARD = "WATKINS_SHEPARD"
    FASTTRACK = "FASTTRACK"
    UPEXPRESS = "UP_EXPRESS"
    ELOGISTICA = "ELOGISTICA"
    ECOURIER = "ECOURIER"
    CJPHILIPPINES = "CJ_PHILIPPINES"
    SPEEDEX = "SPEEDEX"
    ORANGECONNEX = "ORANGECONNEX"
    TECOR = "TECOR"
    SAEE = "SAEE"
    GLSITALYFTP = "GLS_ITALY_FTP"
    DELIVERE = "DELIVERE"
    YYCOM = "YYCOM"
    ADICIONALPT = "ADICIONAL_PT"
    DKSH = "DKSH"
    NIPPONEXPRESSFTP = "NIPPON_EXPRESS_FTP"
    GOLS = "GOLS"
    FUJEXP = "FUJEXP"
    QTRACK = "QTRACK"
    OMLOGISTICSAPI = "OMLOGISTICS_API"
    GDPHARM = "GDPHARM"
    MISUMICN = "MISUMI_CN"
    AIRCANADA = "AIR_CANADA"
    CITY56WEBHOOK = "CITY56_WEBHOOK"
    SAGAWAAPI = "SAGAWA_API"
    KEDAEX = "KEDAEX"
    PGEONAPI = "PGEON_API"
    WEWORLDEXPRESS = "WEWORLDEXPRESS"
    JTLOGISTICS = "JT_LOGISTICS"
    TRUSK = "TRUSK"
    VIAXPRESS = "VIAXPRESS"
    DHLSUPPLYCHAINID = "DHL_SUPPLYCHAIN_ID"
    ZUELLIGPHARMASFTP = "ZUELLIGPHARMA_SFTP"
    MEEST = "MEEST"
    TOLLPRIORITY = "TOLL_PRIORITY"
    MOTHERSHIPAPI = "MOTHERSHIP_API"
    CAPITAL = "CAPITAL"
    EUROPAKETAPI = "EUROPAKET_API"
    HFD = "HFD"
    TOURLINEREFERENCE = "TOURLINE_REFERENCE"
    GIOECOURIER = "GIO_ECOURIER"
    CNLOGISTICS = "CN_LOGISTICS"
    PANDION = "PANDION"
    BPOSTAPI = "BPOST_API"
    PASSPORTSHIPPING = "PASSPORTSHIPPING"
    PAKAJO = "PAKAJO"
    DACHSER = "DACHSER"
    YUSENSFTP = "YUSEN_SFTP"
    SHYPLITE = "SHYPLITE"
    XYY = "XYY"
    MWD = "MWD"
    FAXECARGO = "FAXECARGO"
    MAZET = "MAZET"
    FIRSTLOGISTICSAPI = "FIRST_LOGISTICS_API"
    SPRINTPACK = "SPRINT_PACK"
    HERMESDEFTP = "HERMES_DE_FTP"
    CONCISE = "CONCISE"
    KERRYEXPRESSTWAPI = "KERRY_EXPRESS_TW_API"
    EWE = "EWE"
    FASTDESPATCH = "FASTDESPATCH"
    ABCUSTOMSFTP = "ABCUSTOM_SFTP"
    CHAZKI = "CHAZKI"
    SHIPPIE = "SHIPPIE"
    GEODISAPI = "GEODIS_API"
    NAQELEXPRESS = "NAQEL_EXPRESS"
    PAPAWEBHOOK = "PAPA_WEBHOOK"
    FORWARDAIR = "FORWARDAIR"
    DIALOGOLOGISTICAAPI = "DIALOGO_LOGISTICA_API"
    LALAMOVEAPI = "LALAMOVE_API"
    TOMYDOOR = "TOMYDOOR"
    KRONOSWEBHOOK = "KRONOS_WEBHOOK"
    JTCARGO = "JTCARGO"
    TCAT = "T_CAT"
    CONCISEWEBHOOK = "CONCISE_WEBHOOK"
    TELEPORTWEBHOOK = "TELEPORT_WEBHOOK"
    CUSTOMCOAPI = "CUSTOMCO_API"
    SPXTH = "SPX_TH"
    BOLLORELOGISTICS = "BOLLORE_LOGISTICS"
    CLICKLINKSFTP = "CLICKLINK_SFTP"
    M3LOGISTICS = "M3LOGISTICS"
    VNPOSTAPI = "VNPOST_API"
    AXLEHIREFTP = "AXLEHIRE_FTP"
    SHADOWFAX = "SHADOWFAX"
    MYHERMESUKAPI = "MYHERMES_UK_API"
    DAIICHI = "DAIICHI"
    MENSAJEROSURBANOSAPI = "MENSAJEROSURBANOS_API"
    POLARSPEED = "POLARSPEED"
    IDEXPRESSID = "IDEXPRESS_ID"
    PAYO = "PAYO"
    WHISTLSFTP = "WHISTL_SFTP"
    INTEXDE = "INTEX_DE"
    TRANS2U = "TRANS2U"
    PRODUCTCAREGROUPSFTP = "PRODUCTCAREGROUP_SFTP"
    BIGSMART = "BIGSMART"
    EXPEDITORSAPIREF = "EXPEDITORS_API_REF"
    AITWORLDWIDEAPI = "AITWORLDWIDE_API"
    WORLDCOURIER = "WORLDCOURIER"
    QUIQUP = "QUIQUP"
    AGEDISSSFTP = "AGEDISS_SFTP"
    ANDREANIAPI = "ANDREANI_API"
    CRLEXPRESS = "CRLEXPRESS"
    SMARTCAT = "SMARTCAT"
    CROSSFLIGHT = "CROSSFLIGHT"
    PROCARRIER = "PROCARRIER"
    DHLREFERENCEAPI = "DHL_REFERENCE_API"
    SEINOAPI = "SEINO_API"
    WSPEXPRESS = "WSPEXPRESS"
    KRONOS = "KRONOS"
    TOTALEXPRESSAPI = "TOTAL_EXPRESS_API"
    PARCLL = "PARCLL"
    XPEDIGO = "XPEDIGO"
    STARTRACKWEBHOOK = "STAR_TRACK_WEBHOOK"
    GPOST = "GPOST"
    UCS = "UCS"
    DMFGROUP = "DMFGROUP"
    COORDINADORAAPI = "COORDINADORA_API"
    MARKEN = "MARKEN"
    NTL = "NTL"
    REDJEPAKKETJE = "REDJEPAKKETJE"
    ALLIEDEXPRESSFTP = "ALLIED_EXPRESS_FTP"
    MONDIALRELAYES = "MONDIALRELAY_ES"
    NAEKOFTP = "NAEKO_FTP"
    MHI = "MHI"
    SHIPPIFY = "SHIPPIFY"
    MALCAAMITAPI = "MALCA_AMIT_API"
    JTEXPRESSSGAPI = "JTEXPRESS_SG_API"
    DACHSERWEB = "DACHSER_WEB"
    FLIGHTLG = "FLIGHTLG"
    CAGO = "CAGO"
    COM1EXPRESS = "COM1EXPRESS"
    TONAMIFTP = "TONAMI_FTP"
    PACKFLEET = "PACKFLEET"
    PUROLATORINTERNATIONAL = "PUROLATOR_INTERNATIONAL"
    WINESHIPPINGWEBHOOK = "WINESHIPPING_WEBHOOK"
    DHLESSFTP = "DHL_ES_SFTP"
    PCHOMEAPI = "PCHOME_API"
    CESKAPOSTAAPI = "CESKAPOSTA_API"
    GORUSH = "GORUSH"
    HOMERUNNER = "HOMERUNNER"
    AMAZONORDER = "AMAZON_ORDER"
    EFWNOWAPI = "EFWNOW_API"
    CBLLOGISTICAAPI = "CBL_LOGISTICA_API"
    NIMBUSPOST = "NIMBUSPOST"
    LOGWINLOGISTICS = "LOGWIN_LOGISTICS"
    NOWLOGAPI = "NOWLOG_API"
    DPDNL = "DPD_NL"
    GODEPENDABLE = "GODEPENDABLE"
    ESDEX = "ESDEX"
    LOGISYSTEMSSFTP = "LOGISYSTEMS_SFTP"
    EXPEDITORS = "EXPEDITORS"
    SNTGLOBALAPI = "SNTGLOBAL_API"
    SHIPX = "SHIPX"
    QINTLAPI = "QINTL_API"
    PACKS = "PACKS"
    POSTNLINTERNATIONAL = "POSTNL_INTERNATIONAL"
    AMAZONEMAILPUSH = "AMAZON_EMAIL_PUSH"
    DHLAPI = "DHL_API"
    SPX = "SPX"
    AXLEHIRE = "AXLEHIRE"
    ICSCOURIER = "ICSCOURIER"
    DIALOGOLOGISTICA = "DIALOGO_LOGISTICA"
    SHUNBANGEXPRESS = "SHUNBANG_EXPRESS"
    TCSAPI = "TCS_API"
    SFEXPRESSCN = "SF_EXPRESS_CN"
    PACKETA = "PACKETA"
    SICTELIWAY = "SIC_TELIWAY"
    MONDIALRELAYFR = "MONDIALRELAY_FR"
    INTIMEFTP = "INTIME_FTP"
    JDEXPRESS = "JD_EXPRESS"
    FASTBOX = "FASTBOX"
    PATHEON = "PATHEON"
    INDIAPOST = "INDIA_POST"
    TIPSAREF = "TIPSA_REF"
    ECOFREIGHT = "ECOFREIGHT"
    VOX = "VOX"
    DIRECTFREIGHTAUREF = "DIRECTFREIGHT_AU_REF"
    BESTTRANSPORTSFTP = "BESTTRANSPORT_SFTP"
    AUSTRALIAPOSTAPI = "AUSTRALIA_POST_API"
    FRAGILEPAKSFTP = "FRAGILEPAK_SFTP"
    FLIPXP = "FLIPXP"
    VALUEWEBHOOK = "VALUE_WEBHOOK"
    DAESHIN = "DAESHIN"
    SHERPA = "SHERPA"
    MWDAPI = "MWD_API"
    SMARTKARGO = "SMARTKARGO"
    DNJEXPRESS = "DNJ_EXPRESS"
    GOPEOPLE = "GOPEOPLE"
    MYSENDLEAPI = "MYSENDLE_API"
    ARAMEXAPI = "ARAMEX_API"
    PIDGE = "PIDGE"
    THAIPARCELS = "THAIPARCELS"
    PANTHERREFERENCEAPI = "PANTHER_REFERENCE_API"
    BUFFALO = "BUFFALO"
    UENVIOS = "U_ENVIOS"
    ELITECO = "ELITE_CO"
    ROCHEINTERNALSFTP = "ROCHE_INTERNAL_SFTP"
    DBSCHENKERICELAND = "DBSCHENKER_ICELAND"
    TNTFRREFERENCE = "TNT_FR_REFERENCE"
    NEWGISTICSAPI = "NEWGISTICSAPI"
    GLOVO = "GLOVO"
    GWLOGISAPI = "GWLOGIS_API"
    SPREETAILAPI = "SPREETAIL_API"
    MOOVA = "MOOVA"
    PLYCONGROUP = "PLYCONGROUP"
    USPSWEBHOOK = "USPS_WEBHOOK"
    REIMAGINEDELIVERY = "REIMAGINEDELIVERY"
    EDFFTP = "EDF_FTP"
    DAO365 = "DAO365"
    BIOCAIRFTP = "BIOCAIR_FTP"
    RANSAWEBHOOK = "RANSA_WEBHOOK"
    SHIPXPRES = "SHIPXPRES"
    COURANTPLUSAPI = "COURANT_PLUS_API"
    SHIPA = "SHIPA"
    HOMELOGISTICS = "HOMELOGISTICS"
    DX = "DX"
    POSTEITALIANEPACCOCELERE = "POSTE_ITALIANE_PACCOCELERE"
    TOLLWEBHOOK = "TOLL_WEBHOOK"
    LCTBRAPI = "LCTBR_API"
    DXFREIGHT = "DX_FREIGHT"
    DHLSFTP = "DHL_SFTP"
    SHIPROCKET = "SHIPROCKET"
    UBERWEBHOOK = "UBER_WEBHOOK"
    STATOVERNIGHT = "STATOVERNIGHT"
    BURD = "BURD"
    FASTSHIP = "FASTSHIP"
    IBVENTUREWEBHOOK = "IBVENTURE_WEBHOOK"
    GATIKWEAPI = "GATI_KWE_API"
    CRYOPDPFTP = "CRYOPDP_FTP"
    HUBBED = "HUBBED"
    TIPSAAPI = "TIPSA_API"
    ARASKARGO = "ARASKARGO"
    THIJSNL = "THIJS_NL"
    ATSHEALTHCAREREFERENCE = "ATSHEALTHCARE_REFERENCE"
    f99MINUTOS = "99MINUTOS"
    HELLENICPOST = "HELLENIC_POST"
    HSMGLOBAL = "HSM_GLOBAL"
    MNX = "MNX"
    NMTRANSFER = "NMTRANSFER"
    LOGYSTO = "LOGYSTO"
    INDIAPOSTINT = "INDIA_POST_INT"
    AMAZONFBASWISHIPIN = "AMAZON_FBA_SWISHIP_IN"
    SRTTRANSPORT = "SRT_TRANSPORT"
    BOMI = "BOMI"
    DELIVERRSFTP = "DELIVERR_SFTP"
    HSDEXPRESS = "HSDEXPRESS"
    SIMPLETIREWEBHOOK = "SIMPLETIRE_WEBHOOK"
    HUNTEREXPRESSSFTP = "HUNTER_EXPRESS_SFTP"
    UPSAPI = "UPS_API"
    WOOYOUNGLOGISTICSSFTP = "WOOYOUNG_LOGISTICS_SFTP"
    PHSEAPI = "PHSE_API"
    WISHEMAILPUSH = "WISH_EMAIL_PUSH"
    NORTHLINE = "NORTHLINE"
    MEDAFRICA = "MEDAFRICA"
    DPDATSFTP = "DPD_AT_SFTP"
    ANTERAJA = "ANTERAJA"
    DHLGLOBALFORWARDINGAPI = "DHL_GLOBAL_FORWARDING_API"
    LBCEXPRESSAPI = "LBCEXPRESS_API"
    SIMSGLOBAL = "SIMSGLOBAL"
    CDLDELIVERS = "CDLDELIVERS"
    TYP = "TYP"
    TESTINGCOURIERWEBHOOK = "TESTING_COURIER_WEBHOOK"
    PANDAGOAPI = "PANDAGO_API"
    ROYALMAILFTP = "ROYAL_MAIL_FTP"
    THUNDEREXPRESS = "THUNDEREXPRESS"
    SECRETLABWEBHOOK = "SECRETLAB_WEBHOOK"
    SETEL = "SETEL"
    JDWORLDWIDE = "JD_WORLDWIDE"
    DPDRUAPI = "DPD_RU_API"
    ARGENTSWEBHOOK = "ARGENTS_WEBHOOK"
    POSTONE = "POSTONE"
    TUSKLOGISTICS = "TUSKLOGISTICS"
    RHENUSUKAPI = "RHENUS_UK_API"
    TAQBINSGAPI = "TAQBIN_SG_API"
    INNTRALOGSFTP = "INNTRALOG_SFTP"
    DAYROSS = "DAYROSS"
    CORREOSEXPRESSAPI = "CORREOSEXPRESS_API"
    INTERNATIONALSEURAPI = "INTERNATIONAL_SEUR_API"
    YODELAPI = "YODEL_API"
    HEROEXPRESS = "HEROEXPRESS"
    DHLSUPPLYCHAININ = "DHL_SUPPLYCHAIN_IN"
    URGENTCARGUS = "URGENT_CARGUS"
    FRONTDOORCORP = "FRONTDOORCORP"
    JTEXPRESSPH = "JTEXPRESS_PH"
    PARCELSTARSWEBHOOK = "PARCELSTARS_WEBHOOK"
    DPDSKSFTP = "DPD_SK_SFTP"
    MOVIANTO = "MOVIANTO"
    OZEPARTSSHIPPING = "OZEPARTS_SHIPPING"
    KARGOMKOLAY = "KARGOMKOLAY"
    TRUNKRS = "TRUNKRS"
    OMNIRPSWEBHOOK = "OMNIRPS_WEBHOOK"
    CHILEXPRESS = "CHILEXPRESS"
    TESTINGCOURIER = "TESTING_COURIER"
    JNEAPI = "JNE_API"
    BJSHOMEDELIVERYFTP = "BJSHOMEDELIVERY_FTP"
    DEXPRESSWEBHOOK = "DEXPRESS_WEBHOOK"
    USPSAPI = "USPS_API"
    TRANSVIRTUAL = "TRANSVIRTUAL"
    SOLISTICAAPI = "SOLISTICA_API"
    CHIENVENTUREWEBHOOK = "CHIENVENTURE_WEBHOOK"
    DPDUKSFTP = "DPD_UK_SFTP"
    INPOSTUK = "INPOST_UK"
    JAVIT = "JAVIT"
    ZTODOMESTIC = "ZTO_DOMESTIC"
    DHLGTAPI = "DHL_GT_API"
    CEVATRACKING = "CEVA_TRACKING"
    KOMONEXPRESS = "KOMON_EXPRESS"
    EASTWESTCOURIERFTP = "EASTWESTCOURIER_FTP"
    DANNIAO = "DANNIAO"
    SPECTRAN = "SPECTRAN"
    DELIVERIT = "DELIVER_IT"
    RELAISCOLIS = "RELAISCOLIS"
    GLSSPAINAPI = "GLS_SPAIN_API"
    POSTPLUS = "POSTPLUS"
    AIRTERRA = "AIRTERRA"
    GIOECOURIERAPI = "GIO_ECOURIER_API"
    DPDCHSFTP = "DPD_CH_SFTP"
    FEDEXAPI = "FEDEX_API"
    INTERSMARTTRANS = "INTERSMARTTRANS"
    HERMESUKSFTP = "HERMES_UK_SFTP"
    EXELOTFTP = "EXELOT_FTP"
    DHLPAAPI = "DHL_PA_API"
    VIRTRANSPORTSFTP = "VIRTRANSPORT_SFTP"
    WORLDNET = "WORLDNET"
    INSTABOXWEBHOOK = "INSTABOX_WEBHOOK"
    KNG = "KNG"
    FLASHEXPRESSWEBHOOK = "FLASHEXPRESS_WEBHOOK"
    MAGYARPOSTAAPI = "MAGYAR_POSTA_API"
    WESHIPAPI = "WESHIP_API"
    OHIWEBHOOK = "OHI_WEBHOOK"
    MUDITA = "MUDITA"
    BLUEDARTAPI = "BLUEDART_API"
    TCATAPI = "T_CAT_API"
    ADS = "ADS"
    HERMESIT = "HERMES_IT"
    FITZMARKAPI = "FITZMARK_API"
    POSTIAPI = "POSTI_API"
    SMSAEXPRESSWEBHOOK = "SMSA_EXPRESS_WEBHOOK"
    TAMERGROUPWEBHOOK = "TAMERGROUP_WEBHOOK"
    LIVRAPIDE = "LIVRAPIDE"
    NIPPONEXPRESS = "NIPPON_EXPRESS"
    BETTERTRUCKS = "BETTERTRUCKS"
    FAN = "FAN"
    PBUSPSFLATSFTP = "PB_USPSFLATS_FTP"
    PARCELRIGHT = "PARCELRIGHT"
    ITHINKLOGISTICS = "ITHINKLOGISTICS"
    KERRYEXPRESSTHWEBHOOK = "KERRY_EXPRESS_TH_WEBHOOK"
    ECOUTIER = "ECOUTIER"
    SHOWL = "SHOWL"
    BRTITAPI = "BRT_IT_API"
    RIXONHKAPI = "RIXONHK_API"
    DBSCHENKERAPI = "DBSCHENKER_API"
    ILYANGLOGIS = "ILYANGLOGIS"
    MAILBOXETC = "MAIL_BOX_ETC"
    WESHIP = "WESHIP"
    DHLGLOBALMAILAPI = "DHL_GLOBAL_MAIL_API"
    ACTIVOS24API = "ACTIVOS24_API"
    ATSHEALTHCARE = "ATSHEALTHCARE"
    LUWJISTIK = "LUWJISTIK"
    GWWORLD = "GW_WORLD"
    FAIRSENDENAPI = "FAIRSENDEN_API"
    SERVIPWEBHOOK = "SERVIP_WEBHOOK"
    SWISHIP = "SWISHIP"
    TANET = "TANET"
    HOTSINCARGO = "HOTSIN_CARGO"
    DIREX = "DIREX"
    HUANTONG = "HUANTONG"
    IMILEAPI = "IMILE_API"
    AUEXPRESS = "AUEXPRESS"
    NYTLOGISTICS = "NYTLOGISTICS"
    DSVREFERENCE = "DSV_REFERENCE"
    NOVOFARMAWEBHOOK = "NOVOFARMA_WEBHOOK"
    AITWORLDWIDESFTP = "AITWORLDWIDE_SFTP"
    SHOPOLIVE = "SHOPOLIVE"
    FNFZA = "FNF_ZA"
    DHLECOMMERCEGC = "DHL_ECOMMERCE_GC"
    FETCHR = "FETCHR"
    STARLINKSAPI = "STARLINKS_API"
    YYEXPRESS = "YYEXPRESS"
    SERVIENTREGA = "SERVIENTREGA"
    HANJIN = "HANJIN"
    SPANISHSEURFTP = "SPANISH_SEUR_FTP"
    DXB2BCONNUM = "DX_B2B_CONNUM"
    HELTHJEMAPI = "HELTHJEM_API"
    INEXPOST = "INEXPOST"
    A2BBA = "A2B_BA"
    RHENUSGROUP = "RHENUS_GROUP"
    SBERLOGISTICSRU = "SBERLOGISTICS_RU"
    MALCAAMIT = "MALCA_AMIT"
    PPL = "PPL"
    OSMWORLDWIDESFTP = "OSM_WORLDWIDE_SFTP"
    ACILOGISTIX = "ACILOGISTIX"
    OPTIMACOURIER = "OPTIMACOURIER"
    NOVAPOSHTAAPI = "NOVA_POSHTA_API"
    LOGGI = "LOGGI"
    YIFAN = "YIFAN"
    MYDYNALOGIC = "MYDYNALOGIC"
    MORNINGLOBAL = "MORNINGLOBAL"
    CONCISEAPI = "CONCISE_API"
    FXTRAN = "FXTRAN"
    DELIVERYOURPARCELZA = "DELIVERYOURPARCEL_ZA"
    UPARCEL = "UPARCEL"
    MOBIBR = "MOBI_BR"
    LOGINEXTWEBHOOK = "LOGINEXT_WEBHOOK"
    EMS = "EMS"
    SPEEDY = "SPEEDY"
    ZOOMRED = "ZOOM_RED"
    NAVLUNGO = "NAVLUNGO"
    CASTLEPARCELS = "CASTLEPARCELS"
    WEEE = "WEEE"
    PACKALY = "PACKALY"
    YUNHUIPOST = "YUNHUIPOST"
    YOUPARCEL = "YOUPARCEL"
    LEMAN = "LEMAN"
    MOOVIN = "MOOVIN"
    URBIT = "URB_IT"
    MULTIENTREGAPANAMA = "MULTIENTREGAPANAMA"
    JUSDASR = "JUSDASR"
    DISCOUNTPOST = "DISCOUNTPOST"
    RHENUSUK = "RHENUS_UK"
    SWISHIPJP = "SWISHIP_JP"
    GLSUS = "GLS_US"
    SMTL = "SMTL"
    EMEGA = "EMEGA"
    EXPRESSONESV = "EXPRESSONE_SV"
    HEPSIJET = "HEPSIJET"
    WELIVERY = "WELIVERY"
    BRINGER = "BRINGER"
    EASYROUTES = "EASYROUTES"
    MRW = "MRW"
    RPM = "RPM"
    DPDPRT = "DPD_PRT"
    GLSROMANIA = "GLS_ROMANIA"
    LMPARCEL = "LMPARCEL"
    GTAGSM = "GTAGSM"
    DOMINO = "DOMINO"
    ESHIPPER = "ESHIPPER"
    TRANSPAK = "TRANSPAK"
    XINDUS = "XINDUS"
    AOYUE = "AOYUE"
    EASYPARCEL = "EASYPARCEL"
    EXPRESSONE = "EXPRESSONE"
    SENDEOKARGO = "SENDEO_KARGO"
    SPEEDAF = "SPEEDAF"
    ETOWER = "ETOWER"
    GCX = "GCX"
    NINJAVANVN = "NINJAVAN_VN"
    ALLEGRO = "ALLEGRO"
    JUMPPOINT = "JUMPPOINT"
    SHIPGLOBALUS = "SHIPGLOBAL_US"
    KINISI = "KINISI"
    OAKH = "OAKH"
    AWEST = "AWEST"
    BARSAN = "BARSAN"
    ENERGOLOGISTIC = "ENERGOLOGISTIC"
    MADROOEX = "MADROOEX"
    GOBOLT = "GOBOLT"
    SWISSUNIVERSALEXPRESS = "SWISS_UNIVERSAL_EXPRESS"
    IORDIRECT = "IORDIRECT"
    XMSZM = "XMSZM"
    GLSHUN = "GLS_HUN"
    SENDY = "SENDY"
    BRAUNSEXPRESS = "BRAUNSEXPRESS"
    GRANDSLAMEXPRESS = "GRANDSLAMEXPRESS"
    XGS = "XGS"
    OTSCHILE = "OTSCHILE"
    PACKUP = "PACK_UP"
    PARCELSTARS = "PARCELSTARS"
    TEAMEXPRESSLLC = "TEAMEXPRESSLLC"
    ASYADEXPRESS = "ASYADEXPRESS"
    TDN = "TDN"
    EARLYBIRD = "EARLYBIRD"
    CACESA = "CACESA"
    PARCELJET = "PARCELJET"
    MNGKARGO = "MNG_KARGO"
    SUPERPACKLINE = "SUPERPACKLINE"
    SPEEDX = "SPEEDX"
    VESYL = "VESYL"
    SKYKING = "SKYKING"
    DIRMENSAJERIA = "DIRMENSAJERIA"
    NETLOGIXGROUP = "NETLOGIXGROUP"
    ZYOU = "ZYOU"
    JAWAR = "JAWAR"
    AGSYSTEMS = "AGSYSTEMS"
    GPS = "GPS"
    PTTKARGO = "PTT_KARGO"
    MAERGO = "MAERGO"
    ARIHANTCOURIER = "ARIHANTCOURIER"
    VTFE = "VTFE"
    YUNANT = "YUNANT"
    URBIFY = "URBIFY"
    PACKMAN = "PACK_MAN"
    LIEFERGRUN = "LIEFERGRUN"
    OBIBOX = "OBIBOX"
    PAIKEDA = "PAIKEDA"
    SCOTTY = "SCOTTY"
    INTELCOMCA = "INTELCOM_CA"
    SWE = "SWE"
    ASENDIA = "ASENDIA"
    DPDAT = "DPD_AT"
    RELAY = "RELAY"
    ATA = "ATA"
    SKYEXPRESSINTERNATIONAL = "SKYEXPRESS_INTERNATIONAL"
    SURATKARGO = "SURAT_KARGO"
    SGLINK = "SGLINK"
    FLEETOPTICSINC = "FLEETOPTICSINC"
    SHOPLINE = "SHOPLINE"
    PIGGYSHIP = "PIGGYSHIP"
    LOGOIX = "LOGOIX"
    KOLAYGELSIN = "KOLAY_GELSIN"
    ASSOCIATEDCOURIERS = "ASSOCIATED_COURIERS"
    UPSCHECKER = "UPS_CHECKER"
    WINESHIPPING = "WINESHIPPING"
    SPEDISCI = "SPEDISCI"
    FOURKITES = "FOURKITES"
    ETONAS = "ETONAS"
    FINMILE = "FINMILE"
    UNIUNI = "UNIUNI"
    RODONAVES = "RODONAVES"
    INPOSTIT = "INPOST_IT"
    TFORCEFREIGHT = "TFORCE_FREIGHT"
    RICHMOM = "RICHMOM"
    FRANCO = "FRANCO"
    ECPARCEL = "ECPARCEL"
    FEDEXCHINA = "FEDEX_CHINA"
    GOFOEXPRESS = "GOFO_EXPRESS"
    SHIPBOB = "SHIPBOB"
    JERSEYPOSTATLAS = "JERSEYPOST_ATLAS"
    CORETRAILS = "CORETRAILS"
    RHENUSITALY = "RHENUS_ITALY"
    JADLOG = "JADLOG"
    JITSU = "JITSU"
    YANWENEXPRESS = "YANWEN_EXPRESS"
    DASHLINK = "DASHLINK"
    SEINOSUPEREXPRESS = "SEINO_SUPER_EXPRESS"
    FLOSHIP = "FLOSHIP"
    METROSCG = "METROSCG"
    SENDPARCEL = "SENDPARCEL"
    P2P = "P2P"
    CNEXPRESS = "CN_EXPRESS"
    CIRROTRACK = "CIRROTRACK"
    LANDLOGISTICS = "LAND_LOGISTICS"
    VEHO = "VEHO"
    MEDLINE = "MEDLINE"
    VDTRACK = "VDTRACK"
    SINOSCM = "SINO_SCM"
    f3PEEXPRESS = "3PE_EXPRESS"
    SWIFTX = "SWIFTX"
    SFYDEXPRESS = "SFYDEXPRESS"
    TOPTRANS = "TOPTRANS"
    OTHER2 = "OTHER"

  ShipmentTracker* = ref object of RootObj
    ## The tracking information for a shipment.
    tracking_number*: string
      ## The tracking number for the shipment. This property supports Unicode.
    carrier*: ShipmentCarrier
    carrier_name_other*: Option[string]
      ## The name of the carrier for the shipment. Provide this value only if the carrier
      ## parameter is OTHER. This property supports Unicode.

  OrderTrackerRequest* = ref object of RootObj
    ## The tracking details of an order.
    tracking_number*: string
      ## The tracking number for the shipment. This property supports Unicode.
    carrier*: ShipmentCarrier
    carrier_name_other*: Option[string]
      ## The name of the carrier for the shipment. Provide this value only if the carrier
      ## parameter is OTHER. This property supports Unicode.
    capture_id*: string
      ## The PayPal capture ID.
    notify_payer*: Option[bool]
      ## If true, PayPal will send an email notification to the payer of the PayPal
      ## transaction. The email contains the tracking details provided through the Orders
      ## tracking API request. Independent of any value passed for `notify_payer`, the
      ## payer may receive tracking notifications within the PayPal app, based on the
      ## user's notification preferences.
    items*: Option[seq[JsonNode]]
      ## An array of details of items in the shipment.

  OrderUpdateCallbackRequest* = ref object of RootObj
    ## Shipping Options Callback request. This will be implemented by the merchants.
    id*: Option[string]
      ## The ID of the order.
    shipping_address*: Option[JsonNode]
    shipping_option*: Option[JsonNode]
    purchase_units*: seq[JsonNode]
      ## An array of purchase units. At present only 1 purchase_unit is supported. Each
      ## purchase unit establishes a contract between a payer and the payee. Each
      ## purchase unit represents either a full or partial order that the payer intends
      ## to purchase from the payee.

  OrderUpdateCallbackResponse* = ref object of RootObj
    ## Returns the updated shipping options for an order.
    id*: Option[string]
      ## The ID of the order.

  OrderUpdateCallbackErrorResponseDetails* = ref object of RootObj
    ## The error details. Required for client-side `4XX` errors.
    field*: Option[string]
      ## The field that caused the error. If this field is in the body, set this value to
      ## the field's JSON pointer value. Required for client-side errors.
    value*: Option[string]
      ## The value of the field that caused the error.
    issue*: string
      ## The unique, fine-grained application-level error code.

  OrderUpdateCallbackErrorResponse* = ref object of RootObj
    ## The error details.
    name*: string
      ## The human-readable, unique name of the error.
    message*: Option[string]
      ## The message that describes the error.
    details*: Option[seq[OrderUpdateCallbackErrorResponseDetails]]
      ## An array of additional details about the error.
