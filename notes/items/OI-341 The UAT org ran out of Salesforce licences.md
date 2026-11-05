---
id: OI-341
type: open-item
status: open
owner: Elena Spini
with: Aurel Mrruku
org: ROMI
raised: 2026-11-05
updated: 2026-11-05
depends_on: [OI-300]
blocks: []
source: Slack DM D0B5QHS2T7H, 2026-11-05 18:57 CET
---

# OI-341 - The UAT org ran out of Salesforce licences

**Creating the six tutor users in UAT hit `LICENSE_LIMIT_EXCEEDED` on the evening of
5 November. Existing UAT users were deactivated to make room, on Aurel Mrruku's
instruction to keep only his own. The users were then created and the client was told
they were ready. Nobody has checked whether production has the same ceiling.**

## What happened

Elena Spini → Aurel Mrruku, DM, **18:57:05 CET**:

> _"dobbiamo creare gli user in UAT per 6 agenti, BUT **LICENSE_LIMIT_EXCEEDED:
> License Limit Exceeded - Salesforce []**"_

She then shared `Import_Utenti_Salesforce_UAT.xlsx` (Slack file `F0CF7HGB7M4`,
14.8 KB) and stopped before acting: _"prima di disattivare cose che ti faranno
arrabbiare domani mattina MI FERMO"_.

Aurel Mrruku, **18:57:53**: **_"lascia la mia utenza, per il resto procedi pure"_** →
Elena Spini, 18:58: _"a wow ok allora vado"_.

🟢 **It worked.** Sixteen minutes later, at 19:13 CET, she wrote to Marco Montesi
that the six UAT tutor users were active and had their password links — see
[OI-300](OI-300%20Tutor%20training%20and%20tutor%20test%20access%20are%20unplanned.md).

## Why it is open

1. 🔴 **The ceiling itself is unresolved.** The limit was worked around by removing
   other users, not by adding licences. The next user request in UAT fails the same
   way.
2. 🔴 **Which users were deactivated is not recorded.** The instruction was _"lascia
   la mia utenza, per il resto procedi pure"_ — a blanket authorisation, with no list
   written down by either party. ⚠ Anyone who was testing in UAT and is not Aurel
   Mrruku may have lost access without being told, on the eve of the training.
3. 🔑 **Production has never been counted.** The licence question is already open
   twice over — [OI-262](OI-262%20Sabatino%20Rinaldi%20needs%20a%20Salesforce%20user.md)
   (a fifth client user, licence count unanswered) and
   [OI-324](OI-324%20An%20agent%20user%20leaves%20on%2031%20December%20and%20the%20licence%20must%20be%20reassigned.md)
   (seven provisioned agents against Marco Montesi's six, one leaving 31/12). **If
   Prod is as tight as UAT, the 16 November user start hits this.** Nothing in this
   window inspected Prod.
4. ⚠ The UAT org is also where the tutors will train on 9 and 11 November, so a
   licence pool trimmed to fit six is the environment the training runs in.
