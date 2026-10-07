---
id: OI-217
type: open-item
status: open
owner: Fabrizio Paganelli
org: Pienissimo
raised: 2026-10-07
updated: 2026-10-07
depends_on: [OI-210, OI-48]
blocks: [go-live]
source: notes/meetings/2026-10-07 UAT Integrazione WooCommerce e Mexal.md
---

# OI-217 - The article code revision needs direction approval

**A bundle article code used by the shop does not exist in Mexal, and the sync
failed on it. Fabrizio Paganelli intends to put a revision and clean-up of
roughly twenty to thirty article codes to direction before the tests, and cannot
clean the Mexal database until direction approves.**

## The failure that surfaced it

At [the WooCommerce session](../meetings/2026-10-07%20UAT%20Integrazione%20WooCommerce%20e%20Mexal.md)
the send to Mexal failed because the bundle article code the shop used was **not
present in Mexal**. Fabrizio Paganelli offered either to create the missing code
or to supply a current one; Sabatino Rinaldi asked which SKU was in use so he
could check. (The code values are not recorded here.)

## The commitment

Fabrizio Paganelli will:

1. **Obtain direction's approval** for the revision of the article codes in use —
   he put the count at about **20–30 codes** — to align Salesforce and Mexal
   before the tests.
2. **Clean the article codes on the Mexal database** once that approval exists.

Both appear as next steps in the session notes with him as owner. ⚠ **No date is
attached to either**, and the production confirmation is due **13 October**
([OI-218](OI-218%20Direction%20has%20not%20seen%20the%20Business%20Blueprint%20before%20the%2013%20October%20confirmation.md)).

## Why it matters beyond one missing code

The article registry is the open seam in the project.
[OI-210](OI-210%20The%20delivered%20article%20registry%20carries%20no%20tranche%20count.md)
records that the registry delivered on 05/10 contradicts the agreed Performance
Plus model — one article per tranche, with the count in free text, against the
one-article-plus-tranche-count the UAT agreed — and
[OI-48](OI-48%20Bundle-only%20article%20codes.md) has no active blocco codes to map
at all. A direction-approved clean-up is the first mechanism that could resolve
either, and it is the client's own initiative rather than a ROMI request.

⚠ **This is not a decision on OI-210.** Nothing in the 07/10 sessions addressed
the tranche-count contradiction; it went unraised for a third consecutive day.

## What closing it looks like

Direction approves the revision, the code list is cleaned on both sides, the
bundle codes the shop sells exist in Mexal, and the result is reconciled against
the registry decode already held in the notes.
