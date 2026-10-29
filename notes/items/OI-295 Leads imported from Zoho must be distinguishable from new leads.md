---
id: OI-295
type: open-item
status: open
owner: Elena Spini
with: Sabatino Rinaldi
org: both
raised: 2026-10-28
updated: 2026-10-28
depends_on: [OI-290]
blocks: [go-live]
source: Slack D0B5QHS2T7H 2026-10-28 17:03 CET
---

# OI-295 - Leads imported from Zoho must be distinguishable from new leads

**The client asked that Leads migrated from Zoho arrive in Salesforce marked, so
that after go-live a genuinely new Lead cannot be confused with a migrated one.
He accepts them being loaded in state `New`; what he does not accept is their
being indistinguishable. ROMI settled internally on a checkbox. Nothing is built,
and the client has not been told what was decided.**

## The request

🔑 **It arrived privately, not through the project channels.** Elena Spini,
Slack DM `D0B5QHS2T7H`, **2026-10-28 17:03:12 CET**:

> _"tema LEAD invece **Sabatino mi ha scritto in privato** per capire come
> differenziare i record importati che per lui è ok se stanno a NEW **but devono
> essere diversi dai new che entreranno dopo il 16/11**"_

So the constraint is explicit and dated: the boundary is **16 November**, the
agreed go-live
([OI-268](OI-268%20The%20client%20proposed%20a%20go-live%20calendar%20of%2016%20November.md)).

⚠ **The source is a ROMI-internal relay of a private message.** As with the
ticketing answers of 27/10, this mailbox and these channels do not hold
Sabatino Rinaldi's own words — only Elena Spini's report of them. The quotation
marks above are hers, not his.

## ROMI's answer, taken internally

Elena Spini, the same minute, quoting her own earlier proposal to him:

> _"[16:49] piuttosto possiamo fare li importiamo come NEW ma mettiamo **un campo
> di checkbox `Lead from Zoho = TRUE`**"_
>
> _"[16:50] e poi si possono fare i filtri dalle list view ecc che questi sono da
> scartare / o quanto meno non nuovi e piano piano li sistemate se vorrete"_

And the decision, at **17:07:07 CET**: _"si facciamogli sta checkbox e via"_,
with Aurel Mrruku at 17:05:23 leaving the shape to her — _"sei libera di decidere
te come li vuoi gestire (possiamo creare un campo a doc)"_.

## Why it is open

1. 🔴 **Nothing is built.** No `Lead` checkbox field of this name exists in
   `force-app/`, and the migration that will set it is the one being rehearsed
   now. The field has to exist **before** the Lead load, not after.
2. 🔴 **The client has not been told what was decided.** The exchange is a ROMI
   DM. Sabatino Rinaldi stated a constraint; he has not been shown the checkbox,
   the list-view filters, or the fact that cleanup is being handed back to him
   (_"piano piano li sistemate se vorrete"_).
3. ⚠ **No register row covers Lead migration at all** — the same gap recorded
   on [OI-290](OI-290%20Lead%20and%20Referenti%20migration%20data%20is%20owed%20by%20the%20client.md),
   and this is a second requirement landing inside it.
4. ⚠ **A checkbox and a document field were both floated** (_"possiamo creare un
   campo a doc"_). Which one is to be built is Elena Spini's call and is not
   recorded anywhere but this note.
5. 🔑 **It interacts with consent.** OI-290 records that consents ride on the
   Lead. A flag that marks a Lead as migrated says nothing about whether its
   consent state survived, and nobody has connected the two.

## Related

- [OI-290](OI-290%20Lead%20and%20Referenti%20migration%20data%20is%20owed%20by%20the%20client.md)
  — the migration this rides on; the Referenti half was delivered the same day.
- [OI-268](OI-268%20The%20client%20proposed%20a%20go-live%20calendar%20of%2016%20November.md)
  — the 16 November boundary the client named.
