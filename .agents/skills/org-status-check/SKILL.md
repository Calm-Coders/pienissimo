---
name: org-status-check
description: Compare what is actually implemented in the Pienissimo Salesforce org against the requirements recorded in the repository, and report the gap in both directions - requirements with no implementation, implementation with no requirement, and implementation that contradicts what was agreed. Use when asked for an org status check, what is actually implemented, whether the org matches the requirements or the spec, what is left to build, or before a go-live, sign-off, UAT, or client update.
user-invocable: true
---

# Org Status Check (ROMI-PIENISSIMO edition)

One comparison, **three** sides — this project's distinguishing problem:

- **Requirements** — what the repository says should exist.
- **The repository** — `force-app/`, which is the repository's _claim_ about the
  org.
- **The org** — Pienissimo UAT, which is what actually runs.

All three disagree, in both directions. See
[the build ahead of the record](../../../notes/objects/The%20build%20ahead%20of%20the%20record.md)
and
[the Biglietto stack that is not in source control](../../../notes/risks/Risk%20-%20the%20Biglietto%20Apex%20stack%20is%20not%20in%20source%20control.md).
A run that compares only two of the three has failed.

The output is a gap table, not a narrative.

## 1. Extract the requirements as a checklist

Route through [MAP.md](../../../MAP.md) → [INDEX.md](../../../INDEX.md) → the
specific notes. For requirement ids, priorities, state machines and picklist
values, the authority is
[requirements/pienissimo-requirements.yaml](../../../requirements/pienissimo-requirements.yaml) —
grep it for the id rather than loading the prose documents.

Convert what you read into **concrete, checkable items**:

- custom objects and their fields, with types and relationships
- automation: flows, triggers, scheduled jobs, and what fires them
- validation rules, permission sets, record types, layouts
- state machines — the picklist values must match the agreed set exactly
- integration endpoints, named credentials, callout configuration

Note the source of each so a mismatch can be traced back. Where a requirement is
vague, record it as **unverifiable** rather than guessing. Never load a raw
transcript.

## 2. Inventory all three sides

**The org**, read-only:

```bash
sf org display --target-org <alias>
sf org list metadata --metadata-type CustomObject --target-org <alias>
sf org list metadata --metadata-type ApexClass    --target-org <alias>
sf org list metadata --metadata-type Flow         --target-org <alias>
sf data query --use-tooling-api --target-org <alias> \
  --query "SELECT ApexClassOrTrigger.Name, NumLinesCovered, NumLinesUncovered FROM ApexCodeCoverageAggregate"
```

**The repository:**

```bash
find force-app -type f | sed 's|.*/main/default/||' | cut -d/ -f1 | sort | uniq -c | sort -rn
```

**The divergence between them** — a first-class finding, not a preliminary:

```bash
sf project retrieve preview -o <alias>
```

Also read `git log --format="%h %ad %an %s" --date=short -30`. In this project
the repository moves **faster than the trackers**, and commits by developers who
appear in no meeting are the main way to discover unrecorded work.

If no org is reachable, say so plainly and mark the report **repository-only**.

## 3. Match, element by element

Walk the checklist for missing implementation, then walk the inventory in the
other direction for implementation nobody asked for.

| Verdict          | Meaning                                                  |
| ---------------- | -------------------------------------------------------- |
| **Implemented**  | Present and matches                                      |
| **Partial**      | Present but incomplete — missing fields, cases, coverage |
| **Divergent**    | Present but behaves differently from what was agreed     |
| **Missing**      | Required, absent                                         |
| **Unrequested**  | Present, required by nothing in the repository           |
| **Untracked**    | In `force-app/` but not in the org, or the reverse       |
| **Unverifiable** | The requirement is too vague to test                     |

**Divergent, Unrequested and Untracked matter most.** Missing work is usually
known; a silent behavioural difference is what gets discovered in UAT.

Look specifically for: fields that exist but are populated on zero records (the
project has several), automation that never fires, picklists whose values
predate a redesign, required fields that break existing data, and Apex with no
coverage.

## 4. Report

Lead with the counts, then the gap table, most severe first. For every
non-implemented row give the requirement, its source, what each side actually
has, and the concrete consequence.

Cite `file:line` for implementation and the note or `OI-NN` id for the
requirement. State whether the report is against the live org, and name the
alias. Distinguish what you verified from what you inferred.

## 5. Write the findings back

The updated records are the deliverable, not the chat report:

1. Set each affected note's `status:` to what the comparison proved; bump
   `updated:`.
2. Add notes for **Unrequested** and **Divergent** implementation — by
   definition these have no note yet.
3. Update [MAP.md](../../../MAP.md) and [INDEX.md](../../../INDEX.md), then
   regenerate the affected rows of `meetings/open-items.md` **and** `.it.md`, so
   the client-facing view stops contradicting the org.
4. **Append a build-state section to `meetings/DEVELOPMENT-RECAP.md` and
   `.it.md`, in the same session.** The recap is the consolidated client-facing
   design document and it carries a build-state column, so an org check that
   moves what exists leaves it wrong until this is done — and the tracker rows in
   step 3 are not a substitute for it.
   - **Append the next numbered section; never rewrite an earlier one.** The
     recap is append-with-precedence, so the finding goes in a new `## N.`
     section and the **precedence line in the header is extended to name it**.
     That line goes stale silently — check it names every section that exists,
     not only the one you added.
   - Say plainly that the section records **build state only**: an org check
     moves no requirement and no design decision. Where it contradicts an
     earlier section on what _exists_ it wins; where an earlier section records
     what was _agreed_, that section still governs.
   - **Both languages, same session.** The Italian is the client-facing text.
5. Append a [JOURNAL.md](../../../JOURNAL.md) entry.
6. Run `npm run vault:check`.

## 6. Publish the rendered surfaces

The record is now correct. This step makes it visible to people who do not read
the repository — **two audiences, on two surfaces that never exchange text**:
`STATUS.md` and its Notion mirror for ROMI (6a–6e), and the public `site/` page
(6f). Ids, shape and sharing rules:
[the Notion mirror note](../../../notes/The%20Notion%20mirror%20of%20the%20project%20status.md).

**6a. Regenerate [STATUS.md](../../../STATUS.md)** from the notes you just
corrected — it is the source, and Notion only ever mirrors it. Refresh the
regeneration date and **the basis line** in the header (say plainly whether this
run reached a live org, and name the alias if it did — the 2026-08-03 check is
still the newest one, so do not imply otherwise), the "What is built" and "What
is not built" tables, the register-coverage counts, the ranked blocking list and
the risk table. Then `npx prettier --write STATUS.md`.

⚠ **No catalogue prices, no article-code values, no credentials** on `STATUS.md`
or the mirror. Describe a field, never a value — see
[docs/publishing.md](../../../docs/publishing.md).

**6a-bis. Regenerate the Flows page** if a flow note or the register's
`state_machines` block changed. It holds one Mermaid diagram per flow, and the
page carries a Legend diagram that defines the visual vocabulary. **Keep all
four conventions** — they are what make the diagrams readable at a glance:

| Convention                   | Meaning                                            |
| ---------------------------- | -------------------------------------------------- |
| Dark green `START` stadium   | What triggers the flow — not a status              |
| Green box, thick border      | **The first status the record actually holds**     |
| Grey box                     | Terminal — nothing leaves it                       |
| Red dashed box / dotted edge | Drawn in a source diagram, **agreed in no minute** |

Number the statuses (`1. Ordinato`, `2. Disponibile`) only where the order is
fixed; leave branches unnumbered. **Never render an unminuted transition solid**
— that promotes a drawing into a decision, which is the exact failure the
register keeps recording. Do not draw a flow that has no atomic note; say it is
undrawn instead.

**6b. Check the connector before touching anything.** Fetch the identity
(`notion-fetch` with id `self`) and confirm the workspace is the one named in
the mirror note. If that call fails, or the workspace differs, stop here and go
to **6e** — do not go looking for the pages by title.

Take the four ids from the mirror note. **Never locate these pages by searching
for their title.** This workspace also holds the LIFE365 mirror and the two
projects' pages are named alike; a title search will eventually update the wrong
project's status page.

**6c. Update the status page in place.** Same URL means existing invitations
keep working — creating a replacement page silently strands everyone invited to
the old one, and the URL is quoted in `STATUS.md` and the mirror note.

1. `notion-fetch` the status page id to read its current content.
2. `notion-update-page` with `command: "update_content"` and a
   `content_updates` array — one `old_str`/`new_str` pair per section that
   actually changed. Send the smallest edit region that does the job; a section
   whose facts did not move is left alone.
3. Reach for `replace_content` only when the page is being rebuilt wholesale. It
   deletes anything not present in the new content, so read the page first and
   confirm no child page or database has been nested under it.
4. Never create a second status page. If the existing one is somehow unusable,
   say so in the report and stop — replacing it is the user's call, not yours.

Keep the ROMI-internal callout, the price callout and the mirror warning at the
top. Notion renders its own table syntax, not Markdown pipe tables — convert
each table to `<table>` / `<tr>` / `<td>` and keep the inline formatting
Notion-flavoured (`**bold**`, backticks), never raw HTML tags inside a cell.

**Never wrap inline code in bold.** It round-trips as stray asterisks, visible
on the page. Choose one or the other. Always re-fetch after a push and read what
was actually stored: Notion rewrites some inline markup on the way in.

**6d. Reconcile the tracker, matching on `Ref`.** One row per note in
`notes/items/`. For each note whose `status:`, `owner:`, `severity:` or
dependencies moved, update that row's properties; add a row for a note that has
none; never delete a row whose note still exists.

Set `Note` on any row you add — the GitHub URL of the atomic note on `DevMain`,
percent-encoded. **It 404s until the branch is pushed**, so push before claiming
the mirror is current.

⚠ **Do not add a row for a tracker number that has no note.** The database
mirrors `notes/items/` — 54 of roughly 86 numbered rows — and a row with no note
breaks the `Ref` join this step depends on. If the gap matters, write the note;
that is a `drill-meeting` job, not a Notion one.

**6e. If the Notion connector is unavailable**, which is the normal case for
Codex, Cursor, and any session whose OAuth grant has expired: **do not treat it
as a failure.** `STATUS.md` is the deliverable and it is already regenerated.
Say plainly in the report that the mirror is stale and name the last date it was
pushed, so the next session with a working connector can catch it up.

A refusal from the _harness_ is different from a missing connector and is
usually transient: retry once. If writes are refused consistently, treat it as
6e and report the mirror as stale.

Never turn on **Publish to web** to work around any access problem — it removes
the login gate from a page that carries client-relationship candour.

**6f. Refresh [`site/`](../../../site/) — re-derived from the notes, never
copied from this page.**

`site/` is a **different surface with the same subject**, and it is the one
rendered view no other procedure regenerates, so it rots silently between org
checks. This step owns it. The separation from 6a–6e is absolute: `STATUS.md`
and the Notion mirror are internal and name people; `site/` is public and
sanitized to [docs/publishing.md](../../../docs/publishing.md).

- **Re-derive every row from `notes/` and this run's findings. Never move a
  sentence across from `STATUS.md` or Notion** — if a phrase would sit equally
  well on both, it came from the wrong side and has to be rewritten.
- Refresh the **"Status as of" date** and the remaining-weeks figure. A stale
  date is the failure mode that makes the whole page misleading rather than
  merely incomplete.
- Keep the **anonymised vocabulary the page already uses** — _Legacy CRM_, _ERP
  integration_, _E-commerce integration_ — never the vendor, client, product or
  person names behind them.
- Permitted: delivery phase, milestone dates, item counts, workstream state,
  role names without person names. Everything in `docs/publishing.md`'s
  not-permitted list stays out, and **keep the page's register**: it says
  "below deployment threshold", not the coverage percentage. Status, not
  candour.
- Run the **leak-check grep** from `docs/publishing.md` before finishing. It
  must return nothing.
- `site/` is **deployed by hand** and nothing in this step publishes it. Say in
  the report that the page was refreshed but not deployed, so nobody assumes the
  public URL moved.

## Guardrails

- **Read-only against the org.** Never run `sf project deploy start`,
  `sf project retrieve start`, or any `sf data` write — `retrieve start`
  overwrites local metadata and destroys the evidence.
- Do not treat `force-app/` as proof of what is deployed unless you verified it.
- Never fabricate a requirement, an owner, or a deployment state.
- Do not soften a divergence to match what the requirement expected.
- **The Notion mirror is a publish target, never a source.** Never read a fact
  out of Notion into the notes, and never let a missing connector stop the run.
- Nothing from `STATUS.md` or the Notion mirror may reach `site/`, which is
  public.
- **No catalogue prices or article-code values** on any published surface,
  internal or public.
