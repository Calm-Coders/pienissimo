---
id: OI-343
type: open-item
status: open
owner: Elena Spini
with: Fabrizio Paganelli
org: both
raised: 2026-11-06
updated: 2026-11-19
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

## 🔴 2026-11-12 - a seventh day with no reply to the client

**Nothing in this window answers Fabrizio Paganelli.** Three days of mail, four
Slack conversations and four meetings were swept; the Blueprint dispute is not
mentioned in any of them.

🔑 It now sits behind a client approval expected **13 November** for a Fase 2 offer
whose R0 — the stage sale contract — is already in development and has since
acquired a signature requirement
([OI-346](OI-346%20The%20contract%20must%20be%20signed%20by%20the%20account%20legal%20representative.md)).
Aurel Mrruku's own framing on the
[12/11 internal call](../meetings/2026-11-12%20INTERNA%20Modifiche%20Marco.md):
_"Ma perche **stiamo gia sviluppando**"_, against Elena Spini's _"ovviamente non
hanno accettato ancora la fase due"_ and her reading of the exposure — _"questa
parte comunque l'hanno accettata, quindi … c\[e\] la devono pagare"_.

⚠ ROMI's own paperwork still contradicts ROMI's position, as established on 09/11:
Elena Spini's `#tproj-pienissimo` status dates the requirement to **30/10**, not the
02/11 call the disputed sentence cites.

## 2026-11-13 - the analysis is approved and it is being built, before Fase 2 is agreed

🟢 **The functional analysis is approved.** Elena Spini's status post to
`#tproj-pienissimo`, 13/11 19:22:51 CET:

> _"**Contratti da palco: analisi funzionale approvata.** Li trattiamo come **primo
> rilascio della Fase 2, da portare in produzione prima di Pienissimo Live**."_

So the thing the client disputed as outside the Fase 1 Blueprint is now agreed work
with a delivery window, and ROMI has started it. Her own red flag on the same post:

> _"Contratti da palco: il requisito e arrivato a ridosso del go-live. **Se non
> sono in produzione prima di Pienissimo Live (24-26/11), le vendite da palco
> restano senza contratto automatico.**"_
>
> _"Fase 2: non abbiamo ancora la conferma, ma abbiamo gia iniziato a lavorare sul
> primo rilascio per la scadenza dell'evento."_

🔴 **The Blueprint dispute itself is still unanswered — an eleventh day.** Nothing
in this window records ROMI accepting or contesting the client's claim. Meanwhile
ROMI took the opposite position on a different point in writing: the 13/11
Opportunity change is described to the client as _"**in deroga a quanto previsto nel
Blueprint**"_ — see
[the decision](../decisions/Decision%20-%20the%20Opportunity%20is%20won%20at%20the%20first%20collected%20invoice.md).
Both claims about what the Blueprint covers are now live at once, from opposite
directions.

⚠ **Pienissimo Live is 24-26 November**, not the single date of 24/11 carried in
earlier records. Eight days from this sweep, with the release unscheduled and
[no developer committed for December](OI-349%20Fase%202%20has%20no%20developer%20committed%20for%20December.md).

Elisa Migliano wanted both cases tested on the go-live call — _"vendita da palco
che non vendita da palco"_ — and the call ran out of time before either.

## 🔴🔑 2026-11-19 - the dispute became a legal notice

**The scope argument this item recorded on 6 November has been escalated into a
PEC.** The client's Blueprint claim — that the stage sale contract was inside
Fase 1 all along — is now the general form of its legal position: that
**everything ROMI calls Fase 2 is already in the Fase 1 contract**. See
[OI-375](OI-375%20Pienissimo%20sent%20a%20PEC%20contesting%20the%20implementation%20and%20suspending%20the%20go-live.md)
and [OI-342](OI-342%20The%20Fase%202%20offer%20V2%20reorders%20the%20releases%20and%20contradicts%20itself.md).

🔴 **ROMI never replied to the 6 November mail.** Fourteen days. The reply is now
a legal one, owned by Elena Spini and routed through Giancarlo and Angelo rather
than by the project manager direct to Fabrizio Paganelli.

⚠ **`OP-1`, `OP-2` and `OP-4` of the R0 analysis are still unanswered**, a
sixteenth day, and nothing in this window touched them.
