# payouts

Awesome Nim client

## Installation

```bash
nimble install payouts
```

## Usage

```nim
import payouts

proc main() {.async.} =
  var client = initPayoutsClient("your-api-key")
  let servers = await client.getServers()
  echo servers

waitFor main()
```

## License

MIT
