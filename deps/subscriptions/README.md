# subscriptions

Awesome Nim client

## Installation

```bash
nimble install subscriptions
```

## Usage

```nim
import subscriptions

proc main() {.async.} =
  var client = initSubscriptionsClient("your-api-key")
  let servers = await client.getServers()
  echo servers

waitFor main()
```

## License

MIT
