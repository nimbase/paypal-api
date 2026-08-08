# payments

Awesome Nim client

## Installation

```bash
nimble install payments
```

## Usage

```nim
import payments

proc main() {.async.} =
  var client = initPaymentsClient("your-api-key")
  let servers = await client.getServers()
  echo servers

waitFor main()
```

## License

MIT
