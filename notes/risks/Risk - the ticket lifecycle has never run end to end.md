---
id: risk-ticket-lifecycle-unproven
type: risk
status: open
severity: high
owner: ROMI
org: ROMI
raised: 2026-08-03
updated: 2026-08-25
source: meetings/open-items.md org verification 2026-08-03
---

# Risk - the ticket lifecycle has never run end to end

The ticket warehouse is the **top-priority phase 1 deliverable** — the thing
Pienissimo named first at kickoff — and no ticket has ever completed its
lifecycle.

In UAT on 2026-08-03: **29 `Biglietto__c` records**, 28 of them _In attesa
firma_ and one _Caricato_. **17 DocuSign envelopes sent. Zero signatures
recorded. Zero QR codes generated.**

The stage that turns a signature into a usable ticket has therefore never
executed, in any environment. Everything downstream of it — the QR document,
the participant email, the scan at the door, the attendance and no-show
analytics the whole project is justified by — is untested code.

Two things changed under it since that snapshot and make the numbers harder to
read, not easier:

- the 2026-08-06 session **removed digital signature from the ticket flow
  entirely** (participants sign on paper at check-in), so the 28 records
  waiting on a signature are waiting for a step that no longer exists;
- the [state machine was redefined](../flows/The%20ticket%20lifecycle.md) to
  `Ordinato → Disponibile → Assegnato → Utilizzato / Non utilizzato`, which
  none of the existing records use.

The tour runs 7–19 September and the Food Marketing Festival on 29 September —
both before go-live, both ticketed. A dry run on real event data is worth more
than any further design session, and
[the flow itself is still not fully specified](../items/OI-82%20Asset%20flow%20needs%20a%20dedicated%20review.md).

## 2026-08-25 - org check: measured, and no closer to running

Verified read-only against **Pienissimo UAT**. The register's
`lifecycle_evidence` block, written 2026-08-03, recorded 29 tickets, 28 awaiting
signature, 17 DocuSign envelopes sent, **0 signatures, 0 QR codes**. Three weeks
later:

- **37 tickets**, up 8
- **30 awaiting signature**, up 2
- **0 have reached `Disponibile`**, 0 issued, 0 used

The stall is at the same place, and the queue behind it has grown. The two
things that would let a ticket move — a fully paid tranche
([OI-75](../items/OI-75%20Ticket%20availability%20rule.md)) and the four agreed
states ([OI-74](../items/OI-74%20Asset%20state%20machine.md)) — are still
unbuilt: all six `Tranche__c` records are `Aperta`, and
`Biglietto__c.Status__c` still carries the pre-06-August signature vocabulary.

The risk stays **high**. With development due to end **10 September**, no
end-to-end run has been possible on any day of this project so far.
