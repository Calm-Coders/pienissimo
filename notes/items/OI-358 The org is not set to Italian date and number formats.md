---
id: OI-358
type: open-item
status: open
owner: Aurel Mrruku
with: Elena Spini, Marco Montesi
org: both
raised: 2026-11-12
updated: 2026-11-18
depends_on: []
blocks: []
severity: high
source: notes/meetings/2026-11-12 INTERNA Modifiche Marco.md
---

# OI-358 - The org is not set to Italian date and number formats

**The tutors found at training that dates render in American order, the decimal and
thousands separators are the wrong way round, and the Community prints the euro
symbol with no space. The org locale was never set, in a project whose users work
in Italian throughout. It is the first row of the client-facing recap sheet and is
due at the start of next week.**

## What is wrong

From the [12/11 internal call](../meetings/2026-11-12%20INTERNA%20Modifiche%20Marco.md),
Elena Spini reading her training notes:

> _"tutte le date … anche qua novembre 11 e anche le date, il formato data a livello
> di **tranche** e in formato americano. invece lo vogliono italiano perche se non
> capiscono."_

| Surface | Defect |
| --- | --- |
| Dates, everywhere including the tranche screens and the Community | American order |
| Numbers | decimal and thousands separators inverted — _"cambiare la virgola con il punto, cioe opposite"_ |
| Community, currency | no space between the number and `€` — _"aumentare lo spazio con euro e il numero ovunque"_ |
| Quote expiry | ⚠ a note reading _"data scadenza transformato EU"_ that Elena Spini could not interpret |

## The fix and its one risk

🟢 Aurel Mrruku: _"devo **abilitare il formato italiano nella ORG**. … non e una
cosa molto difficile. In teoria non dobbiamo avere problemi."_

🔴 **The risk is the custom code**: _"I problemi li abbiamo poi se abbiamo fatto
delle cose custom, quindi abbiamo messo … su qualche componente LWC un riferimento
custom della data."_ Elena Spini named the place at once — _"Mi viene in mente la
cosa dei prodotti. **Aggiungi prodotti**"_ — and they agreed the sweep must cover
every surface, not just the one complained about: _"non lo facciamo solo qua, ma lo
facciamo dappertutto."_

The candidates to check are the quote product LWCs rebuilt for
[OI-330](OI-330%20The%20product%20selection%20screen%20is%20unusable%20for%20multiple%20products.md)
(`quoteManageProducts`, the `QuoteManageProductsModal` resource) and the tranche
screens.

## Why nobody caught it

⚠ Asked and unanswered on the call. Aurel Mrruku: _"**Come mai ci e sfuggito sta
cosa?**"_ Elena Spini: _"non so manco, cioe, boh, io manco me ne so accorta …
pero si, considerando che usano un sal\[es\]force in italiano potevamo
ar\[rivarci\]."_ Aurel Mrruku: _"**Hanno anche ragione.**"_

🔑 It was raised by the **users**, at training, five days before they start — not
by any test, review or acceptance step.

## Committed to the client

Row 1 of `Pienissimo_Recap_Modifiche_2026-11-12.xlsx`, sent 12/11 18:43Z:

> _"Formato italiano ovunque: date (anche nelle tranche e nella Community),
> separatore delle migliaia e dei decimali, spazio tra numero e simbolo € nella
> Community"_ — **Da implementare**, _"Abilitiamo il formato italiano a livello di
> org e verifichiamo tutti i componenti con riferimenti custom alla data (es.
> Aggiungi prodotti)"_, **Inizio settimana prossima**.

## What is owed

- The org-level locale change, plus a pass over every custom component that formats
  a date or an amount.
- A decision on whether this lands before or after the 16/11 start: the commitment
  says _"inizio settimana prossima"_, which is **after** the users begin.

## 2026-11-16 - it is on the client-facing quote PDF, and it waits for the 18 November release

🔴 **The American date format reaches the client's own customers.** Fabrizio
Paganelli, looking at a quote PDF generated and signed on the go-live call:

> _"qui non abbiamo cambiato la data"_
>
> _"perche se i ragazzi iniziano a mandare via gli ordini, dopo non abbiamo degli
> interlocutori che sono ad un livello sufficiente da capire che **questo qui e un
> formato americano** … **visto che questi documenti hanno una rilevanza verso i
> nostri clienti, dagli la priorita**, se riesci a sistemarlo anche in giornata."_

Aurel Mrruku: _"ci sto gia lavorando"_ — but not today:

> _"in giornata non riesco perche c'ho gia **il rilascio del 18** … il 18 porto
> anche questo cambiamento su quel rilascio, cosi non faccio due volte il
> rilascio."_

Fabrizio Paganelli accepted: _"facciamolo domani mattina."_ ⚠ **The two statements
do not agree** — "tomorrow morning" is the 17th and the release is the 18th — and
nothing resolves which.

🔑 **The 18 November release** carries the quote creation on WooCommerce orders, and
now this. Aurel Mrruku also expects to finish Elena Spini's whole change list
**by Friday 20 November**: _"penso che entro venerdi riesco a finire tutto quello che
m'ha detto, e c'ho il 18."_

🟢 **Partial movement in source**: commit `13b16da`, **Anita Aga, 2026-11-16 18:01
CET, on `DevAnita16` only** — _"changed the labels of the picklists values in
italian"_, a `LeadSource.standardValueSet` with 59 lines of Italian labels. That
covers the lead source list the client asked to have in Italian, not the org locale.
**Not on `DevMain`, not merged, not deployed.** See
[the lead source values](../The%20Pienissimo%20lead%20source%20values.md).

**Still open:** the org locale itself, the number separators, and whether the fix is
a locale change or per-field formatting. It is row 1 of
[the client recap](../The%20Pienissimo%20recap%20of%20open%20changes.md) and it has
now been seen by the client's customers.

## 🔑 2026-11-17 - the currency half shipped, the date half did not

**Three pull requests merged into `DevMain` today and the Italian-format work is
visibly under way — but it is the money that was fixed, not the dates, and the dates
are what the client asked for by priority.**

### What landed

| Surface | Change | Commit |
| --- | --- | --- |
| **Community / Landing Page site** | `defaultLocale` `en_US` -> `it`, the single active language relabelled `English (US)` -> `Italian`, in `digitalExperiences/site/Landing_Page1/sfdc_cms__languageSettings` | `9a23553` (Rexhina Hysi), PR #130 |
| **`quoteAcceptancePage`** | every amount now rendered through `new Intl.NumberFormat("it-IT", {style:"currency", currency:"EUR", useGrouping:"always", minimumFractionDigits:2, maximumFractionDigits:2})` — line list price, amount, discount, total, and the three header totals | `eb71235` / `0e05682`, PR #129 |
| **`quoteManageProducts`** | the same, replacing `Intl.NumberFormat(undefined, …)` with the explicit `it-IT` locale and forcing two decimals and grouping | `eb71235` / `0e05682`, PR #129 |
| **Lead source values** | `LeadSource.standardValueSet` with Italian labels, merged out of `DevAnita16` | `13b16da`, PR #128 |
| further price fixes | _"italian format fixes for the prices on costum components"_ | `654618c` — 🟡 **`DevAnita17` only, not merged** |

🔑 **`quoteManageProducts` is the component Elena Spini named on the 12/11 call** as
the likely casualty of a locale change — _"Mi viene in mente la cosa dei prodotti.
**Aggiungi prodotti**"_. It was fixed explicitly rather than left to the org locale.

🟢 **The euro-spacing complaint is addressed by construction**: `style: "currency"`
with the `it-IT` locale renders `1.234,56 €`, with the separators the client asked
for and a space before the symbol.

### 🔴 No date-format change exists in source

The `DevMain` delta is **52 files, +4,250 / -198 lines**, and it contains:

- no Visualforce page, PDF template or email template of any kind;
- no `DateTimeFormat`, no `dd/MM`, no `MM/dd`, no date-locale edit anywhere.

⚠ **So the one item the client escalated is the one item not in the release.**
Fabrizio Paganelli, 16/11, on the signed quote PDF: _"qui non abbiamo cambiato la
data"_ … _"visto che questi documenti hanno una rilevanza verso i nostri clienti,
**dagli la priorita**, se riesci a sistemarlo anche in giornata."_ He accepted
_"facciamolo domani mattina"_ — which was **today** — and the developer's own plan
was to carry it on the **18 November** release. The release is tomorrow and nothing
is staged for it.

### 🔴 The org locale itself is still untouched

Every change above is per-component or per-site. The org-level locale — Aurel
Mrruku's own stated fix, _"devo abilitare il formato italiano nella ORG"_ — has no
trace in source, which is expected (it is an org setting, not metadata) and
therefore **unverifiable from the repository**. ⚠ The org was not opened in this
run. Two unattributed Salesforce confirmations arrived today that *could* relate —
an org-wide sharing-defaults change completed at **13:46:32Z** and an
organization-wide email address verification request at **16:41:26Z** — but
**neither names the org** and neither is a locale change. Nothing here connects
them to Pienissimo.

### Active retesting, same day

🟢 The quote-acceptance page was being exercised in the **partial sandbox** this
afternoon: an acceptance-request mail for quote `00000322`, subject
_"Preventivo - test 11/17 2"_, at **15:29:41Z**, pointing at
`…--partial.sandbox.my.site.com/gestione-preventivo`. Its own label says it was the
**second** test of the day. The Landing Page site was published to that sandbox
**seven times between 13:51:16Z and 14:24:26Z**.

⚠ **And once to production, at 14:40:33Z**, by `Tech Romi`. The ordering matters and
is not explained: the production publish is **ten minutes before** Rexhina Hysi's
Italian-locale commit (14:50:33Z) and **eighteen minutes before** PR #130 merged
(14:58:03Z). On a project with an established org-first-then-retrieve habit that is
suggestive, but **nothing in this sweep establishes what the production publish
contained**, and it is recorded here as a timestamp, not as a deployment of this
change.

**Still open:** the quote PDF date format, the org locale, the tranche-screen dates,
and `654618c` sitting unmerged on `DevAnita17`.

## 🟡 2026-11-18 - declared done to the client, with nothing in the delta to show for it

**Row 1 of the client-facing change recap was moved to `Già fatto` at 10:37:52Z, and
the release mail at 14:40:26Z tells Pienissimo `Formato date: aggiornato al formato
italiano`. The production deploy of the same afternoon contains no date-format change
of any kind.**

### What is now claimed

- 🆕 **`Pienissimo_Recap_Modifiche_2026-11-12.xlsx` was edited by Anita Aga at
  **2026-11-18 10:37:52Z** and row 1 — _"Formato italiano ovunque: date (anche nelle
  tranche e nella Community), separatore delle migliaia e dei decimali, spazio tra
  numero e simbolo € nella Community"_ — now reads **`Già fatto`**, having read
  `Da implementare` since 12/11. Its own note column is unchanged and still says what
  the fix is: _"Abilitiamo il formato italiano **a livello di org** e verifichiamo
  tutti i componenti con riferimenti custom alla data (es. Aggiungi prodotti)."_
- 🆕 **The release mail** (`1a1ef1a15d272f94`, 14:40:26Z, to amministrazione,
  Fabrizio Paganelli, Sabatino Rinaldi and Elena Spini) lists _"Formato date:
  aggiornato al formato italiano"_ among the released changes →
  [OI-374](OI-374%20The%2018%20November%20release%20mail%20tells%20the%20client%20the%20order%20contract%20flow%20is%20live.md).

### 🔴 What the deploy contains

The production release of 18/11 is the `DevMain` delta `4478915..4d18d57`, deployed
in three quick deploys — `0AfSW000001Malp0AC` (13:43:49Z, 33 non-Apex components),
`0AfSW000001Map30AC` (13:45:39Z, a permission-set restore) and
`0AfSW000001MbQ90AK` (14:23:28Z, the Mexal home-page bundle).

**That delta contains no Visualforce page, no PDF or email template, and no
`dd/MM`, `DateTimeFormat` or locale-date edit anywhere in its 60 `force-app`
files.** The formatting it carries is money: `Intl.NumberFormat("it-IT", EUR)` in
six LWC bundles. The community locale was **excluded from the deploy** because, per
the developer's journal, **production already has `it` as its default** — which
concerns the Experience Cloud site, not the quote PDF.

🔑 **So the only mechanism by which the claim can be true is the org-level Locale
setting**, which is not metadata, leaves no trace in the repository, and was the
developer's own stated fix (_"devo abilitare il formato italiano nella ORG"_). It
is plausible and it is unverified: ⚠ **the org was not opened in this run.**

### Why this needs a person, not another sweep

The date in question appears on the **signed quote PDF that reaches Pienissimo's own
customers**. Fabrizio Paganelli escalated it for that reason on 16/11. The client has
now been told in writing that it is fixed. **Nobody has reported looking at a quote
PDF in production since.**

**Still open:** a confirmed reading of a production quote PDF, the tranche-screen
dates, and `654618c`, which merged into `DevMain` in PR #131 on 18/11 and is
therefore no longer stranded on `DevAnita17`.
