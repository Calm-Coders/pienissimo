---
id: OI-168
type: open-item
status: open
owner: Aurel Mrruku
with: Elena Spini
org: ROMI
raised: 2026-09-22
updated: 2026-09-23
depends_on: [OI-141, OI-151]
blocks: [go-live]
severity: gating
source: notes/meetings/2026-09-22 Test Interni Pre-UAT Parte 2.md
---

# OI-168 - Contract logic is not started and is on the 5 October UAT

Elena Spini asked directly at
[the 17:00 pre-UAT session](../meetings/2026-09-22%20Test%20Interni%20Pre-UAT%20Parte%202.md):
_"Do you have already the logic of contratto?"_

Aurel Mrruku: **_"No, we haven't even started with it… I haven't even started thinking
about it."_**

## Why this is a dated problem, not a backlog item

- 🔴 **`Contratto` is on the UAT agenda for Monday 5 October**, in Elena Spini's
  client-validated calendar posted to `#tproj-pienissimo` at 22/09 18:37 CEST:
  _"Opty Performance Plus + Gestione date pagamento + Contratto"_. Formal approval is
  due **13 October**.
- The record already carries what it must do:
  [OI-141](OI-141%20Contract%20object%20for%20Performance%20Plus%20orders.md)
  — a Contract record created automatically for Performance Plus and
  attivazione/rinnovo orders, fed from the Mexal `scoperto clienti` / `scadenziario`;
  and Elena Spini's 21/09 document breakdown in
  [OI-151](OI-151%20Quote%20signature%20step%20before%20the%20order%20is%20generated.md)
  — Performance Plus gets Contratto + Preventivo **+ scheda Performance Plus**, every
  other order Contratto + Preventivo.
- 🔴 **The DocuSign document content is also untouched.** Aurel Mrruku at the same
  session: _"we haven't worked on the content of the DocuSign"_, and the client must
  still say **where the signature and the date go**.

## The agreed fallback for UAT

Show the opportunity logic for `Plus attivazione/rinnovo` and tell the client the
contract follows the order — _"starting from now will be the order and then will be the
contract, but we will see everything next"_. Aurel Mrruku also needs answers before he
can build: _"I even need some answers on contratto."_

## Open

- 🔴 **Decide whether 5 October shows a contract or a promise**, and tell the client
  which, before the invitation stands as an expectation.
- 🔴 **The questions Aurel Mrruku needs answered are not written down anywhere.**
  Nobody has listed them.
- ⚠ The RID mandate form promised to customers
  ([OI-152](OI-152%20The%20RID%20mandate%20form%20promised%20to%20customers%20does%20not%20exist.md))
  is part of the same document set and still does not exist.

## 2026-09-23 — org-status check

Read-only check of Pienissimo UAT, 08:01–08:40Z, `DevMain` at `61f2a53`. Nothing was deployed or changed.

- 🔴 **Confirmed against the org:** the standard `Contract` object carries **zero custom fields** (Tooling `FieldDefinition`), and no Apex class in the org or `force-app/` writes it. The object has 4 records, all stock. `ORD-05` (contract auto-generation keyed to the product code) is **missing**. **UAT is 5 October, twelve days away.** (verified)
