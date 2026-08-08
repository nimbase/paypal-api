# paypal_tracking

Awesome Nim client

## Installation

```bash
nimble install paypal_tracking
```

## Usage

```nim
import paypal_tracking

proc main() {.async.} =
  var client = initPaypalTrackingClient("your-api-key")
  let servers = await client.getServers()
  echo servers

waitFor main()
```

## License

MIT
