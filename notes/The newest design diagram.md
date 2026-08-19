---
id: ref-dgm2-newest
type: reference
status: active
owner: Elena Spini
org: ROMI
updated: 2026-08-19
source: Drive - Flows & Objects.drawio, modified 2026-08-19T16:33:19Z
decoded_at_version: 2026-08-06T15:22:03Z
supersedes_in_register: DGM-2
---

# The newest design diagram

`Flows & Objects.drawio` — Elena Spini's master design file, **three pages:
LEAD-OPTY, Ordini, Flusso Biglietti**. **This is the authority for state
machines**, ahead of the prose recaps.

> 🔴 **Everything below describes the 06 August version, decoded on 2026-08-14.
> The file was modified again on 2026-08-19 at 16:33 UTC and has NOT been
> re-decoded.** That is 92 minutes after Elena created the standalone
> [19 August ticket flow diagram](The%20ticket%20flow%20diagram%20of%2019%20August.md),
> so the likeliest content is that same ticket flow folded into the master — but
> **that is a guess, and the master is the file the requirement register is
> checked against.** Re-decode it before trusting any state machine here. In
> particular it is unknown whether the master now also shows `Rinuncia` as a
> seventh asset state; see [OI-74](items/OI-74%20Asset%20state%20machine.md).

## The register's dates are wrong; its content is not

[requirements/pienissimo-requirements.yaml](../requirements/pienissimo-requirements.yaml)
records `DGM-2` as `modified: 2026-07-31T09:50:03Z` and `DGM-1` as
`2026-07-31T12:46:09Z`. Drive reports **2026-08-06T15:22** and
**2026-08-04T10:09**. `README.md` and `REQUIREMENTS.md` repeat the 31 July date.

**But the register's extracted content matches this version of the diagram
almost exactly** — it already carries the six asset states including
`Annullato`, the tranche states, the `Scaduto → In attesa di accettazione`
rename (flagged as a retired label), the QR-carries-campaign-member-id detail,
and `CHIUSO/ACQUISITO` documented as a deliberate **name collision** across
Order and Tranche rather than a contradiction.

So whoever built the register read current content and recorded a stale
timestamp. **Fix the provenance dates, do not re-extract the state machines.**

Two genuine gaps remain — see below.

## The two genuine gaps

**1. The order state machine predates the 6 August decision.** The register
carries `order.states: [CREATO, CHIUSO/ACQUISITO]` — the diagram's values. The
closing session agreed **`Ordinato → Fatturato → Incassato`** and struck _Chiuso
acquisito_ as _"non serve più"_. Whether `CHIUSO/ACQUISITO` and `Incassato` are
the same milestone renamed, or two different things, is **not settled anywhere**
— and the tranche rule still depends on `CHIUSO/ACQUISITO`. See
[OI-69](items/OI-69%20Order%20state%20model.md) and
[OI-50](items/OI-50%20Tranche%20object.md).

**2. `opportunity_types` is missing a value.** The register lists
`["Vendita da tutor", "Recall tutor"]`; the diagram also carries **`Plus +
Attivazione o Rinnovo`**, which is what
[OI-70](items/OI-70%20Performance%20Plus%20opportunity%20typing.md) configures.

## Naming, for the record

The asset cancellation state is **`Annullato`** in the diagram and in the
register. Elena's `PIENISSIMO - Project Status.docx` of the same day calls it
**"rinuncia al servizio"**; the client's June requirements document uses the
same phrase. The prose is the outlier — build `Annullato`.

## What the diagram confirms

Asset states `Ordinato → Disponibile → Assegnato → Utilizzato / Non utilizzato /
Annullato`, with `Disponibile` on _"Fattura pagata - a livello di tranche/rate"_.
Tranche: first to `CHIUSO/ACQUISITO` on deposit, subsequent to `CREATO`. Quote
`Bozza → Nuovo Preventivo → In Trattativa → In Attesa Accettazione → Accettato /
Rifiutato`. All of this is **already in the register** and needs no re-extraction.

**Loss reasons, now concrete.** `PERSO`: non interessato · prezzo alto · sceglie
concorrenza (with a competitor list to pick from) · servizio non adatto.
`ERRATO`: ha già P.Pro · già in contatto · dati inesatti · duplicato da CRM ·
non in target · richiesta inviata per errore · SW house / agenzia marketing /
web agency · test.

**Order types:** `STANDARD` · `BUNDLE` (vendita da palco) · `PLUS` (attivazione
o rinnovo). **Opportunity types:** vendita da tutor · recall tutor · plus.

**Other details not in the notes:** the QR code contains the **campaign member
id**; a WooCommerce order is **invisible to Salesforce until status
`COMPLETATO`**, which administration sets by hand on receiving the bank
transfer; the _Insoluti_ report goes every **Monday to Marco Montesi and
amministrazione**; the "Casi Limite" button is visible **only after an asset is
`Assegnato`**; each event has its **own product code**, with ticket type in the
name (`Camerieri Venditori 26 Gold` / `Silver`).

⚠ The diagram uses a **real customer order as its worked example** —
`SO_Ordine Nr. SO-72216 IT04451990982 - DUOMO 2.0 SRL`, carrying a company name
and VAT number. Keep it out of `notes/`, the recaps and [site/](../site/).
