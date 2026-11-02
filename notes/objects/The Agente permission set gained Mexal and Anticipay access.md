---
id: obj-agente-permset-mexal-anticipay
type: object
status: open
owner: Anita Aga
org: ROMI
raised: 2026-11-02
updated: 2026-11-02
depends_on: [OI-296]
blocks: []
source: git b0e69c5 on DevAnita30, 2026-11-02 14:21 CET
---

# The Agente permission set gained Mexal and Anticipay access

**Commit `b0e69c5` on `DevAnita30` grants the `Agente` permission set Apex and
external-credential access to the Mexal and Anticipay integrations, and takes away
editability on eight fields. It is on a branch with no PR, two weeks before
go-live and the day before the client's permissions walk.**

Read from `git show b0e69c5` on 2026-11-02. **Repository only — not verified in any
org.**

## Granted

| What | Detail |
| --- | --- |
| Apex class access | `AnticipayAccountService` |
| Apex class access | `MexalCustomerCreateService` |
| External credential principal | `Anticipay_External_Credential-Anticipay Principal` |
| External credential principal | `Mexal_External_Credential-Mexal_Principal` |
| Object read | `UserExternalCredential` |

🔑 **This is what makes a salesperson's own click reach Mexal and Anticipay.**
`MexalCustomerCreateService` is the create-and-write-back path, so an `Agente` user
can now cause a customer to be created in Mexal under their own credentials rather
than through a system context. ⚠ **Nothing in any meeting, mail or message this
sweep asked for that, and no note records the decision.**

## Withdrawn

Editability removed, now read-only for `Agente`:

- `Account.Agente__c`
- `Opportunity.Categoria__c`, `Opportunity.Sottocategoria__c`
- `Opportunity.UTM_Campaign__c`, `UTM_Content__c`, `UTM_Medium__c`, `UTM_Source__c`,
  `UTM_Term__c`

Also flipped to `false`: one object's `allowDelete` and `modifyAllRecords`. The
`Agente` **profile** takes the same seven field-editability changes.

🟢 **Locking the UTM fields is coherent** — they are set by the WooCommerce and
web-to-lead paths, not by hand.

🔴 **Locking `Account.Agente__c` is not obviously coherent.** That field is the
agent assignment the Mexal order send requires
([OI-214](../items/OI-214%20The%20Mexal%20order%20send%20requires%20an%20agent%20code%20WooCommerce%20orders%20lack.md)),
whose blank values are a known production failure
([OI-288](../items/OI-288%20Editing%20a%20Contact%20fails%20in%20production%20when%20the%20Account%20has%20no%20Agente.md)),
and whose production load fallback is `610.00001`
([OI-293](../items/OI-293%20The%20agent%20registry%20for%20the%20production%20load%20may%20be%20incomplete.md)).
⚠ **If an agent cannot set it, somebody else must, and nobody is named.**

🔴 **Locking `Opportunity.Categoria__c` and `Sottocategoria__c` collides with an
open item.** [OI-265](../items/OI-265%20Opportunity%20Categoria%20and%20Sottocategoria%20values%20do%20not%20match%20the%20client%20registry.md)
says those picklists do not match the client's registry and has been unmoved for
eleven days. **Making them read-only for the people who would have corrected them
is a change in the opposite direction.** ⚠ Nobody has connected the two.

## Why it matters now

1. 🔴 **It is on `DevAnita30` with no PR**, like `Lead_from_Zoho__c` and the
   `Anno Solare` label change before it. `DevMain` does not have it.
2. 🔴 **The client's permissions walk is Tuesday 3 November 14:30**
   ([OI-300](../items/OI-300%20Tutor%20training%20and%20tutor%20test%20access%20are%20unplanned.md)),
   and what is in the branch is not what is in the org.
3. ⚠ **The 27 October record says the `Agente` permission set was already
   "narrowed" and granted to seven new commercial users in production.** This commit
   narrows it again in one direction and widens it in another. **Which version those
   seven users hold is unverified.**

Also in `b0e69c5`: an `Azienda_Precedente__c` lookup filter restricting the
reference to Accounts with record type `Azienda` (error message _"Seleziona un
Account di tipo Azienda."_, `isOptional` false), and a reworked
`Account_Azienda_Two_Column` flexipage.
