---
id: risk-phase2-dispute
type: risk
status: open
severity: high
owner: Elena Spini
org: both
raised: 2026-07-10
updated: 2026-08-14
depends_on: [OI-37, OI-38, OI-83]
source: meetings/open-items.md status updates 2026-08-03 and 2026-08-06
---

# Risk - the phase 2 scope dispute is unresolved

ROMI's position, stated by Elena Spini in three consecutive weekly status posts
(10, 24 and 31 July) and again on 2026-08-06: the **GLS integration**, the
**Teachable integration** and the **Salesforce to Zoho flow for Pienissimo Pro
orders** were never discussed pre-sale, are not in the contract, and belong in
a separately quoted evolutiva. Pienissimo Software Srl is a different legal
entity from this project's client.

Sabatino Rinaldi and Fabrizio Paganelli disagree — they maintain the Zoho item
at least was discussed — and escalated to Daniela Morgese.

**This has now run four consecutive meetings without closing**, and on
2026-08-06 Sabatino admitted he had not read the minuta that flagged it:
_"Io non l'ho nemmeno letto quello, ho preso direttamente il link."_

Two things make it worse than an ordinary commercial disagreement:

1. Daniela approved the **phase 1 / phase 2 timeline** and Sabatino reported
   the approval in session — but she approved dates, not scope or budget. See
   [OI-83](../items/OI-83%20No%20phase%202%20estimate.md), where Sabatino states
   outright that _"Daniela non sapeva questa informazione qui."_
2. The disputed items are tracked as ordinary open work in
   [OI-37](../items/OI-37%20E-commerce%20parallel%20flow%20build.md) and
   [OI-38](../items/OI-38%20Salesforce%20to%20Zoho%20for%20Pienissimo%20Pro.md), so a
   developer reading the tracker would build them.

## The project plan is evidence, and it cuts both ways

`Pienissimo_Project Plan.pptx` (Elena Spini, 10 July, Drive project folder) —
read on 2026-08-14 — lists the integrations by phase, explicitly:

- **Fase 1:** WooCommerce → SFDC · Mexal ⇆ SFDC · Anticipay → SFDC
- **Fase 2:** **GLS → SFDC** · **Teachable → SFDC** · **Ordini Pienissimo Pro:
  SFDC → Zoho Pienissimo Software SRL**

Read carefully before using it in the argument. It supports ROMI's position
that the three are a **separate phase** — they are named as Fase 2, with their
own go-live of **9 November** and their own approval gate. It does **not**
support the stronger claim that they are outside the project: they appear in
ROMI's own plan as project scope, and that plan is what Sabatino Rinaldi says
Daniela Morgese approved.

So "Daniela approved the timeline" and "the phase 2 items are not in the
contract" are both defensible from the same document. That is precisely why
this has not closed in four meetings, and why
[OI-83](../items/OI-83%20No%20phase%202%20estimate.md) — no estimate, decision-maker
never briefed — is the thing that actually has to move.

Until it closes, treat all three as **out of scope and unbuilt**, and do not
let them consume a build slot in the
[compressed window](Risk%20-%20the%20whole%20remaining%20build%20lands%20after%20Ferragosto.md).

⚠ **The pre-sales record is not reachable from Aurel's mailbox.** The earliest
Pienissimo mail there is **24 June 2026** — he was onboarded a month after the
27 May kickoff. Whatever was or was not discussed "in fase di prevendita" sits
with Elena Spini or Andrea Galotto, not here.

## The client put all three in writing on 11 June

[Pienissimo's own requirements document](../The%20client%20June%20requirements%20document.md),
sent to Elena Spini before the 16 June call and read here for the first time on
2026-08-14, contains all three disputed items **as requirements and as direct
questions to ROMI**:

- §2.9 lists **GLS** and **Teachball** among _"Integrazioni richieste"_
- §2.7 describes the parallel flows for book, video courses and **Pienissimo
  Pro**, with Pienissimo Pro _"instradamento diretto alla Software"_
- **Question 10** asks about GLS delivery notification and Teachable completion
- **Question 11** asks how to route Pienissimo Pro renewals to the software team

**This does not decide the dispute, and it should not be presented as if it
does.** 11 June is *after* the 27 May kickoff, so it is not evidence about the
pre-sale conversation, which is what ROMI's position rests on. What it does show
is that the client raised all three formally and in writing, early, and got as
far as putting them to ROMI as numbered questions. That is why Sabatino Rinaldi
and Fabrizio Paganelli are confident they were discussed — and it means the
argument cannot be won by asserting the topics never came up.

The question that actually decides it is narrower: **were they in the contract**,
which turns on the pre-sale record and the signed scope, neither of which is in
this mailbox.
