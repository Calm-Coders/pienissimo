---
id: OI-125
type: open-item
status: open
owner: Andrea Di Cicco
org: ROMI
raised: 2026-09-07
updated: 2026-09-14
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

> **The customer is sent to Mexal every time an order is created**, as an _empty
> update_ when nothing has changed commercially.

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
  `codice`. So the _"empty update"_ pattern is PUT with an unchanged body, exactly
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

## 2026-09-11 — the PUT is built, and nothing calls it

`80420cf` (PR #41, merged 18:05 CEST) adds
`MexalSearchCalloutService.updateCustomer(customerCode, body)`:
**`PUT /clienti/{codice}`**, the path parameter substituted from
`Account.Codice_Cliente_Mexal__c`, a blank code refused before any callout, and
`Mexal_Clienti_Modifica` added to a new `WRITE_ACTIONS` allow-list. 🟢 **The
transport this row asked for exists.**

🔴 **It has no caller.** In `MexalCustomerCreateService.createForAccount`, an
Account that already carries a Mexal code **throws**
_"Account gia collegato a Mexal"_ — and the six lines that would call
`updateCustomer` sit directly above it **as a block comment** headed _"Future
Modifica Cliente path"_.

🟢 **The duplicate `partita IVA` failure this row is really about is now
handled.** `findDuplicatePartitaIvaCustomerCode` parses _"partita iva esiste
gia"_ out of the Mexal error detail and returns **the existing customer code**,
with an Italian message naming it. The failure mode that made the PUT necessary
is no longer opaque — it now tells you which customer you collided with.

**The row stays open**, and the reason has moved: yesterday nothing could issue a
PUT; today something can and nothing does. **What is missing is the caller**, and
[the sequencing decision of the same day](../decisions/Decision%20-%20first%20order%20runs%20Anticipay%20before%20Mexal%20customer%20creation.md)
says where it belongs — the queued chain on any Order after an Account's first,
not the manual button that shipped.

## 2026-09-14 — the caller exists, in the org, and has never run

The org-status-check against Pienissimo UAT found the caller this row asked for
on 11 September, built that morning and **in no branch of this repository**
([the build](../objects/The%20order%20to%20Mexal%20integration%20chain.md)).

`OrderMexalIntegrationService.runMexalCustomerStep` branches exactly where this
row said it should:

- Account has **no** Mexal code and it is the **first** order for that Account →
  `MexalCustomerCreateService.createForAccount` (the POST);
- Account **has** a Mexal code → `MexalCustomerCreateService.updateForAccount` —
  **the PUT**;
- Account has no Mexal code and it is **not** the first order → it throws, rather
  than creating a duplicate.

🟢 **This is precisely what this note specified**: the caller belongs in the
queued chain on any Order after an Account's first, not on the manual button. The
block comment headed _"Future Modifica Cliente path"_ is gone. The "empty update
on every order" pattern agreed on 7 September is what the chain now does.

🟢 The first-order test is a **query for earlier Orders on the same Account**,
not an assumption — so a migrated customer with history is treated as an update,
which is the correct reading of the agreed design.

🔴 **The row stays open, and the reason has moved a third time.** On 10 September
nothing could issue a PUT; on the 11th something could and nothing did; today
something calls it and:

1. **It is not in source control.** A deploy from `DevMain` removes the caller
   again — `force-app/`'s `OrderTriggerHandler` still calls
   `AnticipayOrderAutomation`, not the Mexal chain
   ([the risk](../risks/Risk%20-%20the%20Mexal%20order%20integration%20exists%20only%20in%20the%20org.md)).
2. **It has never executed.** All **30** Orders in UAT carry an empty
   `Mexal_Integration_Status__c`, and no `OrderMexalIntegrationQueueable` appears
   in seven days of `AsyncApexJob`. **Two** Accounts have a Mexal code.

**So the design question is closed, the build question is answered, and the
evidence question is open.** Nothing has yet proved a second order for an
existing customer reaches Mexal successfully. **Run one, in UAT, and record the
result** — that is what would close this row.

⚠ **Andrea Di Cicco was the owner of the implementation** and it was written by
Aurel Mrruku instead. Reassign the row or confirm the handover.

## 2026-09-14 evening — the PUT was executed against Mexal, and there is no PATCH

Two things closed most of this row on 14 September, and neither came from a
meeting.

### 1. It ran, from Salesforce, and it worked

Slack DM Aurel Mrruku ↔ Andrea Di Cicco, **14/09 11:34–12:10 CEST**
(`D0AQ0FMHFM1`). Aurel asked whether there was information on the customer-update
PUT; Andrea answered that it was already in the collection and posted a screenshot
at 11:58. Aurel then:

- _"non mi dava un body e pensavo che non funziona"_ — the empty response had been
  read as a failure;
- **_"ho testato direttamente da SF e va todos bien"_ (12:07:44)** — a PUT issued
  **from Salesforce** succeeded;
- _"si ho creato un mio cliente"_ (12:07:17) — against a customer he had created
  himself.

🟢 **This is the execution evidence this row asked for.** A Mexal customer update
issued by Salesforce completed successfully. ⚠ Two qualifications: it was a
**direct** test, not the `OrderMexalIntegrationService` chain firing on a second
Order, and it was run against **Mexal production** — see
[the risk](../risks/Risk%20-%20the%20Mexal%20integration%20is%20developed%20against%20the%20production%20ERP.md).
The chain-level evidence is still owed.

### 2. The response shape is 204 with no body

_"il put ci da 204 ma no body"_ (12:08:56) → Andrea Di Cicco: **_"vedi gli
header"_** (12:09:20). 🟢 This corroborates the built code, which recovers the
Mexal code from the response headers rather than the body, and it explains the
false-negative reading above. **`PUT /clienti/{codice}` returns `204 No Content`;
anything the caller needs is in the headers.**

### 3. There is no PATCH — the full-body PUT is the only update

Aurel raised the obvious objection (12:09:47–12:10:50):

- _"ma un patch per l'update noon esiste ?"_
- _"il put mi sembra esagerato"_
- **_"poi se hanno dei campi auto complite il put crea dei nuovi"_** — if Mexal
  auto-populates fields, a full-body PUT that omits them may overwrite or
  duplicate them.

He chased it again at 14:34 (_"non scordarsi la cosa di Patch si pienissimo"_ /
_"se hanno anche il patch usiamo quello"_) and Andrea Di Cicco answered at
**15:18:38: _"Non c'è la patch"_.**

🔴 **So the answer is settled and it is the worse one.** Every customer update is
a full-body replace. Aurel's concern is unanswered and is now a standing design
risk, not a question: **nothing has established what a full PUT does to Mexal
fields that Salesforce does not send.** That matters most for the nine
administrative fields that
[OI-117](OI-117%20Administrative%20fields%20lock%20once%20the%20Mexal%20customer%20code%20is%20set.md)'s
validation rule locks but the outbound push never refreshes.

### 4. The caller is in source control at last

`e06a1b4` (PR #43, open) commits `OrderMexalIntegrationService` and the rewritten
`OrderTriggerHandler.afterInsert`, which now calls
`OrderMexalIntegrationService.enqueueForCreatedOrders` — replacing the
`AnticipayOrderAutomation` call and deleting that class. Point 1 of the 14/09
section above ("it is not in source control") is **superseded**, subject to PR #43
merging.

**What would close this row:** one second Order for an existing customer, run
through the chain in UAT, with the result recorded. Everything else is answered.

⚠ Ownership unchanged: the row is Andrea Di Cicco's; the implementation was
written by Aurel Mrruku and Anita Aga. **Reassign or confirm the handover.**
