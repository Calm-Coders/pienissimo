---
id: OI-226
type: open-item
status: open
owner: Fabrizio Paganelli
with: Aurel Mrruku
org: both
raised: 2026-10-09
updated: 2026-10-09
depends_on: [OI-96]
blocks: [go-live]
source: notes/meetings/2026-10-09 Accesso e Tema Prodotti.md
---

# OI-226 - The gruppo merceologico stands in for the flag annullato only for the tests

**Mexal's `cod_grp_merc` now decides whether a product is active in Salesforce.
It was adopted as an explicit temporary workaround for the UAT, it is built and
committed, and reverting it later requires a code change in production that
nobody has scheduled or assigned.**

Agreed at [the 09/10 call](../meetings/2026-10-09%20Accesso%20e%20Tema%20Prodotti.md)
(`00:05:07`–`00:08:08`), built the same afternoon.

## Why the stand-in exists

The field the sync should read is **`flag annullato`**. Fabrizio Paganelli cannot
touch it: it is live in Zoho and changing it breaks the running system —
_"Siccome adesso io questo qui non lo posso toccare, sennò viene fuori casino con
Zoo."_ Salesforce already carries the gruppo merceologico, so he set it to `S` on
the articles that should be active and asked Aurel Mrruku to key off that
instead, for the tests: _"ho pensato di utilizzare per fare i test un escamotage
solo in questo momento."_

Just over **30 article codes** stay active under it, which is the point — it
makes a usable test catalogue out of 1,076 articles.

## 🔴 The warning Aurel Mrruku attached, in his own words

> _"dobbiamo essere molto attenti, Fabrizio, perché nel momento in cui decidiamo
> o teniamo sempre il gruppo merceologico oppure nel momento in cui decidiamo di
> non usare più il gruppo merciologico, ma il Fleg annullato, io devo fare un
> cambiamento a codici in produzione, sappialo."_

And the reason it is a row rather than a footnote:

> _"il problema è se succede adesso, in questi giorni, in queste settimane, non
> vedo nessuna difficoltà, ma se dopo 2-3 mesi decidete di non usare più questo
> flag e io non sono più su sul progetto, lì è un casino. Quindi decidiamo un
> momento anche con la parte di business."_

Fabrizio Paganelli's answer was _"Sì, sì, sì… ce lo ricordiamo"_ — **a shared
memory, not a decision, an owner or a date.** Aurel Mrruku explicitly asked for
the business to be brought in. **That has not happened**, and the Zoho contract
expires **31 October 2026**, which is when the `flag annullato` constraint that
forced the workaround disappears.

## What is built

`c147aa0` (Aurel Mrruku, 09/10 16:56 CEST, **in `DevMain`** via PR #91) changes
`MexalArticleSyncService` and `MexalSearchCalloutService` to read `cod_grp_merc`
and set `IsActive` on **new and existing** products, overriding
`gest_annullato` / `gest_attiva`. The decode and the UAT alignment figures are in
[the article sync note](../objects/The%20Mexal%20article%20sync%20to%20Product2.md).

⚠ **The note written in that commit says "not committed, not in Prod".** It was
written and committed in the same change, so the first half is stale on arrival;
the second half still holds. Corrected in the note.

## 🔴 What closing this requires

1. **A business decision**: gruppo merceologico permanently, or back to
   `flag annullato` once Zoho is gone. Aurel Mrruku asked for it; nobody owns it.
2. **If it reverts, a production code change** — two classes, after go-live, on a
   field that governs which products exist for sales. Unscheduled.
3. **A date.** The natural one is the Zoho dismissal, **31/10**, ten days after
   go-live and the point at which keeping the workaround stops having a reason.

⚠ **The risk Aurel Mrruku named is the realistic one**: the decision outlives the
people who understand it. This row exists so that the next agent or developer
finds the stand-in before finding the surprise.

## ⚠ The same call hand-corrected the key underneath it

Fabrizio Paganelli found the article **categories** on Mexal wrong in the same
conversation — the same code used for consulenze and for Pienissimo Intensive,
and _"su Maxal adesso ce l'ho un attimo invertito"_ — and said he would fix them
directly in Mexal. Those categories are what
[OI-96](OI-96%20Edition%20mapping%20table%20on%20Salesforce.md)'s new
category-wide edition mapping keys on. **Both the active flag and the category
key moved by hand, in the client's ERP, on the day the code that reads them was
written.** Neither has been re-verified from Salesforce since.
