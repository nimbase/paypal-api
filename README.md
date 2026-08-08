<p align="center">
  PayPal REST API clients for Nim
</p>

<p align="center">
  <code>nimble install paypal</code>
</p>

> [!NOTE]
> This package bundles one auto-generated client per PayPal REST API. The clients are generated from the official
> [paypal-rest-api-specifications](https://github.com/paypal/paypal-rest-api-specifications)
> OpenAPI 3.x specs using the [Nimbase](https://github.com/nimbase/nimbase) CLI.

## Modules

Each PayPal API lives in its own module under `src/paypal/`. Import only the
modules you need:

| Module | API |
|---|---|
| `paypal/orders` | Orders |
| `paypal/payments` | Payments |
| `paypal/subscriptions` | Subscriptions |
| `paypal/invoices` | Invoices |
| `paypal/disputes` | Disputes |
| `paypal/payouts` | Payouts |
| `paypal/tracking` | Shipment Tracking |
| `paypal/catalog` | Catalog Products |
| `paypal/webhooks` | Webhooks Management |
| `paypal/reporting` | Transaction Search |
| `paypal/payment_tokens` | Payment Method Tokens |
| `paypal/payment_experience` | Payment Experience |
| `paypal/partner_referrals` | Partner Referrals |

## Usage

```nim
import paypal/orders
import paypal/payments

proc main() {.async.} =
  var client = initOrdersClient()
  client.baseUri = serverPayPalSandboxEnvironment
  client.setTokens("your-access-token")

  # or configure OAuth2 client credentials (client_id, client_secret)
  client.configureOAuth("client-id", "client-secret")

  # endpoint procs follow the <method><path> naming, e.g. POST /v2/checkout/orders
  let order = await client.postV2CheckoutOrders(body)

waitFor main()
```

`init<Api>Client()` takes no arguments; set the bearer token with
`setTokens()` or configure OAuth2 credentials with `configureOAuth()`.
`serverPayPalLiveEnvironment` / `serverPayPalSandboxEnvironment` constants are
exported from each module for switching environments.

## Regeneration

The clients are generated from the OpenAPI specs in `specs/`:

```sh
scripts/gen.sh                 # regenerates src/paypal/ from specs/*.json
scripts/gen.sh --specs:<dir>   # use a different specs dir
```

After each `nimbase openapi.gen` pass, `gen.sh` runs the **afterscript engine**
(`nimbase afterscripts.run <lib> --dir:afterscripts`) which applies
Nim-specific post-generation fixes contributed by the kapsis plugin in
`afterscripts/`:

- `fix_enum_collisions` — dedupes colliding enum field identifiers
- `rename_client` — aligns the generated client type with the lib name
- `fix_type_idents` — renames digit-leading type declarations (e.g. `400`)

### 🎩 License
MIT license | [Made by Humans from OpenPeeps](https://github.com/openpeeps).<br>
Copyright George Lemon & Contributors &mdash; All rights reserved.
