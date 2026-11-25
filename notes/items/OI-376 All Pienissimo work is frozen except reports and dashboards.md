---
id: OI-376
type: open-item
status: open
owner: Aurel Mrruku
with: Elena Spini, Anita Aga
org: ROMI
raised: 2026-11-19
updated: 2026-11-25
depends_on: [OI-375]
blocks: [fase-2]
severity: gating
source: notes/meetings/2026-11-19 INTERNA Check temi PEC.md
---

# OI-376 - All Pienissimo work is frozen except reports and dashboards

**On 19 November, the day after the PEC became known inside ROMI, development on
Pienissimo was stopped. The only work authorised is a set of Lead and Opportunity
reports plus one dashboard, to be built in UAT and not deployed to production,
for an internal review on the morning of Friday 20 November. Fase 2 is stopped
outright. R0, already in production, stays there for now.**

Caused by [OI-375](OI-375%20Pienissimo%20sent%20a%20PEC%20contesting%20the%20implementation%20and%20suspending%20the%20go-live.md).

## The freeze, as instructed

Aurel Mrruku, on
[the 19/11 internal call](../meetings/2026-11-19%20INTERNA%20Check%20temi%20PEC.md),
describing what he had already told Anita Aga:

> _"Gli ho detto di non fare niente, **di non toccare piu niente su pianissimo**."_
> — and of her availability: _"E libera ormai. Non deve fare niente."_

Elena Spini, in the ROMI DM the same morning (10:46–10:52 CET), confirming the
boundary:

| Time (CET) | Instruction |
| --- | --- |
| 10:46:08 | _"**confermo niente PROD per i report/dashboard**"_ |
| 10:46:22 | _"**facciamo solo UAT**"_ |
| 10:52:38 | _"**per R0 pure confermato da lasciare, il resto fermi tutti**"_ |

🔑 **"Il resto fermi tutti"** is the freeze. 🟡 **R0 stays in production** — the
part-0 release of Fase 2 that went in on 18 November — and she had already
written to Angelo to confirm that.

Aurel Mrruku had asked for exactly this ruling in the marketing group DM at
**09:12:30 CET**: _"ma possiamo avere un aggiornamento dettagliato? **devo
fermarmi su questo progetto?**"_ He got the answer four hours later, through the
call and the DM, not as a written instruction.

## The one thing still authorised

A commercial report set and a dashboard on **Lead and Opportunity**, for the
agents, on the Home page.

| | |
| --- | --- |
| Requirement | 🔴 **One line only** — Elena Spini: _"l'unico requisito che ho attualmente e quello di Marco che ha detto che vogliono capire la situazione di lead e opportunity"_. ⚠ Marco Montesi is the commercial lead who has resigned ([OI-357](OI-357%20The%20client%20commercial%20lead%20and%20the%20web%20counterpart%20are%20both%20leaving.md)) |
| Scope agreed on the call | two dashboards, _"qualche report e una dashboard"_ on the Home page; Aurel Mrruku offered and Elena Spini accepted **two further reports on orders and invoices** — _"mettiamo anche due report … su ordini e fatture, cosi almeno se abbiamo fatto ovviamente ancora di piu"_ |
| Environment | **UAT only.** Not production |
| Who builds it | **Anita Aga**, started 19/11 |
| Review | **internal**, Friday 20 November **09:30–10:30 CET** — the meeting `[PIENISSIMO] - Interna Check Report`, invitation sent by Elena Spini at 09:31:46Z to Aurel Mrruku and Anita Aga |

🔑 **The purpose is stated plainly: it is for the PEC reply, not for a user.**
Elena Spini: _"dato che se dobbiamo rispondere a questa … pec"_ and _"cosi almeno
nella risposta noi diciamo che abbiamo tutto"_. See
[OI-377](OI-377%20Reports%20and%20dashboards%20were%20never%20built%20and%20have%20no%20requirements.md).

## The disagreement on the record

⚠ A substantive process disagreement was aired and **not resolved**, and it is
worth preserving because it bears on how the remediation is built.

- **Elena Spini**: reports are configuration, not development, and could be made
  directly in production — _"Prendo le cose che ci sono nella org, le metto
  insieme in un report … non sono sviluppo"_; _"io le avrei fatti direttamente
  … in produzione"_.
- **Aurel Mrruku**: anything that reaches production goes through UAT and git —
  _"anche un campo, anche una label deve passare sempre"_; _"io non faccio mai le
  cose direttamente in produzione"_; and the prerequisite is a requirement:
  _"ti posso inventare cinque dashboard con 10 report dietro le quinte, ma se
  non vanno bene e un lavoro inutile."_
- 🟢 **The outcome went to UAT**, so the stated process held. ⚠ Elena Spini's
  closing position was permissive — _"fai come vuoi, basta che li portiamo"_ —
  so the rule rests on the developer's practice, not on a written decision.

🟡 **A factual correction landed in the same exchange.** Elena Spini believed the
Mexal component of 18/11 had been built straight in production; Aurel Mrruku
corrected both halves — it is a **sync panel with buttons, not a dashboard**, it
went UAT → Prod, and it was **asked for**, by Fabrizio Paganelli, verbally on the
16/11 call and in writing on 16/11 (_"darci l'istruzione per lanciarlo
manualmente al bisogno"_) → [OI-370](OI-370%20The%20client%20cannot%20run%20the%20Mexal%20syncs%20by%20hand.md).

## What is owed

- **A written scope for the reports and the dashboard**, beyond one sentence
  about lead and opportunity, from someone who can still speak to the client.
- **A decision on when the freeze lifts**, and on whether anything already in
  production is to be rolled back — R0 is explicitly a _"per ora"_.
- ⚠ **Nothing records what happens to the nineteen open rows of
  [OI-344](OI-344%20The%20client%20sent%20sixteen%20Sales%20flow%20changes%20and%20none%20is%20triaged.md)**,
  four of which were `IN LAVORAZIONE` when the freeze landed, nor to Elena
  Spini's change workbook of 13/11 that was due **Friday 20 November**.

## 🟡 2026-11-20 - the freeze holds, but the UAT boundary now has a Monday exit

🟢 **The carve-out was delivered and reviewed.** The internal review happened at
09:30 CET as planned →
[the meeting note](../meetings/2026-11-20%20INTERNA%20Check%20Report.md). Five
dashboards and six reports, built by hand by Anita Aga in a day, accepted as
_"completi e pronti"_.

🔴 **And the UAT-only instruction was planned past without being withdrawn.** On
19/11 Elena Spini wrote _"confermo niente PROD per i report/dashboard"_ and
_"facciamo solo UAT"_. On 20/11 the same meeting agreed a **production deployment
on Monday 23 November** if a stakeholder asks. ⚠ No source records the earlier
instruction being lifted; her evening status post re-gates it instead — _"In PROD
solo dopo l'ok di Angelo e Gianpaolo"_ →
[OI-381](OI-381%20The%20report%20and%20dashboard%20remediation%20is%20unmerged%20and%20due%20in%20production%20on%20a%20holiday.md).

🔴 **Everything else is still frozen, and now explicitly so after the client
meeting**: _"per ora tutti fermi"_, and the two new client demands — the
scadenziario and the credit notes — are frozen with it: _"scadenziario e note di
credito restano fermi"_ →
[OI-380](OI-380%20The%20client%20wants%20the%20scadenziario%20and%20the%20credit%20notes%20as%20soon%20as%20possible.md).

🔴 **The freeze has no lift date and the project manager cannot set one.** _"Finche
non arriva il feedback di Angelo e Gianpaolo non so come muovermi la settimana
prossima."_ ⚠ The week in question contains **Pienissimo Live, 24-26 November**.

⚠ **The two questions this note left open on 19/11 are still open.** Nothing
records what becomes of the four `IN LAVORAZIONE` rows of
[OI-344](OI-344%20The%20client%20sent%20sixteen%20Sales%20flow%20changes%20and%20none%20is%20triaged.md),
and Elena Spini's change workbook of 13/11 — **due today, 20 November** — was
again not found, a **fifth** window.

## Update 2026-11-23 - the freeze held through the weekend and the holiday

🔴 **Four days on, the freeze is unchanged and still has no lift date.** The
23 November holiday release that the one authorised exception pointed at **did
not happen** - no merge, no commit, no recorded approval
([OI-381](OI-381%20The%20report%20and%20dashboard%20remediation%20is%20unmerged%20and%20due%20in%20production%20on%20a%20holiday.md)).

🔑 **The lift signal now has a date.** Elena Spini expects to brief the team
on **24 November**, after Angelo Pastorelli's call with the client's direction on
the evening of 23 November
([OI-380](OI-380%20The%20client%20wants%20the%20scadenziario%20and%20the%20credit%20notes%20as%20soon%20as%20possible.md)).
⚠ That is the day **Pienissimo Live** opens.

## 🔑 Update 2026-11-24 - the freeze is partly lifted, by direction, in two places only

**Angelo Pastorelli lifted two things and nothing else.** In
`#tproj-pienissimo` at **15:35:51 CET** — the channel's first Pienissimo traffic
since the 19/11 weekly status post:

> _"[Elena Spini] io direi **manda al cliente le proposte per le call di
> formazione e mettiamo live le dashboard**"_

| What moved | From | To |
| --- | --- | --- |
| The reports and dashboards | **UAT only** — _"confermo niente PROD"_, 19/11 | 🟢 **Production**, planned 25/11 by 12:00 → [OI-381](OI-381%20The%20report%20and%20dashboard%20remediation%20is%20unmerged%20and%20due%20in%20production%20on%20a%20holiday.md) |
| Client contact on training | 🔴 nobody named since the PM was stood down | 🟢 **Elena Spini is told to write to the client** with the training call proposals → [OI-378](OI-378%20Marketing%20training%20is%20undelivered%20and%20the%20client%20did%20not%20attend%20the%20final%20test.md) |

🔑 **This is the first withdrawal of the 19 November UAT-only instruction**, and
it comes from one of the two gatekeepers rather than from the person who gave it.
⚠ It is one line in a chat channel: there is no release note, no scope statement
and no mention of the PEC or of what the client was told.

🔴 **Nothing else was lifted.** _"Il resto fermi tutti"_ still stands:

- 🔴 **Fase 2 remains stopped** — and is now being planned around: Anita Aga, the
  developer who built the reports, is being lined up for another project on the
  express premise that Fase 2 will not start →
  [OI-384](OI-384%20Anita%20Aga%20is%20being%20reallocated%20off%20Pienissimo%20while%20Fase%202%20is%20stopped.md).
- 🔴 **The scadenziario and the credit notes are not mentioned**, a fourth day
  ([OI-380](OI-380%20The%20client%20wants%20the%20scadenziario%20and%20the%20credit%20notes%20as%20soon%20as%20possible.md)).
- ⚠ **The four `IN LAVORAZIONE` rows of [OI-344](OI-344%20The%20client%20sent%20sixteen%20Sales%20flow%20changes%20and%20none%20is%20triaged.md)
  and Elena Spini's 13/11 change workbook** are unmentioned for a **sixth**
  window.

🟡 **Angelo Pastorelli also said, at 15:36:00, _"oggi la sento per i punti
aperti"_** — a third direction-to-direction contact about the open points, on
24 November. ⚠ Nothing records what came of it; see
[OI-380](OI-380%20The%20client%20wants%20the%20scadenziario%20and%20the%20credit%20notes%20as%20soon%20as%20possible.md).

## 🟡 Update 2026-11-25 - the authorised exception is delivered, and work is being planned past the freeze

🟢 **The one thing this freeze allowed is done.** The reports and dashboards are
in production, deployed 25/11 18:19:59 CET with Angelo Pastorelli's written
consent of 10:47:33 CET →
[OI-381](OI-381%20The%20report%20and%20dashboard%20remediation%20is%20unmerged%20and%20due%20in%20production%20on%20a%20holiday.md).
PR #132 is merged and the repository has no open pull request.

⚠ **So the exception is spent, and the freeze itself has never been formally
lifted** — yet new work is now on the client's calendar:

| Planned | Authorised by the 24/11 instruction? |
| --- | --- |
| Marketing training, 3 and 4 December | 🟢 **Yes** — _"manda al cliente le proposte per le call di formazione"_ |
| _Ultimo check della soluzione finale Marketing_, 1 December, **in production** | ⚠ **Not named.** Arguably part of training; it is a production session |
| _Call di chiarimenti e next step_ + **"pianificazione della nuova migrazione"**, 30 November | 🔴 **No.** New scope → [OI-385](OI-385%20A%20scope%20perimeter%20call%20and%20a%20new%20migration%20are%20planned%20for%2030%20November.md) |

🔴 **_"Il resto fermi tutti"_ has not been withdrawn in any source**, and Fase 2
is still stopped — while a migration is being promised to the client in writing.
⚠ **The freeze is now being overtaken in practice rather than decided.**

🔴 **The scadenziario and the credit notes are unmentioned for a fifth day**
([OI-380](OI-380%20The%20client%20wants%20the%20scadenziario%20and%20the%20credit%20notes%20as%20soon%20as%20possible.md)),
and [OI-344](OI-344%20The%20client%20sent%20sixteen%20Sales%20flow%20changes%20and%20none%20is%20triaged.md)'s
four `IN LAVORAZIONE` rows and the 13/11 workbook for a **seventh** window — both
of which the 30 November perimeter call would have to settle.
