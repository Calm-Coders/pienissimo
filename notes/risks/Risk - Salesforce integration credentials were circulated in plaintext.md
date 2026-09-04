---
id: RISK-credentials-in-plaintext
type: risk
status: open
severity: gating
owner: Aurel Mrruku
with: Anita Aga
org: ROMI
raised: 2026-09-04
updated: 2026-09-04
depends_on: [OI-102]
blocks: [go-live]
requirement: INT-16
source: Gmail thread 1a06ccdecfdcba44 and Slack DM D0BKK1D5GF9, both 2026-09-04
---

# Risk - Salesforce integration credentials were circulated in plaintext

**A Postman collection carrying two working Salesforce credentials for the
Pienissimo UAT org was sent by email and posted to Slack on 4 September 2026.**

**Nothing is reproduced here.** This note records that it happened, where, and
what should follow — per
[docs/publishing.md](../../docs/publishing.md).

## What was circulated

Anita Aga → Aurel Mrruku, three deliveries the same afternoon:

| When (CEST)  | Where                            | What                                             |
| ------------ | -------------------------------- | ------------------------------------------------ |
| 16:23        | Gmail, subject _"Pienissimo Assertion"_ | `Pienissimo.postman_collection1`, attached |
| 16:37        | Gmail, same thread               | the same request pasted inline as a **cURL**     |
| 17:08        | Slack DM                         | `Pienissimo.postman_collection.json`, 6.3 KB     |

The collection holds two requests. Between them they carry:

1. **A signed JWT bearer assertion** for the OAuth 2.0 JWT flow against
   `test.salesforce.com`, issued for a named Pienissimo UAT integration user.
2. **A live Salesforce access token** for the UAT sandbox, used as the bearer on
   the WooCommerce endpoint request.

## 🔴 Why this is gating rather than untidy

**The assertion does not expire in any useful sense.** Its `exp` claim is set
roughly **sixty years out**. A JWT bearer assertion is not a password — it is a
pre-signed authorisation that the token endpoint will exchange for a live session
**on presentation, by anyone holding it**, for as long as the connected app
exists and the user is active. Its practical value is therefore the same as a
permanent credential for that user, and it has now been distributed across two
systems, one of which (Gmail) is outside ROMI's own workspace boundary in the
sense that a forward costs one click.

**The access token is separately live.** It grants API access to the org the
whole project is being built in — the same org where
[the community pages have no application-level authentication](Risk%20-%20the%20community%20pages%20have%20no%20application-level%20authentication.md)
and where the customer registry will hold real VAT numbers, codici fiscali,
IBANs and PEC addresses.

⚠ **This is a sandbox, and that is the mitigating fact — not an excuse.** UAT
holds live-shaped customer records today (the data-model workbook is populated
with real companies and named individuals), and the same pattern applied to
production is a breach rather than a lapse. Production is now closer than it was:
`pienissimo.my.salesforce.com` was provisioned on 3 September.

## What should happen

- **Rotate both.** Revoke the access token and reissue the connected app's
  certificate, or at minimum reissue the assertion with a real expiry.
- **Do not carry this pattern to production.** The production credential must not
  travel by mail or chat at all.
- **Give the assertion a realistic `exp`.** Minutes, not decades — the flow is
  designed for short-lived assertions minted per request.
- **Decide where the integration credential lives.** Named credentials are the
  Salesforce answer, and this project already has
  [two that exist only in the org](Risk%20-%20integration%20credentials%20exist%20only%20in%20the%20org.md).

## What the same collection tells us that is good news

🟢 **It answers a question the record has been carrying as a worry.** The
authentication for the inbound WooCommerce route is **platform OAuth** — a JWT
bearer exchange yielding a session token in the `Authorization` header — not the
static shared secret that
[OI-102](../items/OI-102%20Salesforce%20endpoint%20and%20token%20for%20the%20WooCommerce%20plugin.md)
and `INT-16` feared. That is the stronger of the two designs.

⚠ **It does not close `INT-16`.** The recorded finding is that
`WoocommerceOrderService` performs no token or signature check of its own; the
platform authenticating the session is a different guarantee from the class
verifying who is calling it, and **that check should be made against the org, not
inferred from a Postman file.** Leave `INT-16` open until an
`org-status-check` settles it.
