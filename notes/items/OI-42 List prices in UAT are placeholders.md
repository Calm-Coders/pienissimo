---
id: OI-42
type: open-item
status: open
owner: Fabrizio Paganelli
with: Marco Montesi
org: Pienissimo
raised: 2026-07-16
updated: 2026-08-14
blocks: [OI-13, OI-65]
source: meetings/open-items.md row 42
---

# OI-42 - List prices in UAT are placeholders

**Every list price and spread in UAT is ROMI's number, not Pienissimo's.**

Two sources. First, the 16 July migration split each legacy bundle's fixed
price pro-rata by component list price — Bundle 1 became 248,85 / 26,27 /
24,88. Second, the ACADEMY 2026 rebuild needed catalogue prices for the CS
codes, and the Zoho order does not contain any: everything on it is €0
omaggio. So all ten were invented — CAMERIERI 1.200, SOLD OUT 1.500, PIENISSIMO
LIVE 900, O.D.B. LIVE 700, FMF GOLD 1.500, MASTERY 800, MANUALE 1st/2nd/3rd 600
each, HAPPY TEAM 500 — each tagged `[PLACEHOLDER …]` on the product record.

The totals reconcile. The numbers are fiction. That combination is what makes
this dangerous rather than merely incomplete — see
[the risk](../risks/Risk%20-%20placeholder%20prices%20could%20reach%20the%20client.md).

**Real catalogue prices are needed before any of this is shown to Pienissimo.**
Re-raised on 2026-08-06 as
[OI-87](OI-87%20Real%20catalogue%20prices%20still%20outstanding.md).
