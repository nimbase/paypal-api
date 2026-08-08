# orders

Awesome Nim client

## Installation

```bash
nimble install orders
```

## Usage

```nim
import orders

proc main() {.async.} =
  var client = initOrdersClient("your-api-key")
  let servers = await client.getServers()
  echo servers

waitFor main()
```

## License

MIT
