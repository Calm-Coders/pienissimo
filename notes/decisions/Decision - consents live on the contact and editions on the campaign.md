---
id: DEC-2026-09-07-consents
type: decision
status: resolved
owner: Aurel Mrruku
with: Elisa Migliano
org: both
raised: 2026-09-07
updated: 2026-09-07
source: notes/meetings/2026-09-07 Data Model Parte 3.md
---

# Decision - consents live on the contact and editions on the campaign

**Agreed with the client at
[Data Model Parte 3](../meetings/2026-09-07%20Data%20Model%20Parte%203.md), 7
September 2026.** Marketing consents are Contact fields. Which event editions a
contact took part in is CampaignMember data. The two are separated deliberately.

## The problem it solves

In Zoho, `Consenso finalità commerciali` and `Consenso profilazione` sit inside an
`ultima iscrizione` macro-area on the Contact that **also carries the edition the
consent was recorded against**. There is only one such block per contact, so a
second registration **overwrites the first**. Elisa Migliano:
_"come campo di ultima iscrizione c'è solo quello."_

**Rebecca Marmo confirmed what that means in practice**, called into the session
for two minutes: a contact who has already attended has already authorised, and
_"l'autorizzazione poi nei biglietti successivi va in automatico. Cambia solo in
automatico il flag"_. The consent survives; only the edition is lost.

## What was agreed

- **Consents stay on the Contact.** Aurel Mrruku's reason: outbound marketing runs
  off them — _"a livello di contatto, perché poi se si fanno logiche marketing
  outbound"_.
- **Edition participation lives on Campaign / CampaignMember**, one member record
  per edition, so nothing overwrites and the whole history is retrievable. Elena
  Spini walked the client through Campaign History on a live contact to show it.
- **Field shape**: `Consenso finalità commerciali` and `Consenso profilazione` are
  **picklists**, values **`Autorizzo` / `Non autorizzo`**, **default blank**. Not
  checkboxes — Elena Spini proposed a boolean and Elisa Migliano corrected her.

## What follows from it

- **The Zoho per-event tag scheme is retired by this.** `<EVENT>_I` (iscritto) and
  `<EVENT>CP` (contatto principale) become **CampaignMember status values**. Elena
  Spini to the client: _"non si chiamerà più Tag FM, ma sarà campaign
  dell'edizione Food Marketing Festival 2026"_. The whole tag block was deleted
  from the Contact in session.
- **The `rinuncia` / `iscritto` / `presente` marketing tags move with them.**
  [OI-81](../items/OI-81%20Event%20communication%20funnel.md) records the Zoho
  funnel driving off those tags; the funnel now has to key off CampaignMember
  status instead. Fabrizio Mastracci independently proposed exactly that at
  [the marketing session](../meetings/2026-09-07%20Interna%20Flussi%20MKT.md) three
  hours earlier — _"evitando logiche complesse basate su tag ereditate dalla
  piattaforma precedente"_ — so both sides reached it separately on the same day.
- **A migration question falls out of it that nobody asked.** Zoho holds one
  edition per contact. Salesforce wants one CampaignMember per edition attended.
  The history to populate the second **does not exist in the first** — it was
  overwritten each time. So historical edition participation is not migratable
  from this field, whatever else the initial load carries.
  ⚠ **Raised here; not raised in the session.**

## Not decided

- **Whether consent is also mirrored onto CampaignMember** for audit — the
  session settled where consent *lives*, not whether a point-in-time copy is kept
  per edition. GDPR-style questions about proving consent at a given date are not
  addressed anywhere in the record.
- **What `Non autorizzo` suppresses**, and where that is enforced. A blank default
  means most records will be neither authorised nor refused at cutover.
