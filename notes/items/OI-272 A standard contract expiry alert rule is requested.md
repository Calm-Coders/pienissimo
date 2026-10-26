---
id: OI-272
type: open-item
status: open
owner: Elena Spini
with: Fabrizio Paganelli
org: both
raised: 2026-10-20
updated: 2026-10-20
requirement: DM-19
source: Gmail 1a158b6e3e4cee81
---

# OI-272 - A standard contract expiry alert rule is requested

**The client asked whether Salesforce already has a rule that warns the tutor and
the responsible salesperson 15 to 30 days before a contract expires. If not they
will configure it themselves. The question is unanswered.**

## What was asked

[The 20/10 mail](OI-268%20The%20client%20proposed%20a%20go-live%20calendar%20of%2016%20November.md),
§6, after reporting that the Performance Plus tests passed:

> _"I test su attivazione, contratto e rinnovo sono andati bene. Vi chiediamo se
> esiste già una regola standard per gli avvisi di scadenza dei contratti
> (notifica al tutor e al commerciale di riferimento 15–30 giorni prima della
> scadenza). In caso contrario la configuriamo."_

🟢 **The first half is a client pass on Performance Plus** — activation, contract
and renewal all tested well, which is the first unqualified client approval of
that stack.

## Open

- ⚠ **The answer is not in the records.** No note in `notes/flows/` describes a
  contract-expiry alert, and the question was not raised at
  [the 17:01 internal call](../meetings/2026-10-20%20Follow-up%20Interno.md).
  **Whether such a rule exists in the org was not checked in this sweep** — no
  org was opened.
- ⚠ **Two recipients, one of whom may not be modelled.** _"il commerciale di
  riferimento"_ maps onto the agent fields that
  [OI-254](OI-254%20Creating%20a%20Referente%20and%20an%20Account%20failed%20for%20the%20client.md)
  records as inheriting from the creating user, and
  [OI-214](OI-214%20The%20Mexal%20order%20send%20requires%20an%20agent%20code%20WooCommerce%20orders%20lack.md)
  records as still owed its agent code. The tutor side is clearer.
- 🔑 **The client offering to configure it themselves is a pattern worth noting**,
  not a problem: it is the second item in the same mail they took off ROMI's
  plate (the other is the transactional copy in §8, which is
  [OI-264](OI-264%20The%20quote%20expiry%20reminder%20email%20copy%20is%20a%20placeholder.md)).
  ⚠ But a client-configured alert that ROMI has not specified is a thing ROMI
  cannot then support or test.

## What closing it looks like

ROMI inspects the org, answers the question, and either delivers the rule or
confirms in writing that the client owns it — naming the two notification
recipients and where they come from.
