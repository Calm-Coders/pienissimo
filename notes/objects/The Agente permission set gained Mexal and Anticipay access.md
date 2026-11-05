---
id: obj-agente-permset-mexal-anticipay
type: object
status: open
owner: Anita Aga
org: ROMI
raised: 2026-11-02
updated: 2026-11-03
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

## 🟢🔑 2026-11-03 - the first evidence it is in a live org, from the client's own mail

**The 2 November reading — that this branch had no PR and the org did not hold it —
needs qualifying. At least the field-level half is in production.**

Elena Spini to Marco Montesi at **17:20:08Z**, Gmail `1a1a26d14b6484d1`, cc Fabrizio
Paganelli and `amministrazione@pienissimo.com`:

> _"per quanto riguarda il tuo account, come concordato, siamo passati dal profilo di
> **System Administrator** a quello corretto da **Agente**. A livello pratico:
> **Visibilità:** non cambia nulla … **Permessi di modifica:** sono stati disabilitati i
> campi riservati all'amministrazione. Non vedrai più l'icona della matita per la
> modifica diretta su alcune informazioni sensibili; ad esempio, nella scheda degli
> account, **i campi sincronizzati con Mexal non sono più editabili manualmente da
> layout** per preservare la coerenza dell'integrazione."_

🔑 **That is this branch's behaviour, described to the client as live**: the loss of
editability on Mexal-synced Account fields, `Account.Agente__c` among them. 🟢 **And it
is now the documented, agreed rationale** — integration consistency — which no commit
message or meeting had supplied.

⚠ **This is evidence about the profile and the field-level permissions, not about the
Apex half.** Nothing on 3 November says whether the `Agente` permission set's new access
to `MexalCustomerCreateService`, `AnticipayAccountService` and `UserExternalCredential`
is in production. 🔴 **The question of who asked for that remains unanswered**, and no
meeting, mail or message has yet requested it.

⚠ **`DevAnita30` still has no PR.** The org appears to hold the behaviour by a route the
repository does not record.

🔑 **And the question this note raised is answered in practice**: **who sets
`Account.Agente__c` now that agents cannot?** Fabrizio Paganelli's answer, from
[the e2e session](../meetings/2026-11-03%20Test%20e2e%20PROD.md), is that **a fallback
`pienissimo commerciale` user with the Agente profile** is the assignee of record for
accounts with no agent or duplicate agents, communicated to the agents by his own mail.
⚠ Its code was spoken as `001`, `006` and `00` at different moments and **the exact
value is uncertain**. ⚠ **It does not say who may edit the field**, only who it points
at.

⚠ **The OI-265 tension is unchanged.** Locking `Opportunity.Categoria__c` still points
the opposite way from
[OI-265](../items/OI-265%20Opportunity%20Categoria%20and%20Sottocategoria%20values%20do%20not%20match%20the%20client%20registry.md),
**twelfth day**.

🔑 **One further permission fact from the same session**: Fabrizio Paganelli's own admin
user had **no access to child campaigns** despite holding what Aurel Mrruku called full
permissions, and Aurel Mrruku himself **lacks field-level access to `data invio
biglietto`** in production — _"Devo fare per forza un rilascio"_. See
[OI-319](../items/OI-319%20Data%20invio%20biglietto%20is%20missing%20from%20the%20campaign%20page%20in%20production.md).
