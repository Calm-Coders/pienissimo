---
id: OI-168
type: open-item
status: open
owner: Aurel Mrruku
with: Elena Spini
org: ROMI
raised: 2026-09-22
updated: 2026-09-25
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

## 2026-09-24 — the Business Blueprint specifies the Contratto in full, and it is still not started

`Business_Blueprint_Pienissimo.docx` §6.2 — due to the client on 25/09
([OI-179](OI-179%20The%20Business%20Blueprint%20goes%20to%20the%20client%20with%20unchecked%20points.md))
— describes the object this note records as unbuilt:

- Generated **only** for `Performance Plus` opportunities (Attivazione or Rinnovo), with
  an exclusivity rule: a Performance Plus opportunity may contain **no other products**.
- 🔑 **It lives only in Salesforce — explicitly no synchronisation to Mexal.**
- Fields: start/end date, state (nuovo/rinnovo/in corso), total value, invoiced amount,
  collected amount.
- **Service start and end dates are not filled at signature** — signature and service
  start do not coincide. The **Strategist** enters them later by hand, with **a banner
  alert on the Contract page while the field is empty**.
- **Frozen by trigger after the invoice is issued**, to protect the historic record.
- Introduces **`Insoluto`**: an invoice issued and unpaid past its due date, driven into
  **weekly reports** to sales and administration and **monthly reports** of tranche
  falling due the following month.

⚠ The section carries the author's own `● Check con Aurel` marker.

🔴 **Nothing was built.** No commit in this window touches Contract, and the 23/09 org
check found zero custom fields on the object. **UAT is 5 October — eleven days**, and the
specification now includes a trigger-based freeze, a scheduled insoluto report set and a
page banner that did not exist in the record before today.

## 2026-09-25 - still not started, but the questions finally exist and a client session is booked

This row was opened because _"the questions Aurel Mrruku needs answered are not
written down anywhere."_ 🟢 **They now are**, as the working-through at
[the 17:00 internal session](../meetings/2026-09-25%20Interna%20post%20UAT%20Contratto%20e%20Fase%20Due.md) —
recorded field by field in
[OI-141](OI-141%20Contract%20object%20for%20Performance%20Plus%20orders.md). The
substantive ones that remain for the client: **the Zoho structure to replicate**,
and whether the object is needed at all given the tranches already carry the
financial state.

🟢 **And the session to ask them is booked** — **Monday 28 September 10:00**, with
**Fabrizio Paganelli** added: `[ROMI-PIENISSIMO] - Tema Contratti + Open Point`
(invitation 16:50Z, to Aurel Mrruku, `amministrazione@` and Fabrizio Paganelli).
That is **eight days before the 5 October UAT**, not after it.

🔴 **Nothing was built.** `Firmato` — on which the Contract creation now depends —
**is still absent from `force-app`** at `DevMain` `a5f9370`, checked this evening.
No commit in this window touches Contract. The 5 October session is ten days out and
the fallback recorded above (show the opportunity logic, promise the contract) is
still the only plan that exists.

⚠ **One specification item dropped since 24/09:** the BBP's third contract state
`in corso` was deleted in this call. The trigger-based freeze, the insoluto reports
and the page banner recorded above were **not** revisited and stand.
