---
id: OI-86
type: open-item
status: open
owner: Elena Spini
with: Rebecca Marmo
org: both
raised: 2026-08-06
updated: 2026-09-03
blocks: [OI-78]
source: meetings/results/2026-08-06-chiusura-punti-aperti.md
requirement: BIG-18
---

# OI-86 - Who hosts the participant landing page

Salesforce community versus the marketing platform's own landing page. Aurel
Mrruku asked; Elena Spini's reading is that marketing has its own logic and
page.

Note the split already agreed: the **opening funnel communication is
marketing-side**, the **per-participant QR email is sent from Salesforce**. So
the page sits on a seam, and whichever side hosts it has to reach across —
either marketing writes back Contact and Campaign Member records, or Salesforce
serves a page inside a marketing-driven funnel.

[Rebecca Marmo's](../people/Rebecca%20Marmo%20-%20Pienissimo%20marketing.md) call
decides, and that meeting is scheduled only as "after 17 August"
([OI-81](OI-81%20Event%20communication%20funnel.md)).

This blocks [OI-78](OI-78%20Participant%20data%20collection.md), which is the
entry point to the entire
[ticket lifecycle](../flows/The%20ticket%20lifecycle.md) — a one-line decision
holding up the top-priority phase 1 deliverable.

An Experience site called "Landing page marketing" already exists and is Live
in UAT. Whether it is meant for this is not recorded.

## ⚠ 2026-09-02 — ROMI has staffed a community workstream while this is undecided

Aurel Mrruku to Rexhina Hysi on Slack, 11:04 CEST, in Albanian:

> _"nga ana jote dua qe te punosh me community te pienissimo"_ — from your side I
> want you to work on the Pienissimo community.

He shared the project's 1Password vault with her the same hour. She had just
finished another engagement and Aurel Mrruku told Gianpaolo Motta the same
afternoon that he was putting her on Pienissimo.

**A developer is now assigned to "the community" while the record still says
nobody has decided whether the participant landing page lives on a Salesforce
community at all.** That decision belongs to Rebecca Marmo's call, which has
never been scheduled beyond _"after 17 August"_.

⚠ **This is an assignment overheard in a DM, not a decision.** It says nothing
about which community — the participant landing page, the
[BIG-13 Option B signature upload page](../../REQUIREMENTS.md), or the
`Landing page marketing` Experience site that is already Live in UAT and whose
purpose is unrecorded. **Ask Aurel Mrruku which of the three he means before
reading any scope into it**, and do not treat this item as decided.

## 🔴 2026-09-03 - overtaken by a build, not answered

**The page was built on a Salesforce Experience Cloud community and merged to
`DevMain` at 15:02:59Z**, one day after the DM that assigned the work —
[the Landing Page community](../objects/The%20Landing%20Page%20community.md).
It was published to the UAT sandbox the same afternoon.

So the question this item exists to ask — **Salesforce community or the marketing
platform's own landing page** — now has an answer in code.

**It still has no answer in the record.** Rebecca Marmo's call has never been
scheduled beyond _"after 17 August"_. Elena Spini's stated reading, that
marketing has its own logic and its own page, has never been retracted. No
session minuted this, no mail states it, and the PR carries no description.

⚠ **Three consequences a person should look at, not an agent:**

1. **The seam this note describes is still there.** If the page lives on
   Salesforce inside a marketing-driven funnel, marketing has to hand off to it —
   and [OI-81](OI-81%20Event%20communication%20funnel.md)'s funnel work is being
   built by Fabrizio Mastracci **on the marketing side, right now**, with the
   `30 vs 60` day trigger still undecided.
2. **Rebecca Marmo has not been told.** The current system's landing page is
   hers, with its `CF1`/`CF2` variable fields serving several concurrent events.
3. **The ambiguity this note raised on 2 September is resolved for two of three
   readings.** The community Rexhina Hysi was told to work on turns out to be
   this one *and* the quote page. It is **not** the `Landing page marketing`
   Experience site already Live in UAT, whose purpose remains unrecorded.

**Leave this item open.** A build is evidence of what happened, not a record of a
decision, and the difference matters when the client asks who chose it.
