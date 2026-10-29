---
id: meeting-2026-10-27-follow-up-interno
type: meeting
status: resolved
owner: Elena Spini
org: ROMI
raised: 2026-10-27
updated: 2026-10-27
depends_on: [OI-290, OI-292, OI-244]
blocks: [go-live]
source: meetings/2026-10-27-follow-up-interno-transcript.it.md
---

# 2026-10-27 Follow-up Interno

**The ROMI-internal weekly, 43 minutes. It put a hard date on the Lead and
Referenti data the client owes, settled the note-field question against the
sales team, cleared a false alarm on the order import file — and produced the
first man-day estimate for Fase 2 this project has had, which quietly contains
several items the repository still tracks as open Fase 1 questions.**

- **When:** Tuesday 2026-10-27, 17:03 CET, **00:43:26**.
- **Who:** Elena Spini, Aurel Mrruku (ROMI). ⚠ **Fabrizio Mastracci was invited
  and did not attend** — he had said so in the marketing group DM at 09:10 CET
  (_"io non ci sono"_), and Elena Spini went ahead: _"va beh facciamo io ed
  Aurel."_ Fabrizio Paganelli joined **by telephone on speaker** for roughly
  eleven minutes.
- **Source:** full raw transcript, drilled once —
  [the preserved record](../../meetings/2026-10-27-follow-up-interno-transcript.it.md)
  (Drive `1_npAY1ezf8Fk1TzIpalZyX1PUdyoa1UBLCE_bloAhAw`, 31,484 bytes). A 559 MB
  MP4 exists at `1ajTcv9ebj6thCkK4MB_EbogRO-goGca2`; ⚠ **not opened** — the
  first Pienissimo recording in Drive since 23/10.

## 1. The order import file: a false alarm, and a real clarification

Elena Spini and Aurel Mrruku opened by auditing the tracciato against Fabrizio
Paganelli's delivered file and concluded **quantity and net price were missing**
(`00:00:02`). Elena Spini then found she had the wrong version open — _"Questa
era il 22. Mi sa che era il 23 che era venerdì"_ — and telephoned him.

🟢 **It was a sorting artefact.** The file is sorted and the leading rows are
zero-value, so the columns looked empty (`00:09:35`):

> **Elena Spini:** _"Ok, ci sono 6800 righe con un valore … Siccome abbiamo
> aperto il file, abbiamo visto che era tutto ordinato, semplicemente i primi
> erano gli importo netto a zero e ci siamo un attimo bloccati."_

🔑 **New fact about the data: zero-price order lines exist in volume**, as
complimentary product codes — _"ci sono dei codici articolo che sono codici
prodotto omaggio hanno prezzo zero."_ Aurel Mrruku did not know this was
possible: _"Ma si possono fare ordini a prezzo zero?"_ ⚠ Whether the import or
the Mexal send handles a zero-price line is **not** discussed.

🟢🔑 **And the per-unit question was settled explicitly** (`00:09:35`–`00:10:52`):

> **Elena Spini:** _"in[1] porto netto io l'ho inteso come il prodotto del
> prezzo unitario per la quantità. È corretto o volete il prezzo netto
> unitario?"_
>
> **Aurel Mrruku:** _"la riga ha il prodotto che ha un prezzo di listino e un
> prezzo netto. Poi la riga se viene moltiplicata per due, ma lo posso anche
> trovare io, non è un problema. **Basta che divido per la quantità** e c'ho il
> prezzo netto, vero?"_

So `importo netto` in the import file is **price × quantity**, and ROMI will
divide to recover the unit price.

🔴🔑 **This is the same per-unit-versus-line-total distinction that
[OI-287](../items/OI-287%20The%20Mexal%20line%20discount%20is%20sent%20as%20a%20line%20total%20instead%20of%20per%20unit.md)
turns on, asked and answered correctly in one exchange on the inbound side —
while the outbound side is wrong and in production.** Nobody in the call
connected the two. OI-287 was not mentioned.

## 2. Lead and Referenti: a deadline at last, and the join identified

🟢🔑 **A hard date was set internally: Monday 2 November.** `00:22:45`–`00:24:36`:

> **Aurel Mrruku:** _"Elena, là io me ne frego. **Non gli possiamo mandare 10
> mail** per avere un po' di attenzione. Andiamo in live, abbiamo finito. Amen.
> Non ci avete risposto. C'era una data entro queste. **Dobbiamo essere rigidi su
> ste cose.**"_
>
> **Elena Spini:** _"La data però manca, **quindi è colpa mia** … faccio io il
> follow up e gli dico se non mi date questa risposta entro tot."_
>
> **Aurel Mrruku:** _"lunedì prossimo o venerdì, entro lunedì."_
>
> **Elena Spini:** _"Entro lunedì prossimo dobbiamo avere questi dati."_

⚠ **Elena Spini's own 26/10 mail to Sabatino Rinaldi carried no deadline**, which
she acknowledged. ⚠ **The follow-up had not been sent as at this sweep** — no
such mail is in the mailbox.

🟢 **The Referente-to-Account join is identified**, `00:25:42`–`00:28:46`: the
client's file carries `nome azienda` and a **`codice cliente esterno`** that
matches the Salesforce account, and Aurel Mrruku has had it put on one of his own
test companies to prove it — _"basta che ci confermano sta cosa la portiamo."_
⚠ Both admitted the referenti structure is still unclear to them: _"Io non ci ho
capito un tubo sui referenti."_

See [OI-290](../items/OI-290%20Lead%20and%20Referenti%20migration%20data%20is%20owed%20by%20the%20client.md).

## 3. The note field: refused, and replaced with a related list

🟢 **Decided** —
[notes live in a related list, not a field on orders and quotes](../decisions/Notes%20live%20in%20a%20related%20list%20and%20not%20a%20field%20on%20orders.md).

🔑 **It started with an unrecorded meeting.** Elena Spini, `00:14:08`: _"stamattina
abbiamo fatto un piccolo incontro con tutti i commerciali in merito … La prima
cosa che mi hanno chiesto ma il campo note dov'è?"_ ⚠ **That session on the
morning of 27/10 has no transcript, no notes document and no calendar artifact in
Drive.**

Her objection is operational, not aesthetic (`00:14:08`–`00:15:17`):

> _"Loro fanno un ordine, lo fanno alla c\*\*\*\*, scusate il termine, e poi nel
> campo not[e] scrivono il cliente pagherà a €350 il 15 dicembre, al €275 al 29
> di novembre … E poi dopo vengono da me e mi dicono 'Ah, ma perché al cliente
> gli hai fatto …' … c'è scritto nel campo note. Allora, siccome io questa qui è
> una cosa che **voglio stroncare** … **aiutatemi a fare muro**, non lo
> mettiamo."_

Aurel Mrruku confirmed a field was technically trivial — _"se vuole gli possiamo
agire anche un campo su tutti gli oggetti, non è un problema"_ — and agreed to
the related list instead.

🔑 **A "cattivo pagatore" account tag was raised and ruled already covered** by
the existing `categoria statistica cliente`.

## 4. Production release status, told internally

Aurel Mrruku, `00:18:46`–`00:22:45`:

- _"ho iniziato e quasi finito il rilascio in produzione di tutto … da ieri che mi
  sto occupando di quello … **entro domani sera finisco il rilascio in
  produzione**."_
- **_"domani, dopodomani produzione, import degli ordini"_** — _"io devo solo
  caricare i dati, quindi abilitare utenza e caricare i dati in produzione"_ —
  and then _"capisco un po' questi ordini se vengono creati in modo corretto."_
  ⚠ **Whether this is the migration proper or a rehearsal is not stated**, and
  the agreed calendar puts the second extract at 13 November 09:00 with go-live
  on the 16th.
- **15 fields deployed to production** — _"quei 11 campi, 15 campi li ho passati
  in produzione"_ — and Fabrizio Paganelli was told so in chat.
- **An `Agente` permission set exists and was narrowed**: _"ho tolto modifica su
  ordini, su prodotti, non può vedere i bundle"_, tested by Anita Aga.
- 🔴 **WooCommerce production endpoints are needed and were not yet requested** —
  _"mi servono gli end point di produzione per Wocommerce … mando una mail
  domani"_. Mexal's are already held.
- 🟢 A full end-to-end flow test in production was planned for the next day, with
  a marketing test round _"da quella dopo"_ — i.e. the week of 2 November.

🔴🔑 **The team shrinks.** _"Regina [Rexhina Hysi] andrà su un altro progetto,
quindi serve solo con Ana … quindi se c'è una fase due a breve saremo solo in
due, non in tre."_ See
[the risk](../risks/Risk%20-%20the%20delivery%20team%20shrinks%20before%20Fase%202.md).

🟢 Both noted the scope line is now holding — Elena Spini: _"mi è stato vietato di
aggiungere qualsiasi altra cosa"_; Aurel Mrruku: _"sono processi che, come aveva
detto il tizio … perché non si finisce più"_ — consistent with
[the 26/10 ruling](../decisions/ROMI%20will%20absorb%20no%20further%20scope%20in%20Fase%201.md).

## 5. Fase 2 estimated, in man-days

See [the Fase 2 estimate](../The%20Fase%202%20estimate.md) for the figures, the
scope list and what it moves out of Fase 1.

🟢🔑 **Authorship is now on the record** — Elena Spini, `00:39:58`: _"io e
**Claudio** abbiamo partorito questo documento e io l'ho rivisto."_ This answers
a question open since the Fase 2 draft was first mentioned.

Aurel Mrruku objected to estimating before analysis and said so repeatedly —
_"Come pretendi che ti do delle stime senza analizzare quello che … Non fare le
cose in fretta perché li fai male"_ — then supplied numbers anyway, recording
disagreement on one of them: _"metti 10. **Non sono per niente d'accordo**, però
va bene. Devi mettere un numero."_

Elena Spini expects the client to cut it: _"io faccio vedere sta roba, uscirà il
finimondo perché se la fase due è stimata quanto il progetto iniziale, non
vorranno niente di tutto questo. Inizieranno a togliere le cose."_ Aurel Mrruku:
_"Ma il problema è se poi dicono di sì."_

**Routing:** to **Andrea**, who will call **Daniela** (Morgese) — _"io do questo
a il buon Andrea che chiamerà Daniela."_ ⚠ **Which Andrea is not established**;
candidates in the record are
[Andrea Di Cicco](../people/Andrea%20Di%20Cicco%20-%20solution%20architect%20ROMI.md)
and the _"Andrea G."_ of the 24/10 weekly status. **Not resolved, not guessed.**

## 6. Also said

- 🟢 Another **commercial-team training hour** agreed, once the test environment
  is stable and resembles production — _"una volta che siamo già un pezzo avanti
  con l'ambiente di prova che somiglierà quanto più possibile l'ambiente di
  produzione."_
- 🟢 Fabrizio Paganelli reported the **mappature complete** on the call and by
  mail at 15:47:38Z, flagging inconsistencies in the Categoria Prodotto
  descriptions and attaching his Mexal list.
- 🔑 Aurel Mrruku's standing instruction to the client on mapping: _"deve ragionare
  sempre per codice … Solo per codice, non per il nome, per la label"_ — Elena
  Spini had mapped by description and said so.
- Elena Spini is taking a Salesforce certification (`00:42:01`, _"clamo"_ in the
  transcript); Aurel Mrruku offered to teach her Git. Not project state.

---

[1] The transcript reads _"in porto netto"_; the field is `importo netto`.
