---
id: OI-266
type: open-item
status: open
owner: Aurel Mrruku
with: Elena Spini
org: ROMI
raised: 2026-10-19
updated: 2026-10-20
source: notes/meetings/2026-10-19 Test UAT Commerciali.md
---

# OI-266 - The quote product grid does not refresh after adding a line

**After adding a product to a quote, the lines did not appear until the page was
reloaded by hand. Elena Spini called it out as wrong while the client watched
and took the fix herself.**

## What happened

At [the 19/10 session](../meetings/2026-10-19%20Test%20UAT%20Commerciali.md)
`01:10:27`, with a second article just added and nothing on screen, Elena Spini:

> _"Prova a fare un refresh. Quello non mi torna. Ci dovrebbero essere."_

After the manual reload the lines and the `totale complessivo` appeared —
Fabrizio Paganelli: _"ecco qui così compare"_ — and she recorded the defect
rather than letting it pass:

> _"in realtà non va bene neanche che hai dovuto refreshare. Il refresh dovrebbe
> essere automatico, ma questa vabbè, eh, me lo segno io."_

The same stale-read happened once more on the tranche total a minute later
(`01:13:51`), where it resolved itself: Marco Montesi — _"di là dava zero, però
poi mentre andavo a fare … ha fatto da solo"_.

## Why it matters more than it looks

🔑 **It makes two other findings harder to read.** A grid that shows nothing
until reloaded is indistinguishable, from the user's seat, from a grid that is
missing columns — and missing columns is exactly what Fabrizio Paganelli reported
in the same minutes
([OI-207](OI-207%20The%20quote%20and%20order%20layouts%20omit%20the%20commercial%20fields%20the%20client%20requires.md)).
Part of what he saw as absent may have been present but unrendered. **Neither
reading is established**, and that ambiguity is itself a reason to fix the
refresh first.

⚠ **It also lands on the day the quote surfaces were redeployed.** `#102` merged
into `DevMain` at 12:35 CEST and changed `QuoteLineItemTriggerHandler.cls` (+79
lines), `QuoteLineItemTrigger.trigger` and the Quote layout. Whether the UAT org
carried that change at 15:01 CEST is not established here — the org was not
opened — but a trigger-side recalculation that commits after the page renders is
the ordinary cause of exactly this symptom.

## Open

- 🔴 **Unreproduced and unscoped**: whether it affects every line addition or only
  the first.
- ⚠ **Elena Spini owns the report, not the fix.** The fix is Apex or LWC work.

## What closing it looks like

The product-management action refreshes the related lists and the header total
without a manual reload, verified by adding two lines in a row in UAT.

## 🟢 2026-10-20 — explained, and nothing had regressed

**The missing refresh was never built. Aurel Mrruku had wired auto-refresh only to
PDF generation, and Elena Spini's expectation that it also covered adding a product
was her own. The fix was committed the same afternoon, with tests.**

At [the 17:01 internal call](../meetings/2026-10-20%20Follow-up%20Interno.md):

> Elena Spini: _"E non c'era il refresh automatico."_
>
> Aurel Mrruku: _"Sì, ma quando c'era flash [refresh] automatico? Refresh
> automatico l'avevo fatto solo sulla generazione del PDF."_
>
> Elena Spini: _"No, no, l'ho pensato io, l'ho pensato io."_

🟢 **So this is a gap, not a regression** — which matters, because the row was
raised on the day `#102` redeployed `QuoteLineItemTriggerHandler.cls` and a
trigger-side recalculation was the ordinary suspect. **It was not that.** He
confirmed it was straightforward: _"Sì che lo posso mettere."_

🟢 **Built in `bac9f6f`** (Anita Aga, `DevAnita19`, 20/10 15:05:02 CEST) —
_"refresh after products selection and tranche creation"_, two hours *before* the
call, via a new Lightning message channel:

| File | Change |
| ---- | ------ |
| `QuoteProductsChanged.messageChannel-meta.xml` | **new** — the publish/subscribe channel |
| `quoteLineItemsWithBundles.js` | +92 — subscribes and refreshes |
| `quoteManageProducts.js` | +9 — publishes on product change |
| `quoteCreateTranche.js` | +11 — publishes on tranche creation |
| `__tests__/quoteLineItemsWithBundles.test.js` | **+143 — LWC jest coverage** |

🟢 **It is tested.** A 143-line jest suite ships with it — notable in a project
whose Apex coverage is
[a gating risk](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md).
This is LWC jest, not Apex, so it is a `npm run test:unit` matter and touches
nothing in that standing instruction.

🟢 **And it covers the tranche total too**, which this row recorded as resolving
itself a minute later on 19/10 — so both stale reads are addressed by one channel.

## 🔴 What is still open

- 🔴 **Unmerged.** On `DevAnita19`, no PR. `origin/DevMain` stands at `25629af`
  and does not carry it.
- ⚠ **The ambiguity this row created for
  [OI-207](OI-207%20The%20quote%20and%20order%20layouts%20omit%20the%20commercial%20fields%20the%20client%20requires.md)
  is not retrospectively resolved.** The refresh existing from today does not tell
  anyone what Fabrizio Paganelli was looking at on 19/10. The discount control he
  re-checked after a manual reload was genuinely absent, and
  [that is what was designed on 20/10](OI-207%20The%20quote%20and%20order%20layouts%20omit%20the%20commercial%20fields%20the%20client%20requires.md).
- ⚠ **Not verified in any org**, in UAT or production. The claim above is
  repository arithmetic against the commit.
