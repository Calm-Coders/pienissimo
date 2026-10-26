---
id: ref-oi-189-193-reserved
type: reference
status: active
owner: Aurel Mrruku
org: ROMI
raised: 2026-09-29
updated: 2026-09-29
---

# Item ids 189 to 193 are reserved by an uncommitted org status check

**Five item numbers are in circulation with the dev team but exist nowhere in this
repository. Do not reuse them.**

An `org-status-check` run on **29/09, 10:17–10:25 UTC** (Pienissimo UAT
`00DMA000004nMMr2AM` against `DevMain` `3e1a350`, read-only) reported its findings
to the dev group at 12:49 CEST under five new ids. Its own report states **_"No org
write, deploy, Apex test run, commit or push"_** — so the notes it says it wrote
were never committed, and the session's container is gone.

| Id | Subject as reported |
| --- | ------------------- |
| OI-189 | Quote state — UAT has active `Firmato` and creates Orders there; `DevMain` created them at `Accettato` |
| OI-190 | Ticketing — three ticket classes, one PDF page and the QR-to-document hook exist only in UAT |
| OI-191 | Tranche payment — the `Incassato` Order close after all tranches are paid is in `DevMain`, absent from the deployed UAT handler |
| OI-192 | UAT bundle editor HTML/JS/CSS differs from source |
| OI-193 | UAT Lead path HTML/JS/CSS differs from source |

**Why they must not be recycled:** [AGENTS.md](../AGENTS.md) makes item ids 1:1
with the client-facing tracker's numbers, and these five have already been read by
the dev group under those meanings. Allocating 189 for something else would put two
meanings on one number in the team's own correspondence. **The next free id is
197**, after
[OI-194](items/OI-194%20The%20ticket%20is%20a%20signed%20participation%20document%20not%20just%20a%20QR%20code.md)–[OI-196](items/OI-196%20Whether%20tickets%20are%20sent%20when%20the%20buyer%20names%20only%20some%20participants.md).

## What happened to the underlying findings

- **OI-189 closed itself the same day.** `f53016d` (Anita Aga, 29/09 11:18 CEST) put
  `Firmato` into `QuoteStatus.standardValueSet` and rewired `QuoteTriggerHandler`;
  it reached `DevMain` at 17:49 CEST via PR #68, hours after the check ran. The
  check's reading was correct when taken. See
  [OI-151](items/OI-151%20Quote%20signature%20step%20before%20the%20order%20is%20generated.md).
- **OI-190** is the participant-document stack, now tracked under
  [OI-185](items/OI-185%20The%20participant%20name%20change%20regenerates%20the%20ticket%20as%20a%20new%20asset.md)
  and [OI-194](items/OI-194%20The%20ticket%20is%20a%20signed%20participation%20document%20not%20just%20a%20QR%20code.md).
- **OI-191** is [OI-69](items/OI-69%20Order%20state%20model.md)'s deploy gap.
- **OI-192 / OI-193** are org-vs-source drift with no note. ⚠ **They are the only
  two of the five with no home in the repository** — if the drift matters, someone
  has to re-establish it, because the evidence went with the session.

⚠ Whoever next runs `org-status-check` should **commit before reporting**, or
report without allocating ids.
