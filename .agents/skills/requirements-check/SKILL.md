---
name: requirements-check
description: Sweep email, Slack and Drive for anything new about the ROMI-PIENISSIMO project since the last check - messages, meetings, recordings, transcripts, attachments, specs, decisions, or people - then drill any new meeting through the project's meeting workflow and fold every finding back into the project records. Use when asked for a requirements check, whether anything new has come in, to check email/Slack/Drive for updates, to catch up after time away, or before a status meeting.
user-invocable: true
---

# Requirements Check (ROMI-PIENISSIMO edition)

Requirements arrive by email, in chat, and as files people share — and then die
there. This procedure sweeps those sources, ingests what is new, and updates the
project records.

It is the inbound counterpart to `org-status-check`: that one asks *does the org
match the requirements*, this one asks *have the requirements changed and nobody
told the repository*.

## 1. Establish the watermark

Find the last sweep so this run is incremental:

- the newest note in `notes/traces/` — **select it by the `updated:` frontmatter
  field, not by sorting filenames**, or a same-day second run will sort before
  the first;
- the newest [JOURNAL.md](../../../JOURNAL.md) entry.

State the watermark explicitly. Prior sweeps: **2026-08-03** (Slack, Gmail,
Drive, Fathom) and **2026-08-07** (Slack canvas, which surfaced the 06/08
closing session).

Also list what is already held, so you can tell new material from known.

## 2. Sweep email

Search the ROMI mailbox. Search several ways, because each misses different
things:

- the project subject tag `[ROMI-PIENISSIMO]`
- the counterpart domains — `@pienissimo.pro` and the Pienissimo Software
  entity — in `from:`, `to:` and `cc:`
- each known participant by address: Sabatino Rinaldi, Elisa Migliano, Marco
  Montesi, Fabrizio Paganelli, Andrea Parmeggiani, Daniela Morgese, and
  Mirko Merendi at Kreosoft
- project-name variants

Include sent mail and threads where you are only cc'd. Read full bodies — a
specification in a quoted reply is easy to miss from a snippet. Known
mail-borne artifacts to watch for: the **Mexal WEBAPI credentials**, the
**event list**, the **bundle-only article codes** and the **catalogue prices**,
all of which have been promised by mail and are still owed.

## 3. Sweep chat

Cover **`#tproj-pienissimo`** and **direct messages** — a channel-only read is
not a complete sweep; decisions land in DMs.

Then the parts of chat that are not messages:

- **The canvas and pinned indexes.** Re-read them; entries get added, and links
  that were missing before may now exist. The 06/08 session was found this way.
- **File attachments on the messages that posted those links** — a file can be
  reachable through chat when the Drive link is not.
- Threads on older messages; replies arrive long after the parent.

## 4. Sweep Drive and Fathom

Files shared with you, recently modified files matching the project, and every
document referenced from chat or email. In particular the
`[Pienissimo] Fase Progettuale` folder, the two `.drawio` design diagrams, and
`Campi Oggetti, Flussi e Utenti Salesforce - Pienissimo.xlsx`.

**Verify each link resolves.** A 404 is a sharing request to raise, not a source
you have. Check modified dates — a document can be present, linked, and three
weeks stale, and a stale link people are actively following is itself a finding.

Where two documents claim the same role, say which is current.

## 5. Triage what you found

| Found                                    | Do                                                          |
| ---------------------------------------- | ----------------------------------------------------------- |
| Meeting recording, transcript or notes   | Run **`drill-meeting`** on it                                |
| A specification, payload or API contract | Create or update the note; record the contract               |
| A decision or reversal in a message      | Update the affected note, cite the message and its date      |
| A commitment or deadline                 | Create or update the `OI-NN` note, with owner and date       |
| A person not in the records              | Add a person note; mark inferred details `uncertain:`        |
| Credentials in a message body            | Record that it happened and where. **Never copy the values** |
| Catalogue prices                         | Note that they arrived. **Never copy prices into notes**     |
| A file for a different client            | Ignore it. Do not count it as a missing source               |

Do not re-ingest what is already held. If a new source contradicts an existing
record, later evidence wins — record the reversal and cite both dates.

## 6. Drill the meetings properly

Follow `drill-meeting` rather than summarising in place. Transcripts here run to
~100 KB each; drill them one at a time and say what each cost and what it
changed.

## 7. Write the findings back

1. Create or update the affected notes; bump `updated:`.
2. Update [MAP.md](../../../MAP.md) and [INDEX.md](../../../INDEX.md) if the
   live position moved.
3. Regenerate the affected rows of `meetings/open-items.md` **and** `.it.md`,
   and `DEVELOPMENT-RECAP.md` **and** `.it.md`.
4. If a requirement changed, update the YAML register **and both** prose
   documents — the Italian is what the client signs.
5. Write a **trace note** at `notes/traces/Source trace YYYY-MM-DD.md`
   recording: the watermark used, every source and query searched, the account
   each ran against, what was found, and what remains unreachable. **This is the
   watermark for the next run** — without it the next sweep starts blind.
6. Append a [JOURNAL.md](../../../JOURNAL.md) entry; run `npm run vault:check`.

## 8. Report

- **New since `<watermark>`** — each item, its source, its date.
- **What it changes** — the notes and requirements affected.
- **Still unreachable** — named precisely enough to ask someone for them. The
  standing list includes the 30/07 marketing follow-up notes.
- **Sources searched** — including the ones that returned nothing.

## Guardrails

- **Read-only on every external source.** Never send an email or a message,
  never modify or share a Drive file, never mark anything read. If something
  needs to be sent, say so and stop.

  **One carve-out, and only one:** the **scheduled nightly run** posts its own
  report to the Slack conversation `C0BQD34LLF4` — the ROMI Salesforce dev group
  (Aurel Mrruku, Anita Aga, Sara Aga, Rexhina Hysi). That is the single message
  this procedure may send, it goes only to that conversation, and it contains
  only the run's own findings. It is never a reply to someone, never a post in a
  channel, and never a message to the client. Everything else stays read-only.
- Never copy credentials, tokens, catalogue prices or personal data into the
  records — see [docs/publishing.md](../../../docs/publishing.md).
- Never fabricate a participant, a date, a decision, or an owner.
- Never load a raw transcript to browse it — drill it, or `rg` it for a quote.
- Report absence of evidence as absence, not as proof that nothing exists.
