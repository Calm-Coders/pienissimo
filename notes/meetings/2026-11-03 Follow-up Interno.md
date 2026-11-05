---
id: meeting-2026-11-03-follow-up-interno
type: meeting
status: resolved
owner: Elena Spini
org: ROMI
raised: 2026-11-03
updated: 2026-11-03
depends_on: [OI-304]
blocks: []
source: meetings/2026-11-03-follow-up-interno-transcript.it.md
---

# 2026-11-03 - Follow-up Interno

**ROMI-internal, 00:36:20, Aurel Mrruku and Elena Spini alone. They drafted the
stage-sale contract analysis line by line and sent it to the client twenty-five
minutes later. The value of this transcript is that it records what was deliberately
left out of the document, and Aurel Mrruku's own view that the days are badly
short.**

## Attendees

- **Aurel Mrruku** (ROMI)
- **Elena Spini** (ROMI)

No client present. 🔑 **This is a drafting session**, not a decision meeting — Elena
Spini read the draft aloud clause by clause and Aurel Mrruku corrected it.

## Sources

**Sources:** [meetings/2026-11-03-follow-up-interno-transcript.it.md](../../meetings/2026-11-03-follow-up-interno-transcript.it.md)
(00:36:20, read in full). ⚠ **No Gemini notes document exists for this session** —
only the transcript. The output is
[the functional analysis](../The%20stage%20sale%20contract%20functional%20analysis.md),
sent at 18:00:14Z.

## 🟢🔑 The scope question of 2 November is answered: the contract covers everything

Aurel Mrruku opened believing only Performance Plus products generate a contract —
_"i prodotti che sono plus devono poter generare un contratto"_. **Elena Spini
challenged it and he checked the 2 November transcript himself**, then conceded:

> _"il contratto lo vuole per tutte le vendite da palco, quindi sia per i corsi sia
> per la plus … lo dice nella trascrizione del 2 novembre"_

and

> _"chiaramente quando facciamo le vendite da palco si deve sempre generare il
> contratto perché comunque sia anche se sono pacchetti piccolini"_

🔑 **This closes the open question carried on
[OI-304](../items/OI-304%20Contracts%20for%20WooCommerce%20stage%20sales%20are%20not%20generated.md)
and in the 2 November trace** — whether Fabrizio Paganelli's _"solo per la parte
della Plus corsi"_ narrowed the scope below what both decks price. **It does not.**
Every WooCommerce stage order generates a PDF contract; **Performance Plus
additionally gets the Contract record.**

🔑 **`contratto informatico` is defined at last**: it is **the Contract record in
Salesforce**, as distinct from the PDF. Aurel Mrruku: _"sia il contratto informatico
che lo chiama lui, quindi il record del contratto, che il PDF."_ It became **RF7**.

## 🔴 What was deliberately removed from the document before it went to the client

🔑 **This is the reason to keep this transcript.**

1. 🔴 **The product check.** Aurel Mrruku: the flow must also test the product,
   because _"non tutti i prodotti che arrivano da Wcommerce devono generare un
   contratto"_. Elena Spini noted it plainly: _"questa cosa del controllo dei
   prodotti non c'è"_ — **and the document went out without it.**
2. 🔴 **The two-template requirement.** Elena Spini raised _"un template o due,
   corsi e plus"_; Aurel Mrruku confirmed **two** and protested the doubling of
   work. Elena Spini then **cut the open point**: _"non ce l'ho mai parlato di un
   template diverso, io lo toglierei proprio"_. Aurel Mrruku: _"toglio."_
   → [OI-323 is the domain item; the template item is OI-322's sibling](../items/OI-326%20A%20second%20PDF%20template%20is%20needed%20for%20corsi%20and%20for%20Plus.md)
3. 🔴 **The chasing mechanism — _solleciti_.** The draft carried _"Cliente che non
   firma … solleciti senza blocchi"_ as Open Point 5. Aurel Mrruku: _"toglili pure
   di tutto che poi là non finiamo mai"_. Elena Spini deleted the row.
   🔑 **So the 30 October decision's chasing report was not forgotten on 2 November —
   it was raised on 3 November and struck out.** That is a sharper fact than "never
   mentioned again".
4. **The system numbering row**, also deleted.
5. 🔑 **The claim that reaching Mexal means the customer has paid.** Elena Spini had
   written it from Elisa Migliano's 2 November statement. **Aurel Mrruku rejected
   it**: _"Non è detto … Noi non ce l'abbiamo l'informazione … lo sappiamo a
   mezzanotte"_, and _"il punto due non mi piace per niente"_. Elena Spini: _"Lo devo
   togliere."_
   ⚠ **This qualifies the 2 November record**, which called payment timing "settled".
   The order-state rule stands; **ROMI does not hold the payment fact, and learns it
   at midnight.**

## 🔴 Aurel Mrruku's technical objections, none of which are in the document

### The DocuSign return path has to be rewired

Today a trigger fires when a signed document arrives, finds the Opportunity and the
Quote, and sets the quote to `Firmata`. **For an order there is never a Quote.**

> _"ogni volta che ci arriva un documento da DocuSign dobbiamo capire se quel
> documento fa parte a un ordine oppure fa parte di una quota. E qua sarà un bagno di
> sangue perché non l'ho mai fatto, ho sempre usato le quote"_

🟢 **A narrow escape**: _"meno male che non abbiamo usato il preventivo standard
perché sta cosa non veniva poi gestita, perché il preventivo standard si fa solo con
le quote."_

🔑 **The signature trigger point also moves** — _"firma prima scattava quando tu
facevi accettato, quindi dobbiamo intervenire anche su quando invia il documento"_ —
which is why flow rows 7 and 8 were reworded to _"momento in cui scatta la firma
elettronica"_ and _"momento in cui il PDF firmato torna su Salesforce"_.
→ [OI-322](../items/OI-322%20The%20DocuSign%20return%20trigger%20only%20handles%20quotes%20not%20orders.md)

### The new template cannot be a copy

Every dynamic pointer in the existing template resolves against the **Quote**, and
the Order does not carry the same fields — _"la nota che è sul preventivo non vale
perché non la trova"_.

> _"Devi prendere il contenuto di quello che c'è e devi cambiare tutti i puntamenti
> dinamici"_ — _"va creato nuovo, non è manco modificato quello che c'è"_

🔑 **Aurel Mrruku has not started**: _"tutti quei campi non ho fatto niente. Devo dire
ai ragazzi … che vogliamo fare il template sugli ordini, cosa ci dobbiamo
tracciare."_ That is **OP-1** of the delivered document, owner Aurel Mrruku, due
**5 November**.

### A bundle must learn that it is a Plus bundle

To pick the right template the order must be classifiable. Aurel Mrruku will do it
**automatically, not by asking Fabrizio Paganelli**: _"se un bundle ha un prodotto
plus, allora è un bundle plus"_, _"lo metto in automatico, non dico manco di farlo"_.
⚠ **And it reaches into existing code** — _"devo mettere mano anche su la [logica]
del bundle"_.
→ [OI-328](../items/OI-328%20A%20bundle%20containing%20a%20Plus%20product%20must%20be%20flagged%20as%20a%20Plus%20bundle.md)

### 🟢 One thing already exists

The **resend button**: _"ce l'abbiamo già sull'ordine"_. ⚠ It is positioned on
**order creation/send**, not on PDF generation, because without the Mexal id no PDF
is generated at all — Elena Spini moved it in the flow table accordingly.

## 🔴🔑 The estimate is short, and both of them know it

> **Aurel Mrruku:** _"Ho la paura che abbiamo messo davvero poche giornate … Sai
> quanto mettevo per un template? **da 10 a 15 giorni**."_ With AI, _"2-3 giorni solo
> col template"_.

> **Elena Spini:** _"E non posso chiedere più i giorni, mi sa che già m'ammazzano."_

They settled on **6-7 days, "diciamo 7 giorni alla fine"**, against a scope that now
includes a new template built from scratch, a rewired DocuSign return path, a bundle
classification, a signature status, and a resend button.

🔑 **Neither the two-template need nor the DocuSign rewiring is priced in the
document the client received.**

## 🔴 ROMI has no one else on this

> _"c'ho un sacco di progetti che sono partiti adesso. Eh, Regina su un progetto, Ana
> e Sara su un altro che durerà tipo 6-7 mesi **e il lavoro lo devo fare io**. Amen."_

⚠ **Names as transcribed** — "Regina" and "Ana" are almost certainly **Rexhina Hysi**
and **Anita Aga**, but the transcript garbles names throughout and this is **marked
uncertain**. ⚠ It also sits oddly against the e2e session, where Aurel Mrruku said a
record-type fix _"la sta facendo Ana"_ on Pienissimo the same morning.

🔑 **Read with the 7-day R0 estimate, this is the staffing risk on the release.**

## 🔑 The Fase 2 day-count discrepancy is known to them and unresolved

> **Aurel Mrruku:** _"Sai cosa faranno qua? Metteranno una media o il 58?"_
> **Elena Spini:** _"mi sa che poi lui ha detto la media … lo scopriremo."_

⚠ So the **150 giornate** in the offer against **58-78** in the plan is not an
oversight nobody noticed — **ROMI is aware and waiting to be told.** Aurel Mrruku:
_"è un bagno di sangue."_

## 🔑 Open Point 2 was pushed to the client on purpose

On the signature status, Aurel Mrruku: _"non ce l'hai uno status la firma
sull'ordine … dobbiamo fare un flag in qualche modo che ti dice che è firmato."_
Elena Spini decided not to answer it:

> _"Qua gli lasciamo l'open point, ci faranno sapere … cacchio ce ne dobbiamo fare
> noi, ce lo dobbiamo dire loro."_

🔑 **So OP-2 is deliberately the client's to answer, by 5 November, owner Fabrizio
Paganelli.** That is the first time the 30 October status-flag question has had an
owner and a date.

## 🆕 Dates fixed here

- **Confirmation from Pienissimo by Thursday 5 November** — negotiated down from
  Aurel Mrruku's _"servono tipo 6-7 giorni"_ to Elena Spini's five, on the e2e call
  that morning and held to here.
- **Elena Spini sent the document the same evening** — _"Stasera tanto glielo
  mando"_, then _"me lo mando subito"_. It went at **18:00:14Z**.
- **Tomorrow's e2e continuation capped at 1.5 hours from 14:30**, on Aurel Mrruku's
  insistence: _"Lascia un'ora te che so che durerà. Se lasci un'ora diventa fa due.
  Se fai due fa quattro."_ Elena Spini: _"faccio un'ora e mezza"_. ⚠ Elena Spini does
  not expect to attend.

## Related

- [The stage sale contract functional analysis](../The%20stage%20sale%20contract%20functional%20analysis.md) — the output
- [2026-11-03 Test e2e PROD](2026-11-03%20Test%20e2e%20PROD.md) — the same morning
- [2026-11-02 Tema Contratti WooCommerce](2026-11-02%20Tema%20Contratti%20WooCommerce.md) — the source it was drafted from
- [Decision - stage sale contracts are release R0 of Fase 2](../decisions/Decision%20-%20stage%20sale%20contracts%20are%20release%20R0%20of%20Fase%202.md)
