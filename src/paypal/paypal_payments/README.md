# paypal_payments

Awesome Nim client

## Installation

```bash
nimble install paypal_payments
```

## Usage

```nim
import paypal_payments

proc main() {.async.} =
  var client = initPaypalPaymentsClient("your-api-key")
  let servers = await client.getServers()
  echo servers

waitFor main()
```

## License

MIT
