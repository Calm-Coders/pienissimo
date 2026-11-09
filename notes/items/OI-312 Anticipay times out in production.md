---
id: OI-312
type: open-item
status: open
owner: Fabrizio Paganelli
with: Andrea
org: both
raised: 2026-11-03
updated: 2026-11-09
depends_on: []
blocks: [go-live]
severity: gating
source: notes/meetings/2026-11-03 Test e2e PROD.md
---

# OI-312 - Anticipay times out in production

**The Anticipay P.IVA call does not answer in the production org. It waits 120
seconds and times out. Anticipay had told ROMI in writing that production was ready.
The first end-to-end production test had to continue without it.**

## What happened

In [the 3 November e2e session](../meetings/2026-11-03%20Test%20e2e%20PROD.md) Aurel
Mrruku created a test account in production and triggered the Anticipay lookup. It
returned nothing: _"non va. va in time out praticamente"_. The connector's wait is
**120 seconds**.

🔑 **Anticipay said production was fine.** Elena Spini re-read Andrea's mail live:
_"ha detto confermo, tutto ok, portate direttamente in produzione. Lui stesso non ci
aveva dato nient'altro."_ Fabrizio Paganelli's reading: _"si vede che hanno fatto
qualche cosa e si sono dimenticati."_

🔑 **The endpoints are Anticipay's to supply.** Aurel Mrruku corrected Elena Spini
explicitly: _"non è che diamo noi i puntamenti. Noi facciamo la chiamata verso di
loro. Sono loro che danno i puntamenti."_ So this is not a ROMI configuration item.

## Who owns it

**Fabrizio Paganelli phoned Andrea during the call.** Andrea would look at it
afterwards, not then: _"ci guardo io, dai, dopo, però non adesso"_. ⚠ **No deadline
was given and no update had arrived by the end of the day.**

## Why it matters now

1. 🔴 **It blocks the remaining production tests on any new account.** The decision on
   the call was to proceed with an existing good customer instead.
2. 🔑 **It is the long-standing question answered the wrong way.** _"Whether Anticipay
   answers in production"_ has been carried as unreachable for weeks. **It does
   not.**
3. 🔑 **It does not block an order.** By design a failure is not fatal — _"un errore
   di Anticipay non blocca l'invio"_ — so the go-live is not gated on it, but the
   data enrichment silently does not happen.
4. ⚠ **It interacts with the R0 contract flow.** [The functional analysis](../The%20stage%20sale%20contract%20functional%20analysis.md)
   records, as _"Dedotto, da confermare"_, that a failed P.IVA check still lets the
   order reach Mexal and the contract be generated. **With Anticipay timing out in
   production, that is the normal path, not the edge case.**

## 🔑 What Anticipay actually does, recorded for the first time

Aurel Mrruku, pressed by Elena Spini: it is **not a validation**. _"L'Anticipay non
ti fa un controllo, fa una chiamata e ha una risposta, prende il risultato della
risposta e lo mette su dei campi."_ A result comes back only for an **Italian** P.IVA
that Anticipay can find; for anything else _"fallisce sempre"_. It runs **only on an
account's first order**, and only when the account has no Mexal code and no
consolidated Anticipay flag.

⚠ **So a wrong-but-Italian P.IVA cannot be detected**, which is the limit case Elena
Spini raised and nobody answered: the order reaches Mexal and the contract goes out
with the wrong number. _"È un caso limite, però devono saperlo."_

⚠ **Aurel Mrruku speculated Pienissimo may already check Anticipay on the WooCommerce
side.** Not established.

## Related

- [The Anticipay middleware API contract](../The%20Anticipay%20middleware%20API%20contract.md)

## 🔴 2026-11-04 - a second day, no progress and still no date

Aurel Mrruku asked directly in
[the 04/11 session](../meetings/2026-11-04%20Continuazione%20Test%20e2e%20PROD.md):
_"Hai avuto notizie riguardo a quel time out limit che ricevevamo da Anticipay?"_

Fabrizio Paganelli: _"No, no. Oggi, domani abbiamo un evento, quindi **Andrea non
c'è** e ieri doveva preparare la cosa e **non ce l'ha fatta.**"_

So:

- 🔴 **Nothing was done on 3 November** despite the undertaking given on the call.
- 🔴 **Nothing will be done on 4 or 5 November** — Andrea is at an event.
- 🔴 **Still no date**, a second consecutive record.

🟡 **The workaround stands and is now the operating assumption**, not a stopgap —
Fabrizio Paganelli: _"a sto punto io continuerei a usare questo \[canale\] qui."_
The whole 04/11 production chain ran on it without incident, which means **the
production path is being proved out on a configuration that is not the intended
one.**

⚠ The two unanswered questions from 03/11 are unchanged: whether Pienissimo already
checks Anticipay on the WooCommerce side, and which domain the client owes
([OI-323](OI-323%20The%20production%20domain%20has%20not%20been%20supplied%20by%20the%20client.md)).


## 🔴🔑 2026-11-09 - the supplier says there is nothing wrong, and the ball is back with ROMI

**Six days on, the first movement — and it is a denial.** The thread, Gmail
`1a1bfc2c0e27f7d3`, all on 9 November:

- **10:02:53Z** — Fabrizio Paganelli to Andrea Parmeggiani, cc Aurel Mrruku and
  Elena Spini: _"Ciao Andrea, **hai avuto modo di verificare?** Fammi sapere"_
- **10:31:50Z** — Andrea Parmeggiani: 🔴 _"Ciao Fabrizio, **Avevo già verificato
  che non avevo rilevato problemi**"_
- **10:52:13Z** — Fabrizio Paganelli: _"Ok, **Aurel puoi specificare tu ad Andrea
  ciò che non funziona?** Grazie"_

🔑 **So the position is now symmetrical and stuck**: ROMI observed a 120-second
timeout in production on 3 November; the supplier says he checked and found
nothing; and **the next move is ROMI's**, to say precisely what fails. ⚠ **Nothing
in this sweep shows Aurel Mrruku answering.**

### 🆕 Two production-style alerts fired in the sandbox the same day

Two Salesforce notification mails reached `a.mrruku@romicompany.com`, both subject
_"**Sandbox**: Errore Anticipay da verificare"_, both _"Il controllo Anticipay ha
restituito un errore e richiede una verifica amministrativa"_:

| Mail | Time | Account | Stato HTTP |
| --- | --- | --- | --- |
| `1a1c0036cd5095c6` | **11:13:32Z** | `001MA000014QQP5YAO` | **404** |
| `1a1c0a434bcc2e97` | **14:09:08Z** | `001MA000015FFD8YAO` | **404** |

🔑 **This is new evidence of a different failure mode.** Production fails by
**timeout**; the sandbox fails with **HTTP 404**, which is a routing or endpoint
answer, not a hang. ⚠ The message body carries _"TEST -"_, so these are test
records, and 🟢 **the admin-notification path itself works** — the error is being
surfaced as designed.

⚠ **Whether the 404 and the production timeout are the same defect is not
established.** They are recorded as two observations.

### 🔑 What the 09/11 call settled about the other timeout

[The client review](../meetings/2026-11-09%20Review%20temi%20Fase%202.md) cleared up a
confusion these records carried. Elena Spini remembered production timeouts
against **Info Point** and the **QR scanner**; Aurel Mrruku corrected both:

> _"Quello di q\[uel\] \[QR\] cod\[e\] è il contrario. Loro scanarizzano il
> biglietto, **ci chiamano** per \[ag\]giornare il biglietto"_ — and the timeout
> _"era Anticipay"_.

🔑 **And both systems are the same man's.** The Anticipay call and the
ticket-scanning app are Andrea Parmeggiani's — _"quello che gestisce app … Ah, è
sempre Andrea."_ So one unanswered supplier holds **two** production integrations.

🟢 **Escalation was agreed on the call**: Fabrizio Paganelli had written that
morning, cc'd both, told Aurel Mrruku _"chiamalo anche tu, scrivigli anche tu"_,
and said he would **go to Andrea Parmeggiani in person** immediately afterwards —
_"quando finiamo la call vado di là di persona e glielo chiedo"_. ⚠ **No outcome
of that visit appears in any source in this window.**

### Where it stands

- 🔴 **Still no date, a seventh day.** The go-live is not gated on it, but the data
  enrichment silently does not happen in production.
- 🔴 **Aurel Mrruku owes Andrea Parmeggiani a precise failure description** — now
  an explicit client request.
- ⚠ **The production Info Point connection has no separate finding any more**; the
  timeout attributed to it was Anticipay's. **Info Point's own integration does not
  exist yet** and is release R3, February 2027.
