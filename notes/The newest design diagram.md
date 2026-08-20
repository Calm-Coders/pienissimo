---
id: ref-dgm2-newest
type: reference
status: active
owner: Elena Spini
org: ROMI
updated: 2026-08-20
source: Drive - Flows & Objects.drawio, modified 2026-08-20T15:36:24Z
decoded_at_version: 2026-08-20T15:36:24Z
supersedes_in_register: DGM-2
---

# The newest design diagram

`Flows & Objects.drawio` — Elena Spini's master design file, **three pages:
LEAD-OPTY, Ordini, Flusso Biglietti**. **This is the authority for state
machines**, ahead of the prose recaps.

**Re-decoded 2026-08-20 at its 2026-08-20T15:36:24Z version** — 128 KB, plain
uncompressed mxfile XML, read in full. This clears the 🔴 action carried since
19 August, when the file had moved and had not been re-read.

> ⚠ **The file has now moved twice in two days** — 19 Aug 16:33 UTC and 20 Aug
> 15:36 UTC — and **neither edit is minuted**. The 19 August version was never
> decoded, so the changes below are dated only as *"after the 06 August version
> that was decoded on 14 August"*. Where a change can be pinned to 20 August it
> is because [the 19 August standalone drawing](The%20ticket%20flow%20diagram%20of%2019%20August.md)
> is a one-day-old reference point that does not contain it.

## What changed since the record

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
