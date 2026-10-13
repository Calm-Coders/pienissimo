---
id: OI-214
type: open-item
status: open
owner: Aurel Mrruku
with: Marco Montesi
org: both
raised: 2026-10-07
updated: 2026-10-13
depends_on: [OI-219]
blocks: [OI-134, go-live]
severity: gating
source: notes/meetings/2026-10-07 UAT Integrazione WooCommerce e Mexal.md
---

# OI-214 - The Mexal order send requires an agent code WooCommerce orders lack

**Mexal rejects an order without an agent code, and an order arriving from
WooCommerce need not have an agent. The send failed on exactly this at
the 07/10 UAT, and there is no default.**

## The failure

At [the WooCommerce session](../meetings/2026-10-07%20UAT%20Integrazione%20WooCommerce%20e%20Mexal.md),
re-sending a test order to Mexal returned an error for the missing mandatory
agent code. Aurel Mrruku tried assigning an agent by hand to test the sync and
found the agent user **inactive**, which Elena Spini confirmed. The send
eventually succeeded only once an active agent was associated.

## The shape of the gap

Fabrizio Paganelli put a number on it: **about 80% of WooCommerce orders belong
to customers already linked to a tutor or a company**, so the agent comes
through. For the remainder the assignment _"deve essere gestita dall'ufficio
commerciale"_ — a manual step, with no default value and no queue.

Two rulings from the same session bound the problem:

- **An order keeps the agent it was created with.** Changing the agent on the
  customer registry later does not move orders already created.
- **The agent is inherited from the customer registry at order creation**, and
  the fields that matter are the agent category and the commission category
  (Fabrizio Paganelli, Elena Spini). Commission categories are not native on the
  Mexal order and sit on the customer registry — Fabrizio Paganelli confirmed he
  had that added on Salesforce.

## Open

- 🔴 **Which agent code to use for WooCommerce orders with no agent is
  unanswered.** Elisa Migliano undertook to ask Marco Montesi. Until he answers,
  the ~20% have no route.
- **The default agent logic for orders from Palco is Aurel Mrruku's** to define,
  together with the payment-method mapping
  ([OI-219](OI-219%20Default%20payment%20method%20and%20agent%20for%20WooCommerce%20and%20Palco%20orders.md)).
- ⚠ **The error is not surfaced where it happens.** Aurel Mrruku asked for the
  mandatory-agent-code error to be reported **on the order screen itself** for
  diagnosis; at present it is only visible in the integration log.

## What closing it looks like

Marco Montesi names the fallback agent code, the inheritance runs at order
creation for every channel including WooCommerce and Palco, an order with no
natural agent still transmits, and the failure is readable on the order record
rather than only in `Integration_Log__c`.

## 🟢 2026-10-08 - the invisible error was built, exactly as asked

The ⚠ above — the mandatory-agent-code error reaching only
`Integration_Log__c` — is **closed in code**. Agreed first at
[the 08/10 internal session](../meetings/2026-10-08%20Internal%20Test.md), where
Elena Spini and Aurel Mrruku settled on showing the integration log's exceptions
_"direttamente a livello di ordine nell'interfaccia utente, utilizzando un
colore di sfondo specifico per evidenziare l'errore anziché una formattazione
complessa"_ — a background colour rather than elaborate formatting.

**Anita Aga's `12959b7`** (08/10 16:15 CEST, merged to `DevMain` via PR #88)
delivers it:

| Component | What |
| --------- | ---- |
| `Order.Mexal_Integration_Error__c` | new LongTextArea(32768), 5 visible lines, label **Errore Integrazione Mexal**, described as the latest error raised while sending this order |
| `OrderMexalIntegrationService` | +43 lines writing the field |
| `Order_Record_Page.flexipage` | the field placed on the order page (198 lines changed) |
| `Mexal_Integration_Error.uiFormatSpecificationSet` | the conditional highlight — the agreed background colour |
| `Full_Permission` permission set | field access |

🔴 **The item itself does not close.** The error is now visible; **which agent
code to use for an agentless WooCommerce order is still unanswered**, and that
is the gating half. Elisa Migliano had undertaken to ask Marco Montesi, and
nothing in this sweep shows she has — he wrote twice on 08/10, on other matters,
and the agent code appears in neither mail.

⚠ **Not verified in an org.** This is repository arithmetic against `DevMain`
`8879f08`; nobody in this sweep saw the message render on an order.

## 🟡 2026-10-12 - the agent code now travels through the Quote, and the gap is not closed

`27304d7` (Anita Aga, 18:21 CEST) adds **`Quote.Codice_Agente_Esterno__c`**,
a 40-character text field whose own description states the mechanism:

> _"Codice agente esterno copiato dall'agente dell'Account al momento della
> creazione del preventivo."_

`QuoteTriggerHandler` stamps it on insert from
`Opportunity.Account.Agente__r.Agente__c`, and `OrderTriggerHandler` now prefers
the Quote over the Account when it fills `Order.Codice_Agente__c`.

🟢 **What this is good for.** It freezes the agent at quote creation instead of
reading the Account at order time, which is what the 03/09 Data Model session
agreed — the code is inherited from the tutor and **freezes on the order for
commission attribution**. The right fix for that requirement.

### 🔴 It does not answer this row

The gating question is unchanged: **which agent code does an agentless
WooCommerce order use?** No default was added, and ~20% of WooCommerce orders
have no agent. Marco Montesi has not answered, and Elisa Migliano's ask of him is
now five days old.

### ⚠ One path worth a human's eye before this merges

In the new `OrderTriggerHandler` loop, an order **with** a Quote takes the
quote's value and `continue`s:

```apex
if (orderRecord.Quote__c != null) {
  Quote quoteRecord = quotesById.get(orderRecord.Quote__c);
  orderRecord.Codice_Agente__c = quoteRecord == null
    ? null
    : quoteRecord.Codice_Agente_Esterno__c;
  continue;
}
```

So when an order has a Quote whose `Codice_Agente_Esterno__c` is blank — an
Account with no `Agente__r` at quote creation, or a quote created before this
field existed — the order gets **`null`**, and the Account fallback below is
never consulted. Previously the Account was the only source, so such an order
would have picked up the Account's code if it had one later.

⚠ **Recorded as a path, not as a confirmed regression.** Whether it can happen
depends on whether an Account can have an agent at order time but not at quote
time, and on whether existing quotes get backfilled — neither is established
here, and no test run is attached to the commit.

### Not in `DevMain`

`27304d7` is on **`DevAnita_CodiceAgenteEsterno`**
(`git merge-base --is-ancestor 27304d7 DevMain` → false at `a061f55`). No PR has
been opened for it. 🟢 The error-surfacing half of this row — the
`Mexal_Integration_Error__c` field and its highlight, `12959b7` on 08/10 — **is**
in `DevMain` and is unaffected.

## 🟢 2026-10-13 — now in `DevMain`

`27304d7` reached `DevMain` through **PR #96**, merged as `cfe5fd2` at
10:47:24 CEST. `Quote.Codice_Agente_Esterno__c` is in source at `DevMain`
**`21d6686`**. The "not in `DevMain`" finding above is **closed**.

Anita Aga also landed **`f89d68e`** the same morning — _"Get the detailed message
error from Mexal to appear on Order"_ — which extends the error-surfacing half of
this row.

🔴 **The gating half is untouched: which agent code an agentless WooCommerce order
should use is still unanswered**, by anyone, in any source. ⚠ So is the
`continue`-past-the-Account-fallback path recorded above; nothing tested it, and
nothing in the 13/10 session or the 14/10 e2e scope exercises a WooCommerce order
without an agent.
