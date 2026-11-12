---
id: OI-329
type: open-item
status: in-progress
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: both
raised: 2026-11-04
updated: 2026-11-12
depends_on: []
blocks: [go-live]
requirement: ORD-01
source: notes/meetings/2026-11-04 Continuazione Test e2e PROD.md
---

# OI-329 - Tranches must be mandatory and the quote PDF blocked without them

**The client reversed an agreed rule on 4 November: a quote may no longer be sent
without tranches. The enforcement point chosen is the PDF — if any line lacks a
payment due date or a tranche, the quote PDF cannot be generated. Aurel Mrruku
accepted it on the call and said he was already working on it the same evening.**

## The reversal

🔑 **Tranches were optional by agreement.** Aurel Mrruku, on the call: _"avevamo
detto che puoi fare anche preventivi senza tranche. Ovviamente poi deve essere
pagato tutto per mettere i biglietti disponibili."_ That is the behaviour the org
carries today, and the quote Fabrizio Paganelli had open proved it — _"vedi che in
questo qui scadenza di pagamento è nulla"_.

🔴 **The client's reason is the tutors.** Fabrizio Paganelli, in
[the 04/11 session](../meetings/2026-11-04%20Continuazione%20Test%20e2e%20PROD.md):

> _"il rischio qual è? Che i tutor che sono degli smanettoni prendono, fanno un
> ordine tipo questo, buttano dentro, lo mandano al cliente e si dimenticano di
> metterci qui le tranche."_
>
> _"Le tranche le mettono, le devono mettere dappertutto perché dopo noi dobbiamo
> sapere che cosa dobbiamo fatturare."_

## The mechanism, as agreed

Aurel Mrruku offered the two candidate enforcement points and recommended the
cheaper one:

- **Required field on the product-entry screen** — _"Dobbiamo cambiare un attimo
  UI quando tu inserisci i prodotti … sull'offerta praticamente."_
- 🟢 **A check at PDF generation** — _"forse quando generiamo il preventivo
  possiamo fare un check. Se non hai le tranche non puoi generare il preventivo,
  così li costringi a fare le tranche."_ Fabrizio Paganelli: _"Se ti è più facile,
  sì, va bene lo stesso."_

Fabrizio Paganelli then set the strength of the test himself — **per line, on the
due date, not just "at least one tranche exists"**: _"se manca la data di scadenza
su almeno una riga non si può generare PDF"_. Aurel Mrruku flagged it as severe
and deferred to the client: _"è un po' forte come \[regola\] … Ok, siete voi il
cliente. Quindi decisione vostra. Per me non cambia niente. Basta che faccia un
controllo che non puoi generare il PDF."_

He restated the undertaking twice more: _"Io farò in modo che tu non puoi fare
genera PDF qua se non hai una tranche"_ and _"Allora, tranche obbligatorio. Ok,
tracciato tutto."_

## Where it stands

🟢 **Aurel Mrruku was working on it the same evening.** Elena Spini on Slack at
16:46 CET: _"per te è facile?"_ → 16:52 _"fattibile, mi sto occupando di questo"_.
🔴 **Nothing is in the repository**: `DevMain` was clean at this sweep and no
commit on 4 November touches quote PDF generation.

## Why it matters beyond the UI

- The **vendite da palco** path is exempt in practice — Fabrizio Paganelli:
  _"nelle vendite da palco il problema non si pone … Bisogna crearlo apposta,
  però qui glielo metterei."_ ⚠ **Whether the block must spare that path is not
  stated**, and R0 generates a document from an Order, not a Quote
  ([OI-322](OI-322%20The%20DocuSign%20return%20trigger%20only%20handles%20quotes%20not%20orders.md)).
- A quote with no tranche cannot be invoiced in instalments, which is the whole
  Performance Plus model, and it is why the asset stays `ordinato` until the full
  amount is paid.

## Register status

⚠ **This changes agreed behaviour and the register does not record it.**
`ORD-01` in `requirements/pienissimo-requirements.yaml` describes a guided action
that creates each tranche after products are selected; neither it nor the
`tranche` state machine says tranches are optional or mandatory. **Treated as a
v1.7 candidate and deliberately not written into the register** — the register is
contract-bound and is not restructured from a note, the same handling the three
13/10 `Concordato` rulings got. The Italian prose the client signs is untouched.

**Closing it:** a quote line with no payment due date, and `Genera PDF` refusing
with a message the tutor can act on — demonstrated in UAT, then in production.

## 🔑 2026-11-12 - the rule bit the client on his own products

**The mandatory-tranche rule is live in production and the client hit it the same
afternoon, on the product registry rather than the quote.**

Fabrizio Paganelli, **2026-11-12 16:51:13Z**, `Anagrafica Articoli`
(`1a1d0abac99f5ad4`):

> _"state lavorando sull'anagrafica articoli? Perche ci sono alcune cose su cui non
> mi ritrovo, **anche rispetto ai test che avevo fatto**"_

Aurel Mrruku, 17:14:53Z: _"Sto facendo dei rilasci in prod in questo momento. Mi
puoi spiegare cosa non torna? **I prodotti plus devono avere delle tranche.**"_

🔑 The mail was read live on the
[internal call](../meetings/2026-11-12%20INTERNA%20Modifiche%20Marco.md) and
diagnosed from the screenshot: the error is **`Numero tranche non configurato sul
prodotto plus`**, with `Numero tranche` at zero. The cause is configuration, not
code — the value must be set **on the product in Salesforce**, not in Mexal:
_"i prodotti … quando avvengono su sales force deve mettere il numero
tran\[che\]"_ · Elena Spini: _"lui deve andare su Performance \[Plus\] tranche
mensile … 1 deve mettere, quindi mi aspetto che non l'abbia fatto."_

⚠ **No reply had been sent to him when this sweep ran.** The diagnosis exists only
in the internal call. 🔑 And it is a predictable consequence of making tranches
mandatory: every existing `plus` product in the registry needs `Numero tranche`
set, and nothing records a sweep of them.
