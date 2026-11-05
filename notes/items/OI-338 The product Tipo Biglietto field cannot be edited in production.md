---
id: OI-338
type: open-item
status: open
owner: Rexhina Hysi
with: Aurel Mrruku
org: both
raised: 2026-11-05
updated: 2026-11-05
depends_on: []
blocks: []
source: Gmail 1a1aa9c8b2f14291, 2026-11-05T07:29:07Z
---

# OI-338 - The product Tipo Biglietto field cannot be edited in production

**Fabrizio Paganelli could not edit `Tipo Biglietto` on the product registry in
production and asked ROMI to check. The request was escalated twice inside ROMI
during the day, a Prod permission change was reported done at 14:24 CET, and at
15:44 CET Elena Spini was still asking for him to be unblocked. Whether he can edit
the field now is not established.**

## The request

Fabrizio Paganelli → Aurel Mrruku and Elena Spini, **2026-11-05T07:29:07Z**
(Gmail `1a1aa9c8b2f14291`):

> _"dovrei aggiornare il campo Tipo Biglietto nell'anagrafica prodotti. Vedo però
> che, in produzione, quel campo non lo posso modificare. Potete verificare?"_

## What happened during the day, in order

| Time (CET) | Source | Event |
| --- | --- | --- |
| 08:29 | mail | Fabrizio Paganelli asks |
| 12:08 | Elena Spini DM | She pastes the mail to Aurel Mrruku: _"Fabrizio mi chiede un check su questo altrimenti è bloccato"_ |
| 12:08-12:09 | Elena Spini DM | Aurel Mrruku lists his competing work — _"che devo fare prima …. migrare i record / deployare in prod i cambiamenti chiesti ieri / oppure fixare i permission"_ |
| 13:04 | Elena Spini DM | _"priorità a sistemargli questa cosa perchè lo blocco poi rispondi alla mail"_ |
| 14:05 | dev group | Aurel Mrruku → Rexhina Hysi: _"kaloje pak ne prod lejet per te modifiku produktet, dhe me be me dije se po me bezdisin"_ |
| 14:08 | dev group thread | Rexhina Hysi: _"Agente? Profile"_ → Aurel Mrruku: _"ishte te produkti nje type"_ |
| 14:23 | dev group | Anita Aga names the field: _"Tipo Biglietto"_ |
| 14:24 | dev group | Rexhina Hysi: **_"done thuaj t shtypin butonin edit te productet"_**, one ✅ |
| 14:06 | dev group | Aurel Mrruku asks Anita Aga for a field test in Prod: _"be dhe nje test te fushes ne prod, te thot"_ |
| 15:44 | Elena Spini DM | 🔴 Elena Spini **still asking**: _"puoi sbloccare Fabrizio per il campo?"_ → Aurel Mrruku: _"no elena ho altre priorità"_ |

🔴 **So the record contradicts itself on whether the block was cleared.** A Prod
permission change was reported done at 14:24, and eighty minutes later the project
manager was still asking for the same unblock and was refused on priority. ⚠ **No
org was opened in this session**, so neither state is verified here, and the result
of Anita Aga's requested field test is not recorded anywhere.

## What is not established

- ⚠ **Which permission was changed.** Rexhina Hysi asked _"Agente? Profile"_ and the
  answer she got named the field, not the profile. The dev group does not say what
  she edited, and it is an **undocumented direct edit to Prod** — the same class of
  drift already listed for 29/10 onward in [JOURNAL.md](../../JOURNAL.md).
- ⚠ **Whether the change is in source.** Nothing in this window says it was
  retrieved into `force-app`.
- ⚠ Whether the obstacle was field-level security, the Agente profile's layout, or
  the record-type access reported fixed earlier.

## Why it matters

1. The client is the product-registry owner — `Tipo Biglietto` is his field to
   maintain, and [OI-76](OI-76%20Ticket%20type%20picklist%20on%20the%20product.md) and
   [OI-269](OI-269%20Event%20communications%20must%20be%20differentiated%20by%20ticket%20type.md)
   both depend on its values being right.
2. 🔑 It is the **second** access complaint from the same user in two weeks, after
   the 03/11 move of Marco Montesi from System Administrator to Agente deliberately
   removed edit rights: _"sono stati disabilitati i campi riservati
   all'amministrazione"_. The profile tightening and the registry work pull in
   opposite directions and nobody has reconciled them.
3. 🔴 He was then locked out of Prod entirely until Monday —
   [OI-339](OI-339%20The%20client%20was%20locked%20out%20of%20production%20during%20the%20migration%20load.md)
   — so the verification cannot happen before 9 November either way.
