---
id: OI-119
type: open-item
status: resolved
owner: Anita Aga
with: Aurel Mrruku
org: ROMI
raised: 2026-09-04
updated: 2026-10-08
depends_on: [OI-107]
blocks: [OI-73]
requirement: INT-18
source: force-app/main/default/classes/AnticipayErrorNotificationService.cls, read 2026-09-04
---

# OI-119 - The Anticipay error notification goes to a hardcoded ROMI address

**The agreed failure mail was built, and it is addressed to the developer.**

`AnticipayErrorNotificationService` was merged to `DevMain` on 4 September
(PR #32, commit `ad10298`, Anita Aga, _"Automation for Anticipay call, added two
buttons for manual Anticipay check, email send on error"_). It does what the
25 August and 2 September agreements asked for: it inspects the
`Integration_Log__c` rows from an Anticipay lookup, and when any carries
`Is_Error__c = true` it renders the `Anticipay_Error_Notification` template and
sends it.

🔴 **To the wrong recipient, and not configurably.**

```apex
private static final String ADMIN_EMAIL = 'a.aga@romicompany.com';
...
message.setToAddresses(new List<String>{ ADMIN_EMAIL });
```

The design recorded from the **2 September Anagrafica Articoli session** is that
on failure a mail goes to **`amministrazione@pienissimo.com`** — the client's own
administration — carrying a direct link to the Salesforce record
([OI-73](OI-73%20VAT%20validation%20moves%20into%20Salesforce.md),
[the session](../meetings/2026-09-02%20Follow-up%20Anagrafica%20Articoli.md)).
What shipped mails **one ROMI developer's personal work address**.

## Why this is a row and not a nit

**It reads exactly like a development placeholder**, and it probably is. But it
is merged to the working branch, it is not marked `TODO`, and nothing in the
commit, the PR or any message says it is temporary. Left alone it ships, and the
failure mode is silent in the worst way: the integration behaves correctly,
the log is written correctly, the notification is sent correctly — **to someone
who is not the person the process depends on.** Pienissimo's administration would
never learn that a VAT lookup failed, and the first evidence would be a customer
record that quietly never got its data.

Two fixes, and they are not the same size:

- **The address.** Change the constant to the agreed recipient.
- **The mechanism.** A recipient that differs between sandbox and production
  should not be a compiled constant. `Integration_Configuration__c` is ROMI's own
  scaffolding for exactly this and
  [holds zero rows](../objects/The%20integration%20scaffolding%20has%20never%20been%20configured.md);
  a custom setting or custom metadata type is the smaller change.

⚠ **Confirm the recipient before changing it.** The agreed address is the
client's shared administration mailbox, and mailing integration errors there is
a decision about what the client sees. It was agreed in session, but it was
agreed before the mail existed.

## Two smaller things in the same class

- **Send failures are swallowed.** The `Messaging.sendEmail` call sits in
  `try { … } catch (Exception ignored) { System.debug(…) }`. A failed
  notification leaves nothing but a debug line, so the one mechanism that reports
  integration errors cannot itself report that it failed.
- **A missing template degrades silently and correctly.** `getTemplate` returns
  `null` when `Anticipay_Error_Notification` is absent and the class falls back to
  a built-in subject and body. That is the right behaviour and is worth not
  "fixing".

**No date.** The build is done; this is a one-line correction plus a decision
about where the address should live.

## 🟢 2026-10-08 - resolved: the address is a custom setting now

**Anita Aga's `ff3e4d4`** (08/10 14:32 CEST, merged to `DevMain` via PR #88)
replaces the hardcoded constant with configuration:

```apex
- private static final String ADMIN_EMAIL = 'a.mrruku@romicompany.com';
+ private static final String NOTIFICATION_CONFIG_NAME = 'Anticipay_RecipientEmail';
```

New **`Integration_Notification_Config__c`** custom setting with
`Recipient_Emails__c` and `Enabled__c`, read through a new
`IntegrationNotificationConfigService.getRecipientEmails(name)` which splits on
commas, semicolons and newlines, validates each address against a pattern,
de-duplicates case-insensitively and returns an empty list when the setting is
missing or disabled. `MexalCustomerErrorNotificationService` was converted the
same way, under its own configuration name.

🟢 **This also answers the 07/10 request** recorded at
[the WooCommerce UAT](../meetings/2026-10-07%20UAT%20Integrazione%20WooCommerce%20e%20Mexal.md):
a dedicated mailbox for automatic system notifications, owed to Aurel Mrruku. It
is now a configurable recipient list rather than one developer's address.

⚠ **Two things to carry into the Prod deploy, neither reopening the row.**

- 🔴 **An unconfigured org sends nothing.** With no setting record, or
  `Enabled__c` false, both services return early after a `System.debug` and the
  error mail is **silently dropped**. The previous behaviour always mailed
  someone. A custom setting's *record* is data, not metadata, so deploying the
  object does not create it — **the value must be set in UAT and in Prod by
  hand**, and nothing in this sweep confirms either has been.
- The recipient list itself is **not recorded here**, per
  [docs/publishing.md](../../docs/publishing.md).
