---
id: OI-106
type: open-item
status: open
owner: Aurel Mrruku
with: Andrea Parmeggiani
org: both
raised: 2026-09-01
updated: 2026-09-01
depends_on: [OI-94]
blocks: [OI-73]
requirement: INT-18
source: notes/The Anticipay middleware API contract.md
---

# OI-106 - One static bearer token serves both Anticipay environments

The middleware authenticates with **a single static bearer token in the
`Authorization` header**. The documentation prints a working token value inline,
and the `:env` parameter added on 1 September does **not** come with a second
one.

So, as documented:

- **one host** — `integration.pienissimo.com`
- **one token** — the same string for `env=test` and `env=prod`
- **no rotation, no expiry, no scope** described anywhere

**The token value is not recorded in this repository**, deliberately, and must
not be. It belongs in `Integration_Configuration__c.Token__c` in the org — see
[the publishing rules](../../docs/publishing.md) and
[the contract](../The%20Anticipay%20middleware%20API%20contract.md).

## Why this is an item and not a shrug

**1. The test environment turned out to be a path parameter.** The 25 August
session recorded an outstanding action on Pienissimo Software: _"stand up the
test environment ROMI points at"_ — the one Gemini mis-assigned to Aurel Mrruku
and he corrected on Slack the same afternoon. What arrived is `env=test` **on the
production host, behind the production token**, sharing the production database.
That may well be fine for a cache-read lookup. But it is not what "dedicated test
environment" normally means, and **nobody has said out loud that the action is
now closed**. Close it explicitly or restate what is still wanted.

**2. A test credential leak is a production credential leak.** With one token
there is no blast radius. Anyone who gets the token from a ROMI sandbox, a debug
log, a screenshot or a developer laptop can call `env=prod` — which, after
Pienissimo Software flips the switch, **spends money at Anticipay per lookup**.
Cost control was Andrea Parmeggiani's own founding argument for the middleware
([OI-94](OI-94%20Anticipay%20is%20called%20through%20the%20Pienissimo%20middleware.md)).

**3. It was distributed by mail, to six addresses, twice.** Thread
`1a0589a4a85b5bdf` went to Aurel Mrruku, cc Elena Spini,
`amministrazione@pienissimo.com`, Fabrizio Paganelli and Sabatino Rinaldi — on
**31 August** and again on **1 September**. That includes **a shared mailbox**
whose readership nobody has enumerated, and **Sabatino Rinaldi**, who is the
WooCommerce plugin developer and has no role in this integration. The token now
sits in at least six mailboxes and in a PDF in a Downloads folder.

⚠ **Nobody did anything wrong here.** Mailing a token is ordinary practice and
Andrea Parmeggiani described the auth as deliberately simple on 25 August, which
everyone accepted. The point is only that **the token should now be treated as
already disclosed** when deciding whether to rotate it before go-live.

**4. `401` is a new error code and it lands in the same bucket as a bad VAT
number.** The documented errors now include `401 token missing or invalid`,
which the 25 August protocol never contemplated. Under the agreed design any
error is stored and raises an _internal notification_. So **a rotated or revoked
token looks exactly like a run of unknown companies** — a whole-integration
outage presenting as routine data noise. See
[OI-107](OI-107%20The%20Anticipay%20error%20path%20does%20not%20reach%20the%20integration%20log%20intact.md).

## The ask

For **Andrea Parmeggiani**, at the 1 September call:

- Is there a **separate token for `env=test`**, or is one string genuinely
  intended for both? If one, will a second be issued?
- **Does the token expire or rotate**, and who is told when it does?
- Can the token that was mailed be **rotated before go-live**, on the assumption
  that a value mailed to six addresses is public?

For **Aurel Mrruku**:

- Decide whether `env=test` on the production host **discharges** the test
  environment action from 25 August, and say so in writing either way.
- Distinguish `401` from the data errors in whatever notification the error store
  raises — do not let an auth failure page the same channel as a missing company.

## 2026-09-01 - asked and answered: one token, on purpose

**The first question in "The ask" above was put to Andrea Parmeggiani in the
[1 September call](../meetings/2026-09-01%20Follow-up%20Integrazione%20Anticipay.md)
and answered.**

> **Aurel Mrruku:** _"ma si può usare anche lo stesso token perché praticamente
> l'ambiente è lo stesso?"_
> **Andrea Parmeggiani:** _"sì, sì."_

Then, agreeing the split: _"facciamo due path diversi… due endpoint diversi"_ —
**two paths, one token**, which is exactly what v2 of the documentation delivered
2.5 hours later.

⚠ **This changes what kind of item this is.** It was written as a gap someone had
not noticed. It is now **a decision both sides took knowingly**, on a stated
rationale — the environments share a database, so the credential is not
separating anything that is actually separate. That rationale is coherent.

🔴 **What it does not answer is point 2 of "Why this is an item".** The shared
token still means a value leaked from a ROMI sandbox can call `env=prod` and
spend money at Anticipay once the switch is flipped. Nobody weighed that in the
room; the question asked was _"can we use the same token"_, not _"what happens if
it leaks"_. Rotation and expiry were **not discussed at all**.

### Where this leaves the item

- The **environment question is closed.** Do not re-ask it — Aurel Mrruku already
  decided, on the record, that `:env` on the shared host is acceptable for a
  cache-read lookup. That also **discharges the 25 August test-environment
  action** as explicitly as this project is going to manage.
- The **credential-hygiene question stays open** and is now narrower: given one
  token, deliberately, **can it be rotated before go-live**, on the assumption
  that a value mailed to six addresses is already public? That is the only thing
  left to ask Andrea Parmeggiani here.
- The **`401` distinction stays open** and is Aurel Mrruku's, unchanged.

Status stays `open` for those two. The headline question is settled.

## The other side of the same problem

ROMI owes Pienissimo a token in the opposite direction, for the WooCommerce
endpoint, under
[OI-102](OI-102%20Salesforce%20endpoint%20and%20token%20for%20the%20WooCommerce%20plugin.md)
— where the 31 August org check found the receiving Apex class has **no
application-level auth at all**, making that token the entire defence. Two
integrations, two static shared secrets, both distributed by mail. Worth one
decision about how this project handles credentials rather than two.
