---
id: meeting-2026-11-16-ultimi-check-prod
type: meeting
status: resolved
owner: Elena Spini
with: Aurel Mrruku, Anita Aga, Fabrizio Paganelli, Elisa Migliano, Marco Montesi, Sabatino Rinaldi
org: both
raised: 2026-11-16
updated: 2026-11-16
depends_on: []
blocks: []
source: Drive 1g9NO_P9ju0l-kGfgz_E3ZCJzqACuOapccmul-732FPQ
---

# 2026-11-16 - Ultimi Check PROD

**Two hours and eighteen minutes on the first morning the client's users were
live. The migration numbers were walked through, the new Opportunity rule was
proved end to end in production on a real order, and three things broke in the
room: the Mexal nightly syncs had failed overnight on Mexal's own maintenance
window, a user had already converted leads and thrown an Apex exception, and the
WooCommerce test could not complete because the client had deactivated most of the
catalogue the day before. The call ended early when the client's management pulled
two of the three attendees away.**

## Attendees

- **Aurel Mrruku** (ROMI) — lost his office connection mid-call and continued
  from a phone and then a colleague's PC
- **Anita Aga** (ROMI / Calm-Coders)
- **Fabrizio Paganelli** (Pienissimo)
- **Elisa Migliano** (Pienissimo, amministrazione)
- **Marco Montesi** (Pienissimo) — added to the call by Fabrizio Paganelli; left
  partway. He is the commercial lead who has resigned
  ([OI-357](../items/OI-357%20The%20client%20commercial%20lead%20and%20the%20web%20counterpart%20are%20both%20leaving.md))
- **Sabatino Rinaldi** (Pienissimo)
- 🔴 **Elena Spini absent** — she is on leave until 19 November
  ([OI-348](../items/OI-348%20Fase%201%20post%20go-live%20support%20is%20unassigned%20and%20unpriced.md))

## Sources

| | |
| --- | --- |
| Transcript | Drive `1g9NO_P9ju0l-kGfgz_E3ZCJzqACuOapccmul-732FPQ`, 93,900 chars, **read in full in five passes** |
| Duration | **02:17:59** |
| Recording | ⚠ none in the folder — the folder holds the transcript shortcut only |
| Agenda | Aurel Mrruku's mail of 13/11 16:56Z, Gmail `1a1d06456c06e4f8`, walked point by point |

## The migration, as reported to the client

Walked from the 13/11 mail. Figures as stated in the call; the repository holds no
customer values.

| | |
| --- | --- |
| **Aziende** | 24 new, 32 updated, **8,307** in Prod. Those with no Partita IVA stay out |
| **Locali** | 953 new, 15 updated, **4,873** |
| **Referenti with a Mexal code** | 86 new, 231 updated, **17,775** Contacts. 100 rows carry a code matching no Azienda and stayed out |
| **Referenti without a code** | **49,811 of 49,822** loaded as Leads; Partita IVA left blank, `Company` = `Referente Importato` |
| **Zoho lead file** | 10,765 rows, of which 6,772 already present as referenti and merged; **407 left out** (296 email already a Contact, 111 duplicates) |
| **Orders** | 45 new and 18 modified; the 18 were **deleted with their whole chain and re-inserted** under the same Mexal code, with no "modified" flag |
| **Orders deleted** | 32 — the 13 cancelled in Mexal, order 77241 replaced, and the 18 recreated |
| **Orders not loaded** | 28 (58 lines), old 2023-24 orders of 6 customers absent from the anagrafica |
| **Invoices** | all from 2024 onward: **10,969 invoices, 15,670 scadenze**; **19,574 tickets** now available |
| **Ticket mails** | 🟢 **none went out** — confirmed by check, thanks to Fabrizio Paganelli's backdating of the event editions ([OI-353](../items/OI-353%20Production%20event%20end%20dates%20are%20backdated%20to%20stop%20ticket%20mails%20during%20the%20load.md)) |

🔴 **The client cannot verify the Azienda count.** Fabrizio Paganelli: _"il check
della numerica non la possiamo fare perche su Mexal abbiamo anche tante aziende
molto vecchie che non sono state migrate."_ Agreed fallback: sample checks.

## What broke, in the order it surfaced

### The nightly Mexal syncs had failed, and now the reason is known

Fabrizio Paganelli had spent Sunday afternoon in Mexal deactivating article codes
so the tutors would not see them, by changing the `gruppo merceologico`. On Monday
morning: _"sono andato a vedere, pero a me non mi pare che funzioni."_

Aurel Mrruku checked the job from script and found **HTTP 500 on both the 01:00
article run and the 02:00 customer run**, the 03:00 quote reminder having
succeeded. 🔑 Fabrizio Paganelli supplied the cause:

> _"ci sono delle procedure che girano in notte su Mexal che **buttano fuori gli
> utenti**, fa dei backup suoi automatici, a meno che sia proprio quella l'ora in
> cui ti butta fuori. Quindi **qualsiasi procedura non funziona**."_

Aurel Mrruku re-ran the article sync in the call: 109 articles returned, and
`plus_N02`'s description change verified at 10:03. Recorded in
[the sync window note](../The%20Mexal%20sync%20window%20and%20the%20year%20boundary.md),
[OI-334](../items/OI-334%20The%20Mexal%20sync%20frequency%20is%20undecided%20and%20no%20job%20is%20scheduled%20in%20production.md)
and
[OI-327](../items/OI-327%20The%20blow%20product%20codes%20carry%20the%20wrong%20gruppo%20merceologico.md).

### A user converted leads in production and threw an Apex exception

Aurel Mrruku, reading the job log: _"**chi stamattina ha fatto conversione dei
lead?** Martina, perche in produzione pure. Ma li potete fermare, per cortesia."_

Marco Montesi: _"li ho gia avvisati tutti stamattina. Si vede che lei ha fatto
qualcosa prima prima che io gli avvisassi, **anche perche non sappiamo come
muoverci** … perche alcune cose qui non vanno e non girano e non funzionano."_

The Salesforce exception mail for that conversion arrived at **09:16:51Z**. See
[OI-337](../items/OI-337%20Lead%20conversion%20throws%20in%20production%20when%20the%20Opportunity%20fields%20are%20inaccessible.md).

### The WooCommerce test could not finish

🔴 Sabatino Rinaldi admitted the plugin flag was **still off**: _"Il plugin di
WCommerce ancora non l'ho attivato, che faccio?"_ — activated live, in production,
during the call. Fabrizio Paganelli: _"cosi stamattina facciamo dei test in
produzione."_

Sabatino Rinaldi then placed a real shop order, bank transfer, moved it to
Completato. The opportunity matched, **the order never reached Salesforce**:

> _"e andato tutto bene, ha visto anche qual era l'opportunity, ma non ti ha
> inviato l'ordine perche sotto c'ho l'errore **come l'altra volta: product code
> match**."_

Three real product codes were tried in turn and all were inactive. Aurel Mrruku:
_"Mi sa che **li ha disabilitati Fabrizio** sti prodotti"_ · _"ho un prodotto
attivo, la maggior parte sono non attivi."_ The test was abandoned when Elisa
Migliano pulled Sabatino Rinaldi into a management meeting, and deferred to _"oggi
pomeriggio … dopo le 3."_ See
[OI-366](../items/OI-366%20Most%20Salesforce%20products%20are%20inactive%20so%20WooCommerce%20orders%20fail%20the%20product%20code%20match.md)
and
[OI-354](../items/OI-354%20WooCommerce%20is%20connected%20to%20production%20by%20the%20client.md).

⚠ Sabatino Rinaldi placed that order under **Fabrizio Paganelli's name with his
own home address and mobile number**. Not recorded here.

## The new Opportunity rule, proved in production

Aurel Mrruku: _"ho anche portato su il cambiamento dello status dell'opportunita …
adesso l'opportunita passa in vinta al primo pagamento"_, tested in UAT, and
_"**non c'e nessun blocco su azioni su quella struttura**"_ — orders, opportunities,
order lines and assets stay editable once Vinta.

Fabrizio Paganelli then ran the whole chain live, with Aurel Mrruku watching the
org: a new Performance Plus `attivazione` opportunity on the `test pienissimo`
account, four tranches dated 30/11/2026, 31/12/2026, 31/01/2027 and 28/02/2027
with a 20% discount, quote PDF generated, sent for acceptance, signed through
DocuSign, the order sent to Mexal, invoiced in part and the first invoice paid.

🟢 **Result, verified in the org on the call:** invoice paid, scadenza paid, the
order **not** Fatturato because not everything was invoiced, the Opportunity
**Vinta**. Aurel Mrruku: _"Perfetto, funziona."_

Fabrizio Paganelli restated the general rule and Aurel Mrruku confirmed it:

> _"la regola generale che vale per tutto e che l'opportunity va in vinta quando c'e
> stato l'incasso collegato alla fattura che e collegato a sua volta a quell'ordine."_
> — _"corretto."_

And he walked the WooCommerce variant himself: a card payment is registered the
same day, so the order goes Incassato overnight and the Opportunity Vinta; a bank
transfer stays Ordinato until administration sees it on the statement. See
[OI-69](../items/OI-69%20Order%20state%20model.md).

## Metadata changed directly in production, during the call

🔴 Four picklists were edited live in Prod, by the client, with Aurel Mrruku
guiding — none of it from source:

| Object / field | What was done |
| --- | --- |
| `Product2` → `Anno accademico` | Values did not exist on the product at all, only on Campaign. `2026/27`, `2027/28`, `2028/29` added by Fabrizio Paganelli |
| `Product2` → `Tipo bundle` | Held only the year bundles; **Performance Plus** and a catch-all **altri pacchetti** added, the latter over an unresolved disagreement — _"Io non sono d'accordo su farlo … intanto lo facciamo, dopo al massimo lo eliminiamo"_ |
| `Product2` → `Evento di origine` | 🔴 **no values at all** in Prod; its dependency on `Anno accademico` had to be rebuilt by including and excluding values by hand |
| Bundle record type | Fabrizio Paganelli had no permission; granted live — _"Non t'ho attivato il permesso sul record bundle"_ |

⚠ The `/` in `2026/27` is suspected and unresolved: Aurel Mrruku, _"forse quel
slash che non gli va bene, lo dobbiamo usare un altro carattere"_, before the
failure turned out to be Fabrizio Paganelli's own PC. Recorded in
[OI-367](../items/OI-367%20Picklist%20values%20and%20a%20dependency%20were%20created%20directly%20in%20production.md).

🔑 Restated on the call and consistent with
[the standing decision](../decisions/Decision%20-%20single%20products%20come%20only%20from%20Mexal%20and%20only%20bundles%20are%20built%20in%20Salesforce.md):
single products come from Mexal only, _"quando facciamo gli eventi i bundle li
creiamo direttamente su Sales Force."_

## Answered on this call

| Question | Answer |
| --- | --- |
| **May the client test in production?** | 🟢 Aurel Mrruku: _"siete liberi di testare in produzione"_, and they did, for two hours. Closes [OI-355](../items/OI-355%20Nobody%20answered%20whether%20quote%20tests%20can%20be%20run%20in%20production.md) |
| **The 28 orders of 6 customers** | Not loaded, by the client's choice — _"lasciamo stare cosi. Non li carichiamo"_ |
| **Order 77241's date** | _"Si, confermato il 22/10/2026"_ |
| **The 33 invoices with no customer** | Their 2022-23 orders were never imported, and an invoice reaches the customer through its order. Fabrizio Paganelli: _"lo sistemo a mano"_ |
| **The Mexal order numerator** | 🔑 Mirko Merendi set it on Friday 13/11: Salesforce orders enter Mexal **from 80,000 up**, Zoho orders are below. → [OI-310](../items/OI-310%20The%20production%20load%20needs%20a%20pre-load%20and%20a%20delta%20run.md) |
| **Ticket sends for Pienissimo Live and Intensive** | Left off. Sabatino Rinaldi: _"Oggi non vanno attivati."_ The rule: send date in the past **and** event end date in the future |
| **The 296 leads already present as Contacts** | Sabatino Rinaldi: _"e giusto che venga trattato come un opportunity e non come un lead perche abbiamo gia l'azienda"_ |
| **Several principal contacts per Azienda** | Aurel Mrruku took the last one and asked the client to verify them while working orders → [OI-372](../items/OI-372%20Several%20principal%20contacts%20per%20Azienda%20were%20collapsed%20to%20the%20last%20one.md) |

## Commitments made, with dates

- 🔑 **Jobs rescheduled in the room**: from 05:00 every 15 minutes, plus an
  afternoon round. Fabrizio Paganelli typed it into the mail thread as `PUNTO 5`
  at 09:01Z and said the last afternoon run should be **14:00**. ⚠ What was
  deployed the same day is 05:00/13:00, 05:15/13:15, 05:30/13:30 — the 14:00 run
  does not exist. → [OI-334](../items/OI-334%20The%20Mexal%20sync%20frequency%20is%20undecided%20and%20no%20job%20is%20scheduled%20in%20production.md)
- 🔑 **Manual run buttons on the home page by 18 November**, after
  `execute anonymous` failed on the client's Developer Console in the call:
  _"Ti metto una sezione sincronizza con Mexal … sincronizza prodotti, articoli,
  clienti, fatture scadenziario."_ Plus documentation. →
  [OI-370](../items/OI-370%20The%20client%20cannot%20run%20the%20Mexal%20syncs%20by%20hand.md)
- **Sabatino Rinaldi asked for the final job times by mail** once agreed with
  Fabrizio Paganelli, _"cosi evitiamo di accavallarci, perche noi ne facciamo
  abbastanza poi di questi di notte."_ Nothing records it sent.
- **The date format on the client-facing quote PDF** goes into the **18 November**
  release, not today: _"il 18 porto anche questo cambiamento su quel rilascio."_
  Fabrizio Paganelli asked for priority — _"se i ragazzi iniziano a mandare via gli
  ordini dopo non abbiamo degli interlocutori che sono ad un livello sufficiente da
  capire che questo qui e un formato americano."_ →
  [OI-358](../items/OI-358%20The%20org%20is%20not%20set%20to%20Italian%20date%20and%20number%20formats.md)
- **Elena Spini's list of open changes is due Friday 20 November**: _"m'ha mandato
  un bel Excel Elena venerdi. C'erano altre cose chieste anche nei test"_ →
  [OI-344](../items/OI-344%20The%20client%20sent%20sixteen%20Sales%20flow%20changes%20and%20none%20is%20triaged.md)
- **The home page is to be stripped** of the standard components: _"mi elimini
  tutto quello che c'e qui"_ → [OI-364](../items/OI-364%20Agents%20cannot%20see%20the%20home%20page%20or%20the%20calendar%20in%20production.md)
- **A third signature is missing on the courses contract** and Aurel Mrruku has
  no record of it: _"Me la sono persa se l'abbiamo visto insieme … mandate una
  mail … con un cerchio in rosso"_ →
  [OI-336](../items/OI-336%20The%20quote%20PDF%20allegato%20B%20has%20no%20signature%20field.md)

## Two risks the client raised and accepted

- 🔴 **DocuSign asks the signer to register.** Marco Montesi: _"qui sembra quasi
  che uno si debba registrare … **i nostri clienti digitalmente qui si perderanno,
  non sapranno cosa fare**."_ Aurel Mrruku: _"non ci puoi fare niente … lo fa
  apposta perche e un'utenza."_ Accepted with no mitigation beyond briefing the
  tutors — _"inizialmente tocchera chiamare i clienti ogni volta che qui si
  perderanno e succedera di ogni."_ →
  [OI-369](../items/OI-369%20DocuSign%20asks%20signers%20to%20register%20and%20the%20client%20expects%20to%20lose%20them.md)
- 🔴 **New business is still being keyed into Zoho.** Marco Montesi asked whether
  the commercial team could start; Aurel Mrruku: _"in teoria e tutto attivo in
  produzione … fino adesso non abbiamo visto nessuna anomalia."_ Marco Montesi:
  _"io intanto gli faccio caricare le opportunity che avevano su Zoho."_ Sabatino
  Rinaldi on the web side: _"ora in tempo reale no, **sono ancora su Zoho**"_, and
  the Pienissimo Live registration forms are built, tested and waiting on ROMI —
  _"appena Fabrizio ci da l'ok, mettiamo pienissimo live come nuovi moduli."_ →
  [OI-371](../items/OI-371%20Opportunities%20are%20re-keyed%20from%20Zoho%20while%20the%20web%20forms%20wait%20for%20ROMI.md)

## Not done, and why

- **No euro figures transcribed**, although quote and invoice totals were read
  aloud repeatedly.
- **No customer record copied.** The test order's personal data is named as
  existing and not reproduced.
- **The org was not independently inspected in this session.** Everything above
  that describes Prod is what the call shows or what the 16/11 journal entries
  record, not a fresh inspection.
- **The afternoon WooCommerce retest was not found** in any source as of this
  sweep.
