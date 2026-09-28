---
id: OI-176
type: open-item
status: open
owner: Aurel Mrruku
with: Sabatino Rinaldi
org: both
raised: 2026-09-24
updated: 2026-09-24
depends_on: [OI-149]
blocks: [go-live]
severity: gating
source: Slack DM D0B5QHS2T7H, Elena Spini 2026-09-24 15:43:58 CEST
---

# OI-176 - Web to Lead assigns every lead the Diretta record type

**The successor defect to
[OI-164](OI-164%20Web%20to%20Lead%20leads%20arrive%20without%20a%20record%20type.md),
found in the first client acceptance session.**

The untyped-lead defect is fixed: leads created by the form now carry a record type.
**They all carry the wrong one.**

| Time (CEST)           |                                                                                                  |
| --------------------- | ------------------------------------------------------------------------------------------------ |
| `00:41:46` in session | Elena Spini: _"Sono tutti record type diretta, ecco perché si vedono così. Quindi è sbagliato."_ |
| **15:43:58**          | Elena Spini, DM, during the session: 🔴 **_"nulla mette solo rt diretta"_**                      |
| 15:44:18              | Aurel Mrruku: _"asp che li chiedoo il htm correto"_                                              |

## What it means

- **`Diretta` is being applied unconditionally**, including to leads that should be
  `Standard`. The record types were split precisely so a streaming-event lead and a
  generic web lead take different paths
  ([OI-149](OI-149%20Two%20Lead%20record%20types.md)), and the two state machines differ:
  `Diretta` has two states, `Standard` has seven.
- The consequence is downstream: a lead wrongly typed `Diretta` skips the `Standard`
  intermediate states and, by the flow the client approved, is converted to Account +
  Contact + Opportunity on qualification during the event.
- 🔴 **It was visible to the client.** The test records created during the session were
  typed `Diretta` and Elena Spini flagged them as wrong in front of the room.

## Why, as far as this sweep establishes

Aurel Mrruku's immediate response — _"asp che li chiedo il htm corretto"_ — points at
**the form markup, not at Salesforce configuration**: a request to Sabatino Rinaldi for
the correct HTML. The previous defect had a platform cause (the creating user could see
neither record type); this one looks like a single hard-coded `recordType` value in the
form the client is posting.

⚠ **Not diagnosed here. The org was not opened and the form markup was not read.**
Nothing in this sweep establishes whether more than one form exists, or whether
Sabatino Rinaldi's forms and the HTML test harness Aurel Mrruku shared in chat behave
the same way.

## Related, and unanswered

The same session raised a question that bears directly on this: **how is a `Standard`
lead supposed to enter the system at all?** Aurel Mrruku asked it (`00:41:46`), Elena
Spini put it to Marco Montesi, and Sabatino Rinaldi described web forms with hidden
fields and UTM parameters. **No ruling is recorded.** If every form is a `Diretta` form,
the question and the defect are the same question.

## Open

- 🔴 **Get the correct form markup from Sabatino Rinaldi** and make the record type
  follow the form, not a constant.
- 🔴 **Rule how `Standard` leads arrive** — form, manual entry, or both.
- ⚠ The test leads created in the 24/09 session are typed wrongly and are in UAT.
