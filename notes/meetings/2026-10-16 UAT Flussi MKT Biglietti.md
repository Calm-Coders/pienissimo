---
id: meet-2026-10-16-uat-flussi-mkt-biglietti
type: meeting
status: resolved
owner: Elena Spini
org: both
raised: 2026-10-16
updated: 2026-10-16
source: meetings/2026-10-16-uat-flussi-mkt-biglietti-transcript.it.md
---

# 2026-10-16 UAT Flussi MKT Biglietti

**The marketing half of the ticket chain ran end to end in production for the
first time — invitation, nomination, PDF with QR — and the client's marketing
team reopened two logics that were already closed, on the morning after a scope
freeze was announced. The client won the argument on the renunciation buttons,
and a new configurable-reminder build was agreed that nobody had asked for
before today.**

**Source:** [meetings/2026-10-16-uat-flussi-mkt-biglietti-transcript.it.md](../../meetings/2026-10-16-uat-flussi-mkt-biglietti-transcript.it.md)
(full raw transcript plus the Gemini notes header, 141,076 bytes, 02:26:15).
Booked 10:00 CEST; the transcript opens at `00:01:37` and ends at `02:26:15`.

Participants, from the transcript header and from who actually speaks:
**Elena Spini, Aurel Mrruku, Fabrizio Mastracci** (ROMI) and **Sabatino
Rinaldi, Matteo Distaso, Rebecca Marmo, Fabrizio Paganelli, Elisa Migliano**
(Pienissimo). Marco Montesi and `amministrazione@pienissimo.com` are on the
invitation; neither speaks.

⚠ **Two attendance facts a reader needs.** Elena Spini **leaves at about
`02:09`** for another meeting, before the session ends, having said that any
decision taken in the client's own 15:00 internal meeting _"mette in
discussione il piano"_. Fabrizio Paganelli joins the marketing side of the
project **for the first time** — he and Fabrizio Mastracci introduce themselves
at `00:01:37` (_"non ci siamo mai sentiti, credo"_).

⚠ **Speaker labels and dictation are unreliable in the usual way.** The
transcript renders Andrea Parmeggiani as _"Parmegiani"_/_"Parmigiani"_,
Salesforce as _"Sales Force"_/_"salesource"_/_"ST force"_, `weight`/`wait` is
dictated interchangeably as _"weight"_, _"wait"_, _"weigh"_ and _"peso"_, and
`ODB` appears as _"DB"_, _"ODB"_, _"Dibsob"_ and _"DB Live"_. Read through
rather than normalised silently; square brackets mark every repair inside a
quotation.

## 1. The flow ran in production, with fake data

Elena Spini opened by setting the boundary (`00:06:47`): Marketing Cloud is
testable **only in production**, so part of the configuration was moved there
and today's test uses **fake data**, with a real-data simulation to follow.

> _"attualmente non abbiamo tutte le funzionalità in produzione. Come sapete
> Marketing Cloud è testabile solo in produzione. abbiamo portato parte delle
> configurazioni fatte per fare questo questo test. Ciò vuol dire che faremo
> dei test comunque con dei dati fake oggi"_

Fabrizio Mastracci described the build (`00:10:48`–`00:15:58`): **two Marketing
Cloud campaigns**, each containing a flow —

1. **`automazione richiesta conferma biglietto`** — sends the invitation
   newsletter **up to 11 times**, with WhatsApp to be added alongside once
   configured with Matteo Distaso. Three exit conditions, _"quelle che abbiamo
   concordato"_: the holder renounces, the holder fills in the ticket, or the
   event dates pass.
2. **`automazione invio biglietto assegnato`** — fires when the holder enters
   the participant data: creates the order line, generates the **PDF with QR
   code and liberatoria**, and mails the download link.

**It worked.** Sabatino Rinaldi received the invitation (`00:20:57`), filled in
the names of Matteo Distaso and Rebecca Marmo, and the ticket PDF arrived about
a minute later carrying the QR (`00:27:55`–`00:29:50`). He confirmed the QR
resolves to **the campaign member**, not the contact.

🟢 **The check-in side was confirmed in the same minutes** — see
[OI-161](../items/OI-161%20The%20event%20check-in%20app%20must%20integrate%20with%20Salesforce.md).
Elena Spini, at `00:04:05`, reading Andrea Parmeggiani's reply that had landed
that morning: _"è andato bene il test del QR code"_. Aurel Mrruku checked the
logs live and found **two** successful calls — one from Postman at ~18:00 and a
real one from the application at 22:54 the previous evening.

> **Elena Spini:** _"Quindi ha funzionato il tuo pressing ieri, Fabrizio.
> Bravo!"_

## 2. The renunciation buttons — the client won, against ROMI's stated advice

The longest and sharpest passage of the session (`00:22:38`–`01:05:15`), and it
reopens a logic the record had closed. See
[OI-242](../items/OI-242%20The%20community%20Rinuncia%20button%20must%20show%20the%20public%20refusal%20text.md).

**Elena Spini's position**, restated three times: a direct `accetta`/`rifiuta`
pair in the mail is **misleading**, because neither button performs the action —
both land on a community page where a second click is still required.

> _"anche se qua noi facciamo il tasto rifiuta, tu dovresti comunque finire su
> un'altra pagina e in una in un secondo momento dovresti comunque ricliccare
> un altro tasso. Quindi non è un'azione automatica"_

**Matteo Distaso's position**, held without moving: the refusal must be visible
**in the mail itself**, or the data is worthless.

> _"lui rifiuta nascosto in questa maniera, non ce lo farà mai sapere. … non
> vedono il rifiuta o non vogliono andare in un'altra pagina, sono pigri
> eccetera eccetera, non lo fanno."_
>
> _"i tassi di rifiuta noi dalla mail crolleranno … e noi attribuiremo sta cosa
> al fatto che la gente vuol venire ma poi ci troviamo le sale vuote"_

And, when Elena Spini argued the general case: _"E pensi male perché non
conosci i nostri clienti."_

**Aurel Mrruku set out the engineering objection** (`00:38:08`–`00:39:17`), and
it is the clearest statement of the risk in the record:

> _"Tu apri la mail in un cellulare, hai attiva rinuncia, per sbaglio hai fatto
> rinuncia, hai già spaccato tutto e hai perso tutti i biglietti."_
>
> _"cerchiamo di fare le cose non solo i happy path"_

He added two consequences nobody answered: that an `accetta` click should
**remove** the renunciation option, and that a holder invited to two events can
open the older mail and renounce a booking already accepted.

🔑 **ROMI conceded.** Elena Spini, `00:41:43`:

> _"se per i vostri clienti pensate che va bene così alziamo le mani e ci
> veniamo incontro in questo modo. Fare questo Fabrizio e Aurel non penso sia
> un problema."_

**What was agreed:**

| Change | Owner |
| --- | --- |
| `accetta` **and** `rifiuta` buttons in the invitation mail, **both pointing at the same landing page** | Matteo Distaso, Rebecca Marmo (copy) |
| A **double-confirm pop-up** on the renunciation page — _"La rinuncia è definitiva. Sei veramente sicuro?"_ | Aurel Mrruku |
| **Enlarge** the renunciation button, and check the mobile rendering | Aurel Mrruku |

Aurel Mrruku confirmed feasibility without qualification — _"è completamente è
tutta custom questa pagina, quindi possiamo fare tutto quello che serve"_ —
while asking that it still look reasonable on mobile.

⚠ **An existing logic was restated and limits the concession.** Once the first
participant name is entered, the first ticket is issued immediately and
**renunciation is no longer possible for that block** (`00:25:11`). So the mail
can carry a `rifiuta` button that, for a partly-nominated order, lands on a page
with no renunciation control. Elena Spini said this aloud; nobody treated it as
a problem to solve.

🔴 **Rebecca Marmo's follow-up became a Fase 2 deferral** —
[OI-253](../items/OI-253%20Restoring%20a%20ticket%20after%20an%20accidental%20rinuncia%20is%20Fase%202.md).
Asked whether a mistakenly renounced ticket can be made available again
(`00:43:08`), Aurel Mrruku answered _"quando si rinuncia si rinuncia a tutto"_
and Elena Spini deferred the edge cases:

> _"lo tracciamo come caso limite della fase due, ma adesso dobbiamo andare
> avanti"_

⚠ **So the client obtained the button it was warned about and the recovery path
for its misuse in the same session, with the button in Fase 1 and the recovery
in Fase 2.**

## 3. Click tracking — a vocabulary problem, not a capability problem

`00:47:33`–`00:58:54`. Matteo Distaso asked repeatedly whether clicking a button
in a mail can apply a **tag** that routes the lead into a dedicated funnel. The
answer took ten minutes to land because **Salesforce has no "tags"** in the
sense he meant.

Resolved as: click and open tracking exist (Fabrizio Mastracci showed the send
dashboard with per-record opens and clicks for Sabatino Rinaldi); routing is
built with **decision splits**; and writing the interest back to the CRM _"si
può fare"_ but needs **a session of its own**.

⚠ Recorded because it is the second time a marketing capability question has
been answered with "possible, but separately" and no session has been booked.

## 4. The reminder wait intervals — new scope, on the morning after the freeze

`01:08:27`–`01:33:00`, and the substantive build change of the session. See
[OI-250](../items/OI-250%20The%20reminder%20wait%20intervals%20must%20be%20configurable%20per%20edizione.md).

The build has **one** `weight interval` field on the Edizione campaign: a single
number of days applied between every one of the 11 sends. Rebecca Marmo, who
runs the sends, said that is not how she works:

> _"io dalla prima alla seconda mail passano due giorni, dalla terza alla quarta
> cinque, cioè variano"_
>
> _"quando programmo l'invio dei biglietti, weight me li calcolo io, guardo la
> il calendario e me li calcolo io a mano … magari non so il sabato preferisco
> non inviare comunicazioni, preferisco il venerdì"_

Fabrizio Mastracci explained why the interval cannot simply live in the journey:
a static step would be shared across every campaign using that journey, and a
dynamic one means duplicating the journey and reworking an 11-mail flow with a
loop each time (`01:12:09`).

**Aurel Mrruku proposed** auto-creating 11 child records (`weight 1` … `weight
11`) on the campaign, which the campaign owner edits by hand (`01:19:56`). He
demonstrated it with standard Tasks on screen, stating that the real thing would
be a custom object. Rebecca Marmo asked for **days of waiting, not dates** —
_"Io voglio giorni di attesa perché la data così ho paura che vada"_ — and Aurel
Mrruku accepted.

**Elena Spini then proposed the simpler form that was adopted** (`01:28:19`):

> _"anziché creare questi record, ma non si possono creare 11 campi che Rebecca
> deve compilare per forza quando crea la campagna … 11 campi di cui, ad
> esempio, se non c'è il valore perché non è presente, ne compila solo quattro,
> allora i reminder si bloccano"_

**Fabrizio Mastracci closed on the hybrid** (`01:31:13`): up to 11 fields on the
Edizione, a blank field meaning the send stops there, so an event with five
reminders fills five.

🔴 **Both builders flagged the cost.** Fabrizio Mastracci: _"io prima di tutto
sicuramente dipendo da Aurel che deve fare e deve portare in produzione una
cosa … e poi io devo ristravolgere"_. Aurel Mrruku added a second dependency
nobody has resolved — **who is allowed to edit the fields**:

> _"Dobbiamo anche capire questi campi quando possono essere modifi[cabili],
> permessi da capire chi lo deve fare questa cosa"_

🔑 **Elena Spini put the governance objection on the record herself:**

> _"avevamo provato a scrivervi in tutti i modi qual erano le logiche e ci
> troviamo sempre a ridosso di tutto a fare delle modifiche … Perché questa cosa
> dei weight è uscita al 16 di ottobre"_

⚠ **Nothing was decided.** Elisa Migliano asked whether a decision was needed
today and Elena Spini said no — _"Adesso vorrei solo capire se effettivamente
questa soluzione può avere senso"_ — pending the client's **internal 15:00
meeting**. Which means a build change landed in scope on 16 October, the day
after a freeze limited Fase 1 to _"affinamenti minori"_
([OI-243](../items/OI-243%20Go-live%20moved%20from%2021%20October%20to%202%20November.md)),
and **nobody in the room named the freeze**.

⚠ Rebecca Marmo's own view of why this surfaced late: _"Io pensavo di essere
stata abbastanza chiara nella mail degli 11 invi in cui il tempo non è fisso,
però a quanto pare non è stato chiaro."_ Fabrizio Mastracci replied that he had
sent her two mails asking for confirmation of the logics. **Neither mail is in
this repository** — see the trace.

## 5. Flexibility against the CRM — the architectural argument

`01:34:14`–`01:56:52`. Sabatino Rinaldi asked whether the funnels need to hang
off CRM campaigns at all, rather than off independent marketing lists:

> _"mi sembra di essere in una scatola troppo chiusa in termini di collegamento
> tra il marketing e il CRM. Io ho bisogno di estrema flessibilità"_

And the reason, which is the clearest statement of the client's risk appetite in
the record:

> _"se tra 9 mesi vogliamo svoltare il mondo del dell'invio biglietti … non
> iniziamo a smantellarlo tutto e ritornare agli errori che abbiamo fatto fino
> ad ora ad avere un CRM che è un macello"_

Elena Spini's answer separated the two cases: **arbitrary sends are free** —
_"ti prendi tutti i tuoi record che vuoi con delle logiche ci farai un'altra
nuova mail"_ — but **these two ticket flows are not**, because orders, payments,
tranches and assets hang off them.

> _"eventuali modifiche a questo flusso toccano tutto quello che abbiamo fatto
> sul CRM, quindi da prendere con le pinze"_

🟢 She committed to supplying **technical documentation and specifications** so
the client could modify the flow itself in two years' time. ⚠ No date, no owner,
no format — and it is the second undated documentation commitment in the record.

🟢 She also framed the single-flow design as a process gain the client must
adapt to, not a limitation — _"non vedete il fatto di avere un flusso unico per
ogni edizione come una limitazione, ma anzi deve essere vista come una
miglioria"_.

## 6. The Food Marketing Festival needs its own template

`01:47:48`–`01:55:09`. See
[OI-252](../items/OI-252%20The%20Food%20Marketing%20Festival%20needs%20its%20own%20journey%20template.md).

Rebecca Marmo and Sabatino Rinaldi named the one event the agreed design does
not fit: **free and paid tickets in the same event, three ticket types, and
funnels started reactively** —

> _"quest'anno abbiamo inviato prima solo ai gratuiti o prima solo quelli a
> pagamento. Guardavamo gli scarichi … molti vengono studiati qualche giorno,
> cioè oggi per domani"_

The **tour** was explicitly cleared as fitting the standard logic; the Food
Marketing Festival was not. It runs **once a year, most recently September**.

**Fabrizio Mastracci's solution:** leave a **duplicable template journey**
pointed at that single campaign, whose weights and mails Rebecca Marmo can
change freely without touching the standard flow. **With one condition**, which
is the part that matters:

> _"è importante che tu come ingresso … mantieni sempre lo stesso o comunque la
> stessa struttura di quello che ti ho dato io. Cioè, tu non puoi prendere un
> giorno, ti crei una lista CSV, la importi e dici voglio mandare le mail a
> tutte quelle persone perché questo comporta un errore"_

Elena Spini generalised it: the current flow is _"flusso standard"_; every later
special case becomes flow 2, 3, 4. ⚠ Rebecca Marmo proposed twice to duplicate
the flow per event and was told no both times, because the journey's entry
criteria key on the **Invito Evento** object rather than on the campaign.

## 7. ODB Live streaming will not generate a ticket

`01:59:11`–`02:07:18`. See
[OI-251](../items/OI-251%20ODB%20Live%20streaming%20must%20not%20generate%20a%20ticket.md).

Rebecca Marmo raised online events, believing every ticket goes through the one
funnel. Sabatino Rinaldi corrected her: **ODB Live has no tickets at all.**

> _"Sono si iscrivono a una diretta su Zoom. … ODB Live tu acquisti
> eventualmente su W[oo]commerce quel biglietto, quel prodotto che è un prodotto
> digitale, lo paghi €200, arriva su Mexal. … Non c'è da scaricare un biglietto,
> non c'è da far nulla."_

🟢 **The existing design already covers it.** Elena Spini: the product carries
_"genera biglietto, sì o no"_, driven from Mexal — so an article flagged no
produces no ticket in the CRM.

🔑 **Fabrizio Paganelli raised the one real objection** (`02:04:16`): with no
ticket there is no QR and no scan, so **attendance is not tracked**, and the
2028 edition would be indistinguishable from the 2027 one.

> _"nel l'ODB che ci sarà nel 2028 se non lo tieni monitorato ti trovi anche
> quelli del 2027"_

Sabatino Rinaldi answered that **Zoom** supplies registrants and actual
attendees — _"Zoom è uno strumento che ti traccia anche quanti peli nel naso ha
chi ha partecipato"_ — to be cross-referenced with the CRM. Fabrizio Paganelli
accepted and took the action:

> _"Allora, mi segno che l'ODB sarà un codice articolo senza generazione del
> biglietto e siamo a posto."_

⚠ **`Soldout` is a different case and was separated explicitly**: it has an
in-room component, so it is handled as an ordinary ticketed event.

## 8. The Salesforce–Zoom connector

`02:07:18`–`02:09:12`. See
[OI-255](../items/OI-255%20The%20Salesforce%20to%20Zoom%20connector%20is%20unverified.md).

Sabatino Rinaldi recalled asking **Andrea Galotto, before the contract was
signed**, whether Marketing Cloud connects directly to Zoom. Fabrizio Mastracci
suggested the answer had been about the CRM, not Marketing Cloud. Aurel Mrruku
confirmed _"c'è un connettore standard"_; Elena Spini preferred standard
connectors without committing; both flagged that capability depends on
documentation and on **Pienissimo's Zoom subscription tier**.

Sabatino Rinaldi closed it as not a worry — _"Anche se non ce lo fa stesso, se
lo faccio da solo non è un problema"_ — on the understanding that Zoom pulls
contact data from the CRM rather than the reverse.

⚠ **Nothing is established**: no connector named, no subscription tier known, no
owner, and a pre-contract conversation is being relied on. It now sits under the
ODB attendance design, which depends on Zoom data reaching the CRM.

## 9. Smaller findings

- 🔴 **A test contact's phone number did not reach the CRM** (`00:45:39`) —
  [OI-256](../items/OI-256%20A%20test%20contact%20phone%20number%20did%20not%20reach%20the%20CRM.md).
  Sabatino Rinaldi: _"È l'unico numero vero dei tre che ho messo"_, and it is
  absent. The room's explanation was contact reuse — he recalled a green
  _"numero trovato"_ / _"esiste già"_ message while nominating — and Aurel
  Mrruku noted they were in production. **Nobody verified it.**
- ⚠ **Connection problems cost the first ten minutes.** Rebecca Marmo, Sabatino
  Rinaldi and Matteo Distaso heard nothing until `00:09:56`. So the opening
  description of the two flows was delivered to a partial room, and the
  renunciation argument restarted material they had missed.
- ⚠ **A test artefact of record**: the invitation subject rendered as _"Test
  mark in edizione accad 26"_ and the confirmation as _"I partecipanti
  confermati partecipanti sono stati salvati"_. Elena Spini offered to make the
  latter _"più parlante"_; no owner was named.
- ⚠ **`Camerieri Venditori 2026` rendered once as _"Venditori 2006"_** in the
  mail Matteo Distaso received (`01:00:34`). Recorded as a transcript artefact
  rather than a defect — the edition name is correct elsewhere in the session —
  but it has not been checked against the campaign record.
