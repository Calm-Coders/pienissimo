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

## 2026-09-24 — Agent codes filled on UAT users

After the Account import, the user pointed out that `User.Agente__c` was blank.
The `Account_NEW` source gives a clear prevailing code for seven Agent users;
those seven fields were populated in Pienissimo UAT. One agent has two
different codes across two Accounts, so the user selected the code of one
of those rows for that User. Another agent's only source row has a blank
code, and the user directed us to leave that User field blank. The final
UAT query confirms eight of nine inactive Agent users have `Agente__c` set.
All 8,140 Account lookups and per-Account original codes remain unchanged;
five Account rows have a code different from their linked User's chosen code.

## 2026-09-24 — commission category and zona fields deployed

The user directed the team to add both fields to Account, using the latest
Account model workbook. `Categoria_Provvigioni_Cliente__c` and `Zona__c` are
now in UAT and visible on the Azienda page. Of 8,140 eligible `Account_NEW`
rows, 8,138 commission categories were loaded; all source zona values were
blank, so no zona data was set. This closes the **Account field/data portion**
of the gap recorded above. The live Mexal customer payload still assigns
`cod_agente` to `null`, and the order integration mapping remains separate.
No Mexal update job was enqueued by this data update.

## 2026-09-24 — commission category on the Agent user

The user asked for `Categoria Provvigioni Cliente` on User, alongside the agent
code. `User.Categoria_Provvigioni_Cliente__c` already existed in Pienissimo
UAT as a TextArea and was shown on the User layout, but all nine inactive
Agent users had it blank. Its metadata and the User layout are now in the DX
source. Eight users were filled from the prevailing category for their name
in `Account_NEW`; Elisa Migliano's only eligible Account had no category, so
her User field remains blank. Nicol Pironi had two eligible Accounts with
different categories; the user explicitly chose `19` for that User, matching
the Account with agent code `610.00019`. The original per-Account category
values were not changed. Read-back of all nine users found zero mismatches.
