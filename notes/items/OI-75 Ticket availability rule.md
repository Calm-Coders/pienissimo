---
id: OI-75
type: open-item
status: open
owner: ROMI
with: Elisa Migliano
org: both
raised: 2026-08-06
updated: 2026-08-14
depends_on: [OI-50]
source: meetings/results/2026-08-06-chiusura-punti-aperti.md
requirement: BIG-06
---

# OI-75 - Ticket availability rule

**A ticket becomes available when the tranche invoice carrying its order line
is paid in full.** Partial payment releases nothing. This supersedes every
earlier wording.

Order lines group into tranches by due date and each tranche is invoiced
separately, so per-event release comes out of tranche-level invoicing —
[OI-50](OI-50%20Tranche%20object.md).

⚠ **Tranche composition follows customer payment convenience, not events.** An
event's ticket can sit behind unrelated items in the same invoice. There is no
way to release by event.

**The invoice must arrive in Salesforce, and the match is on `numero di riga
d'ordine`.** Two other candidate keys were killed in session by
[Elisa Migliano](../people/Elisa%20Migliano%20-%20Pienissimo%20administration.md):
**by date**, because the tranche date is a presumed collection date and they
invoice in advance; and **by product**, because _"un tutor può mettere anche lo
stesso codice due volte nello stesso ordine."_

The Mexal invoice carries cliente, numero documento, riferimento numero
d'ordine, codice articolo and numero riga d'ordine — see
[the Mexal integration](../flows/The%20Mexal%20integration.md).
