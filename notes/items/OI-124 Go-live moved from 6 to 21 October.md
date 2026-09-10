---
id: OI-124
type: open-item
status: resolved
owner: Elena Spini
with: Pienissimo
org: both
raised: 2026-09-07
updated: 2026-09-09
blocks: [go-live]
requirement: CTX-02
source: Gmail thread 1a0815f9a43d3b87, 2026-09-08 14:15Z and 2026-09-09 07:08Z
---

# OI-124 - Go-live moved from 6 to 21 October

**On 8 September Elena Spini told Pienissimo in writing that go-live is
21 October 2026, fifteen days later than the signed 6 October, and asked for
written acknowledgement. The register has not been changed. This row carries the
conflict until a human says whether the signed text moves.**

## ✅ The 07/09 reading was wrong, and this corrects it

This row was opened on 7 September reading the internal follow-up as agreeing
**21 September** with approval by **13 September** — a date _earlier_ than the
register, described as a _slittamento_ that adds development weeks. That note
said the direction "only makes sense against a plan this repository does not
hold" and told the next reader to **ask, not infer**.

The plan arrived the next day and resolves it: **the months were missing from
Gemini's paraphrase.**

| 07/09 Gemini `Concordato`                   | 08/09 client mail and plan deck        |
| ------------------------------------------- | -------------------------------------- |
| go-live **21 settembre**                    | go-live **21 ottobre**                 |
| approvazione entro **13** dello stesso mese | approvazione soluzione entro **13/10** |

`Pienissimo_Project Plan 2.pptx` (Drive `1tIjf-PQNgqIxnzJxsb5cTcDcPdfFuISE`,
saved 14:08:27Z) carries **"GO-LIVE FASE 1 (21/10)"**, **"UAT Ready Fase 1
(entro 23/09)"** and **"Approvazione Soluzione 1 (entro 13/10)"**. A _slittamento_
adding development weeks is exactly what a move from 6 to 21 October is.

⚠ **The method lesson is worth keeping.** A Gemini decision list dropped the month
from two dates and produced a coherent-looking reading that was wrong in
direction as well as value. The 07/09 note was right to refuse to act on it.

## What was sent to the client

`[ROMI-PIENISSIMO] - Stato Avanzamento Progetto`, 8 September 14:15Z, from
Elena Spini to **Sabatino Rinaldi, Fabrizio Paganelli, amministrazione@ (Elisa
Migliano) and Marco Montesi**, cc Aurel Mrruku and Andrea Di Cicco.

Its stated reason for the move is _"diversi temi ancora pending e i lavori stanno
procedendo a rilento"_ — the data model still being defined, and frequent
revisions to the analysis flows.

It sets out:

- **Go-live 21 October** (against _"il 6 ottobre inizialmente ipotizzato"_).
- **UAT and test 23 September – 13 October**, guided sessions first, then
  autonomous testing by Pienissimo in UAT, across nine named flows.
- **Fase 2 is out of perimeter** and needs separate valuation and quotation —
  see [OI-83](OI-83%20No%20phase%202%20estimate.md) and
  [the dispute](../risks/Risk%20-%20the%20phase%202%20scope%20dispute%20is%20unresolved.md).
- Four **blocking** decisions owed by the client: DocuSign licences, the
  marketing form review, the data model, and data migration held in stand-by.

Elena Spini asked for a reply _"per conferma di avvenuta lettura e di presa
visione delle nuove tempistiche e del perimetro di progetto"_. That
acknowledgement is [OI-128](OI-128%20Client%20confirmation%20of%20the%2021%20October%20plan%20and%20the%20Fase%202%20perimeter.md).

## 🔴 What the register still says

Unchanged, in nine places across three files:

| Where                                                | What it says                                                                |
| ---------------------------------------------------- | --------------------------------------------------------------------------- |
| `REQUIREMENTS.md` / `REQUISITI.it.md` — **`CTX-02`** | **Go-live 6 October 2026**                                                  |
| Both documents, priority key                         | `M` = _indispensable for the 6 October 2026 go-live_                        |
| Both documents, milestone table                      | **6 October 2026 — Go-live**                                                |
| Both documents, Fase 2 rule                          | requests endangering **6 October 2026** are automatically Fase 2 candidates |
| `requirements/pienissimo-requirements.yaml`          | `go_live: 2026-10-06`, and `CTX-02`'s text                                  |

`REQUISITI.it.md` is **the document presented to Pienissimo for signature**.

⚠ **The Fase 2 escalation rule's premise has changed.** It reads _"unless the
go-live date is explicitly renegotiated"_ — and the date has now been explicitly
renegotiated by ROMI in writing. The rule has not been re-examined against the
new date.

## What is better and what is worse

🟢 **Better than the 07/09 reading.** A later date is a real extension, and the
sequence now hangs together: UAT ready 23/09, approval 13/10, go-live 21/10.

🔴 **The Zoho margin narrows to ten days.** Zoho CRM expires **31 October 2026**.
6 October left twenty-five days of overlap; 21 October leaves **ten**, and the
plan puts no buffer after go-live beyond _"supporto post go-live"_.

🔴 **UAT starts 23 September against a build that has never been UAT-tested.** On
the same afternoon Aurel Mrruku said in
[Flussi MKT Parte 2](../meetings/2026-09-08%20Flussi%20MKT%20Parte%202.md) that
_"non abbiamo ancora fatto dei UAT noi"_ and that a production release needs
_"almeno un paio di settimane"_. The nine flows the mail lists for UAT include
several the record shows as unbuilt or unproven — Mexal, tranche propagation,
DocuSign signature-to-QR, and the Marketing Cloud flows
([OI-134](OI-134%20The%20marketing%20flows%20cannot%20be%20tested%20before%20a%20production%20release.md)).

⚠ **The edition-mapping window moved again.** The mapping is to be entered by
hand "in the days immediately before go-live"
([OI-121](OI-121%20The%20edition%20mapping%20table%20has%20no%20rows%20and%20no%20owner.md)) —
those days have now moved twice in two days and the table still has no named
owner.

## What a human has to do

1. **Decide whether `CTX-02` moves now or on the client's acknowledgement.** The
   date has been proposed to the client in writing but **not yet accepted**. This
   sweep left the register at 6 October for that reason — the Italian is the
   operative text and it is not moved by a mail that is still awaiting reply.
   When the confirmation lands, `CTX-02`, the `M` definition, both milestone
   tables, the Fase 2 rule and `go_live:` change **in both languages in the same
   session**.
2. **Re-examine the Fase 2 escalation rule** against a renegotiated date.
3. **Say whether the 23 September UAT start is real**, given that no UAT has been
   run and production is two weeks out.

**All three were done or answered on 9 September. See below.**

## ✅ 2026-09-09 - the acknowledgement landed and the register moved

**Fabrizio Paganelli replied at 07:08:22Z**, into the same thread, to Elena
Spini and the three other client addressees, cc Aurel Mrruku, Andrea Di Cicco
and — newly — `daniela@pienissimo.com`:

> _"Ciao Elena, **presa visione** e aggiungo Daniela in cc, per sua conoscenza.
> Fabrizio"_

That is the exact phrase Elena Spini asked for. Her request was for
_"conferma di avvenuta lettura e di **presa visione delle nuove tempistiche** e
del perimetro di progetto"_, and for the **date** it is the acknowledgement this
row was waiting on.

**The register was moved the same day**, in both languages in one session, in the
ten places this row listed:

| File                                        | Changed                                                                         |
| ------------------------------------------- | ------------------------------------------------------------------------------- |
| `requirements/pienissimo-requirements.yaml` | `go_live: 2026-10-21`, `CTX-02` text, `version: "1.5"`, `date: 2026-09-09`      |
| `REQUIREMENTS.md`                           | `CTX-02`, the `M` priority definition, the milestone table, the §14 Fase 2 rule |
| `REQUISITI.it.md`                           | `CTX-02`, the `M` priority definition, the milestone table, the §14 Fase 2 rule |

The YAML meta carries a comment recording the renegotiation, its evidence and the
original signed date, so the change is auditable without this note.

⚠ **One mention of 6 October was deliberately left**, in §2.2 of both prose
documents: _"these three cannot be planned and do not count toward the 6 October
date"_ / _"non concorrono alla data del 6 ottobre"_. That paragraph is prefaced
_"To be settled in this session"_ and records what was said at the **06/08
sign-off session**. Editing the date inside it would misquote the session. It is
a historical quotation, not a live rule.

## 🔴 What this does not settle

1. **Three of the four addressees have not replied.** Sabatino Rinaldi, Elisa
   Migliano (`amministrazione@`) and Marco Montesi are silent. The date now rests
   on **one** acknowledgement, from the client's product and registry lead rather
   than from its project lead.
2. **The perimeter is untouched by this.** Fabrizio Paganelli acknowledged
   reading; he did not accept the Fase 2 exclusions, and the record predicted
   exactly this outcome — see
   [OI-128](OI-128%20Client%20confirmation%20of%20the%2021%20October%20plan%20and%20the%20Fase%202%20perimeter.md)
   and [the dispute](../risks/Risk%20-%20the%20phase%202%20scope%20dispute%20is%20unresolved.md).
   **The scope dispute is not closed by this reply and must not be recorded as
   closed.**
3. **The §14 escalation rule has not been re-examined**, only re-dated. It now
   reads _"requests that endanger the 21 October 2026 date are automatically
   candidates for Phase 2, unless the go-live date is explicitly renegotiated"_ —
   and the date has just been renegotiated once, which is the precedent the rule
   was written to constrain.
4. **The 23 September UAT start is still unreconciled** with Aurel Mrruku's
   _"non abbiamo ancora fatto dei UAT noi"_ of the same afternoon
   ([OI-134](OI-134%20The%20marketing%20flows%20cannot%20be%20tested%20before%20a%20production%20release.md)).
   That is now **fourteen days** away, and this row's resolution does nothing
   about it.

**This row is resolved as a register conflict. It is not evidence that the plan
is agreed.**
