---
id: meeting-2026-09-28-tema-contratti
type: meeting
status: active
owner: Elena Spini
org: both
raised: 2026-09-28
updated: 2026-09-28
source: Drive, Trascrizione, 2026-09-28 10:02 CEST (doc 18mdBvZVFvBbNWbY5ccy7JWSeB1avvJxNLMwUBjHim4k, 60,638 characters, read in full)
---

# 2026-09-28 Tema Contratti e Open Point

**The client was asked whether the Contract object should exist, and answered by
giving it a purpose nobody in the record had stated: it is the customer's
contractual history, not a per-order appendix.** 28/09, 10:02 CEST, **1h03m02s**,
**Aurel Mrruku · Elena Spini · Fabrizio Paganelli**.

This is the session booked on 25/09 to put
[OI-141](../items/OI-141%20Contract%20object%20for%20Performance%20Plus%20orders.md)
and [OI-168](../items/OI-168%20Contract%20logic%20is%20not%20started%20and%20is%20on%20the%205%20October%20UAT.md)
to Fabrizio Paganelli, and it did. It also closed four other open points.

⚠ **No Gemini summary exists** — only the raw transcript. Fabrizio Paganelli had
forgotten the invitation and joined at `00:05:00` after Elena Spini telephoned
him; the first five minutes are Elena Spini and Aurel Mrruku alone.

⚠ **The transcript attributes the whole join sequence at `00:05:00` to Elena
Spini**, including Fabrizio Paganelli's own replies. Nothing in this note is
attributed from that passage.

## 🔑 The Contract survives, and its purpose is the opposite of what was recorded

ROMI went in intending to ask whether the object could be dropped — Aurel
Mrruku's 25/09 objection was that the tranches already hold the financial state.
He put the alternative to Fabrizio Paganelli directly (`00:10:00`): the five
fields can live **on the order**, _"sull'ordine mi sembra molto più sensato
perché … adesso l'ordine è il contenitore di tutte le tranche."_

Fabrizio Paganelli did not defend the object on a per-order basis. He reframed it:

> _"l'importante è che noi da qualche parte abbiamo un contenitore dove per ogni
> cliente io posso vedere quando è stato attivato da data a data, qual era
> l'importo complessivo, si è pagato tutto."_

The point is the **customer's contractual history across years and renewals** —
_"se magari è un cliente storico, io potrei avere anche 5 6 rinnovi, almeno in un
unico quadro, ho tutte le informazioni della storia contrattuale del cliente, non
solo del contratto collegato a quell'ordine."_ He was explicit that the
implementation is ROMI's call: _"dal punto di vista tecnico dove voi mettete
questa informazione mi interessa relativamente."_

🟢 **Aurel Mrruku accepted it on that basis**, and restated the reason in his own
words (`00:12:00`): _"il contratto praticamente non è che è collegato all'ordine,
è collegato al cliente, quindi serve un'entità."_ A report on one customer's
contract history then reads the Contract records, not the orders.

### Cardinality, settled in one exchange

🔑 **One Contract per order** — Fabrizio Paganelli: _"Ogni ordine avrà il suo
contratto e ogni ordine avrà i suoi tre quattro valori"_; Aurel Mrruku said the
same sentence first. The multi-year view is obtained by reading the Account's
several Contracts, **not** by pointing many orders at one Contract. Fabrizio
Paganelli had floated both shapes (`00:12:00`, _"1 a 1 ordine con contratto
oppure … 1 a n"_) and left the choice to ROMI; the 1:1 reading is what both then
worked from.

### The three financial fields, and where they come from

Fabrizio Paganelli named them as a progression (`00:17:00`):

| Field       | Meaning                                | Source                             |
| ----------- | -------------------------------------- | ---------------------------------- |
| `ordinato`  | the order value, set once              | the order                          |
| `fatturato` | invoiced to date, grows month by month | the nightly Mexal invoice read     |
| `incassato` | collected to date                      | the nightly Mexal payment read     |

Two derived readings he asked for by name: `ordinato − fatturato` is what remains
to invoice, and **`fatturato − incassato` is how punctual the customer is**.

🟢 Aurel Mrruku confirmed the mechanism and asked whether anything cleverer was
expected: _"Non mi aspetto qualcosa di molto particolare a livello logico su
queste informazioni a livello di contratto, vero?"_ — Fabrizio Paganelli: no.
**Amounts were used as illustrations in the call and are not recorded here** —
see [docs/publishing.md](../../docs/publishing.md).

### 🔑 `data di attivazione` is a distinct field, and the 12 months run from it

This corrects the record. `data inizio` / `data fine` are the order's own dates.
**`data di attivazione` is separate and manual**, because customers buy and then
defer: _"Ah, non mi attivate oggi perché ho il locale chiuso, attivatemi a marzo
quando riaprirò il locale."_ Fabrizio Paganelli: _"ci dovrà essere qualcuno che
scientemente andrà a riempire il campo data di attivazione … e da lì
decorreranno i 12 mesi."_ So the contract term is measured from activation, not
from signature or order.

### 🔑 New: `strategist` and `digital` as plain text fields

Fabrizio Paganelli asked for the two roles that follow a contract to be recorded
on it — **`strategist`** (a supervisor) and **`digital`** (the operator a
supervisor oversees), about **fifteen people in total**.

- **Plain text, not lookups.** They have **no Salesforce licence** and will not
  get one: _"Questi non avranno un'utenza sales force perché la userebbero solo
  per andare a metterci quel nome lì dentro … Non ha senso."_
- Aurel Mrruku twice offered a `Strategist` object instead; Fabrizio Paganelli
  accepted it as possible but chose text for now — _"poi magari questo qui sarà
  una cosa da mettere a posto bene nella fase tre o quattro o sette."_
- ⚠ **This resolves the long-standing `Strategist` ambiguity in
  [OI-141](../items/OI-141%20Contract%20object%20for%20Performance%20Plus%20orders.md)
  only partly.** The role now has a definition and a headcount. It still has **no
  named person**, and the note's earlier open question — who fills the service
  dates by hand — was not asked.
- Pienissimo already runs **its own internal platform** holding this assignment;
  Fabrizio Paganelli suggested it could later feed Salesforce automatically via
  Sabatino Rinaldi. **Not committed, no date.**

### What the client will do with the object

Three uses, at three levels, all of them reporting (`00:15:00`):

- **Direction:** how many customers are active today.
- **Commercial:** whose contract expires at the end of a given month, so the
  sales team can chase renewals — _"a fine di ottobre avete 10 clienti che
  scadono, quindi contattateli."_
- **Administration:** which customers to invoice this month.

⚠ These are the same reports the Business Blueprint specified as scheduled
weekly/monthly jobs, recorded in
[OI-168](../items/OI-168%20Contract%20logic%20is%20not%20started%20and%20is%20on%20the%205%20October%20UAT.md).
**Nothing in this session said who builds them or when.**

### Fields can still move

Aurel Mrruku deliberately left the field list soft: _"siccome sono campi che sono
popolati con una logica abbastanza semplice, quando faremo i test possiamo anche
indicare … più campi o meno campi. A me interessava proprio il concetto, il
legame tra le entità account, ordine, contratto."_ He expects more to surface
during testing. **The entity relationship is what was agreed; the field list is
not frozen.**

## 🟢 Credit notes and the payment correction are Fase 2, confirmed by the client

The one thing this session changes for
[OI-157](../items/OI-157%20Credit%20notes%20and%20storni%20are%20unbuilt%20and%20undefined.md):
it was ROMI's decision on 25/09 and **unconfirmed by the client**. Fabrizio
Paganelli confirmed it himself (`00:27:00`):

> _"rimandiamo sia al tema della nota di credito che questo qui alla fase due."_

His reasons, both new to the record:

1. **Volume:** _"la nota di credito ne facciamo poche, quindi fortunatamente …
   possiamo anche posticiparla e dare priorità ad altre cose."_
2. 🔑 **Mexal has no order behind a credit note.** _"mentre per le fatture
   abbiamo un ordine sottostante … per le note di credito su Mexal non passano
   gli ordini, quindi noi dovremmo fare la nota di credito a mano su Salesforce e
   la nota di credito a mano su Mexal."_ He compared it unfavourably with a
   previous employer's returns-order type and said the gestionale is _"un po'
   particolare"_ here. ⚠ **He asked for it to be verified** —
   _"questa cosa qui verifichiamola bene"_ — so this is his recollection, not a
   confirmed API fact. **Nobody was assigned the verification.**

The second item confirmed to Fase 2 is the **wrong-payment correction**: an
administration mis-registration that has already flowed through to the ticket,
needing the asset state walked back and the invoice re-applied. Elena Spini asked
for a dedicated edge-case pass _"una volta che abbiamo veramente strutturato il
tutto"_, and Fabrizio Paganelli agreed.

🔑 **Fase 2 will be released incrementally, not as one drop.** Elena Spini
proposed prioritising within it — _"possiamo fare rilasci dedicati pezzettino per
pezzettino"_ — and Aurel Mrruku backed it with the reason: _"il problema è
strutturare bene il data model e non mettere cose a metà"_, because production
bug bonifiche cost more than staged delivery. He drew the contrast explicitly:
**Fase 1 cannot be staged, because the structures must all exist for the Excel
migration to map onto.**

⚠ Fabrizio Paganelli asked **which months Fase 2 covers** and did not get an
answer — Elena Spini said the quotation is still to be done and she would send
the updated plan and a proposal **this week**. Still no dates.

## 🔑 Performance Plus products are identified by the Mexal article category

This is the session's second substantive ruling, and it settles how Salesforce
knows a product is a Plus product — an open question since
[OI-141](../items/OI-141%20Contract%20object%20for%20Performance%20Plus%20orders.md)
recorded that _"a specific product code … does not exist yet."_

The three of them read `Articoli Salesforce.xlsx` live on screen (`00:45:00`).
The answer is the existing Mexal **`categoria articolo`** field:

| Category | Meaning                                    | Order + Contract?                    |
| -------- | ------------------------------------------ | ------------------------------------ |
| `C10`    | Performance Plus — **attivazione**         | yes                                  |
| `C11`    | Performance Plus — **rinnovo**             | yes                                  |
| `C20`    | additional / spot services, incl. Google   | 🔴 **no** — an ordinary sale         |

Fabrizio Paganelli, on `C10` and `C11`: _"il C10 sono tutti codice articolo plus
il C11 sono tutti codici articolo plus rinnovo."_ And on `C20`: _"servizi spot
che vengono venduti, ma … su questi non è che deve essere generato un ordine, un
contratto, eccetera … è una vendita normale."_

🟢 **Aurel Mrruku dropped his own proposal in favour of this.** He had asked for a
Salesforce mapping table that Fabrizio Paganelli would maintain by hand; once the
category proved sufficient he withdrew it — _"Quindi non devi fare nessun altro
campo."_ He asked Elena Spini to write into the delivered documentation that
every product arriving with `C10` or `C11` is categorised as a Performance
product.

**What the flag is for:** filtering the product picker when a tutor builds a Plus
offer, so a non-Plus product cannot be chosen. Fabrizio Paganelli checked the
purpose — _"l'obiettivo è quello di aiutare il tutor nel momento di inserimento
dell'offerta"_ — and Aurel Mrruku confirmed it.

### ⚠ Google services were said both ways in one session

At `00:45:00` Fabrizio Paganelli said the Google services follow **the same logic
as Performance Plus** — _"anche qui c'è un contratto, c'è una data d'inizio, una
data a fine"_, smaller amounts and a shorter term. Five minutes later he
classified them under `C20` as ordinary sales with no order and no contract.

The reconciliation he offered himself: **if a signature flow is wanted for
Google, he will recode those article codes as `C10`/`C11`**, and they would then
behave as Plus and get a Contract. Elena Spini checked this back and Aurel Mrruku
confirmed it. 🔴 **Nobody decided.** Fabrizio Paganelli: _"Adesso non so … lo
segno."_

**So: the Contract stays Performance Plus only, as recorded on 25/09 — and the
client holds an unexercised option to bring Google services in by recoding.**

### 🔑 `Numero tranche` comes from the article, and the current Plus codes are to be replaced

Fabrizio Paganelli described how he intends to drive tranche creation
(`00:50:00`): the **article carries a tranche count**, and using that article on
an offer auto-creates that many equal instalments, editable afterwards. He plans
to create **one article code per tranche count** — his examples were a
four-tranche and a twelve-tranche variant — and to set the roughly twenty
existing `C10` codes to **`annullato`**:

> _"questi tutti questi qua li potrò mettere in stato di annullato … Ti potrò
> creare un nuovo codice articolo … con tranche."_

Aurel Mrruku tied this to the `Numero tranche` field already on the order,
which _"ci permette poi in automatico di dividere in base al numero di tranche il
prodotto sull'offerta."_ Only Fabrizio Paganelli creates tranches, as agreed on
25/09.

🔴 **He could not deliver the new codes on 28/09** — _"non penso di farcela
oggi"_ — because the article codes must be created in Mexal first. **No date was
given.** Aurel Mrruku said he would instead edit the existing UAT products to
test, and Fabrizio Paganelli endorsed the shortcut: one four-tranche and one
twelve-tranche variant _"e hai già tracciato il 95% delle casistiche."_
⚠ **Next week is the Performance Plus UAT (05/10).**

## 🟢 `rifiutato` is settled, and it is a reason, not a state

The wording Fabrizio Paganelli and Marco Montesi both objected to on 24/09 — a
superseded quote marked `rifiutato` reads as a tutor's failure — was resolved
here (`01:00:00`).

His objection restated: _"a me mi piace il termine sostituito … perché rifiutato,
sembra qualche cosa che è incapace il tutor da vendere."_ Aurel Mrruku held the
state, on a case Fabrizio Paganelli accepted: a single quote on a lost
opportunity **is** genuinely refused.

🔑 **The agreed shape:** the state stays **`Rifiutato`**; the accompanying
flag/reason changes from `per scelta altro preventivo` to **`sostituito da altro
preventivo`**. Aurel Mrruku: _"Invece di scrivere per scelta [tra] l'altro
preventivo, facciamo sostituito."_ Elena Spini took it down as _"sostituito da
altro preventivo."_ When one quote is signed, the others move to `Rifiutato`
carrying that reason, and Aurel Mrruku noted the statistic falls out of the flag.

🟢 **Also confirmed in the same passage:** several quotes can be worked **in
parallel** on one opportunity, and a quote can be **edited and made primary**
rather than superseded by a third — Fabrizio Paganelli had assumed a strict
version chain and Aurel Mrruku corrected him.

## 🔑 Permissions: everyone sees everything, and that is the client's decision

The first client statement on
[OI-186](../items/OI-186%20The%20Salesforce%20user%20list%20and%20profiles%20were%20never%20agreed%20with%20the%20client.md).

Fabrizio Paganelli initially reached for segregation — _"i commerciali dovranno
vedere delle cose che … noi in amministrazione vediamo cose che i commerciali non
possono vedere"_ — and reversed once Aurel Mrruku spelled out what the phrase
meant at record level (a commerciale seeing another's orders and accounts):

> _"adesso è così, eh, e tutti i commerciali vedono tutto … è una modalità che
> non mi sento di disapplicare, nel senso che poi dopo corriamo il rischio che
> stravolgiamo troppo il modo di lavorare."_

🔑 **The rule, in his words:** _"facciamo che al momento tutti vedono tutto e poi
l'importante è che non tutti possano modificare tutto."_ Visibility is open;
**editing is what gets restricted**, plus field-level exceptions.

🔑 **His reason is a Zoho incident, and it is a requirement in itself.** Someone
changed configuration without telling anyone and **his invoicing stopped for
days**: _"uno per risolvere una cosa del suo reparto faceva i danni agli altri …
mi si è bloccata la fatturazione perché Tizio era andato dentro, aveva toccato
determinate cose."_ He wants configuration structures locked to named people,
with a request route for exceptions — _"sarei più favorevole a blindare
determinati profili, a fare determinate cose, solo le cose del loro reparto."_

🟢 **Shape agreed:** Elena Spini proposed _"forse uno o due profili, ma … forse
già solo uno e poi andiamo di permessi"_; Aurel Mrruku ruled **roles out
entirely** — _"ruoli poco, siccome tutti vedono tutto, non vedo utilità."_ So
**one profile plus permission sets, no role hierarchy.** This supersedes the four
profiles inferred from the org chart.

🔴 **Deferred, deliberately:** which functions get an ad-hoc permission is to be
decided **after** UAT, once the record life cycles are visible. Aurel Mrruku:
_"alla fine dei test dobbiamo definire … ci dovete dire questa roba si deve fare
solo da questa persona."_ Fabrizio Paganelli agreed.

🔴 **The user list was not asked for and was not given.** It was the second thing
this session was supposed to obtain. Elena Spini named it as a red flag in
`#tproj-pienissimo` ninety minutes earlier; it did not come up in the call.

## 🟢 DocuSign credentials, closed within the hour

Elena Spini raised the missing DocuSign access (`00:31:00`). Fabrizio Paganelli
had not known it was outstanding — _"Ah, vi servivano gli accessi"_ — and
undertook to chase Elisa Migliano himself, who was out of the office: _"Vedo di
fare in modo che ve lo giro io."_

🟢 **They arrived by mail at 10:27Z**, roughly twenty-five minutes after he said
it, and Elena Spini confirmed receipt to Aurel Mrruku on Slack at 12:44 CEST.
**The values are not recorded anywhere in this repository** — see
[OI-111](../items/OI-111%20DocuSign%20licences%20are%20not%20confirmed%20with%20the%20client.md).

## Data quality: about twenty dirty Accounts, and the client will fix them

Aurel Mrruku reported the agent-code problem found during the imports — _"una
ventina di dati che mi davano problemi soprattutto sugli agenti, perché è stato
usato un codice su diversi nomi"_ — and that he has provisionally taken the last
value because the environment is UAT. Fabrizio Paganelli accepted the cleanup
without argument: _"Dopo se sono solo 20 li mettiamo a posto, dai, quello non è
un problema."_

⚠ **The real decision is deferred to production**, and Aurel Mrruku said the full
load may surface more: _"Poi devo caricare tutto il resto e lì si vedrà."_
Fabrizio Paganelli, twice: _"lì ne vedrai delle belle."_ Elena Spini kept the row
open _"comunque per tracciamento."_

## Dates and availability

- 🔴 **Pienissimo is unreachable on Tuesday 29/09.** Fabrizio Paganelli:
  _"domani … siamo irreperibili praticamente, quindi domani non ce la facciamo in
  nessun modo"_ — their biggest company event of the year.
- **Next contact agreed in the call: Wednesday 30/09**, which is the tickets /
  campaigns / events UAT.
- ⚠ **This conflicts with a Slack DM.** At 13:01 CEST — three hours after the
  call — Elena Spini told Aurel Mrruku _"Fabrizio ha confermato per domani
  mattina"_, i.e. Tuesday 29/09 morning, keeping an internal evening check as
  well. **Which of the two holds is unresolved**, and the recorded session is the
  later-spoken of the two only by minutes. Do not assume either.

## Outstanding at the end of the session

| Owed by           | What                                                          | Date  |
| ----------------- | ------------------------------------------------------------- | ----- |
| Fabrizio Paganelli | new Plus article codes with tranche counts, created in Mexal   | 🔴 none |
| Fabrizio Paganelli | whether Google services get the Plus contract flow            | 🔴 none |
| Sabatino Rinaldi   | the Web Form templates                                        | 🔴 none |
| the client         | the user list                                                 | 🔴 none |
| Elena Spini        | the Fase 2 plan and quotation                                 | this week |
| Elena Spini        | the functional document on user organisation and permissions   | this week |
| Elena Spini        | the quote signature-point PDF, to the client for review        | 🔴 none |
| unassigned         | verify that Mexal really has no order behind a credit note     | 🔴 none |
