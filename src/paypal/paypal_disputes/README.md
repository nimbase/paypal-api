# paypal_disputes

Awesome Nim client

## Installation

```bash
nimble install paypal_disputes
```

## Usage

```nim
import paypal_disputes

proc main() {.async.} =
  var client = initPaypalDisputesClient("your-api-key")
  let servers = await client.getServers()
  echo servers

waitFor main()
```

## License

MIT
