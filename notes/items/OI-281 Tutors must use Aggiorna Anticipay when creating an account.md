---
id: OI-281
type: open-item
status: open
owner: Fabrizio Paganelli
org: Pienissimo
raised: 2026-10-21
updated: 2026-10-21
depends_on: [OI-246]
blocks: []
severity: normal
source: notes/meetings/2026-10-21 Check Dati Migrazione e OP.md
---

# OI-281 - Tutors must use Aggiorna Anticipay when creating an account

**A tutor can create an account with nothing but a VAT number and a made-up
company name, and the contract DocuSign sends out will carry that name. The
Anticipay lookup that would correct it runs later, when the order is sent to
Mexal. Three technical fixes were considered and all three were dropped; the
agreed control is training and instruction only.**

Discussed at length, `02:23:20`–`02:43:18`, in
[the 21/10 morning session](../meetings/2026-10-21%20Check%20Dati%20Migrazione%20e%20OP.md).

## The exposure, in the client's words

Fabrizio Paganelli, who had done exactly this earlier in the same call:

> _"conosco i miei polli, i tutor e i commerciali molto spesso ragionano in modo a
> volte anche sm[an]ato … metto la partita IVA, scrivo test Fabrizio e poi vado
> avanti perché dico 'Ah, ci pensa l'amministrazione' … Se noi mandiamo [i]l
> contratto da firmare prima che ci sia stata la chiamata verso Anticip[ay], sul
> contratto ci viene fuori che l'azienda pienissimo in accordo con l'azienda test
> Fabrizio."_

And why it is not cosmetic:

> _"potrebbe succedere che se con questo cliente noi andiamo in contestazione un
> domani perché magari smette di pagare … non possiamo andare dall'avvocato e
> produrre un contratto dove dentro c'è una dicitura sbagliata."_

🔑 **The root cause is a cost decision the client made themselves**, as Aurel
Mrruku pointed out: _"siete stati voi che avete detto che per non spendere soldi
non dobbiamo fare le chiamate anticip[ay] ogni volta che si [fa] un
aggiornamento."_

## Why the flow is ordered the way it is

Confirmed in the call: the Anticipay call fires **after** quote acceptance and
contract signature, as the first step of order transmission, and only when the
account has no Mexal code. So at the moment the contract is sent, the customer
code does not exist — Aurel Mrruku: _"non c'è"_, _"arriva dopo."_

## The three rejected fixes

| Option | Why it was dropped |
| ------ | ------------------ |
| Move the Anticipay call to quote send | Would fire on every send — a customer can receive five quotes before becoming a Mexal customer. Aurel Mrruku: _"lo devi fare ogni volta."_ Fabrizio Paganelli: _"non ha senso farlo tutte le volte perché dopo diventa casino."_ |
| A confirmation pop-up before sending, offering the check | Same per-send cost, and Aurel Mrruku located the real boundary: _"il check lo deve fare prima di generare il documento, non sull'invio del documento."_ Elena Spini disagreed with dropping it — _"Come non ha senso? Secondo me ha senso più"_ — and was overruled. |
| Account approval states, so an unconfirmed account cannot be quoted | 🔑 **Both sides said this is what large organisations do and both walked away from it.** Aurel Mrruku: _"Quando viene generato un account azienda c'è uno stato di quell'account e se quello stato … non è praticamente confermato, tu non puoi usare quell'account quando crei i preventivi."_ Fabrizio Paganelli: _"Dovrebbe essere così … nelle grandi aziende si fa così."_ Dropped on integration risk, not on cost: _"creare dei stati non è un problema. Il problema è spostare la l'integrazione"_ and the chained jobs behind it. Elena Spini closed it: _"penso che abbiamo altri problemi molto più grossi da gestire prima di questo."_ |

## 🟡 What was actually agreed

**Nothing in code.** Fabrizio Paganelli: _"lasciamo stare come tutto il flusso che
abbiamo visto … Il problema che ci sia un account non aggiornato lo risolviamo a
monte facendo in modo che nell'anagrafica degli account i tutor quando
inseriscono un account nuovo devono … cliccare su aggiorna anticipay."_

Delivered by training, which he will give himself and described in his own
terms: _"quando faremo la formazione gli diciamo noi … smettete di fare le capre
come avete fatto fino ad oggi quando create i clienti li create bene."_ Elena
Spini: _"Ma è una cosa che diremo ai tutor che dovranno fare."_

🟢 The duplicate call is harmless: pressing the button early does not stop the
later automatic check, and the button stops working once a Mexal code exists.

## Still open

- 🔴 **The control is a human habit with no system backstop**, by explicit
  decision. Any tutor who skips the button still gets a contract with whatever
  they typed.
- ⚠ It depends on key-user training, which
  [OI-246](OI-246%20Key%20User%20training%20cannot%20be%20completed%20before%20the%20new%20go-live.md)
  records as not yet scheduled against the new date.
- ⚠ Stage sales are a separate case the client raised and did not close: there
  the invoice goes out before the contract, so the exposure differs —
  _"sui le vendite da palco non abbiamo il problema del contratto perché
  fatturiamo prima di mandargli il contratto."_ He undertook to retest with
  deliberate errors with Elisa Migliano and come back; not yet reported.
