---
id: risk-second-flow-lost
type: risk
status: open
severity: medium
owner: Aurel Mrruku
with: Anita Aga
org: ROMI
raised: 2026-09-02
updated: 2026-09-02
requirement: [BIG-19]
source: org-status-check against Pienissimo UAT, 2026-09-02 08:05-08:14Z
evidence: Metadata API Flow list and FlowDefinitionView vs git log --all on force-app flows
uncertain: the second Flow's name, trigger and purpose; no surviving record names it
---

# Risk - a second Flow was deleted with no source copy

**The Pienissimo UAT org now contains zero project Flows, and one of the two it
held on 28 August was never in this repository.**

## The evidence, both directions

**The org has none.** Verified two independent ways on 2026-09-02, because a
single empty listing is not proof:

- Metadata API `listMetadata` for `Flow` returns an empty list, with no
  unavailability recorded;
- `FlowDefinitionView` returns **79** flows, and **every one of them is
  namespaced** — managed-package or Salesforce standard. Not one non-namespaced
  flow exists.

**The record says there were two.**
[The 28 August trace](../traces/Source%20trace%202026-08-28.md) states it plainly:
_"2 Flows, `Lead_Non_Risponde_Follow_Up` active"_.

**Git accounts for exactly one of them.**
`Lead_Non_Risponde_Follow_Up.flow-meta.xml` was added in `225b172` (27 Aug,
_"Added logic for Lead flux"_) and deleted in `158c2d0` (31 Aug, _"Modified the
logic for Woocommerce Integration, removed logic from flow and added on
Trigger"_). That deletion is **deliberate, minuted by its own commit message,
and fully recoverable** — the file is in history.

`git log --all --diff-filter=A -- force-app/**/flows/**` returns **that one file
and nothing else**. So the second Flow was org-only, and it is now gone.

## What is actually lost

**Nobody knows.** That is the finding. No surviving artefact names the second
flow — the 28 August run reported a count and one name, published nothing, and
its evidence cache has since been overwritten by later runs. There is no way
from here to say what it did, whether it was active, or whether anything
depended on it.

It may well have been trivial: a scratch flow, a Salesforce-generated screen
flow, something Anita Aga built and replaced with the trigger logic on purpose.
**The point is not that something valuable was lost — it is that the project
cannot tell.**

## Why it is worth a note at severity medium rather than high

Unlike [the Biglietto stack](Risk%20-%20the%20Biglietto%20Apex%20stack%20is%20not%20in%20source%20control.md),
nothing here is known to have been running in production, carrying data, or
costing ~270 lines of work. Nothing decays; there is no recycle-bin window,
because a deleted Flow is not a record.

What it does is confirm that the org-only pattern is **still producing losses**
after the Biglietto stack was supposed to be the lesson — alongside
[two named credentials](Risk%20-%20integration%20credentials%20exist%20only%20in%20the%20org.md)
found unversioned in the same run.

## The ask

**One line from Anita Aga:** was there a second Flow in the Pienissimo sandbox
before 31 August, and what was it? If she remembers it and it mattered, it can
be rebuilt from memory now, cheaply. If she does not, this note closes as an
accepted loss and its value is the pattern, not the artefact.

**Do not reconstruct a flow from inference.** An invented flow in `force-app/`
would be worse than an absent one.
