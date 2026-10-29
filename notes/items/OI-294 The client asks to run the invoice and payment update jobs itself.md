---
id: OI-294
type: open-item
status: open
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: both
raised: 2026-10-28
updated: 2026-10-28
depends_on: [OI-244]
blocks: []
source: Gmail thread 1a181e993625de7c
---

# OI-294 - The client asks to run the invoice and payment update jobs itself

**During UAT the client asked to be given the ability to launch the invoice and
payment-collection update processes on demand, so that a test shows its result
immediately instead of waiting for the scheduled run. The request was never
answered: the reply that came back addressed a different subject, and the thread
closed on the client waiting.**

## The request

Gmail `1a181e993625de7c`, **2026-10-28 09:48:49Z**, Fabrizio Paganelli to Aurel
Mrruku and Elena Spini, cc `amministrazione@pienissimo.com`, subject **Test**:

> _"volevamo fare oggi dei test, compreso emissione fatture e registrazione
> incassi. **Per vedere subito gli aggiornamenti ci potete dare la possibilità di
> lanciare le elaborazioni di aggiornamento fatture e incassi?** Se vi è più
> comodo possiamo fare anche una breve call"_

Two things are being asked for at once: permission to run the E2E test
(invoice issue plus payment registration), and **a way for the client to trigger
the invoice and incassi update jobs themselves**. Only the first is about today.

## Why it is open

🔴 **The second half was not answered.** Aurel Mrruku replied at **11:27:59Z**
about something else — that the Mexal integrations were being blocked for the
historical load:

> _"Oggi mi sto occupando del deploy in produzione e del caricamento degli
> ordini. **Per evitare la creazione duplicata di 7.721 ordini su Mexal, è
> necessario bloccare temporaneamente le integrazioni.** Non appena avrò
> completato l'operazione vi avviserò subito, così da poter riprendere i test
> E2E."_

Fabrizio Paganelli at **11:34:30Z**: _"Ok, grazie, attendiamo vostre"_. ⚠ **The
thread ends there.** Nothing in the mailbox grants, refuses or schedules the
ability to launch the elaborations, and the client is on record as waiting.

⚠ **Whether such a manual trigger exists at all is not established here.** The
record holds scheduled and queued Mexal work (the nightly alignment, the order
queue, the aging batch) but nothing describing a user-invocable "run now" for
invoices and incassi, and the org was not opened in this sweep.

🔑 **It is a requirement in the ordinary sense even if it is answered as a no**:
a client operator asking to re-run a sync is asking for a screen, a button or a
permission, and no register row covers one.

## Related

- [OI-244](OI-244%20Historical%20orders%20will%20be%20migrated%20from%20Mexal%20by%20spreadsheet.md)
  — the load that caused the integrations to be blocked.
- [OI-296](OI-296%20Account%20creation%20to%20Mexal%20failed%20in%20UAT%20and%20account%20send%20was%20switched%20off.md)
  — a second switch turned off the same afternoon, also without a recorded
  re-enable.
