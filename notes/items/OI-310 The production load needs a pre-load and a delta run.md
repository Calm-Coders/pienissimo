---
id: OI-310
type: open-item
status: open
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: both
raised: 2026-11-02
updated: 2026-11-02
depends_on: [OI-244, OI-290]
blocks: [go-live]
source: notes/meetings/2026-11-02 Tema Contratti WooCommerce.md
---

# OI-310 - The production load needs a pre-load and a delta run

**A full production load costs three to four hours of processing, and the window
between the client's last invoicing day and go-live is one weekend. So the plan
changed on 2 November: load the product registry, accounts and contacts in
advance, then run only the delta on 12-13 November. The advance file has no
delivery date.**

## What was agreed

Aurel Mrruku, on [2 November](../meetings/2026-11-02%20Tema%20Contratti%20WooCommerce.md):

> _"riusciamo a portarlo prima almeno [l']anagrafica dei prodotti? … E a sto punto
> faccio anche un run sugli account con quelli esistenti perché voglio caricare
> anche i contatti e il 12 13 praticamente faccio solo il delta così … perché ci
> mettono 3-4 ore a caricare tutto perché sono [delle] migliaia di contatti e di
> ordini."_

> _"così io ho un buffer di qualche giorno e non lascio tutto per venerdì."_

Fabrizio Paganelli accepted, with one cost: _"per fare questo ti dovrei
riaggiornare i file di interfaccia"_ — the extract files have to be regenerated —
and estimated it at _"non ci dovrebbe voler molto"_. He will deposit a file called
a **_"versione produzione"_** in the shared folder.

🔑 **The window named for it is Wednesday, Thursday or the following Monday** —
Aurel Mrruku: _"non so, mercoledì, giovedì o lunedì prossimo"_. ⚠ **No single date
was agreed and no owner confirmed one**, so this is a preference, not a
commitment.

## What this changes about the 13 November plan

🟢 **The single-pass plan recorded in
[OI-268](OI-268%20The%20client%20proposed%20a%20go-live%20calendar%20of%2016%20November.md)
is softened, not contradicted.** The client-facing commitment stays: **12 November
is Fabrizio Paganelli's last Mexal invoicing day, 13 November 09:00 the handover.**
What changes is that most of the volume moves earlier and the dated run becomes a
delta — which is the de-risking the two-stage plan was dropped for.

🟢 **The product registry is stable** and can go early — _"l'anagrafica dei
prodotti no, è stabile quella"_. 🔴 **Accounts cannot**: the client can create one
on the last day.

🟢 **Confidence in the order load is high**: _"Sui ordini abbiamo visto che ha
funzionato tutto a meraviglia, quindi l'unico problema che posso avere è il tempo
di processare tutti i record."_ — so the stated risk is **duration, not
correctness**.

## Why it is open

1. 🔴 **No date for the refreshed interface files**, and they gate the whole
   pre-load.
2. 🔴 **The Lead and Referenti halves are not ready for it.** Aurel Mrruku asked
   the same morning for _"tutti i lead e tutti [i] contatti fino a quel momento"_,
   so **a second, later extract is now expected** on top of the delivered Lead
   file — and the Referenti tracciato has still not arrived
   ([OI-290](OI-290%20Lead%20and%20Referenti%20migration%20data%20is%20owed%20by%20the%20client.md)).
3. ⚠ **The three-to-four-hour figure is unverified against production.** It comes
   from the UAT rehearsal of 28 October.
4. ⚠ **No rollback is recorded**, for the pre-load or for the delta — unchanged
   since the single-pass plan was adopted.
