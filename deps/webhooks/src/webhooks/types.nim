import std/[options, json]

type
  EventList* = ref object of RootObj
    ## A list of webhooks events.
    events*: Option[EventList2]
    count*: Option[int64]
      ## The number of items in each range of results. Note that the response might have
      ## fewer items than the requested `page_size` value.
    links*: Option[LinkDescriptionList]

  EventTypeList* = ref object of RootObj
    ## A list of webhook events.
    event_types*: Option[EventTypeList2]

  WebhookList* = ref object of RootObj
    ## A list of webhooks.
    webhooks*: Option[WebhookList2]

  WebhookLookupList* = ref object of RootObj
    ## A list of webhook lookups.
    webhooks_lookups*: Option[WebhooksLookupList]

  DefinitionsEventTypeList* = seq[EventType]

  DefinitionsLinkDescriptionList* = seq[LinkDescription]

  Error* = ref object of RootObj

  Error2* = ref object of RootObj
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

  ErrorType* = ref object of RootObj
    ## The type of webhook error that occurred.
    id*: Option[string]
      ## The ID for the webhook error type.
    name*: string
      ## The unique error type name.
    description*: Option[string]
      ## A human-readable description of the error type.

  Event* = ref object of RootObj
    ## A webhook event notification.
    id*: Option[string]
      ## The ID of the webhook event notification.
    create_time*: Option[string]
      ## The date and time when the webhook event notification was created, in [Internet
      ## date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
    resource_type*: Option[string]
      ## The name of the resource related to the webhook notification event.
    event_version*: Option[EventVersion]
    event_type*: Option[string]
      ## The event that triggered the webhook event notification.
    summary*: Option[string]
      ## A summary description for the event notification.
    resource_version*: Option[ResourceVersion]
    resource*: Option[Resource]
    links*: Option[LinkDescriptionList]

  EventList2* = seq[Event]

  EventResend* = ref object of RootObj
    ## Resends a webhook event notification, by ID.
    webhook_ids*: Option[WebhookIdsList]

  EventType* = ref object of RootObj
    ## An event type.
    name*: string
      ## The unique event name.<blockquote><strong>Note:</strong> To subscribe to all
      ## events, including events as they are added, specify an `*` as the value to
      ## represent a wildcard.</blockquote>
    description*: Option[string]
      ## A human-readable description of the event.
    status*: Option[string]
      ## The status of a webhook event.
    resource_versions*: Option[ResourceVersionsList]

  EventTypeList2* = seq[EventType]

  EventVersion* = string

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

  Patch* = ref object of RootObj
    ## The JSON patch object to apply partial updates to resources.
    op*: string
      ## The operation.
    path*: Option[string]
      ## The <a href="https://tools.ietf.org/html/rfc6901">JSON Pointer</a> to the target
      ## document location at which to complete the operation.
    value*: Option[JsonNode]
      ## The value to apply. The <code>remove</code> operation does not require a value.
    `from`*: Option[string]
      ## The <a href="https://tools.ietf.org/html/rfc6901">JSON Pointer</a> to the target
      ## document location from which to move the value. Required for the
      ## <code>move</code> operation.

  PatchRequest* = seq[Patch]

  Resource* = ref object of RootObj
    ## The resource that triggered the webhook event notification.

  ResourceVersion* = string

  ResourceVersions* = string

  ResourceVersionsList* = seq[ResourceVersions]

  SimulateEvent* = ref object of RootObj
    ## Simulates a mock webhook event.
    webhook_id*: Option[string]
      ## The ID of the webhook. If omitted, the URL is required.
    url*: Option[string]
      ## The URL for the webhook endpoint. If omitted, the webhook ID is required.
    event_type*: string
      ## The event name. Specify one of the subscribed events. For each request, provide
      ## only one event.
    resource_version*: Option[string]
      ## The identifier for event type ex: 1.0/2.0 etc.

  SwaggerLinkDescription* = LinkDescription

  VerifyWebhookSignature* = ref object of RootObj
    ## A verify webhook signature request.
    auth_algo*: string
      ## The algorithm that PayPal uses to generate the signature and that you can use to
      ## verify the signature. Extract this value from the `PAYPAL-AUTH-ALGO` response
      ## header, which is received with the webhook notification.
    cert_url*: string
      ## The X.509 public key certificate. Download the certificate from this URL and use
      ## it to verify the signature. Extract this value from the `PAYPAL-CERT-URL`
      ## response header, which is received with the webhook notification.
    transmission_id*: string
      ## The ID of the HTTP transmission. Contained in the `PAYPAL-TRANSMISSION-ID`
      ## header of the notification message.
    transmission_sig*: string
      ## The PayPal-generated asymmetric signature. Appears in the
      ## `PAYPAL-TRANSMISSION-SIG` header of the notification message.
    transmission_time*: string
      ## The date and time of the HTTP transmission, in [Internet date and time
      ## format](https://tools.ietf.org/html/rfc3339#section-5.6). Appears in the
      ## `PAYPAL-TRANSMISSION-TIME` header of the notification message.
    webhook_id*: string
      ## The ID of the webhook as configured in your Developer Portal account.
    webhook_event*: Event

  VerifyWebhookSignatureResponse* = ref object of RootObj
    ## The verify webhook signature response.
    verification_status*: string
      ## The status of the signature verification.

  Webhook* = ref object of RootObj
    ## One or more webhook objects.
    id*: Option[string]
      ## The ID of the webhook.
    url*: string
      ## The URL that is configured to listen on `localhost` for incoming `POST`
      ## notification messages that contain event information.
    event_types*: DefinitionsEventTypeList
    links*: Option[DefinitionsLinkDescriptionList]

  WebhookIds* = string

  WebhookIdsList* = seq[WebhookIds]

  WebhookList2* = seq[Webhook]

  WebhooksLookup* = ref object of RootObj
    ## The webhook lookup details.
    id*: Option[string]
      ## The ID of the webhook lookup.
    client_id*: Option[string]
      ## The application client ID.
    links*: Option[DefinitionsLinkDescriptionList]

  WebhooksLookupList* = seq[WebhooksLookup]
