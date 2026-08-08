import std/[options, json]

type
  AlternateNotificationMethod* = ref object of RootObj
    ## Captures additional notification modes to reach out to the receiver regarding
    ## this payment.
    phone*: Option[Phone]

  ApplicationContext* = ref object of RootObj
    ## Metadata for Venmo transactions.
    social_feed_privacy*: Option[string]
      ## This attribute controls the privacy of a payout transaction in recipient’s feed.
      ## PUBLIC, FRIENDS_ONLY & PRIVATE are the values that can be used. PUBLIC - The
      ## payment displays on the recipient's public Venmo feed. FRIENDS_ONLY - The
      ## payment displays only to the recipient's Venmo friends. PRIVATE - The payment
      ## displays only on the recipient's personal feed. Defaults to `PRIVATE` if left
      ## blank.
    holler_url*: Option[string]
      ## Link to a Holler sticker. For Venmo recipients, the sticker displays with the
      ## payout message. The maximum URL length is 151.
    logo_url*: Option[string]
      ## Link to a logo that displays as the sender's profile image in the recipient's
      ## Venmo feed. Used to add or update the business profile image. Max image size:
      ## 1024 x 1024 pixels. The image should be square and maximum URL length is 2000.

  BatchEnum* = enum
    ## The payouts status.
    DENIED = "DENIED"
    PENDING = "PENDING"
    PROCESSING = "PROCESSING"
    SUCCESS = "SUCCESS"
    CANCELED = "CANCELED"

  CreatePayoutRequest* = ref object of RootObj
    ## The create payout request.
    sender_batch_header*: SenderBatchHeader
    items*: PayoutItemRequestList

  Currency* = ref object of RootObj
    ## The currency and amount for a financial transaction, such as a balance or
    ## payment due.
    currency*: string
      ## The [three-character ISO-4217 currency
      ## code](/docs/integration/direct/rest/currency-codes/).
    value*: string
      ## The value, which might be:<ul><li>An integer for currencies like `JPY` that are
      ## not typically fractional.</li><li>A decimal fraction for currencies like `TND`
      ## that are subdivided into thousandths.</li></ul>For the required number of
      ## decimal places for a currency code, see [Currency codes - ISO
      ## 4217](https://www.iso.org/iso-4217-currency-codes.html).

  DefinitionsLinkDescriptionList* = seq[LinkDescription]

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

  FundingSource* = enum
    ## Identifies a funding source type.
    BALANCE = "BALANCE"

  Language* = string

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

  Payout* = ref object of RootObj
    ## The create payout response.
    batch_header*: Option[PayoutHeader]
    links*: Option[DefinitionsLinkDescriptionList]

  PayoutBatch* = ref object of RootObj
    ## The PayPal-generated batch status.
    total_items*: Option[int64]
      ## The total number of items in the full result list.
    total_pages*: Option[int64]
      ## The total number of pages.
    batch_header*: Option[PayoutBatchHeader]
    items*: Option[PayoutBatchItemsList]
    links*: Option[PayoutBatchDefinitionsLinkDescriptionList]

  PayoutBatchDefinitionsLinkDescriptionList* = seq[LinkDescription]

  PayoutBatchHeader* = ref object of RootObj
    ## The payout header that is returned in response to a payout header request. Shows
    ## details for an entire payout request.
    payout_batch_id*: string
      ## The PayPal-generated ID for a payout.
    batch_status*: BatchEnum
    time_created*: Option[string]
      ## The date and time when processing for the payout began, in [Internet date and
      ## time format](https://tools.ietf.org/html/rfc3339#section-5.6).
    time_completed*: Option[string]
      ## The date and time when processing for the payout was completed, in [Internet
      ## date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
    time_closed*: Option[string]
      ## The date and time when the payout was closed, in [Internet date and time
      ## format](https://tools.ietf.org/html/rfc3339#section-5.6). A payout is considered
      ## closed when all items in a batch are processed and the available balance from
      ## the temporary hold is released.
    sender_batch_header*: PayoutSenderBatchHeader
    funding_source*: Option[FundingSource]
    amount*: Option[Currency]
    fees*: Option[Currency]

  PayoutBatchItems* = ref object of RootObj
    ## The payout item status and other details.
    payout_item_id*: string
      ## The ID for the payout item. Viewable when you show details for a payout.
    transaction_id*: Option[string]
      ## The PayPal-generated ID for the transaction.
    activity_id*: Option[string]
      ## The unique PayPal-generated common ID created to link sender side and receiver
      ## side transaction. Used for tracking.
    transaction_status*: Option[TransactionEnum]
    payout_item_fee*: Option[Currency]
    payout_batch_id*: string
      ## The PayPal-generated ID for the payout.
    payout_item*: PayoutItemDetail
    currency_conversion*: Option[PayoutCurrencyConversion]
    time_processed*: Option[string]
      ## The date and time when this item was last processed, in [Internet date and time
      ## format](https://tools.ietf.org/html/rfc3339#section-5.6).
    errors*: Option[Error]
    links*: Option[PayoutBatchItemsDefinitionsLinkDescriptionList]

  PayoutBatchItemsDefinitionsLinkDescriptionList* = seq[LinkDescription]

  PayoutBatchItemsList* = seq[PayoutBatchItems]

  PayoutCurrencyConversion* = ref object of RootObj
    ## The currency conversion resource.
    from_amount*: Option[Currency]
    to_amount*: Option[Currency]
    exchange_rate*: Option[string]
      ## The exchange rate that is applied for this payout.

  PayoutHeader* = ref object of RootObj
    ## The payout header that is returned in response to a payout header request. Shows
    ## details for an entire payout request.
    payout_batch_id*: string
      ## The PayPal-generated ID for a payout.
    batch_status*: BatchEnum
    time_created*: Option[string]
      ## The date and time when processing for the payout began, in [Internet date and
      ## time format](https://tools.ietf.org/html/rfc3339#section-5.6).
    sender_batch_header*: PayoutSenderBatchHeader

  PayoutItem* = ref object of RootObj
    ## The payout item status and other details. A <code>payout_item_id</code> helps
    ## you identify denied payments. If a payment is denied, you can use the
    ## <code>payout_item_id</code> to identify the payment even if it lacks a
    ## <code>transaction_id</code>.
    payout_item_id*: string
      ## The ID for the payout item. Visible when you show details for a payout.
    transaction_id*: Option[string]
      ## The PayPal-generated ID for the transaction.
    activity_id*: Option[string]
      ## The unique PayPal-generated common ID that links the sender- and receiver-side
      ## transactions. Used for tracking.
    transaction_status*: Option[TransactionEnum]
    payout_item_fee*: Option[Currency]
    payout_batch_id*: string
      ## The PayPal-generated ID for the payout batch.
    sender_batch_id*: Option[string]
      ## A sender-specified ID. Tracks the payout in an accounting system. Should be
      ## unique within 30 days.
    payout_item*: PayoutItemDetail
    currency_conversion*: Option[PayoutCurrencyConversion]
    time_processed*: Option[string]
      ## The date and time when this item was last processed, in [Internet date and time
      ## format](https://tools.ietf.org/html/rfc3339#section-5.6).
    errors*: Option[Error]
    links*: Option[PayoutItemDefinitionsLinkDescriptionList]

  PayoutItemDefinitionsLinkDescriptionList* = seq[LinkDescription]

  PayoutItemDetail* = ref object of RootObj
    ## The details for a sender-created payout to a single recipient.
    recipient_type*: Option[RecipientEnum]
    amount*: Currency
    note*: Option[string]
      ## The sender-specified note for notifications. Supports up to 4000 ASCII
      ## characters and 1000 non-ASCII characters.
    receiver*: string
      ## The receiver of the payment. Corresponds to the `recipient_type` value in the
      ## request.
    sender_item_id*: Option[string]
      ## A sender-specified ID number. Tracks the payout in an accounting system.
    recipient_name*: Option[Name]
    recipient_wallet*: Option[RecipientWalletEnum]
    purpose*: Option[PurposeEnum]

  PayoutItemRequest* = ref object of RootObj
    ## The sender-created payout to a recipient.
    recipient_type*: Option[string]
      ## The recipient type. Value is:<ul><li><p><code>EMAIL</code>. The unencrypted
      ## email. Value is a string of up to 127 single-byte
      ## characters.</p></li><li><p><code>PHONE</code>. The unencrypted phone
      ## number.</p><blockquote><strong>Note:</strong> The PayPal sandbox does not
      ## support the <code>PHONE</code> recipient
      ## type.</blockquote></li><li><p><code>PAYPAL_ID</code>. The encrypted PayPal
      ## account number.</p></li><li><p><code>USER_HANDLE</code>. User handle (or)
      ## Username associated with Venmo account.</p></li></ul><br/>If the
      ## <code>sender_batch_header</code> includes the <code>recipient_type</code>
      ## attribute, payout items use the <code>recipient_type</code> of the
      ## <code>sender_batch_header</code>, unless a payout item has its own
      ## <code>recipient_type</code> attribute. If the <code>sender_batch_header</code>
      ## omits the <code>recipient_type</code> attribute, each payout item must include
      ## its own <code>recipient_type</code> value.
    amount*: Currency
    note*: Option[string]
      ## The sender-specified note for notifications. Supports up to 4000 ASCII
      ## characters and 1000 non-ASCII characters.
    receiver*: string
      ## The receiver of the payment. Corresponds to the `recipient_type` value in the
      ## request. Max value of up to 127 single-byte characters.
    sender_item_id*: Option[string]
      ## The sender-specified ID number. Tracks the payout in an accounting system.
    recipient_wallet*: Option[string]
      ## The recipient wallet.
    alternate_notification_method*: Option[AlternateNotificationMethod]
    notification_language*: Option[Language]
    application_context*: Option[ApplicationContext]
    purpose*: Option[PurposeEnum]

  PayoutItemRequestList* = seq[PayoutItemRequest]

  PayoutSenderBatchHeader* = ref object of RootObj
    ## The sender-provided header for a payout request.
    sender_batch_id*: Option[string]
      ## The sender-specified ID number. Tracks the payout in an accounting
      ## system.<blockquote><strong>Note:</strong> <p>PayPal does not process duplicate
      ## paypal_payouts. If you specify a <code>sender_batch_id</code> that was used in the last
      ## 30 days, the API rejects the request with an error message that shows the
      ## duplicate <code>sender_batch_id</code> and includes a HATEOAS link to the
      ## original payout with the same <code>sender_batch_id</code>.</p><p>If you receive
      ## an HTTP <code>5<i>nn</i></code> status code, you can safely retry the request
      ## with the same <code>sender_batch_id</code>. The API completes a payment only
      ## once for a <code>sender_batch_id</code> that is used within 30
      ## days.</p></blockquote>
    recipient_type*: Option[RecipientEnum]
    email_subject*: Option[string]
      ## The subject line for the email that PayPal sends when payment for a payout item
      ## completes. The subject line is the same for all recipients. Value is an
      ## alphanumeric string with a maximum length of 255 single-byte characters.
    email_message*: Option[string]
      ## The email message that PayPal sends when the payout item completes. The message
      ## is the same for all recipients.

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

  PurposeEnum* = enum
    ## The purpose of the transaction.
    AWARDS = "AWARDS"
    PRIZES = "PRIZES"
    DONATIONS = "DONATIONS"
    GOODS = "GOODS"
    SERVICES = "SERVICES"
    REBATES = "REBATES"
    CASHBACK = "CASHBACK"
    DISCOUNTS = "DISCOUNTS"
    NONGOODSORSERVICES = "NON_GOODS_OR_SERVICES"

  RecipientEnum* = enum
    ## The ID type that identifies the payment receiver.
    EMAIL = "EMAIL"
    PHONE2 = "PHONE"
    PAYPALID = "PAYPAL_ID"

  RecipientWalletEnum* = enum
    ## The wallet where the recipient receives the payout. Payouts to Venmo recipients
    ## require a 'note' string and a US mobile phone number.
    PAYPAL = "PAYPAL"
    VENMO = "VENMO"

  SenderBatchHeader* = ref object of RootObj
    ## The sender-provided payout header for a payout request.
    sender_batch_id*: Option[string]
      ## A sender-specified ID number. Tracks the payout in an accounting
      ## system.<blockquote><strong>Note:</strong> <p>PayPal does not process duplicate
      ## paypal_payouts. If you specify a <code>sender_batch_id</code> that was used in the last
      ## 30 days, the API rejects the request with an error message that shows the
      ## duplicate <code>sender_batch_id</code> and includes a HATEOAS link to the
      ## original payout with the same <code>sender_batch_id</code>.</p><p>If you receive
      ## an HTTP <code>5<i>nn</i></code> status code, you can safely retry the request
      ## with the same <code>sender_batch_id</code>. The API completes a payment only
      ## once for a <code>sender_batch_id</code> that is used within 30
      ## days.</p></blockquote>
    recipient_type*: Option[string]
      ## The ID type that identifies the recipient of the payment. For example,
      ## <code>EMAIL</code>.
    email_subject*: Option[string]
      ## The subject line for the email that PayPal sends when payment for a payout item
      ## completes. The subject line is the same for all recipients. Value is an
      ## alphanumeric string of up to 255 single-byte characters.
    email_message*: Option[string]
      ## The email message that PayPal sends when the payout item completes. The message
      ## is the same for all recipients.
    note*: Option[string]
      ## The payouts and item-level notes are concatenated in the email. The maximum
      ## combined length of the notes is 1000 characters.

  TransactionEnum* = enum
    ## The item transaction status.<blockquote><strong>Note:</strong> For
    ## <code>POST/v1/payments/payouts-item/{payout_item_id}/cancel</code>, the only
    ## possible <code>transaction_status</code> value is
    ## <code>RETURNED</code>.</blockquote>
    SUCCESS2 = "SUCCESS"
    FAILED = "FAILED"
    PENDING2 = "PENDING"
    UNCLAIMED = "UNCLAIMED"
    RETURNED = "RETURNED"
    ONHOLD = "ONHOLD"
    BLOCKED = "BLOCKED"
    REFUNDED = "REFUNDED"
    REVERSED = "REVERSED"
