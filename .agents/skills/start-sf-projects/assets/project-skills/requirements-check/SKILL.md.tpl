---
name: requirements-check
description: Sweep email, Slack and Drive for anything new about the project since the last check - messages, meetings, recordings, transcripts, attachments, specs, decisions, or people - then drill any new meeting through the project's meeting workflow and fold every finding back into the project records. Use when asked for a requirements check, whether anything new has come in, to check email/Slack/Drive for updates, to catch up after time away, or before a status meeting.
user-invocable: true
---

# Requirements Check - {{PROJECT_NAME}}

Requirements arrive by email, in chat, and as files people share - and then die
there. This procedure sweeps those sources for anything new about the project,
ingests it properly, and updates the project records.

It is the inbound counterpart to `org-status-check`: that one asks _does the org
match the requirements_, this one asks _have the requirements changed and nobody
told the repository_.

List the sources searched in the report, including any that returned nothing.

## 1. Establish the watermark

Find the date of the last sweep, so this run is incremental:

- the most recent trace note in `notes/traces/`
- the newest `JOURNAL.md` entry
- the project's research-status or provenance document

State the watermark explicitly in the report. If none exists, say so and sweep
from the project's start date instead.

Also list what has already been ingested - meeting recaps, tracked items, known
participants - so you can tell genuinely new material from what you already
hold.

## 2. Sweep email

Search the **project mailbox named in `README.md`**. If the README does not name
one, ask which account to search rather than guessing.

Search several ways, because each misses different things:

- the project's subject tag
- each counterpart's email domain, in `from:`, `to:` and `cc:`
- each known participant by address
- project-name variants

Include sent mail and threads where you are only cc'd. Read the full body of
anything that looks substantive - a specification in a quoted reply is easy to
miss from a snippet.

## 3. Sweep chat

Cover the project channel **and direct messages** - a channel-only read is not a
complete sweep, and decisions frequently land in DMs between the people running
the project.

Then the parts of chat that are not messages:

- **Canvases, tabs and pinned indexes.** Re-read them; entries get added, and
  links that were missing before may now exist.
- **File attachments on the messages that posted those links.** A file can be
  reachable through chat when the underlying Drive link is not.
- Threads on older messages - replies arrive long after the parent.

## 4. Sweep Drive

Look for files shared with you, recently modified files matching the project,
and every document referenced from chat or email.

**Verify each link actually resolves.** A link that 404s is a sharing request to
raise, not a source you have. Check the modified date too: a document can be
present, linked, and three weeks stale - and a stale link that people are
actively following is itself a finding.

Where two documents claim the same role, establish which one is current and say
so plainly.

## 5. Triage what you found

Decide what each item is before acting on it:

| Found                                    | Do                                                           |
| ---------------------------------------- | ------------------------------------------------------------ |
| Meeting recording, transcript or notes   | Run the project's **`drill-meeting`** workflow on it         |
| A specification, payload or API contract | Create or update the requirement note; record the contract   |
| A decision or reversal in a message      | Update the affected note, cite the message and its date      |
| A commitment or deadline                 | Create or update the tracked item, with owner and date       |
| A person not in the project records      | Add a participant note; mark inferred details `uncertain:`   |
| Credentials in a message body            | Record that it happened and where. **Never copy the values** |
| A file for a different client            | Ignore it. Do not count it as a missing project source       |

Do not re-ingest something already held. If a new source contradicts an existing
record, later evidence wins - but record the reversal and cite both dates.

## 6. Drill the meetings properly

For each new meeting, follow the project's own `drill-meeting` procedure rather
than summarising in place. It preserves the source, extracts facts into notes,
and regenerates the rendered views - skipping it produces a summary nobody can
trace later.

Large transcripts are expensive. Drill them deliberately, one at a time, and say
in the report what each one cost and what it changed.

## 7. Write the findings back

1. Create or update the affected notes. Bump `updated:`.
2. Update the hub and router (`MAP.md`, `INDEX.md`) if the live position moved.
3. Regenerate any rendered tracker the project maintains.
4. Write a **trace note** at `notes/traces/source-trace-YYYY-MM-DD.md` recording:
   the watermark used, every source and query searched, the account or mailbox
   each ran against, what was found, and what remains unreachable. This is the
   watermark for the next run - without it the next sweep starts blind.
5. Append a `JOURNAL.md` handoff entry.
6. Run the project's integrity check (`npm run vault:check`).

If the sweep changed the live position of the project, also refresh
[STATUS.md](../../../STATUS.md) and its Notion mirror using the reconciliation
and publishing references under `org-status-check`; the same rules apply here.

Follow the project's own write protocol where it has one; it overrides this list.

## 8. Report

- **New since `<watermark>`** - each item, its source, its date.
- **What it changes** - the notes and requirements affected.
- **Still unreachable** - links that 404 and files needing to be shared, named
  precisely enough to ask someone for them.
- **Sources searched** - including the ones that returned nothing, with the
  account used.

## Guardrails

- **Read-only on every external source.** Never send an email or a chat message,
  never modify or share a Drive file, never mark anything read. If something
  needs to be sent, say so and stop.
- Never copy credentials, tokens or personal data into the project records.
- Never fabricate a participant, a date, a decision, or an owner.
- Never load a raw transcript to browse it - drill it, or search it for a quote.
- Report absence of evidence as absence, not as proof that nothing exists.
