# webhooks

Awesome Nim client

## Installation

```bash
nimble install webhooks
```

## Usage

```nim
import webhooks

proc main() {.async.} =
  var client = initWebhooksClient("your-api-key")
  let servers = await client.getServers()
  echo servers

waitFor main()
```

## License

MIT
