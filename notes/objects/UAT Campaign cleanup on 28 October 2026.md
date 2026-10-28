---
id: uat-campaign-cleanup-2026-10-28
type: reference
status: resolved
updated: 2026-10-28
source: User request in Codex on 2026-10-28
---

# UAT Campaign cleanup on 28 October 2026

The user requested deletion of Campaign records matching
`CreatedBy.Name != 'Amministratore Pienissimo'`, including dependent records
where necessary, and explicitly selected **Pienissimo UAT**.

Completed in one anonymous Apex transaction on 28 October 2026:

- Deleted all **4** matching Campaigns.
- Deleted **82 Event_Invitation__c** records that restricted Campaign deletion.
- Salesforce cascade-deleted **25 CampaignMember** records.
- Preserved **181 Asset** records; their Campaign lookup is now empty.
- Preserved all **36** Campaigns created by the excluded administrator.
- No linked edition mappings, opportunities, protected child Campaigns,
  tasks, events, attachments or content-document links were found.

The script checked the sandbox org identity and exact Campaign IDs, asserted
the dependency counts, and included rollback on any failure. Execution
succeeded with no callouts, email invocations or queued jobs. Post-commit CLI
queries independently verified **0** matching Campaigns, **36** excluded
Campaigns and all **181** original Assets with an empty Campaign lookup.

Local recovery snapshots of the Campaigns, invitations, members and original
Asset links, together with the execution script and result, are under
`.sf/campaign-cleanup-2026-10-28/` (ignored by Git). Production was not changed.
