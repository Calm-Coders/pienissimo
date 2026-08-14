---
id: OI-73
type: open-item
status: open
owner: Aurel Mrruku
with: Elisa Migliano
org: both
raised: 2026-08-06
updated: 2026-08-14
source: meetings/results/2026-08-06-chiusura-punti-aperti.md
requirement: INT-14
---

# OI-73 - VAT validation moves into Salesforce

**The VAT check moves into Salesforce and fires at the FIRST order of an
account** — not at account creation, and not deferred to phase 2.

As-is: pre-invoicing in Mexal reads the order's VAT, checks the Mexal registry,
and if absent calls a business-information service returning ragione sociale,
address, PEC and legal representative. Elisa Migliano rates that registry
_"corretta al 99,5%"_. She proposed relocating the call to order generation so
the data pushed to Mexal is already clean; Elena Spini approved.

**Not at account creation, on cost**: free events draw 3,000–6,000 registrants
of whom roughly 250 buy.

Design details: a checked account carries a **"consolidato" flag** and is never
re-checked; failures email an **administration address Pienissimo must still
supply**; a **manual re-check button** sits on both order and account, using the
same API.

✅ **The provider is settled: Anticipay, formerly CreditSafe.** They are the
same company under two names, which is what made the transcript read as two
candidates. Elena Spini's `PIENISSIMO - Project Status` document (6 August)
writes it as _"Anticipay (ex CreditSafe)"_ and marks the timing **confirmed at
order creation**; the calendar invitation for the technical call is titled
_Integrazione Anticipay_ and describes the service as CreditSafe in its body.
Either name may be used in a requirement, but prefer **Anticipay** and note the
former name once.

📅 **The technical call is scheduled: Tuesday 25 August 2026, 10:00–11:00.**
Invited: Aurel Mrruku, Elisa Migliano (`amministrazione@`), **Andrea
Parmeggiani** (`andrea.p@pienissimo.pro`) and Sabatino Rinaldi, cc Andrea Di
Cicco. It is the **first** of the post-Ferragosto restart meetings.

Still outstanding: **credentials**, and the **administration address** that
failure notifications should go to.
