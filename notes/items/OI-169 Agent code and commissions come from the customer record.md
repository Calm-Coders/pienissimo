---
id: OI-169
type: open-item
status: in-progress
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: both
raised: 2026-09-22
updated: 2026-09-23
depends_on: [OI-159]
blocks: [go-live]
source: notes/meetings/2026-09-22 Test Mexal.md
---

# OI-169 - Agent code and commissions come from the customer record

🟢 **Agreed at [Test Mexal](../meetings/2026-09-22%20Test%20Mexal.md) with Mirko
Merendi and Fabrizio Paganelli present.**

## The rule

The **`codice agente` is a fixed attribute of the customer**, not of the person typing
the order. An order inherits the agent from the **customer registry**, and explicitly
**not** from the Salesforce user who entered it — which may be a shared or stand-in
account. The same holds for the **`categoria provvigionale`**, which has 7–8 predefined
values tied to tutors.

Salesforce must therefore populate **zona** and **categoria provvigionale** on the
customer-creation call to Mexal.

🟢 **Commission values themselves are not Salesforce's problem.** Mirko Merendi will
write a **scheduled Mexal procedure** that fills provvigioni, tipo merce and
contropartita di riga after the order arrives — partly because those fields are not
exposed on the order-line body of the API at all. Fabrizio Paganelli agreed explicitly
to simplify ROMI's build.

## What was built the same day

Aurel Mrruku instructed the developers at **22/09 15:51 CEST**, in the dev group: the
**User** gets an `agente` field, the **Account** links to that user, and on order
creation the value is read **from the Account** into `codice_agente` — consistent with
the ruling.

🔴 **And then a stricter rule than anyone agreed.** At
[the 17:00 pre-UAT session](../meetings/2026-09-22%20Test%20Interni%20Pre-UAT%20Parte%202.md)
he added: the **Lead** also gets an `agente` field, and **a Lead cannot be converted
without one**, because an Account cannot be created without an agent — immediately
followed by **_"he said he's going to think about it, but I'm putting it right now, so I
don't forget it."_**

⚠ **That conversion block is not in the agreement.** The agreement says the agent
belongs to the customer; it does not say a Lead without an agent may not convert. It is
a **validation the client is still considering**, being built before the answer — and it
lands on the Lead path whose UAT is **24 September**.

## Open

- 🔴 **Get the conversion-blocking rule confirmed or dropped**, and name who confirmed
  it. Leads arrive from public forms with no agent.
- 🔴 **Fabrizio Paganelli owes the predefined commission-category values**, to avoid
  mapping errors — action from the same session, undelivered as at this sweep.
- ⚠ It interacts with
  [OI-163](OI-163%20Lead%20conversion%20has%20no%20agreed%20duplicate%20rule.md): both
  add conditions to the same conversion path, and neither is client-agreed.

## 2026-09-23 — org-status check

Read-only check of Pienissimo UAT, 08:01–08:40Z, `DevMain` at `61f2a53`. Nothing was deployed or changed.

- 🟢🔴 **Nothing of this item is built, in the org or in `force-app/`.** Tooling `FieldDefinition` shows **no agent, zona or provvigione field** on `User`, `Account`, `Lead` or `Order`. There is **no Lead validation rule** apart from `Require_Non_Qualificato_Exit_Reason`. `force-app/` mentions `agente` only in the two Mexal callout classes. (verified)
- ⚠ **Correction to the 22/09 record.** It said a conversion-blocking Lead validation _"was built"_. It was **announced** at the 17:00 session (_"I'm putting it right now"_) and **has not reached the org or any branch**. So nothing blocks conversion at the 24/09 Lead UAT. The rule agreed at `Test Mexal`, that the agent comes from the customer record, is also unbuilt.
