# paypal_orders

Awesome Nim client

## Installation

```bash
nimble install paypal_orders
```

## Usage

```nim
import paypal_orders

proc main() {.async.} =
  var client = initPaypalOrdersClient("your-api-key")
  let servers = await client.getServers()
  echo servers

waitFor main()
```

## License

MIT
