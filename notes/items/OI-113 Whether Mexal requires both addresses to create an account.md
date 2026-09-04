---
id: OI-113
type: open-item
status: open
owner: Andrea Di Cicco
with: Fabrizio Paganelli
org: both
raised: 2026-09-03
updated: 2026-09-04
depends_on: [OI-58]
requirement: INT-01
source: notes/meetings/2026-09-03 Data Model Parte 1.md
---

# OI-113 - Whether Mexal requires both addresses to create an account

**The only decision [Data Model Parte 1](../meetings/2026-09-03%20Data%20Model%20Parte%201.md)
formally deferred.** Gemini files it under _Da approfondire_, alone:

> _"Sospensione della verifica sui campi obbligatori di spedizione e fatturazione
> in Mexal in attesa di test tecnici con Andrea."_

Fabrizio Paganelli's position is that Mexal **may require both** the billing and
the shipping address before it will create a customer record. Elena Spini and
Aurel Mrruku declined to design against that until it is tested.

## Why it is not a detail

The Account creation flow agreed in the same session pushes the record from
Salesforce into Mexal **immediately before the order is created**
([OI-116](OI-116%20Nightly%20Mexal%20to%20Salesforce%20anagrafica%20sync.md) is its
return leg). If Mexal rejects a create for a missing shipping address, the
failure lands **in the middle of an order being placed** — the worst possible
moment, and on a path that
[OI-107](OI-107%20The%20Anticipay%20error%20path%20does%20not%20reach%20the%20integration%20log%20intact.md)
already shows does not report integration errors intact.

The consequence if the answer is _yes_: eight address fields become mandatory on
Salesforce (via, città, provincia, CAP for each of billing and shipping) where
the client's own template currently marks only the billing four. That is a
layout, a validation rule and a migration-quality problem on the ~150-field
registry, not a field toggle.

## How to settle it

This is answerable by **one test call against Mexal**, not by a meeting. It sits
with Andrea Di Cicco, whose JSON update and test send from the 2 September
session are still outstanding
([OI-110](OI-110%20Agent%20and%20network%20fields%20are%20missing%20from%20the%20Mexal%20order%20call.md)).
Failing that, **Mirko Merendi at Kreosoft** answers this class of question — he
cleared eight of them in one pass on 11 August.

**No date was set.**


## 2026-09-04 — a workaround was adopted before the question was answered

[Data Model Parte 2](../meetings/2026-09-04%20Data%20Model%20Parte%202.md) settled
the address duplication by **mirroring**: both the billing and the shipping sets
exist in the Salesforce data model, the shipping set is **populated
automatically with the billing values**, it is **hidden on the Salesforce user
screens**, and both are passed to Mexal.

The stated reason is precisely this item — avoiding a Mexal rejection for a
missing address.

🟢 **It defuses the schedule risk.** Eight address fields no longer wait on a
test call, and the client's four-field template is not contradicted on screen.

🔴 **It does not answer the question, and it can be wrong in a new way.** If
Mexal genuinely requires a *distinct* shipping address for some customers, a
mirrored billing address is a **wrong value rather than a missing one** — and a
wrong address that passes validation is worse than a rejection, because nothing
reports it. The failure moves from order creation to delivery.

⚠ **The test call is still worth making**, and it is now cheaper than it was: it
no longer blocks the build, so it can be a verification instead of a gate. It
still sits behind Andrea Di Cicco's JSON update and test send, outstanding since
2 September.
