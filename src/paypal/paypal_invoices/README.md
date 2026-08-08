# invoices

Awesome Nim client

## Installation

```bash
nimble install invoices
```

## Usage

```nim
import invoices

proc main() {.async.} =
  var client = initInvoicesClient("your-api-key")
  let servers = await client.getServers()
  echo servers

waitFor main()
```

## License

MIT
