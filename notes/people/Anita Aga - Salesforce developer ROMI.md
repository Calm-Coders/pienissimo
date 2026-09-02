---
id: person-anita-aga
type: person
status: active
org: ROMI
team: Calm-Coders
updated: 2026-09-02
---

# Anita Aga - Salesforce developer ROMI

Salesforce developer on this project, part of the
[Calm-Coders team working for ROMI](../Calm-Coders%20on%20GitHub%20means%20ROMI.md).

Between 4 and 7 August she committed the largest single block of build work in
the project: the `OrderBigliettoTrigger` that creates tickets from a confirmed
order (with a test class), the `Integration_Configuration__c` /
`Integration_Log__c` / `API_Callout_Engine` framework, `Solo_Bundle__c`, the
WooCommerce id fields, and the product picklists and custom fields.

**Most of that work is not reflected in any tracker or recap** — the written
record still describes several of those items as unbuilt. That is a gap in the
project's record-keeping, not in the work; see
[the build ahead of the record](../objects/The%20build%20ahead%20of%20the%20record.md).
When reconciling what exists, read her commits alongside the trackers.

Git identities: `Anita Aga`, `anitaaga`.

## 2026-09-02 — full-time on this project, and holding the Anticipay handover

Aurel Mrruku to Gianpaolo Motta, Slack DM, 16:11 CEST: **_"Anita è full su
pienissimo"_** — in a conversation about who is available between now and
October.

Earlier the same day he sent her the project's Notion page, the Notion open-items
view, and a ready-to-run Anticipay call against the new `romi.pienissimo.com`
host with its bearer header (12:05-12:39 CEST).

⚠ **That she now owns the Anticipay build is an inference from the handover, not
a statement.** Nobody said it. What is recorded is the allocation and the three
things she was handed.

⚠ She is also the last person who can answer whether an export was taken before
the 28 August destructive deploy — an ask that has gone unanswered for several
sweeps and is now moot for the data
([UAT data is disposable](../decisions/Decision%20-%20UAT%20data%20is%20disposable%20in%20Fase%201.md))
but not for the deleted Apex
([the code risk](../risks/Risk%20-%20the%20Biglietto%20Apex%20stack%20is%20not%20in%20source%20control.md)).
