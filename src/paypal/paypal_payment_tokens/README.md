# paypal_payment_tokens

Awesome Nim client

## Installation

```bash
nimble install paypal_payment_tokens
```

## Usage

```nim
import paypal_payment_tokens

proc main() {.async.} =
  var client = initPaypalPaymentTokensClient("your-api-key")
  let servers = await client.getServers()
  echo servers

waitFor main()
```

## License

MIT
