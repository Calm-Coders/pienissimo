---
id: obj-unrequested-implementation
type: object
status: active
owner: Aurel Mrruku
org: ROMI
raised: 2026-08-25
updated: 2026-08-25
source: org-status-check against Pienissimo UAT, 2026-08-25
evidence: sf org list metadata + sf sobject describe, Pienissimo UAT
---

# Unrequested implementation in the org

Components present in Pienissimo UAT that **no requirement in this repository
asks for**. None is a defect. They are recorded so that the next
`org-status-check` does not re-discover them as findings, and so nobody spends a
sprint explaining them.

Three of them do carry a real cost, noted below.

## Stock sales-path fields on Opportunity

`Budget_Confirmed__c`, `Discovery_Completed__c`, `ROI_Analysis_Completed__c`,
`Loss_Reason__c` — in the org, absent from `force-app/`, referenced by no
requirement and by no minute. These are Salesforce's own sample sales-process
fields, shipped with the org rather than built for this project.

⚠ **`Loss_Reason__c` is a name collision worth watching.** The project built
`Opportunity.Motivazione_Chiusa_Persa__c` for exactly this purpose, with the
four agreed Italian values. Two loss-reason fields now sit on the same object.
The stock one should be removed from layouts before UAT so users cannot fill in
the wrong one.

## Experience Cloud scaffolding

Sixteen Apex classes — `CommunitiesLandingController`, `CommunitiesLoginController`,
`CommunitiesSelfRegController`, `CommunitiesSelfRegConfirmController`,
`MicrobatchSelfRegController`, `SiteLoginController`, `SiteRegisterController`,
`MyProfilePageController`, `ChangePasswordController`, `ForgotPasswordController`
and their test classes — plus the matching pages. Stock, shipped with the org.

⚠ **They are not free.** Six of them appear in `ApexCodeCoverageAggregate` at
**zero coverage**, adding roughly 130 uncovered lines to the org-wide figure the
75% production floor is measured against. They have to be covered or excluded
when the test suite is written — see
[OI-64](../items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md).

## Salesforce internal objects

`In_App_Checklist_Settings__c` and the `sfdcInternalInt__*` permission sets
(`sfdc_a360`, `sfdc_activityplatform`, `sfdc_scrt2`,
`sfdc_nc_constraints_engine_deploy`, `sfdc_a360_sfcrm_data_extract`). Platform
internals. Ignore them.

## Quick actions that look like project work and are not

`Account.Child_Account` and `Campaign.Child_Campaign`, both last modified
**2026-05-13 by "Amministratore Pienissimo"** — three months before the
20 August campaign design.

⚠ **`Campaign.Child_Campaign` will be mistaken for the campaign parent/child
model.** It is not: see
[the campaign parent and child model](The%20campaign%20parent%20and%20child%20model.md),
which is confirmed unbuilt.

## Not on this list

`Integration_Configuration__c`, `Integration_Log__c` and `API_Callout_Engine`
are unrequested in the strict sense but are
[ROMI's standard scaffolding](../Integration%20Configuration%20is%20standard%20ROMI%20scaffolding.md),
built on every project. Already recorded; do not re-flag.
