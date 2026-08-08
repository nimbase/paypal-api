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
scripts/gen.sh                 # regenerates src/paypal/paypal_*/ + shims
scripts/gen.sh --specs:<dir>   # use a different specs dir
```

Each PayPal API is a module tree nested under `src/paypal/paypal_<api>/`
(e.g. `src/paypal/paypal_orders`, `src/paypal/paypal_catalog`). The main
`paypal` package re-exports them via thin shim modules in `src/paypal/`
(`import paypal/orders`), and `config.nims` (root) auto-adds every inner
package's `src` to the path. `nimble test` runs every nested test suite.

For each spec, `scripts/gen.sh` invokes `nimbase openapi.gen`, which
automatically runs the package's **prescripts** (before) and **postscripts**
(after) — kapsis plugins in `prescripts/` and `postscripts/`:

- **prescripts** — `validate_spec`: pre-generation hook
- **postscripts** — `rename_package` (renames identity to `paypal_<api>` and
  drops the per-client `.nimble`), `fix_enum_collisions`, `rename_client`,
  `fix_type_idents`, `fix_query_defaults`, plus the wiring: `write_shims`,
  `write_paypal_nim`, `write_config`, `write_test_task`

Scripts can also be run manually:

```sh
nimbase prescripts.list / postscripts.list
nimbase postscripts.run <pkg-dir>          # --spec:<path> --dir:<plugins>
```

Docs are generated from the main module (documents every nested module too):

```sh
nim doc --index:on --project --path:. --out:.gh-pages src/paypal.nim
```

### 🎩 License
MIT license | [Made by Humans from OpenPeeps](https://github.com/openpeeps).<br>
Copyright George Lemon & Contributors &mdash; All rights reserved.
