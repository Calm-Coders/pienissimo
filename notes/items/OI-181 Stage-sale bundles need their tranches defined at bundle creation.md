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

## 🟢🔑 2026-09-25 evening - the first build landed the same day, on `DevMain`

**PR [#62](https://github.com/Calm-Coders/pienissimo/pull/62) merged at 18:07 CEST**
(`a5f9370`), from Anita Aga's `DevAnita25/09`. The gating gap raised at 10:30 had an
implementation on the working branch **eight hours later**. Verified against
`force-app/` at `a5f9370`, not against the org.

`04696bd` (17:03 CEST) — _"Created an object for Bundle Tranch, created a new
component for tranch creation, edited the existing logic for quotes that contain an
bundle."_

**New object `Bundle_Tranch__c`** — a **tranche template on the bundle product**,
which is exactly the shape agreed in the session:

| Field             | Type   | What the metadata says                                                                                                       |
| ----------------- | ------ | ---------------------------------------------------------------------------------------------------------------------------- |
| `Bundle__c`       | Lookup | To `Product2`, with an **active lookup filter on `RecordType.DeveloperName = Bundle`** — only a bundle product can carry one. |
| `Data_Scadenza__c` | Date   | _"Due date copied to the quote tranche created from this bundle template."_                                                   |
| `Sequenza__c`     | Number | _"Order of this tranche in the bundle payment plan."_                                                                         |

**And the two joins that make the inheritance traceable:**

- `Tranche__c.Bundle_Tranch__c` — _"The bundle tranche template that generated this
  quote tranche"_, relationship `Generated_Tranches`. 🟢 **This answers point 3 of
  the agreed shape**: a quote tranche now knows which bundle template it came from,
  so an inherited tranche can be told from a hand-made one.
- `BundleComponent__c.Bundle_Tranch__c` — a bundle line to its tranche.

Also in the PR: **`BundleTranchController.cls`**, LWC **`bundleCreateTranch`** (532
lines of JS, the guided screen), a `Bundle_Tranch__c` layout and record page, a
`Full_Permission` permission set, and a substantial rework of
**`bundleProductAssignment`** (587-line HTML diff, +233 lines JS) — the component
the client saw fail in the morning.

⚠ **Aurel Mrruku confirmed the org side independently** at
[the 17:00 internal session](../meetings/2026-09-25%20Interna%20post%20UAT%20Contratto%20e%20Fase%20Due.md)
(`00:35:00`), reading the picklists live: _"abbiamo il tranch e abbiamo anche i
bundle tranch"_.

### What the build does not yet answer

- 🔴 **No Apex test class, and none is to be written here** — see the standing
  instruction in [AGENTS.md](../../AGENTS.md).
  [OI-64](OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md) and
  [OI-66](OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md) stay gating.
- 🔴 **The WooCommerce half is not visible in this PR.** Point 2 of the agreed shape
  — an order from WooCommerce taking its tranches from the bundle and **ignoring the
  WooCommerce price** — is not evidenced by any file in the diff. The commit message
  covers quotes, not orders. **The 02/10 re-test is the WooCommerce path.**
- 🔴 `Data_Scadenza__c` and `Sequenza__c` are both **`required: false`**, and
  `Bundle__c` is optional too. Nothing in the metadata enforces a coherent payment
  plan — the same absence as
  [the tranche sequence integrity risk](../risks/Risk%20-%20the%20tranche%20sequence%20has%20no%20integrity%20control.md).
- ⚠ **`Sequenza__c` is new vocabulary.** The session agreed article code, quantity,
  list price, discount and due date per line; a sequence number was not discussed.
- ⚠ The estimate was _"at least one week"_. One evening produced the object and the
  quote-side component. **The remaining four working days are the order side, and
  the estimate should not be read as beaten.**

🟢 **The same PR brought the Campaign fields onto `DevMain`** — `Anno_Accademico__c`,
`Data_Inizio_Evento__c`, `Data_Fine_Evento__c`, `Data_Avvio_Bruciatura__c`,
`Tipologia_Evento__c`, `Luogo__c`, `Indirizzo__c`, `Parcheggio__c`,
`Orario_Inizio__c`, `Zoom_Meeting_Id__c`, `Link_Iscrizione_Infopoint__c`,
`Prodotto__c` and the **`Campagna_Figlio` record type** — authored in `c3aa064`
before this sweep's watermark but only reaching the working branch now. They bear on
the **30/09 campaigns-and-tickets session**.
