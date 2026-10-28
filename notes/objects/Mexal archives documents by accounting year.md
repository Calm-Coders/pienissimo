---
id: mexal-accounting-year
type: object
status: active
owner: Aurel Mrruku
org: ROMI
raised: 2026-10-28
updated: 2026-10-28
depends_on: [OI-244]
blocks: []
source: force-app/main/default/classes/MexalSearchCalloutService.cls
---

# Mexal archives documents by accounting year

**Mexal keeps documents in one archive per accounting year, and a WEBAPI call
reads only the year named in its `Coordinate-Gestionale` header. Reading a prior
year's invoices means setting that year explicitly. The code learned this on
28 October; no meeting, mail or requirement in these records had said it.**

## Where it is written

`force-app/main/default/classes/MexalSearchCalloutService.cls`, added on
`DevMain` between `4c1b36b` and `d9d18e3` (28 October):

```apex
// Mexal keeps documents in one archive per accounting year: a backfill of a
// prior year's invoices sets it, everything else uses the current year.
public static Integer accountingYear;
```

and, in the header the service sends on every call:

```apex
'Azienda=' + MEXAL_COMPANY + ' Anno=' +
  String.valueOf(accountingYear == null ? Date.today().year() : accountingYear)
```

Before this change the header always carried `Date.today().year()`. 🔑 **So every
Mexal read this project had made before 28 October was scoped to the current
year without anyone saying so**, and the default is unchanged — only a caller
that sets `accountingYear` escapes it.

## Why it matters

- 🔑 **The historical load crosses three archives.** The invoices imported on
  28 October are **2024 (6,161), 2025 (2,292) and 2026 (2,353)**
  ([OI-244](../items/OI-244%20Historical%20orders%20will%20be%20migrated%20from%20Mexal%20by%20spreadsheet.md)),
  so the backfill necessarily had to switch year per batch.
- ⚠ **It is a static on a service class**, which means it is process-wide for the
  transaction and has to be set and cleared by whatever drives the import. The
  record holds no description of that driver, and nothing in the repository tests
  the behaviour.
- 🔑 **The same constraint applies at go-live.** The agreed calendar extracts the
  final order file on **13 November 09:00** and goes live on **16 November**
  ([OI-268](../items/OI-268%20The%20client%20proposed%20a%20go-live%20calendar%20of%2016%20November.md)) —
  a load that runs in one year against documents filed in another will come back
  empty rather than wrong, which is the harder failure to notice.

⚠ **Not confirmed with Kreosoft.** This is ROMI's reading of Mexal's behaviour as
encoded in its own client. Mirko Merendi has never been asked about the `Anno`
header in any record held here, and the 26/10 vendor call
([Tema Ordini Mexal](../meetings/2026-10-26%20Tema%20Ordini%20Mexal.md)) did not
mention it.
