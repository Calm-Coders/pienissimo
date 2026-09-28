---
id: OI-183
type: open-item
status: open
owner: Marco Montesi
with: Aurel Mrruku
org: Pienissimo
raised: 2026-09-25
updated: 2026-09-25
depends_on: [OI-49]
source: notes/meetings/2026-09-25 UAT Recall Tutor e Bundle.md
---

# OI-183 - The checkout email template choice is with the client

From [UAT Recall Tutor e Bundle](../meetings/2026-09-25%20UAT%20Recall%20Tutor%20e%20Bundle.md),
`00:15:20`–`00:24:42`.

## Already agreed

- A **button** in the email, not the raw checkout link.
- The recipient is **prefilled with the primary contact's email** and stays editable
  (Sabatino Rinaldi).
- The greeting uses the **customer's name** and the email is signed with the
  **agent/tutor's name**, not _"gentile cliente"_ / _"team Pienissimo"_. Marco Montesi:
  _"fondamentale"_.
- Each email can be edited in the pop-up before sending.

Aurel Mrruku owns all four (Gemini action _"Implementare Email Prefill"_).

## The choice the client owns

| Option                              | Base text changed by          | Dynamic (customer name, tutor)            |
| ----------------------------------- | ----------------------------- | ----------------------------------------- |
| Template in code (as built)         | a developer, then a release   | **yes**                                   |
| Standard Salesforce email templates | a system admin, in production | no, or only with merge fields (see below) |

Marco Montesi objected that today they change texts whenever they like: _"questo è un
grosso limite per come lavoriamo oggi"_. Sabatino Rinaldi clarified that the individual
email stays editable; only the **base** text is fixed. The session left it _"su questo
ci aggiorniamo"_. Fabrizio Paganelli's condition: every customer-facing text must be
**reviewed with the direction** first, because changes later could be costly.

## Open

- ⚠ **The either/or was presented more starkly than it is.** Standard Lightning email
  templates support merge fields from the related record (opportunity owner, contact
  first name), so a template an admin can edit may still carry the name and the tutor.
  **Check before the client decides**, since it may remove the trade-off.
- The client owes the texts, reviewed by the direction. No date was set.
