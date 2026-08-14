---
id: OI-73
type: open-item
status: open
owner: Aurel Mrruku
with: Elisa Migliano
org: both
raised: 2026-08-06
updated: 2026-08-14
uncertain: provider name
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

⚠ **The provider is unconfirmed.** The transcript garbles it; earlier meetings
say **Anticipay**, and **CreditSafe** also appears. Elisa says it is already
live and can hand over references. Do not write either name into a requirement
until it is confirmed.

Technical call with **Andrea Parmeggiani** (`a.parmeggiani@pienissimo.pro`) in
the third week of August — he is
[out until roughly 24–26 August](../risks/Risk%20-%20the%20whole%20remaining%20build%20lands%20after%20Ferragosto.md).
