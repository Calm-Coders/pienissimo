---
id: OI-307
type: open-item
status: open
owner: Aurel Mrruku
org: ROMI
raised: 2026-10-30
updated: 2026-11-13
depends_on: [OI-290]
blocks: [go-live]
severity: gating
source: notes/meetings/2026-10-30 Rapido Allineamento Aurel Elena.md
---

# OI-307 - The Lead import needs the duplicate rules disabled

**The client's Lead file carries a masked placeholder in the VAT column for many
rows. Identical placeholders collide under the duplicate rules, so the import will
be blocked. The plan is to switch the rules off for the import only. Nothing
records who switches them back on.**

## The blocker

Aurel Mrruku, [the 30 October internal alignment](../meetings/2026-10-30%20Rapido%20Allineamento%20Aurel%20Elena.md),
around `00:22:00`:

> _"**Partita IVA quando c'è xx** … **duplicati**. **Devo togliere le regole di
> duplicazione solo per l'import.**"_

Elena Spini confirms the placeholder was ROMI's own instruction — _"Tu gli avevi
detto di mettere xx"_ — and that a real value was impossible because the field is
numeric.

🔑 **The placeholder is visible in the delivered file.** `lead-da-importare.csv`
(`1P7oWyZrfg5SlKVbTJtMDK1HDllYjs5ZH`) carries `XXXXXXXXXXX` in the `P.IVA` column
on a large share of rows, alongside genuine values such as Italian VAT numbers.
**The file was not opened for content** — it holds real Lead records; the column
and the placeholder are visible in the Drive search preview alone, and **no row
count was taken**.

## Why it is open

1. 🔴 **Nothing is recorded as done.** The rules are not disabled, the import has
   not run, and the Lead load is the next migration step in front of
   [OI-290](OI-290%20Lead%20and%20Referenti%20migration%20data%20is%20owed%20by%20the%20client.md).
2. 🔴🔑 **No re-enable step exists.** _"solo per l'import"_ is the whole of the
   plan. ⚠ **Disabling duplicate rules on Lead and leaving them off through
   go-live would let the sales team create duplicates freely from 16 November.**
   Nobody owns turning them back on, and no checklist carries it — including
   [the Manual Steps tracker](../Manual%20Steps%20Pienissimo%20tracker.md), which is
   where a step like this belongs.
3. ⚠ **Which rules, on which object, is unstated.** Lead duplicate rules,
   matching rules, or both; and whether the Account/Contact rules are implicated
   when these Leads are later converted.
4. 🔑 **It compounds [OI-302](OI-302%20WooCommerce%20matches%20customers%20by%20email%20instead%20of%20partita%20IVA.md).**
   The same day, partita IVA was adopted as the uniqueness key for WooCommerce
   customers. **A population of Leads loaded with a masked VAT number is a
   population the new key cannot distinguish**, if any of them later becomes a
   customer. The two decisions were taken five hours apart and nobody connected
   them.

## Also from the same exchange: the consent flags

🔑 **The client set the consent flags uniformly true, and said he did not care.**
Elena Spini: _"ha detto che mette tutti tu[tti true] … ha detto che non gli
interessa"_, after Aurel Mrruku noted _"c'è anche il flag di normativa privacy"_.
The delivered file shows `Flag consenso Profilazione` and `Flag Informativa
Privacy` as `true` on every row visible in the preview.

⚠ **This is a data-protection question and nobody has raised it as one.** Whether
a blanket `true` reflects consent actually held for years-old Zoho Leads is not
evidenced anywhere, and these records should not assert that it does. It is
recorded here as what was said, by whom, and what the file shows.

## 2026-11-13 - checked in Prod: no rule had to be disabled

The two Lead duplicate rules in Prod are set to **Allow** on insert, yet the API still
rejects a duplicate hit (`DUPLICATES_DETECTED`) unless the call carries `allowSave`.
The Referenti Lead load sent it from Apex for the 2,059 rows concerned, so **no rule was
switched off and none needs switching back on**. Most hits were Lead-against-Lead matches
on name plus a shared placeholder company, not genuine duplicates. A masked VAT value was
not involved: the Referenti were loaded with the field empty. This does not cover the
29 October Lead file, which is still not loaded.

## 2026-11-13 - the second Lead file (`lead-da-importare.xlsx`) was imported; the masked VAT was not

The blocker named above is real but sits in code, not in a duplicate rule:
`LeadConversionTriggerHandler.preventDuplicateOpenLeads` compares `Partita_IVA__c` as text,
so the masked `XXXXXXXXXXX` carried by **9,527 of the 11,172 rows** would have been accepted
once and refused for every other row. Disabling duplicate rules would not have helped. The
masked value was therefore **written to no Lead** (the field is not mandatory); only 1,301 real
P.IVA were stored. Result and counts: see
[OI-351](OI-351%20Referenti%20without%20a%20Mexal%20code%20are%20imported%20as%20marketing%20leads.md).
