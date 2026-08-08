# transaction

Awesome Nim client

## Installation

```bash
nimble install transaction
```

## Usage

```nim
import transaction

proc main() {.async.} =
  var client = initTransactionClient("your-api-key")
  let servers = await client.getServers()
  echo servers

waitFor main()
```

## License

MIT
