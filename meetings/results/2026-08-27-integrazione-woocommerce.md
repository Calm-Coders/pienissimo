# [ROMI-PIENISSIMO] Integrazione WooCommerce — 2026-08-27

**Sources:** [meetings/2026-08-27-integrazione-woocommerce-transcript.it.md](../2026-08-27-integrazione-woocommerce-transcript.it.md) (original Italian transcript, Google Meet + Gemini notes, **48m20s**) · [recording](https://drive.google.com/file/d/1UjJNRMmX73UGC-ZFOu_ngWIKJVSwDUwv/view) · [notes & transcript](https://docs.google.com/document/d/1EgEzGO3qtD8r0eC_uleobil6WnJgknpRvoZDG--IPIw/edit) · found by the nightly `requirements-check` sweep of 2026-08-27

**Attendees:** ROMI — Elena Spini (chair), Aurel Mrruku, Andrea Di Cicco. Pienissimo — Sabatino Rinaldi, Fabrizio Paganelli, Elisa Migliano. `amministrazione@pienissimo.com` was on the invitation.

> **Attribution caveat.** Speaker labels in this project are chronically unreliable. In this transcript they are readable and the six voices are distinguishable; this recap follows the transcript and uses the Gemini summary only for cross-checking. Where they differ, the transcript governs.

> **Context:** the technical session [OI-49](../../notes/items/OI-49%20WooCommerce%20checkout-link%20flow.md) had been waiting for since **31 July**, and the fourth post-Ferragosto restart meeting. A second, hands-on session ran the same afternoon — [Test Integrazione WooCommerce](2026-08-27-test-integrazione-woocommerce.md).

---

## The headline

🟢 **The integration direction is settled: WooCommerce writes into Salesforce. And it is not a stock webhook.**

The record has carried "webhook, ROMI recommends it" since 6 August without anyone testing it against what WooCommerce can actually do. It was tested on screen in this session and rejected:

| Option | Outcome |
| ------ | ------- |
| Salesforce scheduled pull | ❌ rejected — Salesforce has no order to poll for |
| Stock WooCommerce webhook | ❌ **evaluated live and rejected** — one topic per webhook, no multi-select, no control of the body |
| **Custom plugin, PHP action hook on order status transition** | ✅ **agreed** |

Sabatino Rinaldi, working the WooCommerce admin UI: _"non è che mi fa fare una multiselection, mi fa fare solo una selezione."_ A stock webhook would push **every order in every state** and could carry no customer structure at all. Aurel Mrruku read WooCommerce's own guidance aloud — it advises against the stock webhook for that reason and recommends a small plugin whose action inspects the order state.

Recorded at [the WooCommerce order integration](../../notes/flows/The%20WooCommerce%20order%20integration.md). Closes `INT-14`.

---

## Decisions

### 1. Direction and mechanism

**WooCommerce pushes; Salesforce receives.** Aurel Mrruku: _"è una comunicazione outbound lato vostro, inbound lato sales force."_

The exchange that produced it is worth keeping. Asked how his existing Pienissimo platform learns that an order has moved to _in lavorazione_, Sabatino Rinaldi described a **cron polling WooCommerce every few minutes** — _"ho un [cron] che ogni tot di minuti va a controllare che è un sync"_. Aurel Mrruku named the two problems: it is **asynchronous**, and the call runs **from his platform to WooCommerce**, the wrong way round for Salesforce, which has no order to poll for. Sabatino Rinaldi drew the conclusion himself: _"deve essere WooCommerce che scrive su Sales Force."_

⚠ This **supersedes the mu-plugin** in `Integrazione_Salesforce_WooCommerce.docx`. The client-side component is Sabatino Rinaldi's own plugin, written and maintained by Pienissimo.

### 2. The three business scenarios, stated by the client and approved

Elena Spini set them out; Aurel Mrruku restated the end-to-end flow and she approved it aloud — _"A me torna."_

| # | Case | What Salesforce must receive |
| - | ---- | ---------------------------- |
| 1 | Customer **not** known to Salesforce | full company anagrafica **+** contact **+** what is being bought |
| 2 | Account and contact **already** exist | the order only |
| 3 | **Recall-tutor** opportunity | a Salesforce-generated link carrying the **Opportunity id**, which returns on the order |

Scenario 3 is OI-49 end to end: Salesforce creates an opportunity of a given type → it generates an email carrying a link with the opportunity id → the customer clicks through to the WooCommerce cart → on the order reaching the trigger state the plugin pushes it, with the id, to Salesforce. Scenarios 1 and 2 are the same mechanism **without the first leg**.

### 3. Payload shape

**One JSON body, three sub-structures: order, customer, order lines.** Aurel Mrruku does the wrapper mapping on the Salesforce side and asked only that a first test carry _"un dato sulla struttura dell'ordine, un dato sulla struttura del cliente, un dato sulla struttura del prodotto"_ before the fields are frozen.

Andrea Di Cicco asked whether to split it into one webhook for the customer and one for the order. Aurel Mrruku: the cost is much the same either way — _"non è che cambia tanto avere due rapper complessi oppure avere un rapper gigantesco"_ — but a single call means a single point of failure to trace. It resolved in practice to one payload, which the afternoon session then demonstrated.

### 4. Stage sales are mandatory in the test set

Fabrizio Paganelli's own escalation, unprompted, at the close. Tracked as [OI-101](../../notes/items/OI-101%20Stage%20sales%20must%20be%20in%20the%20WooCommerce%20test%20set.md) — see **Open questions** below.

---

## Action items

| # | Owner | Action | State |
| - | ----- | ------ | ----- |
| 1 | Sabatino Rinaldi | Build the plugin and run a wire test against a throwaway endpoint | ✅ **done the same afternoon** |
| 2 | Aurel Mrruku | Map the payload fields onto Salesforce | 🔴 open — needs the payload file |
| 3 | Sabatino Rinaldi, Aurel Mrruku, Elisa Migliano | Technical test of the integration | 🟡 partially — the 16:00 session ran without Elisa Migliano |
| 4 | Sabatino Rinaldi, Aurel Mrruku | **Simulate stage sales** | 🔴 open — [OI-101](../../notes/items/OI-101%20Stage%20sales%20must%20be%20in%20the%20WooCommerce%20test%20set.md) |
| 5 | Andrea Di Cicco | Merge the WooCommerce and Mexal field sets | 🔴 open, **unassigned in session** — [OI-103](../../notes/items/OI-103%20WooCommerce%20and%20Mexal%20field%20overlap.md) |

---

## Open questions / risks

🔴 **Stage sales are the money and they are untested.** Fabrizio Paganelli: _"se ci blocchiamo su una vendita di un libro o di uno stream che costa €97, pazienza. Ma se ci blocchiamo su una vendita da palco che magari sono in gioco anche €8.900 €900 o più, dopo lì diventa un problema grosso."_ WooCommerce is used *heavily* for stage sales — the customer in the room scans a QR code and buys — and a stage sale **triggers downstream mechanisms, contract generation among them**. He asked for both cases to be simulated. Aurel Mrruku accepted the technical test but drew the distinction that a **functional test across the cases is separate work**, and it is not scheduled. [OI-101](../../notes/items/OI-101%20Stage%20sales%20must%20be%20in%20the%20WooCommerce%20test%20set.md).

🔴 **The WooCommerce and Mexal field sets will collide.** Andrea Di Cicco raised it early — _"dovremmo fare un attimo il un merge... onde evitare di creare 12.000 campi"_ — and **nobody picked it up**. It is in neither session's next steps and in neither Gemini decision list. [OI-103](../../notes/items/OI-103%20WooCommerce%20and%20Mexal%20field%20overlap.md).

🔴 **The credentials were not exchanged.** The invitation promised _"integrazione tecnica con WooCommerce tramite Webhook, comprensiva dello scambio di credenziali"_ and they have been owed since 14 July. They were never raised. The session's own outcome partly explains it — the blocking credential is now the **Salesforce** endpoint and token, which ROMI owes ([OI-102](../../notes/items/OI-102%20Salesforce%20endpoint%20and%20token%20for%20the%20WooCommerce%20plugin.md)). Whether WooCommerce CK/CS are still needed for a read-back is **unresolved**.

⚠ **Two WooCommerce instances** are on record in `INT-11`; both sessions dealt with one shop. Never revisited.

⚠ **Pienissimo has no WooCommerce specialist.** Elena Spini asked whether they had a WooCommerce equivalent of Kreosoft's Mirko Merendi; Sabatino Rinaldi: _"no, non abbiamo mai avuto bisogno."_ He is the technical team on this integration.

---

## Notes

**The spec had already answered part of this, and the room did not have it.** In the ROMI group DM running alongside the call, Elena Spini posted the link to `Integrazione_Salesforce_WooCommerce.docx` at 10:08 CEST. Andrea Di Cicco replied _"ma io non l ho mai visto sto documento XD"_, then _"io sto andando a braccio"_. Elena Spini: _"queste sono le casistiche io non so manco cosa sia sto webhook."_ The document has been in the Slack canvas since 31 July. Not a decision — but it explains why the session re-derived an architecture the spec already proposed, and it is the second time in four days that a document already in the record was missing from the people using it.

**Requirement changes from this session:** `INT-14` open → **agreed**; `INT-13` mu-plugin superseded and the link-generator's product/quantity pickers dropped; `INT-11` credential direction reversed. All landed in `pienissimo-requirements.yaml`, `REQUIREMENTS.md` and `REQUISITI.it.md`.
