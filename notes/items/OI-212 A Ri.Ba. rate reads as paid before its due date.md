---
id: OI-212
type: open-item
status: open
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: ROMI
raised: 2026-10-07
updated: 2026-10-15
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

## 🔴 2026-10-08 - not fixed, second night, and the day had the author in the code

Re-verified against `DevMain` at **`8879f08`**. Both predicates are unchanged:

```apex
// MexalScadenzarioSearchService.cls
deadline.paid =
  deadline.paymentStatus == 'P' ||
  deadline.paymentStatus == 'E';
```

```xml
<!-- Scadenza_Fattura__c/fields/Pagata__c -->
OR(ISPICKVAL(Stato_Pagamento_Mexal__c, "P"), ISPICKVAL(Stato_Pagamento_Mexal__c, "E"))
```

No date condition in either. `dt_sca_pg` is still parsed into `deadline.dueDate`
a dozen lines above the predicate that ignores it.

⚠ **Aurel Mrruku was in these files today.** `MexalOrderSendService`,
`MexalArticleSyncService` and `WoocommerceOrderService` all changed, and
`MexalScadenzarioSearchService` was touched by the `without sharing` sweep
(`f292b72`) — the one-line sharing modifier only.
[The 08/10 internal session](../meetings/2026-10-08%20Internal%20Test.md) worked
through _"la logica complessa legata alla data di scadenza e allo stato di
pagamento impostato su 'da pagare'"_ for the flows and **did not qualify the paid
test by due date**. The defect was neither raised nor fixed.

**Five days to the 13/10 production confirmation**, and this decides when a
ticket becomes available.

## 🔴 2026-10-09 — a third night, unmoved, at `edc063b`

Re-verified tonight against `DevMain` **`edc063b`**. **Both predicates are
byte-for-byte unchanged**:

- `MexalScadenzarioSearchService.cls:205-207` — `deadline.paid =
  deadline.paymentStatus == 'P' || deadline.paymentStatus == 'E';`
- `Scadenza_Fattura__c.Pagata__c` — `OR(ISPICKVAL(Stato_Pagamento_Mexal__c,
  "P"), ISPICKVAL(Stato_Pagamento_Mexal__c, "E"))`

`dt_sca_pg` is still parsed into `deadline.dueDate` at lines 195-197, in the
same loop, **ten lines above the test that ignores it**. The field's own
`description` still reads _"Vero quando lo stato Mexal e P o E."_ — the
unqualified rule, documented as intended behaviour.

⚠ **Aurel Mrruku was in the Mexal classes again today** — `c147aa0` changed
`MexalArticleSyncService` and `MexalSearchCalloutService`, and `c5e4a1e` added
`MappaturaEdizioneProductSearch`. Neither touched the payment predicate.
**Nothing in any source tonight — mail, chat, meeting, commit or ruling —
mentioned it.**

🔴 **Four days to the 13/10 production confirmation, twelve to go-live.** The
fix remains what the 07/10 ruling asked for: `E` counts as paid only once
`dueDate` is in the past. The data is already in the method.

## 🔴 2026-10-12 - unchanged a fourth night, and the confirmation is tomorrow

Re-verified against `DevMain` at **`a061f55`**:

| Checked | State |
| ------- | ----- |
| `MexalScadenzarioSearchService.cls:205-207` | `deadline.paid = deadline.paymentStatus == 'P' \|\| deadline.paymentStatus == 'E';` — **no date condition** |
| `dueDate` | still parsed at **line 194** from `dt_sca_pg`, eleven lines above the predicate that ignores it |
| `Scadenza_Fattura__c.Pagata__c` | formula still `OR(ISPICKVAL(…,"P"), ISPICKVAL(…,"E"))` |
| The field's `description` | still _"Vero quando lo stato Mexal e P o E."_ — the unqualified rule documented as intended |
| `git log --since 2026-10-09T22:00Z` on both files | **no commits** |

Four commits landed on the project over the weekend window, none of them in these
files. **Nothing in Gmail, Slack, Drive, Fathom or any commit message mentioned
this defect**, a fourth consecutive night.

🔴 **The 13 October production confirmation is tomorrow.** The 07/10 Mexal call
agreed as `Concordato` that state `E` counts as paid **only if the due date has
passed**; five days later the code still releases a ticket when a Ri.Ba. is
merely presented. ⚠ The one session that would have exercised the payment path
end to end — [the 12/10 e2e UAT](../meetings/2026-10-12%20UAT%20Test%20e2e.md) —
**was postponed to 14 October**, so the confirmation now falls before the test.

The correction is unchanged in scope: one date comparison in a method that
already holds the date, and the same condition on the formula field.

## 🔴 2026-10-13 — unchanged a fifth night, and the confirmation date has passed

Re-verified byte-for-byte against `DevMain` **`21d6686`** after **13 commits**
today:

- `MexalScadenzarioSearchService.cls:205-207` —
  `deadline.paid = deadline.paymentStatus == 'P' || deadline.paymentStatus == 'E';`
  with **no date condition**, eleven lines below `deadline.dueDate` being parsed
  from `dt_sca_pg` at line 195. The method already holds the date it ignores.
- `Scadenza_Fattura__c/fields/Pagata__c` —
  `OR(ISPICKVAL(Stato_Pagamento_Mexal__c, "P"), ISPICKVAL(Stato_Pagamento_Mexal__c, "E"))`,
  and its `description` still documents the unqualified rule as intended:
  _"Vero quando lo stato Mexal e P o E."_
- **No commit touched either file.** Latest on the Apex is `f292b72`, which
  predates the finding.

🔴 **The 13/10 production confirmation was today and this was not fixed.**
Nothing in any swept source — mail, chat, meeting, commit or ruling — mentions it.
**Fifth consecutive night.**

⚠ **And the 13/10 session walked straight past it.** The client built a quote with
**four payment tranches due 31 October, 30 November, 31 December and 31 January**,
on payment terms _"RID fine mese data fattura"_ — the Ri.Ba. family this row is
about — and the order reached Mexal. **Four of those four due dates are in the
future**, which is precisely the condition under which an `E` state reads as paid.
The return leg that would expose it (`MexalInvoiceSyncScheduler`, the scadenzario)
is not recorded as having run against that order, so **the defect was set up and
not triggered**.

🔴 The e2e that would exercise the payment path is **tomorrow, 14/10**.

## 🔴 2026-10-14 — sixth night unmoved, and the return leg finally ran without touching it

**Re-verified byte-for-byte at `DevMain` `29d1002`.** Both predicates are
identical to every previous night:

- `MexalScadenzarioSearchService.cls`, `mapDeadlines`:
  `deadline.paid = deadline.paymentStatus == 'P' || deadline.paymentStatus == 'E';`
  — eleven lines below the `dueDate` the same method parses from `dt_sca_pg`.
- `Scadenza_Fattura__c.Pagata__c`:
  `OR(ISPICKVAL(Stato_Pagamento_Mexal__c,"P"), ISPICKVAL(Stato_Pagamento_Mexal__c,"E"))`,
  description still _"Vero quando lo stato Mexal e P o E."_

`git log` on both files is unchanged — last touched by `f292b72` and `731c7ac`.
**No commit in the window went near either.**

## 🔑 But the return leg ran, for the first time on a real invoice

[The 14/10 e2e](../meetings/2026-10-14%20UAT%20Test%20e2e.md) drove the whole
payment chain that this row has been waiting for a test of
(`01:07:56`–`01:23:29`): one €20,000 order split into four deferred invoices,
invoice 10 for €5,000 posted against customer 50171, the scadenzario synced back
into Salesforce, the amount, tranche and payment state read in the Salesforce UI,
and a €5,000 collection registered and synced again.

🟢 **Salesforce showed `non pagato`, correctly.**

⚠ **And that is not a test of this defect.** The payment was a **bonifico**. This
row is about Mexal status **`E`**, which the record associates with the Ri.Ba.
family — the condition that makes `paid = P || E` wrong is a *future-dated* `E`,
and a bonifico does not produce one.

🔴 **So the defect has now survived two consecutive sessions that set it up and
did not trigger it.** On 13/10 the client built four future-dated tranches on
_"RID fine mese"_ terms and the return leg never ran; on 14/10 the return leg ran
and the terms were bonifico. **The one combination that fails — Ri.Ba.-family
terms plus a return leg — has still never been exercised**, and the 13/10
production confirmation date passed two days ago.

⚠ **The exposure grew today.** The same session agreed to run the scadenzario
sync **every half hour to an hour**
([OI-239](OI-239%20The%20Mexal%20scadenzario%20sync%20must%20run%20every%20half%20hour%20and%20nothing%20schedules%20it.md)).
A predicate that reads a rate as paid before its due date is read 48 times a day
instead of once, into a field administrators are being taught to trust — and the
order roll-up it feeds (`incassato`) was shown to the client in this session as a
headline figure.

## 🔴 2026-10-15 - seventh night, and nothing at all happened

Verified by repository arithmetic against `DevMain` at **`544cbfd`**, which is
this procedure's own 14/10 commit: **`DevMain` has not advanced in twenty-four
hours.** Both predicates are byte-for-byte unchanged.

`MexalScadenzarioSearchService.cls:205-207`, last touched by `f292b72` on
**8 October** — seven days ago, and for an unrelated reason
(_"without sharing class"_):

```apex
deadline.paid =
  deadline.paymentStatus == 'P' ||
  deadline.paymentStatus == 'E';
```

`Scadenza_Fattura__c/fields/Pagata__c` last touched by `731c7ac`, **6 October**.

🔴 **No mail, message, meeting, commit or ruling touched it.** The 15/10 session
ran seventy-seven minutes on migration and go-live and never reached payment
state. The 13/10 confirmation date is now **three days past**.

⚠ **And the exposure grew tonight rather than shrinking.** The migration method
agreed in the same session
([OI-244](OI-244%20Historical%20orders%20will%20be%20migrated%20from%20Mexal%20by%20spreadsheet.md))
loads ~10,000 historical orders a year and **derives** their invoiced and
collected state by running this reconciliation against the Mexal id, rather than
importing it. So a predicate that reads an unpaid Ri.Ba. rate as paid would be
applied at migration scale, to historical data, on go-live day, with
[OI-239](OI-239%20The%20Mexal%20scadenzario%20sync%20must%20run%20every%20half%20hour%20and%20nothing%20schedules%20it.md)
then re-reading it forty-eight times a day. **Nobody has connected these**, and
the figure it feeds — `incassato` — is the one shown to the client on 14/10.

The correction is still one date comparison, in a method that already holds the
due date eleven lines above.
