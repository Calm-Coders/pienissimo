---
id: meeting-2026-10-02-interna-pre-uat-plus
type: meeting
status: active
owner: Aurel Mrruku
org: ROMI
raised: 2026-10-02
updated: 2026-10-02
source: Drive, Trascrizione, 2026-10-02 17:01 CEST (doc 1fM5afhfHo6C-L1zEIjHGVSiQQh4BCgjuP-v8_LR2V7c, read in full)
---

# 2026-10-02 Interna Pre-UAT Plus

**A Performance Plus quote was driven end to end — five tranche, signature,
order, contract — and the session opened and closed on the same unresolved thing:
the Mexal payment state.** 02/10, 17:01 CEST, **54m07s**,
**Aurel Mrruku · Elena Spini · Anita Aga · Rexhina Hysi**. ROMI-internal,
rehearsal for the Performance Plus UAT on Monday 05/10.

🟢 This session resolves last night's _"Anna"_ and _"Regina"_: Elena Spini greets
_"Hi, Anna. Hi, Regina."_ and the attendee list is **Anita Aga and Rexhina Hysi**.
⚠ It does **not** resolve _"Claudio"_, which remains unattributed.

## 🔴 The payment state, which is where it started

Aurel Mrruku's opening question, before any agenda:

> _"can we check on the line order line? Stato pagamento Mexal. What are the
> values? I think we might have a problem."_

They looked, and the field is not there — Elena Spini: _"we have only the standard
field"_; Aurel Mrruku: _"I need that field. This field is very important to
understand the contract values, all the creazione asset."_

Mid-session Mirko Merendi's answer arrived, and Aurel Mrruku restated the rule he
intends to implement:

- lookup is `ricerca scadenziario` **per codice cliente**;
- a scadenziario row exists → the invoice exists → **fatturata**;
- row present, no `P` and no `E` → **fatturata, non incassata**;
- **`P` or `E` → incassata**;
- no row at all → no payment information for that invoice.

🔴 Current behaviour, in his own words: _"right now we have a logic based on what
we receive — if we receive `P` is paid … I need to change the structure again."_
⚠ He added **_"but we need confirm by them"_** and **_"I'm going to type it
today"_**; this sweep found nothing written. See
[OI-201](../items/OI-201%20Ri.Ba.%20payments%20are%20read%20as%20unpaid%20because%20only%20P%20counts.md).

His own assessment of the risk: _"The problem is that if we start testing and the
values are not defined, it's going to be a mess."_ The integration UAT is 07/10.

## 🔑 The Performance Plus tranche model, as the client redefined it

> _"we have defined with the client that it has completely differed from what we
> did at the beginning … we define a product, we define the tranches of the
> product, and the sum of the offer is number of tranches × value of the product."_

So one product with N tranche, not N products. Demonstrated: €6,000 × 5 = €30,000.
**Fabrizio Paganelli enters the tranche count on the product in Salesforce** —
_"this job is going to be done by Fabrizio."_ Plus products are identified by
`categoria articolo` **C10 / C11**, read as attivazione and rinnovo, carry
`genera biglietto = false` because they are a service, and must not sit inside a
bundle. Mixing a tranche product with a non-tranche product in one offer is
blocked: selecting a second product deselects the first.

🔴 **The Plus products still have no real names or codes.** Aurel Mrruku, on asking
the client for them: _"he said I can't give you those products. Put whatever you
want."_ ⚠ The Performance Plus UAT is **Monday 05/10** and
`Articoli Salesforce.xlsx` has not moved since 30/09.

## 🔴 What the run exposed as missing

- **The tranche has no value.** _"missing on all the tranches, not only here,
  everywhere"_, and it must follow order amendments —
  [OI-205](../items/OI-205%20The%20tranche%20carries%20no%20value%20so%20the%20client%20cannot%20see%20what%20each%20one%20is%20worth.md).
- **`Unità di misura` is missing on every preventivo and at bundle level.** Rexhina
  Hysi confirmed the standard `QuantityUnitOfMeasure` carries only `each`;
  Aurel Mrruku ruled the value should be **`NR`**, using the standard picklist.
  🟢 Shipped the same evening as `6522417`.
- **`Insoluto` has nowhere to stand.** Reading the Blueprint clause aloud, neither
  could say whether `data scadenza fattura` exists or whether there is an invoice
  object —
  [OI-206](../items/OI-206%20The%20Insoluto%20concept%20has%20no%20invoice%20due%20date%20and%20no%20invoice%20record.md).

## 🟢 What was verified working

- **The Contract**, against the Blueprint clause by clause: data inizio/fine
  attivazione, valore totale, importo fatturato, importo incassato, `tipo contratto`
  nuovo/rinnovo, and a status of creato / parzialmente incassato / incassato. Shown
  with `ordinato` €30,000 and fatturato and incassato at zero, then walked through
  what happens when a line is paid. Also surfaced on the Account. The freeze after
  invoicing exists — _"Yes, I have already it. But right now I'm system admin."_
- **Fiscal residence**, demonstrated live: the Account's residenza fiscale computes
  from the billing country — Italia, estero extra CEE, Repubblica San Marino — off
  the metadata table, which carries codice paese, codice ISO, descrizione paese,
  nomi alternativi, codice residenza fiscale, descrizione, fatturazione elettronica
  (Italy only) and sezionale IVA (3 for Italy, otherwise 1).
- **The Mexal-created flag on the Account** exists — Elena Spini asked for
  _"il flag Mexal consolidato"_ and it was already in. ⚠ Built on Anita Aga's
  branch as `Creato_su_Mexal__c` and **not merged into `DevMain`**.

## 🔑 A correction worth keeping

Elena Spini assumed a WooCommerce order is always fully paid. Aurel Mrruku:
**only the first tranche is paid**, and the nightly job brings the rest. She
conceded. ⚠ The register still carries the rule _"WooCommerce orders are created
already Incassato (paid online)"_, which this contradicts.

## 🔴 How ROMI decided to answer the client's objection

Elena Spini reported Fabrizio Paganelli's reply, identified the contested
`Regole di Business Aggiuntive` points 1 and 2 as the multi-event aggregation per
order, said they had also objected to the `Rinuncia` part, and set the plan: use
the **Monday meeting** rather than the Wednesday call they asked for, and show the
logic live.

> _"I think that as soon as he will see the link it will change his mind because he
> doesn't have any idea of what we are talking about and I really want to make them
> change their mind."_

Aurel Mrruku agreed. See
[OI-203](../items/OI-203%20The%20client%20contested%20the%20agreed%20ticket%20logics%20before%20confirming%20them.md).

On the client's other request that day — a bundle containing a single product —
both were unbothered. Aurel Mrruku's reading: _"I think they want a code for
WooCommerce and another code for Mexal. That's the idea."_ 🟢 The Blueprint already
permits it. His closing priority: _"Make sure they know how to configure the
edizione, very important."_
