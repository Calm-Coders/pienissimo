---
id: method-picklist-record-type-assignment
type: reference
status: active
owner: Aurel Mrruku
org: ROMI
raised: 2026-09-02
updated: 2026-09-02
source: Loading the Anagrafica Articoli bundle codes into Pienissimo UAT, 2026-09-02
---

# How to add a picklist value that records can actually use

**Deploying a picklist value is not the same as making it usable.** On
2026-09-02 three of ten records failed to insert with

```
INVALID_OR_NULL_FOR_RESTRICTED_PICKLIST: bad value for restricted picklist
field: Happy Team
```

while **every check said the value was fine**. The three that failed were exactly
the values that had just been added or renamed.

## What every check said, wrongly

| Check                                  | What it reported                                             |
| -------------------------------------- | ------------------------------------------------------------ |
| `sf project deploy start`              | `Succeeded`, component `Changed: true`                       |
| `sf sobject describe`                  | value present, `active = true`                               |
| Metadata retrieve of the `CustomField` | value present, `valueSettings` correct                       |
| Dependency bitmap (`validFor`)         | `gAAA` - correct, valid for the controlling value being used |
| Metadata retrieve of the `RecordType`  | **no `picklistValues` block for the field at all**           |

Four of five said yes. The fifth was the answer and looked like an absence.

## The cause

**A new picklist value is not automatically assigned to existing record types.**
`Product2` has two record types (`Item`, `Bundle`), so every insert is evaluated
against the record type's assigned value set - and the new values were in the
field but not on the record type.

🔴 **A Metadata API retrieve of a RecordType omits the `picklistValues` block
when it considers the assignment implicit.** So the retrieved metadata is
identical whether all values are assigned or none are. **You cannot tell the two
apart by reading the retrieved file**, which is what made this cost an hour.

## The fix, and the order it has to go in

1. Add the value to the field's `valueSetDefinition`, plus a `valueSettings`
   entry if the picklist is **dependent** (ours is - `Evento__c` is controlled by
   `Anno_Solare__c`).
2. **Add the value to every record type's `picklistValues` block**, in
   `objects/<Object>/recordTypes/<Name>.recordType-meta.xml`. All of them, not
   just the one you are loading into - a value missing from a sibling record type
   is a trap set for whoever writes the next record.
3. Deploy, then insert.

Doing step 3 before step 2 produces an error that names the value and blames the
value, and every diagnostic you reach for will agree with the value and not with
the error.

## How to actually verify

Do not trust describe or a retrieve. **Insert one throwaway record with the new
value** - it is the only check that exercises the same path the real load will.
That single insert is what settled this after four other checks had said the
opposite.

Sibling method note, same shape of failure from the other direction:
[how to read the org schema without a false negative](How%20to%20read%20the%20org%20schema%20without%20a%20false%20negative.md).
There, `sf sobject describe` **hid** a field that existed; here it **showed** a
value that could not be used.
