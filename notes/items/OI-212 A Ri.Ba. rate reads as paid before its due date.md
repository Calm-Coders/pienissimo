---
id: OI-212
type: open-item
status: open
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: ROMI
raised: 2026-10-07
updated: 2026-10-07
depends_on: [OI-201]
blocks: [OI-75, OI-141, go-live]
severity: gating
requirement: ORD-14
source: notes/meetings/2026-10-07 Temi Integrazione Mexal.md
---

# OI-212 - A Ri.Ba. rate reads as paid before its due date

**The 07/10 vendor call agreed that a scadenzario rate in state `E` counts as
paid only when its due date is in the past. The code committed four days earlier
tests `P || E` with no date condition, on both the Apex and the formula path. A
Ri.Ba. presented on the twentieth of the month therefore reads as paid while the
money has not arrived — which is precisely the premature ticket release Fabrizio
Paganelli raised in the call.**

## The ruling

Agreed by Aurel Mrruku, Fabrizio Paganelli and Mirko Merendi at
[the 07/10 Mexal call](../meetings/2026-10-07%20Temi%20Integrazione%20Mexal.md),
recorded as `Concordato`:

> _"Viene stabilito che le rate con stato 'E' nello scadenziario siano
> considerate pagate solo se la data è nel passato, venendo altrimenti
> classificate come da pagare."_

And in the detail: _"se una rata presenta lo stato `E` ma la data di scadenza è
futura rispetto alla data odierna, il sistema dovrà considerarla come 'da
pagare' anziché pagata, evitando stati di scaduto anticipato."_

## Why the client asked for it

Fabrizio Paganelli explained that when the bank flow is generated on the
twentieth of the month, the rate moves from empty to `E` — _emesso/presentato_ —
**without the collection having happened**. Mirko Merendi confirmed Mexal treats
such a rate as theoretically paid on the basis of days of exposure, and that `P`
appears from the payment date plus those days. Fabrizio Paganelli's stated fear
was tickets being released on Salesforce before the money arrived.

That is the same availability chain
[OI-75](OI-75%20Ticket%20availability%20rule.md) governs: the 06/10 session had
just confirmed that marketing links unlock only against assets paid in full to
saldo.

## Where the code disagrees

Both surfaces checked on `DevMain` **`391b401`**, 2026-10-07:

- `force-app/main/default/classes/MexalScadenzarioSearchService.cls:205-207` —
  `deadline.paid = deadline.paymentStatus == 'P' || deadline.paymentStatus == 'E';`
  with no reference to `deadline.dueDate`, which is parsed a dozen lines above
  from `dt_sca_pg`. The data needed for the fix is already in the object.
- `force-app/main/default/objects/Scadenza_Fattura__c/fields/Pagata__c.field-meta.xml`
  — `OR(ISPICKVAL(Stato_Pagamento_Mexal__c, "P"), ISPICKVAL(Stato_Pagamento_Mexal__c, "E"))`,
  described as _"Vero quando lo stato Mexal e P o E."_

`Scadenza_Fattura__c.Stato_Scadenza__c` then reads
`IF(Pagata__c, "Pagata", IF(AND(NOT(ISBLANK(Data_Scadenza__c)), Data_Scadenza__c < TODAY()), "Scaduta", "A scadere"))`.
Because `Pagata__c` wins first, an `E` rate with a future date resolves to
**`Pagata`**, and the `Scaduta` / `A scadere` arithmetic underneath it — the
whole point of [OI-208](OI-208%20Overdue%20and%20upcoming%20payments%20are%20not%20distinguished%20on%20the%20contract.md)
— never runs for it. The same swallows
[OI-206](OI-206%20The%20Insoluto%20concept%20has%20no%20invoice%20due%20date%20and%20no%20invoice%20record.md)'s
`Insoluto__c` concept for Ri.Ba. rates.

## Relationship to OI-201

[OI-201](OI-201%20Ri.Ba.%20payments%20are%20read%20as%20unpaid%20because%20only%20P%20counts.md)
is **not** reopened. The bug it recorded — only `P` counted, so every Ri.Ba.
read as unpaid — was real and is fixed. What changed is the rule: Kreosoft's
02/10 written answer (_"puoi considerarla pagata al pari dello stato P"_) was
unqualified, and the client qualified it on **07/10** with the date test. Later
evidence wins; both dates are cited here and in OI-201.

⚠ **The Gemini "next steps" line states the rule without the `E` qualifier** —
_"definendo lo stato come pagata per date di scadenza passate e da pagare per
date future"_ — which, taken literally, would mark an unpaid past-due rate as
paid. The `Concordato` wording above is the authoritative one; the summary line
is a compression and should not be built from.

## What closing it looks like

The `E` state is tested together with the due date on both paths, a rate
presented but not yet due reads `A scadere` rather than `Pagata`, and the pair
is exercised on one real Ri.Ba. invoice in UAT. Aurel Mrruku and Fabrizio
Paganelli agreed to test the payment-state handling the following week.
