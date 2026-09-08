---
id: OI-126
type: open-item
status: open
owner: Aurel Mrruku
with: Fabrizio Mastracci
org: ROMI
raised: 2026-09-07
updated: 2026-09-08
depends_on: [OI-78]
requirement: BIG-06
source: notes/meetings/2026-09-07 Interna Flussi MKT.md
---

# OI-126 - An asset flag for incomplete participant data

**Marketing Cloud needs to find the tickets whose participant data the buyer has
not filled in. Fabrizio Mastracci asked for that to be one field on Salesforce
rather than a query Marketing Cloud has to reconstruct.**

## The ask

From [the 7 September marketing session](../meetings/2026-09-07%20Interna%20Flussi%20MKT.md):
the nurturing flow chases buyers until they name their participants, so its entry
and exit criteria are *"this ticket has no participant yet"*. Fabrizio Mastracci
asked to simplify the check with **a field or checkbox on Salesforce**, so
Marketing Cloud queries and triggers can key off it directly.

Owner **Aurel Mrruku**, who also owes Fabrizio Mastracci **the trigger
specification by chat** so the first flow's configuration can start.

## Why it is worth a row rather than a line in a build list

- **It gates the first marketing flow**, which Fabrizio Mastracci is starting to
  configure now. Without it the flow either cannot be built or gets built against
  a fragile query.
- **The obvious implementation is a formula, and a formula may not be queryable
  the way Marketing Cloud needs.** Nobody discussed whether it is a stored
  checkbox maintained by the registration path or a derived field.
- **The state it represents is not currently modelled.** The asset states named in
  the same session are `disponibile`, `utilizzato` and `annullato` — none of them
  distinguishes *sold but unnamed* from *sold and named*.

## ⚠ Check the invitation object first

[The event invitation build](../flows/Proposed%20event%20invitations%20for%20participant%20registration.md)
was committed to `DevMain` on the **same day** as this request, in commit
`d562af0`. It creates `Event_Invitation__c` with `Status__c` and `URL_Status__c`,
one invitation per Account-Campaign, on the paid-order ticket insertion path.

That object tracks **the invitation**, not the asset — its journal entry states
explicitly that the current source _"does not backfill existing Assets, schedule
sends, track delivery or auto-complete/reopen invitations"_. So it does **not**
already answer this ask, but it is adjacent enough that building a second,
overlapping status field would be a mistake.

**Whoever picks this up should decide deliberately whether the flag belongs on
`Asset`, on `Event_Invitation__c`, or on both** — and record which, because two
sources of truth for "is this ticket named yet" is exactly the kind of drift this
project keeps finding.

## Not decided

- Which object carries it.
- Whether it is maintained by the participant registration controller, by a
  trigger on Asset, or derived.
- What it does when a ticket is **partially** named — a bundle can hold several
  tickets and the community form allows some to be filled and others not. The
  same partial-completion problem is why
  [rinuncia moved into the community](../decisions/Decision%20-%20rinuncia%20moves%20from%20the%20marketing%20email%20to%20the%20community.md).

## 2026-09-08 - the client's own segment rule is stricter than a flag

`SEGMENTI FUNNEL BIGLIETTI.docx`, read this run
([OI-81](OI-81%20Event%20communication%20funnel.md)), states the exit criterion the
flag has to serve:

> _"un contatto avente 3 biglietti può decidere di partecipare anche solo con 1
> biglietto e in questo modo, una volta inseriti i dati, esce dal funnel e non
> riceve più comunicazioni."_

🔴 **This is a contact-level aggregate, not an asset-level boolean.** The segment
compares *iscrizioni effettuate* against **tickets held by that contact for that
event**. A per-Asset "data incomplete" flag does not express it: a holder of three
tickets with one completed has two incomplete assets and **must still leave the
funnel**.

So the deliverable is at least one of:

- a **contact- or account-level** roll-up per campaign — tickets held versus
  tickets completed — which is what Marketing Cloud can actually segment on; or
- the per-asset flag **plus** the aggregation done in Marketing Cloud, which
  pushes the logic into the flow the design was trying to keep simple.

⚠ **Nobody has chosen.** The 8 September org check confirms the starting point is
unchanged: **Asset still carries eight custom fields with no completeness flag**,
and the participant controller has no withdrawal action. The check explicitly
declined to invent a field name, and so does this row.

⚠ It interacts with the tag scheme: `<EVENT>_I` is set **per contact on first
completion**, which is the same aggregate seen from the marketing side.
