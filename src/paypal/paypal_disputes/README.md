# disputes

Awesome Nim client

## Installation

```bash
nimble install disputes
```

## Usage

```nim
import disputes

proc main() {.async.} =
  var client = initDisputesClient("your-api-key")
  let servers = await client.getServers()
  echo servers

waitFor main()
```

## License

MIT
