---
id: OI-89
type: open-item
status: open
owner: ROMI
org: ROMI
raised: 2026-07-17
updated: 2026-08-14
source: Salesforce sandbox exception mail, 2026-07-17 16:00 UTC
evidence: job 707MA00000hkzDD, org ability-customization-52152--partial
---

# OI-89 - BigliettoPdfQueueable callout error

A Salesforce sandbox exception mail of **2026-07-17** reports:

> `BigliettoPdfQueueable for job ID 707MA00000hkzDD:`
> **`Callout not allowed from this future method. Please enable callout by
> annotating the future method. eg: @Future(callout=true)`**

The PDF generation job for tickets **fails at runtime** on a missing
`@future(callout=true)` annotation. It is a one-line fix in principle, but the
class is in the org and
[not in `force-app/`](../risks/Risk%20-%20the%20Biglietto%20Apex%20stack%20is%20not%20in%20source%20control.md),
so it cannot be fixed from this repository as things stand.

**This is the mechanism behind an observation already recorded.** The
2026-08-03 org check found 17 DocuSign envelopes sent and **0 QR codes
generated** —
[the lifecycle has never run end to end](../risks/Risk%20-%20the%20ticket%20lifecycle%20has%20never%20run%20end%20to%20end.md).
This exception is a concrete reason why the QR half never completed, three
weeks before that check.

Nobody raised it in any meeting; it arrived as an automated mail and was never
tracked. Whether it still occurs is unverified — re-run the job, or check the
sandbox exception mail since 17 July.

⚠ Note that the 2026-08-06 session **removed DocuSign from the ticket flow**.
Confirm the PDF/QR path is still wanted in its current shape before fixing it —
see [OI-66](OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md).
