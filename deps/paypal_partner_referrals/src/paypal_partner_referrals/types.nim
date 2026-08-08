import std/[options, json]

type
  Status400* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  Status401* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  Status403* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  Status422* = ref object of RootObj
    details*: Option[seq[JsonNode]]

  Account* = ref object of RootObj
    ## Common account object to hold the account related details of the customer.
    individual_owners*: Option[IndividualOwnerList]
    business_entity*: Option[BusinessEntity]

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
      ## sub-premise. Usually a single building within a collection of buildings with a
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

  Bank* = ref object of RootObj
    ## The bank account information.
    nick_name*: Option[string]
      ## The user-provided short name for the user's bank account.
    account_number*: string
      ## The bank account number.
    account_type*: string
      ## The type of bank account.
    currency_code*: Option[CurrencyCode]
    identifiers*: Option[IdentifierList]
    branch_location*: Option[JsonNode]
      ## The portable international postal address. Maps to[AddressValidationMetadata](h
      ## ttps://github.com/googlei18n/libaddressinput/wiki/AddressValidationMetadata) and
      ## HTML 5.1 [Autofilling form controls: the autocompleteattribute](https://www.w3.
      ## org/TR/html51/sec-forms.html#autofilling-form-controls-the-autocomplete-attribut
      ## e).
    mandate*: Option[Mandate]

  BankList* = seq[Bank]

  BeneficialOwners* = ref object of RootObj
    ## Beneficial owners of the entity.
    individual_beneficial_owners*: Option[IndividualBeneficialOwnerList]
    business_beneficial_owners*: Option[BusinessBeneficialOwnerList]

  BillingAgreement* = ref object of RootObj
    ## The details of the billing agreement between the partner and a seller.
    description*: Option[string]
      ## The billing agreement description.
    billing_experience_preference*: Option[BillingExperiencePreference]
    merchant_custom_data*: Option[string]
      ## The custom data for the billing agreement.
    approval_url*: Option[string]
      ## The URL to which to redirect seller to accept the billing agreement.
    ec_token*: Option[string]
      ## The billing agreement token for the agreement.

  BillingExperiencePreference* = ref object of RootObj
    ## The preference that customizes the billing experience of the customer.
    experience_id*: Option[string]
      ## The ID of the payment web experience profile.
    billing_context_set*: Option[bool]
      ## Indicates whether the partner has already displayed the billing context to the
      ## seller.

  BirthDetails* = ref object of RootObj
    ## Date of birth data provided by the user
    date_of_birth*: DateNoTime

  Business* = ref object of RootObj
    business_type*: Option[BusinessTypeInfo]
    business_industry*: Option[BusinessIndustry]
    business_incorporation*: Option[JsonNode]
      ## Business incorporation information.
    names*: Option[BusinessNameDetailList]
    emails*: Option[EmailList]
    website*: Option[string]
      ## Website of the business.
    addresses*: Option[BusinessAddressDetailList]
    phones*: Option[BusinessPhoneDetailList]
    documents*: Option[BusinessDocumentList]

  BusinessAddressDetail* = ref object of RootObj
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
    `type`*: BusinessAddressType

  BusinessAddressDetailList* = seq[BusinessAddressDetail]

  BusinessAddressType* = enum
    ## Address type under which the provided address is tagged
    WORK = "WORK"

  BusinessBeneficialOwner* = ref object of RootObj
    business_type*: Option[BusinessTypeInfo]
    business_industry*: Option[BusinessIndustry]
    business_incorporation*: Option[JsonNode]
      ## Business incorporation information.
    names*: Option[BusinessNameDetailList]
    emails*: Option[EmailList]
    website*: Option[string]
      ## Website of the business.
    addresses*: Option[BusinessAddressDetailList]
    phones*: Option[BusinessPhoneDetailList]
    documents*: Option[BusinessDocumentList]
    percentage_of_ownership*: Option[Percentage]

  BusinessBeneficialOwnerList* = seq[BusinessBeneficialOwner]

  BusinessDocument* = ref object of RootObj
    id*: Option[string]
      ## The encrypted identifier for the document.
    labels*: Option[LabelsList]
    name*: Option[string]
      ## The file name.
    identification_number*: Option[string]
      ## The number for the document. It is the ID number if the document is `ID CARD`,
      ## the passport number if the document is `PASSPORT`, etc.
    issue_date*: Option[DateNoTime]
    expiry_date*: Option[DateNoTime]
    issuing_country_code*: Option[CountryCode]
    files*: Option[FileReferenceList]
    links*: Option[LinkDescriptionList]
    `type`*: Option[BusinessDocumentType]

  BusinessDocumentList* = seq[BusinessDocument]

  BusinessDocumentType* = enum
    ## The type of documents.
    SOCIALSECURITYNUMBER = "SOCIAL_SECURITY_NUMBER"
    EMPLOYMENTIDENTIFICATIONNUMBER = "EMPLOYMENT_IDENTIFICATION_NUMBER"
    TAXIDENTIFICATIONNUMBER = "TAX_IDENTIFICATION_NUMBER"
    PASSPORTNUMBER = "PASSPORT_NUMBER"
    PENSIONFUNDID = "PENSION_FUND_ID"
    MEDICALINSURANCEID = "MEDICAL_INSURANCE_ID"
    CNPJ = "CNPJ"
    CPF = "CPF"
    PAN = "PAN"
    BUSINESSREGISTRATION = "BUSINESS_REGISTRATION"

  BusinessEntity* = ref object of RootObj
    business_type*: Option[BusinessTypeInfo]
    business_industry*: Option[BusinessIndustry]
    business_incorporation*: Option[JsonNode]
      ## Business incorporation information.
    names*: Option[BusinessNameDetailList]
    emails*: Option[EmailList]
    website*: Option[string]
      ## Website of the business.
    addresses*: Option[BusinessAddressDetailList]
    phones*: Option[BusinessPhoneDetailList]
    documents*: Option[BusinessDocumentList]
    beneficial_owners*: Option[BeneficialOwners]
    annual_sales_volume_range*: Option[CurrencyRange]
    average_monthly_volume_range*: Option[CurrencyRange]
    purpose_code*: Option[seq[PurposeCodeEnum]]
      ## The account's purpose code.
    business_description*: Option[string]
      ## The business goals description. For example, a mission statement.

  BusinessIndustry* = ref object of RootObj
    ## The category, subcategory and MCC code of the business.
    category*: string
      ## The customer's business category code. PayPal uses industry standard seller
      ## category codes.
    mcc_code*: string
      ## The customer's business seller category code. PayPal uses industry standard
      ## seller category codes.
    subcategory*: string
      ## The customer's business subcategory code. PayPal uses industry standard seller
      ## subcategory codes.

  BusinessName* = ref object of RootObj
    ## The business name of the party.
    business_name*: Option[string]
      ## Required. The business name of the party.

  BusinessNameDetail* = ref object of RootObj
    business_name*: Option[string]
      ## Required. The business name of the party.
    `type`*: BusinessNameType

  BusinessNameDetailList* = seq[BusinessNameDetail]

  BusinessNameType* = enum
    ## Business name type
    DOINGBUSINESSAS = "DOING_BUSINESS_AS"
    LEGALNAME = "LEGAL_NAME"

  BusinessPhoneDetail* = ref object of RootObj
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
    `type`*: BusinessPhoneType

  BusinessPhoneDetailList* = seq[BusinessPhoneDetail]

  BusinessPhoneType* = enum
    ## The type of phone number provided. For example, home, work, or mobile.
    CUSTOMERSERVICE = "CUSTOMER_SERVICE"
    BUSINESS2 = "BUSINESS"

  BusinessSubType* = enum
    ## Sub classification of the business type
    ASSOTYPEINCORPORATED = "ASSO_TYPE_INCORPORATED"
    ASSOTYPENONINCORPORATED = "ASSO_TYPE_NON_INCORPORATED"
    GOVTTYPEENTITY = "GOVT_TYPE_ENTITY"
    GOVTTYPEEMANATION = "GOVT_TYPE_EMANATION"
    GOVTTYPEESTDCOMM = "GOVT_TYPE_ESTD_COMM"
    GOVTTYPEESTDFC = "GOVT_TYPE_ESTD_FC"
    GOVTTYPEESTDSTTR = "GOVT_TYPE_ESTD_ST_TR"

  BusinessType* = enum
    ## The business types classified
    ANYOTHERBUSINESSENTITY = "ANY_OTHER_BUSINESS_ENTITY"
    ASSOCIATION = "ASSOCIATION"
    CORPORATION = "CORPORATION"
    GENERALPARTNERSHIP = "GENERAL_PARTNERSHIP"
    GOVERNMENT = "GOVERNMENT"
    INDIVIDUAL = "INDIVIDUAL"
    LIMITEDLIABILITYPARTNERSHIP = "LIMITED_LIABILITY_PARTNERSHIP"
    LIMITEDLIABILITYPROPRIETORS = "LIMITED_LIABILITY_PROPRIETORS"
    LIMITEDLIABILITYPRIVATECORPORATION = "LIMITED_LIABILITY_PRIVATE_CORPORATION"
    LIMITEDPARTNERSHIP = "LIMITED_PARTNERSHIP"
    LIMITEDPARTNERSHIPPRIVATECORPORATION = "LIMITED_PARTNERSHIP_PRIVATE_CORPORATION"
    NONPROFIT = "NONPROFIT"
    ONLYBUYORSENDMONEY = "ONLY_BUY_OR_SEND_MONEY"
    OTHERCORPORATEBODY = "OTHER_CORPORATE_BODY"
    PARTNERSHIP = "PARTNERSHIP"
    PRIVATEPARTNERSHIP = "PRIVATE_PARTNERSHIP"
    PROPRIETORSHIP = "PROPRIETORSHIP"
    PROPRIETORSHIPCRAFTSMAN = "PROPRIETORSHIP_CRAFTSMAN"
    PROPRIETORYCOMPANY = "PROPRIETORY_COMPANY"
    PRIVATECORPORATION = "PRIVATE_CORPORATION"
    PUBLICCOMPANY = "PUBLIC_COMPANY"
    PUBLICCORPORATION = "PUBLIC_CORPORATION"
    PUBLICPARTNERSHIP = "PUBLIC_PARTNERSHIP"
    REGISTEREDCOOPERATIVE = "REGISTERED_COOPERATIVE"

  BusinessTypeInfo* = ref object of RootObj
    ## The type and subtype of the business.
    `type`*: Option[BusinessType]
    subtype*: Option[BusinessSubType]

  Capabilities* = enum
    ## Optional capabilities of the selected PayPal product for which the customer is
    ## being onboarded.
    PAYPALWALLETVAULTINGADVANCED = "PAYPAL_WALLET_VAULTING_ADVANCED"
    PAYUPONINVOICE = "PAY_UPON_INVOICE"
    APPLEPAY = "APPLE_PAY"
    GOOGLEPAY = "GOOGLE_PAY"

  CapabilitiesList* = seq[Capabilities]

  ClassicApiIntegration* = ref object of RootObj
    ## The integration details for PayPal CLASSIC endpoints.

  CountryCode* = string

  CountryCode2* = string

  CountryTransferMethodCurrencySelection* = ref object of RootObj
    ## Requested country, transfer method and currency.
    country*: Option[CountryCode]
    transfer_methods*: Option[TransferMethodList]

  CountryTransferMethodCurrencySelectionList* = seq[CountryTransferMethodCurrencySelection]

  CreateReferralDataResponse* = ref object of RootObj
    ## The shared referral data.
    links*: Option[DefinitionsLinkDescriptionList]

  CurrencyCode* = string

  CurrencyCode2* = string

  CurrencyCodeList* = seq[CurrencyCode2]

  CurrencyRange* = ref object of RootObj
    ## The currency range, from the minimum inclusive amount to the maximum inclusive
    ## amount.
    minimum_amount*: Option[Money]
    maximum_amount*: Option[Money]

  DateNoTime* = string

  DateTime* = string

  DefinitionsLinkDescriptionList* = seq[LinkDescription]

  DependentProcess* = ref object of RootObj

  DependentProcessList* = seq[DependentProcess]

  Document* = ref object of RootObj
    ## The document object.
    id*: Option[string]
      ## The encrypted identifier for the document.
    labels*: Option[LabelsList]
    name*: Option[string]
      ## The file name.
    identification_number*: Option[string]
      ## The number for the document. It is the ID number if the document is `ID CARD`,
      ## the passport number if the document is `PASSPORT`, etc.
    issue_date*: Option[DateNoTime]
    expiry_date*: Option[DateNoTime]
    issuing_country_code*: Option[CountryCode]
    files*: Option[FileReferenceList]
    links*: Option[LinkDescriptionList]

  Email* = ref object of RootObj
    ## An email address at which the person or business can be contacted.
    `type`*: string
      ## The role of the email address.
    email*: EmailAddress

  EmailAddress* = string

  EmailList* = seq[Email]

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

  FileReference* = ref object of RootObj
    ## The file reference. Can be a file in PayPal MediaServ, PayPal DMS, or another
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

  FinancialInstruments* = ref object of RootObj
    ## Financial instruments attached to this account.
    banks*: Option[BankList]

  FirstPartyDetails* = ref object of RootObj
    ## The integration details for PayPal first party REST endpoints.
    features*: RestEndpointFeaturesEnumList
    seller_nonce*: string
      ## S256 - The code verifier must be high-entropy cryptographic random string with a
      ## byte length of 43-128 range.

  Identifier* = ref object of RootObj
    ## The bank account ID. An ID with `ROUTING_NUMBER_1` is required.
    `type`*: Option[string]
      ## The bank account ID type.
    value*: Option[string]
      ## The value of account identifier.

  IdentifierList* = seq[Identifier]

  IndividualBeneficialOwner* = ref object of RootObj
    id*: Option[string]
      ## The encrypted party ID.
    names*: Option[PersonNameList]
    citizenship*: Option[CountryCode]
    addresses*: Option[PersonAddressDetailList]
    phones*: Option[PersonPhoneDetailList]
    birth_details*: Option[BirthDetails]
    documents*: Option[PersonDocumentList]
    percentage_of_ownership*: Option[Percentage]

  IndividualBeneficialOwnerList* = seq[IndividualBeneficialOwner]

  IndividualOwner* = ref object of RootObj
    id*: Option[string]
      ## The encrypted party ID.
    names*: Option[PersonNameList]
    citizenship*: Option[CountryCode]
    addresses*: Option[PersonAddressDetailList]
    phones*: Option[PersonPhoneDetailList]
    birth_details*: Option[BirthDetails]
    documents*: Option[PersonDocumentList]
    `type`*: Option[IndividualOwnerType]

  IndividualOwnerList* = seq[IndividualOwner]

  IndividualOwnerType* = enum
    ## Role of the person party played in the account.
    PRIMARY = "PRIMARY"

  IntegrationDetails* = ref object of RootObj
    ## The integration details for the partner and customer relationship. Required if
    ## `operation` is `API_INTEGRATION`.
    classic_api_integration*: Option[ClassicApiIntegration]
    rest_api_integration*: Option[RestApiIntegration]

  Labels* = string

  LabelsList* = seq[Labels]

  Language* = string

  LegalConsent* = ref object of RootObj
    ## The customer-provided consent.
    `type`*: string
      ## The type of consent. `SHARE_DATA_CONSENT` gives consent to you to share your
      ## customer's data with PayPal.
    granted*: bool
      ## Indicates whether the customer agreed to share this type of data. To give
      ## consent, specify `true`. To withhold consent, specify `false`.

  LegalConsentList* = seq[LegalConsent]

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

  Mandate* = ref object of RootObj
    ## Seller’s consent to operate on this financial instrument.
    accepted*: bool
      ## Whether mandate was accepted or not.

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
    full_name*: Option[string]
      ## When the party is a person, the party's full name.

  OfflineOnboardingPreference* = ref object of RootObj
    ## The preference details for offline onboarding without UI.

  Operation* = ref object of RootObj
    ## The required operation to share data.
    operation*: string
      ## The operation to enable for the customer. To enable the collection of the API
      ## permissions that you require to integrate with the customer, specify
      ## `API_INTEGRATION`. `BANK_ADDITION` is supported only for the US.
    api_integration_preference*: Option[IntegrationDetails]
    offline_onboarding_preference*: Option[OfflineOnboardingPreference]
    billing_agreement*: Option[BillingAgreement]

  OperationList* = seq[Operation]

  PartnerConfigOverride* = ref object of RootObj
    ## The preference to customize the web experience of the customer by overriding
    ## that is set at the Partner's Account.
    return_url*: Option[string]
      ## The URL to which to redirect the customer upon completion of the onboarding
      ## process.
    return_url_description*: Option[string]
      ## The description of the return URL.
    show_add_credit_card*: Option[bool]
      ## Indicates whether to show an add credit card page.

  PayoutAttributes* = ref object of RootObj
    ## Payout specific attributes.
    marketplace*: Option[bool]
      ## If `true`, specifies that the merchant or platform is offering goods or services
      ## on behalf of 3rd party sellers.
    kyc_required*: Option[bool]
      ## If `true`, specifies that the Kyc is required for the merchant.
    country_transfer_method_currency_selection*: Option[CountryTransferMethodCurrencySelectionList]

  Percentage* = string

  Person* = ref object of RootObj
    ## Details of the person or party.
    id*: Option[string]
      ## The encrypted party ID.
    names*: Option[PersonNameList]
    citizenship*: Option[CountryCode]
    addresses*: Option[PersonAddressDetailList]
    phones*: Option[PersonPhoneDetailList]
    birth_details*: Option[BirthDetails]
    documents*: Option[PersonDocumentList]

  PersonAddressDetail* = ref object of RootObj
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
    `type`*: PersonAddressType

  PersonAddressDetailList* = seq[PersonAddressDetail]

  PersonAddressType* = enum
    ## The address type under which the provided address is tagged.
    HOME = "HOME"

  PersonDocument* = ref object of RootObj
    id*: Option[string]
      ## The encrypted identifier for the document.
    labels*: Option[LabelsList]
    name*: Option[string]
      ## The file name.
    identification_number*: Option[string]
      ## The number for the document. It is the ID number if the document is `ID CARD`,
      ## the passport number if the document is `PASSPORT`, etc.
    issue_date*: Option[DateNoTime]
    expiry_date*: Option[DateNoTime]
    issuing_country_code*: Option[CountryCode]
    files*: Option[FileReferenceList]
    links*: Option[LinkDescriptionList]
    `type`*: Option[PersonDocumentType]

  PersonDocumentList* = seq[PersonDocument]

  PersonDocumentType* = enum
    ## The type of documents.
    SOCIALSECURITYNUMBER2 = "SOCIAL_SECURITY_NUMBER"
    EMPLOYMENTIDENTIFICATIONNUMBER2 = "EMPLOYMENT_IDENTIFICATION_NUMBER"
    TAXIDENTIFICATIONNUMBER2 = "TAX_IDENTIFICATION_NUMBER"
    PASSPORTNUMBER2 = "PASSPORT_NUMBER"
    PENSIONFUNDID2 = "PENSION_FUND_ID"
    MEDICALINSURANCEID2 = "MEDICAL_INSURANCE_ID"
    CNPJ2 = "CNPJ"
    CPF2 = "CPF"
    PAN2 = "PAN"
    NATIONALIDCARD = "NATIONAL_ID_CARD"

  PersonName* = ref object of RootObj
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
    `type`*: PersonNameType

  PersonNameList* = seq[PersonName]

  PersonNameType* = enum
    ## The person's name type.
    LEGAL = "LEGAL"

  PersonPhoneDetail* = ref object of RootObj
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
    `type`*: PhoneType

  PersonPhoneDetailList* = seq[PersonPhoneDetail]

  Phone* = ref object of RootObj
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

  PhoneType* = enum
    ## The phone type.
    FAX = "FAX"
    HOME2 = "HOME"
    MOBILE = "MOBILE"
    OTHER = "OTHER"
    PAGER = "PAGER"

  Product* = enum
    ## The PayPal product for which the customer is onboarded.
    ALIPAY = "ALIPAY"
    BANCONTACT = "BANCONTACT"
    BLIK = "BLIK"
    EPS = "EPS"
    PPCP = "PPCP"
    EXPRESSCHECKOUT = "EXPRESS_CHECKOUT"
    PAYMENTMETHODS = "PAYMENT_METHODS"
    ADVANCEDVAULTING = "ADVANCED_VAULTING"
    IDEAL = "IDEAL"
    MBWAY = "MB_WAY"
    MULTIBANCO = "MULTIBANCO"
    PAYPALCOMMERCEPLATFORMBUSINESS = "PAYPAL_COMMERCE_PLATFORM_BUSINESS"
    PPPLUS = "PPPLUS"
    PRZELEWY24 = "PRZELEWY24"
    SATISPAY = "SATISPAY"
    TRUSTLY = "TRUSTLY"
    WECHATPAY = "WECHAT_PAY"
    WEBSITEPAYMENTPRO = "WEBSITE_PAYMENT_PRO"
    ZETTLE = "ZETTLE"
    HYPERWALLETPAYOUTS = "HYPERWALLET_PAYOUTS"

  ProductList* = seq[Product]

  PurposeCodeEnum* = enum
    ## The purpose code. Required only for India. For more information, see the Reserve
    ## Bank Of India web site. Value is:<ul><li><code>P0104</code>. Cross border
    ## delivery of goods and services.</li><li><code>P0301</code>. Business related
    ## travel purchase.</li><li><code>P0801</code>. Hardware
    ## consulting.</li><li><code>P0802</code>. Software
    ## consulting.</li><li><code>P0803</code>. Data processing
    ## consulting.</li><li><code>P0805</code>. Freelance
    ## journalism.</li><li><code>P0806</code>. Other information
    ## services.</li><li><code>P0902</code>. Licensing
    ## revenues.</li><li><code>P1004</code>. Legal.</li><li><code>P1005</code>.
    ## Accounting and tax.</li><li><code>P1006</code>. Business and management
    ## consultancy.</li><li><code>P1007</code>. Advertising and market
    ## research.</li><li><code>P1008</code>. Research and
    ## development.</li><li><code>P1009</code>. Architectural services.</li></ul>
    P0104 = "P0104"
    P0301 = "P0301"
    P0801 = "P0801"
    P0802 = "P0802"
    P0803 = "P0803"
    P0805 = "P0805"
    P0806 = "P0806"
    P0902 = "P0902"
    P1004 = "P1004"
    P1005 = "P1005"
    P1006 = "P1006"
    P1007 = "P1007"
    P1008 = "P1008"
    P1009 = "P1009"

  ReferralData* = ref object of RootObj
    ## The customer's referral data that partners share with PayPal.
    individual_owners*: Option[IndividualOwnerList]
    business_entity*: Option[BusinessEntity]
    email*: Option[EmailAddress]
    preferred_language_code*: Option[Language]
    tracking_id*: Option[string]
      ## The partner's unique identifier for this customer in their system which can be
      ## used to track user in PayPal.
    partner_config_override*: Option[PartnerConfigOverride]
    financial_instruments*: Option[FinancialInstruments]
    operations*: OperationList
    products*: Option[ProductList]
    capabilities*: Option[CapabilitiesList]
    outside_process_dependencies*: Option[DependentProcessList]
    legal_consents*: LegalConsentList
    payout_attributes*: Option[PayoutAttributes]
    legal_country_code*: Option[CountryCode]

  ReferralDataResponse* = ref object of RootObj
    ## The share referral data response.
    partner_referral_id*: Option[string]
      ## The ID to access the customer's data shared by the partner with PayPal.
    submitter_payer_id*: Option[string]
      ## The payer ID of the partner who shared the referral data.
    submitter_client_id*: Option[string]
      ## The client ID of the partner who shared the referral data. This cliend ID will
      ## be returned only when the caller is determined as an internal partner, which
      ## means the scope of the caller's security context only have
      ## "https://uri.paypal.com/services/customer/partner-referrals", For more
      ## information, see <ahref="https://github.paypal.com/Customers-R/partnselleronbno
      ## deserv/blob/b0a631c43e80a4dd43d34c01f479c272b3287796/src/helpers/securityContext
      ## Helpers.js#L143">Api Actor type in Typhoon service</a>.
    referral_data*: Option[ReferralData]
    links*: Option[ReferralDataResponseDefinitionsLinkDescriptionList]

  ReferralDataResponseDefinitionsLinkDescriptionList* = seq[LinkDescription]

  RestApiIntegration* = ref object of RootObj
    ## The integration details for PayPal REST endpoints.
    integration_method*: Option[string]
      ## The REST-credential integration method.
    integration_type*: string
      ## The type of REST-endpoint integration. To integrate with Braintree v.zero for
      ## PayPal REST endpoints, specify `third_party_details`.
    first_party_details*: Option[FirstPartyDetails]
    third_party_details*: Option[ThirdPartyDetails]

  RestApiIntegrationRestEndpointFeaturesEnumList* = seq[RestEndpointFeaturesEnum]

  RestEndpointFeaturesEnum* = enum
    ## The REST endpoint.
    PAYOUTS = "PAYOUTS"
    PAYMENT = "PAYMENT"
    REFUND = "REFUND"
    FUTUREPAYMENT = "FUTURE_PAYMENT"
    DIRECTPAYMENT = "DIRECT_PAYMENT"
    PARTNERFEE = "PARTNER_FEE"
    DELAYFUNDSDISBURSEMENT = "DELAY_FUNDS_DISBURSEMENT"
    READSELLERDISPUTE = "READ_SELLER_DISPUTE"
    UPDATESELLERDISPUTE = "UPDATE_SELLER_DISPUTE"
    ADVANCEDTRANSACTIONSSEARCH = "ADVANCED_TRANSACTIONS_SEARCH"
    SWEEPFUNDSEXTERNALSINK = "SWEEP_FUNDS_EXTERNAL_SINK"
    ACCESSMERCHANTINFORMATION = "ACCESS_MERCHANT_INFORMATION"
    TRACKINGSHIPMENTREADWRITE = "TRACKING_SHIPMENT_READWRITE"
    INVOICEREADWRITE = "INVOICE_READ_WRITE"
    DISPUTEREADBUYER = "DISPUTE_READ_BUYER"
    UPDATECUSTOMERDISPUTES = "UPDATE_CUSTOMER_DISPUTES"
    VAULT = "VAULT"
    BILLINGAGREEMENT2 = "BILLING_AGREEMENT"
    WITHDRAWALS = "WITHDRAWALS"
    LINKEDFINANCIALINSTRUMENTS = "LINKED_FINANCIAL_INSTRUMENTS"
    USERPROFILE = "USER_PROFILE"
    TRANSACTIONRISKDATA = "TRANSACTION_RISK_DATA"
    PAYPALBALANCE = "PAYPAL_BALANCE"
    EXCHANGECURRENCY = "EXCHANGE_CURRENCY"

  RestEndpointFeaturesEnumList* = seq[RestEndpointFeaturesEnum]

  SignupMode* = enum
    ## Signup Mode to be used for sellers for third party integration.
    VERIFYWITHPAYPAL = "VERIFY_WITH_PAYPAL"

  ThirdPartyDetails* = ref object of RootObj
    ## The integration details for PayPal REST endpoints.
    features*: Option[RestApiIntegrationRestEndpointFeaturesEnumList]
    signup_mode*: Option[SignupMode]
    organization*: Option[string]
      ## The organization to which the account will belong in the partner’s hierarchy, as
      ## a path.

  TransferMethod* = ref object of RootObj
    ## Requested transfer method and currency for a country.
    transfer_method_type*: Option[string]
      ## Transfer Method type.
    currencies*: Option[CurrencyCodeList]

  TransferMethodList* = seq[TransferMethod]
