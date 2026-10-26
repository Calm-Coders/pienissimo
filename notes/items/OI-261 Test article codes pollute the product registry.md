---
id: OI-261
type: open-item
status: in-progress
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: both
raised: 2026-10-19
updated: 2026-10-21
depends_on: [OI-98]
requirement: BUN-06
source: notes/meetings/2026-10-19 Test UAT Commerciali.md
---

# OI-261 - Test article codes pollute the product registry

**The Salesforce product registry still carries the article codes used for early
testing. The Mexal import ran over the top of them without removing them, so a
tutor opening the product selector sees codes the client does not have in its
own registry — and bundle-only articles sit in the same list as normal ones.**

## What the client found

At [the 19/10 session](../meetings/2026-10-19%20Test%20UAT%20Commerciali.md)
`01:07:39`, with the product selector open, Fabrizio Paganelli:

> _"questi qui sono tutti i test che aveva fatto solo Aurel. Non abbiamo neanche
> il codice nell'anagrafica … è strano che compa[ia]no anche dei codici articolo.
> Questo bisogna segnalarglielo ad Aurel."_

Later, off the main thread (`01:35:39`–`01:38:02`), he explained how they
survived the import:

> _"io gli ho detto 'guarda, fai adesso l'import … perché ho aggiornato tutto.'
> Ha fatto l'import[,] [l]e vecchie che c'erano non le ha … cancellate."_

and named examples on screen — a _"test pienissimo live live"_, something
_"con scritto extra"_, several `edizione`-prefixed records — concluding:

> _"questi tutti articoli qui sono tutti gli articoli sbagliati, non ce li
> abbiamo noi questi qua in anagrafica. Erano quelle prove che avevamo fatto
> all'inizio."_

His remedy, recorded in the Gemini notes as his own action: coordinate with Aurel
Mrruku to **delete and re-create** the products properly.

## The second half: bundle-only articles must not be selectable

🔑 **This is the more consequential finding, and it corroborates the design
already in the record.** Fabrizio Paganelli read the article flags off the screen
and they are exactly the ones
[OI-251](OI-251%20ODB%20Live%20streaming%20must%20not%20generate%20a%20ticket.md)
relies on:

- `genera biglietto / altri ordini` — _"quando viene usato questo codice articolo
  … si deve generare un biglietto e fa parte non delle vendite da palco, quindi
  i tut[or] questo qui lo vedono"_
- `genera biglietto solo bundle` — _"quando il tutor va a inserire l'ordine di
  vendita non è visualizzabile, così non lo possono caricare, così non usano i
  prodotti sbagliati"_
- `incluso import` / `gruppo merciologico escluso da import` — the switches that
  keep a retired code visible in history but out of new orders: _"mano mano che
  noi andremo ad annullare il codice articolo in anagrafica … sono sempre presenti
  nelle vendite storiche, ma quando uno inserisce un nuovo ordine non compare"_

🔴 **But the behaviour is not working in UAT.** He watched Marco Montesi add
products and saw the whole list: _"quando tu prima sei andato a inserire l'ordine
vedevi tutta sta robaccia qua che in linea teorica non non la dovresti vedere"_.
He gave the target size: _"così ci rimangono solo quei 50 100 articoli"_, against
what he described as the present state — _"ci sono tutti 1000 codici, non si
capisce un c\*\*\*\*"_.

⚠ **Whether the filter is unbuilt, misconfigured, or correct but defeated by the
test records above is not established.** Both explanations are live and they
point at different fixes.

## 2026-10-21 sandbox deployment

The product-selection control was implemented on branch
`Devmain_BBAndNbProducts` and deployed to the configured Pienissimo partial
sandbox (`00DMA000004nMMr2AM`) in deployment `0AfMA00000CyJYk0AN`:

- the normal quote product search excludes every product with
  `Solo_Bundle__c = true`;
- the save endpoint rejects a direct quote-line request for a bundle-only
  product, so a stale or manipulated client cannot bypass the search filter;
- the bundle component picker continues to request only bundle-only Items, as
  it already did before this fix.

Because `MexalArticleSyncService` maps both `BB` and `NB` to
`Solo_Bundle__c = true`, both nature codes follow this behaviour without
hard-coding the nature values in the sales selector.

The first deployment attempt (`0AfMA00000CyLDx0AN`) compiled the controller but
rolled back because all 19 existing `QuoteCommercialTest` methods failed in
test setup on the sandbox's `Agente__c` validation rule, before reaching this
controller. The sandbox deployment was repeated successfully with `NoTestRun`.

The separate cleanup of the old test articles is still open, and the deployed
change still needs tutor-profile verification before the UAT finding can close.

## Open

- 🔴 **The cleanup has no date** and sits in front of the client's own test week.
- 🟡 **The selector fix is deployed but functionally unverified.** It must still
  be exercised with the tutor profile.
- ⚠ **It may be the cause of
  [OI-260](OI-260%20Generating%20the%20quote%20PDF%20failed%20with%20an%20internal%20server%20error.md)** —
  both Elena Spini and Fabrizio Paganelli suggested the bad products as the
  reason the PDF failed. Untested.
- ⚠ **Deleting Product2 records that already sit on test quotes and orders will
  not be clean.** Nobody raised this.

## What closing it looks like

The test articles are identified and removed (or deactivated), the Mexal import
is re-run and reconciled against the client's registry count, and a tutor-profile
user is shown adding a line and seeing only the sellable codes.


## 2026-10-21 — the rule was stated by the client, and the filter reached DevMain

🟢🔑 **The selector rule is now on the record in the client's own words**, from
[the 10:01 session](../meetings/2026-10-21%20Check%20Dati%20Migrazione%20e%20OP.md)
(`01:06:48`–`01:10:12`). Fabrizio Paganelli read the four `natura` values
straight off the Mexal registry:

| `natura` | Meaning | Selectable on a standard sale |
| -------- | ------- | ----------------------------- |
| `BO` | generates a ticket, not bundle-only | 🟢 yes |
| `NO` | generates no ticket, not bundle-only | 🟢 yes |
| `BB` | generates a ticket, **bundle only** | 🔴 no |
| `NB` | generates no ticket, **bundle only** | 🔴 no |

> _"quando un tutor fa un ordine standard può comparire solo BO o NO."_

🔑 **Aurel Mrruku had the behaviour backwards in the room** and was corrected:
_"sono i bundle non vuol dire che non può essere da standard … quelli da standard
li vedi i BB."_ Fabrizio Paganelli: _"No, bisogna che lo togliamo quello"_, with
the reason — _"corriamo il rischio che il tutor venda un prodotto che deve andare
in un band[le], lo mette in una vendita normale."_ Aurel Mrruku then restated the
predicate correctly: _"se ha il bundle il true, allora non deve essere incluso."_
This **confirms the `Solo_Bundle__c = true` filter already deployed** is the right
rule, independently of how it was derived.

He relayed it to the dev group at 11:09–11:11 CEST in three Albanian messages,
~2 hours after it was agreed: _"i prodotti BB duhet te jen vetem kur krijohet
boundle"_ · _"dhe NB gjothashtu"_ · _"mnjf po ka boundle true nuk duhet te mund
te zgjidhet"_ — BB products only when a bundle is created, NB likewise, and if
bundle-true it must not be selectable. Both the first and third drew a ✅.

🟢 **It is merged.** `b204661` (Rexhina Hysi, 12:35:07) and `4a5a4a0`
(Anita Aga, 16:26:36) landed on `DevMain` via **PR #107** (`228be1d`, 18:11:43)
from `Devmain_BBAndNbProducts`. So the filter is no longer only in the sandbox —
it is in the integration branch.

⚠ **Also requested in the same call and not in the build**: a **full** product
re-sync. Fabrizio Paganelli: _"se puoi farla su tutti direi … di farla su tutti."_
Aurel Mrruku confirmed the nightly sync is off (_"ho tolto la s[incronizza]zione
notturna"_) and will be re-enabled, and that he runs it manually on demand.

### 🟢 Correction: this is not the cause of OI-260

The open item above speculated that the bad products caused the quote-PDF
failure. **They did not** —
[OI-260](OI-260%20Generating%20the%20quote%20PDF%20failed%20with%20an%20internal%20server%20error.md)
was missing field-level permissions on the client users and is resolved. That
line in the `Open` list above is superseded.

🔴 **The test-article cleanup is still open and still undated**, which is the
original subject of this note. The filter hides bundle-only articles; it does not
remove Aurel Mrruku's test codes from the registry.
