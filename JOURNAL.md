# Journal - Pienissimo

Append-only session handoffs. Newest first. Any agent, any model, writes here
at the end of a session that changed project state, so the next one can resume
cold. Format and intent:
[notes/Retrieval and write protocol.md](notes/Retrieval%20and%20write%20protocol.md).

Keep the twenty most recent entries here; archive older ones to
`notes/sessions/YYYY-QN.md`.

---

## 2026-09-01 — claude — nightly requirements-check: the Anticipay follow-up drilled, and OI-95 is resolved

- **Did:** swept Gmail, Slack, Drive and Fathom from watermark
  **2026-08-31T22:00Z**. ⚠ **Not** from the newer
  [01/09 Anticipay drill trace](notes/traces/Source%20trace%202026-09-01%20Anticipay%20API%20drill.md),
  which is newest by `updated:` but **disclaims itself as a watermark in its own
  first line**. Selecting mechanically by frontmatter would have skipped the
  31/08 → 01/09 window entirely. Then drilled the **01/09 Anticipay follow-up** —
  Gemini notes, notes document and **the full 19m49s transcript**.
- **State:** the meeting the last trace called _"the single most valuable thing
  outstanding"_ is in the record
  ([the minute](notes/meetings/2026-09-01%20Follow-up%20Integrazione%20Anticipay.md)),
  and it **resolved [OI-95](notes/items/OI-95%20Which%20Anticipay%20fields%20land%20in%20Salesforce.md)**:
  all eleven middleware fields land on `Account`, the legal representative on the
  Account rather than a Contact, his address as one free-text field. The `:env`
  split was **invented in that call** (v2-as-outcome now confirmed, not
  inferred); the **shared token is deliberate** (OI-106, asked outright);
  **Anticipay serves Italian companies only**, which answers the foreign-VAT half
  of `INT-18` in the negative and which nobody in the room noticed (OI-73). Four
  of six open questions were **never raised**. New: **OI-109** (codice
  destinatario SDI) and a
  [risk note on org access](notes/risks/Risk%20-%20the%20team%20lost%20access%20to%20the%20Pienissimo%20orgs%20on%201%20September.md).
  Eight notes updated, three created; rows 48/94/95/98/105/106/108 + new 109 in
  both trackers; §24 in both recaps. **No requirement changed.**
- **Next:** ⚠ **`Anagrafica Articoli.xlsx`** — Fabrizio Paganelli's 01/09 14:04Z
  attachment carrying the bundle-only code proposal and questions addressed to
  ROMI — **is unread and the meeting it was prepared for is 2 September.**
  Somebody has to download it by hand, as with the WooCommerce payload and the
  API PDF. Then chase **three** Anticipay questions, not six: the error response
  bodies, the pass-through date, the `dascita` typo.
- **Watch:** 🔴 **Do not record OI-108 as "the client considered and declined".**
  The personal-data question was **never raised** in the call; the room took all
  five person fields without it being asked. One field now has a stated purpose
  (contract signature), four do not. ⚠ Also: **org access failed for both Aurel
  Mrruku and Elena Spini on the morning of 01/09 and nothing written says it was
  restored** — the two decaying findings (Biglietto recycle bin ~12 Sept, the
  unversioned `WoocommerceOrderService`) can only be worked from inside that org.
  ⚠ Housekeeping: the 01/09 drill's own entry sits at the **bottom** of this file
  rather than the top, against the newest-first rule. Left in place, not moved.

## 2026-08-31 — claude — nightly requirements-check: a destructive deploy took 37 records and 270 lines of unversioned code

- **Did:** swept Gmail, Slack, Drive and Fathom from watermark **2026-08-28T22:00Z**
  (from [the 28 Aug trace](notes/traces/Source%20trace%202026-08-28.md), by
  `updated:`). Window 29–31 Aug; the 29th and 30th were a weekend and are empty
  everywhere.
- **State:** **one client mail, no meeting, and a second consecutive stranded org
  check.** Drive zero, Fathom zero, `#tproj-pienissimo` silent since 28/08, canvas
  unchanged and now five sessions behind.
- **Finding 1 — 🔴🔴 `Biglietto__c` was deleted from the org with all 37 records,
  and seven Apex components went with it that were never in source control.** An
  `org-status-check` at 31/08 09:36–09:52Z found it and, for the second run
  running, **published nothing**. The mechanism it said it could not establish was
  one `git show` away: commit **`5d8cdb3`** (Anita Aga, 28/08 18:10 CEST) carries a
  destructive-changes manifest. `git log --all` proves **none of the eight deleted
  components ever existed in this repository on any branch** — so ~270 lines of the
  DocuSign and PDF stack are gone from their only copy, code that had run (19 of
  37 records carried an envelope id). The org check called this "drift resolved by
  deletion from both sides"; **there were never two sides**, and I corrected that
  reading in the record. Records were **not** migrated: Asset went 4 → 5. Recycle-bin
  recovery closes about **12 September**.
- **Finding 2 — 🟢 the Anticipay API documentation arrived four days early.** Andrea
  Parmeggiani, 31/08 16:15Z, `Documentazione API – Salesforce.pdf`. Owed by 04/09.
  First client commitment on this project met ahead of its date. **The PDF is
  unread** — a sweep cannot open a Gmail attachment. Its mail body alone adds a new
  contract fact: during the test period the middleware **serves only from the
  Pienissimo cache and does not call Anticipay**, so a test-period `404` cannot be
  told from a genuine not-found.
- **Finding 3 — the same unversioned-code pattern is live on WooCommerce.** The
  deployed `WoocommerceOrderService` is not in source control and the repo's
  unshipped `WooCommerceOrderEndpoint` claims the same `urlMapping`; the duplicate
  contract silently changed 409 → 200 + `duplicate: true` without telling Sabatino
  Rinaldi; `INT-16` survived a full rewrite still unauthenticated.
- **Next:** three things have dates. **Open the Anticipay PDF before the 01/09
  10:00 call.** **Ask Anita Aga whether an export was taken** before ~12 Sept.
  **Retrieve `WoocommerceOrderService` into `force-app/`** — one command, and it is
  the largest uncovered class as well as the live endpoint.
- **Watch:** ⚠ this sweep **did not open the org**; every build-state assertion is
  attributed to the 31/08 run and dated. ⚠ **Coverage fell 1,769 → 1,571 and that
  is not progress** — the whole difference is deleted code, no test was written;
  never quote the improvement without that clause. ⚠ OI-66 is **superseded, not
  done**. ⚠ The Biglietto deletion is a **ROMI-side incident** and was deliberately
  **not** given a client-facing tracker row — whether it is disclosed is a human's
  call, not a sweep's.
- **Cost:** 9 notes updated, 3 created; both trackers (rows 66, 81, 94, 95, 102,
  104), a new §22 in both recaps plus the §21.10 table corrected, MAP, INDEX,
  trace. **No requirement changed**, so the register and both prose documents are
  untouched.

## 2026-08-28 — claude — nightly requirements-check: a quiet night externally, five false claims corrected internally

- **Did:** swept Gmail, Slack, Drive and Fathom from watermark **2026-08-27T22:00Z**
  (from [the 27 Aug trace](notes/traces/Source%20trace%202026-08-27.md), by
  `updated:`). The earlier 28 Aug entry below was the payload ingest — a single
  artifact, not a sweep — so it moved no watermark.
- **State:** **no client sent anything and no meeting ran.** Gmail returned zero
  Pienissimo items after the watermark across three query shapes; Drive zero,
  fully paged; Fathom zero; the canvas unchanged and still four sessions behind.
  Both findings were ROMI-side, both on Slack.
- **Finding 1 — the record was materially out of date.** An `org-status-check`
  ran on 28/08 14:45–14:56Z, verified five `MAP.md` claims **false**, and
  **published nothing** ("no note or requirement mutated"). Its results were
  sitting in a group DM. Folded in: 2 Flows exist, Asset has 8 custom fields, the
  WooCommerce endpoint is deployed and taking live traffic, `OrderItem.Tranche__c`
  is granted to `Tranche_Management`, and the Lead-conversion break is
  **resolved** — the 27/08 note that inferred it was written without org access
  and was wrong. OI-104's dedupe turns out to be **already built**
  (`WooCommerce_Order_Key__c`, unique + external id, 409, exercised); what remains
  is a SOQL-then-insert race and `INT-16`, now verified from the code as having
  **no auth at all**.
- **Finding 2 — the phase 2 red flag is five weeks old and unchanged.** Elena
  Spini's status post broke a seven-week silence in `#tproj-pienissimo`, but its
  red-flag paragraph is **verbatim** from 24/07, 31/07 and 07/08. The one new
  sentence says she still has no update. Also new and genuinely positive: the
  **2 MKT flows are confirmed and Fabrizio Mastracci is building them** — while
  the 100+ form review is confirmed **still owed after nine weeks** and the funnel
  screenshots he needs have never been confirmed delivered.
- **Next:** OI-102's token is the whole of the WooCommerce authentication and the
  tests are the week of 31 Aug — that is the one thing with a deadline. Settle
  OI-81's `30 vs 60` before the flow is finished. `STATUS.md`, the Notion mirror
  and the Flows page are still owed by `org-status-check` — **second trace
  running**.
- **Watch:** ⚠ this sweep **did not open the org**; every build-state assertion
  written tonight is attributed to the 28/08 run and dated. ⚠ Do not cite Elena
  Spini's 28/08 post for the _merits_ of the phase 2 dispute — it adds no
  argument, only a date for the silence. ⚠ "Fabrizio" in that post is **Mastracci
  (ROMI)**, not Paganelli (Pienissimo).
- **Cost:** 5 notes updated, 0 created; both trackers (rows 14, 81, 104), both
  recaps, MAP, INDEX, trace. **No requirement changed**, so the register and both
  prose documents are untouched.

## 2026-08-28 — claude — the WooCommerce payload attachment was opened

- **Did:** Aurel Mrruku supplied the file Sabatino Rinaldi mailed on **27/08 at
  14:20:18Z** (subject _"Integrazione woo commerce - salesforce"_, cc Andrea Di
  Cicco and Elena Spini, body _"Ecco il payload:"_). Provenance confirmed against
  Gmail. Not a meeting and not a sweep — a single artifact, decoded and folded in.
- **State:** preserved at `Payload woo-salesforce.json` in the repository root,
  verified identical to the mailed original. Decoded in
  [the WooCommerce payload contract](notes/The%20WooCommerce%20payload%20contract.md).
  **Two notes created** (the contract, OI-104), **three updated** (the flow,
  OI-49, OI-102), both trackers (rows 49 and 102 touched, **104** added), the
  register (`INT-11`, `INT-16`) and both prose mirrors, `MAP.md`, `INDEX.md`.
- ⚠ **Read the contract note's "How to read it" section before using any of
  this.** Aurel Mrruku's own instruction, given during the session: the file is
  **one example order** and is authoritative on the payload's **structure only**.
  Do not raise findings about which of its fields were empty or duplicated — the
  sample is a €50 test product through a test funnel. An earlier pass of this
  session did exactly that and produced three items off the sample values; they
  were withdrawn before anything left the repository. **Ask Sabatino Rinaldi
  instead** — the open questions are listed at the foot of the contract note.
- **What it closed:** 🟢 two of the five points OI-49 has carried since 31 July —
  the parameter is **`sf_opportunity_id`** (top level, and again in `meta_data`;
  the recorded `sf_opp_id` was only the snippet default), and the id is the
  **15-character** Salesforce form, case-sensitive. Both are structural, so the
  example does settle them.
- **What it cost:** 🔴 **the id travels in clear** — the envelope has no
  signature, nonce or send-timestamp field — so the header token ROMI owes is the
  _entire_ authentication of this integration, while `INT-16` still recommends a
  signed token. 🔴 **No idempotency key either**, beside a plugin that has a
  manual re-send button and a trigger that fires on two states. Both are one item,
  [OI-104](notes/items/OI-104%20The%20WooCommerce%20payload%20has%20no%20idempotency%20key.md).
- **Worth reading before anyone writes the endpoint:** `meta_data[].value` is
  string, object _and_ array across rows, so a typed Apex wrapper throws;
  `tracking.first_click` is not ISO 8601 and `Datetime.valueOf` fails on it; every
  money value is a string with inconsistent decimals; `order.id` is a number while
  `order.number` is a string. Full list in the contract note.
- **Next:** the endpoint under
  [OI-102](notes/items/OI-102%20Salesforce%20endpoint%20and%20token%20for%20the%20WooCommerce%20plugin.md)
  now has a contract to build against and the client half is delivered. Before the
  **week of 31 August** tests it needs a dedupe rule (OI-104), a decision on the
  clear-text id (`INT-16`), and Sabatino Rinaldi's answers on `event` values and
  `sku`. Fase 1 development ends **10 September**.
- **Not touched:** Apex tests — still Aurel's separate task, unprompted work
  forbidden.

---

## 2026-08-27 — claude — nightly requirements-check: the WooCommerce integration is settled, and half of it is already built

- **Did:** swept Gmail, Slack, Drive and Fathom against the **2026-08-26T21:40Z**
  watermark (the 26 Aug nightly trace, selected by `updated:`). Found **both
  27 August WooCommerce sessions** — Gemini notes, **full transcripts** and
  recordings for each — and drilled them per `drill-meeting`. Also found a live
  Apex failure in the Pienissimo partial sandbox that came from no meeting at all.
- **State:** transcripts preserved verbatim at
  `meetings/2026-08-27-integrazione-woocommerce-transcript.it.md` (48m20s) and
  `meetings/2026-08-27-test-integrazione-woocommerce-transcript.it.md` (17m13s),
  each read once in full. Bilingual recaps for both in `meetings/results/`.
  **Eight notes created, six updated**, both trackers (rows 49 and 73 touched,
  100–103 added), both recaps (§21), `MAP.md`, `INDEX.md`. Full audit:
  [the trace](notes/traces/Source%20trace%202026-08-27.md).
- **The headline:** 🟢 **the integration direction is settled — WooCommerce writes
  into Salesforce**, and not via a stock webhook: those were evaluated on screen
  and **rejected** (one topic per webhook, no multi-select, no control of the
  body). The mechanism is a **custom WooCommerce plugin on a PHP order-status
  action hook** sending one JSON body with order, customer and lines —
  [the flow](notes/flows/The%20WooCommerce%20order%20integration.md). 🟢 **And
  Sabatino Rinaldi had already built it** by the afternoon session: v1.3, always
  active, HTTP 200 on the wire against the production shop, with a manual re-send
  button.
- **Requirements moved, for the first time in three sweeps.** `INT-14` open →
  agreed · `INT-13` mu-plugin superseded and the link generator's product/quantity
  pickers dropped, because carts are **Funnel Kit** funnels that already carry the
  product · `INT-11` credential direction **reversed** · 🔴 **`ORD-12` corrected**
  — an order reaches Salesforce at **`in lavorazione` OR `completato`**, any
  payment method, not only COMPLETATO, so every line arrives paid. All landed in
  the YAML register, `REQUIREMENTS.md` and `REQUISITI.it.md` in the same session,
  with `tracked_by` wired back.
- **Next:** 🔴
  [OI-102](notes/items/OI-102%20Salesforce%20endpoint%20and%20token%20for%20the%20WooCommerce%20plugin.md)
  — **ROMI owes Pienissimo the Salesforce endpoint and header token.** It is the
  only thing between a working client-side plugin and a real test, and it blocks
  the integration tests set for the **week of 31 August**. Nothing of the
  Salesforce side exists. Also: **download the `Payload woo-salesforce`
  attachment** from Sabatino Rinaldi's 14:20Z mail — it is the authoritative
  field list and no connected tool can open a Gmail attachment.
- **Watch:** 🔴
  [the sandbox failure](notes/risks/Risk%20-%20LeadConversionQueueable%20is%20broken%20in%20the%20Pienissimo%20sandbox.md)
  — `LeadConversionQueueable` threw _"No such column 'Servizio_Interesse__c' on
  entity 'Lead'"_ at 15:08Z. **The repo's copy of that class does not select that
  field** and the field's metadata **is** in `force-app/`, so the org runs a
  different version and the sandbox lacks a field the repository has. Lead
  conversion does not complete there, which also blocks testing
  [OI-100](notes/items/OI-100%20Same%20lead%20email%20with%20different%20VAT%20during%20conversion.md).
  Written **without org access** — confirm before acting. ⚠ Also: the afternoon
  session had **two participants and no minute but Gemini's**, and it relocated
  the **client-agreed P.IVA check** ([OI-73](notes/items/OI-73%20VAT%20validation%20moves%20into%20Salesforce.md))
  with neither Elisa Migliano, who proposed it, nor Elena Spini, who approved it,
  in the room. Prefer the 6 August client rule until someone restates it.
- **Not done, deliberately:** no Apex test class written or proposed — coverage is
  Aurel Mrruku's separate task before the production deploy. `STATUS.md`, the
  Notion mirror and `site/` were not regenerated: they carry **build state**,
  refreshed by the 26 Aug org check, and this sweep moved decisions. A note landed
  in `notes/flows/`, so **step 6a-bis applies on the next org-status run** —
  flagged, not done.

---

## 2026-08-26 — claude — nightly requirements-check: the Mexal review, and the edition mechanism changes again

- **Did:** swept Gmail, Slack, Drive and Fathom against the **2026-08-26**
  watermark (the trace taken at ~13:15 CEST the same day, selected by
  `updated:`). Found the **26 August `Review Temi Integrazione Mexal`** client
  session — Gemini notes, **full 1h25m45s transcript** and recording — and
  drilled it per `drill-meeting`. Also found a new **2 September** client meeting
  and a substantive ROMI group DM thread.
- **State:** transcript preserved verbatim at
  `meetings/2026-08-26-review-temi-integrazione-mexal-transcript.it.md` and read
  once in full. Bilingual recap in `meetings/results/`. **Five notes created**
  (the meeting, OI-96/97/98/99), **eleven updated**, both trackers, both recaps
  (§20), `MAP.md`, `INDEX.md`. `vault:check` green — 126 notes, 126 unique ids,
  all links resolve. Full audit:
  [the trace](notes/traces/Source%20trace%202026-08-26%20nightly.md).
- **The headline:** 🔴 **the event edition now comes from a hand-maintained
  Salesforce table** keyed on `article code × order-date window`, matched **per
  order line**, with a separate hand-entered event date driving the no-show
  logic — [OI-96](notes/items/OI-96%20Edition%20mapping%20table%20on%20Salesforce.md).
  It **replaces the one-active-child-campaign rule** agreed 24 August, which
  Elena Spini killed in session because a bundle spanning two events cannot
  resolve to one active edition. This also settles what
  [OI-46](notes/items/OI-46%20Bundle%20classification%20picklists.md) turns on:
  `Anno_Solare__c`'s job now belongs to OI-96, and it is populated on 1 of 280
  products, so dropping it costs one record.
- **Also landed:** Mexal's three classification fields are assigned and each was
  **tested on the wire** — `natura` → genera biglietto, `categoria statistica` →
  the event, `gruppo merceologico` → candidate for ticket type, `Gest. annullato`
  → product disabled. Only **listino 1** is used. **Invoicing stays Mexal-driven
  for ~6 months.** A ticket-generating article and its bundle twin need **two
  distinct codes**, which reverses the 24 August reading in
  [OI-48](notes/items/OI-48%20Bundle-only%20article%20codes.md).
- **Next:** 🔴 **[OI-92](notes/items/OI-92%20Mexal%20Scadenziario%20as%20the%20trigger%20to%20reverse%20an%20asset.md)
  was the question this meeting existed to answer and was never asked** — the
  word _scadenziario_ is not in the transcript, and it now has no forum. Put it
  on the **2 September** agenda explicitly, together with the customer-registry
  items, because that invitation is titled for the **article** registry only.
- **Watch:** 🔴
  [OI-98](notes/items/OI-98%20The%20Mexal%20article%20registry%20is%20being%20re-created.md)
  — Fabrizio Paganelli intends to **close all ~1000 article codes and re-create
  them**, listini included, going to direction on **31 August**. It makes
  `Prodotti e Bundle.xlsx`, the event list, the tier evidence and the 280 UAT
  products provisional, **eleven days before Fase 1 development ends**. Nobody in
  the session connected the two. ⚠ Also: `Flows & Objects.drawio` moved a
  **sixth** time, six minutes into the meeting, and **no tracked text cell
  changed** — but it now contradicts the minutes on campaigns as well as on
  Anticipay. Prefer the meeting note over the diagram on campaigns.
- **Not done, deliberately:** no requirement document was opened or changed —
  the session settled a mechanism, not a clause, and OI-96 is explicitly
  unfinished. `STATUS.md`, the Notion mirror and `site/` were not regenerated:
  they carry build state, refreshed by the same day's org check, and this sweep
  moved decisions. **The Flows page is flagged** — `notes/flows/The Mexal
integration.md` changed, so step 6a-bis applies on the next org-status run.

---

## 2026-08-26 — codex — org-status results now deliver to Aurel by Slack DM

- **Standing instruction implemented:** every completed `org-status-check` run
  now sends its final result to Aurel Mrruku by direct message, independently of
  `report`, `reconcile` or `publish` mode. Aurel can opt out for an individual
  run without disabling the standing preference.
- **Destination verified, not inferred:** the Slack connector returned one exact
  Aurel match in the `Romi` workspace. The stable workspace and user ids are
  recorded in the skill's Slack-delivery reference; ordinary runs do not search
  again or substitute a channel or similarly named account.
- **Delivery contract:** send only after validation and selected write/publish
  work finishes; include the full substantive result, thread numbered
  continuations above 4,500 characters, omit secrets and local paths, and return
  the message link in chat. An unavailable or ambiguous Slack send is reported
  without retrying or invalidating the org check.
- **Generator:** future Salesforce projects receive the same delivery mechanism
  disabled by default; it becomes active only after explicit authorization and
  exact recipient verification. Agent and Claude mirrors remain synchronized.
- **End-to-end proof:** a one-time configuration confirmation was delivered to
  Aurel's DM successfully and Slack returned its message permalink. No org-status
  report was generated merely to test delivery.

## 2026-08-26 — codex — org-status-check rebuilt as a hybrid evidence pipeline

- **Structure:** replaced the 278-line monolith with a compact router and four
  progressive references: evidence model, live-org inventory, reconciliation
  and publishing. Scope (`targeted`/`full`) is now independent from output
  (`report`/`reconcile`/`publish`), so a status question no longer implies a
  large repository or Notion rewrite.
- **Precision:** the report keeps requirement compliance, repository/org drift
  and operability as separate axes. Field existence uses Tooling
  `FieldDefinition`; access requires matching `FieldPermissions` and
  `ObjectPermissions`. Failed inventory calls become `unverifiable`, never an
  empty result. Graphify and Open Codebase Index are exception-navigation aids,
  not deployment evidence; exact search remains the exhaustive fallback.
- **Deterministic layer:** added a nine-assertion starter plan at
  `requirements/org-verification.json` and local commands for repository and
  live-org snapshots, structural comparison, validation and tests. Generated
  evidence stays under gitignored `.org-status-cache/`; output paths are
  constrained there and Salesforce credentials or record data are not stored.
- **Regression protection:** five Node tests cover object-qualified duplicate
  field names, the deployed-but-no-FLS failure mode, matching field/object
  access, failed-inventory uncertainty and invalid requirement references.
  Windows Salesforce CLI invocation was smoke-tested after handling `.cmd`
  execution explicitly.
- **Mirrors and generator:** `.agents` and `.claude` copies are byte-identical.
  The reusable `start-sf-projects` template now generates the same modular,
  report-first architecture and its related workflows no longer cite the old
  hardcoded step 6.
- **Validation:** skill-creator validation, `org-status:test`, repository
  snapshot, mirror validation and Python compilation pass. The stricter
  build-state validator correctly exposes two pre-existing undefined refs,
  `QUO-01` and `QUO-06`; this skill-only update did not rewrite the requirements
  register. No live org snapshot, deployment, retrieve, data write, test run,
  Notion write, commit or push was performed.

## 2026-08-26 — claude — requirement-trace: the `sales` batch, 9 → 19 of 167

- **Batch:** `sales` (`SAL`), 23 requirements. **Five notes mapped, ten
  requirements traced.** Progress table and full evidence:
  [the fabricated-mappings note](notes/The%20requirement%20mappings%20were%20fabricated.md).
  Tickets and sales are now done; **36 requirements remain** across `INT`,
  `BUN`, `ORD`, `DAT`, `MKT`, `NFR`, `CTX`.
- **Every pair was decided by quotation**, requirement text beside a line from
  the note. Nothing scored, nothing carried over from the discarded 2026-08-15
  table — two of which (`OI-68 → SAL-17`, `OI-59 → SAL-10`) this batch
  **rejected** in favour of better-evidenced targets.
- **Wired:** `SAL-07/06/08/09/10` ← [OI-59](notes/items/OI-59%20Quote%20workflow%20configuration.md) ·
  `SAL-18/04` ← [OI-80](notes/items/OI-80%20Lead%20routing%20queues.md) ·
  `SAL-16` ← [OI-68](notes/items/OI-68%20Quote%20acceptance%20landing%20page.md) ·
  `SAL-17` ← [the quote to order flow](notes/flows/The%20quote%20to%20order%20flow.md) ·
  `SAL-21` ← [OI-70](notes/items/OI-70%20Performance%20Plus%20opportunity%20typing.md).
  Both directions written; `vault:check` reciprocates all ten with no warnings.
- **⚠ The thing to carry forward: `requirement:` accepts a LIST.**
  `vault:check` strips brackets and comma-splits, so
  `requirement: [SAL-07, SAL-06, SAL-08, SAL-09, SAL-10]` validates in both
  directions. Without it, one note evidencing five requirements emits four
  permanent "does not cite back" warnings — which is how a real disagreement
  would end up ignored. **The schema block in `AGENTS.md` still documents only
  the singular form and should be corrected** — I did not edit the canonical
  instructions unasked. Convention adopted: **primary id first**.
- **Two contradictions raised, no requirement text touched.** `RC-07` —
  `SAL-16` is still `to_confirm` but was **rejected outright** on 2026-08-06 and
  replaced by the landing page, so it reads to a builder as still open. `RC-08` —
  `SAL-21` documents only one of the two jobs `Opportunity.Tipo_Opportunita__c`
  is asked to do; the attivazione/rinnovo typing that drives contract generation
  ([OI-51](notes/items/OI-51%20Contract%20auto-generation%20keyed%20to%20product%20code.md))
  is in no requirement.
- **Two register gaps found** — [OI-90](notes/items/OI-90%20Whether%20to%20introduce%20a%20Prospect%20state.md)
  (a **Prospect** state alongside Lead and Cliente is covered by nothing, in any
  area) and [OI-71](notes/items/OI-71%20Service%20start%20date%20owned%20by%20the%20Strategist.md)
  (the Strategist-owned service start date, its banner and its email alert are
  covered by nothing; `DM-19` is adjacent and does not cover it).
- **Two deferrals, now with ids to test against:**
  [OI-72](notes/items/OI-72%20Partita%20IVA%20mandatory%20on%20lead%20forms.md) →
  marketing/data-model batch, and ⚠ it **contradicts `MKT-02`** (double opt-in);
  [OI-29](notes/items/OI-29%20Account%20creation%20policy%20for%20free%20tour%20tickets.md) →
  data-model batch, check `DM-01` and `DM-03`. OI-29 is needed before the
  7–19 September tour.
- **13 of the 23 `SAL` requirements still have no note.** Two are worth a human
  rather than another pass: `SAL-13` (cross-check in the orders batch — it is
  the sales-side statement of the tranche mechanism) and `SAL-20`, the batch's
  closest near-miss, **left untraced on purpose** because OI-59's "generic and
  preventivo-inviato" pair does not clearly correspond to the requirement's
  "after first contact / after the appointment" pair.
- **Published:** `STATUS.md` and the Notion status page refreshed (**19 of 167**,
  120 notes, 56 item notes) and the `Requirement` column set on the four Notion
  tracker rows, verified by re-query. `site/` was **not** touched — it publishes
  no trace count and no item status changed. The Flows page was **not**
  regenerated: the flow note changed only in frontmatter provenance and the
  register's `state_machines` block did not move, so it would have been a no-op
  push.
- ⚠ Also corrected on `STATUS.md`: the prose still read "9 of **163**" against a
  table saying 167, and the item-note counts were a batch stale (54/42/8).

## 2026-08-26 — claude — requirements-check: a dry sweep, and four marketing commitments went overdue

- **Watermark used:** 2026-08-25, from
  [that day's trace](notes/traces/Source%20trace%202026-08-25.md), selected by
  `updated:`. **New watermark: 2026-08-26**,
  [Source trace 2026-08-26](notes/traces/Source%20trace%202026-08-26.md).
- **Did:** swept Gmail (two query shapes), Slack (`#tproj-pienissimo`, the
  canvas re-read in full, workspace-wide DMs, and `from:` filters on Elena Spini
  and Andrea Di Cicco), Drive (two query shapes), Fathom and Calendar.
  **Nothing new arrived.** First fully dry sweep in this record — and it is a
  one-day window, so it is a sample of one, not a trend.
- **The one record change came from the calendar, not from an inbox.** Every
  marketing commitment made on 19 August is now overdue with no evidence on any
  channel: DNS records **five days** late, funnel screenshots and graphics
  **six days** late, and the forms were **due today**.
  [OI-14](notes/items/OI-14%20Marketing%20forms%20and%20subdomain.md) is the only
  note this sweep changed. It has been open since 23 June — **nine weeks**, the
  oldest live blocker — and the first ticketed event is **7 September**.
  ⚠ Matteo Distaso and Rebecca Marmo correspond with Fabrizio Mastracci on
  channels this sweep does not reach: **ask him before escalating.**
- **Four confirmations of absence worth keeping.** `Flows & Objects.drawio` has
  **not** moved since 25 Aug 08:23Z, so its self-contradiction stands — LEAD-OPTY
  says the middleware, Ordini still says `Anticipay`. The Slack canvas is
  unchanged with newest entry **20.08**, so the client-facing 25 Aug session is
  still not indexed on it. `#tproj-pienissimo` is silent for a **sixth** week.
  Fathom still holds **0** recordings since 6 Aug.
- **Today's Mexal review had not run yet** when the sweep was taken (~13:15 CEST
  against a 16:00–17:00 slot). Confirmed, client-facing, six attendees, first
  Mexal session since 14 July, and **the Mexal WEBAPI credentials are due at
  it**. The next run should expect a recording and drill it. Tomorrow 10:00 is
  the WooCommerce session, where its credentials are due.
- **Did not do:** no requirement document opened; `MAP.md`, both trackers and
  both recaps untouched, because the live position did not move.
  **`STATUS.md`, the Notion mirror and `site/` were regenerated earlier the same
  day by `org-status-check` and are current** — step 7's refresh was deliberately
  not repeated, since it would have rewritten identical figures.
- **Read-only throughout.** Nothing sent, replied to, shared or marked read; no
  Slack message posted on this run.

## 2026-08-26 — claude — org-status-check: one finding of the 25 Aug check was a false negative

- **Org:** Pienissimo UAT (`a.mrruku@pienissimo.uat`, `00DMA000004nMMr2AM`),
  read-only, against `DevMain` at `dc513c6`. Second check in two days.
- **The thing to carry forward:** ❌ **the 2026-08-25 finding that
  `OrderItem.Tranche__c` was "committed but never deployed" is wrong.** The
  field is in the org, created 24/08 15:18Z. `sf sobject describe` **filters by
  the running user's field-level security**, and that field is granted to no
  profile and no project permission set — invisible even to System
  Administrator. Every field comparison was re-run against Tooling
  `FieldDefinition`; only this one finding changed. Method note written so this
  does not recur:
  [How to read the org schema without a false negative](notes/How%20to%20read%20the%20org%20schema%20without%20a%20false%20negative.md).
  The old risk note was renamed to
  [OrderItem Tranche is invisible to every user](notes/risks/Risk%20-%20OrderItem%20Tranche%20is%20invisible%20to%20every%20user.md);
  its conclusion survives, its diagnosis did not.
- **Two green findings.** 🟢 PR #12 (`dc513c6`) **retrieved the tranche creation
  stack into source control** one day after it was deployed — controller (byte
  identical to the org copy), LWC, quick action, two fields, permission set.
  Only the Tranche layout is still org-only. 🟢 **`Quote.Status` now carries the
  agreed lifecycle** `Bozza → Nuovo Preventivo → In Trattativa → In Attesa
Accettazione → Accettato / Rifiutato` — the first agreed state machine on this
  project to reach the org. [OI-59](notes/items/OI-59%20Quote%20workflow%20configuration.md)
  reversed on that point one day after it was written.
- **New findings.** 🔴 The **integration scaffolding has never been configured**
  — `Integration_Configuration__c` and `Integration_Log__c` hold zero rows, one
  named credential (`DocuSign`), so Mexal / WooCommerce / the VAT middleware
  have no endpoint
  ([note](notes/objects/The%20integration%20scaffolding%20has%20never%20been%20configured.md)).
  🔴 **`Tranche__c.Sequenza__c` has no integrity control** — 1, 4, 3 on one
  quote, null on three records, and ticket release reads it as a total order
  ([risk](notes/risks/Risk%20-%20the%20tranche%20sequence%20has%20no%20integrity%20control.md)).
  🔴 The **Quote value set was swapped without migrating the records** — 3 of 4
  quotes sit on deactivated values; a rehearsal for the same operation on 37
  tickets. 🔴 §17.2's "no Flow" is wider than recorded: also zero
  `WorkflowRule`, `ApprovalProcess`, `EmailTemplate`, `CustomNotificationType`
  and no scheduled Apex — so Marco Montesi's reminder copy and the 24/08
  notifications have nothing to sit on. The Biglietto stack is **three
  components larger** than recorded (`BigliettoPdf` page, `DocuSign` named
  credential, `BundleComponent__c` tab).
- **Unchanged:** 37 tickets, 30 in `In attesa firma`, 0 ever `Disponibile`, 0 QR
  codes; Asset still zero custom fields; Campaign and CampaignMember still zero;
  Order/Lead/Opportunity still stock. Coverage **0%**, **1069** uncovered lines
  (1028 on 25/08 — the whole rise is `QuoteTrancheController`'s snapshot
  catching up, not new code).
- **Wrote:** 3 new notes, 11 updated, the renamed risk; `MAP.md`, `INDEX.md`
  (119 notes), the 26/08 org-verification block in `open-items.md` **and**
  `.it.md`, `§19` in `DEVELOPMENT-RECAP.md` **and** `.it.md` with the precedence
  line extended to name §18 and §19 (it was stale at §17), the register's
  `build_state` block (DIV-04 … DIV-07 added; nothing else in the register
  touched), `STATUS.md` and `site/`.
- **Did not do, deliberately:** no deploy, no retrieve, no data write, no test
  run. **No Apex test class written or offered** — that is a separate task on
  request. No requirement amended: the register's
  `state_machines.quote.states` now disagrees with the org and with OI-59 and is
  **flagged for a human** as DIV-07, not corrected.
- **Still owed by a human, untouched by an org check:** #46
  (`Anno_Solare__c`), #53 (asset generation stated two ways), #59 ("Da
  ricontattare" task vs banner), #69 (is `Incassato` `CHIUSO/ACQUISITO`
  renamed?), #74 (`Rinuncia`).

## 2026-08-25 — claude — Nightly requirements-check: the Anticipay call reversed the integration design

- **Watermark used:** 2026-08-24, from
  [that day's trace](notes/traces/Source%20trace%202026-08-24.md), selected by
  `updated:`. **New watermark: 2026-08-25**,
  [Source trace 2026-08-25](notes/traces/Source%20trace%202026-08-25.md).
- **Did:** swept Gmail, Slack (channel, canvas, workspace, DMs), Drive and
  Fathom. Six findings; the sweep was not dry.
- **The headline:** the **25 August client Anticipay call ran and changed the
  counterparty**. Salesforce will **not** call Anticipay — it calls a middleware
  **built and hosted by Pienissimo Software Srl**. Token in the HTTP header,
  `404`/`500` error codes returned with their messages and stored in Salesforce
  for three months, returned values overwrite Salesforce, payload trimmed to
  fields nobody has chosen yet. New
  [OI-94](notes/items/OI-94%20Anticipay%20is%20called%20through%20the%20Pienissimo%20middleware.md)
  and [OI-95](notes/items/OI-95%20Which%20Anticipay%20fields%20land%20in%20Salesforce.md),
  session at
  [2026-08-25 Integrazione Anticipay](notes/meetings/2026-08-25%20Integrazione%20Anticipay.md).
- **The thing that actually needs a human:** a **Fase 1** integration now has a
  hard build dependency on **the entity at the centre of the phase 2 scope
  dispute**. Fase 1 cannot go live unless Pienissimo Software writes the service,
  hosts it and keeps it running. Who pays and who owns uptime was never raised.
  Recorded in
  [the risk note](notes/risks/Risk%20-%20the%20phase%202%20scope%20dispute%20is%20unresolved.md).
- **Two accuracy problems to know about.** The Gemini minute assigns "create the
  test environment" to Aurel Mrruku — wrong; he corrected it on Slack (_"serve un
  loro ambiente di test dove noi dobbiamo puntare"_) and Elena Spini accepted,
  but **the client-facing calendar invitation still carries the error**. And
  `Flows & Objects.drawio` moved a **fifth** time, during the call, updating only
  the LEAD-OPTY page — so **the master now contradicts itself**, Ordini still
  naming Anticipay.
- **Also closed, all from Slack DMs:** the Postman collection (partial), the
  invoice-to-order-line link (a Mexal invoice carries its item list — the input
  the tranche aggregation needs), and Marco Montesi's reminder-email copy.
- **State:** three notes created, seven updated, `MAP.md`, `INDEX.md`, both
  trackers (rows 50, 58, 59, 73 + new 94, 95) and both recaps (§18) regenerated.
  `npm run vault:check` green.
- **Next:** the **26 August** client Mexal review is the venue for the WEBAPI
  credentials, `Get Fatture`'s missing order-line number, listino 1 vs 2, the
  Mexal test company and #93. Chase Andrea Parmeggiani's API example ahead of
  **1 September**.
- **Watch:** **no requirement document was touched.** OI-94 bears directly on
  signed integration text and a human has to decide whether `REQUISITI.it.md`
  moves. Do not read the **Ordini** page of the design file for the VAT rule —
  it is stale.

---

## 2026-08-25 — codex — Teammate code-intelligence bootstrap added

- **Did:** added the repository-local `setup-code-intelligence` skill under
  `.agents/skills/`, mirrored it to `.claude/skills/`, and added
  `npm run intelligence:setup` plus a read-only
  `npm run intelligence:setup:check`. The installer checks the system
  prerequisites, installs or reuses the exact lockfile-matched Node tree,
  installs the pinned Graphify/MCP Python requirements, pulls the Ollama
  embedding model, builds both indexes, and verifies the Git hooks and live
  Graphify watcher.
- **Windows fix found while testing:** Git Bash can be installed without `sh`
  being on PowerShell's PATH. Added `scripts/run-with-git-sh.mjs`, which finds
  Git's bundled shell, and routed `npm run intelligence:verify` through it.
  Also handled the native Open Codebase Index module being locked by an active
  agent: an already lockfile-matched dependency tree is reused; if dependencies
  really changed, the installer tells the developer to restart and run once
  from a terminal.
- **Why setup is explicit:** a pull delivers the skill, installer, configs and
  hooks, but pulls and branch switches never download packages or models. Once
  the one-time setup succeeds, the existing hooks and MCP wrapper own graph
  freshness.
- **Verified:** the complete `npm run intelligence:setup` succeeds on Windows,
  including both index builds, its final health check, and the refresh verifier
  at 8/8.

---

## 2026-08-25 — claude — Architecture documented

- **Did:** wrote [docs/architecture.md](docs/architecture.md) - the four-kinds
  model (authority / preserved / derived-for-humans / derived-for-machines), the
  Obsidian vault rules and its committed `.obsidian/` config, the two MCP indexes
  and their two different freshness models, the DX build, the publication chain
  and the agent layer, plus ten invariants and three Mermaid diagrams. Added a
  condensed **Architecture** section carrying the top-level schema to
  [README.md](README.md), and routed both from [INDEX.md](INDEX.md). Then closed
  a second gap: the README named no technologies and carried no install steps at
  all - the only ones in the repository were the optional code-intelligence block
  in [docs/code-intelligence.md](docs/code-intelligence.md). Added a **Stack and
  setup** section - the eleven-row stack table, first-run commands, the optional
  code-intelligence and Obsidian steps, and the five check commands.
- **Then closed the two regeneration gaps that audit exposed.** The 25/08 org
  check had updated the notes, both trackers, `STATUS.md` and Notion, but **two
  rendered surfaces were left behind**: `DEVELOPMENT-RECAP` (last touched 24/08 -
  step 5 named only `open-items`) and `site/` (last touched 14/08 - old step 6f
  excluded it, and no other procedure claimed it, so nothing owned it at all).
  - **The recap:** appended **§17 - build-state check against the UAT org**, EN
    and IT, covering the tranche being built, zero Flows in the org, stock state
    machines, the repository being ahead of and behind the org at once, the 37
    parked tickets, 0% coverage and the empty classification fields. The
    precedence line in both headers was itself stale - it stopped at §14 while
    §15 and §16 existed - and now runs to §17 with the rule that §17 wins on what
    _exists_ and earlier sections still govern what was _agreed_.
  - **The procedure:** `org-status-check` step 5 now requires the recap in both
    languages (append the next section, extend the precedence line, build state
    only); step 6f no longer says `site/` is out of scope but **owns** it -
    re-derive from `notes/`, never move a sentence from `STATUS.md` or Notion,
    keep the anonymised vocabulary, run the leak check, and say in the report
    that the page is refreshed but not deployed. Mirrored to `.claude/skills/`.
  - **The page:** `site/` refreshed to 25/08 - 6 wk remaining, tranche
    `not started` -> `partly built`, marketing funnels `blocked on client review`
    -> `model agreed, build not started`, a new `Record status models` row, the
    milestone table put in date order, and the four owner counts replaced with
    counts derived from the item notes (50 open, 7 gating, 11 awaiting client,
    1 commercial). Leak check clean. [docs/publishing.md](docs/publishing.md)
    now records who refreshes it.
- **Also added a viewer for the Salesforce graph.** `graphify-out/graph.json`
  (179 nodes, 184 edges) had no graphic representation at all - it was reachable
  only as text through the MCP tools. `scripts/graph-view.mjs` renders it to
  `graphify-out/graph.html`: dependency-free, offline, force-directed, filterable
  by node kind and relation, searchable, with a per-node panel listing every
  connection and the `file:line` it came from. Inferred edges dashed, governor
  violations red - deliberately, so it reads as leads to check rather than
  findings. Wired as `npm run intelligence:view`.
  - **It strips the Apex `source` text** the graph carries on every node - the
    page keeps the file path instead, so it stays 86 KB and is not a way to
    forward source code.
  - **Output lands in `graphify-out/`, which is gitignored.** The page is
    generated data like the graph itself; nothing regenerates it automatically,
    so re-run the command after a graph rebuild.
- **State:** documentation, rendered views and one new script. **No note,
  requirement, tracker or metadata was touched** - §17 records build state
  already established by the 25/08 org check, it does not re-run it.
  `npm run vault:check` passes.
- **Next:** nothing pending. The recap and `site/` are now regenerated by step 5
  and step 6f of `org-status-check`; revisit only when the routing rules in `AGENTS.md`,
  the MCP wiring or the publication chain actually change.
- **Watch:** the per-folder note counts in that file are stamped 2026-08-25 and
  will drift - `vault:check` prints the live total. The INDEX row for
  [README.md](README.md) had been stale at ~2k and is now ~6k.

---

## 2026-08-25 — claude — Graphify snapshot staleness closed

- **Did:** the Graphify-SFDX graph was a manual snapshot that went silently
  stale after any branch switch, merge or metadata retrieve. Added
  `scripts/refresh-sf-graph.sh` and wired it to `.husky/post-checkout`,
  `post-merge` and `post-rewrite`, plus a `retrieve` / `postretrieve` npm script
  pair for `sf project retrieve start`. Updated
  [docs/code-intelligence.md](docs/code-intelligence.md) and the routing bullet
  in [AGENTS.md](AGENTS.md).
- **Why rebuild rather than detect:** the extract is **deterministic** —
  byte-identical across runs on unchanged input — and takes **0.67 s**. Cheaper
  to rebuild unconditionally than to maintain a staleness check.
- **Verified live:** `graphify.serve` calls `_maybe_reload()` in both
  `call_tool` and `read_resource`, keyed on graph.json's `(mtime_ns, size)`.
  Proved it end-to-end by injecting a probe node — the running MCP server
  reported 180 nodes with **no session restart**, then 179 again after a
  rebuild. **Refreshing the file is enough; no client restart is needed.**
- **The hook degrades silently.** The Python toolchain is a per-machine opt-in,
  so the script no-ops when `graphify` is unimportable and never fails the git
  operation. DevAnita / DevSara / DevRexhina_* branches are unaffected if they
  never install it — but they also get no graph.
- **Both remaining gaps are now closed as well.** Both clients launch Graphify
  through `scripts/graphify_serve_fresh.py` (wired in `.mcp.json` and
  `.codex/config.toml`). It rebuilds at session start and watches `force-app/`
  on a 2 s poll for the life of the session, which covers the two cases no git
  hook can see: metadata edited in place, and `sf project retrieve start` run
  directly. Verified end to end — touched a class, graph rebuilt ~2 s later,
  stdout still 0 bytes.
- **How to check it still works:** `npm run intelligence:verify`
  (`scripts/verify-graph-refresh.sh`, ~20 s). Eight assertions covering the
  hook, its silent degradation without the Python toolchain, the wrapper's
  startup rebuild and MCP handshake, the live watcher, and that stdout stays
  empty. Currently 8/8. Run it after touching anything in the refresh path.
- **The one real trap, worth not re-learning.** A child process of an MCP stdio
  server must not inherit fd 0. `graphify.serve` swaps stdin for an OS pipe
  (`_filter_blank_stdin`), and the rebuild subprocess inherited it and **hung**
  — measured 20 s timeout inherited against 0.25 s with `stdin=DEVNULL`. The
  same class of bug applies to git hooks, which receive rewritten-commit data
  on stdin for `post-rewrite`, so `scripts/refresh-sf-graph.sh` detaches stdin
  too. **Do not remove either redirect.** Both are commented in place.
- **Note, unrelated to the fix:** `sf_violations` reports two HIGH SOQL-in-loop
  findings on `BundleComponentTriggerHandler` and
  `BundleProductAssignmentController`. Both are **false positives** — they are
  SOQL-_for_ loops, the bulkified idiom. This is exactly the heuristic caveat
  AGENTS.md already warns about; the caveat is correctly worded and needs no
  change.

## 2026-08-25 — codex — shared code and Salesforce intelligence layer

- **Did:** added project-scoped MCP configuration for both Codex
  (`.codex/config.toml`) and Claude Code (`.mcp.json`). Both clients launch Open
  Codebase Index for semantic/code navigation and Graphify-SFDX for
  Salesforce-specific graph queries.
- **Pinned tooling:** `open-codebase-index@0.25.1` is a development dependency;
  `requirements-code-intelligence.txt` pins `graphify-sfdx==0.1.1` and the
  compatible `mcp==1.29.1`. MCP 2.x is currently incompatible with Graphify's
  `AnyUrl` import. The local Codex CLI was upgraded from 0.116.0 to 0.149.1 so
  it can read the current project MCP configuration.
- **Indexes:** local Ollama `nomic-embed-text` embeddings produced 686 chunks
  across 156 code/metadata files in `.codebase-index/index/`. Graphify produced
  179 nodes and 184 edges from `force-app/` in `graphify-out/graph.json`.
  Generated outputs are ignored; configuration and refresh commands are
  committed.
- **Important correction:** Graphify was first pointed at the repository root
  and crawled `.sfdx` standard Apex libraries, creating a polluted 8,884-node
  graph. Extraction is now deliberately rooted at `force-app/`.
- **Verified:** both servers completed a real MCP initialize/list-tools/tool-call
  handshake. Open Codebase Index returned index status and a representative
  bundle search; Graphify returned graph statistics, Salesforce impact, and an
  18-step order-of-execution chain. Claude Code sees both project servers and
  will require its normal one-time project approval.
- **Watch:** Graphify's two HIGH `SOQL-in-loop` results appear to be its static
  heuristic interpreting Apex SOQL-for loops. Treat graph confidence and
  violation output as leads and inspect the cited source before making a claim.

---

## 2026-08-25 — claude — org-status-check against Pienissimo UAT

- **Did:** ran the three-way comparison — requirements register vs `force-app/`
  vs the live **Pienissimo UAT** org (`a.mrruku@pienissimo.uat`,
  `00DMA000004nMMr2AM`), read-only. Metadata inventories, sObject describes,
  picklist extraction, record counts and `ApexCodeCoverageAggregate`.
- **Biggest correction:** the record said **`Tranche__c` exists in neither the
  org nor the repository**. It exists in **both**, and the Quote-side creation
  UI (`Quote.Crea_Tranche` + `quoteCreateTranche` LWC + `QuoteTrancheController`)
  went into the org on **2026-08-25**, hours before the check. OI-50 rewritten.
- **Four findings that change the plan:**
  1. 🔴 **Zero Flows in the org** — confirmed three ways (`Flow` and
     `FlowDefinition` metadata lists, Tooling query). Every declarative
     automation designed since June is absent; all automation is three Apex
     triggers.
  2. 🔴 **`OrderItem.Tranche__c` is committed and never deployed** — a new
     divergence direction, repository ahead of org. New risk note.
  3. 🔴 **Coverage is 0%, not 1%** — 24 classes/triggers, 1028 uncovered lines,
     zero covered. `QuoteTrancheController` (144 lines) shipped the same day
     with no test.
  4. 🔴 **30 of 37 tickets sit in `In attesa firma`**, a state struck on
     2026-08-06. None has ever reached `Disponibile`. Standard `Asset` carries
     zero custom fields.
- **State:** updated OI-41, OI-44, OI-46, OI-47, OI-49, OI-50, OI-59, OI-64,
  OI-66, OI-69, OI-74; the Biglietto build, build-ahead-of-record, campaign
  parent/child and quote-to-order notes; the coverage, source-control and
  ticket-lifecycle risks. Added two notes — the `OrderItem.Tranche__c` risk and
  `Unrequested implementation in the org`. Rewrote the register's `build_state`
  block (`checked: 2026-08-25`, with new `divergent:` entries); no requirement
  text touched. Inserted a 2026-08-25 org-verification block into
  `meetings/open-items.md` **and** `.it.md`. Refreshed MAP.md, INDEX.md,
  STATUS.md. Pushed the Notion mirror: Status page, Flows page (diagrams
  unchanged, build-state text rewritten) and **13 tracker rows reconciled on
  `Ref`** — all 13 were stale from earlier sessions, not from this check.
- **Watch out:** `sf project retrieve preview` **cannot be used on this org** —
  partial sandbox, no source tracking, `NonSourceTrackedOrgError`. Divergence
  has to be found component by component. Also: `sf` subcommands other than
  `org list` fail under the Bash tool on this machine (`'C:\Program' is not
recognized`); use the PowerShell tool for them.
- **Next:** the org-only tranche components need retrieving into source control,
  and `OrderItem.Tranche__c` needs deploying or an explicit deferral. Both are
  write actions this check deliberately did not take.

---

## 2026-08-24 — codex — tranche and standard Asset decisions recorded

- **Did:** recorded Aurel Mrruku's direct decision that payment tranches are
  created on the Quote after product selection through a guided choice of Quote
  Line Items and a planned payment due date. The tranche reference/date
  propagate to Order Items; Mexal returns payment per line; Salesforce marks
  the tranche fully paid only when every included line is fully paid.
- **State:** updated OI-50, OI-75, the quote-to-order and Mexal flows, the
  catalogue-block note, the YAML register and both contractual prose mirrors.
  The `BLO-` catalogue block is now explicitly separate and does not create
  `Tranche__c`.
- **Also decided:** the target ticket object is the standard Salesforce Asset.
  The direct instruction did not identify the decision-maker, so it is not
  personally attributed. OI-41 is resolved; `Biglietto__c` remains the current
  UAT implementation and its migration/rebuild is an open, unestimated gap.
  Updated the atomic item, object/flow/risk notes, both trackers and recaps,
  `STATUS.md`, `MAP.md`, the register and both contractual prose mirrors. The
  register/prose version is now 1.4 dated 2026-08-24.
- **Check correction:** mapping OI-41 to `DM-22` exposed that `vault:check`
  accepted only three-letter requirement prefixes and silently omitted all
  `DM-*` ids. The parser now accepts the `DM` prefix without counting
  two-letter reconciliation ids; OI-41 and DM-22 carry the reciprocal trace,
  bringing the measured coverage to 9/159 (the 154 main entries plus five
  requirement ids under `scope:` and `build_state:`).
- **Next:** build remains entirely outstanding: `Tranche__c`, Quote-side action
  and fields, propagation to Order Items, and payment roll-up. The Notion
  **Flows** page was refreshed for the tranche decision at 13:47 CEST. At 16:07
  CEST the Notion Status and Flows pages were refreshed for the Asset decision,
  OI-41 was moved to `Resolved` and mapped to `DM-22`, and all three were fetched
  again to verify them. Asset field/automation mapping and migration are still
  to plan and build.
- **Watch:** the final paid-state API value is deliberately still open under
  OI-69. Do not infer `CHIUSO/ACQUISITO`; creation and roll-up can proceed while
  the final label waits for Elena's answer.

## 2026-08-24 — claude — generator reconciled with what the live projects actually do

Two divergences between `start-sf-projects` and both live projects, closed in
the generator so future projects inherit the corrected shape.

- **The scaffolded mirror note is renamed.** It shipped as
  `notes/notion-mirror.md`, which **breaks this project family's own rule** that
  the filename is the note's H1 title — both Pienissimo and Life365 had renamed
  it by hand. The generator now writes
  `notes/The Notion mirror of the project status.md`, and every scaffolded link
  to it is **percent-encoded**, as the portability rules require.
  ⚠ **The `id:` stays `ref-notion-mirror`** — ids are stable forever and both
  live projects already use it. Renaming the file is not renaming the note.
- **Checked the overwrite guard rather than assuming it.** The installer's
  `seeded` set — files written once and never rewritten — is built from the keys
  of `vault_seed_templates()`, so it follows the rename automatically. Confirmed
  the renamed key sits inside that function. Had the path been hardcoded
  anywhere else, a re-run would have **overwritten a mirror note holding real
  Notion ids**; it is not.
- **The tracker's Status picklist goes from three values to five.** The stub
  offered `Open / In progress / Resolved`; the vault's frontmatter schema allows
  `open | in-progress | resolved | stale | superseded`, so a scaffolded tracker
  could not represent a stale or superseded item at all. Now aligned.
- Both scripts still compile (`py_compile`), and `.agents/` and `.claude/`
  copies verified byte-identical.
- ⚠ **Life365 still holds an unreconciled copy of the generator** — it now
  differs in four files (the two drill templates, the script, the
  org-status-check template). If the generator is meant to live in one place,
  that decision is still nobody's.
- **Not done:** the Flows page is not part of the scaffold. It is a Pienissimo
  invention, and adding it to the generator would push an unproven idea onto
  every future project.

## 2026-08-24 — claude — Flows refresh wired into all five skills

- 🔴 **Third instance of the same defect, caught by Aurel asking when the flows
  update.** Only `org-status-check` step 6a-bis regenerated the Flows page. The
  four skills that actually **edit** `notes/flows/` — `drill-meeting`,
  `drill-me`, `requirements-check`, `requirement-trace` — refreshed `STATUS.md`
  and the status mirror but **never the diagrams**. `drill-meeting` is exactly
  what moved `The ticket lifecycle` on 19 August, so the next such drill would
  have left the diagrams silently stale. All four now carry the pointer; all
  five skill pairs verified byte-identical.
- **The pattern to watch:** every time a new rendered surface is added, the
  skills that write its _source_ have to be told. It has now been missed three
  times in one day — the STATUS.md close-out, the README links, and this.
- ⚠ **The register's own date stamp is stale.**
  `requirements/pienissimo-requirements.yaml` declares `version: 1.1,
date: 2026-08-03`, but the file was last written **2026-08-20** by the nightly
  routine. Do not use that stamp as a freshness signal; use `git log`.
  Not corrected here — bumping a contract-bound register's version is a
  deliberate act, not a side effect of a journal entry.
- **Freshness at this moment:** flow notes 2026-08-19 (ticket lifecycle) and
  2026-08-15 (quote-to-order, Mexal); register content 2026-08-20; Notion Flows
  page regenerated 2026-08-24, so the page is current with every source.
- ⚠ **The nightly cannot push any of this.** The routine runs
  `requirements-check` Mon–Fri 23:30, but a headless cloud run has no
  interactively-authenticated Notion connector, so it will report the mirror
  stale rather than refresh it. **In practice every Notion surface updates only
  when a human-driven session with the connector runs one of the five skills.**

## 2026-08-24 — claude — a Flows page, one schema per flow

- **New Notion page `PIENISSIMO - Flows`**, `3c6a6b77-a25c-81f8-91e7-ffba884cd150`,
  under the PIENISSIMO parent. **Eight Mermaid diagrams**: lead, opportunity,
  quote, quote-to-order, order, tranche, the ticket/asset lifecycle, and the
  Mexal call sequence.
- **Every diagram is sourced, none invented.** They come from the three notes in
  [notes/flows/](notes/flows/) and the `state_machines` block of
  [the register](requirements/pienissimo-requirements.yaml) — which is why the
  page is a mirror like the rest of the space, not a new source.
- **Dotted edges are the convention that matters.** An edge drawn in a source
  diagram but agreed in no minute renders **dotted**, labelled with its item:
  the `Aggiornamento Incasso` reversal
  ([OI-91](notes/items/OI-91%20Aggiornamento%20Incasso%20button.md)) and
  `Rinuncia` ([OI-74](notes/items/OI-74%20Asset%20state%20machine.md)). Rendering
  either solid would quietly promote a drawing into a decision. Step 6a-bis now
  says so.
- **The order diagram draws the conflict rather than resolving it** — two
  vocabularies side by side with an unanswered dotted link between
  `CHIUSO/ACQUISITO` and `Incassato`
  ([OI-69](notes/items/OI-69%20Order%20state%20model.md)). The tranche diagram
  carries the callout about the client's **second, product-side** tranche.
- ⚠ **Three flows are deliberately undrawn** — e-commerce parallel, documents &
  signatures, Performance Plus contracts. `DEVELOPMENT-RECAP` §3 names them as
  core flows but **none has an atomic note**, so drawing them would mean
  inventing detail. The page states this instead of leaving a silent gap. **If
  those flows matter, the fix is to write the notes**, not to draw from the
  recap.
- **Re-fetched after publishing** and confirmed all eight Mermaid blocks
  survived intact with no markup mangling — avoided wrapping inline code in
  bold this time, which is what broke the parent page earlier.
- **Made the entry points explicit, on Aurel's note that they were not.** Every
  diagram now opens with a dark green `START` stadium naming the **trigger**,
  and the **first status the record actually holds** is a thick-bordered green
  box beside it — the two were previously indistinguishable from ordinary
  states. Terminal states are grey, disputed ones red dashed, and statuses are
  numbered where the order is fixed (`1. Ordinato`, `2. Disponibile`). A
  **Legend diagram** at the top defines the vocabulary.
- Two entry points that are easy to get wrong are now stated on the face of
  the diagram: **tranche 1 starts at `CHIUSO/ACQUISITO` and skips `CREATO`
  entirely** while tranches 2..n start at `CREATO`; and the order flow has
  **two competing first states** drawn side by side, because the record has
  not chosen.
- Wired in: the mirror note's id table and a new section, README and `STATUS.md`
  link lines, and **step 6a-bis** of `org-status-check` in both skill mirrors —
  which now carries the four conventions as a table, so a regeneration cannot
  quietly drop them.

## 2026-08-24 — claude — start-sf-projects brought in, and its templates fixed

- **Compared the two projects' skill sets properly.** Neither has strictly more:
  **Life365** had `start-sf-projects` (the generator that scaffolded both),
  **Pienissimo** has `requirement-trace` — correctly, since Life365 has no
  `requirements/` register at all to trace against.
- **Copied `start-sf-projects` into this repo**, `.agents/` and `.claude/`,
  verified identical: `SKILL.md`, `agents/openai.yaml`,
  `scripts/create_sf_project.py`, `scripts/install_project_workflows.py`, and
  four `assets/project-skills/*/SKILL.md.tpl` templates.
- 🔴 **Fixed the defect that prompted this.** The generator's `drill-me` and
  `drill-meeting` templates carried **zero** mention of `STATUS.md` or Notion,
  so every project scaffolded from it got drill skills that move note statuses
  and leave the mirror silently stale. Life365's live copies had been
  hand-patched after generation; the generator never was. Both templates now
  carry the refresh step, matching the wording already in
  `requirements-check.tpl`. All four templates now reference `STATUS.md`.
- **The generator's design was never the problem.** It already scaffolds
  `STATUS.md` as a stub for `org-status-check` to fill, and ships a
  `notes/notion-mirror.md` with an empty id table and a first-run procedure.
  Only the two close-out pointers were missing.
- ⚠ **Naming divergence, left alone:** the generator scaffolds the mirror note
  as `notes/notion-mirror.md`, while **both** live projects renamed it to
  `notes/The Notion mirror of the project status.md` to satisfy the
  filename-is-the-H1-title rule. The generator's stub name breaks that
  convention. Not changed — it would alter what every future project gets, and
  is a naming call, not a bug fix.
- ⚠ **Two copies of the generator now exist**, here and in `life365`, and
  **only this one carries the template fix.** They can drift. If the generator
  should live in one place, that is a decision nobody has taken.
- **Traced the Notion URL through every file that should carry it.** It was
  quoted **nowhere** — `README.md` had no mention of `STATUS.md` or Notion at
  all, and `STATUS.md` named Notion only in passing, without the links. Step 6c
  meanwhile _asserted_ the URL was "quoted in `STATUS.md` and the mirror note",
  which was false when written. Now true: **README.md, STATUS.md and the mirror
  note** all carry both URLs, verified byte-identical against the live page ids.
- **The nightly routine was undocumented in the README too.** Pienissimo has run
  cloud routine `trig_01VCdUXmqy8PngWPJHA2dSYC` since 2026-08-14, and only
  `docs/task-status.md` described it — the README had no `Scheduled checks`
  section at all, where the sister project devotes one to it. Added, matching
  Life365's shape with this project's own facts: Mon–Fri 23:30 Europe/Budapest,
  Opus 5, commits **directly to DevMain** and only when `vault:check` passes,
  reporting to the "pienissimo devs" group DM. It also now carries the
  🔴 **DST fix due 25 October** (`30 21` → `30 22`), which otherwise fires
  22:30 local inside the go-live window.
- ⚠ **Not independently verified.** The routine's configuration above is
  transcribed from `docs/task-status.md`, not read back from the cloud — no
  connected tool here lists cloud routines. The evidence it still runs is the
  commit trail: `nightly requirements-check` on 18, 19 and 20 August. Friday
  21 August produced no commit, which is the documented behaviour for a
  no-change run, not proof of a failure.
- ⚠ **Three files quote those URLs**, so a page replaced rather than updated in
  place breaks all three at once. That is exactly why step 6c forbids creating a
  replacement page, and the mirror note now says so beside the id table.
- `AGENTS.md` now says six procedures, with a warning that `start-sf-projects`
  is a generator: **editing a skill here does not change what the next project
  gets** — that has to be done in the template. `CLAUDE.md` skill list updated.

## 2026-08-24 — claude — nightly requirements-check, four meetings out of the dark at once

- **Did:** ran `requirements-check` against watermark **2026-08-20**. Gmail,
  Slack, Drive and Fathom all swept. **Six findings — the largest single sweep in
  the project's records.**
- **The headline: the 19 and 20 August sessions were minuted all along.** Three
  consecutive sweeps reported them as leaving no minute of any kind. Both now
  have a canvas entry, a recording and a Gemini notes-plus-transcript doc, added
  to the canvas between the 21 Aug re-read and 24 Aug. And Elena Spini had
  **minuted the 20 Aug session to the client the same evening** (20/08 18:08
  CEST) — she forwarded it to Aurel on 24/08 16:38. **The gap was distribution,
  not existence.** That minute is now the strongest evidence in the record:
  human-written, sent to the client, uncontradicted for four days.
- **Two further ROMI-internal sessions ran on 24 Aug** — Interna per update
  flusso Lead/Opty (Elena + Aurel, 15 decisions) and Follow-up Interno (Elena,
  Aurel, Andrea Di Cicco, Fabrizio Mastracci, 5 decisions). Both fully minuted.
- 🔴 **The most consequential finding is a design conflict, not a decision.**
  Fabrizio Paganelli, minuted to the client 20/08: **Mexal article codes are
  transversal across years and the edition is determined by the ORDER DATE, not
  the product.** `Product2.Anno_Solare__c` and its dependency matrix assume the
  opposite. §13's finding that the matrix was ROMI guesswork now has its answer —
  there is no client source because there is no client concept.
  [OI-46](notes/items/OI-46%20Bundle%20classification%20picklists.md) is now
  "should this field exist", and it needs **Aurel's ruling**.
- 🆕 **What carries the edition instead is a three-level campaign model** —
  Campagna Padre → Campagna Figlio → Campaign Member, agreed with the client
  20/08 and configured internally 24/08: two Record Types, a **hand-populated
  lookup on Product** for the parent campaign code, one active child per parent,
  membership at enrolment only. ~10 campaigns a year, created manually.
  **Entirely unbuilt.** New note:
  [the campaign parent and child model](notes/objects/The%20campaign%20parent%20and%20child%20model.md).
  It rewrites the scope of OI-77 and OI-84.
- 🔴 **Two contradictions block building.** (1)
  [OI-59](notes/items/OI-59%20Quote%20workflow%20configuration.md): the 20/08
  minute told the **client** that "Da ricontattare" generates **no automatic
  task** (banner instead); the 24/08 internal session specifies a validation
  rule, a trigger and reminder notifications on that same state. (2)
  [OI-53](notes/items/OI-53%20Asset%20generation%20rule.md): the 19/08 minute
  states the asset-creation rule **two incompatible ways in one document** — the
  Dettagli say "at order", the auto-generated Decisioni line says "order **or**
  quote". Prefer the Dettagli; get both ruled on.
- ✅ **Settled:** [OI-76](notes/items/OI-76%20Ticket%20type%20picklist%20on%20the%20product.md)
  — ticket type is a **manually maintained Salesforce field owned by
  amministrazione**, because Mexal carries at most three classifications; this
  **reverses** the standing instruction to ask for a tier _column_ on 26/08.
  [OI-50](notes/items/OI-50%20Tranche%20object.md) — tranche created by hand on
  the Quote, before the order, editable only in `Bozza`.
  [OI-75](notes/items/OI-75%20Ticket%20availability%20rule.md) — availability
  follows the tranche **and every tranche before it**.
  [OI-73](notes/items/OI-73%20VAT%20validation%20moves%20into%20Salesforce.md) —
  the provider is **Anticipay**, called on the first order for an Account.
  [OI-82](notes/items/OI-82%20Asset%20flow%20needs%20a%20dedicated%20review.md)
  **resolved** — the review it asked for is the 20/08 session.
- **New artifact:** `Integrazioni pienissimo.xlsx` (Andrea Di Cicco, 24/08) — the
  first field-level Mexal↔Salesforce mapping;
  [note](notes/The%20Mexal%20integration%20mapping%20workbook.md). Sandbox pattern
  fixed: **code 501 for new customers, series 10 for new orders**. ⚠ **It holds
  real customer records** — existence recorded, **no values copied**. Third
  artifact with this problem.
- **The design file moved a fourth time** (24/08 16:34:34Z), re-decoded in full.
  **For the first time the edit is minuted**: it carries the campaign lookup
  rule, two `RULES + FLOW` blocks with the **actual picklist values** for both
  "Motivazione da Ricontattare" fields, a third loss-reason list, and
  `Anticipay`. The last two **cannot be dated** — present now, absent from the
  20/08 prose write-up, and prose is not a byte-level record.
- **Written:** 4 meeting notes, 3 new supporting notes (campaign model,
  integration workbook, Fabrizio Mastracci person note — ROMI marketing, **not**
  Fabrizio Paganelli), 19 item notes rewritten + OI-82 resolved, the design
  diagram note, `MAP.md`, `INDEX.md`, `meetings/open-items.md` + `.it.md` (19
  rows, #82 moved to Resolved, new header note and status block),
  `meetings/DEVELOPMENT-RECAP.md` + `.it.md` (new §16), and
  [the trace](notes/traces/Source%20trace%202026-08-24.md).
- **Not done, deliberately:** **no requirement was changed.** The YAML register,
  `REQUIREMENTS.md` and `REQUISITI.it.md` are untouched. OI-46 and OI-76 bear
  directly on signed text, but rewriting a contractual document off a nightly
  sweep is a human's call. Nothing in `force-app/` was touched. `STATUS.md` and
  the Notion mirror were **not** regenerated — see Watch.
- **Watch:** ⚠ `STATUS.md` and its Notion mirror are now **stale** — this sweep
  moved the live position substantially and step 6 of `org-status-check` was not
  run. That is the first thing the next session should do. ⚠ Matteo Distaso's
  DNS deadline (21/08) passed unconfirmed and the forms deadline is 26/08;
  Rebecca Marmo's funnel screenshots never arrived. ⚠ Fathom has held **0
  recordings since 06 August** while five sessions were recorded — **a Fathom
  miss no longer proves a meeting did not happen**; check Drive and the canvas.
- **Next:** take OI-46, OI-53 and OI-59 to a human — they are three
  one-sentence rulings and they block Order, Tranche, Asset and the picklists.
  The 26/08 client Mexal review is the forum for OI-46 and OI-92; ask OI-76 for
  the **value list**, not a column.

## 2026-08-24 — claude — STATUS.md created and mirrored to Notion

Replicated the Life365 status apparatus for this project, at Aurel's request.
Pienissimo had **none** of it: no `STATUS.md`, and `org-status-check` stopped at
step 5 with no publish step.

- **New [STATUS.md](STATUS.md)** — the ROMI-internal, human-facing status page,
  generated from `notes/`. ⚠ **Its basis line says plainly that this was not a
  live org check.** The newest org verification is still **2026-08-03** and is
  stale in both directions; the "what is built" table is read from `force-app/`
  on `DevMain` and labelled as such. Do not let a later regeneration quietly
  upgrade that claim.
- **New [the mirror note](notes/The%20Notion%20mirror%20of%20the%20project%20status.md)**
  — the four Notion ids, the workspace, and the sharing rules.
- **Notion, in `Aurel mrruku's Space`**: parent page **PIENISSIMO**, page
  **ROMI - PIENISSIMO Project Status**, and database **PIENISSIMO - Open Items**
  with **54 rows**, one per note in `notes/items/`, keyed on `Ref`.
- **`org-status-check` gained step 6** (6a–6f), in both `.agents/` and
  `.claude/` mirrors, which are byte-identical. It updates the page **in place**
  — creating a replacement would strand everyone invited to the old one.
- **Precedence is now written down** in `AGENTS.md`: `notes/` → `meetings/`
  views → `STATUS.md` + mirror → `site/`. Notion is a **publish target, never a
  source**. `docs/publishing.md` now governs the internal surface too.
- ⚠ **The mirror shows 54 of roughly 86 tracker rows**, because only 54 have
  atomic notes. That is stated on the status page, the parent page and in the
  note, so it cannot be mistaken for a complete tracker. **Closing the gap means
  writing the missing notes, not adding Notion rows** — a row with no note
  breaks the `Ref` join step 6d depends on.
- **Price rule extended to the new surface.** `Prodotti e Bundle.xlsx` put real
  catalogue prices in the repository for the first time this morning; neither
  `STATUS.md` nor the mirror carries a single value, and both say so.
- **Second pass, same day — two parity gaps closed.** The first build had the
  database but not everything Life365's has: **the `Note` URL column** and **the
  three views**. Both now exist. `Note` links each row to its atomic note on
  GitHub (`DevMain`, percent-encoded); views are **Board** by status,
  **Critical path** filtered to the checkbox, and **By owner** — all sorted by
  `Ref`, matching Life365's config. ⚠ The `Note` links **404 until the branch is
  pushed**, which reads as a missing note rather than an unpushed commit; step
  6d now says so.
- **Also closed: only `org-status-check` knew the page existed.** In Life365
  four skills carry a close-out pointer to step 6; Pienissimo's had none, so a
  `drill-meeting` or `drill-me` run would have moved a dozen note statuses and
  left Notion silently stale. `drill-meeting`, `drill-me`,
  `requirements-check` and `requirement-trace` now all end by refreshing
  `STATUS.md` and the mirror.
- **Watch:** the workspace is **personal** (`a.mrruku@romicompany.com`), not a
  ROMI company workspace, and it also holds the **LIFE365** mirror whose pages
  are named alike. Step 6 forbids locating anything by title for exactly that
  reason. If ROMI ever adopts a company workspace, the pages move by hand.

## 2026-08-24 — claude — the Prodotti e Bundle workbook drilled, 17 days late

- **Aurel downloaded `Prodotti e Bundle.xlsx` and it was read.** This is the
  file [MAP.md](MAP.md) had been flagging as delivered-but-unopened since
  18 August. Fabrizio Paganelli sent it **2026-08-07 at 12:17 CEST**; the file's
  own metadata shows it was saved **10:16 UTC — one minute before he sent it**,
  so it was built for that request and is the `anagrafica prodotti` the 22/07
  session asked him for. **A copy now sits in the repository root** beside
  `anar_PIE_ricla.xlsx`, so no future agent has to ask a human to fetch it.
  ⚠ It carries **real list prices** — private repo only.
- **Three sheets, four answers.** `Lista Eventi` (11 events, 4 types),
  `Lista Prodotti` (29 articles, 9 events, prices on every row),
  `Esempio di Bundle` (one worked bundle, drawn twice). Decode:
  [the workbook note](notes/The%20Prodotti%20e%20Bundle%20workbook.md).
- ✅ **[OI-87](notes/items/OI-87%20Real%20catalogue%20prices%20still%20outstanding.md)
  resolved** — the real prices are here. It does **not** clear
  [OI-42](notes/items/OI-42%20List%20prices%20in%20UAT%20are%20placeholders.md):
  UAT still holds the placeholders, the input arrived and the load did not. And
  **no bundle price exists anywhere**, so
  [the bundle demo](notes/items/OI-13%20Bundle%20effort%20estimate%20and%20client%20demo.md)
  is still short.
- 🔴 **The headline is a build defect, not a paperwork gap.** The record has
  said since 23/07 that "Happy Team sells nothing". The transcript actually says
  _"durante l'Happy Team non vendiamo niente"_ — **we don't sell _during_ Happy
  Team**. `CS-00154 HAPPY TEAM` is priced, has a complimentary twin, and is in
  the Academy bundle **at quantity 2**. `Product2.Evento__c` is a **restricted**
  picklist with **no `Happy Team` value**, so such an article cannot be
  classified and its asset has no event. Also wrong: `Camerieri` (truncated),
  `Odb Live`, an invented `ND`. See
  [OI-46](notes/items/OI-46%20Bundle%20classification%20picklists.md).
- ⚠ **The `Anno_Solare__c` → `Evento__c` dependency matrix is ROMI guesswork.**
  It is built with a specific mapping and **the workbook has no year column at
  all**. That is the controlling half of the mechanism OI-46 specifies.
- **[OI-76](notes/items/OI-76%20Ticket%20type%20picklist%20on%20the%20product.md)
  — `Silver` and `Dinamond` both die.** The registry's tiers are `EXECUTIVE`,
  `GOLD`, `DIAMOND`. `Dinamond` was a typo for `Diamond`; `Silver` exists
  nowhere, and the minuted 06/08 example named two tiers for an event that has
  neither. **Still open** — `Lista Prodotti` has four columns and neither a
  ticket-type nor an event-flag column, so tier is still parsed out of a name.
- 🆕 **[OI-93](notes/items/OI-93%20Bundle%20components%20should%20be%20priced%20articles.md)
  — a client change request nobody knew existed.** The bundle is drawn as
  `COME SONO ADESSO` (components are `OMAGGIO`) and `COME LO VORREMMO`
  (components are priced). ⚠ **It may already be built and I did not verify
  that** — `BundleComponent__c.Spread_Price__c` and the `Spread_*` fields exist
  for this purpose, but they change the _price on the junction_, not _which code
  is in the bundle_. Different data, same revenue answer.
- **New structural notes:**
  [the article code namespace](notes/objects/The%20article%20code%20namespace.md),
  [a bundle is two levels deep](notes/objects/A%20bundle%20is%20two%20levels%20deep.md),
  and [the normalisation risk](notes/risks/Risk%20-%20normalising%20an%20article%20code%20merges%20two%20products.md).
  The last is the one to carry forward: **`_ARCOD` is an opaque string.**
  `CS-00061` and `CS-0061` are different events at different prices, one leading
  zero apart, and `Product2.Code__c` is a unique case-insensitive external id —
  a normalising import overwrites a product or throws an opaque duplicate error
  during the ~1 September load.
- **[OI-50](notes/items/OI-50%20Tranche%20object.md) gained a problem.** The
  client has a **product-side** tranche — the `BLO-` blocco, in the catalogue,
  before any order — while OI-50 derives one from order-line due dates after the
  sale. Two things, one name. It decides whether `Tranche__c` is created at
  import or at order time. `BundleComponent__c` is also flat and cannot express
  the middle level at all.
- **Views regenerated:** `meetings/open-items.md` + `.it.md` (rows 46/48/50/76
  rewritten, #87 moved to Resolved, #93 added, fourth-pass block appended),
  `meetings/DEVELOPMENT-RECAP.md` + `.it.md` (new §13, §9 blockers updated),
  `MAP.md`, `INDEX.md`.
- **Next / owed:** the 22/07 action paired this file with a **review meeting on
  the anagrafica prodotti** that never happened. OI-46, OI-48, OI-76 and OI-93
  all want the **26/08 client Mexal review**, where Fabrizio is an invitee.
- **Not done, deliberately:** nothing in `force-app/` was changed and
  `requirements/pienissimo-requirements.yaml` was not touched — the event
  picklist fix and OI-93 both need a decision, and a client workbook is evidence,
  not a signed requirement.

## 2026-08-24 — codex — restored the full colored Obsidian graph

- **Did:** verified that Prettier and the vault's 15 native Obsidian graph color
  groups were already installed/configured. Registered Pienissimo as an
  Obsidian vault, cleared the stale `aurel` global graph search from
  `.obsidian/graph.json`, and expanded the color-group panel.
- **Why:** Obsidian was opening the separate Life365 vault, while Pienissimo was
  not registered; its saved graph also carried an old filter. Graph coloring is
  native Obsidian configuration and does not depend on Prettier or a community
  plugin.
- **State:** Pienissimo now opens directly into Graph view with the full color
  configuration; `vault:check` passes.
- **Follow-up:** increased this journal's retention from 10 to 20 entries and
  restored all four archived entries; there are currently 14 in total.

---

## 2026-08-20 — claude — nightly requirements-check, both design diagrams moved on the same afternoon

- **Did:** ran `requirements-check` against watermark **2026-08-19**. Gmail,
  Slack, Drive and Fathom all swept; **three findings**. Cleared the 🔴 action
  carried from 19 August by **re-decoding the master `Flows & Objects.drawio`**
  at its 2026-08-20T15:36:24Z version — and found that the **client's own
  `Workflow Pienissimo 23-7-26.drawio` had moved 68 minutes earlier**, at 14:28
  UTC. Both are register source diagrams (`DGM-2`, `DGM-1`). **Neither edit is
  minuted.** Both decoded in full from base64.
- **State:** new notes
  [the client Lead-Opty diagram](notes/The%20client%20Lead-Opty%20diagram%20moved%20on%2020%20August.md)
  and [OI-92](notes/items/OI-92%20Mexal%20Scadenziario%20as%20the%20trigger%20to%20reverse%20an%20asset.md);
  [the newest design diagram](notes/The%20newest%20design%20diagram.md) rewritten
  for the new version; OI-69, OI-74, OI-76, OI-85, OI-91 updated. Register:
  **provenance dates for both diagrams corrected**, plus non-normative notes on
  `order.reconciliation` and `asset_status`. MAP, INDEX, both trackers (row 92
  added, rows 69/74/76/85/91 flagged), both recaps (§11.3 and the order-state
  gap), README, and **RC-06/07/08 added to §17 of `REQUIREMENTS.md` and
  `REQUISITI.it.md`**. Trace at
  [Source trace 2026-08-20](notes/traces/Source%20trace%202026-08-20.md). The
  oldest journal entry moved to `notes/sessions/2026-Q3.md`.
- **🔴 Next — nothing in the register was re-extracted, and that was deliberate.**
  Three divergences between the register and its own source files are now open
  and need a human, not another sweep: is `Rinuncia` a seventh asset state
  (OI-74); is `Incassato` `CHIUSO/ACQUISITO` renamed (OI-69); and is the ticket
  tier `Silver` or `Dinamond` (OI-76). Each is one sentence from Elena Spini or
  Sabatino Rinaldi.
- **Watch:** ⚠ **The master now draws the 06 Aug order states _alongside_ the old
  ones without striking them** — `CHIUSO/ACQUISITO` and `CREATO` are still on the
  Ordini page. OI-69 can no longer be waved off as "the drawing predates the
  decision"; the source itself is now ambiguous. Only three states, **no
  `Perso`** (OI-85). ⚠ **`DGM-1` is reached through a Drive shortcut**, so a
  `parentId` listing of the project folder returns the shortcut, not the file's
  real `modifiedTime` — this run only caught the client-side edit because the
  sweep was by `modifiedTime` across all files. **Resolve shortcuts.** ⚠ There is
  **no decode of `DGM-1` between 4 and 20 August**, so its divergences from the
  register cannot be dated and are recorded as "present, not registered" — do not
  let a later run report them as "changed today". ⚠ Both the **19 Aug marketing**
  and **20 Aug asset** sessions left **no recording, no canvas entry, no
  message**; Fathom holds nothing after 06 Aug. Whether they ran is unrecorded.
  ⚠ `Prodotti e Bundle.xlsx` is **still unread** — and may also hold the ticket
  tier list OI-76 now needs.
- **Note:** a client-facing meeting is on the calendar — _[ROMI-PIENISSIMO] -
  Review Temi Integrazione Mexal_, **Wed 26 Aug 16:00–17:00 CEST**, Elena Spini
  with Aurel, Andrea Di Cicco, amministrazione@pienissimo.com and Fabrizio
  Paganelli. First Mexal session since 14 July, and the forum for OI-92.

---

## 2026-08-19 — claude — nightly requirements-check, the ticket design moved and nobody said so

- **Did:** ran `requirements-check` against watermark **2026-08-18**. Gmail,
  Slack, Drive and Fathom all swept; **two findings**, one substantial. Elena
  Spini created a **new standalone `Flusso Biglietti.drawio`** in
  `[Pienissimo] Fase Progettuale` on **19 Aug 15:00 UTC**, and modified the
  master `Flows & Objects.drawio` **92 minutes later**. The new file was
  downloaded and base64-decoded in full.
- **State:** new notes
  [the 19 August ticket flow diagram](notes/The%20ticket%20flow%20diagram%20of%2019%20August.md)
  and [OI-91](notes/items/OI-91%20Aggiornamento%20Incasso%20button.md); OI-74,
  OI-78, OI-81, the ticket lifecycle and the master-diagram note updated; MAP,
  INDEX, both trackers (row 91 added, rows 74/78/81 flagged) and both recaps
  §11.3 carry the change; trace at
  [Source trace 2026-08-19](notes/traces/Source%20trace%202026-08-19.md). The
  oldest journal entry moved to `notes/sessions/2026-Q3.md`.
- **🔴 Next — re-decode `Flows & Objects.drawio` at its 19 Aug 16:33 UTC
  version.** It is the master the requirement register is checked against and it
  was **not** re-decoded this run. It is reachable — Drive simply does not
  full-text index mxfiles; download it and base64-decode. Until then it is
  unknown whether the master also shows `Rinuncia`.
- **Watch:** ⚠ **The 14/08 instinct was probably right and 15/08 overruled it.**
  That entry flagged `rinuncia al servizio` as a possible sixth state; OI-74 then
  settled it as loose prose for `Annullato`. The 19/08 drawing puts
  **`Rinuncia` and `Annullato` in the same row as separate boxes**, at different
  moments — decline at the participant-list request vs. name change or credit
  note. **Do not reconfigure the picklist either way**; Elena or Sabatino rules.
  ⚠ **The requirement register was deliberately left alone** — nothing in the
  drawing is minuted, so no agreed requirement has moved. ⚠ OI-91's
  `Aggiornamento Incasso` button is the **first backward transition** in the
  asset state machine and qualifies OI-75's release rule; it also needs the
  tranche object, which does not exist. ⚠ If the 19/08 marketing session ran, it
  is **unminuted** — no recording, no canvas entry, no message.
- **Note:** a new internal meeting is on the calendar — _[PIENISSIMO] - Interna
  per update flusso Lead/Opty_, **Mon 24 Aug 16:00–17:00 CEST**, Elena + Aurel.

---

## 2026-08-18 — claude — nightly requirements-check, the 07/08 attachment surfaced

- **Did:** ran `requirements-check` against watermark **2026-08-14**. Gmail,
  Slack, Drive and Fathom all swept; **one finding**. Elena Spini forwarded the
  thread _"Lista Eventi, Codici prodotto, esempio Bundle"_ on **18 Aug 09:41
  CEST**, answering Aurel's 14 Aug request. Fabrizio Paganelli's 07 Aug 12:17
  message carries **no body text and exactly one attachment,
  `Prodotti e Bundle.xlsx`** — which is why no `from:` search ever found it and
  why only an empty quoted stub survived.
- **State:** new note
  [the workbook](notes/The%20Prodotti%20e%20Bundle%20workbook.md); OI-46, OI-48
  and OI-87 updated; MAP, INDEX, both trackers and both recaps carry the change;
  trace at [Source trace 2026-08-18](notes/traces/Source%20trace%202026-08-18.md).
  The oldest journal entry moved to `notes/sessions/2026-Q3.md`.
- **🔴 Next — this is the whole point of the finding: the file is still
  unread.** No connected tool can read a Gmail attachment; the integration
  exposes metadata only and has no download call, and the file is in neither
  Drive nor Slack. **Aurel must download it**, exactly as
  `Integrazioni pienissimo.xlsx` was handled on 14 Aug. Until then **nothing
  closes**: whether it holds the 7-event list (OI-46), the "(B)" bundle-only
  codes (OI-48) or any price (OI-87) is unverified.
- **Watch:** ⚠ it may well be the _anagrafica prodotti_ promised at the 22/07
  session, which also carried an action on Aurel to attend a review meeting
  _after receiving the Excel_ — if so, that meeting is owed. ⚠ Treat the file as
  **price-bearing** until proven otherwise; record what it answers, never the
  values. ⚠ Two `[ROMI-LIFE365]` marketing docs were shared on 18 Aug dated
  23/07 and **30/07** — a different client, _not_ the Pienissimo 30/07 marketing
  follow-up, which is still unminuted. Do not conflate them.

---

## 2026-08-15 — claude — transcripts linked to their recaps

- **Did:** turned the transcript path in the `Sources:` / `Fonti:` line of all
  **18** files in `meetings/results/` into a relative Markdown link
  (`[meetings/<name>-transcript.it.md](../<name>-transcript.it.md)`). The
  rendered text is unchanged — the path was already written there as plain text
  in 16 files and inside backticks in the 2026-08-06 pair; only the link markup
  is new, so the preserved record still reads exactly as before. The transcripts
  themselves were **not** touched. Added the rule to step 4 of
  `drill-meeting/SKILL.md` in both `.agents/` and `.claude/` so new meetings get
  the link by default.
- **Why:** Aurel noticed the Obsidian graph was full of floating nodes. The
  cause: the vault root is the repo root, and the transcript↔recap relationship
  was recorded as text, not as a link. Isolated files went **23 → 2**; the two
  left are the `meetings/proposals/`. `vault:check` passes (87 notes).
- **State — the graph is still 10 components, not 1.** The nine meeting
  clusters (transcript + EN recap + IT recap) are now internally connected but
  **eight of them still hang off the main graph**, because nothing links their
  recap. Only 2026-08-06 is attached, via a single link in
  [INDEX.md](INDEX.md). The reason is systemic: **70 notes cite their meeting
  through the frontmatter field `source: meetings/results/…`, which is a bare
  YAML string and produces no graph edge.** The same applies to `depends_on:`
  and `blocks:` — the dependency structure is invisible in the graph. Wikilinks
  would fix it but are banned for portability, so the fix has to be body-level
  Markdown links.
- **Next:** either list all nine recaps in `INDEX.md` (one edit, attaches every
  cluster) or add a body-level `**Source:**` link to the ~70 notes that carry
  the frontmatter field (heavier, but makes the citation trail real). Neither
  is done. `meetings/proposals/` (2 files) is linked from nowhere at all.

---

## 2026-08-15 — claude — requirement trace, tickets batch

- **Did:** re-derived the `tickets` area. **10 notes mapped to 8 `BIG`
  requirements**, written in both directions (`requirement:` on the note,
  `tracked_by:` on the requirement) and verified by `vault:check`, which now
  reports `8/137 reachable` with **zero** disagreements. Mappings:
  `BIG-01←flow-ticket-lifecycle` · `BIG-02←OI-53,OI-77` · `BIG-03←obj-biglietto`
  · `BIG-04←OI-76` · `BIG-06←OI-81` · `BIG-09←OI-57` · `BIG-17←OI-74` ·
  `BIG-18←OI-78,OI-86`.
- **🔴 Found `RC-06`: four requirements still encode signature in the ticket
  flow** — `BIG-01`, `BIG-12`, `BIG-19`, `BIG-21` — after 2026-08-06 struck it
  outright ("Participants sign on paper at check-in; DocuSign applies only to
  quotes and contracts"). `BIG-01` is the four-stage lifecycle naming the phases
  of the whole flow, so the stale wording is load-bearing: anyone building from
  the signed document builds a cancelled signature step. Recorded as a
  reconciliation entry on Aurel's instruction; **no requirement text changed**,
  because that edits `REQUISITI.it.md`. **The correction is still owed.**
- **Two register gaps, both deliberate non-mappings.**
  [OI-75](notes/items/OI-75%20Ticket%20availability%20rule.md) — the rule
  releasing a ticket when the tranche invoice is paid in full, which the entire
  flow keys on — **has no requirement id at all**. And
  [OI-84](notes/items/OI-84%20Campaign%20Member%20handling%20for%20manual%20check-in.md),
  manual check-in issuing no QR, is covered by nothing; what breaks is `DAT-03`.
  Full Tier C list in
  [the fabricated-mappings note](notes/The%20requirement%20mappings%20were%20fabricated.md).
- **Method, and why:** batch by the register's own `area:` field — ~20
  requirements per batch instead of 132. Text-similarity scoring was built and
  **rejected**: it produced 28 confident matches, most wrong, because a
  four-word requirement whose words all appear in a long note scores 1.00. That
  is almost certainly how the original 23 were fabricated. The rule is now **a
  mapping needs a quotable sentence**. Written up as a fifth skill,
  `requirement-trace`, in `.agents/` and `.claude/`, registered in `AGENTS.md`
  and `CLAUDE.md`.
- **Next:** five batches left — `SAL` 23, `INT` 22, `BUN` 20, `ORD` 15, and
  data/marketing/nfr/context 28. Run `/requirement-trace` per area. Also note
  **16 of 24 `BIG` requirements have no note**; worth a pre-sign-off pass to
  check none is unbuilt and untracked.

---

## 2026-08-15 — claude — 🔴 the note-to-requirement mappings are fabricated

- **Finding, and it is serious.** Trying to make requirements traceable back to
  the meetings that produced them, the existing `requirement:` frontmatter
  fields turned out to be **generated by arithmetic, not by matching content**.
  In the 2026-08-06 cluster the id is literally `BIG-(OI number minus 69)`:
  - `OI-74` _Asset state machine_ → cites **BIG-05** _"Participants are not
    account contacts"_. The note is entirely the six-value Asset status
    picklist, i.e. **BIG-17**.
  - `OI-75` _Ticket availability rule_ → cites **BIG-06** _"Reminder funnel
    cadence"_. Unrelated; the note is tranche-paid-in-full release.
  - `OI-78` _Participant data collection_ → cites **BIG-09** _"Zero-euro orders
    stay in the CRM"_. Unrelated; the note is the participant landing page,
    i.e. **BIG-18/BIG-19**.
  - `OI-50` _Tranche object_ → cites **ORD-06** _"Order types"_. Its body is
    verbatim **ORD-01** _"Tranches auto-created from order-line due dates"_.
  - `OI-43` _Spread variance does not block saving_ → cites **BUN-04**. Its
    body is verbatim **BUN-17** _"A non-zero spread variance must block
    saving"_.
  - `OI-47` cites **PRD-04**, and there is no PRD prefix in the register at
    all. Probably **BUN-12/BUN-13**, the two product flags.
    **Five of five spot-checks were wrong.** Treat all 23 `requirement:` fields as
    unverified until re-derived from the note bodies.
- **Did NOT write them into the register.** A `tracked_by:` reverse index was
  built and then **reverted** — mirroring fabricated mappings into the
  contract-bound YAML would have laundered them into the document Pienissimo
  signs. `requirements/pienissimo-requirements.yaml` is untouched at HEAD.
- **Did:** taught `scripts/vault-check.mjs` to trace notes against the register
  in both directions — unknown requirement ids are reported per-note, and
  un-backfilled ones as a single count. **Warnings, never errors**, so the
  nightly routine (which commits only on exit 0) stays green. It currently
  reports `0/137 reachable`, the PRD-04 break, and 22 one-way citations. Added
  the both-directions rule to step 4 of `drill-meeting` and step 4.3 of
  `drill-me`, in both `.agents/` and `.claude/`.
- **Aurel chose the safe path, and it is done:** all **23** `requirement:`
  fields were **stripped** from the notes rather than left wrong, and every
  discarded claim is preserved in
  [the fabricated-mappings note](notes/The%20requirement%20mappings%20were%20fabricated.md)
  with a first-impression assessment per row, so re-derivation starts warm
  instead of from nothing. `updated:` bumped on all 23. Nothing else in those
  files changed — the diffs are two lines each.
- **The register was never written to.** It is untouched at HEAD. `tracked_by:`
  belongs there only after the 56 mappings are re-derived and checked.
- **Also unverified:** `AGENTS.md` states the item numbers are cited in
  `REQUIREMENTS.md`. Measured: **zero** `OI-nn` or `#nn` references in either
  `REQUIREMENTS.md` or `REQUISITI.it.md`, and zero links into `notes/` or
  `meetings/` from either. The claim may hold for the published artifacts and
  the client's correspondence, which were not checked.

---

## 2026-08-14 — claude — nightly requirements-check scheduled

- **Did:** created cloud routine `trig_01VCdUXmqy8PngWPJHA2dSYC` —
  **Mon–Fri 23:30 Europe/Budapest** (`30 21 * * 1-5` UTC), reporting to Slack
  group DM `C0BQD34LLF4` (Aurel, Anita Aga, Sara Aga). Full configuration in
  [docs/task-status.md](docs/task-status.md). First run **Mon 17 August**.
- **State:** it **commits directly to DevMain**, Aurel's explicit choice over a
  PR-based flow. Guarded: it commits only if `npm run vault:check` passes, and
  on failure commits nothing and leads its report with the failure. No-change
  runs write nothing and keep the existing watermark.
- **The skill had to change.** `requirements-check` guardrails said "never send a
  chat message", which would have made the routine refuse to post. Added **one
  explicit carve-out** naming that single group DM, mirrored to `.agents/`.
  **Do not widen it** — everything else stays read-only.
- **Watch:** ⚠ **the cron is fixed UTC and DST will break it.** Budapest leaves
  CEST on **25 October 2026**; after that it fires at 22:30 local. Change the
  cron to `30 22 * * 1-5` then.
- **Corrections, same day.** I reported that **Rexhina was unreachable on
  Slack** — wrong. I had searched four names in one query and got nothing;
  searching her name alone returns her immediately
  (`U0B36MRLJUV`, `r.hysi@romicompany.com`). Aurel then added her to the
  conversation by hand; **the channel id did not change**, so the routine still
  points at `C0BQD34LLF4` and now reaches all four developers.
- **Her surname is now known: Hysi**, supplied by Aurel on 2026-08-14 and
  matching the sister project's records. The person note was **renamed**
  accordingly — filename, H1 and all four inbound links — since the filename is
  the note's title.
- **Model set to `claude-opus-5`**, on Aurel's instruction, matching the sister
  project. The `schedule` skill defaults to Sonnet, so a future edit that resends
  `job_config` without the model will silently downgrade it — the model lives
  inside `session_context` and a partial update replaces the whole block.

- **Did:** R1 and R2. Added **§12 to `DEVELOPMENT-RECAP.md` and `.it.md`** — nine
  subsections, both twins in the same session, precedence headers updated so §12
  wins. Corrected the diagram provenance dates in the register, `README.md`,
  `REQUIREMENTS.md` and `REQUISITI.it.md`.
- **Correction, and it matters.** I had claimed the register and the prose
  carried stale state names, and recommended R2 on that basis. **They did not.**
  The register already held `In attesa di accettazione`, `Annullato`, six asset
  states, the tranche states, and `preventivo scaduto` documented as a retired
  label. Notes that over-claimed — OI-50, OI-59, OI-74, OI-69 and
  [the diagram note](notes/The%20newest%20design%20diagram.md) — have been
  corrected. **Verify before asserting a document is stale.**
- **State:** two genuine gaps were found. `order.states` still reads
  `[CREATO, CHIUSO/ACQUISITO]` against the 06/08 decision of
  `Ordinato → Fatturato → Incassato` — now marked `status: conflict` in the
  register with Elena Spini as owner. And `opportunity_types` was missing
  `Plus + Attivazione o Rinnovo`, now added.
- **Next:** **R2b** — get Elena to say whether `Incassato` is `CHIUSO/ACQUISITO`
  renamed. It is the same question as A2 on the board and it blocks configuring
  both `Order` and `Tranche__c`.
- **Watch:** §12 is now the top of the precedence chain in both recaps. Anything
  written after this must either fold into §12 or open §13.

---

## 2026-08-14 — claude — action board opened

- **Did:** created [docs/task-status.md](docs/task-status.md), a **ROMI-internal
  action board** modelled on the sister project's. It holds chores,
  confirmations and repo work that must **not** consume an `OI-NN`, because that
  numbering is client-facing and cited in `REQUIREMENTS.md`. Linked from
  [MAP.md](MAP.md) and [INDEX.md](INDEX.md).
- **State:** six actions for Aurel (A1–A6), four repo tasks (R1–R4). **A6 is
  already sent** — he replied on the _"Lista Eventi, Codici prodotto, esempio
  Bundle"_ thread on 14/08 to establish what Fabrizio delivered on 07/08;
  [OI-46](notes/items/OI-46%20Bundle%20classification%20picklists.md) and
  [OI-48](notes/items/OI-48%20Bundle-only%20article%20codes.md) now record that
  and are **waiting on Elena**, who returns 17 August.
- **Next:** **R2 first** when work resumes — re-merging the diagrams into the
  register and correcting the "31 July" claim. It is the only queued task with
  contractual consequence: `REQUISITI.it.md` goes to Pienissimo for signature
  and currently carries state names the design has moved past. Then R1.
- **Watch:** A4 (retrieving the six Biglietto classes into `force-app/`) is
  **source control, not test work** — it is deliberately outside the test-suite
  deferral and should not be swept up in it.

---

## 2026-08-14 — claude — newest diagram and the Mexal workbook drilled

- **Did:** decoded `Flows & Objects.drawio` (all three pages) and parsed
  `Integrazioni pienissimo.xlsx`, which Aurel downloaded manually after no
  connected tool could reach it.
- **State:** 🔴 **`Get Fatture` maps `numero_ordine` but no order-_line_
  number** — the key
  [OI-75](notes/items/OI-75%20Ticket%20availability%20rule.md) was agreed to match
  on. Mapping gap, not a Mexal limit; the line data is in the per-document call.
  **Raise at the 27 August call.** The diagram also settles three disputes with
  the prose: asset states are six with the sixth named **`Annullato`** (not
  "rinuncia al servizio"), `CHIUSO/ACQUISITO` **still appears** on the Ordini
  page after the session deleted it, and the quote state _Scaduto_ was renamed
  **`In Attesa Accettazione`**. Tranche states appear for the first time.
- **Next:** confirm `CHIUSO/ACQUISITO` with Elena — the tranche rule depends on
  it. Re-merge the diagrams into the register.
- **Watch:** ⚠ **the register is reading stale copies.** It records both diagrams
  as modified 31 July; Drive says **6 August** and **4 August**. `README.md` and
  `REQUIREMENTS.md` repeat the 31 July date. Anything "extracted verbatim from
  the diagrams" needs re-checking — see
  [the newest design diagram](notes/The%20newest%20design%20diagram.md).
- **Note:** both the diagram and the Mexal workbook use **real customer data** as
  worked examples — a named company with VAT, address, phone, email and PEC.
  Recorded as a hazard; the values are not reproduced in `notes/`.

---

## 2026-08-14 — claude — client documents drilled

- **Did:** drilled `01 Documenti forniti dal cliente/`, located the untracked
  16/07 internal meeting, and chased the two artifacts that could not be read.
- **State:** the find is
  [the client's own 11 June requirements document](notes/The%20client%20June%20requirements%20document.md) —
  seven pages, 13 numbered questions to ROMI, an internal owners table, and in
  no tracker. It is the **origin of `rinuncia al servizio`** (a Fabrizio-owned
  requirement, not an August addition), it yielded
  [OI-90](notes/items/OI-90%20Whether%20to%20introduce%20a%20Prospect%20state.md),
  and it puts **GLS, Teachable and Pienissimo Pro in writing on 11 June**.
- **Next:** open `Integrazioni pienissimo.xlsx` manually before 27 August — the
  per-field mapping is in the workbook, not in Mirko's mail body.
- **Watch:** the June document is **not** pre-sale evidence — 11 June is after
  the 27 May kickoff. It shows the topics were raised early and formally, which
  is why the client is confident, but the question that decides
  [the dispute](notes/risks/Risk%20-%20the%20phase%202%20scope%20dispute%20is%20unresolved.md)
  is whether they were **in the contract**. Do not present it as settling
  anything.
- **Tool limits, recorded so nobody repeats the attempt:** Gmail exposes
  attachment metadata but has **no download tool**; Drive cannot render
  `.drawio` as text. Both are noted in the trace with the fallback.

---

## 2026-08-14 — claude — knowledge structure installed

- **Did:** replicated the Life365 knowledge architecture onto this repository.
  Added the routing layer ([MAP.md](MAP.md), [INDEX.md](INDEX.md),
  [AGENTS.md](AGENTS.md) with `CLAUDE.md` / `GEMINI.md` /
  `.github/copilot-instructions.md` as pointers, this journal), the
  [notes/](notes/) vault with its
  [protocol](notes/Retrieval%20and%20write%20protocol.md),
  `npm run vault:check`, committed Obsidian config, the four project skills in
  both `.agents/skills/` and `.claude/skills/`, and
  [docs/publishing.md](docs/publishing.md) + [site/](site/).
- **State:** the first wave of notes is written — every live open item, the
  people, the risks, what is actually built, and the three core flows.
  **Resolved tracker rows were deliberately not split**; they stay in
  `meetings/open-items.md` under `## Resolved`, which remains the archive.
- **Two findings came out of the migration, neither of them in any tracker.**
  **(1)** The repository is roughly a week ahead of the 2026-08-03 org check:
  `OrderBigliettoTrigger`, `Solo_Bundle__c`, both WooCommerce fields,
  `OrderItem.Data_Scadenza__c`, `Opportunity.Tipo_Opportunita__c` and an
  standard integration scaffolding were all committed 04–07 August by the
  Calm-Coders developers working for ROMI — Anita Aga, Sara Aga and Rexhina —
  and the trackers were never updated to match. (The scaffolding itself is
  house pattern and correctly has no requirement; everything else on that list
  does.) **(2)** The Biglietto DocuSign/PDF
  Apex stack that the org check found Active in UAT is **not in `force-app/`
  at all** — six classes live only in the org.
- **Next:** re-run the org check against UAT to date the divergence properly
  (the 2026-08-03 snapshot is now stale in both directions), and decide whether
  `Tranche__c` or the participant flow goes first when the team returns ~24–26
  August.
- **Watch:** item ids in `notes/items/` are the tracker's own numbers
  (`#64` → `OI-64`) because those numbers are cited in `REQUIREMENTS.md` and in
  the published artifacts. Never renumber them. Note filenames are ASCII with
  spaces — Italian domain words are fine, accents are transliterated.

---

## 2026-08-14 — claude — requirements check, watermark 2026-08-07

- **Did:** swept Gmail, Slack, Drive and Fathom from the 2026-08-07 watermark.
  Six material findings, all folded into notes and both tracker languages.
- **State:** **Mexal field mapping answered** by Mirko Merendi on 11/08 —
  agent filter `610`, computed availability, causale FE, a **two-step N+1
  invoice retrieval** that is also the only source of the `numero riga d'ordine`
  [OI-75](notes/items/OI-75%20Ticket%20availability%20rule.md) needs, `501.AUTO`
  client creation, order serie 1 prod / 10 test. **Anticipay = ex CreditSafe**,
  one company — [OI-73](notes/items/OI-73%20VAT%20validation%20moves%20into%20Salesforce.md)
  is no longer uncertain. **Coupons excluded from phase 1**, closing one of
  [OI-49](notes/items/OI-49%20WooCommerce%20checkout-link%20flow.md)'s two open
  decisions. Four meetings dated: **19, 20, 25, 27 August**.
- **Next:** the 20/08 asset meeting is scope discovery, not review — Elisa says
  there are things never discussed. Read the two attachments before the 27/08
  build call: `Integrazioni pienissimo.xlsx` and the Mexal mapping workbook.
  Chase Fabrizio on **listino 1 vs listino 2**.
- **Watch:** three things. **(1)** A **sixth asset state, `rinuncia al
servizio`**, exists in Elena's client-facing doc and in no version of
  [OI-74](notes/items/OI-74%20Asset%20state%20machine.md) — do not configure the
  picklist without it. **(2)** `PIENISSIMO - Project Status.docx` numbers its
  open points **1–15 under its own scheme**; never conflate with the tracker's
  `#NN`. **(3)** [OI-88](notes/items/OI-88%20Zoho%20import%20template%20owed%20to%20Pienissimo.md)
  is new and is the **only migration item ROMI owns** — it had no row anywhere.
- **Note:** the trace note now carries `external_watermark:`, and the earlier
  same-day repository trace is marked `superseded` and links forward, so the
  next run cannot mistake a repo read for a sweep.
- **Correction, same session.** The first pass ran only **one** Gmail query and
  read eight of nine threads from snippets, then reported the client inputs as
  outstanding. Re-running the prescribed search angles showed no new threads —
  but a subject search surfaced that **Fabrizio Paganelli wrote to a thread
  titled "Lista Eventi, Codici prodotto, esempio Bundle" on 07/08 12:17** and
  Elena thanked him 21 minutes later. His message is **not retrievable from the
  mailbox** — an empty quoted stub only, consistent with an attachment. So
  [OI-46](notes/items/OI-46%20Bundle%20classification%20picklists.md) and
  [OI-48](notes/items/OI-48%20Bundle-only%20article%20codes.md) are now marked
  **unverified in both directions**; open that thread in a mail client before
  chasing the client again. Read full bodies next run, not snippets.

---

## 2026-08-26 — codex — org-status Slack delivery expanded

- **Did:** verified the existing `Pienissimo devs` Slack group DM by exact
  conversation id and membership, then updated both the canonical and Claude
  `org-status-check` skills so every completed result is sent independently to
  Aurel's personal DM and the project group DM.
- **Destination:** `Pienissimo devs` contains Aurel Mrruku, Rexhina Hysi, Sara
  Aga and Anita Aga. The completed 26 August org-status report was forwarded to
  the group immediately.
- **Validation:** both skill trees remain byte-for-byte identical; both pass
  the skill validator in UTF-8; all five org-status behavioral tests pass; the
  changed Markdown files pass Prettier verification.
- **Watch:** Slack delivery is independent per destination. If one send fails,
  deliver to the other, report the partial failure in chat and never guess a
  replacement conversation.

---

## 2026-08-27 — codex — traced Lead duplicate VAT question

- **Did:** created
  [OI-100](notes/items/OI-100%20Same%20lead%20email%20with%20different%20VAT%20during%20conversion.md)
  for the unresolved Lead conversion scenario where two Leads share the same
  email but have different VAT / Partita IVA values.
- **Decision needed:** Aurel must choose whether email identity wins, VAT/company
  identity wins, or the conflict should block conversion and ask the user to
  choose the correct Account/Contact.
- **Current build note:** the manual Lead conversion Apex matches by Contact
  email and does not evaluate VAT, so no further change should be made there
  until this question is answered.

---

## 2026-09-02 - codex - checkout email action uses shared template

- **Did:** changed the Opportunity `Send Checkout Email` quick action from a
  hardcoded email composer draft to a direct Apex send using the shared
  `WooCommerce_Checkout_Link` Salesforce email template.
- **UI:** `wooCheckoutEmail` now asks for a recipient email address and sends the
  template to that address; the checkout link is supplied by the template from
  the current Opportunity id.
- **Validation:** the focused LWC behavior is covered by the updated Jest test.
  No Apex test class was added, per the standing instruction to leave Apex test
  work for its separate pass.
- **Follow-up:** after deployment, the quick-action UI was adjusted to hide the
  internal template name and show an example checkout link containing the current
  Opportunity id.

## 2026-09-01 — claude — drilled the Anticipay middleware API documentation

- **Did:** Aurel Mrruku downloaded `Documentazione API - Salesforce.pdf` by hand
  and asked for it to be drilled — the outstanding ask the 31 August trace listed
  first. Extracted with `pdftotext -layout` (the `Read` tool needs poppler's
  `pdftoppm`, which is not installed; `/mingw64/bin/pdftotext` is). Decoded in
  full into
  [the Anticipay middleware API contract](notes/The%20Anticipay%20middleware%20API%20contract.md).
- **Provenance:** Gmail thread `1a0589a4a85b5bdf`, **two** messages from Andrea
  Parmeggiani — v1 **31 Aug 16:15:00Z**, v2 **1 Sep 10:46:38Z** adding the `:env`
  path parameter. The downloaded file is **v2**. Only one Gmail query was run,
  for provenance; **this was not a sweep**.
- **Created:** the contract note, `OI-105`–`OI-108`, and
  [a trace](notes/traces/Source%20trace%202026-09-01%20Anticipay%20API%20drill.md).
  **Updated:** `OI-73`, `OI-94`, `OI-95`, `MAP.md`, `INDEX.md`, both trackers
  (rows 105–108 new; 73, 94, 95 extended) and a new §23 in both recaps.
- **Corrected same session, on Aurel's steer.** `OI-107` was first written as
  _"the error response body is undocumented, so the three-month error store cannot
  be built"_. **Wrong** — the store is `Integration_Log__c`, ROMI's standard
  callout audit trail, already committed and already logging `Response_State__c`
  plus the raw body. Renamed to
  [OI-107 The Anticipay error path does not reach the integration log intact](notes/items/OI-107%20The%20Anticipay%20error%20path%20does%20not%20reach%20the%20integration%20log%20intact.md)
  and rewritten around what reading `API_Callout_Engine` actually shows:
  🔴 **`Is_Error__c` is never set for an HTTP error** (so the agreed notification
  is silent for every `404`), and 🔴 **the `catch` rebuilds the log row without
  `Response_State__c`** (so a non-matching error body loses the HTTP code). Both
  generic — they affect Mexal too. Corrected across MAP, INDEX, both recaps, both
  trackers, OI-73, the contract note and the trace.
- 🔴 **The harder blocker, found in the same pass:** `API_Callout_Engine` **cannot
  pass a path parameter**. For a `GET` it discards the caller's argument
  (`buildRequest` sets a body only when the method is not `GET`) and
  `Endpoint_Path__c` is a static custom-setting field — so `:piva`, which differs
  on every call, has nowhere to go. Extend the shared engine, or give Anticipay
  its own client. Recorded in the contract note; **not yet an item, because the
  choice is Aurel's.**
- **Also corrected:** the token does **not** belong in
  `Integration_Configuration__c.Token__c` — `buildEndpoint` uses
  `callout:<NamedCredential>`, so it goes in a Named Credential. 🟢 And the engine
  never populates `Request_Headers__c`, so the bearer token is not written to the
  log.
- **Also new:** six of eleven response fields identify a private individual
  ([OI-108](notes/items/OI-108%20The%20Anticipay%20payload%20carries%20personal%20data%20of%20the%20legale%20rappresentante.md));
  one static bearer token for both `test` and `prod`, mailed twice to six
  addresses
  ([OI-106](notes/items/OI-106%20One%20static%20bearer%20token%20serves%20both%20Anticipay%20environments.md));
  and `data_di_dascita_legale_rappresentante` is misspelled **in the wire format**
  ([OI-105](notes/items/OI-105%20The%20Anticipay%20date%20of%20birth%20field%20name%20is%20misspelled.md)).
- 🔴 **The PDF was deliberately NOT committed**, breaking the precedent set by
  `Payload woo-salesforce.json`. It carries a **live bearer token** and a real
  individual's full personal data; committing it would put a working credential
  into git history where deleting the file does not remove it. The contract note
  is the record — structure only, no values. **Do not add the PDF later.**
- **Watermark untouched.** The next `requirements-check` still uses
  **2026-08-31T22:00Z** from
  [the 31 August trace](notes/traces/Source%20trace%202026-08-31.md). Slack, Drive
  and Fathom were not searched today.
- **Fixed in passing:** `INDEX.md` had never listed the 31 August trace and still
  named the **28 August** one as the current watermark. Both corrected.
- **Left alone, deliberately:** `INT-18` still reads
  `status: open, recommendation: phase_2` while the whole record treats Anticipay
  as **Fase 1**. Real contradiction, predates today, and fixing it means moving a
  signed document in both languages — raise with Elena Spini rather than change
  it from a note.
- 🔴 **Caught late, and it matters: the 1 September follow-up call ALREADY RAN.**
  The calendar event `2j4tg4tglt9iei6285jfn8i62s` carries a **recording timed
  10:02 CEST** and Gemini notes `1CiCRPuxOoZvqmlUTRahWyewjAuDw4n0wgOMzs4vK0dU`.
  ⚠ **v2 of the documentation arrived 12:46 CEST, after the call ended**, so
  `:env` is plausibly an **outcome** of that session. The first pass of today's
  notes framed the six questions as an agenda for an upcoming call; **corrected
  across `MAP.md`, `OI-94`, both recaps, both trackers and the trace** to read as
  questions raised by the document, to be checked against the minute first.
- **Next action on this whole area: drill the 1 September meeting.** It was not
  done today — it is `drill-meeting`'s job and much larger than what was asked —
  and it may already answer several of `OI-105`–`OI-108`. **Do not chase Andrea
  Parmeggiani for anything before reading it.**
- **Watch:** `MAP.md` is now **~34 KB** against its own "keep under 5 KB"
  instruction. Not restructured today; it needs a deliberate pass that moves the
  dated incident blocks into notes.

## 2026-09-02 — claude — org-status check, and org access confirmed fixed

- **Ran `org-status-check`, full scope, report mode**, against `Pienissimo UAT`
  (`00DMA000004nMMr2AM`, partial sandbox, API 68.0) at repo `4a49376`.
  165 repository components vs 1,072 org components; 9 deterministic assertions;
  `org-status:validate` passes with one warning. Result delivered to the
  `Pienissimo devs` group DM, summary plus one threaded continuation.
- 🟢 **Org access is fixed, and this session is what wrote it down.** Aurel
  Mrruku, asked directly: _"yes its working, we have fixed it"_. The org check
  the same morning corroborates it independently — full inventory, no auth
  failure. [The access risk](notes/risks/Risk%20-%20the%20team%20lost%20access%20to%20the%20Pienissimo%20orgs%20on%201%20September.md)
  is **resolved**; `MAP.md` and `INDEX.md` updated. **Two things it does not
  settle** and the note says so: which PROD Elena Spini meant, and why it broke.
- **Findings the run produced** — the run itself was report mode, so nothing was
  mutated by it. ✅ **All of the following were reconciled and published later the
  same day** — see the next entry:
  - 🔴 **The eleven Anticipay fields agreed 1 September are unbuilt.** Account
    carries three custom fields, none of them PEC, the legal-representative
    fields or the rep address. Eight days before Fase 1 development ends.
  - 🔴 **Zero project Flows in the org**, verified twice (Metadata API list, and
    `FlowDefinitionView` — 79 flows, none non-namespaced).
    `Lead_Non_Risponde_Follow_Up` was deleted in `158c2d0` and is recoverable
    from git, but the 28 August run recorded **two** flows and git history holds
    only ever one flow file. The second is unidentifiable.
  - 🔴 **Named credentials `Anticipay` and `DocuSign` exist only in the org**, as
    do permission sets `DocuSign`, `Full_Permission`, `Sales_User`. Third
    instance of the org-only pattern.
  - 🔴 **The register misstates build state in three places**: `build_state` cites
    `QUO-01`/`QUO-06` which are not among the 154 ids; `NFR-06` carries
    `current: "1%"`; the `ORD-01` `not_built` entry says Order has stock status
    and zero custom fields, against `Incassato` on 12 of 15 orders and 3 custom
    fields.
  - 🟢 **The WooCommerce orphan-route risk is closable.**
    `WoocommerceOrderService` is now committed and **byte-identical** to the
    deployed class (the size gap is line endings alone), the duplicate endpoint
    class is gone from both sides, one REST route remains.
    [The deploy risk](notes/risks/Risk%20-%20a%20clean%20deploy%20would%20orphan%20the%20live%20WooCommerce%20endpoint.md)
    was **left open** — it needs its own pass, not a side effect of this one.
- ⚠ **The coverage number is being read wrongly across the record.** The org
  reports 0% of 1,646 lines, but the last Apex test run is **2026-08-04**, while
  classes changed through 31 August. The aggregate is not measuring current code;
  0% means _unmeasured_, not _measured at zero_. Still a deploy blocker either
  way. No test was run, written or offered.
- ⚠ **`org-status-check` has a silent false negative.** Its Metadata API listing
  returns **0 EmailTemplates** with nothing recorded in
  `unavailable_metadata_types`, because folder-scoped types cannot be enumerated
  without a folder. SOQL proves 88 templates, including the project's active
  `WooCommerce_Checkout_Link`. The negative-evidence rule was violated silently.
  The skill's inventory reference needs this caveat; **not fixed today**.
- **Unrelated, same session:** `.codebase-index/config.json` had `autoIndex:
false` since it was first committed in `3618d96` (25 August) — the package's
  own default, never a decision. Set to `true` at Aurel's request; **uncommitted**
  and needs a session restart to take effect. Reading the shipped MCP server
  showed the watcher reindexes regardless of that flag, so the practical effect
  is the startup pass, not mid-session edits.
- **Watermark untouched.** The next `requirements-check` still uses
  **2026-09-01T22:00Z**. No mail, Slack, Drive or Fathom sweep was run today.

## 2026-09-02 — claude — org-status reconcile + publish

Second half of the same session. Aurel Mrruku authorised `reconcile + publish`
after the report-mode run above; this entry records what was written.

**Register.** The whole `build_state` block was rewritten from the 2026-09-02
evidence, `supersedes: 2026-08-26`. 16 built, 8 not-built, 9 divergent, 2
regression entries, plus three new keys: `instrument_limitations` (LIM-01..04),
`unmapped_observations`, and a corrected `out_of_source_control` list.
✅ **The `QUO-01`/`QUO-06` defect is fixed.** Those ids have never existed among
the 154 requirements — the sales area uses `SAL-`. Entries whose text names a
requirement now cite `SAL-08` and `SAL-09`; entries observing the quote **state
machine** carry a new `state_machine: quote` key and no ref, because the register
has no id for it. `org-status:validate:strict` passes with
`unknown_build_state_refs: []`. ⚠ **That mapping is the one judgment call in this
pass and is reversible** — nothing else in the register was touched, and no
requirement text moved.

**Three new notes**, one per new divergent finding:

- [integration credentials exist only in the org](notes/risks/Risk%20-%20integration%20credentials%20exist%20only%20in%20the%20org.md)
  — `Anticipay` and `DocuSign` named credentials plus three permission sets,
  org-only. Asks for a targeted retrieve; warns explicitly not to commit secrets.
- [a second Flow was deleted with no source copy](notes/risks/Risk%20-%20a%20second%20Flow%20was%20deleted%20with%20no%20source%20copy.md)
  — severity medium, deliberately: nothing is known to have been lost, and the
  finding is that the project cannot tell. **Asks Anita Aga, and says explicitly
  not to reconstruct a flow from inference.**
- [the Anticipay field build has not started](notes/risks/Risk%20-%20the%20Anticipay%20field%20build%20has%20not%20started.md)
  — the sharpest date on the project. Records that the fields are buildable
  _today_, unblocked by the outstanding client answer.

**Two risks resolved**, both with the evidence kept intact rather than rewritten:
[the WooCommerce orphan route](notes/risks/Risk%20-%20a%20clean%20deploy%20would%20orphan%20the%20live%20WooCommerce%20endpoint.md)
(byte-identical after normalising line endings; the 848-char gap is CRLF) and
[OrderItem Tranche invisibility](notes/risks/Risk%20-%20OrderItem%20Tranche%20is%20invisible%20to%20every%20user.md)
(granted to `Tranche_Management`; **propagation still unbuilt**, 0 of 18).

**Three notes corrected**: the coverage risk and `OI-64` both now carry the
LIM-04 reading — 0% is **unmeasured**, not measured at zero, because no test has
run since 4 August;
[the method note](notes/How%20to%20read%20the%20org%20schema%20without%20a%20false%20negative.md)
gained the EmailTemplate case and a generalised rule with an instrument table.

**Rendered views**: `§25` appended to `DEVELOPMENT-RECAP.md` **and** `.it.md` in
the same session, both precedence lines extended (they had been stale since
`§19` and now name every section through `§25`); a `2026-09-02` org-verification
block added to `open-items.md` **and** `.it.md`; `MAP.md`, `INDEX.md` and
`STATUS.md` regenerated.

**Checks**: `vault:check` OK — 156 notes, 156 unique ids, all links resolve.
`validate:strict` passes.

⚠ **Prettier was NOT run repo-wide, deliberately.** `npm run prettier:verify`
fails on **324 files** and has clearly been failing for a long time; reformatting
would have produced a diff that buried this reconcile. Only the three new notes
were formatted. **The repo-wide prettier drift is pre-existing and still owed.**

⚠ **The trace backfill is owed.** `vault:check` now warns that **10** notes cite
a requirement that does not name them back, up from 6 — the three new notes carry
`requirement:` and the register has no matching `tracked_by:`. That is
`requirement-trace`'s job, not this skill's, and was not attempted here.

**Published.** Notion identity verified by **workspace id**, which matched — the
**name** had changed (`Aurel mrruku's Space` → `Romi Projects's Space`); a rename,
not a different workspace, and now recorded in
[the mirror note](notes/The%20Notion%20mirror%20of%20the%20project%20status.md).
Status page updated in place by id; Flows page build-state callouts rewritten with
**every diagram untouched**; tracker reconciled on `Ref` — **14 rows added**
(`OI-96`–`OI-109`), **2 statuses corrected** (`OI-66` Superseded, `OI-95`
Resolved), all **70** rows re-queried and matched. `site/index.html` re-derived;
**the leak check returns nothing**.

⚠ **A trap worth recording.** Small targeted replacements leave untouched every
sentence they contradict. The first Status-page pass left the page asserting both
that the Order Item grant was resolved and, four sections later, that it was
granted to nobody — caught only by re-fetching and reading the whole page.
`STATUS.md` had the same defect and was fixed alongside. **Re-read the whole
surface after writing, not just the parts you changed.**

⚠ **`site/` is refreshed, not deployed.** It has never been deployed; there is no
public URL. Deployment is a manual upload with credentials this session does not
hold.

**Watermark untouched** — still **2026-09-01T22:00Z**. No mail, Slack, Drive or
Fathom sweep ran today.

---

## 2026-09-02 — claude — Anticipay v3: the endpoint moved and now works

- **Did:** drilled a **third** revision of `Documentazione API - Salesforce.pdf`
  (`(1).pdf` in Downloads, 12:47 CEST). Extracted with `pdftotext -layout` and
  **diffed against the v2 extraction** rather than trusting the mail body.
- **The change is two lines.** Host `integration.pienissimo.com` →
  **`romi.pienissimo.com`**. Nothing else differs.
- 🟢 **The endpoint works for the first time.** Thread `1a0589a4a85b5bdf` now has
  5 messages: Aurel Mrruku reported the old host dead at **08:21:59Z**
  (`HTTP/1.1 404`, `Content-Type: text/html`), Andrea Parmeggiani stood up the new
  third-level domain and sent v3 at **10:18:26Z**, Aurel Mrruku confirmed at
  **10:40:45Z**. **So v1 and v2 documented a host that never resolved.**
- 🔴 **Best finding of the session, and it came from the outage, not the fix.** An
  HTML `404` from a wrong hostname is a **third meaning** for `404` (alongside
  _VAT unknown_ and _not cached under `env=test`_), separable only by
  `Content-Type`. It is the concrete case that breaks
  [OI-107](notes/items/OI-107%20The%20Anticipay%20error%20path%20does%20not%20reach%20the%20integration%20log%20intact.md)
  defect 2: `API_Callout_Engine` parses HTML into the `200` wrapper, throws, and
  the `catch` drops `Response_State__c` — **a dead endpoint logged as an Apex
  parse error with no status and no error flag.** Written up as §2b.
- ⚠ **The org's `Anticipay` named credential predates the move** — today's org
  check found it 08:05–08:14Z, before the new host existed. Very probably carries
  the dead host. Folded into
  [the credential risk](notes/risks/Risk%20-%20integration%20credentials%20exist%20only%20in%20the%20org.md).
  **Not verified** — nobody opened Setup; it is stated as a timing inference.
- ⚠ **Three revisions, and the `data_di_dascita` typo and the missing error body
  survive all three** — because neither ask has ever been made. Both belong in one
  mail to Andrea Parmeggiani, who has now revised the doc three times in three
  days.
- 🔴 **Reachability is not the contract.** No lookup has run — no `200`, no `404`,
  no error body observed. **The eleven fields agreed 1 September are still not
  built**, eight days from the 10 September deadline, and that work never needed
  an endpoint or a token.
- **Written:** the trace, plus the contract note, `OI-94`, `OI-105`, `OI-107`, the
  credential risk, `MAP.md`, row 94 in both trackers and a new **§26** in both
  recaps. The v3 PDF was **not** committed — live token and real personal data,
  same as v1–v2.
- **Method note worth keeping:** a document can be perfectly specified and still
  describe nothing. Three sessions of analysis went into a contract whose host had
  never resolved. **Curl an endpoint before drilling its documentation** — it is
  seconds and it bounds everything else.
- **Still not done:** Notion is unpushed and now further behind; today's work and
  the org check's output are both uncommitted.
