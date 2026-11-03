---
id: OI-321
type: open-item
status: open
owner: Aurel Mrruku
org: ROMI
raised: 2026-11-03
updated: 2026-11-03
depends_on: []
blocks: []
source: notes/meetings/2026-11-03 Test e2e PROD.md
---

# OI-321 - The full order synchronisation to Mexal has not been run

**Only the last five days of orders have ever been fetched. The full run takes about
five hours and has not been done.**

## The facts

During [the 3 November e2e session](../meetings/2026-11-03%20Test%20e2e%20PROD.md)
Aurel Mrruku ran a sync to pull the invoice back for the test order, and said what the
sync covered:

> _"Prendo gli ultimi 5 giorni."_

> _"quando passiamo tutti gli ordini faccio tutto e **ci mette 5 ore** a fare tutto"_

Gemini's next-steps record it as _"Eseguire sincronizzazione ordini: Avviare la
sincronizzazione completa di tutti gli ordini verso Mexal. L'operazione finora è stata
eseguita solo per i dati degli ultimi 5 giorni."_

## Why it is open

1. 🔴 **Not run.** Everything older than five days is unverified against Mexal.
2. 🔑 **Five hours is a planning fact**, not a detail. It cannot be slipped into a
   working day and it has no slot.
3. ⚠ **Distinct from [OI-310](OI-310%20The%20production%20load%20needs%20a%20pre-load%20and%20a%20delta%20run.md).**
   That item's _"3-4 hours"_ is the **migration load**; this five hours is the **order
   sync**. They are different operations and both are unscheduled. **Do not conflate
   them.**
4. ⚠ **Whether it must precede the 12-13 November migration is unstated.**
5. 🔑 **Related: the API integrations and the nightly refresh are still off in
   production by decision** — Aurel Mrruku declined to enable them mid-test: _"non
   voglio spaccare qualcosa adesso perché dobbiamo fare dei giri completi, poi alla
   fine devo abilitare gli API."_ So the sync is manual until he does.
