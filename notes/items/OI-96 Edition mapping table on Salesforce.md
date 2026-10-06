---
id: OI-96
type: open-item
status: open
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: both
raised: 2026-08-26
updated: 2026-10-05
depends_on: [OI-46, OI-77]
blocks: [OI-53, OI-84]
source: notes/meetings/2026-08-26 Review Temi Integrazione Mexal.md
---

# OI-96 - Edition mapping table on Salesforce

**A new, manually maintained Salesforce table that decides which event edition
an order line belongs to.** Agreed in principle at the
[26 August Mexal review](../meetings/2026-08-26%20Review%20Temi%20Integrazione%20Mexal.md).

## The shape

One row per combination:

| Column        | Meaning                                                            |
| ------------- | ------------------------------------------------------------------ |
| article code  | the Mexal `_ARCOD`                                                 |
| data inizio   | start of an **order-date** window                                  |
| data fine     | end of that window                                                 |
| edizione      | the Campagna Figlio this window maps to                            |
| **colonna G** | the **event date**, entered by hand, unrelated to the window above |

At order time, each **order line** is matched on the **order date** against the
window for its article code, and takes the edition from the row that matches.

## Three properties that are easy to get wrong

1. **It resolves per order line, not per order.** Elena Spini asked and Fabrizio
   Paganelli confirmed: _"a livello di riga ordine."_ One order legitimately
   splits across editions when it carries articles with different windows.
2. **The windows are arbitrary.** They are **not** the calendar year of the
   edition and **not** the event's own dates — they are the period during which
   orders for that edition are taken, set by hand. Fabrizio Paganelli's worked
   example: Food Marketing Festival 2027 takes orders from 1 Oct 2025 to
   30 Sep 2026. Aurel Mrruku restated it back and got confirmation:
   _"puoi mettere data a piacere… io mi baso solo su quelle date."_
3. **The order date governs, not the tranche date.** Tranches exist only to
   define payments — see [OI-50](OI-50%20Tranche%20object.md).

## Why column G exists separately

The order-date window is deliberately unrelated to when the event happens, so it
cannot drive anything post-event. Column G carries the real event date, and it is
what the **no-show deactivation** keys on: three days after the campaign ends,
un-consumed tickets go to not-consumed. Elena Spini asked for that logic; Aurel
Mrruku asked for the extra column to support it.

## 🔴 What it replaces

**The "one active child campaign per parent" rule, which is now dead.** Elena
Spini killed it in the session — a bundle spanning two events cannot resolve to a
single active edition. See
[the campaign parent and child model](../objects/The%20campaign%20parent%20and%20child%20model.md),
where that rule was recorded as the agreed 24 August configuration.

It also supplies, at last, the concrete mechanism behind
[OI-46](OI-46%20Bundle%20classification%20picklists.md)'s ruling that the edition
comes from the order date rather than the product. `Product2.Anno_Solare__c` is
not merely unnecessary now — this table is what does its job.

## What is not settled

⚠ **The Gemini decision list files this under "Da approfondire", and it is the
only item there.** Aurel Mrruku asked for a dedicated hour with concrete worked
examples before anything is built: _"mettiamo un esempio di ordine con diversi
prodotti che cadono su campagne diverse."_ **That session is not scheduled.**

Also unstated:

- **Which object this table is.** Custom object, custom metadata type, or
  something else — nobody said. It is described only as _"una tabella aggiuntiva
  su Salesforce… gestita a mano"_.
- **Who maintains it.** Administration is implied by "we configure it by hand",
  but no owner was named.
- **What happens when an order date falls in no window, or in two.** No rule was
  discussed. Given Fabrizio Paganelli's own _"dobbiamo essere svizzeri nella
  gestione di questa tabella"_, gaps and overlaps are the obvious failure mode
  and there is no control against either.

**Entirely unbuilt.** Nothing in `force-app/` implements it.

## ✅ 2026-09-04 — built, and faithfully

**`Mappatura_Edizione__c` exists**, merged to `DevMain` in PR #34 (commit
`68c4342`, Anita Aga). The field-by-field decode, the matching logic and what was
added beyond the specification are in
[the build note](../objects/The%20Mappatura%20Edizione%20object.md).

🟢 **All three properties this note flagged as easy to get wrong are honoured** —
resolution is per order line **and per bundle component**, the windows are
order-date windows matched on `Order.EffectiveDate`, and _colonna G_ exists as
`Data_Evento__c` with its purpose written into the field description.

🟢 **Two things were built that nobody specified**: the product key is a
**lookup to `Product2`** rather than a text article code, and **overlapping
active windows are refused** by a before-save trigger. Both are improvements on
what this note described.

🔴 **The table is empty and has no maintainer** — and because the matching code
throws rather than degrading, an unmapped product now blocks an order's move to
`Incassato`. That is
[OI-121](OI-121%20The%20edition%20mapping%20table%20has%20no%20rows%20and%20no%20owner.md).

**This item stays open until the rows exist.** The mechanism is delivered; the
mapping it exists to hold is not.

## 🔴 2026-09-24 — the empty mapping broke order creation twice, once in front of the client

**The consequence this note and
[OI-121](OI-121%20The%20edition%20mapping%20table%20has%20no%20rows%20and%20no%20owner.md)
predicted arrived, on the first day of client acceptance.**

1. **11:13:00Z — a sandbox Apex exception mail**, Pienissimo srl partial sandbox:

   > `OrderItemTrigger: execution of AfterInsert caused by:`
   > `OrderTriggerHandler.TicketGenerationException: Nessuna mappatura edizione trovata`
   > `per il prodotto ACADEMY alla data ordine 2026-09-24.`
   > `Class.OrderTriggerHandler.assignCampaigns: line 334`
   > `Class.OrderTriggerHandler.createTicketsForOrderLines: line 109`

2. **In the 15:00 CEST client session**, the first DocuSign send never left. Aurel
   Mrruku, `01:26:58`: _"non ti arriverà mai DocuSign perché ho messo dei prodotti che non
   sono sulla mappatura."_ He named the cause at `01:39:14`: ticket-type products with **no
   link to a child campaign**. He recovered by switching to a correctly configured
   product, and the chain then ran end to end.

🔑 **This confirms the failure mode the note describes**: the matching code **throws rather
than degrading**, so an unmapped product does not merely skip ticket generation — it
aborts the order-item insert, and with it the quote-to-order-to-DocuSign chain.

🟢 **Work started the same afternoon.** `bfd0fd3` (`DevAnita`, 24/09 15:47 CEST, Anita
Aga, **PR #60, open**) — _"Changed the logic form Mapatura Edizione"_ — rewrites
`MappaturaEdizioneTriggerHandler` (+119/−… lines), extends `Mappatura_Edizione__c` by
~142 lines of object metadata, and touches `Attiva__c`, `Data_Evento__c`, `Data_Fine__c`
and `Data_Inizio__c`. ⚠ **Not read line by line here**, and not on `DevMain`.
⚠ The same commit removes two lines from `OrderTriggerHandlerTest.cls`.

🔴 **Ticket UAT is 30 September** and the mapping stood at **13 of 51** at the 23/09 org
check. A rewritten handler does not add rows.

## 2026-09-25 — the same fault, live, for the second day running

At [UAT Recall Tutor e Bundle](../meetings/2026-09-25%20UAT%20Recall%20Tutor%20e%20Bundle.md) (`00:30:40`), the first WooCommerce test order
failed with `TicketGenerationException: Nessuna mappatura`. Aurel Mrruku created a
mapping row live, pointing the product at a test edition, and the order then landed.
He told the client: _"dobbiamo per forza poi mappare i prodotti… alle edizioni per fare i
test."_ PR #60 (the handler rewrite) **merged at 08:17Z**. Anita Aga (Slack, 10:47 CEST):
only one test bundle has a mapping. Gemini action for Aurel Mrruku: _"Completare la
mappatura dei prodotti alle campagne e alle edizioni necessarie per i test"_.
**Ticket UAT is 30/09.**

## 🔴 2026-09-29 — the same exception, in the sandbox, the day before ticket UAT

A Salesforce sandbox error mail at **08:59:16Z** (partial sandbox
`ability-customization-52152`, org `00DMA000004nMMr`):

> `OrderItemTrigger: execution of AfterInsert caused by:
> OrderTriggerHandler.TicketGenerationException: Nessuna mappatura edizione trovata
> per il prodotto PIENISSIMO LIVE LIVE alla data ordine 2026-09-29.`
> `Class.OrderTriggerHandler.assignCampaigns: line 332`

**Third occurrence on the record** — 24/09 in front of the client, 25/09 at the
Recall Tutor UAT, now 29/09. The rewritten `MappaturaEdizioneTriggerHandler` from
PR #60 did not change the failure mode, because the fault is **missing rows, not
broken code**: the handler still throws rather than degrading, so an unmapped
product aborts the whole order-item insert.

🔴 **Ticket UAT is 30/09, 14:00–16:00 CEST**, with Fabrizio Paganelli, Elisa
Migliano and Rebecca Marmo invited, and the mapping last read at **13 of 51**. The
failing product is named — `PIENISSIMO LIVE LIVE` — so this one is a row somebody
can add before the session.

⚠ `2ed8a56` (Anita Aga, 29/09 18:19 CEST, `DevAnita28/09`, **unmerged**) touches
`MappaturaEdizioneTriggerHandler.cls` (+17/−…). Not read line by line here, and not
on `DevMain`.

## 🔑 2026-09-30 — the client changed the window's source, and reversed a property he set on 26 August

At [the ticket UAT](../meetings/2026-09-30%20UAT%20Biglietti%20Asset%20Campagne%20ed%20Eventi.md)
(`00:29:10`, restated at `00:34:10`) Fabrizio Paganelli objected to associating
article codes that run across years to single editions, and asked for the window
fields to be **the campaign's `data inizio` / `data fine competenza`** instead of
the event's start and end dates:

> _"potresti riprenderle anziché da data inizio evento a data fine evento, da data
> inizio competenza a data fine competenza… sarebbero l'intervallo iniziale finale
> che se un ordine è compreso in quell'intervallo di date, l'ordine con quel
> codice prodotto deve confluire nella campagna"_

His worked example: an order generated 1 December 2025 lands in Pienissimo Live
26; one generated in the following September lands in the next edition.

🟢 **Aurel Mrruku accepted it and costed it at half a day** — _"per me è in metà
giornata ti cambia la logica perché c'ho già tutti gli elementi"_ — and said he
would search on the **parent** campaign rather than the child (`00:30:31`).

🔴 **It reverses property 1 of this note.** Aurel Mrruku named the cost in the
room: under this model _"non possiamo avere diversi biglietti su diverse edizioni
sullo stesso ordine"_. Fabrizio Paganelli answered _"Ma infatti deve essere
così."_

**That is the opposite of what he confirmed on 26 August**, when Elena Spini asked
and he said the table resolves _"a livello di riga ordine"_ precisely so one order
could split across editions — the reason the _"one active child campaign per
parent"_ rule was killed. Later evidence wins, so the 30/09 ruling stands, but
**both dates are on the record and the reversal was not acknowledged by either man.**

⚠ **Consequences nobody worked through:**

- **A bundle spanning two events was the original reason for per-line
  resolution.** [OI-181](OI-181%20Stage-sale%20bundles%20need%20their%20tranches%20defined%20at%20bundle%20creation.md)
  prices bundle components against tranches that deliberately fall in different
  months, and the payment gate agreed the same afternoon assumes exactly that. How
  a one-edition-per-order rule and a multi-event bundle coexist was **not asked**.
- The built object resolves **per order line and per bundle component**
  ([the build note](../objects/The%20Mappatura%20Edizione%20object.md)). Whether
  the new rule removes that or merely constrains the data is unstated.
- The before-save guard **refusing overlapping active windows** becomes far more
  load-bearing: with competenza dates as the window, two editions may not share a
  date range at all.

🔴 **Unbuilt, and the rows are still missing.** Nothing in the session added
mapping rows; the mapping stood at **13 of 51** at the 23/09 org check and the
29/09 `PIENISSIMO LIVE LIVE` exception was **not mentioned in the UAT at all**.
Fabrizio Paganelli and Elena Spini took the action item to map products to
campaigns by hand, and Elena Spini owes Aurel Mrruku the updated product list for
database cleanup. 🔴 **Neither carries a date.**

⚠ `897b38e` (Anita Aga, 30/09 10:13 CEST) adds _"a new custom listview for
Mappatura Edizione"_ and reached `DevMain` via PR #70 — a navigation aid, **not the
logic change agreed six hours later**, and not rows.


## 🔑 2026-10-01 - a hard constraint on the mapping, and a live failure

[The Pre UAT build session](../meetings/2026-10-01%20Pre%20UAT.md) exercised the
mapping end to end and produced two things this row did not have.

🔴 **Competenza ranges may not overlap between sibling editions.** A bundle
product mapped to a 2027 campaign threw an error in the test. Elena Spini asked
whether an earlier competenza date could simply be set; Aurel Mrruku ruled it out
— **overlapping competenza dates are not permitted on child entities sharing the
same parent** (`01:08:59`). Rexhina Hysi remapped the product to resolve it.

This is the operative constraint behind the 30/09 UAT ruling that made the
mapping window the competenza dates. It means the mapping is not free-form: the
editions of one event must partition the timeline.

**The association rule, read back from the blueprint by Elena Spini:** an order is
attached to an edition when **the order date falls inside that edition's
competenza range**.

⚠ **The year-boundary case is mitigated by convention only.** Aurel Mrruku raised
an offer issued in one year and paid or registered in the next; Elena Spini's
answer is that competenza ranges are widened preventively. Nothing in the system
enforces or checks that widening, and widening ranges collides directly with the
no-overlap constraint above.

🟢 **Rexhina Hysi configured child campaigns for 2026 and 2027** for Academy and
Camerieri Venditori during the session, with competenza dates, and associated the
products. The mapping count was not restated; the 13-of-51 figure from 29/09 has
not been superseded by anything this sweep saw.

⚠ Elena Spini recalled a conversation with Fabrizio Paganelli about mapping
through _"il codice denominato natura"_ (`00:58:04`). **Not pursued in the
session and not resolvable from the record** — flagged, not interpreted.

🔴 **Aurel Mrruku owns the edition-mapping section of the blueprint** as a Pre UAT
action item, **with no date**.

### ⬛ The custom metadata type was not for this

`4f672a2` on `DevAnita30` — flagged on 30/09 as _"worth a diff next run"_ because
a custom metadata type is the shape question here — **merged to `DevMain` via PR
#72** at 01/10 10:03 CEST. Diffed: it is
`Product_Category_Rule__mdt`, and it serves
[OI-188](OI-188%20Performance%20Plus%20products%20are%20identified%20by%20the%20Mexal%20article%20category.md),
**not this row**. The edition mapping remains org-side configuration of child
campaigns, with no metadata-driven table.

## 🔑 2026-10-02 - the client agreed to map everything, and the mechanism was restated

At [the 02/10 client UAT](../meetings/2026-10-02%20UAT%20WooCommerce%20e%20Bundle.md)
this moved from a ROMI setup task to a standing client obligation. The agreed
wording:

> _"Tutti i codici articolo e i bundle devono essere mappati nella tabella di
> mappatura edizione associandoli all'intervallo temporale delle date di
> competenza."_

🔴 **The case for it was made by a live failure in the same session.** An order
placed autonomously on WooCommerce for the new `pienissimo lab` product did not
land, because its code was not in Salesforce; Aurel Mrruku had to map `ST054` by
hand mid-call before Sabatino Rinaldi's retry with `Pack 1009` succeeded.

🔑 **The mechanism, stated by Aurel Mrruku** at
[the 12:22 Interna](../meetings/2026-10-02%20Interna.md), correcting a draft
Blueprint sentence: _"i dati della mappatura devono essere inseriti manualmente per
poter fare la mappatura in modo automatico quando si crea l'ordine."_ Manual data
entry, automatic association at order creation. ⚠ **The Blueprint as delivered 95
minutes later still says the association itself is manual**, because Elena Spini
deferred the correction.

His closing priority at the Pre-UAT the same evening was the same thing: _"Make
sure they know how to configure the edizione, very important … documentation at the
end, explain to them."_ No such documentation exists yet.

⚠ `Da Data Competenza` and `A Data Competenza` are confirmed in the Blueprint as
**Administration's responsibility alone**, because the dates drive which edition an
order lands on.

## 🔴🔑 2026-10-05 - the mapping has an authoritative source now, and it contains a collision

[`Articoli Salesforce.xlsx`](../The%20Articoli%20Salesforce%20article%20registry.md)
arrived 05/10 09:24:17Z and is the first authoritative statement of what the
articles actually are. It changes the size and the shape of this task.

🔑 **Scope.** 1,010 articles, of which **197 are active**. Of those, **42 are
event articles** across nine categories: `E02` Food Marketing Festival 9,
`E03` Pienissimo Live 4, `E04` Academy 4, `E05` Sold Out 3, `E06` ODB Live 3,
`E07` Camerieri Venditori 4, `E08` Happy Team 3, `E09` Mastery 4, `E10`
Pienissimo Intensive 8. `E01` Tour has **no** active article. Any "mapped N of
M" figure should be measured against 42 live event articles, not against the
whole registry.

🔴 **`E10` names two different events** — `Golden Numbers` (5 articles, all
cancelled) and `Pienissimo Intensive` (14 cancelled, 8 active). The category
code is the natural key for an article→edition rule and **it is not unique**.
Nothing in the registry distinguishes the two beyond the description text, and
normalising an article's meaning out of its text is what
[the article-code risk](../risks/Risk%20-%20normalising%20an%20article%20code%20merges%20two%20products.md)
forbids. A rule keyed on `E10` will map Golden Numbers articles to Pienissimo
Intensive or refuse both.

🔴 **Not one active `E99` `blocco`.** All 469 are cancelled — see
[OI-48](OI-48%20Bundle-only%20article%20codes.md).

🔑 **The decode of `Natura Articolo`.** The Campi Oggetti workbook's
`Articoli (anagrafica)` sheet defines `Natura` as **"genera biglietto SI/NO
(mexal)"** — the article field that says whether the article produces a ticket.
The registry's `Natura Articolo` column carries `BO`, `BB`, `MS`, `HR`, `NM`,
`S`, `NO`, `ND`. ⚠ The mapping from those codes to yes/no is **not documented
anywhere**, and it governs whether an Asset is generated at all.

⚠ Also new in the same workbook: `Tipo Biglietto` is a three-value picklist —
`Executive`, `Gold`, `Diamond` — and the registry populates it. The competenza
range remains the mapping window per the 30/09 UAT; nothing in this sweep
changed that or the sibling-overlap constraint.
