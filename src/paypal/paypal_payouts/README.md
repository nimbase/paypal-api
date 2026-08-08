# paypal_payouts

Awesome Nim client

## Installation

```bash
nimble install paypal_payouts
```

## Usage

```nim
import paypal_payouts

proc main() {.async.} =
  var client = initPaypalPayoutsClient("your-api-key")
  let servers = await client.getServers()
  echo servers

waitFor main()
```

## License

MIT
