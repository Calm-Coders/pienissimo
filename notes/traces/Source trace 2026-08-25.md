---
id: trace-2026-08-25
type: reference
status: active
updated: 2026-08-25
watermark_used: 2026-08-24
external_watermark: 2026-08-25
account: a.mrruku@romicompany.com
---

# Source trace 2026-08-25

**Watermark for the next `requirements-check` run: 2026-08-25.**

**Watermark used for this run: 2026-08-24** — the
[trace of that day](Source%20trace%202026-08-24.md), selected by its `updated:`
frontmatter field, not by filename order.

## Sources searched

All read-only. **Nothing was sent, replied to, shared, modified or marked read.**
The single message this job sent is its own report to the Slack group
`C0BQD34LLF4`, which the procedure permits.

| Source | Query / scope | Result |
| ------ | ------------- | ------ |
| **Gmail** | `pienissimo after:2026/08/24` | 6 threads — **2 new**, 4 already held |
| **Gmail** | all mail `after:2026/08/24 -in:draft` | 24 threads — 5 project-adjacent, the rest other clients (TFP/Tableau, Daze, bitmobility, 247.it) and vendor/security noise |
| **Slack** | `#tproj-pienissimo` (`C0B5T3RB4FM`), 10 messages back | Last post still **07 Aug 17:12** — unchanged for a fifth week |
| **Slack** | Canvas *Link utili Pienissimo* (`F0BD2H5A9HT`), re-read in full | **Unchanged** — link-for-link identical to the 24 Aug read. The 25 Aug session is **not** on it |
| **Slack** | Workspace-wide incl. private channels, DMs and group DMs, after 2026-08-24 | 20 hits — **two DM threads are findings** (see below); the rest are bitmobility and this job's sibling LIFE365/IUAD reports |
| **Drive** | `modifiedTime > 2026-08-24`, both pages | 17 files — **3 are project findings**, the rest TFP/Tableau, Daze, and 24 Aug items already held |
| **Drive** | `Flows & Objects.drawio` downloaded and base64-decoded | **Read in full**, 130 KB, plain uncompressed mxfile XML, 3 pages, 162 distinct labels |
| **Drive** | Anticipay Gemini doc `17eH8QPV…` | **Read**, 50 KB; notes section extracted by offset, transcript deliberately not loaded |
| **Fathom** | All meetings created after 2026-08-07 | **0 recordings.** Unchanged since 06 Aug — recordings still land in Drive, not Fathom |

## Found

**Six things, one of them a design reversal.**

**1. 🔴 The 25 August Anticipay session ran, and it changed the counterparty.**
`[ROMI-PIENISSIMO] - Integrazione Anticipay`, 10:00 CEST, client-facing, with
Gemini notes, transcript and recording. **Salesforce will not call Anticipay** —
it calls a middleware built and hosted by **Pienissimo Software Srl**. Token in
the header, `404`/`500` error codes stored in Salesforce for three months,
returned values overwrite Salesforce, payload trimmed to fields nobody has picked
yet. Minuted at
[2026-08-25 Integrazione Anticipay](../meetings/2026-08-25%20Integrazione%20Anticipay.md);
new items
[OI-94](../items/OI-94%20Anticipay%20is%20called%20through%20the%20Pienissimo%20middleware.md)
and [OI-95](../items/OI-95%20Which%20Anticipay%20fields%20land%20in%20Salesforce.md).

**2. A follow-up is booked for Tuesday 1 September, 10:00 CEST**, client-facing.
Invitation sent 25 Aug 13:17 UTC. Andrea Parmeggiani owes the API structure
example by **Friday 4 September**; the call is cancellable if it lands first.

**3. ⚠ A Gemini action item is wrong, and the client-facing invitation carries
the error.** The minute assigns "create the test environment" to Aurel Mrruku.
Elena Spini put the list to him on Slack at 15:03 CEST and he corrected it —
_"l'ambiente di test nostro esiste già … serve un loro ambiente di test dove noi
dobbiamo puntare"_ — and she accepted. The invitation went out at 13:17 UTC,
before the correction, and has not been re-sent.

**4. `Flows & Objects.drawio` moved a fifth time**, 2026-08-25T08:23:31Z — 10:23
CEST, **during the call it records**. One cell changed, and **the file now
contradicts itself**: LEAD-OPTY reads _"chiamata API al middleware Pienissimo"_,
Ordini still reads _"chiamata API Anticipay"_. See
[the newest design diagram](../The%20newest%20design%20diagram.md).

**5. Three things arrived on Slack rather than in a meeting**, all closing items
that were on the "still owed" list:

- **The Postman collection** — `Mexal Dev.postman_collection.json`, Andrea Di
  Cicco → Aurel Mrruku, 11:52 CEST. Incomplete, and he says so.
- **The invoice-to-order-line link**, named as the hard part on 24 August: a
  single Mexal invoice carries the list of its items, so per-line payment status
  is reachable. Feeds [OI-50](../items/OI-50%20Tranche%20object.md) and
  [OI-58](../items/OI-58%20Mexal%20integration%20mechanics.md).
- **Marco Montesi's reminder-email copy**, owed since 20 August, relayed by Elena
  Spini at 10:11 CEST. Feeds
  [OI-59](../items/OI-59%20Quote%20workflow%20configuration.md).

**6. The corporate structure stated plainly**, Elena Spini on Slack, 10:19 CEST:
Pienissimo Srl **resells** the Pienissimo Pro software, which is owned by the
distinct legal entity Pienissimo Software Srl. It is the clearest statement of
the relationship in the record, and it lands the same morning as finding 1.

## What it changed

Three notes created (one meeting, OI-94, OI-95), seven updated (OI-50, OI-58,
OI-59, OI-73, the design diagram, the phase 2 risk, Andrea Parmeggiani), plus
`MAP.md`, `INDEX.md`, both trackers (rows 50, 58, 59, 73 and the new 94, 95) and
both recaps (§18).

**The finding that matters most is not the architecture.** It is that a **Fase 1
integration now has a hard build dependency on Pienissimo Software Srl** — the
entity at the centre of
[the phase 2 scope dispute](../risks/Risk%20-%20the%20phase%202%20scope%20dispute%20is%20unresolved.md).
Fase 1 cannot go live unless that company writes a service, hosts it and keeps it
running. Nobody in the session named it. Who pays, and who owns uptime after
go-live, was not raised.

## Deliberately not ingested

- **No requirement document was touched.** `pienissimo-requirements.yaml`,
  `REQUIREMENTS.md` and `REQUISITI.it.md` are unchanged. The counterparty of a
  Fase 1 integration bears directly on signed text, but rewriting a contractual
  document off a nightly sweep is a human's call. Flagged, not done.
- **The 25 August transcript was not loaded to browse.** The document is 50 KB;
  only its notes section (the first 14.8 KB) was read, per the protocol.
- **`ST000036`** and the article codes discussed in the Andrea Di Cicco DM —
  values, not facts. Recorded as "they discussed product codes", never copied.
- The `[TFP] Follow Up Tableau` session, the `Daze - whatsapp` session, the Notion
  access request for the **IUAD** page, the Salesforce personalization
  non-renewal notice, the Trailblazer code, the 1Password and Workspace notices,
  and the bitmobility / 247.it threads — other clients or vendor noise.

## Still unreachable / still owed

Carried from 24 August unless marked:

- 🟢 **Closed this run:** the Postman collection (partial), the reminder-email
  copy, the invoice-to-order-line question.
- 🆕 **The Anticipay middleware API example**, Andrea Parmeggiani, due **4 Sept**
  — with the test environment and the full Anticipay field list.
- ⚠ **The DNS records and the marketing forms.** Matteo Distaso's deadlines were
  **Fri 21 Aug** (DNS) and **Wed 26 Aug** (forms); Rebecca Marmo owed funnel
  screenshots. **Still no source confirms any of it.** The DNS date is now four
  days past.
- **The Mexal WEBAPI credentials** — promised by mail since July, still absent.
  Mirko Merendi's technical mail to Fabrizio Paganelli is **still unanswered**.
  Due at the 26 August review.
- **Marco Montesi's preset quote-expiry timings** per product category — distinct
  from the copy that arrived.
- **Listino 1 vs listino 2** — Mirko Merendi deferred to Fabrizio Paganelli;
  unanswered.
- **A Mexal test company.** Serie 10 is a test lane inside production data.
- **The Pienissimo 30 July marketing follow-up** notes — never circulated.
- **The Zoho data-model workbook** (OI-24) and ROMI's **import template**
  (OI-88).
- The **Pienissimo UAT org** is not reachable from here; run `org-status-check`.

## Method notes worth keeping

- **Slack DMs carried three findings this run and the project channel carried
  none.** `#tproj-pienissimo` has been static for five weeks while the work moved
  entirely into direct messages between Aurel Mrruku, Elena Spini and Andrea Di
  Cicco. A channel-only sweep would have returned "nothing new" on a day that
  reversed an integration design.
- **Read the Slack DM before trusting the Gemini action list.** The correction to
  the test-environment action exists only in a DM, four hours after the minute
  and two hours after the client-facing invitation repeated the error. Gemini's
  `Decisioni` block was right and its `Passaggi successivi` block was wrong, in
  the same document.
- **The canvas was genuinely unchanged this run** — re-read in full, link-for-link
  identical, and the 25 August session is not on it. That does **not** retire the
  24 August lesson; it means the canvas lags, not that it is stable.
- **The design file can move during the meeting it records.** The 08:23 UTC edit
  landed twenty minutes into a call that started at 08:00 UTC. Check the file
  after a session, not only after the minutes.
- **A one-page edit to a multi-page diagram is a contradiction, not an update.**
  Diff every page against the previous decode; the stale page is the one a
  developer will read.
- **`OI-90` has a note but no tracker row** — a pre-existing gap from the 14/08
  sweep, still not closed. Left alone rather than renumbering client-facing rows
  unasked.
