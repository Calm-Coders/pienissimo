---
id: OI-337
type: open-item
status: open
owner: unassigned
with: Aurel Mrruku
org: ROMI
raised: 2026-11-05
updated: 2026-11-05
depends_on: [OI-286]
blocks: []
severity: gating
source: Salesforce error mail, 2026-11-05T08:38:04Z, Gmail 1a1aadbab1e35bdc
---

# OI-337 - Lead conversion throws in production when the Opportunity fields are inaccessible

**A Lead update in Pienissimo **production** threw an unhandled Apex exception on
5 November at 08:38:04Z. The trigger copies seven fields onto the converted
Opportunity and the running user cannot edit them, so the whole `AfterUpdate` dies.
It is the second instance of the same defect class as
[OI-286](OI-286%20Lead%20conversion%20throws%20in%20UAT%20when%20the%20user%20cannot%20create%20a%20Task.md),
and this one is in the live org, eleven days before the user go-live.**

## The error

Salesforce → `a.mrruku@romicompany.com`, **2026-11-05T08:38:04Z** (Gmail
`1a1aadbab1e35bdc`), organisation **`00Dbl000005BSMH`**,
`ability-customization-52152.my.salesforce.com` — **no `--partial` suffix, so this
is Prod, not the sandbox of OI-286** — running user `005SW00000R9XWh`:

```
LeadConversionTrigger: execution of AfterUpdate
caused by: System.DmlException: Operation failed due to fields being
inaccessible on Sobject Opportunity, check errors on Exception or Result!
Class.LeadConversionTriggerHandler.copyConvertedFields: line 95, column 1
Class.LeadConversionTriggerHandler.afterUpdate: line 26, column 1
Trigger.LeadConversionTrigger: line 11, column 1
```

## What line 95 is

In `force-app/main/default/classes/LeadConversionTriggerHandler.cls`, line 95 is
`update opportunitiesToUpdate.values();` — the unguarded DML that writes the fields
assembled at lines 57-71:

| Field written on the converted Opportunity |
| --- |
| `Categoria__c` |
| `Sottocategoria__c` |
| `UTM_Campaign__c` |
| `UTM_Content__c` |
| `UTM_Medium__c` |
| `UTM_Source__c` |
| `UTM_Term__c` |

The DML runs in the user's own context, so a user who lacks **edit** access to any
one of those seven fields fails the whole statement. ⚠ **Which field and which
profile or permission set is missing is not established** — the exception names the
object, not the field, and **no org was opened in this session**. The user id
`005SW00000R9XWh` was not resolved to a person.

## Why it matters

1. 🔴 **It is production.** OI-286 was the partial sandbox; this is the org the
   client works in and the one the 16 November user start depends on.
2. 🔑 **The failure mode is the same as OI-286's** — an unguarded DML in
   `AfterUpdate` that assumes the running user's field access — so the fix pattern
   is the same, and OI-286's fix was never merged:
   `Devmain_LeadChecks` (`42602a8`) is still an unmerged branch with no PR.
3. 🔴 **The Lead edit is rolled back.** The user sees a failure, not a degraded
   conversion, so a converted Lead can be left unconvertible by that user.
4. ⚠ It landed on the same day the client was blocked out of Prod
   ([OI-339](OI-339%20The%20client%20was%20locked%20out%20of%20production%20during%20the%20migration%20load.md))
   and the product-field permissions were being changed by hand
   ([OI-338](OI-338%20The%20product%20Tipo%20Biglietto%20field%20cannot%20be%20edited%20in%20production.md)).
   **Nothing establishes a connection**; the coincidence is recorded, not read.

## What is owed

- Resolve `005SW00000R9XWh` and establish which of the seven fields it cannot edit.
- Decide whether the fix is the permission grant or a guard in the handler. 🔴 **No
  owner was named for this** — the exception notification reaches Aurel Mrruku
  because he is the Apex exception recipient, which is not an assignment.

## Related

- [OI-286](OI-286%20Lead%20conversion%20throws%20in%20UAT%20when%20the%20user%20cannot%20create%20a%20Task.md)
  — the same handler, the same class of defect, in UAT
- [OI-170](OI-170%20DevMain%20is%20ahead%20of%20UAT%20on%20the%20Lead%20conversion%20and%20quote-line%20paths.md)
- [OI-307](OI-307%20The%20Lead%20import%20needs%20the%20duplicate%20rules%20disabled.md)
