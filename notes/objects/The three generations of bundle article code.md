---
id: obj-three-generations-bundle-codes
type: object
status: resolved
owner: Aurel Mrruku
org: ROMI
raised: 2026-09-02
updated: 2026-09-02
depends_on: [OI-48]
source: Product2 inventory of Pienissimo UAT, 291 records, 2026-09-02
---

# The three generations of bundle article code

**Pienissimo UAT carries three different answers to the same question**, all at
once, and nothing in the record noted the middle one until now.

| Generation          | Shape        | Count | State                              |
| ------------------- | ------------ | ----- | ---------------------------------- |
| The Mexal articles  | `CS-00003`   | ~249  | active, the real registry          |
| **The `-B` shadow** | `CS-00003-B` | 30    | **every one inactive, flag unset** |
| The new bundle-only | `SFCV0001`   | 10    | active, loaded 2026-09-02          |

## The `-B` shadow population

**Somebody already built the `codice B` convention.** Thirty products exist whose
code is a workbook article's code with **`-B` appended** - `CS000114-B`,
`CS-00003-B`, `CO-0110-B` and so on - each carrying the same `Name` as its
parent, each **`IsActive = false`**, each with `Genera_Biglietto__c = false`.

That is the convention Fabrizio Paganelli described on
[26 August](../meetings/2026-08-26%20Review%20Temi%20Integrazione%20Mexal.md):
_"se un codice articolo è visibile, se non è il bundle, avrà il codice A.
L'altro codice che è visibile a tutor avrà il codice B."_ It was implemented in
the org and **never recorded in any note, tracker or recap**.

🔴 **It is now superseded.** The workbook of 1 September answers the same need
with `SF`-prefixed codes, and those are the ones loaded and active. The `-B`
records are dead weight that will confuse the next person to open the registry,
and they double every article in a code-collision search.

## Why this matters beyond tidiness

`Product2.Code__c` is **unique and case-insensitive**, so `CS000114` and
`CS000114-B` coexist happily. But the pair defeats every "does this article
already exist" check that is not an exact string comparison - which is the same
failure mode as
[the normalisation risk](../risks/Risk%20-%20normalising%20an%20article%20code%20merges%20two%20products.md),
reached from the opposite direction: there, two different articles collapse into
one; here, one article appears as two.

## The cleanup, as computed

Aurel Mrruku asked on 2026-09-02 for the problem records to be deleted and the
workbook's articles reloaded with `Genera_Biglietto__c` true. The set was
computed and comes to **79 products**:

- **30** `-B` shadow records
- **38** existing records for the workbook's articles, including
  **duplicate pairs under one code** (`CS-00001`, `CS-00002`, `CS-00006`,
  `CS-00155`, `CS-0061`, `CS-0118` each appear twice) and **conflicting pairs**
  where one code names two different articles (`CS-00003` is both
  _UN ANNO CON PIENISSIMO_ and _CAMERIERI VENDITORI EXECUTIVE_; `CS-00009` is
  both _FOOD MARKETING FESTIVAL - SILVER_ and _PIENISSIMO LIVE_)
- **10** `SF` records loaded earlier the same day, to be reloaded uniformly
- **1** spelling variant, `CS000115`, which is the workbook's `CS-00115`

⚠ **Three of the 79 are pinned by child records** - `CS000114`, `CS000115` and
`CS000116`, the three Academy articles, between them referenced by **4 Assets,
7 OrderItems, 23 QuoteLineItems and 3 PricebookEntries**. Those children have to
go first, and deleting the 7 OrderItems removes part of the order-lifecycle
evidence the record has been citing.

## 2026-09-02 - executed, with two deliberate departures

**Done.** `Product2` went **291 -> 236**, and the end state is exactly the
workbook: **43 products carry `Genera_Biglietto__c`**, **10** are
`Solo_Bundle__c`, **13** carry a `Tipo_Biglietto__c`, and **zero** `-B` records
remain.

**95 records were deleted, not 79**, and **three of the 79 were kept.**

🟢 **The `-B` generation is gone entirely - all 49 of it.** The computed set only
covered the 30 `-B` twins of workbook articles; a further **19** existed for
Tour, Golden Numbers and Intensive articles, identical in kind - inactive, flag
unset, same superseded convention. Deleting half a generation would have left the
next person the same confusion, so the sweep was widened to all of them.

🔴 **The three Academy articles were kept, and should have been all along.**
`CS000114`, `CS000115` and `CS000116` sit on **activated orders**, which
Salesforce will not let you remove line items from - _"unable to modify activated
order"_. Forcing it meant deactivating live orders and rewriting the
order-lifecycle evidence. But checking them first showed **they already carried
`Genera_Biglietto__c` true and were active**: identical to what the reload would
have produced, minus `Evento__c`. So they were **updated in place** (`Evento__c`
= `Academy`) rather than destroyed and re-created, and `CS-00115` was excluded
from the load so the org keeps one Academy Omaggio, not two.

⚠ **Four Assets and one OrderItem were deleted before that was understood**, to
clear the way for a deletion that then did not happen. They are recoverable from
the org's Recycle Bin for ~15 days. That is a real cost of acting before
checking, and it is
[disposable UAT data](../decisions/Decision%20-%20UAT%20data%20is%20disposable%20in%20Fase%201.md)
rather than a loss, but it was avoidable.

🟢 **The load follows the org's own convention** - `Code__c` populated,
`ProductCode` left empty, matching the 249-record majority. This retires the
inconsistency the first pass introduced by setting both. Prices came from the
workbook for the 30 priced articles; the 10 bundle-only codes stay unpriced, as
the client sent them.

⚠ **All 40 loaded records carry `Anno Solare 2026`**, still ROMI's assumption -
the workbook has no year column and `Evento__c` cannot be set without its
controlling field.

## Also established while computing it

- **30 of the workbook's 33 Mexal codes match the org exactly** (an earlier
  figure of 29 in this session was one short). `CS-00115` is present as
  **`CS000115`**; only `CS000057` and `CS-00141` are genuinely absent.
- **`Genera_Biglietto__c` is true on 3 of those 30**, though the workbook says
  `SI` for all 43.
- **19 normalisation collision groups exist across the whole catalogue**, not the
  three the workbook alone revealed.
