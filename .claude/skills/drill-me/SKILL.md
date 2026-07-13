---
name: drill-me
description: Interactive decision session for the ROMI-PIENISSIMO project — reads ALL project md files (open-items trackers, DEVELOPMENT-RECAP, meeting recaps), figures out which open points most need the user's input right now, and drills the USER with concrete multiple-choice questions (AI-recommended option first). Answers are written back into the trackers and DEVELOPMENT-RECAP. Use when the user says /drill-me, "drill me", "what should I decide", or wants to clear open decisions between meetings.
---

# Drill Me (ROMI-PIENISSIMO edition)

The reverse of drill-meeting: here the project files interrogate the USER. Read the current state, decide what most needs his input, and ask — with real options, not open-ended questions.

## Pipeline

1. **Load the state.** Read, in this order:
   - `meetings/DEVELOPMENT-RECAP.md` — especially §9 (blocking decisions) and every 🔴/🟡 status;
   - `meetings/open-items.md` — open rows, owners, ⚠ stale flags, last-touched dates;
   - the most recent 1–2 recaps in `meetings/results/` — TBDs and unanswered Open Questions.
   (English versions suffice for analysis; updates in step 4 go to BOTH languages.)

2. **Select and rank what to ask.** Pick the items where the USER's answer actually unblocks something, ranked by:
   1. blocks the blueprint/build (§9 items) — highest;
   2. deadline pressure (Sept 29 Food Marketing / Oct 31 Zoho expiry);
   3. ⚠ stale items owned by Pienissimo/the user that a quick answer could close;
   4. TBDs from the latest meeting.
   Skip items waiting on third parties the user can't answer for (e.g. DocuSign sales rep reply) — but DO ask if there's a status update worth recording.

3. **Drill with AskUserQuestion.** Batch up to 4 questions per round:
   - Each question names the tracker item (#N) or recap section it comes from, in one plain sentence.
   - Give 2–4 CONCRETE options — real alternatives with trade-offs in the description, not "yes/no". Put the AI-recommended option FIRST with "(Recommended)" and say why in its description.
   - The built-in "Other" covers the case where no option fits — when the user picks it, capture their wording verbatim as the decision/requirement.
   - Multi-select where choices aren't mutually exclusive.
   - After each round, offer to continue with the next batch or stop ("Keep drilling?" as the last question of a round, or just read the room — if the user answers tersely, wrap up).

4. **Write the answers back** immediately after each round:
   - `meetings/open-items.md` + `.it.md`: resolve rows the answer closes (Resolved table, today's date, resolution = the user's decision, marked "decided via drill-me session"); update status/notes on rows the answer advances.
   - `meetings/DEVELOPMENT-RECAP.md` + `.it.md`: flip 🔴→✅/🟡 where decided, fold the decision into the right section citing "(drill-me YYYY-MM-DD)", remove cleared §9 entries.
   - If an answer creates NEW work or a new open point, add a tracker row.

5. **Report.** Summarize: decisions recorded (and where), items still open, and the single most urgent thing the user should chase with OTHER people (e.g. "Daniela still owes the flow approval").

## Notes
- Never invent options that contradict decisions already marked ✅ in DEVELOPMENT-RECAP §8 — those are settled; re-open only if the user explicitly says so via "Other".
- Questions must be answerable by THIS user (Aurel, ROMI-side dev): for Pienissimo-owned decisions he can't make, ask instead whether he has news / wants it escalated, and record that.
- Keep each round tight: 4 questions max, most valuable first — better three sharp questions than ten vague ones.
- Date-stamp every decision written to the files with the session date.
