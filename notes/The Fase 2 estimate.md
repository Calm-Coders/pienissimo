---
id: fase-2-estimate
type: reference
status: open
owner: Elena Spini
with: Aurel Mrruku
org: ROMI
raised: 2026-10-27
updated: 2026-10-27
depends_on: [OI-269, OI-272]
blocks: []
source: notes/meetings/2026-10-27 Follow-up Interno.md
---

# The Fase 2 estimate

**ROMI has, for the first time, a man-day estimate for Fase 2. It was written by
Elena Spini with Claudio, reviewed line by line with Aurel Mrruku on 27 October,
and it contains several items this repository still tracks as open Fase 1
questions. The client has not seen it.**

## The artifact

`Pienissimo_Project_Plan_Fase2`, Google Slides
`1b329SMXkcG3kivDfvoziCFuk2I19DlQQqS_UTQtKFeA`, 2,688,592 bytes, owner
`e.spini@romicompany.com`. **Created 2026-10-27 09:12:59Z, modified 17:08:43Z** —
i.e. opened the morning of the review and saved during it.

⚠ **Not opened by this sweep.** The figures below come from
[the review call](meetings/2026-10-27%20Follow-up%20Interno.md) — read the
deck for the authoritative version; Elena Spini said at the close that the day
count still needed redoing: _"Devo rifare un attimo il conteggio dei giorni, ma ci
siamo."_

🟢🔑 **Authorship is on the record** — Elena Spini, `00:39:58`: _"io e **Claudio**
abbiamo partorito questo documento e io l'ho rivisto."_ This answers a question
open since a Fase 2 draft by "Claudio" was first mentioned. ⚠ Claudio has no
person note and no surname in the record.

## The scope list, as read aloud

Grouped as Elena Spini enumerated it (`00:30:58`–`00:33:16`):

- **Integrazioni**: infopoint, **check-in degli eventi**, GLS, Teachable, _"ordini
  Pienissimo Pro"_.
- **Eventi multiedizione / multigiorno** — _"automazioni scalabili per eventi su
  più date edizione, check-in multipli … quella roba degli ingressi."_
- **Note di credito, incassi errati** — _"rettifica delle tranche, annullamenti."_
- **Variazione dello scadenzario e insoluti Ri.Ba.**
- **Ritorno del biglietto a non disponibile in caso di mancato incasso** —
  Elena Spini: _"Questo è un bel cinema."_
- **Cambio nominativo di un biglietto già assegnato** and **annullamento del
  biglietto prima dell'evento**.
- **Spostamento tra edizioni** — _"questo è ancora peggio."_
- **Avviso di scadenza dei contratti Performance Plus** — _"vabbè, questo è
  facile."_
- **Differenziare la comunicazione** per tipo di biglietto.
- **Comunicazioni transazionali** — the client does these itself; ROMI priced
  **support only**: _"han detto che la fanno loro e ho messo solo supporto."_

## The numbers

⚠ **Read as approximate.** The transcript garbles several labels, the review
moved figures as it went, and Elena Spini had not recounted. Where a number was
settled it is given; where it was contested that is said.

| Work package | Man-days | Note |
| --- | --- | --- |
| First package (edizioni / integrazioni, `R1`) | **20** | Aurel Mrruku: _"No, è giusto, è giusto"_ — and contingency of _"almeno una settimana"_ is inside it. The one he judged well estimated. |
| Note di credito, incassi errati, variazione scadenzario, rettifica tranche (`R2`) | **13–15** | Aurel Mrruku's figure: _"metti 13-15 giorni"_, reasoned as _"5 giorni UAT, 5 giorni produzione, 5 giorni"_ |
| Spostamento tra edizioni / annullamento biglietto | **10** | 🔴 Aurel Mrruku first said **15–20**, then conceded: _"metti 10. **Non sono per niente d'accordo**, però va bene. Devi mettere un numero."_ |
| Eventi multiedizione / multigiorno (Mastery, ingressi) | **10** | Aurel Mrruku offered 8, Elena Spini asked for 10, he agreed |
| Ordini Pienissimo Pro | **3–5** | _"lascia cinque"_ |
| GLS + Teachable | **3–5**, possibly **5–7** | Two integrations, not one; Elena Spini corrected herself mid-sentence |
| Analisi | **5–10** | Aurel Mrruku insisted the blueprint sits **inside** analysis and that 5–6 days is not enough: _"ti assicuro io che non sei dentro quei 7 giorni là"_ |

**GLS** is delivery notification — _"quelle cavolo di notifiche quando
effettivamente arriva il libro"_ — and **Teachable** is online courses.

## 🔴 It absorbs open Fase 1 items

This is the finding, not the arithmetic. Items the repository carries as live
Fase 1 questions appear inside the Fase 2 estimate:

- **[OI-269](items/OI-269%20Event%20communications%20must%20be%20differentiated%20by%20ticket%20type.md)
  — "differenziare la comunicazione" by ticket type.** The client restated it as
  a requirement on the same day, and ROMI's internal position is that it is
  necessarily Fase 2 and is to be blocked. See that note.
- **[OI-272](items/OI-272%20A%20standard%20contract%20expiry%20alert%20rule%20is%20requested.md)
  — the Performance Plus expiry alert**, priced here as _"facile"_.
- **Insoluti Ri.Ba. and scadenzario variation**, the territory of
  [OI-212](items/OI-212%20A%20Ri.Ba.%20rate%20reads%20as%20paid%20before%20its%20due%20date.md),
  which is open, unfixed and now in production.
- **Credit notes**, excluded from the 2024 history import on 22/10 _"to a later
  phase"_ — this is that phase, and the volume question is still unanswered.
- **Check-in / ingressi**, already recorded as Fase 2 by
  [an earlier decision](decisions/Decision%20-%20ingressi%20live%20on%20the%20campaign%20edition%20and%20are%20Fase%202.md)
  — consistent.

🔑 **This is Gianpaolo Motta's 26/10 ruling being executed** —
[no further absorption in Fase 1](decisions/ROMI%20will%20absorb%20no%20further%20scope%20in%20Fase%201.md),
_"spostagliele alla fase 2"_. ⚠ **And nothing says the client has been told**
which items moved. The deck routes internally first: to **Andrea**, who will call
**Daniela** (Morgese) — _"io do questo a il buon Andrea che chiamerà Daniela."_
⚠ Which Andrea is unestablished.

## ROMI expects the client to cut it

> **Elena Spini:** _"io faccio vedere sta roba, uscirà il finimondo perché **se la
> fase due è stimata quanto il progetto iniziale, non vorranno niente di tutto
> questo**. Inizieranno a togliere le cose e tanti cari saluti."_
>
> **Aurel Mrruku:** _"Ma il problema è se poi dicono di sì."_

## Caveats on these figures

1. ⚠ **Estimated before analysis, over the technical lead's objection**, stated
   three times: _"Come pretendi che ti do delle stime senza analizzare quello
   che …"_, _"Non fare le cose in fretta perché li fai male"_, _"Tu stai facendo
   una stima senza fare un'analisi."_
2. 🔑 **Elena Spini's own condition for Fase 2 is a signed blueprint first** —
   _"questa volta l'analisi mi devono dire subito che cacchio vogliono. Io faccio
   un documento di blueprint e glielo faccio subito confermare. Se poi si
   inventano la qualunque non c'è nel blueprint."_ A direct response to this
   project's experience; recorded because it is a process commitment, not a
   grumble.
3. ⚠ **Sequence is a proposal, not a plan** — _"questa è una proposta … se loro mi
   dicono che è più importante la mastery … dipende."_ Aurel Mrruku noted packages
   could run in parallel after analysis.
4. ⚠ **No staffing assumption is stated**, and the team is about to go from three
   to two — [the risk](risks/Risk%20-%20the%20delivery%20team%20shrinks%20before%20Fase%202.md).
5. ⚠ **A March go-live was mentioned in passing** — Aurel Mrruku, _"con live
   marzo"_; Elena Spini, _"sarebbe l'[go] live di tutte le fasi"_. **Not a
   commitment and not a date anyone set.**
