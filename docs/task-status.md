# Task status — ROMI internal

**This is not the client tracker.** `meetings/open-items.md` holds the numbered
`#NN` items that Pienissimo sees and that `REQUIREMENTS.md` cites. This board
holds **ROMI-internal actions** — chores, confirmations and repo work that have
no place in a client-facing row and must not consume an `OI-NN`.

English only; it is never shown to the client.

Opened 2026-08-14. Status legend: 🔴 not started · 🟡 in progress · ✅ done ·
⏸ waiting on someone else.

## Aurel — before the team returns (~24–26 August)

| #   | Action                                                                                                                                                                                                                                            | Why it matters                                                                                                                                                                                                                              | Status                                           |
| --- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------ |
| A1  | **Ask Elena Spini to confirm the 10 September Fase 1 development deadline still stands.** Her `Pienissimo_Project Plan.pptx` of 10 July sets it; every conversation anchors on 6 October instead.                                                 | If it stands, the 19–20 August meetings must be scoped as decisions, not exploration. If it has slipped, that is the single most useful fact anyone can add. See [OI-04](../notes/items/OI-04%20Scope%20against%20the%20go-live%20date.md). | 🔴                                               |
| A2  | **Ask Elena whether `CHIUSO/ACQUISITO` is alive or dead.** The 06/08 session deleted it; the diagram she edited that afternoon still uses it. Aurel's 24/08 decision settles tranche creation and payment roll-up, but not the final state label. | Blocks configuring the **final Order and Tranche state values**, not the tranche creation mechanics. See [OI-69](../notes/items/OI-69%20Order%20state%20model.md) and [OI-50](../notes/items/OI-50%20Tranche%20object.md).                  | 🔴                                               |
| A3  | **Email Andrea Di Cicco and Mirko Merendi about the missing order-line number** in the `Get Fatture` mapping.                                                                                                                                     | Small workbook change if raised before the 27/08 call; a redesign if found after. The whole ticket-release rule matches on it — [OI-75](../notes/items/OI-75%20Ticket%20availability%20rule.md).                                            | 🔴                                               |
| A4  | **Inventory and retrieve the six Biglietto Apex classes before planning the move to standard Asset.**                                                                                                                                             | Asset is now the target, but the only copy of six classes remains in UAT. Preserve and map the behaviour before deciding what is migrated, rewritten or retired. This is source control/migration work, **not** test work.                  | 🔴                                               |
| A5  | **Run an org status check against UAT**, or hand over the alias so it can be run here.                                                                                                                                                            | The 2026-08-03 snapshot is stale in both directions and underpins most "what is built" claims. Procedure: `.agents/skills/org-status-check/SKILL.md`.                                                                                       | 🔴                                               |
| A6  | ✉️ Replied on the _"Lista Eventi, Codici prodotto, esempio Bundle"_ thread to establish what Fabrizio sent on 07/08.                                                                                                                              | Decides whether [OI-46](../notes/items/OI-46%20Bundle%20classification%20picklists.md) and [OI-48](../notes/items/OI-48%20Bundle-only%20article%20codes.md) are closed or still blocking the bundle demo.                                   | ⏸ sent 14/08, awaiting Elena — she returns 17/08 |

## Repo work — queued, in priority order

| #   | Action                                                                                                                                          | Why it matters                                                                                                                                                                                                                                                                                                                                                               | Status   |
| --- | ----------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| R1  | Regenerate the recap and trackers from the notes.                                                                                               | Done as **§12 of `DEVELOPMENT-RECAP.md` + `.it.md`**, following the document's own append-a-dated-section pattern rather than rewriting 73 KB. Precedence headers updated so §12 wins. Trackers already carried the 14/08 blocks.                                                                                                                                            | ✅ 14/08 |
| R2  | Re-merge the diagrams into the register; fix the "31 July" claim.                                                                               | Done. ⚠ **My original rationale for this was wrong** — see the correction below. The register's state machines were already correct; only the provenance dates were stale. Two real gaps found: `order.states` (now `status: conflict`) and a missing `opportunity_types` value (added). Dates corrected in the register, `README.md`, `REQUIREMENTS.md`, `REQUISITI.it.md`. | ✅ 14/08 |
| R2b | **Close the `order.states` conflict with Elena Spini.** Is `Incassato` the same milestone as `CHIUSO/ACQUISITO`, renamed — or different?        | 🔴 **The one real state-machine gap.** Aurel's 24/08 decision settles Quote-side tranche creation and payment aggregation. The final Order and Tranche state values still depend on this naming answer — same question as A2.                                                                                                                                                | 🔴       |
| R3  | Drill the four untracked ROMI-internal meetings: 13/07 and 03/08 Follow-up Interno, 16/07 Interna Review Flussi, 05/08 BBP Aurel/Elena.         | Gemini notes exist for all four; none has ever been processed.                                                                                                                                                                                                                                                                                                               | 🔴       |
| R4  | Ingest the **NotebookLM notebook "PIENISSIMO"** (shared 25/06) and confirm whether `PIENISSIMO - Flusso Lead-Opportunita.drawio` is superseded. | Both referenced nowhere in the repo. The notebook is an entire knowledge surface nobody has opened.                                                                                                                                                                                                                                                                          | 🔴       |

## Standing automation

**Nightly requirements-check** — cloud routine `trig_01VCdUXmqy8PngWPJHA2dSYC`,
created 2026-08-14.
<https://claude.ai/code/routines/trig_01VCdUXmqy8PngWPJHA2dSYC>

|            |                                                                                                                                                                                                        |
| ---------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Schedule   | `30 21 * * 1-5` UTC = **Mon–Fri 23:30 Europe/Budapest**                                                                                                                                                |
| Reports to | Slack `C0BQD34LLF4` — the ROMI Salesforce dev group: Aurel Mrruku, Anita Aga, Sara Aga, **Rexhina Hysi**                                                                                               |
| Repo       | `Calm-Coders/pienissimo`, branch **DevMain**                                                                                                                                                           |
| Writes     | **Commits directly to DevMain**, but only if `npm run vault:check` passes. On failure it commits nothing and leads the report with the failure. No-change runs commit nothing and write no trace note. |
| Connectors | Slack · Gmail · Google Drive · Fathom                                                                                                                                                                  |
| Model      | **`claude-opus-5`** — set deliberately on 2026-08-14, matching the sister project. Do not let a later edit silently drop it back to the Sonnet default.                                                |

⚠ **DST — needs a one-line fix in late October.** The cron is fixed UTC. Europe/
Budapest leaves CEST on **25 October 2026**, after which `30 21` fires at
**22:30 local, not 23:30**. That lands inside the go-live window. Change the cron
to `30 22 * * 1-5` on or after 25 October.

📋 **All four developers are in it.** Aurel renamed the conversation to
"pienissimo devs" and added Rexhina Hysi by hand on 2026-08-14; **the channel id
did not change**, so the routine needed no reconfiguration. A sample report was
posted there the same day to show the format.

Note for future edits: apps **cannot create channels** in this workspace
(`restricted_action`, private and public alike), and Slack conversations of this
kind cannot be renamed through the API. Any change of destination has to be made
by hand in Slack, after which two files need the new id — the routine prompt and
the skill carve-out.

📌 The `requirements-check` skill is otherwise strictly read-only on external
sources. It carries **one explicit carve-out** for this routine's Slack post —
see its Guardrails section. Do not widen it.

## Correction — 2026-08-14

I recommended R2 as "the highest contractual consequence on this board" on the
grounds that `REQUISITI.it.md` carried **state names the design had moved past**.
**That was wrong.** Checking the register and the prose before editing them
showed both already carry `In attesa di accettazione`, `Annullato`, the six asset
states, the tranche states and the retired-label note for `preventivo scaduto`.
The requirement register is in better shape than several notes claimed, and the
affected notes have been corrected.

What was actually stale: the **provenance dates** on both diagrams, and
`order.states`, which predates the 06/08 decision. The first is cosmetic; the
second is real and is now **R2b**. If you deprioritised something else on the
strength of my original framing, that was my error.

## Deferred by standing instruction

- **The Apex test suite.** Requested separately before the production deploy —
  see the standing instruction in [AGENTS.md](../AGENTS.md). The coverage records
  ([OI-64](../notes/items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md),
  [OI-66](../notes/items/OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md),
  [the deploy risk](../notes/risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md))
  stay current as the brief for that task. **A4 is not part of this** — retrieving
  the classes is source control, not testing.
