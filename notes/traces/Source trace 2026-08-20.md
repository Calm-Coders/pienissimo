---
id: trace-2026-08-20
type: reference
status: active
updated: 2026-08-20
watermark_used: 2026-08-19
external_watermark: 2026-08-20
account: a.mrruku@romicompany.com
---

# Source trace 2026-08-20

**Watermark for the next `requirements-check` run: 2026-08-20.**

**Watermark used for this run: 2026-08-19** — the
[trace of that day](Source%20trace%202026-08-19.md), selected by its `updated:`
frontmatter field.

## Sources searched

All read-only. **Nothing was sent, replied to, shared, modified or marked read.**
The single message this job sent is its own report to the Slack group DM
`C0BQD34LLF4`, which the procedure permits.

| Source     | Query / scope                                                                     | Result                                                              |
| ---------- | --------------------------------------------------------------------------------- | -------------------------------------------------------------------- |
| **Gmail**  | `pienissimo after:2026/08/19`                                                     | 2 threads — 1 new (the 26 Aug Mexal invitation), 1 already held      |
| **Gmail**  | all mail `after:2026/08/19`                                                       | 3 threads — 2 project (both invitations), 1 Jira weekly digest       |
| **Gmail**  | `pienissimo.com` / `pienissimo.pro` / `kreosoft.com` / `mexal` / `zucchetti`, after 08-17 | 3 threads, all accounted for                               |
| **Gmail**  | `from:` Fabrizio Paganelli, Sabatino Rinaldi, amministrazione, Marco Montesi, Daniela Morgese, Elena Spini, Merendi, Parmeggiani, Elisa, after 08-17 | 3 threads, all accounted for |
| **Slack**  | `#tproj-pienissimo` (`C0B5T3RB4FM`), 15 messages back                             | Last post still **07 Aug 17:12** — unchanged for a third week        |
| **Slack**  | Canvas *Link utili Pienissimo* (`F0BD2H5A9HT`), re-read in full                   | **Link-for-link identical.** No 19/08 or 20/08 entry; newest SALES entry is still 06.08, newest MKT still 30.07 |
| **Slack**  | Workspace-wide incl. private channels, DMs and group DMs, after 2026-08-18        | 4 hits, **all self-noise** — this job's 19 Aug report and the sibling LIFE365/IUAD jobs' reports |
| **Drive**  | `modifiedTime > 2026-08-19`, both pages                                           | **3 files — 2 are the findings below**                              |
| **Drive**  | `parentId = [Pienissimo] Fase Progettuale`, full listing                          | 10 entries; confirmed the movers and that nothing else changed       |
| **Drive**  | `Flows & Objects.drawio` downloaded and base64-decoded                            | **Read in full**, 128 KB, plain uncompressed mxfile XML              |
| **Drive**  | `Workflow Pienissimo 23-7-26.drawio` downloaded and base64-decoded                | **Read in full**, 49 KB, plain mxfile XML                            |
| **Drive**  | `Flusso Biglietti.drawio` re-downloaded and decoded                               | Used as the one-day-old reference point to date the master's changes |
| **Fathom** | All meetings created after 2026-08-07                                             | **0 recordings.** Nothing since the 06 Aug session                   |

## Found

**Three things. Two diagrams moved on the same afternoon; one new meeting.**

**1. `Flows & Objects.drawio` (`DGM-2`, the master) re-decoded at its
2026-08-20T15:36:24Z version.** This clears the 🔴 action carried from 19 August.
Written up on [the newest design diagram](../The%20newest%20design%20diagram.md).
Four changes against the record:

- The **19 August ticket flow is folded into the master** — `Rinuncia` as a
  seventh asset-state box, the `Aggiornamento Incasso` button, the `XX giorni`
  second funnel send, the landing page, `Casi Limite` in two cases. `Rinuncia`
  is therefore now in the file the register is validated against
  ([OI-74](../items/OI-74%20Asset%20state%20machine.md),
  [OI-91](../items/OI-91%20Aggiornamento%20Incasso%20button.md)).
- **The 06 August order states are drawn — and the old ones were not struck.**
  `Ordinato · Fatturato · Incasato` appear on both pages with _"Status Order ==
  Incassato >> Opty in Chiusa Vinta"_, while `CHIUSO/ACQUISITO` and `CREATO`
  remain on the Ordini page and in the tranche rule. Both vocabularies now
  coexist in the source ([OI-69](../items/OI-69%20Order%20state%20model.md)).
  Only three states; **no `Perso`** ([OI-85](../items/OI-85%20Order%20state%20set%20may%20be%20incomplete.md)).
- **New on 20 August:** a `Scadenziario MEXAL - Check con Andrea` sticky, the
  last cell in the file → [OI-92](../items/OI-92%20Mexal%20Scadenziario%20as%20the%20trigger%20to%20reverse%20an%20asset.md).
- **A ticket tier renamed `Silver` → `Dinamond`**, against the minuted 06 August
  wording ([OI-76](../items/OI-76%20Ticket%20type%20picklist%20on%20the%20product.md)).

**2. `Workflow Pienissimo 23-7-26.drawio` (`DGM-1`, the client's file, owned by
Marco Montesi) modified 2026-08-20T14:28:17Z** — its first change since 4 August,
**68 minutes before** the master. Decoded in full; written up on
[the client Lead-Opty diagram](../The%20client%20Lead-Opty%20diagram%20moved%20on%2020%20August.md).
Its picklists still match the register verbatim. A handful of annotations are in
the file but not in the register — ⚠ **no decode exists between 4 and 20 August,
so they cannot be dated** and are recorded as "present, not registered", never as
"added today".

**3. A new meeting on the calendar.** *[ROMI-PIENISSIMO] - Review Temi
Integrazione Mexal*, **Wednesday 26 Aug 2026 16:00–17:00 CEST**, Google Meet,
organiser **Elena Spini**, invitation sent 20 Aug 14:48 UTC. Guests: Aurel
Mrruku (optional), **Andrea Di Cicco** (ROMI), **amministrazione@pienissimo.com**
and **Fabrizio Paganelli** — so it is **client-facing**, and the first Mexal
session since 14 July. It is the natural forum for OI-92.

## Deliberately not ingested

- The Jira weekly digest of 19 Aug — a ROMI-internal work-item summary naming
  other projects, no Pienissimo content.
- The `[ROMI-LIFE365]` material — a different client, excluded by the previous
  traces and unchanged.

## Still unreachable / still owed

- ⚠ **`Prodotti e Bundle.xlsx`** — unchanged since 18 Aug. No connected tool can
  read a Gmail attachment; the file is in neither Drive nor Slack. **Still needs
  Aurel to download it.** It is the one action that unblocks OI-46 and OI-48, and
  it may also carry the ticket tier list that OI-76 now needs.
- **A minute for 19 or 20 August.** Elena's own 07 Aug status post scheduled a
  **19 Aug** marketing session and a **20 Aug** asset session called by Elisa
  Migliano — _"ci sono delle cose di cui non abbiamo mai parlato"_. Fathom holds
  **zero** recordings after 06 Aug, the canvas is unchanged and the channel has
  not been posted to since 07 Aug. **Whether either meeting ran is unrecorded**;
  the diagram edits are consistent with them having run, but that is an
  inference, not evidence.
- **The Pienissimo 30 July marketing follow-up** notes — never circulated.
- **Listino 1 vs listino 2** — Mirko Merendi deferred to Fabrizio Paganelli;
  unanswered.
- **A prior decode of `DGM-1` between 4 and 20 August** — does not exist, which
  is why that file's divergences cannot be dated. If the client's file is going
  to be edited without notice, it is worth decoding on every run.
- The **Pienissimo UAT org** is not reachable from here; run `org-status-check`.

## Method notes worth keeping

- **Decode both diagrams every run, not just the one that looks interesting.**
  This run only caught the client-side edit because the Drive sweep was by
  `modifiedTime` across all files rather than by project folder — `DGM-1` lives
  outside `[Pienissimo] Fase Progettuale` and is reached through a **shortcut**,
  so a `parentId` listing of the project folder returns the shortcut, not the
  file's real `modifiedTime`. **Resolve shortcuts to their targets.**
- **Keep the previous version to date changes against.** The master could only be
  split into "changed since 06 Aug" and "changed on 20 Aug" because the 19 Aug
  standalone file still exists as a one-day-old reference. Where no such
  reference exists — `DGM-1` — say so instead of guessing.
- **Drive does not full-text index `.drawio` mxfiles.** A `fullText` miss on one
  is meaningless and must never be reported as absence. Download and
  base64-decode; both files here were plain XML, not deflate-compressed.
- Large downloads exceed the tool's inline limit and are written to a file
  instead — decode them from disk with python rather than re-requesting.
- **`OI-90` has a note but no tracker row** — a pre-existing gap from the 14/08
  sweep, still not closed. Row 92 follows row 91. Left alone rather than
  renumbering client-facing rows unasked.
