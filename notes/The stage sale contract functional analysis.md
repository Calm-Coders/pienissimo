---
id: ref-stage-sale-contract-analysis
type: reference
status: active
owner: Elena Spini
org: ROMI
raised: 2026-11-03
updated: 2026-11-06
depends_on: [OI-304]
blocks: [go-live]
source: notes/meetings/2026-11-03 Follow-up Interno.md
---

# The stage sale contract functional analysis

**The written specification for the stage-sale contract flow, sent to the client on
3 November at 18:00:14Z — one day earlier than the Wednesday 4 November deadline the
record carried. It is the first document to put the Fase 2 R0 classification in
front of Pienissimo in writing. Seven functional requirements, four open points, a
release date of 18 or 19 November, and a confirmation deadline of 5 November.**

## The artifact

- **Title**: `PIENISSIMO – Analisi Funzionale: Contratto Post-Vendita Da Palco.docx`
- **Drive id**: `1A-sYQEZvbp2ShVbVL1XQPkPottBQKCuI` — an **uploaded `.docx`**, not a
  native Google Doc
- **Mail**: Gmail `1a1a291d143128a7`, **2026-11-03 18:00:14Z**, from Elena Spini to
  **Fabrizio Paganelli, `amministrazione@pienissimo.com` and Sabatino Rinaldi**, cc
  Aurel Mrruku. Subject `[ROMI-PIENISSIMO] - Tema Contratti Post-Vendita Da Palco`
- **Drafted live** in [the internal follow-up](meetings/2026-11-03%20Follow-up%20Interno.md),
  00:36:20, ending ~25 minutes before it was sent
- 🔑 **Comments are invited in the document itself**: _"Potete leggerlo e lasciare
  commenti direttamente nel documento."_

## 🆕 It carries a new meeting

**Thursday 5 November, 12:00-12:30** — a recap of the Fase 2 contents, _"compreso
questo primo rilascio, così chiudiamo insieme gli Open Point"_.

## The seven functional requirements

| ID | Requirement | Detail |
| -- | ----------- | ------ |
| **RF1** | Trigger | The flow starts when Salesforce receives the stage-sale WooCommerce order id **from Mexal**. No action by amministrazione. |
| **RF2** | Document | A **new PDF template with DocuSign tags that reads the Order, not the Quote**. The Fase 1 quote template is untouched. |
| **RF3** | Send and sign | Automatic send via DocuSign; the customer signs **without a DocuSign account**; the signed document returns to Salesforce and is tracked. |
| **RF4** | Error handling | A **resend button on the order, visible only if the previous send failed**. |
| **RF5** | Plus products in bundles | A bundle holds **only courses or only Plus, never mixed** (Fabrizio Paganelli). For Plus: **12 bundle-dedicated article codes without a tranche number**. |
| **RF6** | Order states | **No change.** States move when the Mexal `scadenziario` arrives. |
| **RF7** | 🆕 **Plus electronic contract** | For Plus, **besides the PDF, a Contract record is also created in Salesforce**. |

🆕🔑 **RF7 is new to the record.** The 2 November call left _"contratto cartaceo"_,
_"PDF"_ and _"contratto informatico"_ undefined and interchangeable. The internal
follow-up fixed it: **`contratto informatico` is the Salesforce Contract record**,
and it applies **to Performance Plus only**.

## 🔑 What the scope actually is

Every WooCommerce stage order generates the **PDF contract**; **Performance Plus
additionally gets the Contract record**. Aurel Mrruku verified this against the
2 November transcript during the drafting session — _"il contratto lo vuole per tutte
le vendite da palco, quindi sia per i corsi sia per la plus"_.

🟢 **This retires the open question** of whether Fabrizio Paganelli's _"solo per la
parte della Plus corsi"_ narrowed R0 below what both Fase 2 decks price. **It does
not.**

## The flow, as written

WooCommerce purchase (no signature) → payment → Salesforce order → **Mexal registers
and returns the id** → Salesforce generates the PDF from the new Order template →
automatic DocuSign send → signature → signed document returns → **PDF and signature
state tracked on the order [OP-6]** · resend button only after a failure.

🔑 **Payment, as the document now states it**: card → the WooCommerce order is
immediately `Completato`; **bank transfer → `Sospeso` until amministrazione confirms
it**. ⚠ The 2 November reading that _"if it reaches Mexal the customer has already
paid"_ was **struck out by Aurel Mrruku** in drafting — ROMI does not hold the
payment fact and learns it at midnight.

## The four edge cases, and their status in the document

| Case | Expected behaviour | Status as written |
| ---- | ------------------ | ----------------- |
| Transfer not yet confirmed | Order stays `Sospeso`, does not reach Mexal, no contract | **Dedotto, da confermare** |
| P.IVA check fails on an account's first order (Anticipay) | The Fase 1 mail goes to amministrazione; **the order reaches Mexal anyway and the contract is generated** | **Dedotto, da confermare** |
| PDF generation or DocuSign send fails | Order left without a sent document; resend button appears, then disappears on success | Concordato |
| Order with Plus and courses together | Not provided for; mixed bundles are not made | Concordato |

⚠ **Two of the four are ROMI's deductions, not client agreement** — and Aurel Mrruku
said _"corretto"_ to the transfer case in drafting, and confirmed the Anticipay case
mechanically on [the e2e call](meetings/2026-11-03%20Test%20e2e%20PROD.md) the same
morning. **What is unconfirmed is whether Pienissimo accepts the behaviour**, not
whether it is what the system does.

## 🆕 Dates

| Date | Step | Who |
| ---- | ---- | --- |
| **by 05/11** | **Confirmation of this solution by Pienissimo** | Pienissimo |
| week of **09/11** | Development: Order template, DocuSign send, resend button | Aurel Mrruku |
| week of **16/11** | Joint testing with the client | ROMI / Pienissimo |
| **18-19/11** | **Production release** | Aurel Mrruku |
| **23/11** | Final check; Fabrizio Paganelli builds the event bundle | Fabrizio Paganelli |
| **24-26/11** | Pienissimo Live, with stage selling | Pienissimo |

🔑 **The release is explicitly outside the 16 November go-live**: _"Lo sviluppo non
entra nel go-live del 16/11: Aurel non vuole rischiare la parte già in produzione."_
Two working days of margin, 20 and 23 November, are stated.

🔑 **Fase 1's days are exhausted** — _"Le giornate della Fase 1 sono esaurite.
L'intervento entra come primo rilascio ufficiale della Fase 2 e si aggiunge alla
stima in preparazione."_

## The four open points

| ID | To close | Owner | By |
| -- | -------- | ----- | -- |
| **OP-1** | Fields available on the Order to populate the template — Aurel Mrruku to verify they all exist | Aurel Mrruku | 05/11 |
| **OP-2** | **Signature tracking on the order: status or flag, and where the signed PDF is stored** (in Fase 1 on the quote, with status `Firmato`) | **Fabrizio Paganelli** | 05/11 |
| **OP-3** | **Written confirmation that this is the first release of Fase 2, before development starts.** _"La proposta di Fase 2 era attesa entro il 13/11."_ | Pienissimo | 05/11 |
| **OP-4** | Release date (18 or 19/11) and client availability for testing in the week of 16/11 | Elena Spini, Fabrizio Paganelli | 05/11 |

🔑 **OP-2 is the 30 October status flag, finally with an owner and a date** — and it
was pushed to the client deliberately. Elena Spini in drafting: _"Qua gli lasciamo
l'open point, ci faranno sapere … cacchio ce ne dobbiamo fare noi, ce lo dobbiamo
dire loro."_

🔑 **OP-3 resolves how R0 relates to the 13 November Fase 2 approval**: ROMI is
seeking a **written R0 confirmation by 5 November**, ahead of the proposal deadline,
rather than waiting on it.

## 🔴 What the document does not contain

🔑 **All four were discussed in the drafting session and left out.** They are real
scope and real risk.

1. 🔴 **The product check in RF1.** Aurel Mrruku: _"non tutti i prodotti che arrivano
   da WooCommerce devono generare un contratto."_ Elena Spini noted its absence and
   sent it anyway.
2. 🔴 **Two PDF templates, not one** — one for courses, one for Plus. Confirmed by
   Aurel Mrruku, then **the open point was deleted** because it had never been raised
   with the client.
   → [OI-326](items/OI-326%20A%20second%20PDF%20template%20is%20needed%20for%20corsi%20and%20for%20Plus.md)
3. 🔴 **The DocuSign return trigger rewiring.** Today it resolves a Quote; an order
   has none. Aurel Mrruku has never done it: _"sarà un bagno di sangue"_.
   → [OI-322](items/OI-322%20The%20DocuSign%20return%20trigger%20only%20handles%20quotes%20not%20orders.md)
4. 🔴 **The chasing mechanism.** _"Cliente che non firma … solleciti senza blocchi"_
   was Open Point 5 of the draft and **Aurel Mrruku had it struck**: _"toglili pure di
   tutto che poi là non finiamo mai"_.
   🔑 **So the chasing report of the 30 October decision was not forgotten — it was
   deleted on 3 November.**
5. 🔴 **The bundle Plus classification** needed to choose the template.
   → [OI-328](items/OI-328%20A%20bundle%20containing%20a%20Plus%20product%20must%20be%20flagged%20as%20a%20Plus%20bundle.md)

⚠ **And the estimate carries none of it.** R0 is sized at **6-7 days, "diciamo 7
giorni alla fine"**, while Aurel Mrruku put a template alone at _"da 10 a 15
giorni"_ historically, _"2-3 giorni"_ with AI. Elena Spini: _"non posso chiedere più
i giorni, mi sa che già m'ammazzano."_

## ⚠ One internal inconsistency

The document lists **_"Fabrizio: creazione dei 12 codici articolo Plus su Mexal"_**
as a client dependency still owed, while
[OI-48](items/OI-48%20Bundle-only%20article%20codes.md) records that **the twelve
codes were created on 2 November** and the client said so by mail. ⚠ **Probably a
leftover from the 2 November draft; it has not been corrected and the client has
received it as an outstanding dependency.**

## Related

- [OI-304](items/OI-304%20Contracts%20for%20WooCommerce%20stage%20sales%20are%20not%20generated.md) — the item this specifies
- [Decision - stage sale contracts are release R0 of Fase 2](decisions/Decision%20-%20stage%20sale%20contracts%20are%20release%20R0%20of%20Fase%202.md)
- [The Fase 2 offer](The%20Fase%202%20offer.md) · [The Fase 2 estimate](The%20Fase%202%20estimate.md)
- [The Business Blueprint delivered to the client](The%20Business%20Blueprint%20delivered%20to%20the%20client.md) — which does **not** contain these seven requirements

## 🔴 2026-11-05 - the open points fell due and the client has not answered

**All four open points carried a due date of 5 November. On the day, Elena Spini had
to chase them, and the chase is the last word in the record.**

🔴 **Elena Spini → Fabrizio Paganelli, amministrazione and Sabatino Rinaldi,
13:00:05Z** (Gmail thread `1a1a291d143128a7`), reopening the delivery mail of 3
November:

> _"vi ricordo di darci un feedback su questo tema, considerano anche **nel documento
> ci sono OP con scadenza oggi ancora da chiarire**."_

🔑 **So OP-1 to OP-4 were still open at 14:00 CET on their own due date**, including
**OP-3**, the written confirmation that R0 is the first release of Fase 2 — the
confirmation that development starting in the week of 9 November was supposed to rest
on.

⚠ **The recap call happened.** Elena Spini, 13:05 CET in the DM: _"ho appena fatto la
call con loro per la fase 2 🤢"_ — the 12:00-12:30 slot this note records. **What was
agreed on it is nowhere**: no minutes, no recording, no Drive folder for it, and the
chase mail went out after it.

⚠ **The document itself has not moved** — `1A-sYQEZvbp2ShVbVL1XQPkPottBQKCuI` is
still at its 2026-11-03 17:58Z modification, so nothing was edited into it. Drive
comments would not show in that timestamp, and none is reported in mail or chat.

🟡 **OP-4 has a partial answer, second-hand.** Aurel Mrruku, DM 18:02 CET: _"t ah
risposto per il **deploy del 18**? che era sulla fase 2"_ → Elena Spini: _"ha detto
che **domani mattina manda l OK** e se ha problemi dubbi ci scrive / chiama"_. So a
verbal OK on the 18th is expected on the morning of **6 November**; ⚠ the
conversation does not say whether it also covers OP-3's written confirmation, and
nothing identifies which release _"il deploy del 18"_ is.

## 2026-11-06 — the OK arrived, approving the specification and rejecting its premise

🟢 **The promised OK came, on the morning it was promised.** Fabrizio Paganelli,
Gmail `1a1b03ba790c53c6`, **09:41:00Z**, to Elena Spini, `amministrazione@` and
Sabatino Rinaldi, cc Aurel Mrruku:

> _"L'unico punto sul quale non sono d'accordo e che "La richiesta e emersa nella
> call del 02/11/2026 e non era prevista nel Blueprint di Fase 1", ma questo e un
> altro tema_
>
> _Per il resto, per me va bene quanto indicato nelle specifiche del documento"_

**So the seven functional requirements and the solution are accepted by the client
in writing.** This is the first client approval of any Fase 2 content.

### What it does to the four open points

| | Status after 06/11 |
| --- | --- |
| **OP-1** — fields on the Order to populate the template, Aurel Mrruku to verify | 🔴 **Unanswered.** Nothing in this window reports the verification |
| **OP-2** — signature tracking on the order: status or flag, and where the signed PDF is stored | 🔴 **Unanswered.** It was Fabrizio Paganelli's to answer and his mail does not touch it |
| **OP-3** — written confirmation that this is the first release of Fase 2, before development starts | 🟡 **Half answered.** The specification is confirmed; the Fase 2 premise is explicitly rejected → [OI-343](items/OI-343%20The%20client%20disputes%20that%20the%20stage%20sale%20contract%20was%20outside%20the%20Fase%201%20Blueprint.md) |
| **OP-4** — release date 18 or 19/11 and client availability for testing in the week of 16/11 | 🔴 **Unanswered in writing.** The mail names no date and no availability |

🔑 **The approval and the dispute are the same four lines**, and the disputed
sentence is the one OP-3 exists to secure. **ROMI read the mail as a confirmation.**
Elena Spini, Aurel Mrruku DM **11:02:26 CET**: _"Tema Contratti Post-Vendita Da
Palco >> **Fabrizio ha confermato (a modo suo -.-)**"_; Aurel Mrruku 11:04:42: _"mi
preoccupa "a modo suo""_; she pasted the disputed sentence back; 11:08:00: _"che
trovi la call dove lha detto..."_ — ⚠ **ROMI believes the attribution is on a
recording; which call is not identified and no transcript was opened.**

🔴 **Development was authorised in the same exchange, on an emoji.** Aurel Mrruku,
**11:04:55 CET**: _"posso iniziare coi sviluppi?"_ → a ✅ reaction from Elena Spini
and no words. **So R0 development starts with OP-1, OP-2 and OP-4 open**, OP-2 being
the one design question in the four — where the signature status and the signed PDF
live on the order.

⚠ **The document still has not moved**: `1A-sYQEZvbp2ShVbVL1XQPkPottBQKCuI` remains
at 2026-11-03 17:58:18Z, checked again on 6 November. The approval is in the mail,
not in the artifact, and the client left no comment in it.
