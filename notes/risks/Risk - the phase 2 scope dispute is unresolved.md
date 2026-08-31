---
id: risk-phase2-dispute
type: risk
status: open
severity: high
owner: Elena Spini
org: both
raised: 2026-07-10
updated: 2026-08-28
depends_on: [OI-37, OI-38, OI-83, OI-94]
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

## 2026-08-25 - Fase 1 now depends on the disputed entity

🔴 **The line ROMI is defending got harder to hold, and nobody in the room
noticed.**

[The Anticipay session](../../notes/meetings/2026-08-25%20Integrazione%20Anticipay.md)
agreed that Salesforce will not call Anticipay directly. It will call **an API
built and hosted by Pienissimo Software Srl**, acting as middleware
([OI-94](../items/OI-94%20Anticipay%20is%20called%20through%20the%20Pienissimo%20middleware.md)).
Anticipay → SFDC is a **Fase 1** integration in ROMI's own project plan, quoted
above.

So Fase 1 cannot go live unless the entity ROMI argues is *not* this project's
client **writes a service, stands up a test environment for it, and keeps it
running**. Until 25 August the crossover was only that its maintenance manager
was the named technical contact. It is now a build dependency.

Nothing was said about who pays for that work, who owns the middleware after the
project closes, or which contract it sits under. The decision was taken on
technical merit — cost of repeat lookups, insulation from endpoint changes — and
both arguments are good ones. That is not the issue; the issue is that a
commercial boundary moved inside a technical decision.

Elena Spini restated the corporate structure on Slack the same morning, so the
distinction is live in her mind: _"La loro società è Pienissimo SRL che
rivenditore del software Pienissimo Pro, di proprietà di un'entità legale
distinta, Pienissimo Software SRL."_ — Pienissimo Srl **resells** Pienissimo Pro;
the software is owned by Pienissimo Software Srl. It is the clearest statement of
the relationship in the record.

**This needs Elena Spini before the middleware is built against, not after.**

## 2026-08-28 - a fifth status post carries the same paragraph, unchanged

Elena Spini posted the weekly status to `#tproj-pienissimo` at **12:13:32Z**,
breaking a **seven-week silence** in that channel (the previous post was
07 August). Her **Red flags** block is **copied verbatim** from the 24 July,
31 July and 07 August posts — the same sentences about GLS, Teachable, the Zoho
flow for Pienissimo Pro orders, the separate legal entity, the agreement with
Andrea G., and _"ne avrebbero discusso anche con Daniela e ci riaggiorneranno
settimana prossima."_

**One sentence is new, and it is prefixed to that paragraph:**

> _"Non ho ancora avuto aggiornamenti su questo vedo di smarcare settimana
> prossima"_

So the position on 28 August is: **Pienissimo has still not come back.**
_"Ci riaggiorneranno settimana prossima"_ was first written on **24 July** and
has now been carried forward, word for word, through **five** weekly status
posts without the promised update arriving.

What this does and does not add:

- It does **not** move the substance. No new argument, no new evidence, no
  decision. Nothing here changes the reading above.
- It **does** date the silence precisely, from ROMI's own PM, in writing:
  **thirty-five days** since the escalation to Daniela Morgese was promised, and
  Elena Spini has committed to _smarcare_ it in the week of **31 August**.

That matters now for a reason it did not in July: since 25 August a **Fase 1**
integration depends on Pienissimo Software Srl building and hosting the
Anticipay middleware (the section above). The commercial boundary is being
crossed by the build while the boundary itself is still unagreed, and the
person who has to close it has just said, in writing, that she has nothing.

⚠ **The 28 August post is not a new source for the dispute's merits** — it is
the same paragraph. Cite the 2026-08-06 session and the project plan for the
substance; cite this post only for the fact that nothing has moved.
