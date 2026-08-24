---
id: ref-notion-mirror
type: reference
status: active
owner: Aurel Mrruku
org: ROMI
raised: 2026-08-24
updated: 2026-08-24
source: published 2026-08-24 from STATUS.md and notes/items/
---

# The Notion mirror of the project status

[STATUS.md](../STATUS.md) is the source. Notion is a **mirror** — it exists so
colleagues who do not read the repository can see where the project stands,
behind a login the owner approves person by person.

**Never treat the Notion copy as the record.** If the two disagree, the notes
win, then `STATUS.md`, then Notion. An edit typed into Notion is lost at the
next regeneration.

## Not the same thing as the public page

This project has **two** rendered status surfaces and they must not be confused:

| Surface                              | Audience          | Rules                                                                                          |
| ------------------------------------ | ----------------- | ---------------------------------------------------------------------------------------------- |
| [site/](../site/) → Cloudflare Pages | Public, no login  | Sanitized — no names, no prices, no endpoints, see [docs/publishing.md](../docs/publishing.md) |
| Notion, below                        | ROMI, invite-only | Internal and candid — names people, states the slippage                                        |

Text never moves from Notion into `site/`. The mirror carries the unminuted
design moves, the coverage floor and the commercial dispute; publishing any of
it would breach the publishing rules in one step.

⚠ **The price rule applies here too.** `Prodotti e Bundle.xlsx` put real
catalogue prices in the repository for the first time. They may not reach the
mirror any more than they may reach `site/` — describe a field, never a value.
See [the workbook](The%20Prodotti%20e%20Bundle%20workbook.md).

## What exists

| Artifact                                  | Id                                     | Holds                                  |
| ----------------------------------------- | -------------------------------------- | -------------------------------------- |
| Parent page **PIENISSIMO**                | `3c6a6b77-a25c-814c-b214-ec60e5f4ab89` | Project frame; auto-lists its children |
| Page **ROMI - PIENISSIMO Project Status** | `3c6a6b77-a25c-818e-9b51-dc873a2f489c` | The mirror of `STATUS.md`              |
| Database **PIENISSIMO - Open Items**      | `04cc8a62-d28a-4041-9d79-16271f6cae11` | One row per `notes/items/` note        |
| Its data source                           | `34bc2bc0-2608-4779-829f-5be6f8f7974a` | Needed to create rows or views         |

Workspace: **Aurel mrruku's Space**, `132a6b77-a25c-8158-a1e2-000390dba9f5`,
authenticated as `a.mrruku@romicompany.com`.

⚠ Not a ROMI company workspace — if one is ever adopted, the pages move by hand;
the API cannot switch or rename workspaces. **The same workspace holds the
LIFE365 mirror**, whose parent page is `3bda6b77-a25c-8190-af69-d61a061892ca`.
The two projects are separate parent pages, not one shared tracker, and their
pages are named alike — which is exactly why the procedure forbids locating
anything by title.

## The tracker's shape

Properties: `Item` (title), `Ref` (the `OI-NN` id), `Status`
(Open / In progress / Resolved / Stale / Superseded), `Severity` (`Gating` only
where a note records one), `Critical path` (checkbox), `Owner`, `Org`, `Raised`,
`Depends on`, `Blocks`, `Requirement`, `Note`.

**Views:** **Board** grouped by status, **Critical path** filtered to the
checkbox, **By owner** grouped by owner — all three sorted by `Ref`, matching
the LIFE365 mirror.

`Ref` is the join key back to [notes/items/](items/). **Match on `Ref`, never on
the title** — titles are reworded, ids never are.

`Note` is a URL straight to the atomic note on GitHub:

```
https://github.com/Calm-Coders/pienissimo/blob/DevMain/notes/items/<filename>
```

The filename is **percent-encoded** — note titles carry spaces by design, and a
raw space breaks the link. ⚠ **The link only resolves once the branch is
pushed.** A note written in a session and not yet pushed gives a 404 in Notion,
which looks like a missing note rather than an unpushed commit. If the working
branch ever stops being `DevMain`, every one of these URLs has to be rewritten.

## ⚠ It shows 54 of roughly 86 items

The database mirrors `notes/items/`, which is the source of record. The
client-facing tracker in
[meetings/open-items.md](../meetings/open-items.md) carries roughly **86**
numbered rows, and only **54** have atomic notes behind them.

So the mirror is the _notes_ view, not the whole tracker, and it will look
complete to anyone who does not know that. Both the status page and the parent
page say so in as many words. **Closing that gap means writing the missing
notes, not adding rows to Notion** — a row with no note breaks the `Ref` join
the reconcile step depends on.
