---
id: person-fabrizio-paganelli
type: person
status: active
org: Pienissimo
updated: 2026-09-21
---

# Fabrizio Paganelli - Pienissimo product and registry

**Responsabile Amministrazione** on the April 2026 org chart — he heads
administration, with [Elisa Migliano](Elisa%20Migliano%20-%20Pienissimo%20administration.md)
in Accounting under him. Owns the article master and the Mexal side of the
registry. He decoded
`anar_PIE_ricla.xlsx` with ROMI on 2026-07-23 — `_ARTIP` A = product,
Z = rata/`BLO-` block, C = bundle/`PACK-` — and confirmed that article codes
are unique and stable, which is what makes the ticket-generating set safe to
maintain by flag.

**The project's longest input queue is his:** the definitive seven-event list
([OI-46](../items/OI-46%20Bundle%20classification%20picklists.md)), ten bundle-only
article codes ([OI-48](../items/OI-48%20Bundle-only%20article%20codes.md)), the
ticket-type and event fields on the product master
([OI-76](../items/OI-76%20Ticket%20type%20picklist%20on%20the%20product.md)), and
[real catalogue prices](../items/OI-87%20Real%20catalogue%20prices%20still%20outstanding.md) —
without which every bundle demo runs on
[invented numbers](../risks/Risk%20-%20placeholder%20prices%20could%20reach%20the%20client.md).

He floated the fourth order state _Perso_
([OI-85](../items/OI-85%20Order%20state%20set%20may%20be%20incomplete.md)) and
declared "Chiuso acquisito" dead — _"non serve più."_

## 🔑 2026-09-21 - he is now the project referent

Per Elena Spini's `#tproj-pienissimo` status post of 21/09 09:52:45 CEST, **the
day-to-day project referent moved from Sabatino Rinaldi to Fabrizio Paganelli (area
Amministrazione)**, because of the client's seasonal event commitments, to guarantee
_"presidio operativo continuativo sul completamento della Fase 1"_.

He took the role on in practice at
[Data Model Parte 6](../meetings/2026-09-18%20Data%20Model%20Parte%206.md)
(`01:55:50`), undertaking to **intercede with Daniela Morgese** and agreeing that
**he and Elisa Migliano would run the environment tests directly** to protect the
go-live date.

## What he did in this window

- **19–21/09** — produced and shared the **Zoho migration extraction**, one Excel
  per table, after rejecting ROMI's shared template on a data-format problem he
  diagnosed correctly
  ([OI-88](../items/OI-88%20Zoho%20import%20template%20owed%20to%20Pienissimo.md)).
  🔴 The `ARTICOLI` classification is empty
  ([OI-154](../items/OI-154%20The%20client%20import%20extraction%20is%20missing%20the%20article%20classification.md)).
- **21/09 14:16Z** — **confirmed the UAT calendar** on behalf of the client, having
  consulted his colleagues, with one exception: 1 October is a San Marino public
  holiday. ⚠ He asked for **3 or 4 October**, which are a Saturday and a Sunday;
  the call that afternoon settled on 2 October **after he had left it**, and Elena
  Spini's reply says only _"inviti mandati"_. **His written request has no written
  answer.**
- **21/09** — ruled at the client call that **invoices are generated manually on
  Mexal in the first instance**: _"L'importante per noi è che arrivino gli ordini su
  Mexal, poi dopo alla fattura ci pensiamo noi."_ 🔴 He was then pulled out of the
  call by Daniela Morgese before hearing what that costs in Salesforce
  ([OI-143](../items/OI-143%20The%20tranche%20invoice%20date%20must%20be%20re-keyed%20by%20hand%20into%20Mexal.md)).
- At Parte 6 he pressed the **commercial visibility of discounts on the invoice**,
  proposed and then conceded the **order-header discount**
  ([OI-145](../items/OI-145%20Order%20header%20discounts%20are%20removed.md)), raised
  the **San Marino revenue split**
  ([OI-155](../items/OI-155%20San%20Marino%20revenue%20split%20and%20warehouse%20causale.md)),
  and introduced **`tipologia evento`**
  ([OI-148](../items/OI-148%20Tipologia%20evento%20is%20mandatory%20at%20event%20creation.md)).
- He owes **Mirko Merendi a mail** to confirm the 22/09 accounting-mapping session;
  the invitation went out with `mirko@kreosoft.com` on it.

⚠ **He shares client data from a personal Google account** outside the Pienissimo
organisation. Recorded as a fact about where the migration files live; no value from
them is in this repository.
