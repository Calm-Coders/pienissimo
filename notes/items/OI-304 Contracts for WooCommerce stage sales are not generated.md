---
id: OI-304
type: open-item
status: in-progress
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: both
raised: 2026-10-30
updated: 2026-11-03
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

## 🟢🔑 2026-11-03 - it is specified in writing, a day early, and the scope question is answered

[The functional analysis](../The%20stage%20sale%20contract%20functional%20analysis.md)
went to Fabrizio Paganelli, `amministrazione@pienissimo.com` and Sabatino Rinaldi at
**18:00:14Z** (Gmail `1a1a291d143128a7`), cc Aurel Mrruku — **one day before the
Wednesday 4 November deadline point 4 above recorded.** It was drafted line by line in
[the internal follow-up](../meetings/2026-11-03%20Follow-up%20Interno.md), 00:36:20,
ending twenty-five minutes before it was sent.

🟢 **Point 5 is answered. Paper and electronic are now separated.** `contratto
informatico` is **the Salesforce Contract record**, as against the PDF, and it applies
**to Performance Plus only** — **RF7**. Aurel Mrruku: _"sia il contratto informatico
che lo chiama lui, quindi il record del contratto, che il PDF."_

🟢🔑 **The point 3 scope worry is retired.** Aurel Mrruku opened the drafting session
believing only Plus generates a contract, Elena Spini challenged it, and **he checked
the 2 November transcript himself**: _"il contratto lo vuole per tutte le vendite da
palco, quindi sia per i corsi sia per la plus."_ **So the pricing of courses and Plus
in both decks matches the agreement.** Fabrizio Paganelli's _"solo per la parte della
Plus corsi"_ did not narrow it.

🟢 **Point 2 is closed too** — the twelve bundle-only codes exist and **RF5** records
them. ⚠ But the document still lists _"Fabrizio: creazione dei 12 codici articolo Plus
su Mexal"_ as an outstanding client dependency, which is stale by a day.

🆕 **Dates, now written**: Pienissimo confirms **by 05/11** · development **week of
09/11** · joint tests **week of 16/11** · **release 18 or 19/11** · final check and
event bundle **23/11** · Pienissimo Live **24-26/11**. 🔑 **Explicitly outside the
16 November go-live** — _"Aurel non vuole rischiare la parte già in produzione."_ This
settles point 2 of the previous section: **18 or 19 November, with OP-4 asking the
client to pick.**

🆕 **A new meeting**: **Thursday 5 November 12:00-12:30**, a Fase 2 recap _"compreso
questo primo rilascio, così chiudiamo insieme gli Open Point"_.

### 🟢 Point 1 — the status flag finally has an owner and a date

**OP-2 of the document**: _"Tracciamento della firma sull'ordine: stato o flag, e dove
si salva il PDF firmato (in Fase 1 sul preventivo, con stato Firmato)"_ — owner
**Fabrizio Paganelli**, due **05/11**.

🔑 **It was pushed to the client on purpose.** Aurel Mrruku: _"non ce l'hai uno status
la firma sull'ordine … dobbiamo fare un flag in qualche modo che ti dice che è
firmato."_ Elena Spini: _"Qua gli lasciamo l'open point, ci faranno sapere … cacchio
ce ne dobbiamo fare noi, ce lo dobbiamo dire loro."_

### 🔴 And the chasing report was deleted, not forgotten

🔑 **This corrects the 2 November reading.** The draft carried _"Cliente che non firma
… solleciti senza blocchi"_ as Open Point 5. **Aurel Mrruku had it struck out**:
_"toglili pure di tutto che poi là non finiamo mai"_. Elena Spini deleted the row.

🔴 **So the report half of the 30 October decision is now explicitly out of scope, and
the client has never been told it was ever in.** The unsigned-contract population the
decision creates still has nothing tracking it.

### 🔴 Three pieces of scope were left out of the document

All three were discussed in drafting and deliberately or silently omitted:

1. **The product check in RF1** — Aurel Mrruku: _"non tutti i prodotti che arrivano da
   WooCommerce devono generare un contratto."_ Elena Spini noted its absence and sent
   it anyway.
2. **Two templates, not one** →
   [OI-326](OI-326%20A%20second%20PDF%20template%20is%20needed%20for%20corsi%20and%20for%20Plus.md).
   The open point was removed because it had never been raised with the client.
3. **The DocuSign return trigger rewiring** →
   [OI-322](OI-322%20The%20DocuSign%20return%20trigger%20only%20handles%20quotes%20not%20orders.md),
   plus the bundle classification →
   [OI-328](OI-328%20A%20bundle%20containing%20a%20Plus%20product%20must%20be%20flagged%20as%20a%20Plus%20bundle.md).

🔴🔑 **And R0 is sized at 6-7 days — _"diciamo 7 giorni alla fine"_ — for all of it.**
Aurel Mrruku: _"Ho la paura che abbiamo messo davvero poche giornate … Sai quanto
mettevo per un template? da 10 a 15 giorni."_ Elena Spini: _"non posso chiedere più i
giorni, mi sa che già m'ammazzano."_ ⚠ **And he is alone on it** — _"Regina su un
progetto, Ana e Sara su un altro … e il lavoro lo devo fare io"_ (names as
transcribed, uncertain).

🟢 **One thing already exists**: the resend button, _"ce l'abbiamo già sull'ordine"_.
⚠ Positioned on order creation/send rather than PDF generation, because without the
Mexal id no PDF exists.

### ⚠ The payment-timing claim was withdrawn

🔑 **Aurel Mrruku struck Elisa Migliano's 2 November statement from the draft.** Elena
Spini had written that if the order reaches Mexal the customer has paid; he refused it:
_"Non è detto … **Noi non ce l'abbiamo l'informazione** … lo sappiamo a mezzanotte"_,
and _"il punto due non mi piace per niente"_.

**The order-state rule stands** — WooCommerce forwards only `completato`, card orders
complete immediately, **transfers sit in `Sospeso` until amministrazione confirms** —
but ROMI does not hold the payment fact. ⚠ The document marks the unconfirmed-transfer
case **_"Dedotto, da confermare"_** even though Aurel Mrruku said _"corretto"_ in
drafting.

### ⚠ And the Anticipay edge case is now the normal path

The document records, as _"Dedotto, da confermare"_: a failed P.IVA check sends the
Fase 1 mail to amministrazione, **the order reaches Mexal anyway and the contract is
generated**. Aurel Mrruku confirmed the mechanics on
[the e2e call](../meetings/2026-11-03%20Test%20e2e%20PROD.md) the same morning —
and 🔴 **Anticipay times out in production**
([OI-312](OI-312%20Anticipay%20times%20out%20in%20production.md)), so the failure branch
is what actually happens today, not an edge case. ⚠ Elena Spini named the consequence
and nobody answered it: a contract going out with a wrong P.IVA. _"È un caso limite,
però devono saperlo."_
