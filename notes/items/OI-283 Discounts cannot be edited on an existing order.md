---
id: OI-283
type: open-item
status: open
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: ROMI
raised: 2026-10-22
updated: 2026-10-23
depends_on: [OI-207]
source: notes/meetings/2026-10-22 Check Excel Migrazione.md
---

# OI-283 - Discounts cannot be edited on an existing order

**A tutor who adds an order, generates the PDF and then notices a missing
discount cannot go back and apply it. `Gestisci Prodotti` implements the
discount on add and a delete button; the edit path is not built. The client
found this himself in UAT, deliberately walking his own staff's most likely
mistake.**

Found at `00:23:55`–`00:26:29` of
[the 22/10 session](../meetings/2026-10-22%20Check%20Excel%20Migrazione.md).

## What he did

Fabrizio Paganelli described the test as a user story, not a bug report:

> _"mi sono messo nei panni di un tutor. Inserisco un ordine, genero un PDF prima
> di mandarlo al cliente, lo guardo. Mi accorgo che ho sbagliato, mi sono
> dimenticato di mettergli uno sconto. Prendo e vado a provare a mettergli lo
> sconto"_

He first tried it on the tranche row; Aurel Mrruku redirected him to
`Gestisci Prodotti`, where the discount column exists. It still did not take.

## Confirmed from ROMI's side in the room

Aurel Mrruku checked with the developers during the call and confirmed the gap
is real and known:

> _"mi hanno detto che hanno fatto fino adesso solo quando li aggiungi, quindi
> non quando li modifichi"_

> _"L'hanno messo solo qua e hanno messo anche il tasto cancella a destra, però
> … non l'hanno ancora finito su modifiche."_

🟢 **So this is incomplete work, not a defect in shipped behaviour.** The
discount landed in `4a5a4a0` on 21/10 with 370 lines of LWC jest
([OI-207](OI-207%20The%20quote%20and%20order%20layouts%20omit%20the%20commercial%20fields%20the%20client%20requires.md)),
covering add and delete. Edit was never in that commit and nothing in the record
says it was deliberately deferred.

## 🔴 Why it matters more than it reads

- **The correction is invisible until the PDF.** The order is generated, the PDF
  is produced, and only then does the tutor see the error — which is exactly the
  moment the current build gives them no way back. The documented workaround is
  delete and re-add the line.
- **It compounds
  [OI-281](OI-281%20Tutors%20must%20use%20Aggiorna%20Anticipay%20when%20creating%20an%20account.md).**
  That row records a contract-correctness control delivered by tutor training
  alone. This row removes the tutor's ability to correct a priced order before it
  goes out. Both land on the same person at the same step.
- 🔴 **It sits on top of
  [`SAL-12`](../../requirements/pienissimo-requirements.yaml), which still reads
  _"no discretionary discounts"_, `status: agreed`.** The register has not been
  amended, and this is now the second row built on the contrary assumption.

## ⚠ The requirement has still never been stated

Elena Spini asked the client directly — _"tu qua la modifica come pensavi di
farla, Fabrizio?"_ — and he declined to answer, because ROMI said the screen was
still being worked on:

> _"visto che ci state lavorando non dico niente. Niente ancora perché sennò
> corro rischio di dire delle stupidate."_

🔑 **So the only thing on the record is that the current behaviour is wrong, not
what the right behaviour is.** Whether an edit recalculates the tranche, what
happens to an already-generated PDF, and whether an order sent to Mexal may still
be edited are all unasked.

## Open

- 🔴 **No owner inside ROMI named.** Aurel Mrruku said _"chiedo un attimo ai
  ragazzi"_ and named `Re[x]hina` mid-sentence; **that is not an assignment** and
  is recorded as spoken only.
- 🔴 **No date.** It was not called a blocker by either side.
- ⚠ **Unknown whether the same gap exists on the quote**, which shares
  `quoteManageProducts`. Nobody tested it.

## What closing it looks like

The edit path is built on `Gestisci Prodotti` for both quote and order, the
tranche recalculation behaviour is stated, and the client confirms the corrected
PDF is what he expects. **`SAL-12` is reconciled first or in the same pass.**

## 2026-10-23 - the quote path is answered, an edit path was shown, nothing is merged

This note left three things open. One is answered, one moved, one did not.

### 🟢 The quote path **does** share the gap — question answered

The note said _"Unknown whether the same gap exists on the quote … Nobody
tested it."_ The client tested it the next morning and reported it live in
[the 16:00 call](../meetings/2026-10-23%20Import%20Ordini%20Migrazione.md),
on a **new Opportunity**, not an order:

> _"vado direttamente a a inserire una nuova opportunità sull'azienda … prezzo
> di listino, sconto e nuovo prezzo. Se io qui ci metto il 20%, vedi, non si non
> si aggiornava sta cosa"_

🔑 **It is the same component and the same incomplete work, one object earlier.**
Recorded here rather than as a new row because the fact is the one this note
already holds: the discount column on `Gestisci Prodotti` is finished for add
and delete and not for change. The symptom differs — on the quote the typed
percentage does not recalculate the price on screen — and the cause is the same
component, by Aurel Mrruku's own account: _"sto lavorando proprio su questo
componente"_, _"questo stavo aggiustando stamattina."_

### 🟡 An edit path was demonstrated and accepted, and it does not close this

Aurel Mrruku walked the client to it in the call: _"Fai gestisci i prodotti
adesso. Eh, vedi che c'è la matita a destra?"_ → _"Fai modifica, vedi che la
puoi modificare."_ Fabrizio Paganelli accepted it — _"Ah, perfetto. Così lo
posso modificare"_, _"Va benissimo, dai, va benissimo."_

🔴 **Three reasons it stays open:**

1. **It was shown on the quote**, not on the existing order after a generated
   PDF, which is the scenario this row was raised against. That path was not
   retried in the call.
2. **It is work in progress by his own statement**, twice in the same minute —
   _"È proprio su questa schermata che sto lavorando."_
3. 🔴 **It is not on `DevMain`.** `origin/DevMain` is still `ebc2c5b`.

### 🔴 The build exists and is unmerged

Anita Aga, **`3c66b27`** _"Modified the Gestici Prodotti Component"_, 23/10
16:26 CEST on `DevAnita22` — 25 minutes after the call ended — touching
`quoteManageProducts.html`, `.js`, `.css` and `QuoteManageProductsController`
(+76/−7). The two earlier commits on the same branch the same day (`9512ee0`,
`6e7dacb`) are other work.

⚠ **No pull request.** ⚠ **No LWC jest in these three commits**, against 370
lines added for the discount itself in `4a5a4a0`.

### Unchanged

- 🔴 **The requirement is still unstated.** The client declined on 22/10 and
  nothing on 23/10 asked again. What an edit does to the tranche, to a generated
  PDF, or to an order already sent to Mexal remains unasked.
- 🔴 **No ROMI owner of record and no date.** Anita Aga's commit is evidence of
  who is doing it, not of an assignment.
- 🔴 **`SAL-12`** still reads _"no discretionary discounts"_, `status: agreed`.
  **Sixth session on discounting with the requirement uncited.**
