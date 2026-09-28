---
id: meeting-2026-09-18-interna-temi-mexal
type: meeting
status: resolved
owner: Elena Spini
org: ROMI
raised: 2026-09-18
updated: 2026-09-21
source: Drive transcript doc 1KXc9rcSxq5flHzw6TBgTSIU9tu3K0yBMUi5K081oeUA (read in full)
---

# 2026-09-18 Interna Temi Mexal

**ROMI only, 31m07s, 18/09 10:01 CEST.** Elena Spini and Aurel Mrruku.

⚠ **The title is a placeholder that was never corrected.** The invitation began
as `[PIENISSIMO] - PLACEHOLDER - Interna Mexal`; the session itself is about the
**UAT calendar and the contract documents**, not Mexal. Only a transcript exists —
no Gemini notes were generated.

## What it settled

- **The UAT calendar was drafted here**, and Elena Spini discovered the 29
  September clash with the Food Marketing Festival while drafting it.
- 🔴 **The internal deadline is 23 September** — _"deve essere pronto entro il
  23"_, ideally at least the lead and opportunity area. Aurel Mrruku: _"sto
  facendo tutto il possibile"_, and _"tutto è legato alle opportunità"_.
- 🔴 **Aurel Mrruku does not understand the Performance Plus flow** — _"la parte
  dei plus non mi è chiaro"_ — and it is one of the cases to be tested. Placed in
  the 5 October session, retitled in-session to **`Performance Plus + Gestione
  date pagamento`** at his request, so that the subject is explicitly the division
  of one Performance Plus product across several payment dates.
- 🔑 **Only two documents are generated**, and Aurel Mrruku has built them as
  `preventivo plus` and `preventivo normale`. The confusion is terminological:
  the client calls the contract section embedded in the quote *"contratto"*, while
  `Contract` is also the Salesforce object for the plus flow
  ([OI-141](../items/OI-141%20Contract%20object%20for%20Performance%20Plus%20orders.md)).
  Aurel Mrruku: **_"mi serve capire che cavolo è, quando viene generato, chi lo
  deve generare, cosa il contenuto"_** about the
  `CONTRATTI PIENISSIMO PER TIPOLOGIE DI ORDINI` material. Elena Spini undertook
  to review it and give him the breakdown. ✅ **She delivered it on 21/09 19:34
  CEST by DM** — see
  [OI-151](../items/OI-151%20Quote%20signature%20step%20before%20the%20order%20is%20generated.md).
  She also forwarded the source mail at 18/09 08:14:14Z.
- ⚠ **If they are two distinct documents the DocuSign signature flow has to be
  reworked** — _"se sono due documenti differenti poi da capire con [Docu]Sign
  devo rigestire il flusso di firma"_.

## Findings

- 🔴 🔑 **There is no true UAT environment.** Aurel Mrruku: **_"noi non ce
  l'abbiamo un ambiente di UAT vero e proprio. Noi abbiamo un ambiente di partial
  e produzione, non abbiamo una full."_** Everything the plan and the client-facing
  calendar call "UAT" runs in a **Partial Copy sandbox**.
  → [OI-153](../items/OI-153%20There%20is%20no%20full%20UAT%20sandbox.md)
- 🔴 **Credit notes and storni are unstarted and undefined.** Aurel Mrruku: _"Note
  di credito, non ho manco iniziato a farle"_ and _"non mi è proprio chiaro come
  verrà gestita la nota di credito"_. Elena Spini considered dropping them from
  the calendar as an edge case, and the 6 October invitation went out titled only
  `Integrazione Mexal ↔ Salesforce`.
  → [OI-157](../items/OI-157%20Credit%20notes%20and%20storni%20are%20unbuilt%20and%20undefined.md)
- 🔑 **The `aggiornamento incasso` button proposal was dropped.** Elena Spini's
  earlier design — a button on the Asset, visible only once the asset is
  available and **only to amministrazione users**, to correct an incasso booked
  against the wrong tranche — was abandoned in this session. Aurel Mrruku objected
  that the asset is not always a product (Performance Plus is one product paid in
  x instalments, so there may be no asset) and that the asset hangs off the offer,
  not the order. Elena Spini: _"lo lascerei… se lo devono fare a mano, cioè
  punto"_, and _"lo lascio perdere, lo cancello"_. Stated frequency: **20–30 times
  a year**. → this is the same unserved need
  [OI-136](../items/OI-136%20Public%20participant%20link%20can%20mark%20an%20order%20Incassato.md)
  records; it was scoped once and set aside **without a client decision**.
- 🔴 **Aurel Mrruku needs a final record list** (accounts, customers, products)
  and **at least a couple of days** to load it, plus a cleanup of his own test
  junk in the sandbox first.
- ⚠ **The blueprint document rests on unvalidated personal notes.** Aurel Mrruku
  sent Elena Spini a functional map — _"Ho fatto solo la parte funzionale. Niente
  di tecnico"_ — and warned her explicitly: **_"questi sono appunti miei personali
  che ho fatto durante il tempo"_**, go point by point, do not take it as given,
  and delete the test-environment open points. Elena Spini intends to turn it into
  **a document shared with the client**. She also noted the timing problem
  herself: _"non esiste che arrivo a un giorno, due giorni dagli UAT a dare il
  documento, ma non avevo il tempo di farlo"_.
- Elena Spini raised the Zucchetti precedent — a component by a colleague that
  lets a user pick several PDFs and merges them into one — as a possible pattern
  for the multi-document quote. Not a decision.
