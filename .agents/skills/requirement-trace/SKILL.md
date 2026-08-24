---
name: requirement-trace
description: Re-derive the note-to-requirement mappings for the ROMI-PIENISSIMO project, one register area at a time, so every requirement can be walked back to the meeting that produced it. Writes `requirement:` on the note and `tracked_by:` on the requirement, and records gaps and contradictions rather than papering over them. Use when asked to trace requirements, map notes to requirements, run a trace batch, or check that the register is auditable before sign-off.
user-invocable: true
---

# Requirement Trace (ROMI-PIENISSIMO edition)

Every requirement in
[the register](../../../requirements/pienissimo-requirements.yaml) should be
walkable back to the conversation that produced it:

    requirement -> note -> the note's `source:` -> the recap -> the transcript

The first three links are this skill's job. Read
[the fabricated-mappings note](../../../notes/The%20requirement%20mappings%20were%20fabricated.md)
before starting — it holds the progress table and the history.

## The rule that matters

**A mapping needs a sentence you can quote.** If you cannot put a line from the
note next to the requirement text and see that they are about the same thing,
it is not a mapping — it is a Tier C, and Tier C is a valid, useful answer.

This is not pedantry. The original 23 mappings were **fabricated by arithmetic**
(`BIG-(OI number minus 69)`) and went unnoticed for months. Text-similarity
scoring was then tried as a fix and was **rejected**: it returned 28 confident
matches, most wrong, because a four-word requirement whose words all appear in a
long note scores as a perfect hit. Automated matching reproduces the exact bug
it is meant to fix. Narrow mechanically if you like; decide by reading.

## 1. Pick one area, never the whole register

Batch by the register's own `area:` field. Comparing a note against ~20
requirements instead of 132 is what makes this accurate.

```bash
rg -o 'id: [A-Z]{3}-[0-9]+' requirements/pienissimo-requirements.yaml | sort -u
```

Areas: `tickets` BIG · `sales` SAL · `integrations` INT · `bundles` BUN ·
`orders` ORD · `data` DAT · `marketing` MKT · `nfr` NFR · `context` CTX.

Do one area per session and commit it. Each batch stands alone, so an
interrupted session loses nothing.

## 2. Load the area

- Every requirement in the area, **in full** — id, status, priority, text, and
  any `conflict:` / `acceptance:` / `source:` it carries.
- The notes whose **subject** is that area. Grep the vault for the domain words,
  then discard the hits that merely mention them in passing; a note that
  references tickets once is not a ticket note.

## 3. Propose, with the evidence beside it

For each note, one of:

- **A match** — name the requirement and quote the line from the note that
  justifies it, next to the requirement text.
- **Ambiguous** — two or three candidates. Do not pick. Take it to step 4.
- **Tier C, no requirement** — and say which kind, because they differ:
  - a **register gap** — the note records an agreed decision nothing covers.
    This is the most valuable output the skill produces. Flag it loudly.
  - **out of area** — belongs to a later batch. Say which.
  - **not a requirement at all** — a meeting, a defect, a superseded proposal.
    A `superseded` note records a _rejected_ alternative: pointing it at a live
    requirement misrepresents it.

## 4. Drill the ambiguous ones with AskUserQuestion

Same shape as `drill-me`: 2–4 concrete options, recommended first, the quoted
evidence in the `preview` field so the choice can be made without opening
anything. Never guess to avoid asking — a guess here is the original bug.

## 5. Write both directions

1. **The note** — `requirement: BIG-06` in the frontmatter, and bump `updated:`.
2. **The register** — `tracked_by: [OI-81]` on the requirement entry. A
   requirement may legitimately list several notes.
3. `npm run vault:check` — it verifies both directions agree, reports ids that
   do not exist, and prints the traced count. It reports these as **warnings**,
   never errors, because the nightly routine commits only on exit 0.

Requirement **text**, priority and status are contract-bound. This skill adds
provenance metadata and nothing else. If the trace reveals that a requirement is
wrong, see step 6 — do not fix it here.

## 6. Contradictions go to `reconciliation:`, not into the text

When a note shows a requirement contradicts a later decision, add an `RC-NN`
entry to the `reconciliation:` block: what the register says, what the minutes
say, `evidence_grade`, an `honest_framing`, a `proposed` fix and
`default_if_undecided`.

**Do not edit the requirement text.** `REQUISITI.it.md` is what Pienissimo
signs; changing it is the user's decision and must land in
`REQUIREMENTS.md` + `REQUISITI.it.md` in the same session.

## 7. Close out

Update the progress table in
[the fabricated-mappings note](../../../notes/The%20requirement%20mappings%20were%20fabricated.md)
with the batch result and its Tier C list, append to
[JOURNAL.md](../../../JOURNAL.md), and run `vault:check`.

**A trace batch moves the "requirements reachable from a note" count**, which
`STATUS.md` and its mirror both publish. Refresh them — **step 6 of
[org-status-check](../org-status-check/SKILL.md)**, rules unchanged — and update
the `Requirement` column of any tracker row whose note you wired. A missing
Notion connector is not a failure: regenerate the file, report the mirror stale.

## 8. Report

Mappings written, gaps found, contradictions raised, and the count of
requirements in the area that still have no note — that last number is the one
that matters before sign-off.
