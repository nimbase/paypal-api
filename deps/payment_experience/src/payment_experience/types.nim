import std/[options, json]

type
  Error* = ref object of RootObj
    ## The error information.
    name*: string
      ## The human-readable, unique name of the error.
    debug_id*: Option[string]
      ## The PayPal internal ID. Used for correlation purposes.
    message*: string
      ## The message that describes the error.
    information_link*: string
      ## The URI to detailed information related to this error for the developer.
    details*: Option[ErrorDetailsList]

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
    field*: string
      ## The name of the field that caused the error.
    issue*: string
      ## The reason for the error.

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

  FlowConfig* = ref object of RootObj
    ## The flow configuration parameters.
    landing_page_type*: Option[string]
      ## The type of landing page to display on the PayPal site for user checkout. To use
      ## the non-PayPal account landing page, set to `Billing`. To use the PayPal account
      ## login landing page, set to `Login`.
    bank_txn_pending_url*: Option[string]
      ## The merchant site URL to display after a bank transfer payment_experience. In Germany,
      ## valid only for the Giropay payment method or bank transfer payment method.
    user_action*: Option[string]
      ## Presents either the **Continue** or **Pay Now** checkout flow to the
      ## customer.<br/><br/>Default is **Continue**, or `user_action=continue`. When you
      ## do not know the final payment amount, accept this default flow, which redirects
      ## the customer to the PayPal payment page with the **Continue** button. When the
      ## customer clicks **Continue**, the customer can change the payment
      ## amount.<br/><br/> When you know the final payment amount, set
      ## `user_action=commit` to choose the **Pay Now** flow, which redirects the
      ## customer to the PayPal payment page with the **Pay Now** button. When the
      ## customer clicks **Pay Now**, the payment is processed immediately.
    return_uri_http_method*: Option[string]
      ## The HTTP method to use to redirect the customer to a return URL. Value is `GET`
      ## or `POST`.

  InputFields* = ref object of RootObj
    ## The input field customization parameters.
    no_shipping*: Option[int64]
      ## Indicates whether PayPal displays shipping address fields on the experience
      ## pages. Value is:<ul><li><code>0</code>. Displays the shipping address on the
      ## PayPal pages.</li><li><code>1</code>. Redacts shipping address fields from the
      ## PayPal pages. For digital goods, this field is required and must be
      ## <code>1</code>.</li><li><code>2</code>. Gets the shipping address from the
      ## customer's account profile.</li></ul>
    address_override*: Option[int64]
      ## Indicates whether to display the shipping address that is passed to this call
      ## rather than the one on file for this buyer on the PayPal experience pages. Value
      ## is:<ul><li><code>0</code>. Displays the shipping address on
      ## file.</li><li><code>1</code>. Displays the shipping address specified in this
      ## call. the customer cannot edit this shipping address.</li></ul>

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

  Presentation* = ref object of RootObj
    ## The style and presentation parameters.
    brand_name*: Option[string]
      ## A label that overrides the business name in the PayPal account on the PayPal
      ## pages. Character length and limitations: 127 single-byte alphanumeric
      ## characters.
    logo_image*: Option[string]
      ## A URL to the logo image. A valid media type is `.gif`, `.jpg`, or `.png`. The
      ## image's maximum width is 190 pixels and maximum height is 60 pixels. PayPal
      ## crops images that are larger. PayPal places your logo image at the top of the
      ## cart review area. PayPal recommends that you store the image on a secure (HTTPS)
      ## server. Otherwise, web browsers display a message that checkout pages contain
      ## non-secure items. Character length and limitations: 127 single-byte alphanumeric
      ## characters.
    locale_code*: Option[string]
      ## The locale of pages that the PayPal payment experience displays. A valid value
      ## is `AU`, `AT`, `BE`, `BR`, `CA`, `CH`, `CN`, `DE`, `ES`, `GB`, `FR`, `IT`, `NL`,
      ## `PL`, `PT`, `RU`, or `US`. A 5-character code is also valid for languages in
      ## these countries: `da_DK`, `he_IL`, `id_ID`, `ja_JP`, `no_NO`, `pt_BR`, `ru_RU`,
      ## `sv_SE`, `th_TH`, `zh_CN`, `zh_HK`, or `zh_TW`.

  WebProfile* = ref object of RootObj
    ## A payment web experience profile.
    id*: Option[string]
      ## The ID of the web experience profile.
    name*: string
      ## The web experience profile name. Must be unique for a set of profiles for a
      ## merchant.
    temporary*: Option[bool]
      ## Indicates whether the profile persists for three hours or permanently. To
      ## persist the profile permanently, set to `false`. To persist the profile for
      ## three hours, set to `true`.
    flow_config*: Option[FlowConfig]
    input_fields*: Option[InputFields]
    presentation*: Option[Presentation]

  WebProfileList* = seq[WebProfile]
