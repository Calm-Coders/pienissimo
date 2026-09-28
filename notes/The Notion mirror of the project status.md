---
id: ref-notion-mirror
type: reference
status: active
owner: Aurel Mrruku
org: ROMI
raised: 2026-08-24
updated: 2026-09-23
source: refreshed 2026-09-23 from STATUS.md and notes/items/ after the org-status-check against Pienissimo UAT; Status page replaced whole, 37 tracker rows added (OI-135 to OI-171), 3 statuses corrected, 132 rows verified against 132 notes; Flows page unchanged
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
| Page **PIENISSIMO - Flows**               | `3c6a6b77-a25c-81f8-91e7-ffba884cd150` | A Mermaid schema per flow              |
| Its data source                           | `34bc2bc0-2608-4779-829f-5be6f8f7974a` | Needed to create rows or views         |

Openable links, the same ones quoted in [STATUS.md](../STATUS.md) and
[README.md](../README.md):
[status page](https://app.notion.com/p/3c6a6b77a25c818e9b51dc873a2f489c) ·
[open-items tracker](https://app.notion.com/p/04cc8a62d28a40419d7916271f6cae11) ·
[flows](https://app.notion.com/p/3c6a6b77a25c81f891e7ffba884cd150).

**The Notion Status page, Flows page and the tracker are current as of
2026-09-02**, refreshed by the `org-status-check` run against the live
Pienissimo UAT org. The three intervening runs — 28 August, 31 August and the
report-mode pass on the morning of 2 September — **published nothing**, so the
mirror had been seven days stale and wrong in ways that mattered: it still
showed the deleted ticket object as live, carried a coverage figure of 1,069
lines, and held 56 rows against 70 notes.

**What the 2026-09-02 refresh changed.** The Status page carries the new basis
line, the corrected coverage reading, the resolved Order Item grant, the live
order lifecycle and the unbuilt Anticipay fields. The Flows page again keeps
**every diagram unchanged** — no state machine moved — but its build-state
callouts were rewritten: the ticket lifecycle callout now records that the 37
records were deleted, the tranche callout that the Order Item grant cleared, and
the automation callout that the "zero email templates" claim was an instrument
error. **14 rows were added** (`OI-96` to `OI-109`) and **two statuses corrected**
(`OI-66` to Superseded, `OI-95` to Resolved). All 70 rows were then re-queried
and matched against their notes.

⚠ **A stale-content trap worth knowing.** Updating a page with small targeted
replacements leaves everything you did not name untouched — including sentences
that the update contradicts. The first pass on 2026-09-02 left the Status page
asserting both that the Order Item grant was resolved _and_, four sections
later, that it was granted to nobody. **Re-fetch and read the whole page after
writing**, not just the parts you changed. The Status page carries the new basis line, the 1069-line
coverage figure, the corrected Order Item finding, the configured quote
lifecycle and the empty integration scaffolding; the Flows page again keeps
every diagram unchanged — no state machine moved — but its build-state text, the
quote section and the tranche callouts were rewritten. The Status page was
re-fetched and read back after the push; **no markup was mangled this time**.

⚠ **Notion mangled one span on the way in**, exactly as the procedure warns:
`**text `code`**` round-tripped as `****` visible on the page. **Never wrap
inline code in bold** — say "the available state" rather than bolding a span
that ends in a backticked value. It was caught by re-fetching and corrected.

⚠ **On 2026-08-26 all 54 existing rows matched their notes exactly** — status,
owner and severity, no drift. That is the first clean reconcile, and it holds
only because the 25 August run fixed thirteen rows and no item changed status in
between. Do not read it as evidence the database has stopped drifting: it drifts
whenever a session updates a note without running step 6d, so **check every row,
not only the ones the session touched**.

The thirteen fixed on 2026-08-25 were OI-46, OI-47 and OI-53 (showing
`In progress` against notes that read `open`); OI-50, OI-59, OI-68, OI-73,
OI-77, OI-80, OI-84, OI-91 and OI-92 (showing `Open` against notes that read
`in-progress`); and OI-82, still `Open` after being resolved on 24 August.

**Fourteen rows were added on 2026-09-02** — `OI-96` through `OI-109`, the whole
Mexal article-registry, WooCommerce and Anticipay body of work written between
26 August and 1 September and never mirrored. The database now holds **70**
rows, one per note in `notes/items/`.

✅ **Their `Note` URLs resolve.** All fourteen notes were committed and pushed
before 2026-09-02, and `DevMain` was in sync with `origin/DevMain` at the time
of the refresh — checked deliberately, because the 26 August session added two
rows whose links 404'd for exactly this reason. **The three risk notes written on
2026-09-02 are NOT mirrored**: they are risks, not items, and the tracker mirrors
`notes/items/` only.

⚠ **Three files quote these URLs.** If a page is ever replaced rather than
updated in place, all three go stale at once — which is the reason step 6c
forbids creating a replacement page.

Workspace: **Romi Projects's Space**, `132a6b77-a25c-8158-a1e2-000390dba9f5`,
authenticated as `a.mrruku@romicompany.com`.

⚠ **It was renamed.** Through 2026-08-26 this note recorded it as _Aurel
mrruku's Space_; on 2026-09-02 the identity call returned **Romi Projects's
Space** for the **same workspace id**. A workspace id is immutable and a name is
not, so this is a rename, not a different workspace — which is exactly why the
publishing procedure checks the **id**. If a future run finds the id changed,
that is a different workspace: stop and do not write.

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

## ⚠ It shows 56 of roughly 86 items

The database mirrors `notes/items/`, which is the source of record. The
client-facing tracker in
[meetings/open-items.md](../meetings/open-items.md) carries roughly **86**
numbered rows, and only **56** have atomic notes behind them.

So the mirror is the _notes_ view, not the whole tracker, and it will look
complete to anyone who does not know that. Both the status page and the parent
page say so in as many words. **Closing that gap means writing the missing
notes, not adding rows to Notion** — a row with no note breaks the `Ref` join
the reconcile step depends on.

## The Flows page

Added 2026-08-24. Eight Mermaid diagrams, one per flow, drawn from
[notes/flows/](flows/) and the `state_machines` block of
[the register](../requirements/pienissimo-requirements.yaml) — lead, opportunity,
quote, quote-to-order, order, tranche, the ticket/asset lifecycle and the Mexal
call sequence.

**The visual vocabulary is defined by a Legend diagram at the top of the page**,
and it is load-bearing: a dark green `START` stadium for the trigger, a
thick-bordered green box for **the first status the record actually holds**,
grey for terminal, red dashed for disputed. Statuses are numbered only where the
order is fixed.

**Dotted edges carry meaning.** They mark a transition drawn in a source diagram
but agreed in no minute — the `Aggiornamento Incasso` reversal
([OI-91](items/OI-91%20Aggiornamento%20Incasso%20button.md)) and `Rinuncia`
([OI-74](items/OI-74%20Asset%20state%20machine.md)). Keep that convention: a
diagram that renders an unminuted edge as solid quietly promotes a drawing into
a decision.

⚠ **Three flows are deliberately not drawn** — the e-commerce parallel flow,
documents and signatures, and Performance Plus contracts. The development recap
names them as core flows, but none has an atomic note, so drawing them would
mean inventing the detail. The page says so rather than leaving a silent gap.

## 2026-09-14 — refreshed after the org-status-check, and the tracker is whole again

**All three artifacts were refreshed** by the `org-status-check` run against the
live Pienissimo UAT org. Identity was confirmed as `a.mrruku@romicompany.com`
and every page was reached **by id**, never by title.

**The Status page was replaced whole rather than patched.** It had gone twelve
days stale — still dated 2 September, still saying go-live 6 October, still
claiming zero configuration rows — and the 8 September run was report-only, so
it published nothing. A whole-page replacement was used deliberately **because
the stale-content trap above is exactly what small targeted edits cause**; the
call was made without `allow_deleting_content`, so it would have failed rather
than remove a child page, and it did not. Re-fetched afterwards: **no `****`
mangling, no surviving contradictions.**

**The tracker is now complete for the first time.** It held **70** rows against
**95** item notes — everything from `OI-110` to `OI-134` had never been mirrored,
twenty-five rows covering the whole Mexal, locale, marketing and go-live body of
work written between 2 and 8 September. All twenty-five were added; the
database now holds **95 rows, 95 distinct `Ref` values, and no row without a
`Note` URL**. `DevMain` was verified in sync with `origin/DevMain` first, so
every link resolves.

**Three rows had drifted and were corrected** — `OI-76`, `OI-97` and `OI-109`
all read `Open` against notes that read `resolved`; `OI-109` also carried the
wrong owner (Andrea Parmeggiani, where the note says Elisa Migliano). That is
the drift this note predicts: **it happens whenever a session updates a note
without running the publish step**, and three of the twelve days since the last
refresh produced it.

**The Flows page keeps every diagram unchanged — no state machine moved.** Its
build-state text did move, and substantially: flow 8's call sequence is now
**built and org-only**, so a new red callout records the nine classes, the
queued Anticipay → Mexal chain, and the fact that nothing has run and nothing is
scheduled. The tranche callout records the first propagation the project has
ever measured, 3 of 36 order lines. The zero-project-Flows callout was re-verified
and restated: **66 active flows, every one Salesforce stock or a managed
template**.

⚠ **A counting convention changed and the page says so.** The tracker used to
be the smaller view — 56 rows against ~86 tracker rows. It is now the **larger**
one: 95 notes against roughly 86 numbered tracker rows, because the last three
weeks produced notes faster than the client-facing tracker gained rows. **The
two no longer correspond one to one**, and nobody should read a row count as a
tracker count in either direction any more.

## 2026-09-23 — refresh after nine days stale

**The Status page was replaced whole** from the regenerated `STATUS.md`. It had
no child page or database, which was checked before the write. It was re-fetched
and read back, and **no markup was mangled**. The nightly runs of 15–22 September
published nothing, so the page still showed the Mexal chain as org-only, which
had been closed since 15 September.

**Tracker:** **37 rows added** (`OI-135` to `OI-171`) and **3 statuses
corrected**: `OI-49`, `OI-88` and `OI-102` were resolved in their notes and still
`Open` or `In progress` here. The database now holds **132 rows with 132 distinct
refs**, matching `notes/items/` exactly, with 16 resolved and 15 gating in both
places.

⚠ **Two rows have no `Note` URL on purpose.** `OI-170` and `OI-171` were written
in this session, and `DevMain` has not been pushed, so the link would 404. Fill
them in after the push.

**Flows page: not touched.** No flow note and no `state_machines` entry changed
in this run.
