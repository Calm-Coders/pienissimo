---
id: OI-347
type: open-item
status: open
owner: Aurel Mrruku
with: Elena Spini
org: ROMI
raised: 2026-11-09
updated: 2026-11-09
depends_on: []
blocks: []
source: Slack D0B5QHS2T7H, 2026-11-09 10:42 CET
---

# OI-347 - Salesforce flagged an unsupported SOAP API login in the production org

**Salesforce sent an ACTION REQUIRED notice about an unsupported platform SOAP API
`login()` call against the Pienissimo production org. ROMI's position, reached in
two Slack lines, is that the project does not use it. Nothing was checked in the
org, and the notice's own deadline was not captured.**

## What arrived

Elena Spini, Slack DM, **2026-11-09 10:42:58 CET**:

> _"mi sono dimenticata di dirti che ho ricevuto questa mail da sfdc per la org di
> Pienissimo >> **SFDC - ACTION REQUIRED: Update Unsupported Platform SOAP API
> login()** Org ID == `00Dbl000005BSMH` --- **PROD PIENISSIMO**"_

Aurel Mrruku, 10:43:26: _"np non la \[usiamo\]"_. Elena Spini, 10:44:02:
_"confermi che non abbiamo log in cosi vero?"_ Aurel Mrruku, 10:44:11: _"yes"_,
with a 👍.

## Why it is open rather than closed

1. ⚠ **The answer is a recollection, not an inspection.** Nothing in this session
   looked at the org's API usage, connected apps or integration users. The
   project calls Mexal, Anticipay, DocuSign, WooCommerce and the Info Point app;
   **which authentication each uses is not recorded anywhere in these notes.**
2. 🔴 **The notice itself was not read.** Only Elena Spini's paraphrase and the
   org id reached this record. **No retirement date, no affected API version and
   no list of offending calls are held.** A Salesforce ACTION REQUIRED notice
   normally carries a release deadline.
3. 🔑 **The org id is new information in itself.** `00Dbl000005BSMH` is recorded
   here as the production org id as Elena Spini stated it. ⚠ **It was not
   verified against the `Pienissimo Prod` CLI target.**
4. ⚠ **It arrived on the day of the technical go-live**, when integrations were
   being switched back on around the migration load, and was dealt with in 73
   seconds.

## What is owed

- The notice itself, with its deadline, forwarded into the record.
- A check of what actually authenticates against the production org, so the _"we
  do not use it"_ is evidenced rather than remembered.
