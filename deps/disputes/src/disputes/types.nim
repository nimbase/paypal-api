import std/[options, json]

type
  AcceptClaimResponseOptions* = ref object of RootObj
    ## The allowed response options when the merchant is accepting the claim.
    accept_claim_types*: Option[AcceptClaimTypeList]

  AcceptClaimType* = enum
    ## The refund type proposed by the merchant for the dispute.
    REFUND = "REFUND"
    REFUNDWITHRETURN = "REFUND_WITH_RETURN"
    PARTIALREFUND = "PARTIAL_REFUND"
    REFUNDWITHRETURNSHIPMENTLABEL = "REFUND_WITH_RETURN_SHIPMENT_LABEL"

  AcceptClaimTypeList* = seq[AcceptClaimType]

  AcceptOffer* = ref object of RootObj
    ## A customer request to accept the offer made by the merchant.
    note*: Option[string]
      ## The customer notes about accepting of offer. PayPal can but the merchant cannot
      ## view these notes.

  AcknowledgeReturnItemResponseOptions* = ref object of RootObj
    ## The allowed response options when the seller acknowledges that the buyer has
    ## returned an item for the dispute.
    acknowledgement_types*: Option[AcknowledgementTypeList]

  AcknowledgementType* = enum
    ## The type of acknowledgement allowed for the merchant after the customer has
    ## returned the item. The merchant can update whether the item was received and is
    ## as expected or if the item was not received.
    ITEMRECEIVED = "ITEM_RECEIVED"
    ITEMNOTRECEIVED = "ITEM_NOT_RECEIVED"
    DAMAGED = "DAMAGED"
    EMPTYPACKAGEORDIFFERENT = "EMPTY_PACKAGE_OR_DIFFERENT"
    MISSINGITEMS = "MISSING_ITEMS"

  AcknowledgementTypeList* = seq[AcknowledgementType]

  ActionInfo* = ref object of RootObj
    ## The extended properties for a evidence. Includes additional information such as
    ## the action for which the evidence was requested/submitted, and whether the
    ## evidence is mandatory.
    action*: Option[string]
      ## The action for which the evidence was requested or submitted.
    response_option*: Option[string]
      ## The response option for the corresponding action. Possible values:<ul><li><ahre
      ## f="/docs/api/customer-disputes/v1/#definition-acknowledgement_type">Acknowledgem
      ## ent Types</a></li><li><ahref="/docs/api/customer-disputes/v1/#definition-respon
      ## se-accept_claim_type">Accept Claim types</a></li></ul>.
    mandatory*: Option[bool]
      ## Indicates whether the evidence is mandatory for the corresponding action and
      ## response option.

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

  Adjudicate* = ref object of RootObj
    ## A request to settle a dispute in either the customer's or merchant's favor.
    adjudication_outcome*: string
      ## The outcome of the adjudication.

  Adjudication* = ref object of RootObj
    ## The Adjudication details for the dispute.
    `type`*: AdjudicationType
    adjudication_time*: DateTime
    reason*: Option[AdjudicationReason]
    dispute_life_cycle_stage*: Option[DisputeLifecycleStage]

  AdjudicationList* = seq[Adjudication]

  AdjudicationReason* = enum
    ## The reason for the adjudication type.
    AMOUNTDIFFERENCEEXPECTEDDUETOFEES = "AMOUNT_DIFFERENCE_EXPECTED_DUE_TO_FEES"
    BILLINGAGREEMENTCHANGEDISCLOSED = "BILLING_AGREEMENT_CHANGE_DISCLOSED"
    BILLINGAGREEMENTCHANGENOTDISCLOSED = "BILLING_AGREEMENT_CHANGE_NOT_DISCLOSED"
    BILLINGAGREEMENTDATECHANGEDISCLOSED = "BILLING_AGREEMENT_DATE_CHANGE_DISCLOSED"
    BILLINGAGREEMENTDATECHANGENOTDISCLOSED = "BILLING_AGREEMENT_DATE_CHANGE_NOT_DISCLOSED"
    BUYERATTEMPTEDRETURN = "BUYER_ATTEMPTED_RETURN"
    BUYERBILLEDONLYONCE = "BUYER_BILLED_ONLY_ONCE"
    BUYERCANCELLEDCASE = "BUYER_CANCELLED_CASE"
    BUYERCANCELLEDSERVICE = "BUYER_CANCELLED_SERVICE"
    BUYERFAILEDTODESCRIBEISSUE = "BUYER_FAILED_TO_DESCRIBE_ISSUE"
    BUYERHASPOSSESSIONOFTHEMERCHANDISEORSERVICE = "BUYER_HAS_POSSESSION_OF_THE_MERCHANDISE_OR_SERVICE"
    BUYERMADENOATTEMPTTORESOLVEWITHSELLER = "BUYER_MADE_NO_ATTEMPT_TO_RESOLVE_WITH_SELLER"
    BUYERNOTINPOSSESSIONOFITEMTORETURN = "BUYER_NOT_IN_POSSESSION_OF_ITEM_TO_RETURN"
    BUYERPROVIDEDCREDITRECEIPT = "BUYER_PROVIDED_CREDIT_RECEIPT"
    BUYERRECEIVEDDUPLICATEREFUND = "BUYER_RECEIVED_DUPLICATE_REFUND"
    CANCELLEDPERTERMSOFBILLINGAGREEMENT = "CANCELLED_PER_TERMS_OF_BILLING_AGREEMENT"
    CARDNOTSTOLEN = "CARD_NOT_STOLEN"
    CARDNOTSTOLENBEFOREAUTH = "CARD_NOT_STOLEN_BEFORE_AUTH"
    CUSTOMERRECOGNIZESTRANSACTION = "CUSTOMER_RECOGNIZES_TRANSACTION"
    DECISIONBASEDONAVAILABLEINFORMATION = "DECISION_BASED_ON_AVAILABLE_INFORMATION"
    DELIVERYAFTEREXPECTEDDELIVERYDATE = "DELIVERY_AFTER_EXPECTED_DELIVERY_DATE"
    DELIVERYDUEWITHINEXPECTEDDELIVERYDATE = "DELIVERY_DUE_WITHIN_EXPECTED_DELIVERY_DATE"
    DELIVERYORSERVICEREFUSED = "DELIVERY_OR_SERVICE_REFUSED"
    DOCUMENTATIONMATCHESAMOUNTCHARGED = "DOCUMENTATION_MATCHES_AMOUNT_CHARGED"
    DOCUMENTATIONMATCHESAMOUNTINPAYPALACCOUNT = "DOCUMENTATION_MATCHES_AMOUNT_IN_PAYPAL_ACCOUNT"
    DUPLICATEADDFUNDS = "DUPLICATE_ADD_FUNDS"
    EFFORTLESSSELLERPROTECTION = "EFFORTLESS_SELLER_PROTECTION"
    INPERSONDELIVERY = "IN_PERSON_DELIVERY"
    INELIGIBLEBUYERPROTECTIONPOLICY = "INELIGIBLE_BUYER_PROTECTION_POLICY"
    INELIGIBLESELLERPROTECTIONPOLICY = "INELIGIBLE_SELLER_PROTECTION_POLICY"
    INQUIRYOFFERITEMREPLACED = "INQUIRY_OFFER_ITEM_REPLACED"
    INQUIRYOFFERPARTIALREFUND = "INQUIRY_OFFER_PARTIAL_REFUND"
    INQUIRYOFFERREFUNDWITHITEMRETURN = "INQUIRY_OFFER_REFUND_WITH_ITEM_RETURN"
    INQUIRYOFFERREFUNDWITHREPLACEMENT = "INQUIRY_OFFER_REFUND_WITH_REPLACEMENT"
    INVALIDAPPEALREASON = "INVALID_APPEAL_REASON"
    INVALIDCHARGEBACKSELLERFAVOUR = "INVALID_CHARGEBACK_SELLER_FAVOUR"
    INVALIDDELIVERYPROOF = "INVALID_DELIVERY_PROOF"
    INVALIDDELIVERYPROOFSIGNATURE = "INVALID_DELIVERY_PROOF_SIGNATURE"
    INVALIDDOCUMENTATION = "INVALID_DOCUMENTATION"
    INVALIDPROOFOFSHIPMENT = "INVALID_PROOF_OF_SHIPMENT"
    INVALIDREFUNDPROOF = "INVALID_REFUND_PROOF"
    INVALIDRETURNDELIVERYNOSIGNATUREPROOF = "INVALID_RETURN_DELIVERY_NO_SIGNATURE_PROOF"
    INVALIDRETURNDELIVERYPROOF = "INVALID_RETURN_DELIVERY_PROOF"
    INVALIDTRACKING = "INVALID_TRACKING"
    ITEMALTEREDREPAIRED = "ITEM_ALTERED_REPAIRED"
    ITEMNOTASADVERTISED = "ITEM_NOT_AS_ADVERTISED"
    ITEMNOTASDESCRIBED = "ITEM_NOT_AS_DESCRIBED"
    ITEMNOTDAMAGED = "ITEM_NOT_DAMAGED"
    ITEMNOTDELIVERED = "ITEM_NOT_DELIVERED"
    ITEMNOTRETURNEDTOSELLER = "ITEM_NOT_RETURNED_TO_SELLER"
    ITEMNOTSHIPPED = "ITEM_NOT_SHIPPED"
    ITEMOFDIFFERENTQUALITYORQUANTITY = "ITEM_OF_DIFFERENT_QUALITY_OR_QUANTITY"
    ITEMOUTOFSTOCKANDNOTDELIVERED = "ITEM_OUT_OF_STOCK_AND_NOT_DELIVERED"
    ITEMRETURNEDTOSELLER = "ITEM_RETURNED_TO_SELLER"
    ITEMSERVICEMISREPRESENTED = "ITEM_SERVICE_MISREPRESENTED"
    ITEMSERVICENOTMISREPRESENTED = "ITEM_SERVICE_NOT_MISREPRESENTED"
    ITEMSERVICERECEIVEDBYBUYER = "ITEM_SERVICE_RECEIVED_BY_BUYER"
    ITEMSOLDASDESCRIBED = "ITEM_SOLD_AS_DESCRIBED"
    ITEMVALUEUNAFFECTED = "ITEM_VALUE_UNAFFECTED"
    MULTIPLEAPPEALSWITHSAMEREASON = "MULTIPLE_APPEALS_WITH_SAME_REASON"
    NODOCUMENTATIONFROMBUYER = "NO_DOCUMENTATION_FROM_BUYER"
    NODOCUMENTATIONSUPPORTINGDUEOFCREDIT = "NO_DOCUMENTATION_SUPPORTING_DUE_OF_CREDIT"
    NOPROOFOFDELIVERY = "NO_PROOF_OF_DELIVERY"
    NOPROOFOFDELIVERYINTANGIBLE = "NO_PROOF_OF_DELIVERY_INTANGIBLE"
    NOPROTECTIONFORDIGITALGOODSSERVICE = "NO_PROTECTION_FOR_DIGITAL_GOODS_SERVICE"
    NORESPONSEFROMBUYER = "NO_RESPONSE_FROM_BUYER"
    NORESPONSEFROMBUYERFORADDITIONALINFOREQUEST = "NO_RESPONSE_FROM_BUYER_FOR_ADDITIONAL_INFO_REQUEST"
    NOSELLERRESPONSE = "NO_SELLER_RESPONSE"
    NOSELLERRESPONSEFORADDITIONALINFOREQUEST = "NO_SELLER_RESPONSE_FOR_ADDITIONAL_INFO_REQUEST"
    NOVALIDSHIPMENTPROOF = "NO_VALID_SHIPMENT_PROOF"
    NOTABILLINGERROR = "NOT_A_BILLING_ERROR"
    NOTANUNAUTHORIZEDTRANSACTION = "NOT_AN_UNAUTHORIZED_TRANSACTION"
    NOTDUPLICATEFUNDSADDEDONCE = "NOT_DUPLICATE_FUNDS_ADDED_ONCE"
    NOTDUPLICATEFUNDSWITHDRAWNONCE = "NOT_DUPLICATE_FUNDS_WITHDRAWN_ONCE"
    NOTSHIPPEDTOCORRECTADDRESS = "NOT_SHIPPED_TO_CORRECT_ADDRESS"
    PARTIALREFUNDISSUEDFORMISSINGITEMS = "PARTIAL_REFUND_ISSUED_FOR_MISSING_ITEMS"
    PARTIALREFUNDOFFERACCEPTED = "PARTIAL_REFUND_OFFER_ACCEPTED"
    PAYMENTREVERSEDALREADY = "PAYMENT_REVERSED_ALREADY"
    POSSUBMITTEDINSTEADOFPOD = "POS_SUBMITTED_INSTEAD_OF_POD"
    PREAUTHINSTALLMENTDUE = "PREAUTH_INSTALLMENT_DUE"
    PROOFOFBILLINGAFTERCANCELLATIONACCEPTED = "PROOF_OF_BILLING_AFTER_CANCELLATION_ACCEPTED"
    PROOFOFDUPLICATEDENIEDORINSUFFICIENT = "PROOF_OF_DUPLICATE_DENIED_OR_INSUFFICIENT"
    PROOFOFINCORRECTTRANSACTIONAMOUNTACCEPTED = "PROOF_OF_INCORRECT_TRANSACTION_AMOUNT_ACCEPTED"
    PROOFOFPAIDBYOTHERMEANSNOTSUBMITTED = "PROOF_OF_PAID_BY_OTHER_MEANS_NOT_SUBMITTED"
    PROOFOFTRACKINGNOTSUBMITTED = "PROOF_OF_TRACKING_NOT_SUBMITTED"
    PROTECTEDBYPAYPAL = "PROTECTED_BY_PAYPAL"
    REPRESENTEDBYPAYPAL = "REPRESENTED_BY_PAYPAL"
    SELLERACCEPTEDMULTIPLEPAYMENTS = "SELLER_ACCEPTED_MULTIPLE_PAYMENTS"
    SELLERAGREEDREFUNDWITHOUTRETURN = "SELLER_AGREED_REFUND_WITHOUT_RETURN"
    SELLERAGREEDTOISSUECREDIT = "SELLER_AGREED_TO_ISSUE_CREDIT"
    SELLERISSUEDCREDITTOBUYER = "SELLER_ISSUED_CREDIT_TO_BUYER"
    SELLERISSUEDREFUND = "SELLER_ISSUED_REFUND"
    SELLERNOTREACHABLE = "SELLER_NOT_REACHABLE"
    SELLERRECEIVEDPAYMENTTWICEORFORREPLACEMENT = "SELLER_RECEIVED_PAYMENT_TWICE_OR_FOR_REPLACEMENT"
    SELLERREFUSEDREFUND = "SELLER_REFUSED_REFUND"
    SELLERREFUSEDRETURN = "SELLER_REFUSED_RETURN"
    SELLERSURCHARGEDBUYER = "SELLER_SURCHARGED_BUYER"
    SERVICENOTCOMPLETEDASAGREED = "SERVICE_NOT_COMPLETED_AS_AGREED"
    SHIPPINGCOMPANYWONTSHIP = "SHIPPING_COMPANY_WONT_SHIP"
    TRACKINGPROOFNOTENOUGH = "TRACKING_PROOF_NOT_ENOUGH"
    TRANSACTIONAUTHORIZEDBYCARDHOLDER = "TRANSACTION_AUTHORIZED_BY_CARDHOLDER"
    TRANSACTIONCANCELLEDAFTERAUTHORIZATIONDATE = "TRANSACTION_CANCELLED_AFTER_AUTHORIZATION_DATE"
    TRANSACTIONCANCELLEDBEFORESHIPMENTSERVICEDATE = "TRANSACTION_CANCELLED_BEFORE_SHIPMENT_SERVICE_DATE"
    TRANSACTIONMATCHESBUYERSPENDINGPATTERN = "TRANSACTION_MATCHES_BUYER_SPENDING_PATTERN"
    TRANSACTIONPROCESSEDCORRECTLY = "TRANSACTION_PROCESSED_CORRECTLY"
    TRUSTEDBUYERPAYOUT = "TRUSTED_BUYER_PAYOUT"
    UNUSEDSHIPPINGLABEL = "UNUSED_SHIPPING_LABEL"
    VALIDPROOFOFDELIVERY = "VALID_PROOF_OF_DELIVERY"
    VALIDPROOFOFDELIVERYWITHSIGNATURE = "VALID_PROOF_OF_DELIVERY_WITH_SIGNATURE"
    VALIDPROOFOFREFUND = "VALID_PROOF_OF_REFUND"
    VALIDPROOFSUPPORTINGCLAIM = "VALID_PROOF_SUPPORTING_CLAIM"
    VALIDRETURNDELIVERYPROOF = "VALID_RETURN_DELIVERY_PROOF"
    VALIDRETURNDELIVERYPROOFWITHSIGNATURE = "VALID_RETURN_DELIVERY_PROOF_WITH_SIGNATURE"
    VALIDSHIPMENTPROOF = "VALID_SHIPMENT_PROOF"
    VALUEAFFECTEDSIGNIFICANTLY = "VALUE_AFFECTED_SIGNIFICANTLY"
    PROTECTIONPOLICYAPPLIES = "PROTECTION_POLICY_APPLIES"
    SNADDELAYEDFILING = "SNAD_DELAYED_FILING"
    FUNDSTRANSFERREDTOINCORRECTRECIPIENT = "FUNDS_TRANSFERRED_TO_INCORRECT_RECIPIENT"

  AdjudicationType* = enum
    ## The type of adjudication.
    DENYBUYER = "DENY_BUYER"
    PAYOUTTOBUYER = "PAYOUT_TO_BUYER"
    PAYOUTTOSELLER = "PAYOUT_TO_SELLER"
    RECOVERFROMSELLER = "RECOVER_FROM_SELLER"

  AgreedRefundDetails* = ref object of RootObj
    ## Details of Agreed Refund between customer and merchant.
    merchant_agreed_refund*: Option[bool]
      ## Indicates whether merchant has agreed to refund the buyer or not.
    merchant_agreed_refund_time*: Option[DateTime]

  AllowedResponseOptions* = ref object of RootObj
    ## The allowed response options for the buyer/seller update actions.
    acknowledge_return_item*: Option[AcknowledgeReturnItemResponseOptions]
    accept_claim*: Option[AcceptClaimResponseOptions]
    make_offer*: Option[MakeOfferResponseOptions]

  BillingDisputesProperties* = ref object of RootObj
    ## The billing issue details.
    duplicate_transaction*: Option[DuplicateTransaction]
    incorrect_transaction_amount*: Option[IncorrectTransactionAmount]
    payment_by_other_means*: Option[PaymentByOtherMeans]
    credit_not_processed*: Option[CreditNotProcessed]
    canceled_recurring_billing*: Option[CanceledRecurringBilling]

  Buyer* = ref object of RootObj
    ## The details for the customer who funds the payment. For example, the customer's
    ## first name, last name, and email address.
    name*: Option[string]
      ## The customer's name.

  BuyerEscalationReason* = ref object of RootObj

  CanceledRecurringBilling* = ref object of RootObj
    ## The recurring billing canceled details.
    expected_refund*: Option[Money]
    cancellation_details*: Option[CancellationDetails]

  CancellationDetails* = ref object of RootObj
    ## The cancellation details.
    cancellation_date*: Option[DateTime]
    cancellation_number*: Option[string]
      ## The cancellation number.
    cancelled*: Option[bool]
      ## Indicates whether the dispute was canceled.
    cancellation_mode*: Option[string]
      ## Indicates the mode used for order cancellation.

  CommunicationDetails* = ref object of RootObj
    ## The contact details that a merchant provides to the customer to use to share
    ## their evidence documents.
    email*: Option[EmailAddress]
    note*: Option[string]
      ## The merchant provided notes that are visible to both the customer and PayPal.
    time_posted*: Option[DateTime]

  CountryCode* = string

  CreditNotProcessed* = ref object of RootObj
    ## The credit not processed details.
    issue_type*: Option[string]
      ## The issue type.
    expected_refund*: Option[Money]
    cancellation_details*: Option[CancellationDetails]
    product_details*: Option[ProductDetails]
    service_details*: Option[ServiceDetails]
    agreed_refund_details*: Option[AgreedRefundDetails]

  Cryptocurrency* = ref object of RootObj
    ## The details needed to represent a specific cryptocurrency balance, such as its
    ## symbol and quantity.
    asset_symbol*: CryptocurrencySymbol
    quantity*: CryptocurrencyQuantity
    quantity_in_subunits*: Option[CryptocurrencySubunitsQuantity]
    decimals*: Option[CryptocurrencyDecimals]

  CryptocurrencyDecimals* = int64

  CryptocurrencyQuantity* = string

  CryptocurrencySubunitsQuantity* = string

  CryptocurrencySymbol* = enum
    ## The cryptocurrency symbol or code ticker options. Assigned by liquidity
    ## providers and exchanges.
    BTC = "BTC"
    ETH = "ETH"
    BCH = "BCH"
    LTC = "LTC"
    PYUSD = "PYUSD"
    LINK = "LINK"
    SOL = "SOL"
    MATIC = "MATIC"

  CurrencyCode* = string

  DateTime* = string

  DefinitionsDocumentList* = seq[Document]

  DefinitionsLinkDescriptionList* = seq[LinkDescription]

  DefinitionsSubReasons* = enum
    ## The sub-reason for the service issue.
    DAMAGED2 = "DAMAGED"
    DIFFERENT = "DIFFERENT"
    INCOMPLETE = "INCOMPLETE"
    OTHER = "OTHER"

  DefinitionsSubReasonsList* = seq[DefinitionsSubReasons]

  DenyOffer* = ref object of RootObj
    ## A customer request to deny the offer made by the merchant.
    note*: string
      ## The customer notes about the denial of offer. PayPal can but the merchant cannot
      ## view these notes.

  Dispute* = ref object of RootObj
    ## The dispute details.
    dispute_id*: Option[string]
      ## The ID of the dispute.
    create_time*: Option[DateTime]
    update_time*: Option[DateTime]
    disputed_transactions*: Option[TransactionInfoList]
    reason*: Option[DisputeReason]
    status*: Option[Status]
    dispute_amount*: Option[Money]
    dispute_asset*: Option[Cryptocurrency]
    fee_policy*: Option[FeePolicy]
    external_reason_code*: Option[string]
      ## The code that identifies the reason for the credit card chargeback. Each card
      ## issuer follows their own standards for defining reason type, code, and its
      ## format. For more details about the external reason code, see the card issue
      ## site. Available for only unbranded transactions.
    dispute_outcome*: Option[DisputeOutcome]
    adjudications*: Option[AdjudicationList]
    money_movements*: Option[MoneyMovementList]
    fund_movements*: Option[FundMovementList]
    dispute_life_cycle_stage*: Option[DisputeLifecycleStage]
    dispute_channel*: Option[DisputeChannel]
    messages*: Option[MessageList]
    extensions*: Option[Extensions]
    evidences*: Option[EvidenceList]
    buyer_response_due_date*: Option[DateTime]
    seller_response_due_date*: Option[DateTime]
    offer*: Option[Offer]
    refund_details*: Option[RefundDetails]
    communication_details*: Option[CommunicationDetails]
    supporting_info*: Option[SupportingInfoList]
    allowed_response_options*: Option[AllowedResponseOptions]
    links*: Option[DefinitionsLinkDescriptionList]

  DisputeChannel* = enum
    ## The channel where the customer created the dispute.
    INTERNAL = "INTERNAL"
    EXTERNAL = "EXTERNAL"
    ALERT = "ALERT"

  DisputeInfo* = ref object of RootObj
    ## The dispute summary information.
    dispute_id*: Option[string]
      ## The ID of the dispute.
    create_time*: Option[DateTime]
    update_time*: Option[DateTime]
    reason*: Option[DisputeReason]
    status*: Option[Status]
    dispute_state*: Option[DisputeState]
    dispute_amount*: Option[Money]
    dispute_asset*: Option[Cryptocurrency]
    dispute_life_cycle_stage*: Option[DisputeLifecycleStage]
    dispute_channel*: Option[DisputeChannel]
    buyer_response_due_date*: Option[DateTime]
    seller_response_due_date*: Option[DateTime]
    links*: Option[DefinitionsLinkDescriptionList]

  DisputeInfoList* = seq[DisputeInfo]

  DisputeLifecycleStage* = enum
    ## The stage in the dispute lifecycle.
    INQUIRY = "INQUIRY"
    CHARGEBACK = "CHARGEBACK"
    PREARBITRATION = "PRE_ARBITRATION"
    ARBITRATION = "ARBITRATION"

  DisputeOutcome* = ref object of RootObj
    ## The outcome of a dispute.
    outcome_code*: Option[string]
      ## The outcome of a resolved dispute.
    outcome_reason*: Option[AdjudicationReason]
    amount_refunded*: Option[Money]
    asset_refunded*: Option[Cryptocurrency]

  DisputeReason* = enum
    ## The reason for the item-level dispute. For information about the required
    ## information for each dispute reason and associated evidence type, see <ahref="/
    ## docs/integration/direct/customer-disputes/integration-guide/#dispute-reasons">di
    ## spute reasons</a>.
    MERCHANDISEORSERVICENOTRECEIVED = "MERCHANDISE_OR_SERVICE_NOT_RECEIVED"
    MERCHANDISEORSERVICENOTASDESCRIBED = "MERCHANDISE_OR_SERVICE_NOT_AS_DESCRIBED"
    UNAUTHORISED = "UNAUTHORISED"
    CREDITNOTPROCESSED2 = "CREDIT_NOT_PROCESSED"
    DUPLICATETRANSACTION2 = "DUPLICATE_TRANSACTION"
    INCORRECTAMOUNT = "INCORRECT_AMOUNT"
    PAYMENTBYOTHERMEANS2 = "PAYMENT_BY_OTHER_MEANS"
    CANCELEDRECURRINGBILLING2 = "CANCELED_RECURRING_BILLING"
    PROBLEMWITHREMITTANCE = "PROBLEM_WITH_REMITTANCE"
    OTHER2 = "OTHER"

  DisputeSearch* = ref object of RootObj
    ## An array of disputes. Includes links that enable you to navigate through the
    ## response.
    items*: Option[DisputeInfoList]
    links*: Option[DefinitionsLinkDescriptionList]

  DisputeSource* = enum
    ## The dispute source through which customer initiated the dispute.
    EMAIL = "EMAIL"
    WEB = "WEB"
    CHAT = "CHAT"
    IVR = "IVR"
    PHONE = "PHONE"
    MOBILEAPP = "MOBILE_APP"
    MOBILEWEB = "MOBILE_WEB"
    API = "API"

  DisputeState* = enum
    ## The user specific state of the dispute, could vary between parties during the
    ## dispute lifecycle.
    OPENINQUIRIES = "OPEN_INQUIRIES"
    REQUIREDACTION = "REQUIRED_ACTION"
    REQUIREDOTHERPARTYACTION = "REQUIRED_OTHER_PARTY_ACTION"
    UNDERPAYPALREVIEW = "UNDER_PAYPAL_REVIEW"
    APPEALABLE = "APPEALABLE"
    RESOLVED = "RESOLVED"

  Document* = ref object of RootObj
    ## An uploaded document as a binary object that supports a dispute.
    name*: Option[string]
      ## The document name.
    url*: Option[string]
      ## The downloadable URL for the document for which the client has
      ## access.<br/><br/><blockquote><strong>Note:</strong> Document download may
      ## require some configuration setup and available as a limited release at this
      ## time. For more information, reach out to your PayPal account
      ## manager.</blockquote>.

  DocumentList* = seq[Document]

  DuplicateTransaction* = ref object of RootObj
    ## The duplicate transaction details.
    received_duplicate*: Option[bool]
      ## If `true`, indicates that a duplicate transaction was received.
    original_transaction*: Option[TransactionInfo]

  EmailAddress* = string

  Error* = ref object of RootObj
    ## The error details.
    name*: string
      ## The human-readable, unique name of the error.
    message*: string
      ## The message that describes the error.
    debug_id*: string
      ## The PayPal internal ID. Used for correlation purposes.
    information_link*: Option[string]
      ## The information link, or URI, that shows detailed information about this error
      ## for the developer.
    details*: Option[ErrorDetailsList]
    links*: Option[LinkDescriptionList]

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

  Escalate* = ref object of RootObj
    ## A merchant request to escalate a dispute, by ID, to a PayPal claim.
    note*: Option[string]
      ## The notes about the escalation of the dispute to a claim.
    buyer_escalation_reason*: Option[BuyerEscalationReason]

  EscalateResponse* = ref object of RootObj
    ## The response for escalate action.
    links*: Option[DefinitionsLinkDescriptionList]

  Evidence* = ref object of RootObj
    ## A merchant- or customer-submitted evidence document. evidence_info is expected
    ## for PROOF_OF_FULFILLMENT,PROOF_OF_REFUND and PROOF_OF_RETURN evidence types.
    ## documents and notes can be given for rest of the evidence types.
    evidence_type*: Option[string]
      ## The evidence type.
    evidence_info*: Option[EvidenceInfo]
    documents*: Option[DefinitionsDocumentList]
    notes*: Option[string]
      ## Any evidence-related notes.
    source*: Option[string]
      ## The source of the evidence.
    date*: Option[DateTime]
    item_id*: Option[string]
      ## The item ID. If the merchant provides multiple pieces of evidence and the
      ## transaction has multiple item IDs, the merchant can use this value to associate
      ## a piece of evidence with an item ID.
    item_type*: Option[ItemType]
    action_info*: Option[ActionInfo]
    dispute_life_cycle_stage*: Option[DisputeLifecycleStage]

  EvidenceInfo* = ref object of RootObj
    ## The evidence-related information.
    tracking_info*: Option[TrackingInfoList]
    refund_ids*: Option[RefundIdsList]

  EvidenceList* = seq[Evidence]

  Extensions* = ref object of RootObj
    ## The extended properties for the dispute. Includes additional information for a
    ## dispute category, such as billing disputes, the original transaction ID, and the
    ## correct amount.
    merchant_contacted*: Option[bool]
      ## Indicates that the merchant was contacted.
    merchant_contacted_outcome*: Option[MerchantContactedOutcome]
    merchant_contacted_time*: Option[DateTime]
    merchant_contacted_mode*: Option[MerchantContactedMode]
    buyer_contacted_time*: Option[DateTime]
    buyer_contacted_channel*: Option[string]
      ## The channel through which the buyer contacted the partner to file a dispute.
      ## Partners that allow buyers to create dispute from multiple channels can use this
      ## field to help identify which channel was used for each individual dispute.
    billing_dispute_properties*: Option[BillingDisputesProperties]
    merchandize_dispute_properties*: Option[MerchandizeDisputeProperties]
    reported_source*: Option[DisputeSource]

  FeePolicy* = ref object of RootObj
    ## Policy that determines whether the fee needs to be charged, retained or returned
    ## while moving the money as part of dispute process.

  FundMovement* = ref object of RootObj
    ## This section contains the details about the fund movement of the parties ,time ,
    ## direction and the reason for it.
    party*: Option[string]
      ## The affected party in the money movement.
    amount*: Option[Money]
    asset*: Option[Cryptocurrency]
    initiated_time*: Option[DateTime]
    `type`*: Option[string]
      ## The type of the money movement.
    reason*: Option[FundMovementReason]

  FundMovementList* = seq[FundMovement]

  FundMovementReason* = enum
    ## The reason for the fund movement.
    REVERSEDTRANSACTIONFEE = "REVERSED_TRANSACTION_FEE"
    DISPUTESETTLEMENT = "DISPUTE_SETTLEMENT"
    DISPUTEFEE = "DISPUTE_FEE"
    CHARGEBACKFEE = "CHARGEBACK_FEE"

  IncorrectTransactionAmount* = ref object of RootObj
    ## The incorrect transaction amount details.
    correct_transaction_amount*: Option[Money]
    correct_transaction_asset*: Option[Cryptocurrency]
    correct_transaction_time*: Option[DateTime]

  ItemAgreedRefundDetails* = ref object of RootObj

  ItemBookingDetails* = ref object of RootObj

  ItemCancellationDetails* = ref object of RootObj

  ItemDigitalDownloadDetails* = ref object of RootObj

  ItemInfo* = ref object of RootObj
    ## The information for a purchased item in a disputed transaction.
    item_id*: Option[string]
      ## The item ID. If the merchant provides multiple pieces of evidence and the
      ## transaction has multiple item IDs, the merchant can use this value to associate
      ## a piece of evidence with an item ID.
    item_name*: Option[string]
      ## The item name.
    item_description*: Option[string]
      ## The item description.
    item_quantity*: Option[string]
      ## The count of the item in the dispute. Must be a whole number.
    partner_transaction_id*: Option[string]
      ## The ID of the transaction in the partner system. The partner transaction ID is
      ## returned at an item level because the partner might show different transactions
      ## for different items in the cart.
    reason*: Option[DisputeReason]
    dispute_amount*: Option[Money]
    notes*: Option[string]
      ## Any notes provided with the item.
    item_type*: Option[ItemType]
    product_details*: Option[ItemProductDetails]
    service_details*: Option[ItemServiceDetails]
    booking_details*: Option[ItemBookingDetails]
    digital_download_details*: Option[ItemDigitalDownloadDetails]
    cancellation_details*: Option[ItemCancellationDetails]
    agreed_refund_details*: Option[ItemAgreedRefundDetails]

  ItemInfoList* = seq[ItemInfo]

  ItemProductDetails* = ref object of RootObj

  ItemServiceDetails* = ref object of RootObj

  ItemType* = enum
    ## The type of the item which has the issue.
    PRODUCT = "PRODUCT"
    SERVICE = "SERVICE"
    BOOKING = "BOOKING"
    DIGITALDOWNLOAD = "DIGITAL_DOWNLOAD"

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

  MakeOffer* = ref object of RootObj
    ## A merchant request to make an offer to resolve a dispute.
    note*: string
      ## The merchant's notes about the offer.
    offer_amount*: Option[Money]
    return_shipping_address*: Option[AddressPortable]
    invoice_id*: Option[string]
      ## The merchant-provided ID of the invoice for the refund. This optional value maps
      ## the refund to an invoice ID in the merchant's system.
    offer_type*: OfferType

  MakeOfferResponseOptions* = ref object of RootObj
    ## The allowed response options when the merchant makes offer to the customer.
    offer_types*: Option[OfferTypeList]

  MerchandizeDisputeProperties* = ref object of RootObj
    ## The customer-provided merchandise issue details for the dispute.
    issue_type*: Option[string]
      ## The issue type.
    product_details*: Option[ProductDetails]
    service_details*: Option[ServiceDetails]
    cancellation_details*: Option[CancellationDetails]
    return_shipping_address*: Option[AddressPortable]

  MerchantContactedMode* = enum
    ## The method used to contact the merchant.
    WEBSITE = "WEBSITE"
    PHONE2 = "PHONE"
    EMAIL2 = "EMAIL"
    WRITTEN = "WRITTEN"
    INPERSON = "IN_PERSON"

  MerchantContactedOutcome* = enum
    ## The outcome when the customer has contacted the merchant.
    NORESPONSE = "NO_RESPONSE"
    FIXED = "FIXED"
    NOTFIXED = "NOT_FIXED"

  Message* = ref object of RootObj
    ## A customer- or merchant-posted message for the dispute.
    posted_by*: Option[string]
      ## Indicates whether the customer, merchant, or dispute arbiter posted the message.
    time_posted*: Option[DateTime]
    content*: Option[string]
      ## The message text.
    documents*: Option[DocumentList]

  MessageList* = seq[Message]

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

  MoneyMovement* = ref object of RootObj
    ## The Money movement details with party.
    affected_party*: Option[string]
      ## The affected party in the money movement.
    amount*: Option[Money]
    asset*: Option[Cryptocurrency]
    initiated_time*: Option[DateTime]
    `type`*: Option[string]
      ## The type of the money movement.
    reason*: Option[MoneyMovementReason]

  MoneyMovementList* = seq[MoneyMovement]

  MoneyMovementReason* = enum
    ## The reason for the money movement.
    DISPUTESETTLEMENTFEE = "DISPUTE_SETTLEMENT_FEE"
    DISPUTESETTLEMENT2 = "DISPUTE_SETTLEMENT"
    DISPUTEFEE2 = "DISPUTE_FEE"
    CHARGEBACKFEE2 = "CHARGEBACK_FEE"

  Offer* = ref object of RootObj
    ## The merchant-proposed offer for a dispute.
    buyer_requested_amount*: Option[Money]
    seller_offered_amount*: Option[Money]
    offer_type*: Option[OfferType]
    history*: Option[OfferHistoryList]

  OfferHistory* = ref object of RootObj
    ## The offer history.
    offer_time*: Option[DateTime]
    actor*: Option[string]
      ## The event-related actor.
    event_type*: Option[string]
      ## The type of the history event.
    offer_type*: Option[OfferType]
    offer_amount*: Option[Money]
    notes*: Option[string]
      ## The user submitted notes.
    dispute_life_cycle_stage*: Option[DisputeLifecycleStage]

  OfferHistoryList* = seq[OfferHistory]

  OfferType* = enum
    ## The merchant-proposed offer type for the dispute.
    REFUND2 = "REFUND"
    REFUNDWITHRETURN2 = "REFUND_WITH_RETURN"
    REFUNDWITHREPLACEMENT = "REFUND_WITH_REPLACEMENT"
    REPLACEMENTWITHOUTREFUND = "REPLACEMENT_WITHOUT_REFUND"

  OfferTypeList* = seq[OfferType]

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

  PaymentByOtherMeans* = ref object of RootObj
    ## The payment by other means details.
    charge_different_from_original*: Option[bool]
      ## If `true`, indicates that a charge was made that is different from the original
      ## charge.
    received_duplicate*: Option[bool]
      ## If `true`, indicates that a duplicate transaction was received.
    payment_method*: Option[string]
      ## The payment method.
    payment_instrument_suffix*: Option[string]
      ## Last 2-4 characters of the payment instrument. For payment_method CHECK,
      ## payment_instrument_suffix entered must be of minimum length 2-4 characters. For
      ## payment_method CREDIT_CARD, DEBIT_CARD, GIFT_CARD, BANK_TRANSFER,
      ## payment_instrument_suffix entered must be of length 4.

  PaymentProcessor* = ref object of RootObj

  ProductDetails* = ref object of RootObj
    ## The product information.
    description*: Option[string]
      ## The product description.
    product_received*: Option[string]
      ## Indicates whether the product was, or was not, received or returned.
    product_received_time*: Option[DateTime]
    expected_delivery_date*: Option[DateTime]
    sub_reasons*: Option[SubReasonsList]
    purchase_url*: Option[string]
      ## The URL where the customer purchased the product.
    return_details*: Option[ReturnDetails]

  RefundDetails* = ref object of RootObj
    ## The refund details.
    allowed_refund_amount*: Option[Money]

  RefundIds* = string

  RefundIdsList* = seq[RefundIds]

  RequireEvidence* = ref object of RootObj
    ## Sandbox only. Updates the state of a dispute, by ID, to either
    ## <code>WAITING_FOR_BUYER_RESPONSE</code> or
    ## <code>WAITING_FOR_SELLER_RESPONSE</code>. This state change enables either the
    ## customer or merchant to submit evidence for the dispute. Specify an
    ## <code>action</code> value in the JSON request body to indicate whether the state
    ## change enables the customer or merchant to submit evidence.
    action*: string
      ## The action. Indicates whether the state change enables the customer or merchant
      ## to submit evidence.

  ReturnDetails* = ref object of RootObj
    ## The return details for the product.
    return_time*: Option[DateTime]
    mode*: Option[string]
      ## The method that the customer used to return the product.
    receipt*: Option[bool]
      ## Indicates whether customer has the return receipt.
    return_confirmation_number*: Option[string]
      ## The confirmation number for the item return.
    returned*: Option[bool]
      ## If `true`, indicates that the item was returned but the seller refused to accept
      ## the return and if `false`, indicates the item was not attempted to return.

  Seller* = ref object of RootObj
    ## The details for the merchant who receives the funds and fulfills the order. For
    ## example, merchant ID, and contact email address.
    email*: Option[EmailAddress]
    merchant_id*: Option[string]
      ## The PayPal account ID for the merchant.
    name*: Option[string]
      ## The name of the merchant.

  ServiceDetails* = ref object of RootObj
    ## The service details.
    description*: Option[string]
      ## The service description.
    service_started*: Option[string]
      ## Indicates whether the service was started or cancelled.
    note*: Option[string]
      ## The customer specified note about the service usage.
    sub_reasons*: Option[DefinitionsSubReasonsList]
    purchase_url*: Option[string]
      ## The URL of the merchant or marketplace site where the customer purchased the
      ## service.

  Status* = enum
    ## The overall status of the dispute, constant for all the parties involved at
    ## anytime during the dispute lifecycle.
    OPEN = "OPEN"
    WAITINGFORBUYERRESPONSE = "WAITING_FOR_BUYER_RESPONSE"
    WAITINGFORSELLERRESPONSE = "WAITING_FOR_SELLER_RESPONSE"
    UNDERREVIEW = "UNDER_REVIEW"
    RESOLVED2 = "RESOLVED"
    OTHER3 = "OTHER"

  SubReasons* = enum
    ## The sub-reason for the product issue.
    DAMAGED3 = "DAMAGED"
    DIFFERENT2 = "DIFFERENT"
    MISSINGPARTS = "MISSING_PARTS"
    OTHER4 = "OTHER"

  SubReasonsList* = seq[SubReasons]

  SubsequentAction* = ref object of RootObj
    ## The subsequent action.
    links*: Option[DefinitionsLinkDescriptionList]

  SupportingInfo* = ref object of RootObj
    ## A merchant- or customer-submitted supporting information.
    notes*: Option[string]
      ## Any supporting notes.
    documents*: Option[SupportingInfoDefinitionsDocumentList]
    source*: Option[string]
      ## The source of the Information.
    provided_time*: Option[DateTime]
    dispute_life_cycle_stage*: Option[DisputeLifecycleStage]

  SupportingInfoDefinitionsDocumentList* = seq[Document]

  SupportingInfoList* = seq[SupportingInfo]

  TrackingInfo* = ref object of RootObj
    ## The tracking information.
    carrier_name*: string
      ## The name of the shipment carrier for the transaction for this dispute.
    carrier_name_other*: Option[string]
      ## The name of carrier in free-form text for unavailable carriers. This field is
      ## mandatory when <code>carrier_name</code> is <code>OTHER</code>.
    tracking_url*: Option[string]
      ## The URL to track the dispute-related transaction shipment.
    tracking_number*: string
      ## The number to track the dispute-related transaction shipment.

  TrackingInfoList* = seq[TrackingInfo]

  TransactionInfo* = ref object of RootObj
    ## The information about the disputed transaction.
    buyer_transaction_id*: Option[string]
      ## The ID, as seen by the customer, for this transaction.
    seller_transaction_id*: Option[string]
      ## The ID, as seen by the merchant, for this transaction.
    reference_id*: Option[string]
      ## The ID, as seen by the partner, for this transaction.
    create_time*: Option[DateTime]
    transaction_status*: Option[string]
      ## The transaction status.
    gross_amount*: Option[Money]
    gross_asset*: Option[Cryptocurrency]
    invoice_number*: Option[string]
      ## The ID of the invoice for the payment.
    custom*: Option[string]
      ## A free-text field that is entered by the merchant during checkout.
    buyer*: Option[Buyer]
    seller*: Option[Seller]
    items*: Option[ItemInfoList]
    payment_processor*: Option[PaymentProcessor]

  TransactionInfoList* = seq[TransactionInfo]
