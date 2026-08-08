# paypal_payment_experience

Awesome Nim client

## Installation

```bash
nimble install paypal_payment_experience
```

## Usage

```nim
import paypal_payment_experience

proc main() {.async.} =
  var client = initPaypalPaymentExperienceClient("your-api-key")
  let servers = await client.getServers()
  echo servers

waitFor main()
```

## License

MIT
