---
id: OI-368
type: open-item
status: open
owner: Aurel Mrruku
with: Sabatino Rinaldi, Fabrizio Paganelli
org: both
raised: 2026-11-16
updated: 2026-11-16
depends_on: [OI-357]
blocks: []
severity: high
source: Gmail 1a1e5110ba2a0e58
---

# OI-368 - The client asked for the Mexal integration APIs by mail

**On the afternoon of the go-live the client's web counterpart asked ROMI to send
him the APIs and everything used to integrate Mexal with Salesforce, for his own
internal connections. He is the person who is leaving. The request is unanswered,
and what it asks for overlaps with the Mexal WEBAPI credentials, which are a
client asset ROMI holds for the integration and not a deliverable.**

## The request, in full

Sabatino Rinaldi → Aurel Mrruku, cc Fabrizio Paganelli, **2026-11-16 15:54:10Z**
(Gmail `1a1e5110ba2a0e58`, subject `API MEXAL`):

> _"Ciao Aurel, puoi inviarmi **le API e tutto quello che hai utilizzato per
> integrare Mexal a Salesforce**? Mi serve per dei collegamenti interni, grazie"_

That is the whole message. No scope, no named system, no deadline.

## Why it needs a person and not a reply

- 🔴 **The requester is leaving.** Fabrizio Paganelli said so on 12 November —
  _"Sabatino va via"_ — with no date, successor or handover
  ([OI-357](OI-357%20The%20client%20commercial%20lead%20and%20the%20web%20counterpart%20are%20both%20leaving.md)).
  Sending integration material to a departing person's mailbox for unspecified
  _"collegamenti interni"_ is a decision, not an admin task.
- ⚠ **"tutto quello che hai utilizzato" reaches credentials.** The Mexal WEBAPI
  access is the thing the whole integration runs on; the repository records that it
  exists and deliberately holds no values
  ([the Mexal Postman collection](../The%20Mexal%20Postman%20collection.md)).
  Whatever is sent, the values must not pass through ROMI's project records.
- **The asymmetry is the point.** ROMI has been waiting on this client for the
  WooCommerce shop credentials, which it does not hold and which Sabatino Rinaldi
  owns. The same thread of ownership runs in both directions and only one direction
  has been chased.
- **Kreosoft owns the Mexal side.** Mirko Merendi is the counterpart who set the
  order numerator on 13 November; whether Pienissimo should be getting the
  integration contract from ROMI or from their own Mexal partner is a question for
  the client, not for the developer.

## Not established

- What the _"collegamenti interni"_ are, and whether they read or write Mexal.
- Whether Fabrizio Paganelli, who is cc'd and owns the Mexal relationship,
  endorses the request.
- Whether anything has been sent. As of this sweep the thread holds **one
  message** and no reply.
