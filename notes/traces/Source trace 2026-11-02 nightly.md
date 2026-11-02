---
id: trace-2026-11-02-nightly
type: reference
status: active
updated: 2026-11-02
watermark_used: 2026-10-30T22:00Z
external_watermark: 2026-11-02T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-11-02 nightly

**Watermark for the next `requirements-check` run: 2026-11-02T22:00Z, single
value.**

**Watermark used: 2026-10-30T22:00Z**, the `external_watermark` stated by
[the 30/10 nightly trace](Source%20trace%202026-10-30%20nightly.md), selected by
`updated:` frontmatter. Scheduled nightly run, executed 2026-11-02 ~21:50Z.
**Three days** — 🔑 **no run took place on 31 October or 1 November**, a Saturday
and a Sunday, so this sweep covers both and the two external sources that moved
did so on Monday alone.

🔑 **The headline: the meeting everything had been deferred to delivered, and it
turned an unbudgeted requirement into the first release of a priced Fase 2 — whose
offer appeared in Drive the same morning, carrying a 13 November approval deadline
and no maintenance line.**

🟢 **Environment note.** The clone opened on `main` (two commits, config only) with
none of the knowledge layer in the working tree; `DevMain` did not exist locally and
was created with `git checkout DevMain` against the fetched remote branch.
**Twenty-seven runs, same opening pattern.**

## Sources searched

| Source | Query / scope | Result |
| ------ | ------------- | ------ |
| **Gmail** | `pienissimo after:2026/10/30 -in:draft`, 50 requested, 12 estimated | 🔑 **Only two new messages**, both 02/11: **`Codici prodotto PPLUS solo Bundle`** (09:31:40Z) and the **Meet records notification** for the Tema Contratti session (09:26:43Z). Nothing on 31/10 or 01/11 |
| **Gmail** | `get_message 1a19b99ad8a32714` (PLAIN_TEXT) | 🟢🔑 **The twelve PPLUS bundle-only codes are created** — _"Se vuoi puoi già importare. **Non dovremmo creare nuovi codici prodotto.**"_ → [OI-48](../items/OI-48%20Bundle-only%20article%20codes.md). ⚠ One attachment, `image001.png`, a signature image; **no code values in the body and none asked for** |
| **Gmail** | `get_message 1a19b9520ec24d99` (PLAIN_TEXT) | Meet records for `Tema Contratti WooCommerce`; ⚠ **no Drive link survives in the plain-text body**, so the artifacts were found by Drive search |
| **Gmail** | `(from/to/cc:pienissimo.com OR kreosoft.com) after:2026/10/30`, `THREAD_VIEW_SUMMARY` | 6 threads, **newest message per thread checked**. The long `Import Ordini` thread (21 messages) ends at **30/10 08:16Z**, already held — **no new client mail on the migration** |
| **Drive** | `title contains 'Contratti WooCommerce'` | Meeting folder `1fvoUsgX_WkPMuK5jsVaZavaLiDAej1kf` and a **shortcut only**. ⚠ **No Gemini "Appunti" document and no recording file exist for this session** — the transcript is the only artifact, which is the reverse of the usual pattern |
| **Drive** | `title contains 'Tema Contratti' and mimeType = document` | 🟢🔑 **The transcript target**, `147VwRARVI2tmLcmVnyE7hmBHaYvA7MhrF4P44mhYYn0`, 33,836 bytes, owner `e.spini@romicompany.com` |
| **Drive** | `read_file_content` on it, **48,601 chars** | 🟢🔑 **Too large to return; written to scratch and read in four slices with python. Read once, in order, in full.** → [the meeting note](../meetings/2026-11-02%20Tema%20Contratti%20WooCommerce.md) and `meetings/2026-11-02-tema-contratti-woocommerce-transcript.it.md` |
| **Drive** | `modifiedTime > '2026-10-30T22:00:00Z'`, 2 pages | ⚠ **The filter was not honoured again** and returned older files; triaged by hand, **second run**. 🆕🔑 **Two Pienissimo documents**: `Pienissimo Offerta Fase 2` (`1T1gExUUq4...`, **Andrea Galotto**, created 09:21:44Z, modified 14:45:47Z) and `Pienissimo_Project_Plan_Fase2` (`1b329SMXkc...`, Elena Spini, modified 09:40:40Z). Everything else belongs to other clients — **VFL1 / Via Fratelli Lombardi, Vision, 247, Daze, IUAD / Eduarth** — and was discarded per the skill |
| **Drive** | `read_file_content` on both decks | 🔑 **The densest source of the night after the transcript** → [the Fase 2 offer](../The%20Fase%202%20offer.md). **No euro figure transcribed beyond the stated total and payment terms; no catalogue price anywhere** |
| **Slack** | `slack_read_channel C0B5T3RB4FM` (`#tproj-pienissimo`), `oldest` 1793397600 | **0 messages.** 🔴 **Silent again** after its 30/10 status post |
| **Slack** | `slack_read_channel D0B5QHS2T7H` (Elena Spini DM), same bound | 🔑 **14 messages, all 02/11, all around the call.** 09:41 _"va bene tutto ma non ora / fase 2 / come prima cosa no?"_ → Aurel Mrruku _"OK / si"_ · 10:03 🔑 **the R0 sizing**: _"metto 6gg?"_ → _"si"_ → _"6-7gg??"_ → _"si"_ · 10:07 _"domani sera lo vediamo al nostro allineamento"_. ⚠ 09:01 _"hai mai integrato **Fatture in Cloud (TeamSystem)**"_ → _"no"_ — **not written into any note: this DM carries several projects and nothing ties it to Pienissimo, which runs on Mexal** |
| **Slack** | `slack_read_channel C0C38JJ9D1T` (marketing group DM), same bound | 🟢 **13 messages — it broke a long silence.** Fabrizio Mastracci _"ho quasi terminato"_, promises a written recap of the flow's logic, and 🔴 **needs 4-5 clean records** → [OI-311](../items/OI-311%20The%20marketing%20flow%20update%20needs%20clean%20test%20records.md). 🟢 Elena Spini confirms **client test orders tomorrow** and the single pre-go-live import |
| **Slack** | `slack_read_channel C0BQD34LLF4` (dev group), same bound | **1 message — this sweep's own 30/10 report** (23:12:40 CET). 🔴 **No human reply, and no human message in the channel since** |
| **Slack** | `slack_read_canvas F0BD2H5A9HT` (`Link utili Pienissimo`) | **Unchanged.** Newest entry still 20.08.2026 — **74 days**. Re-read per the skill |
| **Fathom** | `list_meetings created_after 2026-10-30T22:00Z`, 3 pages | **1 meeting, and it is another client** — `Touchbase - tasks to fix`, Tiziana Petruzzi / `247.it`. 🔴 **No Pienissimo meeting, a thirtieth consecutive run**, on a day with a recorded client call |
| **Git** | `fetch origin`, `log --all --since 2026-10-30T22:00:00Z`, `for-each-ref` | 🟢🔑 **`DevMain` moved** — **`d4c2082`** _"fix discount uat and prod"_ (Aurel Mrruku, 02/11 17:48:57 CET). 🟢 **`DevAnita30` moved** — **`b0e69c5`** (Anita Aga, 02/11 14:21:04 CET). `UAT` `8f039ce` and `Prod` `7905945` **unchanged since 29 October** |
| **Repo** | `git show d4c2082` | 🟢🔑 **OI-287 is committed**: the `* Quantity` is gone from `resolveLineDiscount`, the comment cites Mirko Merendi and the UAT `6001` rejection, and the test expects `-50,25` |
| **Repo** | `git show b0e69c5` on five files | 🟢 **`MexalCustomerCreateService` now logs and returns the failure** ([OI-296](../items/OI-296%20Account%20creation%20to%20Mexal%20failed%20in%20UAT%20and%20account%20send%20was%20switched%20off.md)) · 🆕 `Azienda_Precedente__c` lookup filter to record type `Azienda` · 🔴 **the `Agente` permission set and profile changed both ways** → [the permission note](../objects/The%20Agente%20permission%20set%20gained%20Mexal%20and%20Anticipay%20access.md) |
| **Repo** | `ls notes/items` max-id scan | Max existing id **308**, so this run allocated **309**–**311**; next free is **312** |
| **Repo** | journal head, `notes/traces` frontmatter scan | 🔑 **An off-schedule session ran on 02/11** before this sweep — the OI-287 fix and its UAT/Prod deploys. Its journal entry said _"Not committed"_; the commit followed at 17:48 |

## Found

1. 🟢🔑 **[The 2 November Tema Contratti WooCommerce call](../meetings/2026-11-02%20Tema%20Contratti%20WooCommerce.md)
   delivered a design, and it is the only Pienissimo meeting in the window.** 09:32
   CET, **00:49:50**, Aurel Mrruku, Elena Spini, Elisa Migliano, Fabrizio Paganelli;
   🔴 **Sabatino Rinaldi absent.** The contract goes out **on the Mexal order id**,
   from **a second PDF template pointing at the Order instead of the Quote**, with
   🆕 **a resend button visible only after a failure**. Order statuses untouched.
   🟢 The payment-timing question was closed by Elisa Migliano — WooCommerce
   forwards only `completato` orders, _"Se ti passa [a Mexal] vuol dire che il
   cliente ha già pagato"_.
2. 🟢🔑 **The Performance Plus tranche problem was routed around rather than
   solved, and it costs ROMI nothing.** The bundle component will not be changed;
   Fabrizio Paganelli mints **twelve bundle-only Plus codes, one per tranche, none
   carrying a tranche count**, and Aurel Mrruku verified **live on screen** against
   the existing **`PLUS_B01`** that a bundle-true product is already excluded from
   the standard Plus offer: _"quindi siamo già coperti"_. 🟢 **The twelve codes were
   created the same morning** and the client says the registry needs nothing more.
3. 🔴🔑 **The stage-sale contract flow is now Fase 2 R0 — the first time the
   26 October margin ruling has been applied to anything, and the first time it was
   said to the client.** Elena Spini: _"questo però deve passare come primo rilascio
   della fase due … Noi abbiamo già finito tutte le giornate possibili
   immaginabili."_ Sized at **6-7 days** in Slack during the call and **5-7** in both
   decks → [the decision](../decisions/Decision%20-%20stage%20sale%20contracts%20are%20release%20R0%20of%20Fase%202.md).
4. ⚠🔑 **The scope the client agreed to may be narrower than the scope priced.**
   Fabrizio Paganelli: _"Sono d'accordo che lo devi aggiungere **solo per la parte
   della Plus corsi**"_; both decks price R0 for standard courses **and**
   Performance Plus. **Nobody raised it on the call and nothing records it since.**
5. 🔴🔑 **The two mechanisms the 30 October decision rested on were never mentioned
   again.** The signature gate was replaced by a **status flag** and a **chasing
   report**; fifty minutes of design discussion did not come back to either. Still
   no field name, no report owner, no cadence — and it is now the largest
   unaddressed piece of [OI-304](../items/OI-304%20Contracts%20for%20WooCommerce%20stage%20sales%20are%20not%20generated.md).
6. 🟢🔑 **The Fase 2 offer exists** — `Pienissimo Offerta Fase 2`, **Andrea
   Galotto**, created 09:21Z — beside a project plan updated at 09:40Z:
   [the offer](../The%20Fase%202%20offer.md). **Six releases to 26/03/2027.**
   🆕🔑 **Fase 1's dates are client-facing for the first time** — _"go-live tecnico
   09/11, migrazione dati 12-13/11, avvio operativo su Salesforce 16/11"_ — and
   🆕🔑 **a deadline nobody here had: _"Approvazione Fase 2 entro il 13/11"_**, the
   same morning as the handover. 🆕 **Pienissimo Live 24-26/11**, Academy 19-21/01,
   Camerieri e Venditori 06/04.
7. 🔴🔑 **The two decks disagree on the day count by a factor of two** —
   `150 giornate` in the offer against `58 - 78` in the plan. Both touched the same
   day, both client-facing. ⚠ **No reading is asserted; the figures are recorded as
   they stand.**
8. 🔴🔑 **[OI-308](../items/OI-308%20Fase%202%20maintenance%20was%20left%20out%20of%20the%20estimate.md)
   got worse, not better.** Neither document prices maintenance — the offer's only
   recurring commitment is _"un mese di supporto post go-live"_ per release — and on
   the same day **Elena Spini told the client it is in the proposal** while **Aurel
   Mrruku sized it at _"quei 8 ora al mese"_**, against the **three to four days a
   month** he wrote on 30 October. ⚠ **The client has heard the lower figure.**
9. 🟢🔑 **[OI-287](../items/OI-287%20The%20Mexal%20line%20discount%20is%20sent%20as%20a%20line%20total%20instead%20of%20per%20unit.md)
   is fixed, deployed to UAT and production, and committed** as `d4c2082`. 🔑 **Mexal
   settled it** — order `00016059` at quantity 4 was rejected, _"6001 - Il valore
   dello sconto supera il prezzo unitario"_. 🟢 **No production order was affected.**
   🔴 **The order has not been resent**, which is the only end-to-end proof, and
   ⚠ **`schedulerRegistersTheNightlyJob` will fail in production the moment
   [OI-301](../items/OI-301%20Three%20production%20manual%20setup%20steps%20are%20outstanding.md)'s
   nightly jobs are scheduled.**
10. 🆕🔑 **New: [OI-309](../items/OI-309%20The%20product%20activation%20criterion%20must%20switch%20from%20gruppo%20merceologico%20to%20the%20Mexal%20flag.md)**
    — Salesforce reads **`gruppo merceologico`**, not Mexal's `annullato` flag, in
    UAT **and production**, as a first-load arrangement nobody had written down. The
    switch is **a production release, not a setting**, and **Fabrizio Paganelli owes
    the date** — he offered **1 February 2027** and disclaimed it as _"una data a
    caso"_ in the same breath.
11. 🆕 **New: [OI-310](../items/OI-310%20The%20production%20load%20needs%20a%20pre-load%20and%20a%20delta%20run.md)**
    — a full load costs **3-4 hours**, so the product registry, accounts and
    contacts move earlier and **12-13 November becomes a delta**. 🟢 It is the
    de-risking the two-stage plan was dropped for. ⚠ **The advance interface file
    has no date** — _"mercoledì, giovedì o lunedì prossimo"_ — and **no rollback is
    recorded**, for either pass.
12. 🆕 **New: [OI-311](../items/OI-311%20The%20marketing%20flow%20update%20needs%20clean%20test%20records.md)**
    — Fabrizio Mastracci has _"quasi terminato"_ his flow update and is **blocked on
    4-5 clean records**; the only data on offer is **tomorrow's client test orders,
    in production against a live Mexal**. 🟢 He promises **a written recap of the
    flow's logic**, the first anyone has offered. ⚠ **Which flow was not stated and
    is marked uncertain.**
13. 🔴🔑 **The Referenti tracciato missed its 2 November date — a fourth consecutive
    record — and Aurel Mrruku did not know.** He believed everything had arrived;
    **Elena Spini corrected him on the call**: _"I lead li ha mandati, i referenti
    mancano."_ 🔑 **And the Lead file delivered on 29 October is still not loaded
    into production**: _"però gli devo caricare in produzione adesso."_ 🆕 New date
    **Wednesday 4 November 09:00-09:30**, promised by **Fabrizio Paganelli for an
    absent Sabatino Rinaldi**; 🆕 **a second, later extract is now expected.**
14. 🟢🔑 **Licences are answered: twelve in total**, allocation walked on screen —
    7 commerciale/tutor · 1 amministrazione · 1 marketing · 1 PL = **11**, with
    **one of the two left being ROMI's own** working licence. 🔴 **Demand already
    exceeds supply and the answer was to share accounts**: Giordano on the PL
    licence, Rebecca probably marketing. ⚠ **Elisa Migliano objected and was not
    answered** — the shared-account pattern
    [OI-300](../items/OI-300%20Tutor%20training%20and%20tutor%20test%20access%20are%20unplanned.md)
    refused in substance five days earlier. 🔑 Six of the seven commerciali are
    named; ⚠ **it is a licence allocation, not a tutor headcount**, which is still
    unknown.
15. 🔴🔑 **The `Agente` permission set changed in both directions on a branch with
    no PR** — `b0e69c5`. It **gains** Apex access to `MexalCustomerCreateService`
    and `AnticipayAccountService`, both external-credential principals and read on
    `UserExternalCredential`, so **a salesperson's own click can now reach Mexal and
    Anticipay** — which **no meeting, mail or message asked for**. It **loses**
    editability on `Account.Agente__c`, `Opportunity.Categoria__c`,
    `Sottocategoria__c` and five UTM fields. ⚠ **Locking `Categoria__c` points the
    opposite way from OI-265**, unmoved an eleventh day. 🔴 **The client's
    permissions walk is tomorrow and the org does not hold this.**
16. 🟢 **The Mexal account-create failure is now logged instead of lost** —
    `b0e69c5` wraps it in a `try`, inserts an `Integration_Log__c` row and returns
    the failure with its log id rather than rethrowing, _"an unhandled exception
    would roll back the error log along with the action's transaction"_. 🔴 **In no
    org**, and account send is still off in UAT.
17. 🔑 **A domain rule stated for the first time: there are no mixed bundles.**
    _"in un bundle c'è solo la P+ … oppure ci sono solo i corsi, non facciamo bundle
    misti."_ Said forcefully enough to be treated as settled.
18. 🟢 **The 30/10 question of which 09:30 Monday meeting Aurel Mrruku attended is
    answered**: the Tema Contratti one, not the `Allineamento` with Fabrizio
    Mastracci.
19. ⚠ **Items ROMI had ruled on internally are now written into a client
    document, which is the only place the client could read them.**
    [OI-269](../items/OI-269%20Event%20communications%20must%20be%20differentiated%20by%20ticket%20type.md)
    is R1's _"Comunicazioni mirate"_ at 15/01/2027;
    [OI-272](../items/OI-272%20A%20standard%20contract%20expiry%20alert%20rule%20is%20requested.md)
    gains its **first specification** — tutor and referring salesperson, **15-30
    days before expiry** — in R5 at 26/03. 🔴 **Nobody has said either out loud, and
    the deck's approval deadline is 13/11.**
20. 🔴 **The Ri.Ba. territory is priced into Fase 2 R2 at 12 February 2027 while
    [OI-212](../items/OI-212%20A%20Ri.Ba.%20rate%20reads%20as%20paid%20before%20its%20due%20date.md)
    is still an unfixed defect in production** — twenty-first night. ⚠ R2 covers
    _insoluti_ and _variazioni di scadenziario_, which is **adjacent to but not the
    same as** a rate reading paid before its due date. **Nothing says whether the
    defect is in or out.**

## The register

⚠ **Nothing found tonight calls for a register change, and nothing was changed.**
Version stays **1.6**; `go_live: 2026-11-16` unchanged and now corroborated by a
client-facing document, which also names **09/11** as the technical go-live.

🔴 **`SAL-12` was not amended and is now uncited for a twelfth session.** ⚠
**`DM-07`'s competitor-list conflict is unchanged.**

🔑 **The absences remain findings, and three new ones join tonight.** No register row
covers **contract generation for WooCommerce orders** (OI-304, now R0 of a priced
phase), the **order-to-Mexal price breakdown** (OI-284/OI-287), **ticket migration**
(OI-274), **Lead or Contact migration** (OI-290, with OI-295 and OI-307 inside it),
**note capture** (OI-292), **template editability**, **a client-side run of the
invoice and incassi jobs** (OI-294), **bundle picklist content** (OI-299), **tutor
training** (OI-300), **WooCommerce customer identity** (OI-302), **the Mexal order
header note** (OI-306), **duplicate-rule handling for migration** (OI-307),
**Fase 2 maintenance** (OI-308), 🆕 **the product-activation criterion** (OI-309),
🆕 **the migration pre-load** (OI-310) or 🆕 **marketing-flow test data** (OI-311).

⚠ **The Italian wording in `REQUISITI.it.md` still needs a human's eye** —
unchanged, eleven runs on.

## Corrections to the record

- 🔑 **The 30/10 reading that the Performance Plus bundle-tranche logic "may not
  exist" is settled: it does not, and it will not be built.** The twelve codes
  replace it. Both dates cited on OI-304.
- 🔑 **The 30/10 ambiguity about the two 09:30 invitations is resolved** — Aurel
  Mrruku attended Tema Contratti WooCommerce. The `Allineamento` with Fabrizio
  Mastracci does not appear in any artifact this sweep.
- 🔑 **"Maintenance was omitted from the estimate" is now stronger than it was.**
  The 30/10 record had one document; there are now two, both client-facing, and a
  verbal assurance to the client that contradicts both.
- 🔑 **OI-287's "the project is being told it is closed" is retired.** The code now
  matches the announcement. What replaces it is narrower: **no Mexal document has
  yet been produced with the corrected discount.**
- ⚠ **The 29/10-30/10 reading that the Lead half of the migration data was
  "delivered" needs qualifying**: the file exists and has been checked, but **it is
  loaded nowhere**, and a fresher extract is now expected to supersede it.
- ⚠ **`gruppo merceologico`, not `annullato`, is what production reads.** No earlier
  note states the criterion at all; this is new information about already-released
  behaviour, not a reversal.
- 🔴 **The pre-existing defects are unchanged**: rows **163-174 remain duplicated**
  in `meetings/open-items.md` **and** `.it.md` with the copies still differing; the
  **Risks table in `INDEX.md` is still malformed**; row `| 83  |` is still padded;
  **both `DEVELOPMENT-RECAP` files still carry a precedence line ending at §45**
  while they now end at **§75** — eighth run flagged, still an editorial ruling
  rather than a mechanical edit.
- ⚠ **`INDEX.md` trace rows**: the 23/10, 26/10, 27/10 and 28/10 gaps flagged on
  29/10 and 30/10 **were not backfilled**; tonight's row was added. Third run
  flagged.
- ⚠ **`JOURNAL.md` holds ~142 entries against the protocol's "keep the twenty most
  recent"**, and is ~432 KB. **Seventh run to flag it.**
- ⚠ **`MAP.md` still carries two `## Where the project stands` headings**;
  tonight's entry went into the **first**, which is the live block. **`AGENTS.md`
  still calls it _"under 5 KB"_** against ~330 KB.
- ⚠ **The Drive `modifiedTime` filter was not honoured** by the search tool for a
  second run and returned older files; the result set was triaged by hand.

## Not done in this run

- The org was **not** opened. `STATUS.md` was not regenerated and the Notion mirror
  stays stale. 🔑 **What it would settle tonight**: whether the `Agente` permission
  changes of `b0e69c5` are in any org, whether the twelve `PLUS_B` codes have
  reached `Product2`, whether order `00016059` can be resent, whether the WooCommerce
  list view of OI-298 exists, whether `Asset.QR_Id__c` can be created in Prod
  (OI-289, **no further failure notification arrived**), what `a05MA00000GqqcPYAR`
  says, whether OI-301's three manual steps are done, whether the nightly Mexal jobs
  are scheduled, and whether account send is back on in UAT.
- **No Apex test was written, proposed or scaffolded**, per the standing instruction.
  [OI-64](../items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md),
  [OI-66](../items/OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md) and
  [the deploy risk](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md)
  are unchanged; the risk stays `resolved`.
- **OI-212 was not fixed**, a twenty-first night, in production.
- **`DevAnita30` still has no PR and none was opened** — reporting only; opening one
  is not this run's to do.
- **The twelve `PLUS_B` code values were not requested from the client**, and the
  `image001.png` attachment on that mail was not opened.
- **`Referenti Salesforce_V2.xlsx`, the Lead CSV and `lead-da-importare.xlsx`,
  `Utenti Area Commerciale.xlsx`, `Contatti_Zoho_CRM_`, `Account Salesforce_V2.xlsx`,
  `Categorie Prodotto.xlsx` and the OI-265 picklist workbook were not opened** — real
  customer, contact or staff records. **Eleventh day for the picklist workbook;
  OI-265 unmoved.**
- **The 380 MB Import Ordini recording of 28/10 was still not opened** — no tool here
  reads an MP4. **Fourth night.**
- **No `meetings/results/` recap was written** for the 02/11 session, as on every
  nightly run since September; the drill lives in `notes/meetings/` and in the two
  trackers.
- **The `DEVELOPMENT-RECAP` precedence headers, the `INDEX.md` Risks table, the
  duplicated tracker rows and the four missing trace rows were not repaired.**
- **`prettier:verify` was not run** (no `node_modules`); `vault:check` is
  dependency-free and was.

## Still unreachable

🆕 **Whether the blueprint addendum for R0 reaches the client on 4 November, and
whether they confirm it** · 🆕 **what the R0 status flag and chasing report are to
be** — still the largest gap in OI-304 · 🆕 **whether R0 is contingent on the
13 November Fase 2 approval**, which falls before its build window · 🆕 **which
Fase 2 day count is real, 150 or 58-78** · 🆕 **whether the maintenance line will be
added before 13 November, and at eight hours or three to four days a month** ·
🆕 **whether Fabrizio Paganelli's agreement covers Performance Plus or only the
courses** · 🆕 **whether Performance Plus will be sold at Pienissimo Live at all** —
_"lo scopriremo il 24 di novembre la mattina"_ · 🆕 **the twelve `PLUS_B` code
values, and whether they and the ten `SF` codes are one scheme or two** · 🆕 **the
date Fabrizio Paganelli owes for the `annullato` switch** · 🆕 **when the refreshed
interface file arrives** · 🆕 **who supplies Fabrizio Mastracci's clean records, and
which flow he has rebuilt** · 🆕 **whether the `Agente` permission changes are in any
org before tomorrow's permissions walk, and who sets `Account.Agente__c` now that
agents cannot** · 🆕 **whether `Referenti Salesforce_V2.xlsx` is wrong, incomplete or
simply not the tracciato** — four records on · 🆕 **whether the 12 licences are
assigned, and whether sharing the PL and marketing accounts is acceptable to anyone
but the person who proposed it** · **whether the WooCommerce list view was built** ·
**whether the partita IVA matching change was coded** · **how many orders the 30-day
opportunity cookie mis-attributed** · **whether Anticipay answers in production, and
whether San Marino is a sandbox configuration or a coverage gap** · **how many tutors
there are** · **whether test access is needed for every agent in `Utenti Area
Commerciale.xlsx`** · **who re-enables the Lead duplicate rules after the import** ·
**whether Elena Spini took the maintenance line back to Andrea Galotto** ·
**whether "Giuliano" is G Lanzetti's first name** · **whether the Performance Plus
per-tranche line logic exists** — 🔑 **now answered: it does not, and the twelve codes
replace it** · **what the 13 November rollback plan is** · **whether `Asset.QR_Id__c`
can simply be created in Prod** · **what `a05MA00000GqqcPYAR` says** · **whether
account sending to Mexal is back on in UAT** · **whether UAT stops writing to the
same Mexal company as production** · **whether the three unticked production manual
steps are genuinely undone**, and **whether `QuoteNegotiationAgingBatch` was
restored** · **whether the historical data load has been run in production at all** ·
**what was actually said in the 28/10 14:07 call** — 57 minutes, 380 MB, no
transcript · **what `ID riga Mexal` was agreed to mean** · **who
`cdg@pienissimo.com` is** · **whether the Salesforce My Domain was changed to
`pienissimo`** · **which org the three sharing-default changes were made in** · **what
should replace the calendar years in `Anno Accademico`, and which `Bundle Type`
values to add** · **whether the OLD edizione links get deleted or deactivated** ·
**whether Mexal's accounting-year archive behaves as the code assumes** — never put
to Kreosoft · **whether the production file will arrive with the `610.00001`
transformation already applied** · **whether the retired agent codes are in the
delivered list** · **what the Categoria Prodotto description inconsistencies are** ·
**whether the product synchronisation flows are actually on** · **what _"template
completamente personalizzabili"_ means** · **who inherits `Devmain_LeadChecks` and
`Devmain_QuoteTriggerChanges`** · **who Claudio is** · **how many commitments sit in
the Zoho tutor calendars, and who re-enters them** · what Mexal does with a `sconto`
on a quantity-above-one line in a **successful** document — the one measurement that
would close OI-287 · how many Azienda accounts have a blank `Agente__c` · what happens
to the data-model fields Zoho cannot fill · whether Gianpaolo Motta's Fase 2 ruling
will be said to the client in full · whether the client accepts the Change Request
regime (**ninth day of silence**) · which profile the UAT user `005MA00000Gh60y`
holds · where the `rinunciato` asset write lives · which of the three dummy-edizione
mechanisms is the one · who reverses the whole-catalogue activation, and when · how
many credit notes leave the 2024 history · the contents of the picklist workbook ·
whether the ~80 live Performance Plus contracts are migrated, hand-entered or
abandoned · whether the client's lawyer permits the legal-representative fields · the
client's ticket field/value structure (undertaken 21/10, **twelve days**) · what
`Pienissimo 360` is · 🔴 **whether Pienissimo hold a Zoho contract past 31 October**
(**thirteenth run — the date has now passed and no source mentions it**) · which four
`Dettaglio Motivazione Uscita` values OI-259 means · whether a contract-expiry alert
rule exists in the org (OI-272) · which production user is to be copied for the
marketing tests · what _"utente metà bloccato"_ means for WhatsApp · whether Sabatino
Rinaldi's user exists · what Fabrizio Mastracci's _"nuova change request"_ referred
to · the 30/07 marketing notes `1uJCE4NW9nbdI38ADmt66svUT1MRmkyYd24uI0hegAD0` · Zoom
tier · training hours · the Woo instance · DocuSign prod config · `Get Campaign` and
the campaign-ID gap · Jira `PIEN` · `Flows & Objects.drawio` · the _diretta_ form.
