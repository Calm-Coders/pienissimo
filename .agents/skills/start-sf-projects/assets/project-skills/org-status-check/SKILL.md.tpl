---
name: org-status-check
description: Compare what is actually implemented in the Salesforce org against the requirements recorded in the repository, report the gap in both directions - requirements with no implementation, implementation with no requirement, and implementation that contradicts what was agreed - then align the project record and refresh the shared status page and Notion mirror. Use when asked for an org status check, what is actually implemented, whether the org matches the requirements or the spec, what is left to build, to update the project status page, or before a go-live, sign-off, UAT, or client update.
user-invocable: true
---

# Org Status Check - {{PROJECT_NAME}}

One comparison, two sides:

- **Requirements** - what the repository says should exist: notes, trackers,
  recaps, specs.
- **Implementation** - what the Salesforce org actually contains.

Report the gap. **Nothing else is in scope.** Not correspondence, not project
history, not who wrote what - narrow the question to "is the org what the
requirements say it should be", and answer it element by element.

The output is a gap table, not a narrative. A run that restates the
requirements without testing them against the org has failed.

## 1. Extract the requirements as a checklist

Read the smallest set of files that states what should be built: `MAP.md` routed
through `INDEX.md`, then the specific notes in `notes/`.

Convert what you read into **concrete, checkable items** - a requirement you
cannot test against metadata is not usable here. Aim for things like:

- custom objects and the fields on them, with types and relationships
- REST resources, their routes, request shapes and status codes
- automation: flows, triggers, scheduled jobs, and what fires them
- validation rules, permission sets, profiles, sharing
- record types, page layouts, list views

Note the source of each requirement so a mismatch can be traced back. Where a
requirement is vague, record it as **unverifiable** rather than guessing what it
meant. Never load raw meeting transcripts; search them for a quote if needed.

## 2. Inventory what the org implements

Prefer the **live org**, read-only:

```bash
sf org list                                                       # find the alias
sf org display --target-org <alias>
sf org list metadata --metadata-type CustomObject   --target-org <alias>
sf org list metadata --metadata-type ApexClass      --target-org <alias>
sf org list metadata --metadata-type Flow           --target-org <alias>
sf org list metadata --metadata-type PermissionSet  --target-org <alias>
sf sobject describe --sobject <Object> --target-org <alias>
sf data query --use-tooling-api --target-org <alias> \
  --query "SELECT ApexClassOrTrigger.Name, NumLinesCovered, NumLinesUncovered FROM ApexCodeCoverageAggregate"
```

Then the committed metadata, which is the repository's claim about the org:

```bash
find force-app -type f | sed 's|.*/main/default/||' | cut -d/ -f1 | sort | uniq -c | sort -rn
```

**Check the two agree.** `force-app` is not evidence of what is deployed:

```bash
sf project retrieve preview -o <alias>
```

Any divergence is a first-class finding - it means the repository's account of
the org is wrong, and every other comparison rests on it.

⚠ **`retrieve preview` requires source tracking.** A partial or developer sandbox
often has none and fails with `NonSourceTrackedOrgError`. That does not excuse
skipping the comparison: fall back to listing each metadata type and diffing the
names against `force-app/` by hand. Drift in permission sets and tabs hides
exactly there, because objects and Apex usually match while the access layer
quietly does not.

If no org is reachable, say so plainly and mark the report **repository-only**.

Read implementation detail at the boundary - Apex REST classes, triggers, flow
entry criteria - because the contract they implement is what the org actually
does, whatever the requirement says. Where a class matters, compare the
**deployed body** against the repository copy rather than assuming they match:

```bash
sf data query --use-tooling-api --target-org <alias> \
  --query "SELECT Name, Body FROM ApexClass WHERE Name = '<Class>'"
```

## 3. Match, element by element

Walk the checklist. For each requirement, find the implementing metadata or
establish that none exists. Then walk the inventory in the other direction and
find metadata that no requirement asked for.

Classify every row:

| Verdict          | Meaning                                                     |
| ---------------- | ----------------------------------------------------------- |
| **Implemented**  | Present and matches the requirement                         |
| **Partial**      | Present but incomplete - missing fields, cases, or coverage |
| **Divergent**    | Present but behaves differently from what was agreed        |
| **Missing**      | Required, absent from the org                               |
| **Unrequested**  | In the org, required by nothing in the repository           |
| **Unverifiable** | The requirement is too vague to test                        |

**Divergent and Unrequested are the findings that matter most.** Missing work is
usually known; a silent behavioural difference, or metadata nobody asked for, is
what gets discovered in UAT.

Look specifically for divergences that produce no error: fields present in a
payload but absent from the deserialising class, automation that never fires,
required fields that are optional in metadata, permissions never granted, a
picklist value the code writes that the field does not accept, and Apex classes
reporting **zero test coverage** - which blocks any production deploy.

## 4. Report

Lead with the count - implemented, partial, divergent, missing, unrequested -
then the gap table, most severe first. For every non-implemented row give the
requirement, its source, what the org actually has, and the concrete
consequence.

Cite `file:line` for implementation and the note or tracker id for the
requirement. State whether the report is against the live org or
repository-only, and name the org alias if used.

Distinguish what you verified from what you inferred. Absence of evidence is
absence, not proof of the negative.

## 5. Write the findings back

The updated records are the deliverable, not the chat report:

1. Set each requirement note's `status:` to what the comparison proved, and bump
   `updated:`.
2. Add notes for **Unrequested** implementation and for **Divergent** behaviour -
   these have no requirement note by definition.
3. Update the hub and router (`MAP.md`, `INDEX.md`) and regenerate any rendered
   tracker the project maintains, so the client-facing view stops contradicting
   the org.
4. Append a `JOURNAL.md` handoff entry.
5. Run the project's integrity check (`npm run vault:check`).

Follow the project's own write protocol where it has one; it overrides this list.

## 6. Publish the shared status page

The record is now correct. This step makes it visible to the colleagues who do
not read the repository. Ids, shape and sharing rules:
[the Notion mirror note](../../../notes/notion-mirror.md).

**6a. Regenerate [STATUS.md](../../../STATUS.md)** from the notes you just
corrected - it is the source, and Notion only ever mirrors it. Refresh the
regeneration date and the basis line in the header (say plainly whether this run
reached a live org, and name the alias if it did), the "What is built" and "What
is not built" tables, the ranked blocking list, and the risk table. Then
`npx prettier --write STATUS.md`.

**6b. Check the connector before touching anything.** Fetch the identity
(`notion-fetch` with id `self`) and confirm the workspace is the one named in the
mirror note. If that call fails, or the workspace differs, stop here and go to
**6e** - do not go looking for the pages by title.

Take the ids from the mirror note. **Never locate these pages by searching for
their title.** One workspace often holds several projects whose pages are named
alike; a title search will eventually update the wrong project's status page.

**If the mirror note has no ids yet**, this project has never been published.
That is the first-run case: create the three artifacts as described in the mirror
note, then write their ids into it. Do that once, not on every run.

**6c. Update the status page in place.** Same URL means existing invitations keep
working - creating a replacement page silently strands everyone invited to the
old one, and the URL is quoted in `STATUS.md`, `README.md` and the mirror note.

1. `notion-fetch` the status page id to read its current content.
2. `notion-update-page` with `command: "update_content"` and a
   `content_updates` array - one `old_str`/`new_str` pair per section that
   actually changed. Send the smallest edit region that does the job.
3. Reach for `command: "replace_content"` only when the page is being rebuilt
   wholesale. It deletes anything not present in the new content, so read the
   page first and confirm no child page or database has been nested under it.
4. Never `notion-create-pages` a second status page. If the existing one is
   somehow unusable, say so in the report and stop - replacing it is the user's
   call, not yours.

Keep the internal-only callout and the mirror warning at the top. Notion renders
its own table syntax, not Markdown pipe tables - convert each table to
`<table>` / `<tr>` / `<td>`, and never put raw HTML formatting tags in a cell.

**Never wrap inline code in bold.** `**Verified in `the org` today**` round-trips
as `**Verified in ****`the org`**** today**` - stray asterisks, visible on the
page. Choose one or the other. Always re-fetch after a push and read what was
actually stored: Notion rewrites some inline markup on the way in, so the text
you sent is not always the text that renders.

**6d. Reconcile the tracker, matching on `Ref`.**

1. `notion-query-data-sources` in SQL mode against the data source id -
   `SELECT url, "Ref", "Status", "Owner" FROM "collection://<data-source-id>"` -
   to get every existing row keyed by `Ref`, with the row's page url.
2. For each open-item note, find the row whose `Ref` equals the note's
   frontmatter `id:`. **Match on `Ref`, never on the title** - titles get
   reworded, ids never do.
3. Changed row → `notion-update-page` with `command: "update_properties"` on that
   row's url. New item → `notion-create-pages` with a `parent` of
   `{ type: "data_source_id", data_source_id: … }`.
4. **Never delete a row.** An item that closed becomes `Status: Resolved` and
   stays; the tracker is the history as well as the state.

Property formats that are easy to get wrong: checkboxes take the literal strings
`"__YES__"` and `"__NO__"`, not booleans; dates go in as `"date:<Prop>:start"`
with an ISO value, not `"<Prop>"`; select properties take the option name
exactly, and an unknown name creates a new option rather than failing.

Leave the views alone - they are configuration, not content, and survive a data
refresh. If one needs rebuilding, the checkbox filter is
`FILTER "Critical path" = TRUE` (`IS CHECKED` is not valid DSL), and re-read the
view afterwards: `create-view` has been observed to store the inverted
`checkbox_is_not` operator, which silently shows exactly the wrong rows.

Do not add anything to Notion that is not in the notes - a fact that exists only
in the mirror is a fact nobody else can see.

**6e. If the Notion connector is unavailable**, which is the normal case for
Codex, Cursor, and any session whose OAuth grant has expired: **do not treat it
as a failure.** `STATUS.md` is the deliverable and it is already regenerated.
Say plainly in the report that the Notion mirror is stale and name the last date
it was pushed, so the next session with a working connector can catch it up.

A refusal from the _harness_ is different from a missing connector, and is
usually transient: a write can come back "blocked by classifier" and then succeed
unchanged on a retry. Retry once. If a create with a `parent` is refused twice,
create the page at workspace level and `notion-move-pages` it under the parent -
that path has worked when the parented create did not. If writes are refused
consistently, treat it as 6e and report the mirror as stale.

Never turn on **Publish to web** to work around any access problem - it removes
the login gate from a page that carries client-relationship candour.

**6f. `site/` is a different surface and is not part of this step.** The
Cloudflare page is public and sanitized to
[docs/publishing.md](../../../docs/publishing.md); `STATUS.md` and its Notion
mirror are internal and name people. Never copy text between them.

## Guardrails

- **Read-only against the org.** Never run `sf project deploy start`,
  `sf project retrieve start`, or any `sf data` write. `retrieve start`
  overwrites local metadata and destroys the evidence; `deploy start` changes
  the org.
- Running Apex tests is **not** part of this check. Zero coverage means no test
  run has populated the aggregate in that org - report it, do not fix it by
  executing code.
- Never fabricate a requirement, an owner, or a deployment state.
- Do not treat `force-app` as proof of what is deployed unless you verified it.
- Do not soften a divergence to match what the requirement expected.
- **The Notion mirror is a publish target, never a source.** Never read a fact
  out of Notion into the notes, and never let a missing connector stop the run.
- Nothing from `STATUS.md` or the Notion mirror may reach `site/`, which is
  public.
