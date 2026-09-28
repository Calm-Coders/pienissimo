---
id: OI-143
type: open-item
status: superseded
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: both
raised: 2026-09-21
updated: 2026-09-22
depends_on: [OI-50, OI-144]
superseded_by: [OI-166, OI-167]
blocks: [go-live]
severity: resolved-premise
requirement: [ORD-02, ORD-03]
source: notes/meetings/2026-09-21 Interna Temi Mexal.md
supersession_source: notes/meetings/2026-09-22 Logiche Spacchettamento Righe.md
---

# OI-143 - The tranche invoice date must be re-keyed by hand into Mexal

> 🔴 **SUPERSEDED on 2026-09-22. The premise below is wrong and this note's own
> conclusion was wrong.** Two client sessions on 22/09 —
> [Logiche Spacchettamento Righe](../meetings/2026-09-22%20Logiche%20Spacchettamento%20Righe.md)
> at 11:22 with Fabrizio Paganelli, and
> [Test Mexal](../meetings/2026-09-22%20Test%20Mexal.md) at 15:00 with Mirko Merendi of
> Kreosoft — established that **no manual re-keying of tranche dates is required.**
> The body is kept unedited below as the record of what was believed on 21/09.
> **Later evidence wins; cite both dates.**
>
> **What is actually true, as of 2026-09-22:**
>
> 1. 🟢 **The tranche due dates do travel.** A Plus order is already **n lines with the
>    same article code**, each carrying its own `data scadenza riga`, and the order
>    _"passa paro paro su Mexal"_. Administration invoices each line at its period. The
>    client has worked this way for years; Fabrizio Paganelli demonstrated it live.
> 2. 🟢 **Invoice date and due date are not meant to coincide**, and the 21/09 reading
>    that they must was the error. The line date is **commercial** — when the customer
>    must pay; administration **translates** it, invoicing on the 1st for a line due at
>    month end.
> 3. 🟢 **The join key is structural, not the date.** Fabrizio Paganelli:
>    _"lavorare sulla data di scadenza ci creerà dei casini in futuro. Noi dobbiamo
>    lavorare su elementi strutturali delle tabelle."_ Mirko Merendi named the fields:
>    the invoice carries the order's **sigla + numero ordine**, and the scadenziario
>    carries **codice cliente, serie documento, numero documento, data documento**.
> 4. 🔴 **Matching on the date would have been actively wrong.** Scadenziario due dates
>    move: a Ri.Ba. returned unpaid **regenerates a new due date**, and piani di rientro
>    are agreed case by case. _"sulle date di scadenza è bene non fare nessun tipo di
>    automatismo di programma perché è un casino."_
> 5. 🟢 Aurel Mrruku, three hours later: _"tutte le complicazioni che avevo previsto non
>    succedono più… Non so perché l'hanno complicato all'inizio."_ And
>    _"non devo fare nessuna logica customizzata in base alla data di scadenza."_
>
> **What survives as work:**
> [OI-166](OI-166%20The%20order%20line%20needs%20a%20shared%20identifier%20for%20Mexal.md)
> — the order/order-line identifier both systems must hold, which is the real
> unresolved hop —
> and [OI-167](OI-167%20Plus%20orders%20explode%20from%20a%20tranche%20count%20on%20the%20product.md),
> the agreed mechanism.
>
> **What this changes for `ORD-02`:** the row is **no longer contradicted by the date
> argument**. _"the whole order then goes to Mexal with both values at line level"_ is
> what the client actually does. The bundle clause is also answered — bundles reach
> Mexal as their component lines
> ([OI-144](OI-144%20Bundles%20must%20be%20split%20into%20order%20lines%20for%20Mexal.md)).
> ⚠ The register text is still **not edited by this sweep**: what remains open is the
> line-level identifier, and the Italian is the text the client signs. But the reason for
> not editing has changed from "the client has not been asked" to "one mechanical detail
> is still open".
>
> 🟢 **The armed trigger of 2026-09-21 — _"if no artifact shows Fabrizio Paganelli or
> Elisa Migliano being told that tranche dates must be re-keyed by hand"_ — is
> DISCHARGED, not by an artifact but by the premise dissolving.** Nobody needed to be
> told, because it was never true.

## The 21/09 record, unedited

**Established at [the 21/09 Mexal internal](../meetings/2026-09-21%20Interna%20Temi%20Mexal.md)
and not yet agreed with the client.** The most consequential finding of the
18–21/09 window.

## The constraint

Mexal exposes **no field through which Salesforce can set an invoice due date.**

| Field                  | Level                              | Set by                                            |
| ---------------------- | ---------------------------------- | ------------------------------------------------- |
| `data scadenza riga`   | order line, sent with the order    | Salesforce                                        |
| **`Data scadenza PG`** | scadenziario / invoice             | **Mexal, derived from the `modalità di pagamento`** |

The two are **not related one-to-one**. `Scad PG` is computed by Mexal from the
payment method, not from anything Salesforce sends. Aurel Mrruku established this
by querying the scadenziario with `info true` — the field named in the shared
`scoperto clienti` Excel does not exist — and Andrea Di Cicco confirmed it.
Documentation research found no source anywhere stating the two coincide.

**Only two outbound APIs exist** from Salesforce to Mexal: customer and order. An
`evasione riga` API would create an invoice per order line, **but Fabrizio
Paganelli ruled that invoices are created manually on Mexal**, so it is not used.
That ruling was restated by him in the client call the same afternoon:
_"L'importante per noi è che arrivino gli ordini su Mexal, poi dopo alla fattura
ci pensiamo noi."_

## The consequence

Because the invoice is created by hand, **the invoice due date does not exist
until a human types it.** The process therefore becomes:

1. The commercial user defines the tranches on the quote, each with its due date.
2. Those dates propagate to the order.
3. **An administration user opens Salesforce, reads the tranche due dates, and
   re-types them by hand while creating each invoice in Mexal.**
4. Salesforce re-syncs through `get fatture` / the scadenziario and matches the
   invoice to the tranche **on that date**.

The date is the only join key. Andrea Di Cicco:

> _"Se non vuoi una cosa automatica, eh, c'è possibilità d'errore manuale e non si
> aggiornano. […] nel momento in cui ci sta questo errore gli si dice devi
> aggiornare Salesforce con la data corretta."_

Aurel Mrruku: if the date does not match, the tranches simply do not update.

🔑 Andrea Di Cicco's framing of what a tranche is to Mexal: **_"queste trance in
realtà lato loro si traducono in fatture […] sarebbe l'incipit della fattura."_**

## Why this is gating

- **It is a new manual obligation on the client's administration team**, on every
  bundle and every Performance Plus order. Elena Spini's estimate of the volume:
  _"sono la maggior parte, presumo."_
- **A single mistyped date silently breaks the reconciliation** for that tranche.
  There is no validation, no reconciliation report and no owner for the
  correction.
- **Nothing builds it.** The record has `ORD-03` / `AC-06` describing a tranche
  payment roll-up fed from the Mexal scadenziario
  ([OI-50](OI-50%20Tranche%20object.md)); the roll-up merged on 16/09. What
  nobody has built is the **human step that makes the roll-up's input exist**, nor
  any guard on it.
- **It is a process change, not a technical detail**, and it lands on the party
  whose sign-off is due by 13 October.

## Not agreed with the client

🔴 Aurel Mrruku: **_"Dobbiamo per forza fare un passaggio con loro. Se mi
confermano sta cosa, io vado a bomba… Se non gli va bene, io non ho altra
soluzione per loro, perché l'informazione che mi mette a disposizione Mexal è
quella."_**

⚠ **It was put to Fabrizio Paganelli in the 16:00 client call on 21/09 and cut
off at `00:37:11`** when Daniela Morgese pulled him into another meeting. He
agreed to resume by phone. **No artifact in this sweep shows that conversation
happening.** So the client has confirmed *manual invoicing* and has **not** been
told what manual invoicing costs them in Salesforce.

Andrea Di Cicco's advice on presenting it: _"non vendiamogliela come problemi…
veniamo come soluzione."_

## Open

- 🔴 **Put the manual re-keying step to Fabrizio Paganelli and Elisa Migliano
  explicitly, and get it accepted or rejected.** If rejected, there is no
  alternative on the Mexal side.
- 🔴 **Decide what happens when the dates diverge.** Detection, correction and
  who owns it are all unspecified.
- 🔴 **The 22/09 `Test Mexal` session with Mirko Merendi (15:00–17:00) is the last
  scheduled chance to be told otherwise** by the Mexal vendor before UAT.
- ⚠ **No register row states the manual step.** Whether `ORD-03` / `AC-06` need
  amending, or a new requirement is owed, is a human's call.
- ⚠ Elisa Migliano's 18/09 counter-proposal — dedicated Salesforce fields for the
  instalments and their invoice dates, mirroring what tutors type by hand — is
  satisfied on the Salesforce side and **defeated on the Mexal side**. She has not
  been told.

## 🔴 It contradicts `ORD-02`, which is signed text

`ORD-02` in [the register](../../requirements/pienissimo-requirements.yaml) reads:

> _"Tranche reference and due date propagate from Quote Line Item to Order Item;
> **the whole order then goes to Mexal with both values at line level**"_

status `agreed`, priority `M`, source `AUREL-2026-08-24-TRANCHE`.

**The second clause cannot hold.** Two independent reasons, both established on
21/09:

1. **The due date that travels at line level is not the one that matters.**
   `data scadenza riga` reaches Mexal, but the invoice's due date is
   `Data scadenza PG`, which **Mexal computes from the payment method** and
   Salesforce cannot set. So the value arrives and does nothing.
2. **For a bundle there is only one line.** A bundle is transmitted as a single
   element, so n tranche dates have nowhere to go —
   [OI-144](OI-144%20Bundles%20must%20be%20split%20into%20order%20lines%20for%20Mexal.md).

`ORD-03` — _"Mexal updates payment per order line; Salesforce recalculates the
tranche…"_ — survives as a **goal**, but its input now depends on a human retyping
dates correctly.

⚠ **The register has deliberately not been edited.** `REQUISITI.it.md` is the text
presented to Pienissimo for signature, and what replaces `ORD-02` depends entirely
on the conversation with Fabrizio Paganelli that **has not happened** — whether the
client accepts manual re-keying, and whether bundles may be split. Rewriting signed
text on the strength of an internal call, before the client has been asked, would be
worse than leaving it visibly contradicted.

🔴 **So this is a sign-off question, not a filing detail.** The client is due to
approve the solution by **13 October** against a register whose `ORD-02` the
implementation cannot satisfy. **Whoever answers row 143's first open item must
decide what `ORD-02` should say, and update the YAML and both prose documents in the
same session.**
