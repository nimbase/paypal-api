# partner

Awesome Nim client

## Installation

```bash
nimble install partner
```

## Usage

```nim
import partner

proc main() {.async.} =
  var client = initPartnerClient("your-api-key")
  let servers = await client.getServers()
  echo servers

waitFor main()
```

## License

MIT
