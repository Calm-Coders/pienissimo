---
id: OI-125
type: open-item
status: open
owner: Andrea Di Cicco
org: ROMI
raised: 2026-09-07
updated: 2026-09-10
depends_on: [OI-116]
source: notes/meetings/2026-09-07 Follow-up Interno.md
---

# OI-125 - Mexal customer update needs a PUT method

**Sending an account that already exists to Mexal by POST fails. The agreed
design sends the customer on every order creation, so the failing call is on the
main path.**

## The defect

From [the 7 September internal follow-up](../meetings/2026-09-07%20Follow-up%20Interno.md):
Andrea Di Cicco reported that posting an existing account to Mexal returns an
error to the effect that the **partita IVA already exists**. Creation and update
are the same endpoint today, and only creation works.

**PUT or PATCH is required for the update case.** Andrea Di Cicco is to study and
implement it.

## Why it is on the critical path, not a corner case

Agreed in the same session:

> **The customer is sent to Mexal every time an order is created**, as an *empty
> update* when nothing has changed commercially.

So the push is **unconditional**. Every order after a customer's first one hits
the update path, which is the one that does not work. This is not a repair for
edge cases; it is the second and every subsequent order for every customer.

It refines the ownership model settled at Parte 1 —
[OI-116](OI-116%20Nightly%20Mexal%20to%20Salesforce%20anagrafica%20sync.md) and
[OI-117](OI-117%20Administrative%20fields%20lock%20once%20the%20Mexal%20customer%20code%20is%20set.md).
Salesforce creates the account and pushes it to Mexal immediately before the
order; Mexal then owns the anagrafica. What was not previously in the record is
that the push repeats on **every** order, empty or not.

## What is not decided

- **Whether it is PUT or PATCH.** The session names both and settles neither. It
  matters: PUT implies the full record is sent, PATCH implies a delta, and the
  "empty update" pattern reads as PUT with an unchanged body.
- **What identifies the customer** on the update call. `Codice Cliente Mexal` is
  the obvious key and is not named in the notes.
- **What happens when the empty update collides with the nightly batch** running
  the other way ([OI-116](OI-116%20Nightly%20Mexal%20to%20Salesforce%20anagrafica%20sync.md)).
  Both are unbuilt, so the ordering has never been considered.

## Related, from the same session

- **Customer search must be field-filtered.** The lookup is a POST for customers
  modified in the last 24 hours, and Aurel Mrruku raised that the unfiltered
  response risks breaching JSON size limits. Agreed: apply a retrieval filter and
  evaluate pagination.
- **Static management coordinates**: `azienda = PE`, `anno = 2025`, set in code;
  authorization is basic, a base64 user-and-password pair. 🔴 **`anno = 2025` is
  hardcoded against a 2026 go-live and nobody raised it.**

## 🟢 2026-09-10 - both open questions are answered by the collection

`Mexal Dev v.2.postman_collection`, sent by Aurel Mrruku to Anita Aga on Slack at
**14:45:51 CEST**, contains a working `Modifica Cliente` request
([the wire facts](../flows/The%20Mexal%20integration.md#2026-09-10---the-wire-facts-arrive-and-the-first-apex-is-written)):

- **It is `PUT`, not PATCH** — `PUT /webapi/risorse/clienti/{codice}`.
- **It carries the full body**, the same field set as `Creazione Cliente` minus
  `codice`. So the *"empty update"* pattern is PUT with an unchanged body, exactly
  as this note read it.
- **The customer is identified by its Mexal code in the path** —
  `Codice_Cliente_Mexal__c` on the Salesforce side. That was the second unknown
  and it is settled.

🔴 **The item stays open, because nothing sends it.** `force-app/` still has no
code that pushes a customer to Mexal in either direction. The Mexal Apex written
the same afternoon
([the build](../objects/The%20first%20Mexal%20integration%20Apex.md)) is
**hard-guarded to `POST` on `/ricerca` endpoints only** and cannot issue a PUT by
construction — three separate checks refuse it.

So the design question is closed and the build question is untouched. **Every
order after a customer's first still hits a path that does not exist.**

⚠ **Andrea Di Cicco still owes the implementation**, unchanged since 7 September,
and he did not reply on 10 September to a chase left on 9 September about a
different collection ([OI-102](OI-102%20Salesforce%20endpoint%20and%20token%20for%20the%20WooCommerce%20plugin.md)).

### One correction to the paragraph above

This note recorded the coordinates as **`azienda = PE`**. **They are `PIE`** — the
collection and the built code agree, and the Mexal flow note's own 15 July entry
said `PIE` all along. The `PE` spelling was a transcription slip in the
7 September minute.

The `anno = 2025` flag is **not** corrected, only complicated: the collection
sends `Anno=2025` statically while the code sends the **current year**. Nobody
chose. See the flow note.
