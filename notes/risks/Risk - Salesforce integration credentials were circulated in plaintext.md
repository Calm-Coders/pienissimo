---
id: RISK-credentials-in-plaintext
type: risk
status: open
severity: gating
owner: Aurel Mrruku
with: Anita Aga
org: ROMI
raised: 2026-09-04
updated: 2026-09-10
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

## 2026-09-10 - the pattern repeats, this time with the Mexal WEBAPI credential

**`Mexal Dev v.2.postman_collection`**, 32.7 KB, sent by **Aurel Mrruku to Anita
Aga in a Slack direct message at 14:45:51 CEST on 10 September**.

**All fourteen requests in it carry a live `Authorization` header for the
Passepartout WEBAPI** — the basic-auth style credential recorded on 7 September
as _"a base64 encoding of user then password"_ — alongside the `Dominio` and the
`Coordinate-Gestionale` header. The same value is repeated verbatim in every
request, and again in a second, disabled header on each.

⚠ **The value is not in this repository and must never be.** What is recorded is
that it exists, what kind of credential it is, where it was sent, by whom, to
whom, and when.

**This is the third circulation of a project credential in plaintext chat or mail
in seven days**, after the WooCommerce JWT assertion and client secret (04/09,
mail and Slack DM) and the UAT sandbox password spoken aloud into a Gemini
transcript (08/09,
[that risk](Risk%20-%20a%20sandbox%20password%20was%20spoken%20aloud%20and%20preserved%20in%20a%20meeting%20transcript.md)).
Three different secrets, three different channels, three different people. **The
common factor is that the project has no agreed place to put one.**

### What is different, and better, this time

🟢 **The code written from it does the right thing.** Three hours later
`MexalSearchCalloutService` was committed
([the build](../objects/The%20first%20Mexal%20integration%20Apex.md)) and it takes
the credential **through a Named Credential** — `callout:Mexal<path>`, chosen
sandbox-vs-production — and writes the log line as
`Authorization=<managed by Named Credential>`. **The secret is deliberately kept
out of `Integration_Log__c`.** That is the first integration in this project
built the way this risk has been asking for.

🔴 **So the credential should not have needed to travel at all**, and it is a
Slack DM that now holds it indefinitely, in a workspace with unbounded retention
and search.

### The ask, unchanged in kind

- **Rotate the Passepartout WEBAPI credential** once the named credential is
  configured, and do not circulate the replacement in chat.
- **Configure the `Mexal` named credential and external credential**, and get
  them into `force-app/` — a permission set that ships now references
  `Mexal_External_Credential-Mexal_Principal`, which exists in no repository file
  ([the org-only risk](Risk%20-%20integration%20credentials%20exist%20only%20in%20the%20org.md)).
- **Agree one place a secret may live.** Three instances in seven days is a
  process gap, not three mistakes.
