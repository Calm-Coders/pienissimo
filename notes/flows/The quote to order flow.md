---
id: flow-quote-to-order
type: flow
status: in-progress
owner: ROMI
org: ROMI
updated: 2026-08-25
source: meetings/results/2026-08-06-chiusura-punti-aperti.md
---

# The quote to order flow

Settled on 2026-08-06. It replaced the accept/reject buttons that were to sit
inside the quote email — a design that would have let an external client mutate
CRM data directly.

1. After products are selected, the user defines each payment tranche on the
   Quote through a guided action: choose the Quote Line Items and enter the
   payment due date. Each line stores the tranche reference and date —
   [OI-50](../items/OI-50%20Tranche%20object.md), decided by Aurel Mrruku on
   2026-08-24.
2. The quote email carries a **link, not buttons**.
3. The link opens a **landing page** showing preventivo + contratto + condizioni
   generali as a single PDF —
   [OI-68](../items/OI-68%20Quote%20acceptance%20landing%20page.md).
4. **Rifiuto** sets the quote _Rifiutato_. **Accetto** sends the documents via
   **DocuSign**.
5. On signature the quote flips to _Accettato_ and **the order is generated
   automatically**. The tranche reference and payment date propagate from each
   Quote Line Item to its corresponding Order Item; the Order does not recreate
   the tranche.
6. The order runs **Ordinato → Fatturato → Incassato** —
   [OI-69](../items/OI-69%20Order%20state%20model.md). The old "Chiuso acquisito"
   state is deleted.
7. **The Opportunity goes Closed Won only when the order reaches _Incassato_.**
   Payment closes the opportunity, not signature.

**DocuSign is in for the commercial document and out for tickets** — Elena
Spini: _"la firma digitale c'è solo per i preventivi."_ That split is what
finally closed the long-running buy-or-drop question on DocuSign.

Configuration still owed on the quote side: 5-day validity with expiry
mandatory at send, alerts on day 2 and at expiry, a "qualificato da
ricontattare" state and a manual creation button —
[OI-59](../items/OI-59%20Quote%20workflow%20configuration.md), which also waits on
Marco Montesi's list of preset expiry timings per product category.

Two order-side questions are still open: whether a fourth state _Perso_ is
needed ([OI-85](../items/OI-85%20Order%20state%20set%20may%20be%20incomplete.md)) and
how the [credit-note flow](../items/OI-54%20Credit%20note%20flow.md) reverses
lines.

## 2026-08-25 - org check: there is not a single Flow in the org

Verified read-only against **Pienissimo UAT**, two ways — `sf org list metadata
--metadata-type Flow` and `--metadata-type FlowDefinition` both return _no
metadata found_, and a Tooling query `SELECT MasterLabel, ProcessType, Status
FROM Flow` returns **zero rows**. There is also no `flows/` directory in
`force-app/`.

**Every declarative automation this project has designed is unbuilt.** Not
partially built, not built and inactive — absent. That covers this flow, the
[ticket lifecycle](The%20ticket%20lifecycle.md), the asset state machine
([OI-74](../items/OI-74%20Asset%20state%20machine.md)), the quote alerts
([OI-59](../items/OI-59%20Quote%20workflow%20configuration.md)), the Lead/Opty
validation specified on 24 August, and the campaign member automation
([OI-84](../items/OI-84%20Campaign%20Member%20handling%20for%20manual%20check-in.md)).

All automation in the org is **Apex**: three triggers (`BigliettoTrigger`,
`BundleComponentTrigger`, `OrderBigliettoTrigger`) and their handlers. The
register's `build_state` line "Any active Flow; nothing creates a ticket from an
order" (BIG-02, BIG-19) was written on 2026-08-03 and is **still exactly true**
three weeks later, except that `OrderBigliettoTrigger` does now create tickets
from an order in Apex.

This is the single largest missing surface in the build, and it sits against a
**10 September** development end date.
