# paypal_catalog

Awesome Nim client

## Installation

```bash
nimble install paypal_catalog
```

## Usage

```nim
import paypal_catalog

proc main() {.async.} =
  var client = initPaypalCatalogClient("your-api-key")
  let servers = await client.getServers()
  echo servers

waitFor main()
```

## License

MIT
