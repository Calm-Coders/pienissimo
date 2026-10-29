---
id: OI-288
type: open-item
status: open
owner: Aurel Mrruku
org: ROMI
raised: 2026-10-26
updated: 2026-10-26
depends_on: [OI-286]
blocks: [go-live]
source: Gmail 1a1790a907c70ed4
---

# OI-288 - Editing a Contact fails in production when the Account has no Agente

**`ContactTriggerHandler` updates the Contact's Account without guarding the
DML, so an active validation rule that requires `Agente__c` on Azienda accounts
rolls the user's Contact edit back. It fired in production at 16:28Z on 26
October, ninety minutes after the DevMain release.**

## The evidence

Salesforce error mail to `a.mrruku@romicompany.com`, **2026-10-26T16:28:17Z**
(Gmail `1a1790a907c70ed4`):

> _"Apex script unhandled trigger exception by user/organization:
> 005SW00000PV5Ja/00Dbl000005BSMH. Organization: Pienissimo srl
> (ability-customization-52152.my.salesforce.com). ContactTrigger: execution of
> AfterUpdate caused by: System.DmlException: Update failed. First exception on
> row 0 with id 001SW00000g5uixYAA; first error:
> FIELD_CUSTOM_VALIDATION_EXCEPTION, Agente è obbligatorio.: [Agente__c].
> Class.ContactTriggerHandler.syncAccountPrincipalEmails: line 203"_

🔴 **This is production**, not the sandbox: the host is
`ability-customization-52152.my.salesforce.com` with no `--partial.sandbox`
suffix, and the org id is `00Dbl000005BSMH`. The running user is
`005SW00000PV5Ja`, which the flow mails of the same evening name as **Tech
Romi**.

🟢 Aurel Mrruku forwarded it to Rexhina Hysi and Anita Aga at 16:40:42Z, so it
is seen. ⚠ Nothing records a fix.

## The cause, confirmed in source

Both halves are in the repository at `origin/DevMain` `428f42b`:

- **`ContactTriggerHandler.cls:203`** is `update accountsToUpdate;` — a bare
  DML, inside `syncAccountPrincipalEmails`, which writes
  `Account.Email_Contatto_Principale__c` when the principal contact's email
  changes. No `Database.update(..., false)`, no try/catch.
- **`Account.Agente_required_for_Azienda_and_Locale`** is `active`, with
  `errorConditionFormula` `AND($RecordType.DeveloperName = "Azienda",
  ISBLANK(Agente__c))` and `errorMessage` **`Agente è obbligatorio.`** — the
  exact string in the mail.

So any Contact edit that changes the principal email on an **Azienda** account
with an empty `Agente__c` re-validates that Account, trips the rule, and —
because the exception is unhandled in an after-trigger — **the whole
transaction rolls back and the user's Contact edit is rejected.** The account
itself was already invalid; the Contact edit is merely what revealed it.

## Why it matters now

- 🔴 It is **the same defect shape as
  [OI-286](OI-286%20Lead%20conversion%20throws%20in%20UAT%20when%20the%20user%20cannot%20create%20a%20Task.md)**
  — an unguarded DML in an after-trigger handler destroying an unrelated user
  edit — one sibling in UAT on 23/10, this one in production on 26/10. OI-286's
  remedy was permissions; **permissions cannot fix this one**, because the
  blocker is a validation rule on data, not access.
- ⚠ **The diagnostic goes to a developer's mailbox**, not to the user, who sees
  only a failed save.
- 🔑 **The population is unknown and knowable**: however many Azienda accounts
  carry an empty `Agente__c`, each is a Contact edit that will fail. Migrated
  accounts are the obvious risk — the historical load sets an agent from
  _"codice 610"_ where one is missing
  ([OI-244](OI-244%20Historical%20orders%20will%20be%20migrated%20from%20Mexal%20by%20spreadsheet.md)),
  but nothing says the same default is applied to accounts.
- ⚠ **Not verified against the org.** An error mail proves an event, never a
  standing state — the lesson from
  [the 27/08 case](../risks/Risk%20-%20LeadConversionQueueable%20is%20broken%20in%20the%20Pienissimo%20sandbox.md).
  The org was not opened in this run.

## What a fix has to decide

Two different things, and the record settles neither:

1. **Should the sync tolerate an invalid Account?** `Database.update(records,
   false)` with the failures logged would let the Contact edit succeed and leave
   the account email stale. That is a behaviour choice, not a typo.
2. **Should Azienda accounts without an Agente exist at all?** If the rule is
   right, the data is wrong and wants a backfill before go-live. If the data is
   legitimate, the rule is too broad.

⚠ Note also a pre-existing mismatch in the rule itself: its `description` says
_"Requires an Agente for both Azienda and Locale accounts"_ while the formula
tests **Azienda only**. Recorded, not repaired.
