---
id: OI-376
type: open-item
status: open
owner: Aurel Mrruku
with: Elena Spini, Anita Aga
org: ROMI
raised: 2026-11-19
updated: 2026-11-19
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
