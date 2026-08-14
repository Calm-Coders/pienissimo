---
id: trace-2026-08-14
type: reference
status: active
updated: 2026-08-14
---

# Source trace 2026-08-14

**Watermark for the next `requirements-check` run.** What was read to build the
`notes/` vault, and what was deliberately not.

## Read

| Source                                              | Extent                                          |
| --------------------------------------------------- | ----------------------------------------------- |
| `meetings/open-items.md`                            | Open table, org verification, both status-update blocks, stale list, resolved summary |
| `meetings/DEVELOPMENT-RECAP.md`                     | §1 project frame, §2 data model, §9 blockers, §11 closing session |
| `meetings/results/2026-08-06-chiusura-punti-aperti.md` | Header, attendees, attribution caveats, cross-meeting updates |
| `REQUIREMENTS.md`                                   | Grep only — sign-off role table, owed-inputs table |
| `requirements/pienissimo-requirements.yaml`         | `meta` and `sources` blocks                     |
| `force-app/main/default/`                           | Full metadata inventory — classes, triggers, objects, fields, LWC, flexipages |
| `git log`                                           | 20 commits back to 2026-07-20, with authors and dates |

## Not read

- **No raw transcript was opened.** ~830 KB, ~207k tokens.
- `REQUISITI.it.md`, `meetings/open-items.it.md`,
  `meetings/DEVELOPMENT-RECAP.it.md` — the Italian twins. English used for
  facts, per [the protocol](../Retrieval%20and%20write%20protocol.md).
- `anar_PIE_ricla.xlsx` — binary; the decode lives in the notes.
- The `Resolved` table below line 175 of `open-items.md` was summarised, not
  split into notes. It remains the archive.

## Not reachable from here

- **The Pienissimo UAT org.** Every statement about deployed state derives from
  the 2026-08-03 verification recorded in the tracker, which is now stale in
  both directions — see
  [the build ahead of the record](../objects/The%20build%20ahead%20of%20the%20record.md).
  A fresh `org-status-check` is the first thing worth running.
- Email, Slack and Drive were not swept in this session.

## Gaps carried forward

- Untracked sessions named in the tracker and never minuted: the **30 July
  marketing follow-up**, the 06-04 marketing demo, ~06-19, 06-23 and 06-25.
- **Rexhina's surname** is recorded nowhere in this repository.
- The **VAT provider** is unconfirmed — Anticipay or CreditSafe, see
  [OI-73](../items/OI-73%20VAT%20validation%20moves%20into%20Salesforce.md).
