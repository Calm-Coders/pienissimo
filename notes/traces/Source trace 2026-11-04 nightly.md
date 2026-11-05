---
id: trace-2026-11-04-nightly
type: reference
status: active
updated: 2026-11-04
watermark_used: 2026-11-03T22:00Z
external_watermark: 2026-11-04T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-11-04 nightly

**Watermark for the next `requirements-check` run: 2026-11-04T22:00Z, single
value.**

**Watermark used: 2026-11-03T22:00Z**, the `external_watermark` stated by
[the 03/11 nightly trace](Source%20trace%202026-11-03%20nightly.md), selected by
`updated:` frontmatter. Scheduled nightly run, executed 2026-11-04 ~22:00Z. **One
day.**

🔑 **The headline: the production chain ran further than ever — partial invoicing
moves one asset at a time — and in the same hour it was shown to have no reverse
gear.**

🟢 **Environment note.** The clone opened on a detached `main` (two commits, config
only) with none of the knowledge layer in the working tree; `DevMain` did not exist
locally and was created from the fetched remote branch. **Twenty-nine runs, same
opening pattern.** The working tree was **clean** at start, so the four 04/11
development sessions in `JOURNAL.md` were already committed despite three of their
entries saying "uncommitted on `DevMain`".

## Sources searched

| Source | Query / scope | Result |
| ------ | ------------- | ------ |
| **Gmail** | `pienissimo after:2026/11/03 -in:draft`, 50 requested, 14 estimated | **Nine threads moved in the window.** All bodies read in full |
| **Gmail** | `get_message 1a1a7657bebf46a5` (PLAIN_TEXT) | 🟢🔑 **`Import ORDINI - Testata e Riga`**, 16:30:06Z, attachment `Import Ordini (versione del 2026.11.04).xlsx` — _"vi inoltro file con TESTATA e RIGA ordini. Fateci sapere se va tutto a buon fine"_ → [OI-310](../items/OI-310%20The%20production%20load%20needs%20a%20pre-load%20and%20a%20delta%20run.md). ⚠ **Not opened** — real customer records |
| **Gmail** | `get_message 1a1a736daaf9d282` | 🟢 **`Anagrafica Account`**, 15:39:10Z, attachment `Account Salesforce (rev Agente).xlsx` — _"vi giro l'anagrafica degli account tramite mail, mi viene più comodo"_. ⚠ Not opened; the `rev Agente` in the filename is consistent with [OI-332](../items/OI-332%20The%20account%20import%20keys%20on%20the%20Salesforce%20agent%20code%20and%20the%20client%20file%20is%20mis-coded.md)'s correction but **nothing verifies it** |
| **Gmail** | `get_message 1a1a7412568abc82` + thread `1a1a7412568abc82` | 🟢🔑 **`Lista Locali`** thread, 3 messages 15:50-16:21Z, attachment `Locali Salesforce.xlsx`. The whole decision in 31 minutes: _"molti locali senza codice cliente mexal. Li potete caricare ugualmente?"_ → _"record zombi"_ → **_"Caricate allora solo quelli che hanno codice mexal"_** → [OI-333](../items/OI-333%20Locali%20without%20a%20Mexal%20customer%20code%20will%20not%20be%20loaded.md). ⚠ Not opened |
| **Gmail** | `get_thread 1a1a746c8e63d5ac` (PLAIN_TEXT) | 🔑 **`Referenti`**, 3 messages 15:56-16:21Z — **_"considerate il file che vi abbiamo inviato l'ultima volta"_** → Aurel Mrruku _"non hanno il codice mexal del account"_ → **_"Potete verificare?"_** unanswered → [OI-290](../items/OI-290%20Lead%20and%20Referenti%20migration%20data%20is%20owed%20by%20the%20client.md) |
| **Gmail** | `Trasferimento dati` thread `1a17d77a1132e4da`, 2 new messages | 🟢 **Training confirmed**: Marco Montesi 08:59:25Z, _"lunedì 9 e mercoledì 11 dalle 11:30 alle 13:00"_; Elena Spini 17:31:59Z, _"Inviti inviati"_ 🆕 **_"Le utenze dei tutor le creo dopo il training o procedo già adesso?"_** → [OI-300](../items/OI-300%20Tutor%20training%20and%20tutor%20test%20access%20are%20unplanned.md) |
| **Gmail** | `get_message 1a1a727f15cda188` (Gemini notes, Continuazione Test e2e PROD) | Notification only; the document itself was read from Drive |
| **Gmail** | threads `1a1a291d143128a7`, `1a1a269396bff466`, `1a1a2662cea3f834`, `1a1a24155145940d`, `1a1a1b96a6f63a3f`, `1a1a13322fc6fb23`, `1a1a131d3129e774`, `1a1a12aad5256527` | **Already held** — all are 03/11 messages inside the search window's date boundary, drilled by the 03/11 run. Not re-ingested |
| **Drive** | `title contains 'Continuazione Test e2e PROD'` | Meeting folder `19s_fxPIIpb1E3Jmd54MLusZ5QQzI_tqP`, created 15:21:56Z |
| **Drive** | `parentId = '19s_fxPIIpb1E3Jmd54MLusZ5QQzI_tqP'` | ⚠🔑 **One shortcut only**, to the Gemini notes — **no recording, no separate transcript document. Third consecutive session with that pattern** |
| **Drive** | `read_file_content 1Up4-utEa2OhAqeo-m3GJVeaJ4SxqGShtW7NNtVBa6_U`, **97,357 chars** | 🟢🔑 **Too large to return; written to scratch and read in slices with python** — notes + `Dettagli` (22k) and the **full 01:49:12 transcript (75k), read once, in order, in full** → [the meeting note](../meetings/2026-11-04%20Continuazione%20Test%20e2e%20PROD.md) and `meetings/2026-11-04-continuazione-test-e2e-prod-transcript.it.md` |
| **Slack** | `slack_read_channel C0B5T3RB4FM` (`#tproj-pienissimo`), `oldest` 1793743200 | **0 messages.** 🔴 **Silent a third consecutive sweep**; no human message since its 30/10 status post |
| **Slack** | `slack_read_channel C0BQD34LLF4` (dev group), same bound | **2 messages.** 🟢 Aurel Mrruku 10:42:48 CET, _"Things to know before deploying DevMain to Prod"_ — the Prod-versus-`DevMain` record-page and destructive-change warnings, one ✅ and **no reply**; plus this session's own 03/11 report. 🔴 **No nightly report has ever been answered** |
| **Slack** | `slack_read_channel C0C38JJ9D1T` (marketing group DM), same bound | **5 messages.** 🔴🔑 **18:26 Elena Spini to Fabrizio Mastracci** — _"sembra esserci un problema sull'invio dei biglietti in PROD … i biglietti vengono di nuovo inviati quando lo stato dell'asset è in ordinato"_, _"domani ti manderà lui i dettagli"_ → [OI-313](../items/OI-313%20The%20ticket%20nomination%20email%20fired%20for%20assets%20still%20in%20ordinato.md). Also 09:08 Fabrizio Mastracci, _"vorrei prima testare delle logiche che ho aggiunto"_ |
| **Slack** | `slack_read_channel D0B5QHS2T7H` (Elena Spini DM), same bound | **13 messages, two threads read.** 🔑 16:41 _"hanno chiesto di mettere le tranche obbligatorie"_ → _"sempre???"_ → _"fattibile, mi sto occupando di questo"_ ([OI-329](../items/OI-329%20Tranches%20must%20be%20mandatory%20and%20the%20quote%20PDF%20blocked%20without%20them.md)); 16:41 _"cambiare un pò il layout sull'inserimento dei prodotti sul preventivo"_ ([OI-330](../items/OI-330%20The%20product%20selection%20screen%20is%20unusable%20for%20multiple%20products.md)); 🔴 16:41 _"i biglietti vengono di nuovo inviati in ordinato"_ → _"puoi scrivere a Fabrizio nella chat comune?"_ → **_"oggi no, domani"_**. ⚠ 09:13 a `[ROMI-ZUCCHET]` 3CX question — **different client, ignored** |
| **Slack** | `slack_read_canvas F0BD2H5A9HT` (`Link utili Pienissimo`) | **Unchanged.** Newest entry still 20.08.2026 — **76 days**. Re-read per the skill |
| **Fathom** | `list_meetings created_after 2026-11-03T22:00Z`, 3 pages | **0 meetings.** 🔴 **Nothing, a thirty-second consecutive run** — on a day with a 01:49:12 client call recorded through Google Meet |
| **Git** | `fetch origin DevMain`, `ls-remote --heads`, `status` | `DevMain` at **`3e21b32`** (merge of PR #122 from `DevAnita04`); working tree **clean**. 🔴 No branch carries [OI-329](../items/OI-329%20Tranches%20must%20be%20mandatory%20and%20the%20quote%20PDF%20blocked%20without%20them.md) or [OI-330](../items/OI-330%20The%20product%20selection%20screen%20is%20unusable%20for%20multiple%20products.md) work |
| **Repo** | `ls notes/items` max-id scan | Max existing id **328**, so this run allocated **329**–**336**; next free is **337** |
| **Repo** | `JOURNAL.md` first 94 lines | Four 04/11 development sessions already held: the Prod Mexal invoice/scadenzario re-sync, the OI-314 `Fatturato` rule, Prod aligned with UAT (29 components), and the OI-306 `nota` work with its array correction |

## Found

1. 🟢🔑 **[The 4 November Continuazione Test e2e PROD session](../meetings/2026-11-04%20Continuazione%20Test%20e2e%20PROD.md)
   proved the production chain divisible.** 14:28 CET, **01:49:12**. Quote with two
   tranche → DocuSign → **Mexal `OC157`** → **one tranche invoiced, 4.830 €** →
   manual cash collection → `Scadenza Fattura` `pagato` → **only that tranche's
   asset `Disponibile`**, the rest `ordinato`. A second order (~34.000 €) went
   through in full. 🔴 Elena Spini could not attend; Aurel Mrruku and Fabrizio
   Paganelli alone with Elisa Migliano at his desk.

2. 🟢🔑 **[OI-306](../items/OI-306%20The%20WooCommerce%20order%20number%20must%20reach%20Mexal%20in%20the%20order%20header%20note.md)
   is resolved.** The array fix reached Prod before lunch and the quote number was
   read off the Mexal document — _"Vedi nota 07?"_ — and off the invoice printed
   from it. **This record said this morning that Prod still sent the rejected
   string form**; that is now superseded.

3. 🔴🔑 **[OI-331](../items/OI-331%20A%20reversed%20collection%20cannot%20move%20the%20order%20and%20asset%20states%20back.md)
   — the state machine has no reverse gear, by design.** Collection deleted on
   screen, due date reopened, **asset stayed `Disponibile`**. Aurel Mrruku named
   design and fix together. 🔑 **It is the client's monthly Ri.Ba. return cycle**,
   so it arrives in bulk every month, and the ticket may already have been sent.
   Routed to Fase 2, meeting owed to three named people, **no date**.

4. 🔴 **[OI-313](../items/OI-313%20The%20ticket%20nomination%20email%20fired%20for%20assets%20still%20in%20ordinato.md)
   reproduced during the test** — so it is a fault, not an incident — and the
   diagnosis moved **off the event link onto the marketing flow's own filter**, on
   a version 1.5 months old. ⚠ The mapping's send date was deliberately 31/12/27,
   so the send happened outside any window: the date gate is not read either.
   🔴 **The client has still been told nothing**, 30 hours after Elena Spini
   promised an answer.

5. 🆕 **Eight new items, OI-329 → OI-336.**
   [OI-329](../items/OI-329%20Tranches%20must%20be%20mandatory%20and%20the%20quote%20PDF%20blocked%20without%20them.md)
   tranches become mandatory, enforced by blocking `Genera PDF` — **a reversal of
   an agreed rule**, in progress the same evening, nothing in the repo ·
   [OI-330](../items/OI-330%20The%20product%20selection%20screen%20is%20unusable%20for%20multiple%20products.md)
   five UI asks accepted, none built ·
   [OI-331](../items/OI-331%20A%20reversed%20collection%20cannot%20move%20the%20order%20and%20asset%20states%20back.md)
   above ·
   [OI-332](../items/OI-332%20The%20account%20import%20keys%20on%20the%20Salesforce%20agent%20code%20and%20the%20client%20file%20is%20mis-coded.md)
   the import keys on `codice agente` only, falls back to `01`, and the client's
   file has shared and wrong codes — **a mis-assignment is silent** ·
   [OI-333](../items/OI-333%20Locali%20without%20a%20Mexal%20customer%20code%20will%20not%20be%20loaded.md)
   uncoded Locali excluded by decision ·
   [OI-334](../items/OI-334%20The%20Mexal%20sync%20frequency%20is%20undecided%20and%20no%20job%20is%20scheduled%20in%20production.md)
   no frequency chosen **and no Mexal job scheduled in Prod at all** ·
   [OI-335](../items/OI-335%20A%20Pienissimo%20360%20test%20page%20showed%20management%20280000%20euro%20of%20insoluti.md)
   a test page showed management ~280.000 € of insoluti ·
   [OI-336](../items/OI-336%20The%20quote%20PDF%20allegato%20B%20has%20no%20signature%20field.md)
   no signature field on `allegato B`, and `prezzo neto` misspelled on the
   client-facing PDF.

6. 🔑 **The account import rule is on the record for the first time** — read
   `codice agente` only, ignore the owner name, most recent user on a duplicate,
   **fall back to `01`** — together with the data defect that makes it dangerous.
   ⚠ **Aurel Mrruku first said the file needed no correction** and conceded only on
   seeing the mis-coded row: _"Ah no, hai ragione. Cavolo."_

7. 🟡🔑 **[OI-290](../items/OI-290%20Lead%20and%20Referenti%20migration%20data%20is%20owed%20by%20the%20client.md)
   reversed.** The client's answer is that the file already sent **is** the
   deliverable, with the update coming _"la settimana prossima con Sabatino"_ —
   against five consecutive records saying the half was outstanding. 🔴 Aurel
   Mrruku says it carries no Mexal code; the client asked ROMI to verify;
   **unanswered**. 🔑 The file is dated for the first time: **27-28 October**.

8. 🟢 **[OI-310](../items/OI-310%20The%20production%20load%20needs%20a%20pre-load%20and%20a%20delta%20run.md)
   — three of the four interface files arrived** within 50 minutes of the call, and
   the 12-13 November window hardened in the client's own words. ⚠ He is absent on
   the 9th, carries the Pienissimo 360 migration in the same window, and said
   _"Non posso fare tutto da solo."_ 🆕 **The invoice numerators must change before
   go-live** — no owner, no date, in no other record.

9. 🟢 **[OI-205](../items/OI-205%20The%20tranche%20carries%20no%20value%20so%20the%20client%20cannot%20see%20what%20each%20one%20is%20worth.md)'s
   attribution is confirmed** — the client asked for the tranche amount himself —
   and 🔴 **deprioritised conditional on being chased**, with nobody named to chase.

10. 🟢 **[OI-311](../items/OI-311%20The%20marketing%20flow%20update%20needs%20clean%20test%20records.md)
    is unblocked**: the clean production records were made deliberately in this
    session, with a marketing test set for 5 November. 🔴 And the fault it was
    waiting to exclude reproduced in the same hour.

11. 🔴 **[OI-312](../items/OI-312%20Anticipay%20times%20out%20in%20production.md)
    unmoved a second day** — Andrea at an event, nothing prepared, **still no
    date** — and the whole production chain is being validated on the workaround
    channel.

12. ⚠ **[OI-314](../items/OI-314%20The%20order%20line%20fatturato%20status%20is%20not%20implemented.md)'s
    rule was not live during the test**, so the afternoon's orders are not evidence
    for it, and the first order to exercise it will run in a Prod org with no
    scheduled sync.

## Not done, and why

- **The org was not opened.** Every production statement here comes from the
  transcript, the mail or the 04/11 journal entries, not from an inspection in this
  session. `STATUS.md` and its Notion mirror are **stale**; the sweep moved the live
  position and step 6 of `org-status-check` was **not** run.
- **No Apex test class was written or proposed.** Standing instruction.
  [OI-64](../items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md),
  [OI-66](../items/OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md) and
  [the deploy risk](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md)
  are unchanged and were not acted on.
- **The three migration workbooks were not opened** — `Account Salesforce (rev
  Agente).xlsx`, `Locali Salesforce.xlsx`, `Import Ordini (versione del
  2026.11.04).xlsx`. They hold real customer records; existence recorded, no values
  copied. The same holds for `Referenti_V2`, the Lead files, `Utenti Area
  Commerciale.xlsx` and the picklist workbook.
- **`lead-web-to-lead (2).html`**, posted by Rexhina Hysi in the dev group on
  03/11, is **still unopened and still unexplained**; the 03/11 report asked her
  about it and she has not replied.
- **The requirement register was not touched** — stays **v1.6**. The
  [OI-329](../items/OI-329%20Tranches%20must%20be%20mandatory%20and%20the%20quote%20PDF%20blocked%20without%20them.md)
  tranche obligation changes agreed behaviour and is recorded as a **v1.7
  candidate**; the register is contract-bound and is not restructured from a note.
  Neither prose document was amended.
- **Order `00016059` is still not resent** — the only end-to-end proof of
  [OI-287](../items/OI-287%20The%20Mexal%20line%20discount%20is%20sent%20as%20a%20line%20total%20instead%20of%20per%20unit.md).
- **`prettier:verify` was not run** (not executable in this environment, as on
  previous runs).

## Still unreachable

Named precisely enough to ask someone for them:

- **How many Locali rows have no Mexal code**, and what becomes of them
  ([OI-333](../items/OI-333%20Locali%20without%20a%20Mexal%20customer%20code%20will%20not%20be%20loaded.md)).
- **Whether `Referenti_V2` actually carries the Mexal account code** — the client's
  own question, _"Potete verificare?"_, unanswered
  ([OI-290](../items/OI-290%20Lead%20and%20Referenti%20migration%20data%20is%20owed%20by%20the%20client.md)).
- **The seven-agent code list** that the account import depends on; it is cited by
  Aurel Mrruku and is in no repository artifact
  ([OI-332](../items/OI-332%20The%20account%20import%20keys%20on%20the%20Salesforce%20agent%20code%20and%20the%20client%20file%20is%20mis-coded.md)).
- **When Andrea fixes the production Anticipay endpoint**, and which domain the
  client owes ([OI-312](../items/OI-312%20Anticipay%20times%20out%20in%20production.md),
  [OI-323](../items/OI-323%20The%20production%20domain%20has%20not%20been%20supplied%20by%20the%20client.md)).
- **How many signature fields the quote PDF should carry, and what `allegato B`
  is** ([OI-336](../items/OI-336%20The%20quote%20PDF%20allegato%20B%20has%20no%20signature%20field.md)).
- **The chosen Mexal sync frequency**, and who schedules the jobs in Prod
  ([OI-334](../items/OI-334%20The%20Mexal%20sync%20frequency%20is%20undecided%20and%20no%20job%20is%20scheduled%20in%20production.md),
  [OI-301](../items/OI-301%20Three%20production%20manual%20setup%20steps%20are%20outstanding.md)).
- **Whether the tutor users are created before or after training** — Elena Spini's
  own question ([OI-300](../items/OI-300%20Tutor%20training%20and%20tutor%20test%20access%20are%20unplanned.md)).
- **Who owns the invoice numerator change**, and by when.
- **Where the Pienissimo 360 insoluti figure comes from**
  ([OI-335](../items/OI-335%20A%20Pienissimo%20360%20test%20page%20showed%20management%20280000%20euro%20of%20insoluti.md)).
- **Whether Pienissimo confirmed R0 by 05/11**, and what Fabrizio Paganelli answers
  on OP-2 — due tomorrow, with a meeting at 12:00-12:30.
- **How the production test orders can be deleted**
  ([OI-315](../items/OI-315%20Production%20test%20records%20cannot%20be%20deleted.md)), and
  how many events and editions were rebuilt by hand
  ([OI-320](../items/OI-320%20Event%20and%20Edizione%20mappings%20cannot%20be%20moved%20between%20orgs.md)).
- **When the full order sync will run** (five hours,
  [OI-321](../items/OI-321%20The%20full%20order%20synchronisation%20to%20Mexal%20has%20not%20been%20run.md)).
- **Whether Pienissimo holds a Zoho contract past 31 October** — **fourteenth run**,
  four days after the expiry date, and no source has mentioned it.
- **The twelve `PLUS_B` values** (third day) and the picklist workbook
  (thirteenth day, [OI-265](../items/OI-265%20Opportunity%20Categoria%20and%20Sottocategoria%20values%20do%20not%20match%20the%20client%20registry.md)
  unmoved).
- **What `lead-web-to-lead (2).html` is**, and whether the `Agente` Apex grants are
  deployed and who asked for them.

## Written back

- **1 meeting note**: [2026-11-04 Continuazione Test e2e PROD](../meetings/2026-11-04%20Continuazione%20Test%20e2e%20PROD.md),
  plus the preserved transcript `meetings/2026-11-04-continuazione-test-e2e-prod-transcript.it.md` (75 KB).
- **8 new item notes**: OI-329 → OI-336.
- **10 notes updated** (`updated:` bumped): OI-205, OI-290, OI-300, OI-306
  (**status → `resolved`**), OI-310, OI-311, OI-312, OI-313, OI-314, and the new
  meeting note's inbound links.
- **MAP.md** — new nightly entry at the top, `Last updated` chain extended.
- **INDEX.md** — eight item rows, one meeting row.
- **`meetings/open-items.md` and `.it.md`** — 8 new rows each (#329-#336) and
  **9 regenerated rows** each (#205, #290, #300, #306, #310, #311, #312, #313,
  #314).
- **`meetings/DEVELOPMENT-RECAP.md` and `.it.md`** — new **§77** in both.
- **This trace**, and a `JOURNAL.md` entry.
- **Register untouched — v1.6.**
