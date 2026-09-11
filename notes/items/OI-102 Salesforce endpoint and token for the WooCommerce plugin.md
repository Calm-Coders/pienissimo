---
id: OI-102
type: open-item
status: open
owner: Aurel Mrruku
with: Sabatino Rinaldi
org: ROMI
raised: 2026-08-27
updated: 2026-09-10
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

## 2026-09-04 — the endpoint and the authentication exist, and Sabatino Rinaldi has not been given them

**Both halves of the deliverable were built and circulated inside ROMI on
4 September.** Anita Aga sent Aurel Mrruku a Postman collection — by mail at
16:23 and 16:37 CEST, and again as a Slack DM at 17:08 — containing a working
call against the inbound route.

| Deliverable                                  | State on 2026-09-04                                        |
| -------------------------------------------- | ---------------------------------------------------------- |
| The Salesforce **endpoint URL**              | 🟢 exists — an Apex REST route on the UAT sandbox          |
| An **authentication** mechanism              | 🟢 exists — **OAuth 2.0 JWT bearer**, session in the header |
| A reply to Sabatino Rinaldi carrying both    | 🔴 **still not sent**                                       |

🟢 **The authentication is better than this item feared.** The record has been
carrying the expectation of a **static shared token in a header**, which
`INT-16` recommends against and which the payload's lack of any signature made
the entire authentication. What was actually built is a **platform OAuth flow**:
a signed assertion is exchanged at the Salesforce token endpoint for a session,
and that session is the bearer. Salesforce authenticates the caller, so the
route is not open.

🔴 **It has not been delivered, and delivery is the item.** Everything so far is
internal — a developer to a technical lead, on two channels, neither of which
includes Sabatino Rinaldi. His side has been ready since 27 August and needs only
a target and a header. **The integration tests this blocks were set for the week
of 31 August and that week has passed.**

🔴 **The credentials in that collection must not be the ones he receives.** They
were circulated in plaintext and one of them is effectively permanent —
[the risk](../risks/Risk%20-%20Salesforce%20integration%20credentials%20were%20circulated%20in%20plaintext.md).
Whatever is sent to Pienissimo should be issued for them, scoped to them, and
revocable independently.

⚠ **`INT-16` is not closed by this.** The recorded finding is that
`WoocommerceOrderService` performs **no token or signature check of its own**;
platform authentication is a different guarantee, and the class was not
re-read against the org this sweep. Leave `INT-16` open until an
`org-status-check` settles what the route actually enforces.

⚠ **The test payload in the collection matches
[the recorded contract](../The%20WooCommerce%20payload%20contract.md) exactly** —
same 14 top-level keys, the 15-character `sf_opportunity_id`, `event` set to
`woocommerce_order_status_processing`. **No contract change**, and one small
confirmation: `processing` is a real value of the `event` set, consistent with the
27 August correction that an order arrives at `in lavorazione` **or**
`completato`.

⚠ Its `line_items[0].sku` is `CS-00111` — the **hyphenated** form, where the org
holds codes such as `CS000115` unhyphenated. That is
[the normalisation risk](../risks/Risk%20-%20normalising%20an%20article%20code%20merges%20two%20products.md)
appearing in a test fixture. It proves nothing about the production catalogue —
the values are invented — but whoever writes the `sku` match should not assume
one spelling.

## 2026-09-07 - the mail is finally an assigned action, and still unsent

🟢 **"Inviare mail integrazione: Inviare la comunicazione necessaria per
l\'integrazione Woocommerce"** — an action on **Aurel Mrruku** out of
[the internal follow-up](../meetings/2026-09-07%20Follow-up%20Interno.md).

This row has recorded since 4 September that the endpoint and its OAuth JWT-bearer
authentication exist, work, and have never been given to **Sabatino Rinaldi**,
whose side has been ready since 27 August. It is the first time sending them has
an owner.

🔴 **It was still unsent at the end of 7 September.** No mail to `pienissimo.pro`
or `pienissimo.com` on the subject appears in the mailbox, and the newest message
from Sabatino Rinaldi\'s side is unchanged.

⚠ **Rotate before sending.** Both credentials were circulated in plaintext across
mail and Slack and the JWT assertion\'s `exp` is roughly sixty years out
([the risk](../risks/Risk%20-%20Salesforce%20integration%20credentials%20were%20circulated%20in%20plaintext.md)).
A mail to the client is the moment that pattern leaves ROMI.

⚠ **`INT-16` is still not closed.** What the endpoint class enforces on its caller
was not re-verified this run either.

## ✅ 2026-09-08 - it was sent

**Aurel Mrruku mailed Sabatino Rinaldi at 14:17Z**, replying on the
`Integrazione woo commerce - salesforce` thread he opened on 27 August, cc Andrea
Di Cicco and Elena Spini. Attached: **`Pienissimo.postman_collection.json`**.

> _"Abbiamo messo in piedi l'endpoint. Ti passo qui sotto la collection per
> testare direttamente su Postman. Prima si deve fare una chiamata per ricevere
> il token, poi il token viene usato sulla seconda chiamata. Per fare diverse
> chiamate e per evitare i duplicati, basta cambiare l'id dell'order."_

**Twelve days after Sabatino Rinaldi's side was ready**, and after a direct Slack
reminder from Elena Spini that morning at 09:17 CEST — _"reminder PIENISSIMO per
Woocommerce mail"_ — to which Aurel Mrruku answered _"grz"_ five hours before
sending.

🟢 **The duplicate contract is explained in the mail body**, which
[OI-104](OI-104%20The%20WooCommerce%20payload%20has%20no%20idempotency%20key.md)
has wanted since the `409` → `200 + duplicate: true` change went in silently on
31 August. It is explained as a *testing* instruction — change the order id to
avoid duplicates — not as a contract statement, so **OI-104 is not closed by it**.

🔴 **The credentials were not rotated first.** This row and
[the plaintext-credential risk](../risks/Risk%20-%20Salesforce%20integration%20credentials%20were%20circulated%20in%20plaintext.md)
both said to rotate before sending, because the JWT assertion's `exp` is roughly
sixty years out. The collection went to the client unchanged. **That pattern has
now left ROMI.**

⚠ **A newer collection exists and this is not it.** At 14:58 CEST — forty minutes
*after* sending — Aurel Mrruku asked Andrea Di Cicco in DM for _"la collection
aggiornata su pienissimo"_; Andrea Di Cicco answered _"Devo mettere i filtri
ancora"_ and promised it between 17:00 and 18:00. **What Sabatino Rinaldi holds
is the pre-filter version.**

⚠ **No test result yet.** Sabatino Rinaldi had not replied by the end of
8 September, and he is on the client's tour from that day.

## 2026-09-09 - the filtered collection was chased again and did not arrive

Andrea Di Cicco promised the filtered collection _"tra le 5 e le 6"_ on
8 September. It did not come. Aurel Mrruku chased it in the same DM at **12:26
CEST on 9 September**:

> _"ciao"_ / _"alla fine non mhai passato la collectioon :="_

**Andrea Di Cicco has not replied** — read at 23:35 CEST, roughly eleven hours
later, and the DM shows no message after Aurel Mrruku's.

So the position is unchanged and one day older: **Sabatino Rinaldi holds the
pre-filter collection**, the filtered one exists on Andrea Di Cicco's machine
only, and **the sixty-year JWT still has not been rotated**. ⚠ Sabatino Rinaldi
has still sent no test result; he has been on the client's tour since 8
September.

⚠ **Neither man is described here as unresponsive on purpose** — 9–11 September
is the ROMI company offsite
([the compressed calendar](../risks/Risk%20-%20the%20whole%20remaining%20build%20lands%20after%20Ferragosto.md)),
which is a sufficient explanation for a same-day silence and is not evidence of
anything more.

## 2026-09-10 - a second day of silence, and this time he was in the DM

The chase of 9 September is **still unanswered at the end of 10 September**, and
the offsite is no longer a sufficient explanation on its own: **Andrea Di Cicco
was active in the same direct message on 10 September**, between **14:44 and
14:47 CEST**, on other subjects — Teatro Franco Parenti, Sapimed, _"sto
rispondendo a qualche email"_, _"ora abbiamo pausa fino alle 3"_. He scrolled past
Aurel Mrruku's request without answering it.

So, unchanged and now two days old:

- 🔴 **Sabatino Rinaldi still holds the pre-filter collection.**
- 🔴 **The sixty-year JWT is still unrotated**, twice asked for on this row.
- 🔴 **No test result has come back** from the client's side, which has been ready
  since 27 August.

⚠ **Read as a dropped ball inside a busy offsite week, not as refusal.** Nothing
suggests the request was declined; it was not answered. But the pattern has now
persisted through a promise (08/09), a chase (09/09) and a demonstrated presence
(10/09), and **UAT begins in thirteen days**.

⚠ **A different Postman collection did move on 10 September** — Aurel Mrruku sent
Anita Aga `Mexal Dev v.2.postman_collection` at 14:45:51 CEST, one minute before
asking Andrea Di Cicco whether he was working. **That is the Mexal collection,
not this one**
([the wire facts](../flows/The%20Mexal%20integration.md#2026-09-10---the-wire-facts-arrive-and-the-first-apex-is-written)).
Do not let the two be confused: this row is still owed a **WooCommerce**
collection with its filters.

**What a person must do:** ask Andrea Di Cicco directly for the filtered
WooCommerce collection, and rotate the JWT before it goes any further.
