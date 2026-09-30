---
id: OI-182
type: open-item
status: in-progress
owner: Aurel Mrruku
with: Elena Spini
org: both
raised: 2026-09-25
updated: 2026-09-28
depends_on: [OI-140]
source: notes/meetings/2026-09-25 UAT Recall Tutor e Bundle.md
---

# OI-182 - A WooCommerce opportunity record type replaces Recall Tutor

Agreed at [UAT Recall Tutor e Bundle](../meetings/2026-09-25%20UAT%20Recall%20Tutor%20e%20Bundle.md),
`01:54:07`–`01:56:38`.

## Why

The checkout-link flow was designed for one case, the post-event recall. The client
then named a second case with the same mechanics: **fixed packages that tutors sell
without changing them** (a Summer Pack, for example). Marco Montesi: _"ci snellisce
clamorosamente il lavoro piuttosto che andare a fare un'offerta ad hoc."_ Both go
through WooCommerce. Both are bundles the administration builds.

## What was agreed

Elena Spini's proposal, accepted by Sabatino Rinaldi and Marco Montesi:

- The opportunity type **`Recall Tutor` becomes `WooCommerce`**. It uses the same
  checkout-link and checkout-email buttons.
- Before the link is confirmed, the tutor must fill a **mandatory picklist** giving the
  origin: **`Recall Tutor`** (calling back an event's attendees) or **`Pack Tutor`**
  (Fabrizio Paganelli's label for a fixed package).
- Marco Montesi's purpose is statistical: he wants to see that a sale came from the
  **tutor's work** after the tour, not from the customer alone.

Stage sales bought in the room create **no opportunity** at all. They are told
apart by the bundle's product code.

## Open

- ⚠ **Rename or new type?** The Gemini notes say a _new_ record type. The transcript
  has Elena Spini renaming the existing one (_"anziché essere Recall Tutor adesso si
  deve chiamare WooCommerce"_). The API name `Recall_Tutor` is on 3+ UAT
  opportunities already.
- 🔴 This lands on the same object as the **`Standart` misspelling**
  ([OI-140](OI-140%20Three%20Opportunity%20record%20types.md)), unfixed for seven runs.
  Touching the record types once, for both changes, is cheaper than twice.

## ✅ 2026-09-25 — decided via drill-me: new clean types, the old ones retired

Aurel Mrruku: **create new record types `Standard` and `WooCommerce`** with correct API
names, and add the **mandatory origin picklist (Recall Tutor / Pack Tutor)** on
`WooCommerce`. **Remap or delete the UAT opportunities** (UAT data is disposable in Fase
1), then **deactivate `Standart` and `Recall_Tutor`**. Production starts with clean API
names. This also closes the `Standart` misspelling
([OI-140](OI-140%20Three%20Opportunity%20record%20types.md)).

🟢 Register amended, v1.6: `SAL-21` and `state_machines.order.opportunity_types`.

- ⚠ Seven source files reference `Standart` (see OI-140, 22/09). They all move in the same
  change, or `LeadConversionQueueable` and `QuoteManageProductsController` break on the
  retired name.
- ⚠ The Lead → Opportunity type mapping ([OI-150](OI-150%20Opportunity%20type%20comes%20from%20a%20Lead%20picklist.md))
  must point at the new API names.

## 🟢🔑 2026-09-28 - built, and the `Standart` misspelling is finally gone

**`3bd0801`** (Anita Aga, 28/09 12:14 CEST, on `DevMain` at `55101d2`) —
_"Change of API Name of Vendita Standard and Recall Tutor to the correct names and
added origin field for WooCommerce record type"_. Verified against the metadata,
not the commit message:

**Opportunity record types:**

| Before                    | After                                 |
| ------------------------- | ------------------------------------- |
| `Standart` **(deleted)**  | `Vendita_Standard` **(new, 107 lines)** |
| `Recall_Tutor` **(deleted)** | `WooCommerce` **(new, 106 lines)**   |
| —                         | `Plus_Attivazione_Rinnovo` **(new)**  |

🟢 **New field `Opportunity.Origine_WooCommerce__c`** — the mandatory
Recall Tutor / Pack Tutor origin this note called for.

🟢🔑 **`Standart` → `Standard` is done.** It had been flagged on **seven
consecutive runs** as data permanence, not cosmetics. The rename reached the code
paths with it: `LeadConversionQueueable.cls`, `QuoteManageProductsController.cls`,
the `quoteManageProducts` LWC, `Lead.Tipo_Opportunita__c`,
`Opportunity.Tipo_Opportunita__c`, the Opportunity layout, the Quote and
Opportunity record pages, and the `Diretta` / `Standard` Lead record types.

⚠ **Two references survive, both in test code:** `TestDataFactory.cls:257` still
calls `opportunity(accountId, 'Standart')` and line 260 lists the old names in a
comment. **That will fail at runtime against the new record types.** Recorded as an
observation against the standing instruction — **no test class was written,
proposed or scaffolded here**, and this is for whoever takes the test-suite task.

## 🔴 Still open

- 🔴 **The UAT record remapping recorded above has not been shown to happen.** The
  old record types are deleted from `force-app`; **UAT opportunities created under
  `Standart` and `Recall_Tutor` still point at them**, and nothing in this window
  remaps them. Deleting a record type in source does not migrate records.
- 🔴 **Not verified in any org.** This is repository arithmetic against `DevMain`
  `55101d2`. The 02/10 WooCommerce session is the first exercise.
- ⚠ `Plus_Attivazione_Rinnovo` arriving here matters to
  [OI-141](OI-141%20Contract%20object%20for%20Performance%20Plus%20orders.md),
  which reads the Contract `stato` off the opportunity record type.
