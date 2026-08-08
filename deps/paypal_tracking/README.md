# shipment

Awesome Nim client

## Installation

```bash
nimble install shipment
```

## Usage

```nim
import shipment

proc main() {.async.} =
  var client = initShipmentClient("your-api-key")
  let servers = await client.getServers()
  echo servers

waitFor main()
```

## License

MIT
