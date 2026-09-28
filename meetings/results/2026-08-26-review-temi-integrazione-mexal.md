# [ROMI-PIENISSIMO] Review Temi Integrazione Mexal — 2026-08-26

**Sources:** [meetings/2026-08-26-review-temi-integrazione-mexal-transcript.it.md](../2026-08-26-review-temi-integrazione-mexal-transcript.it.md) (original Italian transcript, Google Meet + Gemini notes, **1h25m45s**) · [recording](https://drive.google.com/file/d/1UUpEzSVzPVlXBXrN7HPGvXYp-2NBEfUG/view) · [notes & transcript](https://docs.google.com/document/d/1f_8YVWSssMOcmk9XRmI2en0aqUGFRG2Bk1vnLItt3zU/edit) · found by the nightly `requirements-check` sweep of 2026-08-26

**Attendees:** ROMI — Elena Spini (chair, **left at ~01:02**), Aurel Mrruku, Andrea Di Cicco. Pienissimo — Fabrizio Paganelli (product registry / Mexal), Elisa Migliano (`amministrazione@`).
**Not present:** Sabatino Rinaldi was on the invitation and **never speaks** in the transcript.

> **Attribution caveat.** Speaker labels in this project are chronically unreliable; in this transcript they are unusually clean and the technical exchanges are clearly separated. This recap follows the transcript, with the Gemini summary used only for cross-checking. Where the two differ, the transcript governs. The auto-summary is accurate here but thinner — it omits the two-code rule, the abandoned combination scheme, and the fact that the one-active-child campaign rule was killed.

> **Context:** the first Mexal session since **14 July**, and the meeting [OI-58](../../notes/items/OI-58%20Mexal%20integration%20mechanics.md) had been waiting for. Client-facing. Fabrizio Paganelli is **out of office in the days following** and takes the article-registry proposal to Pienissimo's direction on **Monday 31 August**.

---

## The headline

🔴 **The event edition is assigned by a new, hand-maintained Salesforce table keyed on order date — and this replaces the "one active child campaign" rule agreed on 24 August.**

One row per `article code × data inizio × data fine → edizione`, plus a separate hand-entered **event date** in column G. At order time each **order line** is matched on the **order date** against its article's window and takes the edition from the matching row.

Tracked as [OI-96](../../notes/items/OI-96%20Edition%20mapping%20table%20on%20Salesforce.md). Filed by Gemini under **"Da approfondire"** — the only item there — because Aurel Mrruku asked for a dedicated hour of worked examples before anything is built. **That session is not scheduled.**

---

## Decisions

### 1. The three Mexal classification fields are assigned, and tested on the wire

Fabrizio Paganelli opened with the constraint: **the Mexal article registry has at most three fields for classifying a product**, none of them currently in use — _"siamo liberissimi di fare come è più comodo per noi."_ Each assignment below was verified during the call, Fabrizio Paganelli editing in Mexal while Andrea Di Cicco watched the API response change.

| Mexal field | API name | Carries | Verified |
| --- | --- | --- | --- |
| `natura` | `COD_Natura` | **genera biglietto sì/no** | ✅ value set on `CS_00154` (Happy Team), seen over the API |
| `categoria statistica` | `Sigla cat sta` + `Numero cat sta` | **the event** (Campagna Padre) | ✅ `C01` then `P02` observed. **Splits into two API fields** |
| `gruppo merceologico` | `GRP merch` | candidate for **tipo biglietto** | ⚠ hierarchical in Mexal; **only the code came over, not the level** |
| `Gest. annullato` (technical, 4th) | `Gest. annullato` — `n`/`S` | **product disabled in Salesforce** | ✅ `CS58` cancelled and restored live |

`natura` resolves against a managed base table, **not free text** — Fabrizio Paganelli: _"non posso metterci dentro Pippo."_ That answers Andrea Di Cicco's first objection, that anyone could type anything.

⚠ **The values themselves are not chosen.** Fabrizio Paganelli takes the whole scheme to direction on 31 August.

### 2. Obsolete products are disabled via `Gest. annullato`, with a known manual cost

~**1000 legacy article codes** exist and tutors pick from them. Mexal's `annulla/ripristina` button sets the flag; the integration maps it to an inactive flag on `Product2`; the product stops being selectable.

**Tested against a real invoice**: `CS58` (Food Marketing Festival Gold) was cancelled while an issued invoice referenced it, the invoice was reopened, and the line was still there. Both test articles were restored before the session ended.

⚠ **Elisa Migliano supplied the failure mode from live experience** — tutors have quoted a code while administration cancelled it underneath, the quote then failed to pass to Mexal, and it was fixed by hand. Andrea Di Cicco confirmed Salesforce behaves identically: a disabled product **cannot be re-selected by anyone, master and administration users included**, but an existing order line can be edited to swap in the replacement code. Both accepted that.

History stays reportable — _"tu puoi rivedere tutto lo storico… però non lo puoi selezionare per la vendita."_

### 3. A ticket-generating article and its bundle twin are two distinct codes

Aurel Mrruku: _"devi per forza avere due prodotti, non lo puoi fare un unico prodotto."_ Fabrizio Paganelli named the convention: _"se un codice articolo è visibile, se non è il bundle, avrà il codice A. L'altro codice che è visibile a tutor avrà il codice B."_

⚠ **This reverses the 24 August reading in [OI-48](../../notes/items/OI-48%20Bundle-only%20article%20codes.md)** that `Product2.Solo_Bundle__c` makes twin codes unnecessary. The flag marks which is which; it does not remove the twin.

### 4. Multi-edition bundles of the same article are out of scope

Andrea Di Cicco raised the limitation the date-window design imposes: a bundle selling the **same** event across 2026, 2027 and 2028 in one order cannot be resolved, because every line shares one order date. Fabrizio Paganelli: _"questa qui è una cosa che non facciamo. Non facciamo."_

⚠ Read this narrowly. **Different** articles with **different** windows do split across editions in one order — that is the design.

### 5. The no-show goodwill ticket must be linked to the next child campaign

A good customer who misses an event is manually reassigned a complimentary ticket for the next edition. Aurel Mrruku added the consequence: the reassigned Asset must **also be linked to the next Campagna Figlio by hand**, _"altrimenti… il reminder se non si presenta non scatta più."_ Elena Spini agreed — _"altra casistica aggiunta"_ — immediately before leaving. **There is no control that catches an unlinked reassignment.**

### 6. Invoicing stays piloted by Mexal for roughly six months

Andrea Di Cicco had found the JSON to create an invoice from Salesforce. Fabrizio Paganelli declined: _"per il momento preferisco che venga pilotata solo da Mexal la fatturazione"_, revisiting _"tra 6 mesi quando entreremo a regime."_ Salesforce reads invoices; it does not create them.

### 7. Only listino 1 is used

_"usiamo solo l'uno."_ Products carry two price lists; only the first is in use. **This closes a question open since July**, deferred by Mirko Merendi to Fabrizio Paganelli.

---

## Action Items

| # | Action | Owner | Due |
| - | ------ | ----- | --- |
| 1 | Take the classification scheme to Pienissimo's direction; revise and send the full article registry | Fabrizio Paganelli | Direction **Mon 31 Aug**; registry "next week" |
| 2 | Configure two test articles carrying the new flags (bundle visibility, ticket generation) | Fabrizio Paganelli | Next week |
| 3 | Map Mexal `Gest. annullato` to the inactive/disabled flag on Salesforce | Andrea Di Cicco | — |
| 4 | Hold a dedicated working session on order-line → campaign/edition mapping, with concrete examples | the group | ⚠ **not scheduled** |
| 5 | Deep-map the customer registry — categoria provvigioni, condizioni documenti di magazzino, prealimented order fields, and **Mexal's coded-value dictionaries** | Fabrizio Paganelli, Andrea Di Cicco, Aurel Mrruku, Elisa Migliano | 🟢 **2 Sept 10:00–11:30 CEST**, booked by Elena Spini the same evening — [OI-99](../../notes/items/OI-99%20Customer%20registry%20deep%20mapping%20session.md) |
| 6 | Send the created test customer IDs to Fabrizio Paganelli **and** `amministrazione@` for verification | Andrea Di Cicco | Immediately after the call |

---

## Open Questions / Risks

- 🔴 **[OI-92](../../notes/items/OI-92%20Mexal%20Scadenziario%20as%20the%20trigger%20to%20reverse%20an%20asset.md) was never raised.** The scadenziario question — can an *unpaid* invoice drive an Asset backwards? — was minuted on 20 August as an action for this forum, with its proposer (Fabrizio Paganelli) and its owner (Andrea Di Cicco) both in the room. **The word does not appear once in the transcript.** It now has no scheduled forum.
- 🔴 **[OI-98](../../notes/items/OI-98%20The%20Mexal%20article%20registry%20is%20being%20re-created.md) — Fabrizio Paganelli intends to close every current article code and mint new ones**, probably alongside a price-list revision. It renders `Prodotti e Bundle.xlsx`, the event list, the tier evidence and the 280 `Product2` rows in UAT provisional. **Nobody connected it to the 10 September end of Fase 1 development.**
- 🔴 **There is still no Mexal test environment.** Customer `501.08721` and order `OC11` were created **in production**, on serie 10 — _"purtroppo solamente in produzione posso fare i test."_ The test-company ask still has no owner.
- 🔴 **`tipo nazionalità` is mandatory and undocumented.** It is *residenza fiscale*: Italia / San Marino / Città del Vaticano / UE / extra-UE, driving invoice transmission to the San Marino *ufficio tributario*. Whether Salesforce carries or derives it is undecided — [OI-97](../../notes/items/OI-97%20Fiscal%20residence%20on%20the%20customer%20registry.md).
- ⚠ **The Mexal API documentation is incomplete** — _"tutti sti campi non c'erano sulla documentazione."_ `valuta` was set to `1` by trial and **nobody knows whether 1 is euro**.
- ⚠ **Ticket type has two live answers.** The 20 August client minute says a Salesforce-only field; this session put `gruppo merceologico` back on the table without retracting it, and ended on _"facciamo una prova"_ rather than a decision. The tiers themselves are settled: **Executive, Gold, Diamond** — Fabrizio Paganelli said them out loud, matching the registry. `Silver` and `Dinamond` are both dead.
- ⚠ **The four-value encoding scheme was proposed and abandoned mid-discussion.** Aurel Mrruku floated packing two booleans into `natura`, backed off when ticket type turned out to have three values, and Andrea Di Cicco called it _"un po' complicato"_. **Do not build against it.**
- ⚠ **Unanswered on the call:** the one-to-many relationship between a tranche and Mexal's order-row identifiers. Aurel Mrruku — _"mi devi spiegare sta roba"_ — got no answer before the end. Bears on [OI-50](../../notes/items/OI-50%20Tranche%20object.md).
- ⚠ **The master design file is now stale on campaigns.** `Flows & Objects.drawio` still carries _"Sulle campagne figlie deve esserci logica solo una campagna attiva"_ and the manual product→parent-campaign lookup, both superseded here — see [the newest design diagram](../../notes/The%20newest%20design%20diagram.md).

---

## Notes

- The session was **entirely hands-on**: Fabrizio Paganelli editing Mexal live, Andrea Di Cicco diffing API JSON responses in real time, Aurel Mrruku following in the Postman collection. Every field assignment above was proved rather than assumed.
- **Mexal WEBAPI access demonstrably works.** Andrea Di Cicco read the registry and created both a customer and an order against production during the call. Whatever the record says about credentials still being owed, nobody mentioned them and the access is real.
- Order `OC11` shows Mexal status `S` (*sospeso*); Fabrizio Paganelli confirmed that is normal and flips on transformation to invoice.
- Andrea Di Cicco built his customer-payload mapping from **the fields Pienissimo currently shares with Zoho**, and expects fields on each side the other needs. That is the gap [OI-99](../../notes/items/OI-99%20Customer%20registry%20deep%20mapping%20session.md) exists to close.
- **The Slack aftermath, same evening**, in the ROMI group DM, is sharper than the call. Andrea Di Cicco's verdict at 18:02 CEST: _"le integrazioni per ordini e clienti funzionicchiano"_ — they sort of work. At 18:16 he generalised the documentation problem: 🔴 _"loro hanno dei valori che sono tipo per valuta: 1,2,3,4 — che lato nostro non sappiamo"_ and _"dobbiamo vedere che poi tutti i dati anagrafici arrivano per la fattura"_. **Mexal's coded-value dictionaries are unknown to ROMI as a class**, not just for `valuta`, and he had already asked for them by email without reply. Elena Spini booked the follow-up at 18:30 and the invitation went out at 16:40 UTC.
