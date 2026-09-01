---
id: OI-102
type: open-item
status: open
owner: Aurel Mrruku
with: Sabatino Rinaldi
org: ROMI
raised: 2026-08-27
updated: 2026-08-31
blocks: [OI-49, OI-101, OI-104]
requirement: INT-11
source: meetings/2026-08-27-test-integrazione-woocommerce-transcript.it.md
---

# OI-102 - Salesforce endpoint and token for the WooCommerce plugin

**ROMI owes Pienissimo an inbound endpoint and an authentication token.** It is
the one thing standing between the working plugin and a real integration test.

Aurel Mrruku committed to it in the
[27 August test session](../meetings/2026-08-27%20Test%20Integrazione%20WooCommerce.md):

> _"mandami via mail il payload, inizio a preparare io il puntamento che devi
> puntare... Tieni in considerazione che io ti devo fornire anche
> un'autenticazione con un token che lo userai, quindi lo metterai nel header
> per chiamare sales force. Ti preparo l'ambiente."_

## What has to be delivered

| Item                                                     | State          |
| -------------------------------------------------------- | -------------- |
| The Salesforce **endpoint URL** the plugin posts to      | 🔴 not created |
| An **authentication token**, sent in the HTTP header     | 🔴 not issued  |
| A reply on Sabatino Rinaldi's payload mail carrying both | 🔴 not sent    |

Sabatino Rinaldi's side is ready and waiting: the plugin currently points at a
throwaway test server, he needs only to change the target and add the header,
and he said so — _"quando ci sei me li mandi e io ci guardo"_.

## Why this direction, and why it is new

The credential that was owed on this integration used to run the other way.
`INT-11` and the client-input list both record **WooCommerce CK/CS credentials
owed by Sabatino Rinaldi**, unpaid since 14 July and promised again for the
27 August session. That framing assumed Salesforce would call WooCommerce.

🔴 **It reverses.** With
[the integration pushing from WooCommerce](../flows/The%20WooCommerce%20order%20integration.md),
the blocking credential is ROMI's, not the client's. Two consequences worth
stating plainly:

- **The 27 August session did not exchange the WooCommerce credentials** — the
  invitation promised _"comprensiva dello scambio di credenziali"_ and they were
  never mentioned. That is no longer obviously a gap.
- **Whether WooCommerce CK/CS are needed at all is unresolved.** They are only
  needed if Salesforce still reads orders back over the WooCommerce REST API, as
  the original spec had it. Nobody said whether that leg survives. Until someone
  decides, do not report the CK/CS as owed **or** as closed.

## 2026-08-28 - the endpoint now has a contract to build against

🟢 **The payload landed and was decoded.** Aurel Mrruku downloaded the 27/08
attachment; the field-by-field decode is
[the WooCommerce payload contract](../The%20WooCommerce%20payload%20contract.md)
and the artifact is preserved at `Payload woo-salesforce.json`. The half of this
item that was waiting on Sabatino Rinaldi is **done** — what remains is entirely
ROMI's.

That removes the excuse for the endpoint not existing, and it adds two structural
requirements to what the endpoint must do on day one:

- **Be idempotent on the WooCommerce order key** — the envelope has no dedupe
  field and the plugin has a re-send button
  ([OI-104](OI-104%20The%20WooCommerce%20payload%20has%20no%20idempotency%20key.md)).
- **Deserialize `meta_data` untyped**, and parse the tracking date defensively —
  both throw otherwise. The hazard list is in the contract note.

🔴 **The header token is now the entire authentication of this integration.**
Nothing in the body is signed, so the token ROMI issues is the only thing between
the endpoint and an arbitrary posted order. `INT-16` recommends the opposite and
has not been closed. Weigh that when choosing what the token is and how it is
scoped.

## Blocking

- [OI-101](OI-101%20Stage%20sales%20must%20be%20in%20the%20WooCommerce%20test%20set.md)
  — the stage-sale simulations were deferred to the Salesforce-connected round.
- The full integration tests agreed for the **week of 31 August**.
- Everything on the Salesforce side of
  [the flow](../flows/The%20WooCommerce%20order%20integration.md): the
  Woo-keyed order type, the `SC` product match, the customer-create path.

⚠ **Against the calendar this is urgent.** Fase 1 development ends
**10 September** per ROMI's own project plan
([the compressed calendar](../risks/Risk%20-%20the%20whole%20remaining%20build%20lands%20after%20Ferragosto.md)),
and none of the Salesforce side exists yet — the 26 August org check found no
Flow, no named credential and no integration configuration row for WooCommerce
([note](../objects/The%20integration%20scaffolding%20has%20never%20been%20configured.md)).

⚠ **Do not put the token, the endpoint or any header value in this repository**
when it is issued. Record that it exists and where it was sent — see
[docs/publishing.md](../../docs/publishing.md).

## 2026-08-31 - the tests are this week and the token still does not exist

The `org-status-check` of **2026-08-31, 09:36–09:52Z** re-verified `INT-16`
against a **rewritten** endpoint (`WoocommerceOrderService`, modified that day)
and the finding survived the rewrite unchanged: `global without sharing`, **no
token check and no signature check anywhere in the class**. Its only handling of
`Authorization` redacts the header when logging — the header is received and
stored safely, and never verified.

So the position is now sharper than on 28 August in one specific way: **the
endpoint is not merely unauthenticated, it has been rewritten once since the
finding and still is.** Whoever rewrote it did not add auth, which suggests
nobody has been told this is outstanding.

Meanwhile the integration is live and busy — 16 inbound calls logged, 7 orders
created — so the endpoint is **taking real traffic from the production shop with
no application-level authentication at all**, and has been for four days.

⚠ **The tests this item blocks are happening now.** The week of 31 August began
today. The token has not been issued.

🔴 And the class that would carry the token check
[is not in source control](../risks/Risk%20-%20a%20clean%20deploy%20would%20orphan%20the%20live%20WooCommerce%20endpoint.md),
so the fix has to be made in the org and retrieved, or it will be lost the way
the Biglietto stack was.
