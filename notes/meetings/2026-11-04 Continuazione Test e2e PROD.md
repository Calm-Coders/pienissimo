---
id: meeting-2026-11-04-continuazione-test-e2e-prod
type: meeting
status: resolved
owner: Aurel Mrruku
org: both
raised: 2026-11-04
updated: 2026-11-04
depends_on: []
blocks: [go-live]
source: meetings/2026-11-04-continuazione-test-e2e-prod-transcript.it.md
---

# 2026-11-04 - Continuazione Test e2e PROD

**The second production end-to-end session, 01:49:12, Aurel Mrruku and Fabrizio
Paganelli alone with Elisa Migliano beside him off-camera. The chain ran again in
production and this time it ran further than ever: a quote with two tranche →
DocuSign → signed → Salesforce order → Mexal order `OC157` **carrying the quote
number in the header note** → a partial invoice of one tranche → a manual cash
collection → `Scadenza Fattura` `pagato` → **only the invoiced tranche's asset
became `Disponibile`**. Four new build requests came out of it, the ticket email
fired for `ordinato` assets a second time, and the single largest unsolved thing
in the session is that **none of it can be reversed**.**

## Attendees

- **Aurel Mrruku** (ROMI)
- **Fabrizio Paganelli** (Pienissimo) — drove the whole session from his own user
  in the production org
- **Elisa Migliano** (Pienissimo) — present at Fabrizio Paganelli's desk, speaks
  several times, not a separate connection: _"così dai vede anche l'Elisa, tanto
  siamo qui uno di fianco all'altro"_
- 🔴 **Elena Spini** (ROMI) — invited, did not attend. She said so herself on Slack
  at 16:40 CET: _"come è andata con Pienissimo?"_ / 18:26 _"io non sono riuscita a
  partecipare"_
- 🔴 **Sabatino Rinaldi** — not on the invitation

⚠ **The last six minutes of the recording are not the meeting.** Aurel Mrruku
left at ~01:35; Fabrizio Paganelli stayed on the open line talking to Elisa
Migliano and a colleague about internal Pienissimo matters. Those minutes are
preserved in the transcript and are used here only for the two facts they settle
(the Referenti file's date, and the Pienissimo 360 insoluti page).

## Sources

- **No recording and no separate transcript document exist.** The Drive meeting
  folder `19s_fxPIIpb1E3Jmd54MLusZ5QQzI_tqP` holds **one shortcut only**, to the
  Gemini notes document. 🔑 **Third consecutive session with that pattern.**
- The Gemini notes document `1Up4-utEa2OhAqeo-m3GJVeaJ4SxqGShtW7NNtVBa6_U`
  (97,357 chars) carries **both the auto-notes and the full transcript** on a
  second tab. This note is drilled from **the transcript, read once, in order, in
  full**; the auto-notes were used only as a cross-check. Transcript preserved at
  `meetings/2026-11-04-continuazione-test-e2e-prod-transcript.it.md`.

## 🟢🔑 What worked, and it is more than last time

| Step                      | Result                                                                                 |
| ------------------------- | -------------------------------------------------------------------------------------- |
| Opportunity + quote       | Created in production, `bonifico fine mese data fattura`                               |
| Products with a discount  | Academy 2 + Mastery, 10% — _"Lo sconto va bene adesso"_                                |
| Two tranche               | Created, one due 31/12/2026                                                            |
| Quote PDF                 | Generated, sent, **signed through the real DocuSign connector**                         |
| Salesforce order          | Created on signature, state `Ordinato`                                                  |
| Mexal order               | **`OC157`** — found in Mexal on the sezionale                                            |
| 🔑 **Order header note**  | **`nota 07` present on the Mexal document** — see below                                 |
| Partial invoice           | One tranche only, 4.830 €, due 31/12/2026, discount correct, e-invoice reference present |
| Invoice back to SF        | Returned through `MexalInvoiceSyncJob`, 4.830 €                                         |
| Manual cash collection    | Registered in Mexal prima nota, causale IC                                              |
| 🔑 **Partial settlement** | `Scadenza Fattura` → `pagato`, **and only the invoiced tranche's asset → `Disponibile`** |

🟢🔑 **The partial path is the new result.** On 3 November the chain was proved
whole; on 4 November it was proved **divisible** — one tranche invoiced and
collected moved exactly one asset to `Disponibile` and left the rest `ordinato`.
Fabrizio Paganelli: _"Gli asset sono disponibili perché ho fatturato prima la
maschera"_; Aurel Mrruku: _"Ah, è fatturato solo una tranche. Perfetto, perfetto.
Sta funzionando."_

A second, larger order (five Mastery, ~34.000 €) was then put through invoiced and
collected in full, with the same result: _"vai sugli asset per vedere che se sono
diventati disponibili"_ → _"Disponibili."_ → _"Una meraviglia."_

## 🟢🔑 OI-306 is finished — the quote number is on the Mexal document in production

Aurel Mrruku opened the call having deployed the `nota` array fix to production
that morning: _"Ho avuto tanti problemi su quella nota perché la struttura che ci
ha dato lui non andava bene, ma finalmente ho trovato serviva un array … prima di
pranzo sono andato in produzione."_

Then it was read off the Mexal screen: _"Vai, aprilo. E hai anche nota. Vedi nota
07?"_ → Fabrizio Paganelli: _"Ah, perfetto, perfetto."_ And on the invoice printed
from it: _"Qui c'è la nota riferimento al preventivo numero del …"_

🔑 **This is the closing evidence for
[OI-306](../items/OI-306%20The%20WooCommerce%20order%20number%20must%20reach%20Mexal%20in%20the%20order%20header%20note.md)**,
whose record as of this morning still said Prod carried the rejected string form.
⚠ The transcript does not state the `nota` maximum length; that one sub-question
stays unanswered.

## 🔴🔑 Nothing can go backwards — the session's biggest finding

Fabrizio Paganelli asked the obvious operational question: _"se io mi accorgo che
questo incasso l'ho registrato male, cosa facciamo noi? Eliminiamo l'incasso.
Questa rata qui che l'avevo chiusa, la riapro"_ — and then did it on screen. The
`Scadenza Fattura` went back to unpaid, and the asset **stayed `Disponibile`**.

Aurel Mrruku, naming the design: _"se sei andato in incassato noi abbiamo fatto in
modo che tu non puoi tornare mai più dietro indietro … è tutto il meccanismo che
era con un path, quindi con una via solo in avanti. **Adesso dobbiamo fare in modo
che anche se sei incassato tu devi poter tornare indietro se aggiorni lo
scadenzario.**"_

🔑 **This is not hypothetical, it is the client's monthly banking cycle.** Fabrizio
Paganelli described the Ri.Ba. return flow he and Mirko Merendi designed earlier:
the file goes out on the 20th, the customer's rate closes as paid _"salvo buon
fine"_, and on the 1st of the next month the bank returns which ones were never
collected — _"Andiamo in contabilità e riapriamo la rata. Facciamo in modo
automatico quello che hai visto fare manualmente a me adesso."_

🔴 **And the ticket may already be gone.** Aurel Mrruku: _"Tu pensi di aver
aggiustato la fattura, ma è già partito il biglietto."_ His two candidate remedies,
neither chosen: send tickets only in an evening batch so there is a day to correct
accounting, or gate the send some other way. Fabrizio Paganelli rejected the batch
idea for the normal case — _"i biglietti non possono essere mandati via ogni sera …
a ridosso dell'evento forse anche sì, però normalmente no"_ — and narrowed the
exposure himself: it only bites when a collection lands inside the ticket-send
window before the event.

Routed, not solved: _"ci sono diversi corner case che dobbiamo essere molto molto
attenti a gestire con dei flussi ad hoc per questi casi qua"_, with Elena Spini,
Fabrizio Mastracci and Rebecca to be brought in, and Aurel Mrruku placing it in
**Fase 2** — _"dobbiamo fare attenzione nella fase due"_. Fabrizio Paganelli
agreed the framing: _"Fase due. Questo era."_ → [OI-331](../items/OI-331%20A%20reversed%20collection%20cannot%20move%20the%20order%20and%20asset%20states%20back.md).

## 🔴 The ticket email fired for `ordinato` assets again

Mid-test, with the assets still `ordinato`, Fabrizio Paganelli: _"Qui mi sono
arrivati i biglietti. Sono già arrivati."_ Aurel Mrruku: _"Là dobbiamo capire cosa
sta succedendo perché non è corretto."_

🔑 **The diagnosis moved on.** Looking at the asset list on screen — _"vedi, non
sono [disponibili] e sono in ordinato"_ — Aurel Mrruku put it on the marketing
flow, not on the event-link state: _"Molto probabilmente sta facendo il filtro in
modo sbagliato marketing e che non è disponibile … chi non sta prendendo
correttamente"_, and _"Penso che ha lasciato per lui aveva fatto un flow tipo un
mese e mezzo fa, penso che non l'ha aggiornato."_ He undertook a call with
Fabrizio Mastracci _"appena chiudo con te o domani mattina"_.

⚠ **A confound worth keeping**: Fabrizio Paganelli had set the Academy 27 mapping's
ticket-send date far out on purpose — _"ho messo data invio biglietto, tutto quanto
al 31/12/27 per il momento per evitare di far casino"_ — so the send happened
**outside** any plausible send window, which is itself evidence the date gate is
not being read.

🔴 **ROMI still owed the client an answer from yesterday and still has not sent
one.** On Slack at 16:51 CET Aurel Mrruku declined to write to Fabrizio Paganelli
today — _"oggi no, domani faccio dei controlli"_ — and Elena Spini took it to the
marketing group at 18:26 instead, telling Fabrizio Mastracci that _"i biglietti
vengono di nuovo inviati quando lo stato dell'asset è in ordinato"_ and promising
_"domani ti manderà lui i dettagli"_. →
[OI-313](../items/OI-313%20The%20ticket%20nomination%20email%20fired%20for%20assets%20still%20in%20ordinato.md).

## 🆕 Four build requests, all accepted by Aurel Mrruku on the call

1. 🆕🔑 **Tranches become mandatory, enforced by blocking the PDF.** Fabrizio
   Paganelli's risk: _"i tutor che sono degli smanettoni … fanno un ordine tipo
   questo, buttano dentro, lo mandano al cliente e si dimenticano di metterci qui
   le tranche."_ Aurel Mrruku restated the existing rule — _"avevamo detto che puoi
   fare anche preventivi senza tranche"_ — offered the cheaper enforcement point
   — _"forse quando generiamo il preventivo possiamo fare un check. Se non hai le
   tranche non puoi generare il preventivo, così li costringi a fare le tranche"_ —
   and Fabrizio Paganelli pushed it to the strong form: _"se manca la data di
   scadenza su almeno una riga non si può generare PDF … deve essere così Aurel,
   perché sennò ci fa morire gonfi."_ Aurel Mrruku: _"Ok, siete voi il cliente.
   Quindi decisione vostra."_ → [OI-329](../items/OI-329%20Tranches%20must%20be%20mandatory%20and%20the%20quote%20PDF%20blocked%20without%20them.md)
2. 🆕 **The product selection screen is not usable for more than a few lines** —
   horizontal or split layout, a delete icon (it exists on one screen only, _"Forse
   l'ho lasciato solo su … Lo devo mettere anche nell'altra schermata"_), wider
   columns to kill the inner scroll, and a line-total discount field in value next
   to the net price. → [OI-330](../items/OI-330%20The%20product%20selection%20screen%20is%20unusable%20for%20multiple%20products.md)
3. 🆕 **A quick action on the parent Account to create a Locale** — Aurel Mrruku:
   _"forse ti metto un pulsante direttamente sull'account padre di creare il
   locale"_. Folded into [OI-330](../items/OI-330%20The%20product%20selection%20screen%20is%20unusable%20for%20multiple%20products.md)
   as the second UI ask of the session, since both are Aurel Mrruku's own
   undertakings from the same twenty minutes.
4. 🆕 **The tranche amount on the Order** — Fabrizio Paganelli: _"non vedo
   l'importo della tranche"_. Aurel Mrruku confirmed the shape and the cost:
   _"devo fare un collegamento degli item con le tranche, devo fare una formula …
   si può fare, però"_, conditional on being reminded — _"se me lo ricordi poi"_.
   This is **[OI-205](../items/OI-205%20The%20tranche%20carries%20no%20value%20so%20the%20client%20cannot%20see%20what%20each%20one%20is%20worth.md)
   asked for by the client in his own words**, which that note recorded as an
   unconfirmed attribution.

## 🔑 The account import rule, stated plainly for the first time

Fabrizio Paganelli reopened the agent-code question he had settled a month ago and
could not reconstruct. Aurel Mrruku's script:

> _"Io non mi baso sul nome che hai tu sul file Excel, ma mi baso sul codice
> agente che ho io su Salesforce."_
>
> _"E prendo l'ultimo. Quindi se hai un codice agente 19, vado a vedere sul
> sistema chi è il codice agente 19."_
>
> _"E se per qualche motivo io non ce l'ho un codice agente su Salesforce, lo
> collego con 01."_

🔴 **And the client's own data breaks it.** Fabrizio Paganelli, on screen: Barbara
Giordani appears against five agent codes, _"ma sono sbagliati, va bene solo il
primo"_, and one of her accounts carries `610` — _"è 610 che è sbagliato"_. Aurel
Mrruku's answer is that the script will faithfully assign it anyway: _"ma se a me
arriva 610 si collegherà a Barbara Giordano … a prescindere di quello che mi passi
te."_ Fabrizio Paganelli took the correction work: _"te li devo mettere a posto
io"_, _"Io me lo sono segnato, ho capito il criterio e le prossime volte che te lo
manderò farò la stessa cosa."_ → [OI-332](../items/OI-332%20The%20account%20import%20keys%20on%20the%20Salesforce%20agent%20code%20and%20the%20client%20file%20is%20mis-coded.md)

## 🆕 Locali — the parent reference is the Mexal customer code

Aurel Mrruku: _"i locali devono avere il riferimento dell'account, quindi il
codice Mexal dell'account"_, and the consequence for an uncoded row: _"se un
locale non ha un'azienda, per me non è collegato a un parent, quindi non verrà mai
usato, perché quando fai le offerte lo devi per forza collegare a un'azienda."_
Fabrizio Paganelli, seeing the work: _"questa la vedo più dura. Comunque ci
proviamo."_

The file came 27 minutes after the call and the question was asked in writing —
_"ci sono molti locali senza codice cliente mexal. Li potete caricare
ugualmente?"_ — and settled the same hour. →
[OI-333](../items/OI-333%20Locali%20without%20a%20Mexal%20customer%20code%20will%20not%20be%20loaded.md)

Also demonstrated and confirmed working: creating a Locale as a child account,
`Tipologia Attività` multi-select, and the Locale and its activity type being
carried onto the quote automatically — from the parent **and** from the Locale,
_"è la stessa cosa, solo che sono due punti diversi di creazione delle
opportunità"_. Quotes remain company-only by design: _"i preventivi si devono
creare solo sulle aziende."_

## 🆕 The Mexal sync frequency is still only 03:00, and undecided

Aurel Mrruku: _"Io per il momento li ho lasciati solo alle 3:00 di mattina. Se poi
dobbiamo decidere quante volte al giorno fare questa cosa."_ The options canvassed
— every 6 hours, 07:00 for the tutors, lunchtime, 17:00, 20:00 to close the day,
Fabrizio Paganelli pushing for every two hours and _"una volta alle 9"_ — and the
brake, Aurel Mrruku: _"si può fare, ma non vorrei andare vicino ai limiti"_, with
`Integration_Log__c` as the safety net: _"se qualcosa va male capisco, lo posso
rimettere in piedi."_ Load sizing was done out loud: four Mexal calls per order,
~100 WooCommerce orders a day at the top, _"500 ordini al giorno non succederà
mai"_. **No frequency was chosen.** →
[OI-334](../items/OI-334%20The%20Mexal%20sync%20frequency%20is%20undecided%20and%20no%20job%20is%20scheduled%20in%20production.md)

⚠🔑 **And the premise is wrong.** A production inspection earlier the same day
found **no `Mexal%` CronTrigger in Prod at all** — the invoice and scadenzario sync
ran only because it was enqueued by hand. So the 03:00 job Aurel Mrruku described
to the client does not exist in the org he described it in.

## 🔴 Anticipay — no progress, and no date

Aurel Mrruku asked directly. Fabrizio Paganelli: _"oggi, domani abbiamo un evento,
quindi Andrea non c'è e ieri doveva preparare la cosa e non ce l'ha fatta."_ So
[OI-312](../items/OI-312%20Anticipay%20times%20out%20in%20production.md) is unmoved
a second day, the workaround stands — _"a sto punto io continuerei a usare questo
can qui"_ — and **still nobody has given a date**.

## 🆕 The quote PDF — one signature where there should be two

Signing on screen, Fabrizio Paganelli: _"Qui perché non c'è la firma?"_ on
`allegato B`. Aurel Mrruku: _"Non è stato previsto una firma là. Dalle indicazioni
la firma era là sopra"_, then contradicted himself from experience — _"almeno da
tutti i test che abbiamo fatto abbiamo avuto sempre due firme"_ — and Fabrizio
Paganelli agreed he remembered two. Unresolved. Aurel Mrruku asked for a written
document review instead: _"spendete mezz'ora, un'ora e vedete tutte le righe del
documento … se non vi torna qualcosa anche a livello di data firma oppure qualche
misspelling"_ — and one misspelling was found live, `prezzo neto` with one `t`,
Aurel Mrruku: _"Se vedi che non sono italiano."_ →
[OI-336](../items/OI-336%20The%20quote%20PDF%20allegato%20B%20has%20no%20signature%20field.md)

## 🆕 Two consecutive emails to the customer — raised, and closed as not fixable

Fabrizio Paganelli relayed Sabatino Rinaldi's concern: the customer gets the
DocuSign mail and the Salesforce acceptance mail _"due mail di fila consecutive"_
and may never notice the second. Aurel Mrruku closed it on the call: _"sono
processi completamente separati, capito? Non hai controllo della seconda mail. Poi
la seconda mail può arrivare anche dopo due giorni."_ **No item raised** — nothing
was asked for and nothing was promised. Recorded here so it is not re-raised as new.

## 🔴 A test page showed the client's management 280.000 € of insoluti

From the open line after Aurel Mrruku left. Daniela Morgese photographed a
Pienissimo 360 page showing **~280.000 € (quoted later as 298.000 €) of insoluti**
and called Fabrizio Paganelli to ask whether it was real. It is not: _"non è
assolutamente vero quel numero"_. The page is the unreleased insoluto-chasing
section — _"questo qui era il test che avevamo fatto per l'invio"_ — and it is
visible to the client's management. Agreed: Fabrizio Paganelli tells Daniela
Morgese it is a test, and asks Sabatino Rinaldi to hide it. →
[OI-335](../items/OI-335%20A%20Pienissimo%20360%20test%20page%20showed%20management%20280000%20euro%20of%20insoluti.md)

## 🔑 Migration — what was asked, what arrived, what is still owed

Aurel Mrruku's closing list: _"aspetto i vostri dati, quindi account, ordini,
contatti."_ Within the hour, three files arrived by mail:

| Time (UTC) | Mail                            | File                                            |
| ---------- | ------------------------------- | ----------------------------------------------- |
| 15:39      | `Anagrafica Account`            | `Account Salesforce (rev Agente).xlsx`          |
| 15:50      | `Lista Locali`                  | `Locali Salesforce.xlsx` — _"provvisoria"_      |
| 16:30      | `Import ORDINI - Testata e Riga` | `Import Ordini (versione del 2026.11.04).xlsx` |

⚠ **All three hold real customer records. Their existence is recorded; no values
are copied into the repository.**

🔴 **The Referenti half is still the hole**, and the 04/11 record finally says why.
On the call Aurel Mrruku was explicit about the shape he needs: _"i contatti devono
avere il codice Mexal al posto dell'ID dell'account, quindi ID Mexal sulla colonna
account"_, and about who owes it: _"i contatti che mi deve passare Sabatino."_ Then
by mail at 15:56 Fabrizio Paganelli answered: **_"Per i Referenti considerate il
file che vi abbiamo inviato l'ultima volta. La settimana prossima con Sabatino vi
invieremo l'aggiornamento."_** Aurel Mrruku objected at 16:05 — _"i referenti non
hanno il codice mexal del account… Non li posso collegare in produzione senza quel
valore"_ — and Fabrizio Paganelli's 16:21 reply put the burden back: _"Se non
ricordo male, vi avevamo già inviato un file con il codice mexal dell'account.
Potete verificare?"_ → [OI-290](../items/OI-290%20Lead%20and%20Referenti%20migration%20data%20is%20owed%20by%20the%20client.md)

🔑 **The post-call minutes date the file**: the Referenti extract ROMI holds is from
**27 or 28 October** — _"era del 27 o 28 ottobre se non ricordo male"_ — so it is
~a week stale, and the plan is to reuse it now and refresh it next week: _"te inizia
a dargli quello, poi glielo abbiamo aggiornato"_.

## 🔑 The production load is fixed for 12 and 13 November

Fabrizio Paganelli: _"il 12 e il 13 dobbiamo ricaricare di nuovo tutto … è il 12 e
il 13 che noi stacchiamo tutti i bottoni e loro fanno le importazioni"_, with
himself _"full su sta roba"_ on 10 and 11 November and absent on the 9th. ⚠ **He
also carries the Pienissimo 360 migration in the same window** — _"dal mio lato
c'ho anche Pienissimo 360, devo portarmi tutte le opportunity"_ — and said plainly
he cannot do it alone: _"ho bisogno che qualcuno su sta roba dei contatti mi dà una
mano. Non posso fare tutto da solo."_ →
[OI-310](../items/OI-310%20The%20production%20load%20needs%20a%20pre-load%20and%20a%20delta%20run.md)

## 🆕 Smaller things, recorded

- 🟢 The campaigns, the editions and the product-code mapping were rebuilt in
  production that morning: _"stamattina ho fatto anche tutta la mappatura delle
  campagne, delle edizioni e l'aggancio con i singoli codici prodotto"_ — the
  manual rebuild [OI-320](../items/OI-320%20Event%20and%20Edizione%20mappings%20cannot%20be%20moved%20between%20orgs.md)
  forced on him. ⚠ No volume and no duration stated.
- 🟢 Articles need no file: _"gli articoli non c'è bisogno che te li do perché li
  prendi da Mexal"_ — confirmed.
- 🆕 New product codes were created prefixed with the event name, _"tipo AC Academy
  PLP Live"_ — ⚠ **a sixth code convention**, unverified against
  [the codice rules](../The%20Regole%20Codifica%20Codici%20Articolo%20workbook.md).
- 🆕 Mexal payment condition code **20** was used and was correct — _"20 però era
  giusto, era quello che l'azienda ha scelto nell'ordine"_.
- ⚠ Fabrizio Paganelli deletes the Mexal test movements after each session —
  _"io su Mexal una volta che finiamo la call li vado a cancellare quei movimenti"_
  — while the Salesforce side of the same tests **cannot** be deleted
  ([OI-315](../items/OI-315%20Production%20test%20records%20cannot%20be%20deleted.md)).
- 🆕 The invoice numerators will have to be changed before go-live: _"dobbiamo
  modificare i numeratori"_. ⚠ No owner, no date, not in any record.
- 🆕 Aurel Mrruku owes Fabrizio Paganelli the invoice/collection script link by
  mail: _"magari rimandacelo via mail Aurel quel link"_. ⚠ Not sent as of this
  sweep.
- 🆕 Fabrizio Paganelli wants to attend the commercial training of **Wednesday 11
  November**; Aurel Mrruku had no invitation for it and said Elena Spini was
  probably waiting on Marco Montesi's confirmation — which arrived by mail at
  08:59Z the same morning.
- 🟢 The purpose of the day's orders was stated: real production data for the
  marketing test _"domani"_ with Fabrizio Mastracci and Elena Spini, _"che non
  abbiamo mai fatto un test in produzione reale"_ →
  [OI-311](../items/OI-311%20The%20marketing%20flow%20update%20needs%20clean%20test%20records.md).

## Where the auto-notes are wrong

Recorded because the skill warns about them and because four claims would have
entered the record as fact:

1. ❌ _"risolto un problema strutturale utilizzando un array in **FileMaker**"_ —
   there is no FileMaker here. The transcript has _"un modo strano che **fil
   maker** prendeva il valore"_, a mis-transcription inside a sentence about the
   **Mexal** `nota` field. The notes repeat the artefact as a system name.
2. ❌ _"**Maxal**"_ and _"**Zoom 360**"_ / _"**Pianissimo** 360"_ — Mexal and
   Pienissimo 360 throughout.
3. ❌ The notes place the insoluti discussion inside the meeting. It happened
   **after Aurel Mrruku left**, between Pienissimo staff on an open line, and ROMI
   was not party to it.
4. ❌ _"\[Fabrizio Paganelli, Elisa\] Revisiona documento"_ is listed as a next
   step with no mention that the trigger was **a missing signature field on
   allegato B**, which is the actual finding.
5. ⚠ The notes' `Decisioni → Concordato` block is accurate on all four counts
   (agent-code mapping, testing in production, product-layout rework, tranche
   obligation) and was used to cross-check this note.
