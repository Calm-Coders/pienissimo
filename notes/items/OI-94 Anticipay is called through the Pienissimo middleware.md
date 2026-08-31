---
id: OI-94
type: open-item
status: open
owner: Andrea Parmeggiani
with: Aurel Mrruku
org: both
raised: 2026-08-25
updated: 2026-08-25
depends_on: [OI-73]
blocks: [OI-73]
source: notes/meetings/2026-08-25 Integrazione Anticipay.md
---

# OI-94 - Anticipay is called through the Pienissimo middleware

**Decided 2026-08-25, with the client.** Salesforce does **not** call Anticipay.
It calls an API exposed by **Pienissimo Software Srl**, which sits in front of
Anticipay, caches the results and returns a standardised payload.

Two reasons were given and both were accepted:

1. **Cost.** Andrea Parmeggiani raised it — Anticipay charges per lookup, and
   Pienissimo already holds much of the data. The middleware stores what it
   fetches so the same VAT number is not paid for twice.
2. **Insulation.** Aurel Mrruku added it — if Anticipay changes its endpoints,
   only the middleware has to move, not the Salesforce integration.

## The contract, as far as it is agreed

| Element | Agreed |
| ------- | ------ |
| Caller | Salesforce |
| Callee | Pienissimo Software middleware — **not Anticipay** |
| Trigger | first Order inserted for an Account |
| Auth | a **token in the HTTP request header** |
| Errors | `404` = VAT number not found · `500` = generic; **code and descriptive message both returned** |
| Error storage | codes and messages **saved in Salesforce and kept for three months** |
| Error use | raise **internal notifications** from the stored record |
| Conflicts | the value returned **overwrites** what Salesforce holds |
| Payload | trimmed to the needed fields — see [OI-95](OI-95%20Which%20Anticipay%20fields%20land%20in%20Salesforce.md) |

## What is owed, and by whom

- **Andrea Parmeggiani owes the API structure example**, error codes included.
  He committed to **the end of the week commencing 31 August** — so on or before
  **Friday 4 September**. A follow-up call is booked for **Tuesday 1 September
  10:00 CEST**, cancellable if the material lands first.
- **Pienissimo Software owes the test environment.** ROMI's own test environment
  already exists — it is the UAT org — so what is missing is **theirs, for ROMI
  to point at**. The Gemini minute assigns this to Aurel Mrruku; that is wrong
  and was corrected by him on Slack the same afternoon, with Elena Spini
  accepting the correction. **The client-facing calendar invitation still carries
  the wrong wording** and has not been re-sent.

Nothing can be built against this until the payload example arrives. There is no
endpoint, no schema and no token yet.

## 🔴 Why this is more than a technical choice

A **Fase 1** integration now has a **hard build dependency on Pienissimo Software
Srl** — the separate legal entity ROMI argues is not this project's client, and
which sits at the centre of
[the phase 2 scope dispute](../risks/Risk%20-%20the%20phase%202%20scope%20dispute%20is%20unresolved.md).

Until 25 August the crossover was only that
[Andrea Parmeggiani](../people/Andrea%20Parmeggiani%20-%20Pienissimo%20Software%20maintenance%20manager.md)
was the named contact. Now Fase 1 cannot go live unless Pienissimo Software
**builds and hosts a service**, stands up a test environment for it, and keeps
it running. Nobody in the session named the entity question, and no note in the
record says who pays for that work or who owns the middleware's uptime once the
project closes.

Elena Spini restated the corporate structure on Slack the same morning, so the
distinction is live in her mind: _"La loro società è Pienissimo SRL che
rivenditore del software Pienissimo Pro, di proprietà di un'entità legale
distinta, Pienissimo Software SRL."_

**This needs Elena Spini or Aurel Mrruku, not a developer.** It is a commercial
question wearing an architecture diagram.

## What it does not change

The business rule in
[OI-73](OI-73%20VAT%20validation%20moves%20into%20Salesforce.md) is untouched —
the VAT check still fires at the first order of an Account, still writes back to
the account, still notifies administration on failure. Only the counterparty on
the wire changed. The `consolidato` flag, the manual re-check button and the
administration address Pienissimo still owes all stay as recorded there.

## The design file records the change on one page and not the other

`Flows & Objects.drawio` was edited **during the call** (2026-08-25T08:23:31Z,
10:23 CEST). The **LEAD-OPTY** page now reads _"chiamata API **al middleware
Pienissimo** per check P.IVA Account"_ — while the **Ordini** page still reads
_"chiamata API **Anticipay**"_. See
[the newest design diagram](../The%20newest%20design%20diagram.md). The master
now contradicts itself on this rule; the LEAD-OPTY wording is the later and
correct one.
