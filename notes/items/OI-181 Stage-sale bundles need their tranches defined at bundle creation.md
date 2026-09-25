---
id: OI-181
type: open-item
status: in-progress
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: both
raised: 2026-09-25
updated: 2026-09-25
depends_on: [OI-50]
blocks: [OI-101, go-live]
severity: gating
requirement: [ORD-02]
source: notes/meetings/2026-09-25 UAT Recall Tutor e Bundle.md
---

# OI-181 - Stage-sale bundles need their tranches defined at bundle creation

**Found at [UAT Recall Tutor e Bundle](../meetings/2026-09-25%20UAT%20Recall%20Tutor%20e%20Bundle.md),
25/09, and it reshapes the WooCommerce half of the build.**

## The gap

[OI-50](OI-50%20Tranche%20object.md) creates tranches **on the Quote**, by selecting
quote lines and a due date (decided 24/08, register `ORD-02`). A **stage sale has no
quote.** The customer scans a QR code, pays the **first tranche** on WooCommerce, and
the order reaches Salesforce with nothing to take its tranches from.

What the client expects, in Fabrizio Paganelli's words (`00:59:00`): _"io creo il
bundle, poi creo tutte le righe prodotto… Ad ogni riga prodotto gli associo una data
di scadenza. Poi a Sabatino passo il codice del bundle e"_ the first-tranche amount.
Salesforce must then hold **the whole bundle order**, not the first-tranche amount
WooCommerce charged (`00:39:11`). Under Zoho today, that order becomes one parent
order plus one child order per tranche.

Aurel Mrruku, `00:44:30`: _"questo peso proprio mi mancava… mai considerato."_
Fabrizio Paganelli had understood since July that due dates are set on the bundle.
**Both sides built on different premises for two months.**

## Agreed shape

1. **Tranches can be defined when the bundle is created**, using the same guided
   screen as on the Quote. Per line: article code, quantity, list price, discount and
   **due date** (Fabrizio Paganelli's minimum, `01:16:57`).
2. **An order from WooCommerce takes its tranches from the bundle.** The WooCommerce
   price is ignored, because Salesforce already holds the bundle total and every
   line's price.
3. **A quote that uses the bundle inherits the tranches as defaults.** The tutor can
   re-date them and move lines between tranches, but can never change the
   components. A generic tutor bundle can be created without tranches.
4. Stage-sale orders go to Mexal **with no human check** (`01:02:54`).

**Estimate: at least one week** (Aurel Mrruku, `02:05:08`). Live re-test:
**Fri 2 October**, with a bundle built in the session from Fabrizio Paganelli's codes.

## Open

- 🔴 **One week of work against a re-test in seven days.** It shares the week with the
  28–29/09 deploy question ([OI-177](OI-177%20The%20marketing%20flow%20UAT%20needs%20production.md))
  and the 30/09 ticket session.
- 🔴 **Register `ORD-02` says the tranche is defined on the Quote.** It now has a
  second origin, the bundle. ~~Not amended here~~ → **amended the same session, v1.6**
  (see below).
- ⚠ **The "bundle modificabile" flag is unresolved.** Fabrizio Paganelli proposed it;
  the inherit-then-edit design makes it redundant for quotes; Gemini records it as agreed
  and gives Fabrizio Paganelli an action to define it.
- ⚠ **How the full bundle order relates to the first-tranche payment on WooCommerce**
  (is the first tranche marked paid, and by whom?) was not discussed.

## ✅ 2026-09-25 — decided via drill-me: tranches first, the production deploy after

Aurel Mrruku: **28/09–01/10 go to the bundle-level tranches**, so the 02/10 re-test shows
the new mechanism. **Elena Spini is to be asked to move the partial production deploy to
the week of 5/10**, since marketing is now on 7/10 anyway. Accepted risk: the production
deploy lands close to 7/10.

🟢 **Register amended the same session, v1.6**: `ORD-01`, `ORD-02`, `DM-17` and the
`TRANCHE` glossary now carry the bundle as a second origin
([OI-184](OI-184%20Register%20v1.6%20goes%20to%20the%20client%20as%20one%20change%20set%20at%20UAT%20close.md)).
