---
id: decision-coverage-deferred-fase-1
type: decision
status: resolved
owner: Aurel Mrruku
org: ROMI
raised: 2026-09-02
updated: 2026-09-02
depends_on: []
blocks: []
source: Aurel Mrruku, direct instruction to the agent session, 2026-09-02
---

# Decision - Apex coverage is not a Fase 1 concern

**Apex test coverage is deliberately out of scope for the current build phase.**
Stated by Aurel Mrruku on 2026-09-02: _"in this faase we dont care about the
coverage too"_.

This is not new policy so much as the explicit, dated version of the standing
instruction already in [AGENTS.md](../../AGENTS.md) — the suite is requested as
**one task, separately, before the production deploy**. What is new is that the
0% figure should stop being reported as a live blocker on Fase 1 work.

## What follows

- **Stop leading status summaries with coverage.** It is not a finding about
  this week; it is a known, accepted, dated deferral.
- **Nothing here is written or offered.** No test class, no proposal, no
  scaffold. The standing instruction is unchanged.
- **The records stay current anyway**, because they are the brief for the task
  when it is called:
  [OI-64](../items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md),
  [OI-66](../items/OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md)
  (superseded by deletion, not by coverage) and
  [the deploy risk](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md),
  which **stays open and stays gating**.

## The boundary, stated once

The 75% floor is enforced by Salesforce **at the production deploy**, computed
at deploy time. Deferring coverage costs nothing in a sandbox and everything on
the day of the deploy. So the deferral is safe for Fase 1 and is **not** safe as
a permanent position:

- Fase 1 development ends **10 September**, go-live Fase 1 is **6 October**,
  Fase 2 **9 November**, and the Zoho contract ends **31 October**. The window
  in which the suite must be written and pass is between those dates, and it is
  not scheduled.
- The gap is **1,646 uncovered lines across 21 classes** and grows as code
  lands. It has never been decomposed into an estimate.
- One prerequisite is a one-command chore nobody has run: the largest single
  target, `WoocommerceOrderService`, **is now in the repository** as of the
  2026-09-02 org check, so that prerequisite is met. The Biglietto stack it
  replaced in the count is gone.

Recording the boundary is not a request to act on it.

Related: [UAT data is disposable in Fase 1](Decision%20-%20UAT%20data%20is%20disposable%20in%20Fase%201.md).
