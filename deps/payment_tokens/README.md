# payment

Awesome Nim client

## Installation

```bash
nimble install payment
```

## Usage

```nim
import payment

proc main() {.async.} =
  var client = initPaymentClient("your-api-key")
  let servers = await client.getServers()
  echo servers

waitFor main()
```

## License

MIT
