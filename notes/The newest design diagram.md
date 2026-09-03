---
id: ref-dgm2-newest
type: reference
status: active
owner: Elena Spini
org: ROMI
updated: 2026-09-03
source: Drive - Flows & Objects.drawio, modified 2026-08-26T14:06:48Z
decoded_at_version: 2026-08-26T14:06:48Z
supersedes_in_register: DGM-2
---

# The newest design diagram

`Flows & Objects.drawio` — Elena Spini's master design file, **three pages:
LEAD-OPTY, Ordini, Flusso Biglietti**. **This is the authority for state
machines**, ahead of the prose recaps.

**Re-decoded 2026-08-25 at its 2026-08-25T08:23:31Z version** — 130 KB, plain
uncompressed mxfile XML, read in full. Three pages.

> ⚠ **The file has now moved five times in seven days** — 19 Aug 16:33 UTC,
> 20 Aug 15:36 UTC, 24 Aug 16:34 UTC and 25 Aug 08:23 UTC. The 19 August version
> was never decoded, so pre-20-August changes are dated only as *"after the
> 06 August version that was decoded on 14 August"*.
>
> 🟢 **The 24 and 25 August edits are both minuted**, which no earlier one was.
> The 24 August edit lands the same afternoon as Elena Spini's action _"Inviare i
> verbali della riunione e il link al flusso di lavoro aggiornato sul Drive"_
> from [the Follow-up Interno](meetings/2026-08-24%20Follow-up%20Interno.md). The
> 25 August edit is made **during the meeting it records** — 10:23 CEST, twenty
> minutes into
> [the Anticipay session](meetings/2026-08-25%20Integrazione%20Anticipay.md).

## What changed on 2026-08-25

🔴 **One cell, and it leaves the file contradicting itself.**

The **LEAD-OPTY** page now reads:

> _"Alla generazione del primo ordine di un ACCOUNT chiamata API **al middleware
> Pienissimo** per check P.IVA Account"_

The **Ordini** page still carries the previous wording, verbatim and unedited:

> _"Alla generazione del primo ordine di un ACCOUNT chiamata API **Anticipay**
> per check P.iVA Account"_

Both pages had the second wording on 24 August. Only one was updated when
[the meeting](meetings/2026-08-25%20Integrazione%20Anticipay.md) replaced the
direct call with the middleware. **The LEAD-OPTY wording is the later and correct
one** — see
[OI-94](items/OI-94%20Anticipay%20is%20called%20through%20the%20Pienissimo%20middleware.md).
Anyone reading the Ordini page alone will build the architecture that was
superseded at 10:20 that morning.

Nothing else moved: the campaign `IMPORTANTE` cell, both LEAD-OPTY specification
blocks, the picklist values, the three loss-reason lists, the order and asset
boxes and the `Scadenziario MEXAL` sticky are all present and unchanged. The
`Unhappy path: info con email ad amministrazione` note sits beside both versions
of the cell.

## What changed on 2026-08-24

**1. The campaign configuration, as a new `IMPORTANTE` cell** on the
`Flusso Biglietti` page, verbatim:

> _"Prodotto creazione di un campo lookup campagna codice campagna padre che deve
> essere messo manuale post creazione campagna — Sulle campagna figlie deve
> esserci logica solo una campagni attiva"_

This is the [Follow-up Interno](meetings/2026-08-24%20Follow-up%20Interno.md)
decision written into the design file the same day. See
[the campaign parent and child model](objects/The%20campaign%20parent%20and%20child%20model.md).

**2. Two full specification blocks on the LEAD-OPTY page**, `RULES + FLOW TASK
OPTY` and `RULES + FLOW OPTY/QUOTE`, which carry the
[24 August Lead/Opty rulings](meetings/2026-08-24%20Interna%20per%20update%20flusso%20Lead-Opty.md)
including, for the first time anywhere, **the picklist values themselves**:

- `Motivazione da Ricontattare` — Data corso incompatibile · Locale ancora da
  aprire · Non risponde · Rimanda acquisto per prezzo · Rimanda acquisto per
  motivi personali · Rimanda acquisto per problemi con attività · Richiamare dopo
  la stagione.
- `Motivazione da Ricontattare - Preventivo Inviato` — Richiamare dopo la
  stagione · Ha da fare · Deve pensarci.

Plus the validation rules (`Motivazione da Ricontattare` and `Data da
Ricontattare` mandatory to save the Opty status; `Data Di Scadenza` mandatory to
save a Quote in `In Trattativa`), the **day-2 reminder task** spec
(`Subject = Preventivo Inviato`, `Task Sub type = Da Ricontattare`,
`Due Date = the day after creation`), and `Status Quote == Rifiutato >>` Opty to
Chiusa Persa with a mandatory popup reason. These feed
[OI-59](items/OI-59%20Quote%20workflow%20configuration.md).

**3. A third loss-reason list, `Motivazioni CHIUSA PERSA`** — prezzo alto ·
sceglie concorrenza (competitor list) · tempistiche di erogazione servizio ·
servizio/prodotto non allineato con le aspettative. Distinct from the Lead-level
`PERSO` and `ERRATO` lists already recorded below.

**4. `Anticipay` is named as the VAT-check provider** — _"Alla generazione del
primo ordine di un ACCOUNT chiamata API Anticipay per check P.iVA Account"_, with
_"Unhappy path: info con email ad amministrazione"_, on **both** the LEAD-OPTY
and Ordini pages. See [OI-73](items/OI-73%20VAT%20validation%20moves%20into%20Salesforce.md).
**Superseded on the LEAD-OPTY page on 25 August** — see the 25 August section
above.

⚠ **Items 3 and 4 cannot be dated to 24 August.** They are present in this
version and absent from this note's 20 August write-up, but that write-up was
prose, not a byte-level record — absence from a summary is not proof of absence
from the file. Record them as **present, not previously registered**. There is an
Anticipay meeting on 25 August, which is consistent with either reading.

## What changed on 2026-08-20 and before

**1. The 19 August ticket flow has been folded into the master.** The
`Flusso Biglietti` page now carries everything that was new in the standalone
file: `Rinuncia` as a **seventh asset-state box** annotated _"Avviene nella
comunicazione dei partecipanti o accetta o rinuncia"_, the admin-only
`Aggiornamento Incasso` button, the `A XX giorni dall'evento` second funnel
send, the concrete participant landing page, and `Casi Limite` split into
CASO 1 / CASO 2.

This matters more than the standalone did. `Rinuncia` is no longer only in a
side file — **it is in the file the requirement register is checked against**.
See [OI-74](items/OI-74%20Asset%20state%20machine.md); it is still unminuted and
still needs a human ruling.

The struck-through _"Se quell'Account ha acquistato più eventi"_ branch that the
standalone carried is **absent from the master entirely** — the withdrawn step
was not carried across, which supports reading it as deliberately dropped.

**2. The 06 August order states are now drawn — but the old ones were not
struck.** An `ORDINE` block appeared on the **LEAD-OPTY** page with three boxes,
`Ordinato` · `Fatturato` · `Incasato` (one `s`, as drawn), plus the rule
_"Status Order == Incassato >> Aggiornamento dell'**Opty in Chiusa Vinta**"_ and
_"ci sarà la creazione/copia della quote in ORDINE con stato == ORDINATO"_. The
same three boxes also appear on the **Ordini** page.

**But `Order Status SF == CHIUSO/ACQUISITO` and `Order Status SF == CREATO` are
still on the Ordini page**, and the tranche rule still reads _"la prima TRANCHE
va subito in stato CHIUSO/ACQUISITO"_. So the diagram now shows **both
vocabularies side by side**. It does **not** answer
[OI-69](items/OI-69%20Order%20state%20model.md)'s question — whether `Incassato`
is `CHIUSO/ACQUISITO` renamed or a different milestone — it makes the
coexistence explicit instead. Only three order states are drawn; **no `Perso`**
box appears, which bears on [OI-85](items/OI-85%20Order%20state%20set%20may%20be%20incomplete.md).

**3. New on 20 August: a `Scadenziario MEXAL - Check con Andrea` note.** A
yellow sticky, the **last cell in the file**, placed beside the
`Aggiornamento Incasso` button: _"Capire se da fattura NON pagata (Scadenziario)
è possibile aggiornare ASSET allo stato prima."_ It is **not** in the 19 August
standalone, so it was added on 20 August. Now
[OI-92](items/OI-92%20Mexal%20Scadenziario%20as%20the%20trigger%20to%20reverse%20an%20asset.md).

**4. A ticket tier was renamed: `Silver` → `Dinamond`.** The product-code note
now reads _"Camerieri Venditori 26 Gold"_ / _"Camerieri Venditori 26
**Dinamond**"_. The 19 August standalone said **Silver**, and so does the
06 August transcript, where Elena Spini says plainly _"camerieri venditori
Silver ha un codice diverso da camerieri venditori gold."_ So an unminuted
diagram edit has replaced a minuted term. Almost certainly _Diamond_ misspelt.
**Do not propagate it into the picklist** — see
[OI-76](items/OI-76%20Ticket%20type%20picklist%20on%20the%20product.md).

## The register's dates are wrong; its content is mostly not

[requirements/pienissimo-requirements.yaml](../requirements/pienissimo-requirements.yaml)
recorded `DGM-2` as `modified: 2026-08-06T15:22:03Z`. Drive now reports
**2026-08-20T15:36:24Z**. The provenance date has been corrected; **the state
machines were not re-extracted**, because nothing in this drawing is minuted.

The register's extracted content still matches the diagram for the asset states
including `Annullato`, the tranche states, the `Scaduto → In attesa di
accettazione` rename, the QR-carries-campaign-member-id detail, and
`CHIUSO/ACQUISITO` documented as a deliberate **name collision** across Order
and Tranche.

## The two genuine gaps, restated

**1. The order state machine.** Now half-migrated in the drawing rather than
absent from it — see change 2 above and
[OI-69](items/OI-69%20Order%20state%20model.md) /
[OI-50](items/OI-50%20Tranche%20object.md).

**2. `opportunity_types` is missing a value.** The register lists
`["Vendita da tutor", "Recall tutor"]`; the diagram also carries **`Plus +
Attivazione o Rinnovo`**, which is what
[OI-70](items/OI-70%20Performance%20Plus%20opportunity%20typing.md) configures.

## Naming, for the record

The asset cancellation state is **`Annullato`** in the diagram and in the
register (drawn `Annulato`, one `l`, a typo). Elena's
`PIENISSIMO - Project Status.docx` calls it **"rinuncia al servizio"**, and the
client's June requirements document uses the same phrase. The prose was the
outlier — but with `Rinuncia` now drawn as its own box in the master, that
reading is what OI-74 has reopened. Build nothing until it is ruled on.

## What the diagram confirms

Asset states `Ordinato → Disponibile → Assegnato → Utilizzato / Non utilizzato /
Annullato` (plus the unruled `Rinuncia`), with `Disponibile` on _"Fattura pagata
- a livello di tranche/rate"_. Tranche: first to `CHIUSO/ACQUISITO` on deposit,
subsequent to `CREATO`. Quote `Bozza → Nuovo Preventivo → In Trattativa → In
Attesa Accettazione → Accettato / Rifiutato`. All already in the register.

**Loss reasons.** `PERSO`: non interessato · prezzo alto · sceglie concorrenza
(with a competitor list to pick from) · servizio non adatto. `ERRATO`: ha già
P.Pro · già in contatto · dati inesatti · duplicato da CRM · non in target ·
richiesta inviata per errore · SW house / agenzia marketing / web agency · test.

**Order types:** `STANDARD` · `BUNDLE` (vendita da palco) · `PLUS` (attivazione
o rinnovo). **Opportunity types:** vendita da tutor · recall tutor · plus.

**Other details.** The QR code contains the **campaign member id**; a WooCommerce
order is **invisible to Salesforce until status `COMPLETATO`**, which
administration sets by hand on receiving the bank transfer; the _Insoluti_
report goes every **Monday to Marco Montesi and amministrazione**; the "Casi
Limite" button is visible **only after an asset is `Assegnato`**, and
`Aggiornamento Incasso` only after `Disponibile`; each event has its **own
product code**, with ticket type in the name.

⚠ The diagram still uses a **real customer order as its worked example**,
carrying a company name and VAT number. Keep it out of `notes/`, the recaps and
[site/](../site/).

## Companion file

The client's own [`Workflow Pienissimo 23-7-26.drawio`](The%20client%20Lead-Opty%20diagram%20moved%20on%2020%20August.md)
(`DGM-1`, Marco Montesi) was modified **68 minutes before** this file on the
same afternoon. Both register source diagrams moved on 20 August; neither
change is minuted.

## 2026-08-26 - a sixth edit, made during the Mexal call, changing nothing tracked

`Flows & Objects.drawio` moved again to **2026-08-26T14:06:48Z** — 16:06 CEST,
**six minutes into
[the Mexal review](meetings/2026-08-26%20Review%20Temi%20Integrazione%20Mexal.md)**,
which Elena Spini was chairing. Sixth edit in eight days.

**Re-decoded at that version.** 130 KB, three pages, still plain uncompressed
mxfile XML. **Every text cell this note tracks is unchanged, word for word.**

⚠ **What changed is therefore not in the labels.** Geometry, style or cell
position were not compared — only text content was. Do not report this as "an
edit with no changes"; report it as an edit that **did not move any wording the
record depends on**. The likeliest explanation is an autosave from opening the
file during the call.

### 🔴 Two cells are now stale against meetings, not one

The 25 August section above records the LEAD-OPTY / Ordini split on the Anticipay
middleware. **It is unfixed after a sixth edit** — the Ordini page still reads
_"chiamata API Anticipay"_ while LEAD-OPTY reads _"al middleware Pienissimo"_.

**A second cell joined it today.** The `IMPORTANTE` block on the *Flusso
Biglietti* page still reads:

> _"Sulle campagne figlie deve esserci logica solo una campagna attiva"_

That rule was **abandoned in the 26 August session**, by Elena Spini, who wrote
it — a bundle spanning two events cannot resolve to one active edition. It is
replaced by [OI-96](items/OI-96%20Edition%20mapping%20table%20on%20Salesforce.md),
the order-date mapping table. The same cell's other half — _"Prodotto creazione
di un campo lookup campagna codice campagna padre… messo manuale post creazione
campagna"_ — is also superseded: the event now descends from Mexal's `categoria
statistica`.

⚠ **`AGENTS.md` treats this file as the authority for state machines.** On the
campaign model it is now behind the minutes by one meeting, and behind them on a
page the client's own designers read. **Prefer
[the meeting note](meetings/2026-08-26%20Review%20Temi%20Integrazione%20Mexal.md)
over the diagram on campaigns and editions until someone reconciles the file.**
Nothing on any page mentions Mexal's `natura`, `categoria statistica`,
`gruppo merceologico` or `Gest. annullato`.

## ⚠ 2026-09-03 - the file moved a fifth time, and was not decoded

`Flows & Objects.drawio` was modified at **09:20:01Z on 3 September** by Elena
Spini — about 100 minutes before
[Data Model Parte 1](meetings/2026-09-03%20Data%20Model%20Parte%201.md) started,
so almost certainly preparation for it rather than an outcome of it.

**This session did not decode it.** The Drive text reader cannot render
`application/vnd.jgraph.mxfile`; every previous decode in this note was done by
hand from the XML. **What changed on 3 September is unknown**, and that is a
statement of what was not done, not a claim that nothing changed.

The decode is cheap for anyone with the file open and should be taken before
Parte 2 on 4 September, because the earlier unminuted edits in this note show the
diagram is where design changes land before they reach a minute.
