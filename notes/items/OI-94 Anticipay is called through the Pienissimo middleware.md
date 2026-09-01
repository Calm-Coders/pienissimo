---
id: OI-94
type: open-item
status: open
owner: Andrea Parmeggiani
with: Aurel Mrruku
org: both
raised: 2026-08-25
updated: 2026-08-31
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

## 2026-08-31 - the documentation arrived, four days early

🟢 **Andrea Parmeggiani delivered.** Mail _"Pienissimo - Documentazione API per
chiamata informazioni aziende"_, **31 August 16:15Z**, to Aurel Mrruku, cc Elena
Spini, `amministrazione@pienissimo.com`, Fabrizio Paganelli and Sabatino
Rinaldi, carrying one attachment: **`Documentazione API – Salesforce.pdf`**.

He owed this by **Friday 4 September** and sent it on Monday 31 August — the
first client commitment on this project delivered ahead of its date. The
follow-up call booked for **1 September 10:00 CEST** was made cancellable
precisely on this condition; it is now the meeting's own decision whether to run.

⚠ **The attachment has not been read.** This sweep can see that the PDF exists
and who it went to; it cannot open a Gmail attachment. Everything below comes
from the **mail body**, which is short and substantive. The PDF is the API
contract and it remains unread — the same shape of gap as the WooCommerce
payload attachment on 27 August, which sat unopened for a day until Aurel Mrruku
downloaded it by hand. **It should be opened before the 1 September call**, and
the contract folded into [OI-95](OI-95%20Which%20Anticipay%20fields%20land%20in%20Salesforce.md)
and into this table.

### 🔴 The test period has different semantics from production, and nobody has recorded that until now

Andrea Parmeggiani's own words: _"Per il momento l'API ritorna i dati solamente
se già presenti sul nostro database, evitiamo di fare richieste ad Anticipay per
questo periodo di test, alla fine del test invece inoltreremo le chiamate ad
Anticipay e per voi sarà trasparente."_

| | During the test period | After it |
| --- | --- | --- |
| Middleware behaviour | serves **only from the Pienissimo cache** | forwards a miss on to Anticipay |
| A VAT number they do not already hold | **returns nothing** | returns Anticipay's answer |
| Change required on the ROMI side | none — the switch is theirs | none, _"per voi sarà trasparente"_ |

This is new. The 25 August contract in the table above describes the **production**
behaviour and says nothing about a cache-only test mode. Two consequences follow
and neither has been discussed:

- 🔴 **A test that queries an unknown VAT number will look like a `404`
  when it is really "not cached yet".** The agreed error semantics give `404` a
  single meaning — _VAT number not found_ — and during the test period it will
  carry two. Any test evidence gathered before the switch cannot distinguish a
  genuine unknown company from a cold cache, so **do not treat test-period `404`
  rates as a measure of Anticipay's coverage.**
- The switch from cache-only to pass-through is **Pienissimo Software's to
  flip**, on a date nobody has named. ROMI has no signal for when it happens and
  no way to detect it from the outside. Ask for the date, and ask to be told when
  it is done.

Neither point invalidates anything already agreed — the counterparty, the
trigger, the header token, the three-month error retention and the overwrite rule
all stand as recorded. It narrows what the **first round of testing can prove**.

## The design file records the change on one page and not the other

`Flows & Objects.drawio` was edited **during the call** (2026-08-25T08:23:31Z,
10:23 CEST). The **LEAD-OPTY** page now reads _"chiamata API **al middleware
Pienissimo** per check P.IVA Account"_ — while the **Ordini** page still reads
_"chiamata API **Anticipay**"_. See
[the newest design diagram](../The%20newest%20design%20diagram.md). The master
now contradicts itself on this rule; the LEAD-OPTY wording is the later and
correct one.
