---
id: meeting-2026-10-21-check-dati-migrazione-e-op
type: meeting
status: resolved
owner: Elena Spini
org: both
raised: 2026-10-21
updated: 2026-10-21
source: meetings/2026-10-21-check-dati-migrazione-e-op-transcript.it.md
---

# 2026-10-21 Check Dati Migrazione e OP

**Client call, 10:01 CEST, 02:46:16 — the longest session in the project
record.** Fabrizio Paganelli, Elisa Migliano and Sabatino Rinaldi for
Pienissimo; Elena Spini and Aurel Mrruku for ROMI. Booked as the migration
rehearsal promised on 15/10. It did two things: it **fixed 16 November as the
agreed go-live, with a two-phase import** that removes the operational freeze
the client refused, and it **surfaced the migration blocker nobody had raised**
— historical ticket balances have no path into Salesforce.

Full raw transcript preserved at
[meetings/2026-10-21-check-dati-migrazione-e-op-transcript.it.md](../../meetings/2026-10-21-check-dati-migrazione-e-op-transcript.it.md)
(read once, in full). The Drive document also carries a Gemini notes section
with a `Decisioni` / `Passaggi successivi` list; where the two differ the
transcript governs. ⚠ Gemini renders Zoho as _"Zoo"_/_"Zo"_, Mexal as
_"Maxal"_/_"Maxile"_, Anticipay as _"Antipay"_/_"Anticip"_, WooCommerce as
_"Wcommerce"_, Salesforce as _"Sales Force"_/_"Ses Force"_; repairs appear only
inside quotations, in brackets.

The call broke for coffee at `00:51:59` and resumed at `01:05:03` with Fabrizio
Paganelli and Aurel Mrruku working through the test findings; it closed by
booking the 14:30 session that became
[Tema Migrazione](2026-10-21%20Tema%20Migrazione.md).

## 🔑 The go-live date was agreed, in the room, by both sides

This is the finding of the day.
[OI-268](../items/OI-268%20The%20client%20proposed%20a%20go-live%20calendar%20of%2016%20November.md)
stopped being a proposal.

- Elena Spini opened by confirming ROMI had answered the calendar mail in
  writing — _"io ho risposto anche alla mail che mi ha mandato Sabatino"_ — and
  restated ROMI's position: _"non è che il 16 si va tutto pronto … ci sono
  diverse configurazioni che vanno fatte manuali, quindi … noi avevamo proposto
  il nove come rilascio, cioè ma un rilascio tecnico per permetterci di arrivare
  poi il 16 a dire 'Ok, è tutto pronto'."_ ⚠ **That reply mail is not in the
  swept mailbox** — it was sent from `e.spini@romicompany.com` and the sweep
  runs against `a.mrruku@romicompany.com`.
- Fabrizio Paganelli explained where the client's date came from: _"è una
  proposta questa che … l'abbiamo ragionata ieri anche con la direzione che era
  qui"_ — i.e. settled with their management on 19 October, one day before the
  mail. Elena Spini's complaint was the notice, not the date: _"a parte che
  nessuno mi aveva anticipato il tema eh di fare un rilascio così a lungo … ci
  eravamo sentiti lunedì, me lo potevate anticipare."_
- 🟢 **The 16th stands as the operational go-live** and all four named people are
  committed to being on it. Aurel Mrruku: _"per forza lunedì il 16 io, te,
  Sabatino, Elena dobbiamo essere tutti presenti sul pezzo, operativi e per
  qualsiasi motivo il massimo 10 minuti dobbiamo comunicare tra di noi."_
  Fabrizio Paganelli: _"Va bene. Io ci sono."_
- 🔑 **The weekend migration the client proposed is dead** and nobody defended
  it. Aurel Mrruku: _"ti dico già da tanti anni che faccio sto lavoro, cerchiamo
  di non lasciare mai le immigrazioni e i deploy in weekend. Perché non abbiamo
  mai tutti i membri dei team operativi."_ Elena Spini: _"il 14:15 è weekend."_

See [OI-268](../items/OI-268%20The%20client%20proposed%20a%20go-live%20calendar%20of%2016%20November.md)
for the agreed calendar and
[the Zoho risk](../risks/Risk%20-%20go-live%20now%20falls%20after%20the%20Zoho%20contract%20expires.md)
for what it costs.

## 🟢 The two-phase import, which is what unblocked the date

The client had refused a week-long invoicing freeze outright — Fabrizio
Paganelli: _"io non posso star fermo una settimana, capito? … se devo star fermo
una settimana a quel punto slittiamo in dicembre"_, with Pienissimo Live on
23–26 November behind it. Aurel Mrruku first insisted a freeze was unavoidable
(_"Impossibile che si lavora in due sistemi nello stesso momento"_), then
separated the two concerns and proposed the design that was accepted:

> _"Per me quando io vado in produzione con Salesf[orce] puoi avere una
> settimana di ordini non migrati in sales force. Dividiamo le tematiche … ma si
> devono fare due migrazioni di ordini, quindi una prima migrazione che decidiamo
> noi la data e poi il resto … e così siamo tranquilli e non ci fermiamo manco un
> giorno, manco un secondo."_

Fabrizio Paganelli: _"Se è così va bene. Se è così va bene. Per me va bene."_
Full calendar in
[OI-268](../items/OI-268%20The%20client%20proposed%20a%20go-live%20calendar%20of%2016%20November.md).

⚠ **Aurel Mrruku asked for two freeze days, Friday 13 and Monday 16, and did not
get them.** _"la cosa migliore è di prevedere due giorni di fermo, non uno …
venerdì e lunedì."_ Fabrizio Paganelli countered that he would hand over the
second extract at 09:00 on Friday 13 so that Monday 16 is a working invoicing
day: _"dobbiamo puntare al fatto che il lunedì 16 alle 9 io riesco a fatturare da
S[ale]sF[orce]."_ The 16th is therefore both the go-live and a live invoicing
day, with no contingency day behind it.

## 🔴 The blocker: historical ticket balances

Raised by Aurel Mrruku at `00:22:42` and unresolved when the call ended — see
[OI-274](../items/OI-274%20The%20historical%20ticket%20balance%20has%20no%20migration%20path.md).

- A bulk order import does not create the Assets. _"quando viene creato l'ordine
  da questa migrazione, non stiamo prevedendo la creazione degli asset con tutti
  gli stati degli asset … io non ho eseguito nessuna logica di creazione del
  biglietto."_
- Nor the marketing link: _"non c'era manche il link per l'invio."_
- The client has customers who have paid for tickets to events that have not
  happened. Fabrizio Paganelli's worked example at `00:27:28`: a customer who
  bought in September holds tickets for Food Marketing Festival (attended),
  Pienissimo Live and the Academy (not yet), all invoiced and paid.
- 🔑 **Neither side had this in scope and both said so.** Aurel Mrruku: _"non era
  stato mai parlato di migrazione di biglietti, Fabrizio? … portare i biglietti da
  Zo[ho] in Sales Force? Mai."_ Elena Spini: _"c'è tanto di documento, di email,
  di qualsiasi cosa in cui si è parlato di migrazione solo di queste cose."_
- Fabrizio Paganelli escalated to the project lead mid-call (`00:32:55`).
  🔴 **Sabatino Rinaldi's reaction is the sharpest client escalation on record**:
  _"tocca trovare una soluzione perché non è possibile arriva a sto punto dove non
  ci siam posti prima sto problema … io il 21 di ottobre stiamo parlando di queste
  cose da tanto tempo, quindi mi aspetto da parte vostra dovete portarci una
  soluzione."_ Aurel Mrruku refused the framing: _"qua non sono per niente
  d'accordo con te … se tu non mi dici che voglio questi record in sales force,
  come ti devo dire io come portare questi record in sales?"_
- Volume estimated live by three people as **~1,000 available tickets**
  (Fabrizio Paganelli: _"saranno un migliaio"_; Sabatino Rinaldi: _"Non superiamo
  i migliori [il migliaio]"_). Aurel Mrruku's rule of thumb: _"stiamo parlando di
  500 facciamo a mano … ci mettiamo 3[-]4 giorni."_
- 🔑 Sabatino Rinaldi offered an alternative route ROMI did not know existed:
  _"dato che loro non sanno che noi abbiamo pienissimo 360, valutiamo anche la
  possibilità di portarci dei dati su pienissimo 360 e tramite [A]PI entrare in
  sales[f]orce."_ ⚠ **`Pienissimo 360` appears in no project record.** Elena Spini
  in DM the same morning: _"ma che è sto Pienissimo 360 -.-"_

## What else was decided

| Item | Decision |
| ---- | -------- |
| [OI-261](../items/OI-261%20Test%20article%20codes%20pollute%20the%20product%20registry.md) — bundle-only articles on a standard sale | 🟢 **Settled and built the same day.** The four `natura` values were read off the Mexal registry live: `BO` generates a ticket and is not bundle-only, `NO` generates none and is not bundle-only, `BB` and `NB` are bundle-only. Rule: _"quando un tutor fa un ordine standard può comparire solo BO o NO"_ — Aurel Mrruku: _"se ha il bundle il true, allora non deve essere incluso."_ |
| [OI-207](../items/OI-207%20The%20quote%20and%20order%20layouts%20omit%20the%20commercial%20fields%20the%20client%20requires.md) — commercial columns | 🟢 Re-confirmed and in progress: _"abbiamo già iniziato molto prob[abil]mente entro oggi lo finiamo."_ Required set, verbatim: _"Codice articolo, unità di misura, quantità, prezzo di listino, totale di listino, sconto e totale netto."_ 🔑 **Editability settled**: inside a bundle the component lines show but are not editable; on a standard sale quantity, discount % and net are editable and **the list price is locked**. |
| [OI-260](../items/OI-260%20Generating%20the%20quote%20PDF%20failed%20with%20an%20internal%20server%20error.md) — quote PDF 500 | 🟢 **Cause found and fixed**: user permissions. Aurel Mrruku: _"erano dei permessi, ma l'abbiamo aggiustato … stavamo facendo i permessi per le vostre utenze, mancavano dei campi sui permessi, per quello andava in errori."_ Elena Spini apologised for not saying so: _"Mi sono dimenticata di avvisarti alla fine."_ |
| Account creation screen | 🟢 Nine changes agreed — see [OI-279](../items/OI-279%20The%20tutor%20account%20creation%20screen%20must%20be%20simplified.md). |
| `Mandato RID` | 🟢 New read-only field agreed — see [OI-277](../items/OI-277%20A%20read-only%20Mandato%20RID%20field%20is%20required%20on%20the%20account.md). |
| Legal representative | 🟡 Suspended pending the client's lawyer — see [OI-278](../items/OI-278%20The%20account%20layout%20omits%20the%20legal%20representative%20data.md). |
| Anticipay before the contract goes out | 🟢 Resolved operationally, not in code — see [OI-281](../items/OI-281%20Tutors%20must%20use%20Aggiorna%20Anticipay%20when%20creating%20an%20account.md). |
| Technical documentation | 🟢 Aurel Mrruku undertook to write one — see [OI-282](../items/OI-282%20The%20client%20is%20owed%20a%20technical%20integration%20document.md). |
| Opportunity record types | 🟢 Clean pass. `Performance Plus` keeps the activation/renewal sub-choice (_"Infatti che era C10 o C11"_); standard sale has none and should not; WooCommerce carries `origine` with PEC and tutor recall. 🔑 Terminology pinned: a **`pack tutor`** is a pre-built bundle Fabrizio Paganelli creates, sold through a WooCommerce link; a tutor's **custom package** is an ordinary standard sale with ~15 lines and ~5 tranches; a **`recall tutor`** is a stage sale by Giuliano to people who attended and did not buy. |

## 🟢 What the Anticipay 404 mails actually are

The sandbox `Errore controllo Anticipay — Stato HTTP: 404 — TEST - Azienda non
trovata` mails (two on 20/10 at 10:20Z, two more on 21/10 at 09:43Z) are
**expected behaviour in UAT, not a defect**. Aurel Mrruku, at `01:41:03`:

> _"quando m'avete abilitato Anti[ci]pay per non spendere dei crediti, avete
> fatto in modo che il check si fa solo su i dati che avete già sul vostro
> sistema, quindi devi mettere una partita IVA di un account che hai già sul tuo
> database."_

So the UAT call is redirected at the client's own database to avoid burning
credits; any VAT number not already held returns 404. In production the call
goes out normally — _"a regime verrà fatta normalmente"_ — and Fabrizio Paganelli
must ask **Andrea** to open it for a live test: _"basta che Andrea mi abilita e
lato nostro non dobbiamo fare niente."_ ⚠ `Andrea` holds the Anticipay
credentials and is still unidentified in the records.

## 🟢 The order/contract flow, stated end to end for the first time

Aurel Mrruku walked it at `02:18:59`–`02:20:23`; recorded because the client
asked for it in writing and it is the basis of
[OI-282](../items/OI-282%20The%20client%20is%20owed%20a%20technical%20integration%20document.md):

1. Tutor sends the quote; customer accepts; Salesforce updates and DocuSign
   sends the contract; customer signs; DocuSign reports back; quote goes to
   `firmato`.
2. On `firmato` the **Order** is created, and with it the **Contract** record —
   there are two contract concepts and only the second is a record: _"il
   contratto del preventivo … ma il contratto come oggetto, come record, non è
   stato ancora creato perché viene creato quando si crea il record di ordine."_
3. First job checks the account for a Mexal code. If absent → Anticipay call →
   update the account → send the account to Mexal → receive the customer code →
   store it → only then send the order.
4. On a Mexal failure an error mail goes to the administrator and a Mexal status
   field on the order is updated. 🔑 Those mails currently reach Aurel Mrruku and
   **will be repointed to the client**: _"Ovviamente questo non arriva più a me,
   ma arriverà a te, perché metteremo la tua utenza."_

## Housekeeping confirmed

- 🟢 **The nightly account and product sync was switched off and will be switched
  back on.** Aurel Mrruku: _"L'avevo spento io perché stavo lavorando. Sì, però lo
  accendo di nuovo, non è un problema."_ He runs it on demand from the developer
  console; he undertook to hand the client the account/product script as well as
  the invoice one (_"questa qua fa … fattura più scadenziario, quindi anche
  l'incasso"_).
- 🟢 The Google address autocomplete was deliberately replaced: it set `country`
  to the United States on San Marino and Parma addresses that Anticipay returns
  without a state. Tutors type address and postcode by hand.
- `P.IVA` and `PEC` move to the top of the creation screen, above the addresses.

## Open questions this call leaves

- 🔴 How historical ticket balances reach Salesforce
  ([OI-274](../items/OI-274%20The%20historical%20ticket%20balance%20has%20no%20migration%20path.md)) —
  a design was drafted in the afternoon session but nothing is built.
- 🔴 Whether the ~80 Performance Plus contracts can be handled by hand by
  Fabrizio Paganelli and Elisa Migliano, as he proposed: _"sui clienti che hanno
  la P[erformance ]P[lus] e che c'è il contratto sono 80 e ci mettiamo io e
  l'Elisa, quelli li facciamo [a] mano."_ See
  [OI-280](../items/OI-280%20Performance%20Plus%20contract%20generation%20must%20be%20bypassed%20for%20migrated%20orders.md).
- ⚠ What `Pienissimo 360` is and whether it is in scope for anything.
- ⚠ Who `Andrea` is and whether he will open the Anticipay call for a
  production test.
- ⚠ Whether the product description truncation and the `livelli 0–6` from the
  tracciato are in the pending cumulative screen release. Aurel Mrruku: _"stiamo
  facendo dei cambiamenti su tutte le schermate e andrà tutto un stesso push,
  altrimenti ho dei conflitti."_
