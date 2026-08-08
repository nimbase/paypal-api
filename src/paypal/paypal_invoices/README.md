# paypal_invoices

Awesome Nim client

## Installation

```bash
nimble install paypal_invoices
```

## Usage

```nim
import paypal_invoices

proc main() {.async.} =
  var client = initPaypalInvoicesClient("your-api-key")
  let servers = await client.getServers()
  echo servers

waitFor main()
```

## License

MIT
