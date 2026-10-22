---
id: OI-283
type: open-item
status: open
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: ROMI
raised: 2026-10-22
updated: 2026-10-22
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
