# paypal_reporting

Awesome Nim client

## Installation

```bash
nimble install paypal_reporting
```

## Usage

```nim
import paypal_reporting

proc main() {.async.} =
  var client = initPaypalReportingClient("your-api-key")
  let servers = await client.getServers()
  echo servers

waitFor main()
```

## License

MIT
