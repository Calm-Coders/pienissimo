---
id: trace-2026-09-25
type: reference
status: active
updated: 2026-09-25
watermark_used: 2026-09-24T22:00Z
external_watermark: 2026-09-25T13:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-09-25

**Watermark for the next `requirements-check` run: 2026-09-25T13:00Z, single value.**
The nightly run tonight should start here, not at 22:00Z yesterday.

**Watermark used: 2026-09-24T22:00Z**, the `external_watermark` of
[the 24/09 nightly trace](Source%20trace%202026-09-24%20nightly.md).

An **on-demand run**, requested by Aurel Mrruku at ~12:40Z (_"check all the meetings
and do a drill me like the job at 23"_), followed by a drill-me session.
**Not posted to Slack**: only the scheduled nightly run may send its report.

## Sources searched

| Source     | Query / scope                                                                            | Result                                                                                                                                                                                      |
| ---------- | ---------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Fathom** | `list_meetings created_after 2026-09-24T22:00Z`, 3 pages                                 | **0 meetings**                                                                                                                                                                              |
| **Drive**  | `modifiedTime > '2026-09-24T22:00:00Z'`, page 1 (5 files) + title search on new meetings | 🔑 **`UAT: Recall Tutor + Bundle` notes + transcript** (read in full, 154,062 chars) · data-model workbook re-saved 10:25Z · client import workbooks from 24/09 (not opened: customer data) |
| **Gmail**  | `pienissimo after:2026/09/24 -in:draft`, 40 requested, 8 estimated                       | 🔑 Gemini notes mail for the UAT session (read in full) · invitation `[PIENISSIMO] - Interna` Fri 02/10 17:00 CEST · everything else already held                                           |
| **Slack**  | workspace-wide `after:2026-09-24`, by timestamp, 20 results                              | Aurel Mrruku → Anita Aga 11:41–11:42 CEST (`Evento di origine`, `Presenza piattaforma`) · Rexhina Hysi PR #61 · Anita Aga: one test bundle mapped · other-client channels ignored           |
| **Slack**  | DM `D0B5QHS2T7H` (Elena Spini), from 24/09 22:00Z                                        | an internal call 12:30–13:00 CEST, _"cosi registriamo se dovesse servire"_. **No notes or recording found on Drive**                                                                        |
| **Slack**  | `C0BQD34LLF4` (dev group), from 24/09 22:00Z                                             | last night's report 00:03 CEST; Aurel Mrruku 10:18–10:25 CEST on the PR #59 merge conflicts: _"pr merged"_                                                                                  |
| **Git**    | `fetch --all --prune`, `log --all --since 2026-09-24T22:00Z`                             | 12 commits; `DevMain` at `ab318f3`; `DevAnita25/09` `c3aa064` _"Added Campaign Fields"_ (12:17Z, no PR)                                                                                     |
| **GitHub** | `gh pr list --state all --limit 6`                                                       | 🔑 **#59, #60, #61 merged** 08:17–10:06Z                                                                                                                                                    |

`#tproj-pienissimo` was not read separately; the workspace-wide search returned no post
from it in the window.

## Found

1. 🔑 **[UAT Recall Tutor e Bundle](../meetings/2026-09-25%20UAT%20Recall%20Tutor%20e%20Bundle.md)**:
   stage-sale bundles need tranches at bundle creation
   ([OI-181](../items/OI-181%20Stage-sale%20bundles%20need%20their%20tranches%20defined%20at%20bundle%20creation.md));
   WooCommerce opportunity type ([OI-182](../items/OI-182%20A%20WooCommerce%20opportunity%20record%20type%20replaces%20Recall%20Tutor.md));
   email template choice ([OI-183](../items/OI-183%20The%20checkout%20email%20template%20choice%20is%20with%20the%20client.md));
   anno solare → **anno accademico** (reversal, OI-46); a decision confirming `BUN-06`;
   marketing moved to 07/10 (OI-177).
2. 🔴 **PR #59 merged**, so `Account.Agente__c` and `Codice_Agente_Esterno__c` are both on
   `DevMain` (OI-178).
3. 🔴 `Firmato` (OI-151) is **not** in `force-app` on `ab318f3`.

## Not done in this run

- The org was not opened, so `STATUS.md` was not regenerated.
- The transcript was **not** copied into `meetings/` and no per-meeting recap was written
  in `meetings/results/`, as on every run since 27/08.
- The Italian §47 of `DEVELOPMENT-RECAP.it.md` (24/09) is missing. Flagged in §48-IT.

## Still unreachable

- The 12:30 CEST internal Elena Spini ↔ Aurel Mrruku call: recorded "if needed", no
  artifact found.
- `Flows & Objects.drawio` (unchanged), the 30/07 marketing notes.
