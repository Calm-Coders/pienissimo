---
id: OI-304
type: open-item
status: in-progress
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: both
raised: 2026-10-30
updated: 2026-11-02
depends_on: []
blocks: [go-live]
severity: gating
source: notes/meetings/2026-10-30 Connessione WooCommerce.md
---

# OI-304 - Contracts for WooCommerce stage sales are not generated

**Customers who buy during a live event order through WooCommerce, and no contract
is produced for them. The existing flows do not generate a paper contract for a
WooCommerce order, and what should be generated depends on what is in the bundle.
The question was too large for the call that raised it and has its own meeting on
2 November.**

## The gap

Fabrizio Paganelli, in [the 30 October WooCommerce call](../meetings/2026-10-30%20Connessione%20WooCommerce.md):
the **paper contract is not automatically generated** for orders placed by
customers buying at live events. Aurel Mrruku confirmed that **the current flows
provide no automatic paper-contract generation for WooCommerce orders at all**,
and that solving it needs a mechanism keyed on **the bundle content** and on **the
order having been sent to Mexal**.

🔑 **These are stage sales — _vendite da palco_.** The customer has already paid
when the order arrives, which is what forces the next decision.

## The decision taken: no signature before the order

> _"L'adozione dello standard per cui i contratti generati da ordini WooCommerce
> **non richiedono la firma digitale preventiva** all'invio dell'ordine, ma
> prevedono **un flag di stato e una reportistica dedicata** per sollecitarne la
> firma."_

Fabrizio Paganelli's ground: the contracts run to **about €20,000**, and customers
buy **on impulse during classroom courses**, so holding the WooCommerce order until
a signature arrives is impracticable. Aurel Mrruku agreed.

🔑 **Two mechanisms are therefore owed and neither exists**: a **status flag** for
whether the contract has been signed, and a **report** to chase the unsigned ones.
⚠ **Neither has a field name, an owner for the report, or a chasing cadence.**

🔑 **Send order, then contract.** Aurel Mrruku and Fabrizio Paganelli agreed the
contract goes to the customer **after** the order reaches Mexal, independently of
minor problems, because the stage customer has already paid.

## Why it is open

1. 🔴 **The generation logic is undefined.** It has to distinguish bundle types —
   annual courses against **Performance Plus** — and that is the whole subject of
   the deferred meeting.
2. ⚠ **A Performance Plus mechanic was named and not pursued.** Aurel Mrruku said
   that generating one line per tranche is **not native to standard bundles** and
   needs specific logic for Performance Plus and its decomposition into multiple
   lines. **Whether that logic already exists was not established** in the call.
3. 🔴 **Unsigned high-value contracts become a standing population at go-live.**
   The decision accepts orders without signatures; without the flag and the report,
   nothing tracks them. **€20,000 a contract.**
4. ⚠ **Paper and electronic are both in scope and not separated.** The next step is
   recorded as defining _"il flusso di generazione e invio dei contratti cartacei e
   informatici"_.
5. ⚠ **No register row covers contract generation for WooCommerce orders.**

## The meeting that owns it

**Monday 2 November 09:30–10:00 CET**, `[ROMI-PIENISSIMO] - Tema Contratti
WooCommerce` — Aurel Mrruku, Elena Spini, Fabrizio Paganelli,
`amministrazione@pienissimo.com` (Gmail `1a18d667b2ed2313`). Scope set by Aurel
Mrruku in Slack at 16:18:30 CET: _"tema contratti per gli ordini da woocomerce (
cntratti cartacei"_.

⚠ **It collides with a second 09:30 invite the same morning** —
`[ROMI-PIENISSIMO] - Allineamento` with Fabrizio Mastracci (Gmail
`1a18d64b1236ad5d`). Both were sent by Elena Spini within two minutes. **Nothing
says which Aurel Mrruku attends.**

## 🟢🔑 2026-11-02 - the meeting happened, and it produced a design

[The 2 November session](../meetings/2026-11-02%20Tema%20Contratti%20WooCommerce.md)
ran 00:49:50 with Aurel Mrruku, Elena Spini, Elisa Migliano and Fabrizio Paganelli.
🔴 **Sabatino Rinaldi was absent.** It answers most of what this row listed as
open.

**The flow, as designed on the call:** WooCommerce order → Salesforce → Mexal; when
**Mexal returns the order id**, Salesforce generates the contract PDF and an
automation sends it through DocuSign; the signed contract comes back and is tracked.
Order statuses are untouched — _"gli stati d'ordine cambiano quando arriva lo
scadenziario"_.

**The build is a second PDF template.** Today generation reads the **Quote**
(_"il PDF si genera … prendendo i dati dalla quot"_); the work is _"un altro
template uguale a quello di prima, però con i puntamenti sull'ordine"_, after
confirming the Order carries every field the template needs. Aurel Mrruku sized it
at _"2 3 4 giorni"_ to build plus testing and a separate production release —
_"stiamo parlando di una settimana"_.

🆕 **A resend button** was added to the design, visible only after a failed send:
_"ti metto forse un pulsante che faccio rinvio solo nel caso in cui c'era un errore
prima"_.

🟢 **The payment-timing question is settled.** The contract goes out on the Mexal
order id, not on the invoice or its payment. Fabrizio Paganelli objected that stage
customers sometimes pay by transfer; **Elisa Migliano closed it** — WooCommerce only
forwards orders in state `completato`, so _"Se ti passa [a Mexal] vuol dire che il
cliente ha già pagato"_. Elena Spini: _"la logica una volta che abbiamo l'ordine di
Mexal può partire"_.

### 🟢 The Performance Plus tranche problem was routed around, not solved

Point 2 above asked whether per-tranche line logic exists for bundles. **It does
not**, and the bundle component will not be changed. Aurel Mrruku described the code
route as _"completamente una logica nuova"_: block further products once a Plus
product is added, read the tranche count, generate and date that many elements.

🟢 **Fabrizio Paganelli proposed twelve bundle-only Plus codes instead — one per
tranche, none carrying a tranche count** — and Aurel Mrruku accepted: _"funziona.
Non devo fare nessun intervento a livello di bundle."_ He then verified on screen,
against the client's existing code **`PLUS_B01`**, that a bundle-true product is
already excluded from the standard Plus offer: _"sui bundle la posso scegliere,
invece su le plus … non la posso scegliere … quindi siamo già coperti."_ **So no
Salesforce change is needed for this part at all.** 🟢 **The twelve codes were
created the same morning** — see
[OI-48](OI-48%20Bundle-only%20article%20codes.md).

🔑 **A hard rule emerged**: there are no mixed bundles. _"in un bundle c'è solo la
P+ … oppure ci sono solo i corsi, non facciamo bundle misti."_

### 🔴 What this row still carries

1. 🔴 **The status flag and the chasing report are unchanged — neither was
   mentioned on the call.** The 30 October decision replaced the signature gate with
   them, and 00:49:50 of design discussion did not come back to either. **Still no
   field name, no report owner, no cadence.** This is now the largest unaddressed
   piece of the item.
2. 🔴 **The release date is unsettled**: Aurel Mrruku offered **19 November**,
   Fabrizio Paganelli pushed for **18**, the decks say _"before Pienissimo Live
   (24-26/11)"_, and the operative deadline is **Monday 23 November**, when the
   bundle for the event must be built.
3. 🔴 **It is Fase 2 work now** — see
   [the decision](../decisions/Decision%20-%20stage%20sale%20contracts%20are%20release%20R0%20of%20Fase%202.md)
   and [the offer](../The%20Fase%202%20offer.md): **R0, 5-7 days.** ⚠ Priced for
   standard courses **and** Performance Plus, while Fabrizio Paganelli agreed
   _"solo per la parte della Plus corsi"_.
4. 🔴 **Nothing is confirmed in writing.** A solution document or blueprint
   addendum is owed to the client on **Wednesday 4 November**.
5. ⚠ **Paper and electronic are still not separated.** The call used _"contratto
   cartaceo"_, _"file PDF"_ and _"contratto informatico"_ interchangeably; for
   Performance Plus Fabrizio Paganelli asked for both — _"sia il PDF che nel caso
   della Plus generare il contratto informatico"_. **No definition was given.**
6. ⚠ **Whether Performance Plus is even sold at the 24-26 November event is
   unknown** — _"lo scopriremo il 24 di novembre la mattina"_ — so the deadline is
   being met for a case that may not arise, and would be missed if it does.
7. 🟢 **The 30 October ambiguity about which 09:30 meeting Aurel Mrruku attended is
   resolved**: this one.

⚠ **No register row covers it still**, and 🔑 **the €20,000 figure was not repeated
on the call** — it rests on the 30 October record alone.
