# paypal_subscriptions

Awesome Nim client

## Installation

```bash
nimble install paypal_subscriptions
```

## Usage

```nim
import paypal_subscriptions

proc main() {.async.} =
  var client = initPaypalSubscriptionsClient("your-api-key")
  let servers = await client.getServers()
  echo servers

waitFor main()
```

## License

MIT
