---
id: OI-169
type: open-item
status: in-progress
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: both
raised: 2026-09-22
updated: 2026-09-24
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

## 🟢 2026-09-23 18:47 CEST — it is built now, on a branch

⚠ **This supersedes the correction recorded twelve hours earlier on this note.** That
correction was accurate when written: at 08:40Z the org and every branch held no agent
field. **Rexhina Hysi's `7eab757` (23/09 18:47:58 CEST, `DEV_LeadAgenteBundle`) creates
them.**

| Metadata in `7eab757`                         |                                                                 |
| --------------------------------------------- | --------------------------------------------------------------- |
| `Agente__c`                                   | on **Account**, **Lead**, **Quote** and **User** — four objects |
| `..._Agente_When_Qualificato.validationRule`  | the **conversion-blocking rule**, by its filename               |
| `LeadConversionQueueable.cls`                 | +129 lines                                                      |
| `BundleProductAssignmentController.cls` + LWC | reworked                                                        |
| Account, Lead, Quote and **User** layouts     | the fields surfaced                                             |

🟢 This is Aurel Mrruku's dev-group instruction of 22/09 15:51 CEST built as specified —
the User carries the `agente`, the Account links to it, the order reads it from the
Account — and it is what Fabrizio Paganelli's 23/09 mail confirms Salesforce owes Mexal
([OI-159](OI-159%20Mexal%20order%20fields%20Salesforce%20does%20not%20populate.md)).

🔴 **Three things remain open, and the third is the one that bites.**

1. **It is not on `DevMain`** — no pull request exists for `DEV_LeadAgenteBundle` at the
   time of this sweep, and it is therefore not in UAT either.
2. **`zona` and `categoria provvigioni cliente` are not in this commit.** The same day,
   [Check Data Import](../meetings/2026-09-23%20Check%20Data%20Import.md) `00:53:31` moved
   `zona` **off the tutor user and onto the account**, and renamed `classificatore rete`
   to **`categoria provvigioni cliente`** to match Mexal. `7eab757` ships `Agente__c` and
   neither of the other two.
3. 🔴 **The validation rule still blocks conversion while the client is still thinking.**
   The 22/09 finding stands: it was built during a session in which Fabrizio Paganelli
   said he would consider it. **The Lead UAT is 24/09.** If this branch merges and
   deploys before then, the first client acceptance session meets a conversion block
   nobody agreed to; if it does not, the agent field the client was shown does not exist.
   **Neither outcome has been chosen by anyone.**

## 2026-09-24 — Account data loaded in UAT

The `Account_NEW` import linked all 8,140 qualified Accounts to one of nine
new inactive Agent-profile users via `Account.Agente__c`. Each of the nine has
the `Agente` permission set. User accounts have reserved invalid-domain email
addresses; new Accounts remain owned by an active UAT user. Because five
source rows differed from the prevailing code for a given agent name, and one
agent name had two distinct codes, the user directed us to preserve each row's
`Codice_agente` on Account in `Codice_Agente_Esterno__c`. One row had no code.

This supplies the customer-to-agent lookup for UAT Account data. It does not
resolve the outstanding Lead conversion rule, zona, commission category, or
Mexal order payload described above.

## 🟢 2026-09-24 — the client accepted the agent obligation, and named the anomalies in the data

**At [UAT: Lead e Opportunità](../meetings/2026-09-24%20UAT%20Lead%20e%20Opportunita.md)
the conversion-blocking rule stopped being a ROMI decision the client was "still
considering".** The Gemini notes record it under **Concordato**:

> _"Obbligatorietà dell'agente o tutor sui lead — La specificazione dell'agente o tutor è
> resa obbligatoria sul lead per poter procedere allo stato di qualificazione."_

Demonstrated live at `00:46:49`, Aurel Mrruku: _"Per andare in qualificato mi dirà manca
l'agente."_ 🔑 **The block is on `Qualificato`, not on conversion** — which matches the
rule's own name, `Require_Agente_When_Qualificato`, and is narrower than the 23/09 record
suggested.

🔑 **Fabrizio Paganelli settled the vocabulary** (`00:20:38`): **"agente" and "tutor" are
synonyms**, and the value is customer-master data that goes to Mexal. That is this note's
premise, stated by the client.

### 🔴 The loaded agent codes do not reconcile

Aurel Mrruku raised this before the session and again at `00:23:28`, from the
`Account_NEW` import:

- **one tutor appears on two accounts carrying two different agent codes**;
- **another tutor's agent code is empty.**

Fabrizio Paganelli offered two explanations — a pending overnight alignment, or private
customers who are never invoiced. Agreed: **Aurel Mrruku merges the duplicate record**,
**Fabrizio Paganelli verifies the agent codes on Mexal**, because they have to match the
codes on the orders.

⚠ The codes and the individuals' names are **deliberately not reproduced here.**

### 🔴 There are now two agent fields

`Account.Codice_Agente_Esterno__c` on `DevMain` (`64b2843`, and 8,140 accounts carry it)
and `Agente__c` on Account/Lead/Quote/User on `DEV_LeadAgenteBundle` (`7eab757`, PR #59,
open). **What the client was shown is the second.** →
[OI-178](OI-178%20Two%20agent%20field%20implementations%20exist%20on%20two%20branches.md)

🟢 `DEV_LeadAgenteBundle` **now has a pull request** — #59, opened 24/09 08:06Z. The 23/09
"no PR" flag is discharged; the branch is still unmerged.

🔑 **`zona` and `categoria provvigioni cliente` now have Mexal API names.** Mirko Merendi,
24/09 08:46:51Z: customer `cod_agente`, **`cod_zona`**, **`cod_cat_pr`**; order
`codice_agente`. Neither branch carries the two missing fields.
