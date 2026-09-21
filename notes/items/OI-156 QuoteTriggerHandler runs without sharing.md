---
id: OI-156
type: open-item
status: open
owner: Anita Aga
org: ROMI
raised: 2026-09-18
updated: 2026-09-21
depends_on: [OI-136]
blocks: [go-live]
severity: gating
source: git 2d31ebe on DevMain via PR #50
---

# OI-156 - QuoteTriggerHandler runs without sharing

`2d31ebe` (Anita Aga, 18/09 18:20:32 CEST) changes one line:

```diff
-public with sharing class QuoteTriggerHandler {
+public without sharing class QuoteTriggerHandler {
```

**Merged to `DevMain` in PR #50 on 2026-09-21T11:00:06Z**, so it is in the branch
UAT deploys from, three days before the client tests.

## Why it is a finding

- **Sharing enforcement was removed from the quote trigger**, which runs on every
  quote insert and update — including the ones reached from the **public community
  quote page**. `QuoteAcceptanceController` is already `public without sharing` on
  a bare `quoteId`, a standing finding since 16/09.
- **The likely motive is on record, obliquely.** At
  [the 21/09 pre-UAT session](../meetings/2026-09-21%20Test%20Interni%20Pre-UAT.md)
  Rexhina Hysi attributed a quote-creation failure to **community guest-user
  permissions**. Widening the handler makes that failure go away. ⚠ **Nobody has
  written down that this is why**, and the inference is not attributed to anyone.
- **No requirement authorises it.** No PR description, no review, no comment.
- 🔴 **It is the same shape as
  [OI-136](OI-136%20Public%20participant%20link%20can%20mark%20an%20order%20Incassato.md)**:
  a guest-reachable write path widened so a flow would work, discovered by reading
  the diff rather than from any decision.
- ⚠ **It is one line inside a 1,068-line commit** titled about the Manage Products
  component — the same pattern that hid the `isSandbox()` guard inside PR #43 on
  15/09 ([OI-137](OI-137%20The%20order%20to%20Mexal%20chain%20is%20disabled%20in%20every%20sandbox.md)).
  Two of the three most severe security findings on this project have arrived as
  incidental lines in large, undescribed commits.

## Open

- 🔴 **Establish whether the widening is necessary**, and if it is, scope it — a
  targeted `without sharing` helper rather than the whole handler.
- 🔴 **If it exists to serve the guest quote page, that is a design decision about
  what an unauthenticated visitor may write**, and it belongs with whoever ruled
  on the equivalent question for the participant page. **Nobody ruled on that one
  either.**
- ⚠ Verify in the org what the community guest profile can actually reach through
  it. This note is repository arithmetic; **the org was not opened.**
