---
id: meeting-2026-11-03-test-e2e-prod
type: meeting
status: resolved
owner: Aurel Mrruku
org: both
raised: 2026-11-03
updated: 2026-11-03
depends_on: []
blocks: [go-live]
source: meetings/2026-11-03-test-e2e-prod-transcript.it.md
---

# 2026-11-03 - Test e2e PROD

**The first end-to-end test run in the production org with the client. 02:49:39 —
the longest session in the project record. The whole chain worked: quote → DocuSign
→ signed → Salesforce order → Mexal order → invoice → customer created → invoice
synced back unpaid. Everything around the chain did not: Anticipay times out in
production, the UAT mappings cannot be moved, test records cannot be deleted, and
Fabrizio Paganelli's verdict was _"anche oggi mancava la metà delle robe"_.**

## Attendees

- **Aurel Mrruku** (ROMI) — left before the end, _"devo andare per forza perché c'è
  un'altra call"_
- **Elena Spini** (ROMI)
- **Fabrizio Paganelli** (Pienissimo) — **joined ~25 minutes late**; he had
  forgotten the call: _"mi sono dimenticato"_
- 🔴 **Sabatino Rinaldi** — invited optional, absent. ⚠ Elena Spini: _"Sabatino in
  realtà non serve"_
- 🔴 **Elisa Migliano** — invited optional, could not join: _"Elisa adesso deve
  andar via"_

⚠ **Speaker labels are unreliable as usual.** Fabrizio Paganelli greeted Aurel
Mrruku as _"Ciao Marco"_ and corrected himself. Attribution below is reconstructed
from content.

🔑 **The Gemini auto-notes for this session contradict the transcript in at least
two places** — see [Where the auto-notes are wrong](#where-the-auto-notes-are-wrong).

## Sources

**Sources:** [meetings/2026-11-03-test-e2e-prod-transcript.it.md](../../meetings/2026-11-03-test-e2e-prod-transcript.it.md)
(02:49:39, ~129 KB, read in full in five slices), plus the Gemini notes mail
(Gmail `1a1a12aad5256527`, 11:28:10Z). ⚠ **No recording file and no separate
transcript document exist** — the Drive folder
`1xgs6XSFD1omGmMhcsmNLZ2CeIsHMn5pt` holds **only** the Gemini notes shortcut, and
that one document carries both the notes and the transcript.

## 🟢🔑 What worked — the chain, end to end, in production

Fabrizio Paganelli drove it himself from his own `amministrazione@pienissimo.com`
user, on screen:

1. **Account** created — company record type, San Marino, agent assigned.
2. **Opportunity** `test 0311 standard` (standard sale) and a **quote**, payment
   condition _bonifico fine mese data fattura_.
3. Two products added, two **tranche** created with due dates on **30 November** and
   **31 December**.
4. **PDF generated**, quote **sent for acceptance** by email.
5. **DocuSign** — Aurel Mrruku confirmed it was the real connector, not the sandbox
   one: _"ti arriva da DocuSign originale"_, _"Questo è un documento ufficiale"_.
   Fabrizio Paganelli signed.
6. The signed document came back, **asynchronously**, and the quote went to
   **`Firmato`**.
7. **Salesforce order 113** created, `Mexal Integration Status` = **`inviato`**.
8. **Mexal order `OC155`** found on the Mexal side, **with the discounts applied
   correctly**. 🔑 Aurel Mrruku had never tested a discounted order before —
   _"incrociamo le dita che va tutto su Mexal perché non avevo mai fatto un test con
   lo sconto"_ — and it reconciled.
9. **Invoice issued** in Mexal, payment condition code **20**.
10. **New Mexal customer created**, fiscal residence **RSM**, agent code as set.
11. Aurel Mrruku ran a sync; the **invoice came back into Salesforce unpaid**, with
    its due date in `a scadere`.

🟢 **This is the first time the full Salesforce → Mexal → invoice path has been
demonstrated in production.** ⚠ **No catalogue price or article-code value is
recorded here**; the amounts and the two discount percentages were checked on the
call and reconciled.

## 🔴 Anticipay times out in production

The first attempt failed. A P.IVA verification call for the new test account
**timed out** — the connector waits **120 seconds** and gets nothing.

🔑 **Anticipay had told ROMI production was ready.** Elena Spini re-read Andrea's
mail on the call: _"ha detto confermo, tutto ok, portate direttamente in
produzione. Lui stesso non ci aveva dato nient'altro"_. Fabrizio Paganelli: _"si
vede che hanno fatto qualche cosa e si sono dimenticati."_

🔑 **The pointings are Anticipay's to give, not ROMI's.** Aurel Mrruku corrected
Elena Spini explicitly: _"non è che diamo noi i puntamenti. Noi facciamo la
chiamata verso di loro. Sono loro che danno i puntamenti."_

Fabrizio Paganelli phoned **Andrea** live; Andrea would look at it later, not then.
The session continued **without Anticipay**. → [OI-312](../items/OI-312%20Anticipay%20times%20out%20in%20production.md)

### 🔑 What Anticipay actually is, stated plainly for the first time

Aurel Mrruku, pressed by Elena Spini: **it is not a validation.** _"l'Anticipay non
ti fa un controllo, fa una chiamata e ha una risposta, prende il risultato della
risposta e lo mette su dei campi."_ A result only comes back for an **Italian**
P.IVA that Anticipay can find; for anything else _"fallisce sempre"_. The call runs
**only on the first order**, and only when the account has no Mexal code and no
consolidated Anticipay flag.

🔴 **A failure does not block anything.** _"un errore di Anticipay non blocca
l'invio"_ — the order goes to Mexal regardless.

⚠ **Elena Spini named the limit case and it is unresolved**: a customer enters a
wrong-but-Italian P.IVA, Anticipay fails, amministrazione gets the Fase 1
notification, the order reaches Mexal anyway, **and the contract goes out carrying
the wrong P.IVA**. _"È un caso limite, però devono saperlo."_ Aurel Mrruku
speculated Pienissimo may already run an Anticipay check on the WooCommerce side —
**not established.** This is the case the R0 analysis records as _"Dedotto, da
confermare"_.

## 🔴 Production could not be cleaned

Aurel Mrruku deleted event invitations, tickets, opportunities and quotes — about
twenty records — live in production, with Elena Spini. **Orders and the accounts
linked to them could not be removed**: _"non hai i permessi perché abbiamo fatto in
modo che non puoi cancellare gli ordini"_, and _"li abbiamo messi incassati per i
biglietti in qualche modo poi devo trovare le possibilità di annullarli"_.

🔴 **So production carries undeletable test orders, some marked collected, and the
accounts behind them.** Fabrizio Paganelli asked again by mail at 14:04:03Z for the
morning's tests to be removed before he does the mapping.
→ [OI-315](../items/OI-315%20Production%20test%20records%20cannot%20be%20deleted.md)

## 🔴 The UAT mappings cannot be moved, and it cost the client a day

Sending the quote for acceptance failed with **_"mappatura mancante"_**. 🟢 Aurel
Mrruku: _"meno male che l'abbiamo messo il blocco"_ — the guard works.

Fabrizio Paganelli asked to copy the event/edition mappings he had already built in
UAT. **Aurel Mrruku refused, on a technical ground**: production events and editions
have different ids and there is no external id to join on — _"Se avessi un ID
esterno l'avrei fatto in 10 minuti, ma non ce l'ho un ID esterno"_. Not even a
spreadsheet round-trip works, for the same reason.

🔴 Fabrizio Paganelli took it badly: _"è un lavoro cinese"_, _"Io l'avevo detto che
era una cosa che non dovevamo rifare"_, _"Mi ven da piangere"_, and — half in jest,
twice — that he would invoice ROMI for the extra hours. He accepted it and will redo
events, editions and mappings by hand in production.
→ [OI-320](../items/OI-320%20Event%20and%20Edizione%20mappings%20cannot%20be%20moved%20between%20orgs.md)

⚠ **Aurel Mrruku's order of work**: the mapping comes **after** the product registry
is corrected — _"lo facciamo dopo che è messa a posto i prodotti"_.

## 🔑 The product registry in production

- **1093 products** are loaded. Aurel Mrruku counted them live with a query.
- 🔑 **The activation criterion is confirmed from the org**: Aurel Mrruku enabled
  products _"sul campo, non su annullato, ma sull'altro"_ — Fabrizio Paganelli
  supplied the name, **`gruppo merceologico`**. About **500** carry it. This
  corroborates [OI-309](../items/OI-309%20The%20product%20activation%20criterion%20must%20switch%20from%20gruppo%20merceologico%20to%20the%20Mexal%20flag.md)
  from the org rather than from a meeting.
- 🔴 **Fabrizio Paganelli admitted a registry error**: the codes beginning `blow`
  were set to **`S`** when they should be **`N`**. He will correct `gruppo
  merceologico`; Aurel Mrruku must then **delete and re-insert** those products.
  → [OI-327](../items/OI-327%20The%20blow%20product%20codes%20carry%20the%20wrong%20gruppo%20merceologico.md)
- 🔑 **The API integrations and the nightly refresh are deliberately still off in
  production.** Aurel Mrruku declined to switch them on mid-test: _"non voglio
  spaccare qualcosa adesso perché dobbiamo fare dei giri completi, poi alla fine devo
  abilitare gli API"_. **This answers a standing question — the product
  synchronisation flows are not on, by decision, not by oversight.**

## 🆕 Layout and field changes agreed

| What | Detail | Note |
| ---- | ------ | ---- |
| **`importo netto`** | A new line column, quantity × net price, so a tutor sees the row total without a calculator. The existing `nuovo prezzo` becomes **`prezzo netto`**. Quantity stays where it is, in the `quantità e stato` column header. | [OI-316](../items/OI-316%20The%20quote%20line%20needs%20a%20net%20amount%20column.md) |
| **`descrizione condizioni di pagamento`** | **Obscured**, and the space reused as **`note preventivo`**, enlarged so long notes are fully visible. | [OI-317](../items/OI-317%20The%20payment%20condition%20description%20field%20must%20become%20quote%20notes.md) |
| **`data competenza`** | Renamed to **`da data ordine`** / **`a data ordine`** on the edition. | [OI-318](../items/OI-318%20The%20data%20competenza%20labels%20must%20be%20renamed%20to%20data%20ordine.md) |
| **`data invio biglietto`** | Missing from the campaign record page in production. | [OI-319](../items/OI-319%20Data%20invio%20biglietto%20is%20missing%20from%20the%20campaign%20page%20in%20production.md) |

🔑 **Why the payment-condition field has to go.** Fabrizio Paganelli demonstrated
what tutors write into it — a bespoke instalment plan with amounts and dates in free
text. Aurel Mrruku: _"E buona fortuna poi con le fatture"_. Fabrizio Paganelli:
_"oscuratelo questo campo"_. ⚠ **But he then argued tutors genuinely need to write
notes** — course programme references the customer asks for — which is why the field
becomes `note preventivo` rather than disappearing. 🔑 Elena Spini confirmed the
field was a deliberate data-model decision, not an accident.

🔑 **An incidental finding**: changing anything that feeds the invoice sends the
quote **back to `Bozza`** and the PDF must be regenerated.

## 🔴 The asset state argument — the substantive requirements dispute of the session

**Fabrizio Paganelli says there are three states; the build has two.**

> _"noi abbiamo tre step. Arriva l'ordine, è ordinato. Poi dopo l'ordine io lo
> fatturo, diventa fatturato."_ … _"fatturato e incassato, quindi barra pagato, sono
> due cose diverse, non è la stessa cosa. Io oggi faccio l'ordine, al primo di
> dicembre lo fatturo, al 31 di dicembre il cliente paga. Quindi quell'unico ordine
> nel corso di due mesi subisce tre stati diversi."_

**The built behaviour**, confirmed by Aurel Mrruku and Elena Spini: an asset is
`ordinato` from order creation and becomes `disponibile` **only when the invoice is
actually collected**. There is no `fatturato` on the asset. Elena Spini: _"questo
flusso è stato condiviso miliardi di volte, quindi su questo sono ferma."_

🔑 **Fabrizio Paganelli's real concern is reporting, not accounting.** Whoever pulls
a report of available and unavailable assets sees `ordinato` and cannot tell that
the asset has been invoiced but not collected — _"chi guarda questa schermata senza
avere una logica contabile … fanno casino"_.

🔑 **The technical obstacle, stated precisely.** An asset is **not** an invoice line:
_"diversi asset sono collegati alla stessa riga"_, because assets are the quantity on
the line. So a one-to-one asset↔invoice-line link cannot exist. Aurel Mrruku named
two routes — propagate the order line's status to all its assets, or **invent an
ad-hoc field on the asset** — and **neither was chosen**.

🔑 **Where the client can already see it**: on the **order line** related list, the
`FT…` invoice link plus `Mexal Payment = unpaid` together mean invoiced-not-paid.
Fabrizio Paganelli accepted this view as _"a prova di stupido"_.

🔴 **The question was not closed on the call.** Aurel Mrruku left for another call,
Fabrizio Paganelli went to phone **Rebecca**, and Elena Spini offered to rename the
label from `ordinato` to **`non ancora disponibile`**.

🟢🔑 **It was closed by mail the same day, in ROMI's favour.** At **12:37 CET**
(Gmail `1a1a13322fc6fb23`) Fabrizio Paganelli wrote: _"mi sono confrontato con
Rebecca per gli stati dell'asset. **Va bene così come impostato ad oggi.**"_ Elena
Spini: _"Ok grazie dell'update."_ → **The label stays and nothing is built.** See
[the decision](../decisions/Decision%20-%20asset%20states%20stay%20as%20built%20and%20the%20ordinato%20label%20is%20not%20renamed.md)

### 🆕 What Aurel Mrruku did agree to build

An order-line **`fatturato`** status, driven from Mexal and **independent of
payment**: if every order line has an invoice link and at least one is not
collected, the order goes to `fatturato`; when all are collected it goes to
`incassato`, which already works.

⚠ **Agreed knowing it is imperfect.** Fabrizio Paganelli asked whether it keys on
all order lines or on the lines of one tranche; Aurel Mrruku said **all order
lines**, _"perché praticamente il fatturato vuol dire che tutto l'ordine è
fatturato"_. Fabrizio Paganelli objected — _"E dopo diamo un'informazione distorta
lo stesso"_ — and it was adopted anyway.
→ [OI-314](../items/OI-314%20The%20order%20line%20fatturato%20status%20is%20not%20implemented.md)

## 🔑 Users, licences and access

**Seven agent users** were sent production activation mail during the call, read out
one by one: Carmen, Davide S., Barbara, Segreteria, Sara D., Martina, Valentina V.
Fabrizio Paganelli wrote the covering mail live, ending _"mi raccomando, non toccate
nulla in ambiente produzione"_ because ROMI is still configuring. By the end of the
call **Carmen, Barbara, Martina and Valentina had already completed verification**.

- 🔑 **Verification links expire after 72 hours** and someone must open each mailbox.
- 🔴 **Marco Montesi has no agent code** — he is a manager. The call's decision was
  that he would **use the `segreteria` user**, which only Martina and Elisa Migliano
  can read. Fabrizio Paganelli: _"Che casino, che casinisti che siamo."_ ⚠ Elena
  Spini objected: _"secondo me Marco deve avere la sua utenza."_
  🟢🔑 **Superseded the same day** — by 17:20Z Elena Spini had told Marco Montesi his
  own user was moved from **System Administrator** to the **Agente** profile. See
  [the permission note](../objects/The%20Agente%20permission%20set%20gained%20Mexal%20and%20Anticipay%20access.md).
- 🔴 **One of the seven leaves on 31 December.** Fabrizio Paganelli: Davide Stefani is
  engaged as an agent, not an employee, _"Al 31 di dicembre cesserà l'attività, dopo
  lo dovremmo sostituire con un'altra persona nuova"_. Aurel Mrruku: changing the
  username is enough.
  → [OI-324](../items/OI-324%20An%20agent%20user%20leaves%20on%2031%20December%20and%20the%20licence%20must%20be%20reassigned.md)
- 🔑 **A fallback agent user exists**: a `pienissimo commerciale` user with the
  **Agente** profile, which accounts with no agent or duplicate agents are to be
  pointed at. Fabrizio Paganelli communicated this by mail. ⚠ Its code was spoken as
  `001`, `006` and `00` at different moments — **the exact value is uncertain** and
  is not recorded here.
- 🔴 **Fabrizio Paganelli had no access to child campaigns** despite holding "all
  permissions"; Aurel Mrruku granted it mid-call. Campaigns must be created by hand
  in production.
- 🔴 **Aurel Mrruku lacks field-level permission on `data invio biglietto` himself** —
  _"Non ho i permessi sul campo. Devo fare per forza un rilascio."_ **A release, not
  a setting.**
- ⚠ Elena Spini, on Fabrizio Paganelli's permission sets: _"sembravano pochi rispetto
  a quei famosi 12"_. **What the twelve are was not established** and is not assumed
  here to be the twelve licences.
- 🔑 **Valentina's "missing" activation mail was a misunderstanding** — she had
  already completed activation. ⚠ **The Gemini notes list "resend the activation mail
  to Valentina" as an action item; the transcript resolves it on the call.**

## 🆕 Order header notes — OI-306 has its purpose confirmed

Fabrizio Paganelli explained **why** he wants it: the customer signs the quote, the
signed document carries the Salesforce order number, and when the invoice is raised
the **quote reference and the Mexal order number must appear in the invoice notes**.
He and **Mirko Merendi** exchanged a mail with the Mexal field code.

🔴 **Aurel Mrruku: _"non l'ho fatto ancora"_.** He listed what he still owes:
_"Mi mancano la community, le note, alcuni layout."_
→ [OI-306](../items/OI-306%20The%20WooCommerce%20order%20number%20must%20reach%20Mexal%20in%20the%20order%20header%20note.md)

## 🆕 An unexplained missing due date on the order line

Fabrizio Paganelli: a `data scadenza` per order line was requested, _"anche parlando
con Mirko"_, and on one order **it is not populated** — _"Adesso qui non è
valorizzata perché non lo so perché."_ ⚠ **No cause was found on the call.**
→ [OI-325](../items/OI-325%20The%20order%20line%20due%20date%20is%20not%20populated.md)

## 🟢 Decisions

| Decision | Who | Detail |
| -------- | --- | ------ |
| **The Salesforce login URL stays as it is** | Fabrizio Paganelli | Elena Spini offered to customise `ability-customization-52152` to a Pienissimo name. Fabrizio Paganelli refused because tutors who have already configured their key would have to regenerate it: _"Ti dico di no solo per tutto, solo per rigenerare la chiave"_, _"lasciamo stare così dai, chi se ne frega"_. ⚠ Elena Spini noted the integration endpoint link would also have to change. → [the decision](../decisions/Decision%20-%20the%20Salesforce%20My%20Domain%20stays%20unchanged.md) |
| **Asset states stay as built** | Fabrizio Paganelli, after Rebecca | By mail, 12:37 CET. The `ordinato` label is not renamed. |
| **An order-line `fatturato` status will be built** | Aurel Mrruku | Order-level, independent of payment. |
| **API integrations stay off until the full rounds are done** | Aurel Mrruku | Agreed by Elena Spini. |
| **Fase 2 goes through an internal pass first** | Elena Spini, Fabrizio Paganelli | See below. |
| **PEC stays optional on Account** | Aurel Mrruku | Fabrizio Paganelli wanted it mandatory; Aurel Mrruku refused because non-Italian companies have none. |

## 🔑 Fase 2 governance was settled

Elena Spini: **Andrea Galotto** — ROMI, the sales side, who interfaces with
**Daniela** — told her to do a pass with whoever is running the project before
taking a call with Daniela directly. Fabrizio Paganelli agreed: _"Facciamo un
passaggio prima io e te, dai, prima di coinvolgere loro due."_

- 🔑 Elena Spini: **the activity list is already defined** — _"la lista delle attività
  ed è già definita, però poi c'è il preventivo"_.
- 🔑 **Price and numbers go to Andrea Galotto and Daniela**, after the Elena/Fabrizio
  pass. Fabrizio Paganelli: _"poi dopo il preventivo se la vedono Andrea e la
  Daniela. Io magari informo la Daniela."_
- ⚠ **So Daniela appears to be Pienissimo-side** — Fabrizio Paganelli asked _"Andrea,
  chi è Andrea? Andrea vostro"_ about Andrea Galotto but undertook to brief Daniela
  himself. **Marked inferred, not established.**

This bears directly on the unreconciled **150 vs 58-78** day counts in
[the offer](../The%20Fase%202%20offer.md) and
[the estimate](../The%20Fase%202%20estimate.md).

## 🔴 Fabrizio Paganelli's own verdict, and what is still untested

> _"rifacciamole queste test perché, come hai visto, anche oggi mancava la metà delle
> robe"_

and

> _"Dobbiamo secondo me rivedere la Performance Plus, i pacchetti, cioè sono cose
> importanti queste."_

🔴 **Performance Plus and the bundles have not been tested at all.** A further
session with **Rebecca** is owed, to check the asset labels and the invoicing logic.

⚠ **Fabrizio Paganelli invoiced both tranches by mistake** during the test, when at
steady state he should have invoiced only the first — which is part of why the
`fatturato` discussion was so tangled.

## 🆕 Next session

**Wednesday 4 November, afternoon.** Fabrizio Paganelli has a workplace-safety
course in the morning and will try to move it; Elena Spini is unavailable all day, so
**Aurel Mrruku and Fabrizio Paganelli continue alone**. Elena Spini re-sent the same
meeting: `[ROMI-PIENISSIMO] - Continuazione Test e2e PROD`, **14:30-16:00 CET**
(Gmail `1a1a2662cea3f834`).

🔑 **Fabrizio Paganelli also owes the data tracciati tomorrow morning** — _"domani
mattina che cos'è che vi devo dare? Vi devo dare tutti i tracciati dati"_ — which
corroborates the 4 November 09:00-09:30 slot promised on 2 November for the
**Referenti** extract.

## 🟢 Also agreed, smaller

- A **full order synchronisation to Mexal** is owed. Aurel Mrruku's sync only
  fetched **the last 5 days**; the whole set _"ci mette 5 ore a fare tutto"_.
  → [OI-321](../items/OI-321%20The%20full%20order%20synchronisation%20to%20Mexal%20has%20not%20been%20run.md)
- **The community and the Notes object are not in production yet.** 🟢 Aurel Mrruku
  reported in the marketing DM at **12:48 CET** that he had brought the community up
  during the day.
- **A domain is still owed by the client.** Aurel Mrruku: _"il dominio poi lo
  dobbiamo aggiustare"_; Elena Spini: _"non ce l'hanno dato, quindi mi sa che glielo
  dobbiamo chiedere"_. ⚠ **Which domain was not stated** and it is **not** the login
  URL, which was separately decided to stay.
  → [OI-323](../items/OI-323%20The%20production%20domain%20has%20not%20been%20supplied%20by%20the%20client.md)
- **Shipping address falls back to the billing address** when left blank.
- **Quote status path**: `in attesa di accettazione` once the mail is confirmed, then
  back to `in trattativa` after about five days unsigned.
- Aurel Mrruku has done **one partial production release** to test functionality; the
  discount fix went in on 2 November. Quote totals and discount totals **were never
  released to production**.

## 🔴 The production consequence, twelve minutes after the call

The event link reached **`pronto`** during the test while no tickets were available.
Elena Spini saw it and checked the behaviour was correct — _"Ma dice non ci sono
biglietti disponibili"_, _"L'importante è che comunque non va"_.

🔴 **It then fired a ticket-nomination email to Fabrizio Paganelli at 12:33 CET for
an order whose assets were still `ordinato`.** Elena Spini diagnosed the cause in the
marketing DM at 12:46 CET: _"secondo me il problema qui è che il link era in
PRONTO"_.
→ [OI-313](../items/OI-313%20The%20ticket%20nomination%20email%20fired%20for%20assets%20still%20in%20ordinato.md)

## Where the auto-notes are wrong

🔑 **Recorded so nobody drills this session from the summary.**

1. **_"Aurel esegue direttamente la cancellazione dei dati superflui in produzione"_**
   — partly false. Invitations, tickets, opportunities and quotes went; **orders and
   their accounts could not be deleted at all.**
2. **_"[Aurel] Reinviare mail attivazione … a Valentina"_** — stale. The transcript
   resolves it on the call: she had already activated.
3. **_"Elena Spini … propone di effettuare un controllo con Rebecca prima che Aurel
   mrruku abbandoni la riunione"_** — the check with Rebecca happened **after** Aurel
   Mrruku had already left, and the answer arrived by mail afterwards.
4. The notes present the asset-state exchange as a clarification. **It was a
   disagreement**, and the technical reason a per-asset invoiced state cannot be
   built one-to-one is absent from them entirely.
