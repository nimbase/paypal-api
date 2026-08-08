# paypal_webhooks

Awesome Nim client

## Installation

```bash
nimble install paypal_webhooks
```

## Usage

```nim
import paypal_webhooks

proc main() {.async.} =
  var client = initPaypalWebhooksClient("your-api-key")
  let servers = await client.getServers()
  echo servers

waitFor main()
```

## License

MIT
