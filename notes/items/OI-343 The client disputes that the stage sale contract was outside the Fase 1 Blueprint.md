---
id: OI-343
type: open-item
status: open
owner: Elena Spini
with: Fabrizio Paganelli
org: both
raised: 2026-11-06
updated: 2026-11-09
depends_on: [OI-304]
blocks: []
source: Gmail 1a1b03ba790c53c6, 2026-11-06T09:41:00Z
---

# OI-343 - The client disputes that the stage sale contract was outside the Fase 1 Blueprint

**Fabrizio Paganelli approved the stage-sale contract functional analysis in
writing on 6 November and rejected exactly one sentence in it: the one that says
the request arose in the 2 November call and was not foreseen in the Fase 1
Blueprint. That sentence is the commercial basis for treating the work as Fase 2
R0 rather than as Fase 1 scope, and he set it aside rather than arguing it.**

## What he wrote

Gmail `1a1b03ba790c53c6`, **2026-11-06 09:41:00Z**, Fabrizio Paganelli to Elena
Spini, `amministrazione@pienissimo.com` and Sabatino Rinaldi, cc Aurel Mrruku,
replying to her 5 November chase:

> _"L'unico punto sul quale non sono d'accordo e che "**La richiesta e emersa
> nella call del 02/11/2026 e non era prevista nel Blueprint di Fase 1**", ma
> questo e un altro tema_
>
> _Per il resto, per me va bene quanto indicato nelle specifiche del documento"_

🔑 **Two things in four lines.** The specification is accepted — see
[the analysis](../The%20stage%20sale%20contract%20functional%20analysis.md) — and
the attribution of where the requirement came from is not.

## Why the sentence matters

The disputed sentence is the premise of the whole R0 classification. If the stage
sale contract was in the Fase 1 Blueprint, it is work already paid for; if it was
not, it is the first release of a Fase 2 the client has still to approve by
13 November ([OI-342](OI-342%20The%20Fase%202%20offer%20V2%20reorders%20the%20releases%20and%20contradicts%20itself.md)).
**`OP-3` of the analysis exists to get that in writing**, and what came back
approves the specification while denying the premise.

🔴 **Nobody has answered him.** The ROMI reading of his mail, same morning in the
Elena Spini DM:

- **11:02:26 CET**, Elena Spini: _"Tema Contratti Post-Vendita Da Palco >>
  Fabrizio ha confermato (a modo suo -.-)"_
- **11:04:42**, Aurel Mrruku: _"mi preoccupa "a modo suo""_ — she pasted the
  disputed sentence back as the answer
- **11:08:00**, Aurel Mrruku: _"che trovi la call dove lha detto..."_ (one 😂)

🔑 **So ROMI's position is that the request is on a recording and the attribution
can be evidenced** — and that position has been stated in a DM between two ROMI
people, not to the client. ⚠ **Which call, and whether the recording supports
it, is not established here**; no transcript was opened for this note.

## And development started on it the same hour

**11:04:55 CET**, Aurel Mrruku in the same DM: _"posso iniziare coi sviluppi?"_ —
answered with a ✅ reaction and nothing in words.

🔴 **The approval ROMI is building on is the half of the mail that approves the
specification, while the half that rejects the commercial premise is unanswered
and `OP-1`, `OP-2` and `OP-4` are still open.** `OP-2` — where the signature
status and the signed PDF live on the order — is a design question, and it was
his to answer.

## What is owed

- A written ROMI answer on the Blueprint question, or an explicit decision to
  leave it, because silence here is what a later invoice dispute is built on.
- `OP-2` from Fabrizio Paganelli, `OP-1` from Aurel Mrruku, `OP-4` from both.
- A statement of whether the ✅ is the authority to develop R0, and from whom.


## 🔴🔑 2026-11-09 - ROMI's own status report dates the requirement to 30 October, not 2 November

**The disputed sentence may be wrong on its own facts, and the evidence is ROMI's
own.** Elena Spini's status post in `#tproj-pienissimo`, **2026-11-09 09:00:06
CET** — the first message in that channel in five sweeps:

> _"**Contratti da palco: nuovo requisito emerso il 30/10.** Nelle vendite da palco
> il contratto va inviato dopo l'ordine, con DocuSign, e per i Plus serve anche il
> record dell'oggetto contratto. Il 3/11 ho mandato l'analisi funzionale e il 6/11
> Fabrizio P. ha dato l'ok alle specifiche. **Lo trattiamo come primo rilascio
> della Fase 2**, da portare in produzione prima di Pienissimo Live (24-26/11)."_

🔑 **The analysis says the request _"è emersa nella call del 02/11/2026"_. Her
internal status says it emerged on **30 October**.** Those cannot both be right,
and the client objected to exactly that clause.

⚠ **This does not settle the Blueprint question**, which is whether the
requirement was foreseen in Fase 1 — a different question from when it was voiced.
**But it removes the easy version of ROMI's answer**: the 2 November attribution,
which Aurel Mrruku proposed to evidence from a recording (_"che trovi la call dove
lha detto..."_), is contradicted by ROMI's own reporting line three days before the
client disputed it.

🔑 **30 October is the date of
[the internal alignment](../meetings/2026-10-30%20Rapido%20Allineamento%20Aurel%20Elena.md)**
and of [the ruling that new scope goes to Fase 2](../decisions/Decision%20-%20new%20scope%20after%2026%20October%20goes%20to%20Fase%202.md).
⚠ **Which 30/10 conversation carried the requirement is not established here.**

### 🔴 Still nobody has answered him

**A fourth day.** No mail, Slack message or meeting in this window contains a ROMI
reply on the Blueprint point. Meanwhile:

- 🟢 **R0 is being built** — the client review of 9 November describes _"il rilascio
  zero per i contratti da palco **su cui Aurel mrruku sta già lavorando**"_, so the
  ✅ reaction is now the operative authority in practice.
- 🔴 **And it grew.** The same call added that **the contract must be signed by the
  account's legal representative**, pending a lawyer →
  [OI-346](OI-346%20The%20contract%20must%20be%20signed%20by%20the%20account%20legal%20representative.md).
  **Scope is being added to a release whose commercial basis is disputed.**
- 🔴 **`OP-1`, `OP-2` and `OP-4` are still open** a sixth day; `OP-2` overlaps
  OI-346 directly.
- 🔑 **The deadline is now four days away.** Fase 2 approval is due **13 November**
  and R0 is its first release.
