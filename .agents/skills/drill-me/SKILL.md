---
name: drill-me
description: Interactive decision session for the ROMI-PIENISSIMO project — reads the current state from MAP.md and the notes vault, figures out which open points most need the user's input right now, and drills the USER with concrete multiple-choice questions (AI-recommended option first). Answers are written back into the notes and then into the trackers. Use when the user says /drill-me, "drill me", "what should I decide", or wants to clear open decisions between meetings.
user-invocable: true
---

# Drill Me (ROMI-PIENISSIMO edition)

The reverse of `drill-meeting`: here the project interrogates the USER. Read the
current state, decide what most needs his input, and ask — with real options,
not open-ended questions.

## 1. Load the state cheaply

Do **not** read `meetings/open-items.md` (~50k tokens) or `DEVELOPMENT-RECAP.md`
(~18k) to do this. Read instead:

1. [MAP.md](../../../MAP.md) — the live chain and standing constraints.
2. The newest trace note in `notes/traces/` — select it by the `updated:`
   frontmatter field, **not** by sorting filenames.
3. Candidate items, by grepping frontmatter rather than loading notes:

```bash
rg -l "^status: open"        notes/items/
rg -l "^severity: gating"    notes/
rg "^blocks:|^depends_on:"   notes/items/
rg -l "^owner: Aurel"        notes/
```

Then open only the notes you shortlist. Escalate to the big documents only if
the notes genuinely cannot answer, and say so.

## 2. Select and rank what to ask

Pick items where the USER's answer actually unblocks something:

1. **gating items and anything that blocks the deploy** — the coverage debt,
   the tranche object, the data workbook. On coverage, the only useful question
   is *when to schedule the suite*; never offer to write it;
2. **deadline pressure** — tour 7–19 Sept, Food Marketing 29 Sept, go-live
   6 Oct, Zoho expiry 31 Oct;
3. **decisions ROMI owns that have been deferred** — a validation rule, a
   picklist, an architecture choice nobody is waiting on the client for;
4. **⚠ stale items** a quick answer could close;
5. TBDs from the latest meeting.

Skip items waiting on third parties he cannot answer for — but DO ask whether
there is a status update worth recording, or whether he wants it escalated.

## 3. Drill with AskUserQuestion

Batch up to 4 questions per round:

- Each question names the item id (`OI-NN`) or note it comes from, in one plain
  sentence.
- Give 2–4 **concrete** options — real alternatives with trade-offs in the
  description, never "yes/no". Put the recommended option FIRST with
  "(Recommended)" and say why.
- Multi-select where the choices are not mutually exclusive.
- "Other" captures wording that does not fit — record it verbatim.
- After each round, offer to continue or stop. If the user answers tersely,
  wrap up.

## 4. Write the answers back — notes first

Immediately after each round:

1. **The note** — update `status:`, record the decision in the body with the
   session date, bump `updated:`. If the answer creates new work, create a new
   note with the next free `OI-NN`.
2. **The views** — `meetings/open-items.md` + `.it.md` (resolve or advance the
   row, marked "decided via drill-me session" with today's date) and
   `meetings/DEVELOPMENT-RECAP.md` + `.it.md` (flip 🔴→✅/🟡, fold the decision
   into the right section citing "(drill-me YYYY-MM-DD)").
3. **The register** — if a requirement changed,
   `requirements/pienissimo-requirements.yaml` plus **both**
   `REQUIREMENTS.md` and `REQUISITI.it.md`. The Italian is what gets signed.
4. [MAP.md](../../../MAP.md) if the live position moved, then
   [JOURNAL.md](../../../JOURNAL.md), then `npm run vault:check`.

## 5. Report

Decisions recorded and where, items still open, and the single most urgent thing
to chase with OTHER people.

## Notes

- Never invent options that contradict a decision already settled — those are
  closed; re-open only if the user explicitly says so via "Other".
- Questions must be answerable by THIS user (Aurel, ROMI technical lead). For
  Pienissimo-owned decisions, ask about news or escalation instead.
- Better three sharp questions than ten vague ones.
- Date-stamp every decision with the session date.
