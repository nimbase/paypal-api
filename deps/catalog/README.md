# catalog

Awesome Nim client

## Installation

```bash
nimble install catalog
```

## Usage

```nim
import catalog

proc main() {.async.} =
  var client = initCatalogClient("your-api-key")
  let servers = await client.getServers()
  echo servers

waitFor main()
```

## License

MIT
