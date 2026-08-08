# paypal_partner_referrals

Awesome Nim client

## Installation

```bash
nimble install paypal_partner_referrals
```

## Usage

```nim
import paypal_partner_referrals

proc main() {.async.} =
  var client = initPaypalPartnerReferralsClient("your-api-key")
  let servers = await client.getServers()
  echo servers

waitFor main()
```

## License

MIT
