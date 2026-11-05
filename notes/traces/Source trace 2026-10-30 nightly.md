---
id: trace-2026-10-30-nightly
type: reference
status: active
updated: 2026-10-30
watermark_used: 2026-10-29T22:00Z
external_watermark: 2026-10-30T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-10-30 nightly

**Watermark for the next `requirements-check` run: 2026-10-30T22:00Z, single
value.**

**Watermark used: 2026-10-29T22:00Z**, the `external_watermark` stated by
[the 29/10 nightly trace](Source%20trace%202026-10-29%20nightly.md), selected by
`updated:` frontmatter. Scheduled nightly run, executed 2026-10-30 ~21:50Z.
**One day.**

🔑 **The densest night of the project so far: two meetings drilled, yesterday's
gating fault withdrawn, `#tproj-pienissimo` broke a long silence with a full
status report, and seven new items opened.**

🟢 **Environment note.** The clone opened on `main` (two commits, config only) with
none of the knowledge layer in the working tree; `DevMain` did not exist locally and
was created with `git checkout DevMain` against the fetched remote branch.
**Twenty-six runs, same opening pattern.**

## Sources searched

| Source | Query / scope | Result |
| ------ | ------------- | ------ |
| **Gmail** | `pienissimo after:2026/10/29 -in:draft`, 50 requested, 15 estimated | 🔑 **Nine new messages.** New threads: **`Campo Note di Testata su Ordine`** (2 msgs, 15:11/15:15Z) · the **`Connessione WooCommerce` Gemini notes** (15:51Z) · **`Rapido Allineamento` meeting records** (09:33Z) · three **Mon 2 Nov invitations** (15:18–15:21Z) · the **`Test PS Tutor`** update (09:37Z). New messages on **`Trasferimento dati`** (1, 10:02Z) and **`Import Ordini`** (1, 08:16Z) |
| **Gmail** | `get_message 1a18d8250d203e84` (PLAIN_TEXT) | 🔑 **The WooCommerce call's Gemini summary** — five agreed changes and nine next steps → [the meeting note](../meetings/2026-10-30%20Connessione%20WooCommerce.md) |
| **Gmail** | `get_message 1a18c4325074df92` (PLAIN_TEXT) | 🟢🔑 **Elena Spini answers Marco Montesi on both counts** — training window, and **dedicated profiled users for every tutor** → [OI-300](../items/OI-300%20Tutor%20training%20and%20tutor%20test%20access%20are%20unplanned.md). ⚠ `Utenti Area Commerciale.xlsx` **not opened** (staff records); a new question goes back to the client inside it |
| **Gmail** | `get_message 1a18be1a3980c8bd` (PLAIN_TEXT) | 🔴🔑 **"rimaniamo in attesa del tracciato dei referenti/contatti"** → [OI-290](../items/OI-290%20Lead%20and%20Referenti%20migration%20data%20is%20owed%20by%20the%20client.md). **Corrects the 29/10 record** |
| **Gmail** | `get_message 1a18d62bf46e4358` (PLAIN_TEXT) | 🔑 **Kreosoft names the field in four minutes**: the Mexal order header note is **`nota`** lato API → [OI-306](../items/OI-306%20The%20WooCommerce%20order%20number%20must%20reach%20Mexal%20in%20the%20order%20header%20note.md) |
| **Gmail** | thread listing `1a182dd5f59d7d43` | ⚠🔑 **Aurel Mrruku sent WooCommerce connection documentation _with credentials_** at **14:00:57Z** to Elena Spini, cc Sabatino Rinaldi — _"Allego qui la documentazione con ele credenziali da usare"_, 232,618 B. **Recorded as having happened; no value copied anywhere** |
| **Drive** | `modifiedTime > '2026-10-29T22:00:00Z'`, 2 pages | ⚠ **The filter returned files outside it** (29/10 and earlier), so the page was triaged by date by hand. **One genuinely new Pienissimo item**: `SALESFORCE recap points to fix` (16:37Z) is **another client** (`tiziana.petruzzi@247.it`) and was discarded. 🆕 **`lead-da-importare.xlsx`** `1M11As2y1bzSAWEAlqDx4qEviuSguSg6Q`, **1,002,783 B**, created 29/10 13:08:02Z — **the corrected attachment, now identified by id**, and **opened by the account holder 30/10 09:23:13Z** |
| **Drive** | `title contains 'Allineamento' or 'WooCommerce' or 'Connessione'` | 🔑 **Two new meeting record sets**, both owned by Elena Spini. ⚠ The Drive entries are **shortcuts** and `read_file_content` returns nothing for them; the targets were found by a second search on `mimeType = document` |
| **Drive** | `read_file_content 1QqwvLMX8XvSq9sXa9ynaG8a-g0JxpYyKNzpQ9bTyiko`, **24,343 B** | 🟢🔑 **The richest single source of the night** → [2026-10-30 Rapido Allineamento](../meetings/2026-10-30%20Rapido%20Allineamento%20Aurel%20Elena.md). Complete, in Italian, 00:27:40 |
| **Drive** | `read_file_content 1g4-BqRteDnAzQ89T7UxUPuFaZyVB3euixAPm6Wa424E`, **84,381 chars** | 🔑 **Too large to return; written to scratch and sliced with python.** The `Riepilogo`, `Decisioni`, `Passaggi successivi` and the whole `Dettagli` section were read; ⚠ **the raw transcript was not read line by line** → [2026-10-30 Connessione WooCommerce](../meetings/2026-10-30%20Connessione%20WooCommerce.md) |
| **Drive** | `parentId` of both meeting folders | Only the shortcuts; no recording file listed for either session |
| **Slack** | `slack_read_channel C0B5T3RB4FM` (`#tproj-pienissimo`), `oldest` 1793311200 | 🟢🔑 **It broke its silence: one long status post, 15:30 CET.** Go-live, the 13/11 single-pass import, the discount logic "closed", the Referenti gap, the Notes ruling, Fase 2 to Andrea G., **margin finito**, 15 days to finish. **The single most informative message of the sweep** |
| **Slack** | `slack_read_channel D0B5QHS2T7H` (Elena Spini DM), same bound | 🟢 **23 messages.** 11:10 Zucchet aside · 15:55–16:13 the WooCommerce call reported live · 🔑 **16:13–16:21 Elena Spini declines the call and the Monday contract slot is set** — _"metti uno slot con fabrizio lunedi mattina"_, _"tema contratti per gli ordini da woocomerce ( cntratti cartacei"_ |
| **Slack** | `slack_read_channel C0BQD34LLF4` (dev group), same bound | **1 message — this sweep's own 29/10 report** (23:05:27 CET). 🔴 **No human reply: fortieth night** |
| **Slack** | `slack_read_channel C0C38JJ9D1T` (marketing group DM), same bound | **0 messages.** Silent |
| **Fathom** | `list_meetings created_after 2026-10-29T22:00Z`, 3 pages | **0 meetings.** 🔴 **Twenty-ninth consecutive run with no Pienissimo meeting**, on a day with two recorded calls |
| **Git** | `fetch origin`, `log --all --since 2026-10-29T22:00:00Z`, `for-each-ref` | 🔑 **A new branch, `DevAnita30`, two commits, and `DevMain` did not move.** `0717486` _"Added field on Lead"_ (15:10:59 CET) · `4fb8092` _"Added a lookup filter on Account ParentId and edited Anno Solare picklist values names"_ (16:47:53). `DevMain` `52ddc4c` · `UAT` `8f039ce` · `Prod` `7905945`, all unchanged |
| **Repo** | `git show` on both commits | 🟢🔑 **`Lead_from_Zoho__c` exists** — checkbox, default false, on the Lead flexipage and the `Agente` + `Full_Permission` sets → [OI-295](../items/OI-295%20Leads%20imported%20from%20Zoho%20must%20be%20distinguishable%20from%20new%20leads.md). 🟡 **`Anno_Solare__c` value _labels_ renamed to `Anno Accademico NNNN`, API names unchanged** → [OI-299](../items/OI-299%20Bundle%20creation%20offers%20the%20wrong%20Anno%20Accademico%20values%20and%20too%20few%20Bundle%20Type%20values.md). 🆕 **`Account.ParentId` lookup filter to record type `Azienda`**; ⚠ **`Codice_Agente__c` and `Origine__c` removed from `Order_Record_Page`** |
| **Repo** | `sed -n '226,238p' MexalOrderSendService.cls`; `git diff DevMain origin/DevAnita30` | 🔴 **[OI-287](../items/OI-287%20The%20Mexal%20line%20discount%20is%20sent%20as%20a%20line%20total%20instead%20of%20per%20unit.md) unchanged, fifth night** — the multiplication by `Quantity` and the comment asserting Mexal divides are both still there, and `DevAnita30` does not touch the class |
| **Repo** | `ls notes/items` max-id scan | Max existing id **301**, so this run allocated **302**–**308**; next free is **309** |
| **Repo** | link-target scan for `G Lanzetti` | 5 references. **Deliberately not renamed** — see below |

## Found

1. 🟢🔑 **[OI-298](../items/OI-298%20WooCommerce%20bundle%20orders%20from%20a%20new%20customer%20do%20not%20reach%20Salesforce.md)
   was never a fault, and withdrawing it is tonight's most important result.** Aurel
   Mrruku opened `a05MA00000GsbhJYAR` on screen: _"**Ha già fatto tutto, ha già
   creato l'ordine**"_, order number read back, status `Ordinato`, dated 29/10. 🔑
   **Three premises of the 29/10 record were wrong** — the order arrived, the
   customer was **not** new (account and contact created 20 October by
   `amministrazione`: _"non è vero perché [Salesforce] non ti lascia mentire"_), and
   there were **four** test orders, not one. 🔑 **The real problem is findability**:
   the client could not locate his own orders, and the remedy — a WooCommerce list
   view on Orders — **is not built.** ⚠ **A populated response body was read as an
   error, escalated as a client-facing fault and carried in these records as gating
   for a day. The cost was one unread field.**
2. 🟢🔑 **`#tproj-pienissimo` published a full status report at 15:30 CET**, after
   long silence, and it is the night's densest source. **Go-live 16/11 confirmed;
   🆕 the final import collapses to a single pass on 13/11** _"perché le prove in UAT
   sono andate bene"_; **15 days to finish, down from 26, the 10 migration days
   absorbed**; 🔴 **_"Margine finito"_ — Gianpaolo Motta, 26/10, everything new goes
   to Fase 2** → [the decision](../decisions/Decision%20-%20new%20scope%20after%2026%20October%20goes%20to%20Fase%202.md).
3. 🔴🔑 **[OI-287](../items/OI-287%20The%20Mexal%20line%20discount%20is%20sent%20as%20a%20line%20total%20instead%20of%20per%20unit.md)
   is now worse than unfixed: the project is being told it is closed.** The same
   recap states _"Il 26/10 con Fabrizio P. e Mirko **abbiamo chiuso la logica degli
   sconti verso Mexal: passano a valore sulla riga, divisi per la quantità**"_ — which
   is exactly what this record has said the requirement is, and **the inverse of
   what the code does**. ⚠ _"Closed"_ may mean the specification rather than the
   implementation; what is not available is a reading in which the shipped
   arithmetic is right. 🔴 **Fifth night, two production releases, and the 30/10 call
   that sent live orders to Mexal never mentioned the discount.**
4. 🔴🔑 **The Referenti tracciato is NOT delivered, and the 29/10 record was wrong.**
   Three sources say so on one day: Elena Spini's 08:16Z mail, the 10:01 call
   (_"**Io ho chiesto i contatti, lui ha mandato i lead**"_), and the 15:30 recap
   (_"il tracciato dei Referenti non è ancora arrivato. Lead ok"_). 🔑 **So
   `Referenti Salesforce_V2.xlsx` is not the deliverable**, and the Lead file met a
   commitment ROMI had not made. **Now promised for 2 November** — eleven days before
   the single-pass import.
5. 🟢🔑 **`Lead_from_Zoho__c` was built** (`0717486`, 15:10 CET) — checkbox, label
   _"Lead from Zoho"_, on the Lead page and two permission sets. 🔑 **Three of
   OI-295's open points close**: checkbox not document field, API name known, sales
   visibility granted. 🔴 **It is on `DevAnita30` and nowhere else**, and ⚠ **nothing
   sets it** — a field that defaults false and is never written is indistinguishable
   from no field.
6. 🆕🔴 **New: [OI-302](../items/OI-302%20WooCommerce%20matches%20customers%20by%20email%20instead%20of%20partita%20IVA.md)**
   — WooCommerce binds orders to accounts by **email**, and one customer can hold
   several premises with different VAT numbers on one email. Agreed to move to
   **partita IVA**; ⚠ no code change is in the repository.
7. 🆕🟢 **New: [OI-303](../items/OI-303%20The%20WooCommerce%20plugin%20kept%20the%20opportunity%20id%20in%20cookies%20for%2030%20days.md)**
   — the plugin held the opportunity id in cookies and sessions for **30 days**
   across completed purchases, so later orders attached to a closed opportunity.
   **Sabatino Rinaldi shipped the fix during the call.** ⚠ No version, no regression
   test, and **thirty days of possibly mis-attributed orders were not swept**.
8. 🆕🔴 **New: [OI-304](../items/OI-304%20Contracts%20for%20WooCommerce%20stage%20sales%20are%20not%20generated.md)**
   — **no contract is generated for stage sales**, and the decision taken is that
   **WooCommerce orders need no prior digital signature**: ~**€20,000** contracts,
   bought on impulse in the classroom, so a status flag and a chasing report replace
   the signature gate. 🔴 **Neither the flag nor the report exists.** Its own meeting
   is **Monday 2 November 09:30**, which ⚠ **clashes with a second 09:30 invite sent
   two minutes apart**.
9. 🆕🔴 **New: [OI-305](../items/OI-305%20Anticipay%20does%20not%20answer%20in%20UAT%20for%20test%20data%20or%20San%20Marino.md)**
   — Anticipay does not answer in UAT for invented data **or for San Marino**, so a
   full test cycle with a genuinely new customer **cannot be run in UAT**. 🔑 The
   workaround is to test with a real existing VAT number, which **removes the very
   path the client has been reporting faults on**. 🔑 San Marino is the client's own
   jurisdiction.
10. 🆕🔑 **New: [OI-306](../items/OI-306%20The%20WooCommerce%20order%20number%20must%20reach%20Mexal%20in%20the%20order%20header%20note.md)**
    — the WooCommerce order number must print on the Mexal document for invoice
    matching. **Kreosoft named the field in four minutes: `nota` lato API.** Sized by
    the client at **half an hour**; not built. ⚠ **And ROMI ruled out free note
    fields on orders forty minutes earlier** — probably a different thing, nobody has
    said so.
11. 🆕🔴 **New: [OI-307](../items/OI-307%20The%20Lead%20import%20needs%20the%20duplicate%20rules%20disabled.md)**
    — the Lead file's masked `XXXXXXXXXXX` VAT placeholders will trip the duplicate
    rules, so Aurel Mrruku will **switch the rules off for the import**. 🔴 **No
    re-enable step exists anywhere**, including the Manual Steps tracker; leaving them
    off through go-live would let the sales team create duplicates freely. 🔑 **And it
    collides with OI-302**, decided five hours later, which makes partita IVA the
    uniqueness key.
12. 🆕🔴 **New: [OI-308](../items/OI-308%20Fase%202%20maintenance%20was%20left%20out%20of%20the%20estimate.md)**
    — **maintenance was omitted from the Fase 2 estimate already sent.** Aurel Mrruku
    expects at least 3–4 days a month and warns a retained day is not priced like
    scattered hours. 🔑 **And it names the Andrea: Andrea Galotto**, who is writing
    the offer. ⚠ Nothing records Elena Spini going back to him.
13. 🟢🔑 **[OI-300](../items/OI-300%20Tutor%20training%20and%20tutor%20test%20access%20are%20unplanned.md)
    is answered on both counts and the shared account is refused in substance** —
    _"Anche gli altri tutor avranno un'utenza dedicata e profilata"_. Permissions walk
    **Tue 3/11 14:30**, Marco Montesi off admin **Wed 4/11**, training 5/11 or the week
    after. 🔴 **Licences unconfirmed** (_"disabilitiamo qualcosa che abbiamo noi"_),
    🔴 **nobody knows how many tutors there are**, and 🔴 **a question is back with the
    client**: must test access be prepared for every agent in `Utenti Area
    Commerciale.xlsx`.
14. 🔴🔑 **Rexhina Hysi is off the project full time** — _"Regina ormai è su un altro
    progetto full time"_ — leaving **Anita Aga as the only developer**, seventeen days
    from go-live. 🔑 **A reassignment, not a departure**, which supersedes the earlier
    "leaving date" reading. 🔴 Her two branches remain unmerged and unowned.
15. 🔑 **The 29/10 invoice bug, in its author's words**: the match was on the
    **scadenza date** from the client's spreadsheet, it hit **about a third of all
    orders**, and he had first blamed the missing contact before reasoning that the
    invoice references the **order line id**. Already on OI-244 by commit; the
    magnitude and the false trail are new.
16. 🔑 **The DocuSign ceiling is a count, not a cost** — _"non è a euro, è con numero
    … hanno 2500 se non mi sbaglio"_ — which retires the _"fino a 10€"_ joke recorded
    on 29/10 as if it were a budget. 🔑 **A signature-free test path exists**:
    `pienissimo rinnovo` and `plus rinnovo` do not fire DocuSign.
17. ⚠🔑 **Credentials were mailed.** Aurel Mrruku sent the WooCommerce connection
    documentation with credentials at **14:00:57Z**. **Recorded that it happened and
    where; no value copied.** 🔑 It is the partial answer to a standing unreachable —
    the Woo production endpoints are now documented somewhere — ⚠ **but the
    production switch still has no date.**
18. ⚠ **A first name for [G Lanzetti](../people/G%20Lanzetti%20-%20CEO%20of%20both%20Pienissimo%20companies.md)
    appeared and was not acted on.** Gemini names _"Giuliano Lanzetti"_ among the
    WooCommerce call's participants. **The note was deliberately not renamed**: the
    same transcripts render Rexhina as _"Regina Ana"_, Anita as _"Anna"_ and Mexal as
    _"Maxal"_, and **no Lanzetti is on the invite**. `uncertain: first name` stands.

## The register

⚠ **Nothing found tonight calls for a register change, and nothing was changed.**
Version stays **1.6**; `go_live: 2026-11-16` is now confirmed by ROMI rather than
proposed by the client, which the register already reflects; `zoho_expiry:
2026-10-31` as earlier runs left it.

🔴 **`SAL-12` was not amended and is now uncited for an eleventh session.** ⚠
**`DM-07`'s competitor-list conflict is unchanged.**

🔑 **The absences remain findings, and five new ones join tonight.** No register row
covers the **order-to-Mexal price breakdown** (OI-284/OI-287), **ticket migration**
(OI-274), **Lead or Contact migration** (OI-290, with OI-295 and OI-307 inside it),
**note capture** (OI-292), **template editability**, **a client-side run of the
invoice and incassi jobs** (OI-294), **bundle picklist content** (OI-299), **tutor
training** (OI-300), 🆕 **WooCommerce customer identity** (OI-302), 🆕 **contract
generation for WooCommerce orders** (OI-304), 🆕 **the Mexal order header note**
(OI-306), 🆕 **duplicate-rule handling for migration** (OI-307) or 🆕 **Fase 2
maintenance** (OI-308).

⚠ **The Italian wording in `REQUISITI.it.md` still needs a human's eye** —
unchanged, ten runs on.

## Corrections to the record

- 🔑 **OI-298 is withdrawn.** See finding 1. The 29/10 trace and the 29/10 MAP entry
  both carry it as a gating fault; **both are superseded and the dates are cited on
  each side.** The OI-296 pairing that rested on it falls away with it, and
  `a05MA00000GqqcPYAR` **is still unread**.
- 🔑 **"Both halves of the migration data are delivered" is withdrawn.** The 28/10
  and 29/10 records read `Referenti Salesforce_V2.xlsx` as satisfying the Referenti
  half. ROMI, who can open it, were still asking for the tracciato on 30/10. ⚠
  **Whether V2 is wrong, incomplete or simply not what was asked is stated by
  nobody.**
- 🔑 **The _"fino a 10€"_ DocuSign ceiling is not a budget and not even a currency.**
  Recorded on 29/10 with a warning that it was a joke; it is a **count of 2,500
  envelopes**.
- 🔑 **Rexhina Hysi's "leaving date" was the wrong question.** She is reassigned
  full time to another project, not leaving. Superseded, both dates cited.
- ⚠ **The 29/10 reading that the Lead file settled OI-295's client-communication
  problem stands**, but the field's *name* was never decided — Elena Spini:
  _"chiamalo come vuoi … non mi interessa"_. The label exists because Anita Aga built
  it from a sentence, not because anyone ruled.
- ⚠ **The WooCommerce environment question was agreed twice, in opposite
  directions**, inside one meeting, and Gemini's own `Concordato` list carries both.
  **No resolution is asserted here.** The one undisputed fact: there is a single
  WooCommerce environment.
- ⚠ **Tutor training is sized at one hour and at two hours by the same person on the
  same day.** Not reconciled.
- 🔴 **The pre-existing defects are unchanged**: rows **163–174 remain duplicated**
  in `meetings/open-items.md` **and** `.it.md` with the copies still differing; the
  **Risks table in `INDEX.md` is still malformed**; row `| 83  |` is still padded;
  **both `DEVELOPMENT-RECAP` files still carry a precedence line ending at §45**
  while they now end at **§73** — seventh run flagged, still an editorial ruling
  rather than a mechanical edit.
- ⚠ **`INDEX.md` trace rows**: the 23/10, 26/10, 27/10 and 28/10 gaps flagged on
  29/10 **were not backfilled**; tonight's row was added. Second run flagged.
- ⚠ **`JOURNAL.md` holds ~141 entries against the protocol's "keep the twenty most
  recent"**, and is ~427 KB. **Sixth run to flag it.**
- ⚠ **`MAP.md` still carries two `## Where the project stands` headings**;
  tonight's entry went into the **first**, which is the live block.
- ⚠ **The Drive `modifiedTime` filter was not honoured** by the search tool and
  returned older files; the result set was triaged by hand. Worth knowing for the
  next run.

## Not done in this run

- The org was **not** opened. `STATUS.md` was not regenerated and the Notion mirror
  stays stale. 🔑 **What it would settle tonight**: whether the WooCommerce list view
  of OI-298 exists, whether the `Agente` permissions are as Rexhina Hysi left them,
  whether `Asset.QR_Id__c` can be created in Prod (OI-289, **no fourth failure
  notification arrived today**), what `a05MA00000GqqcPYAR` says, whether the three
  manual steps of OI-301 are done, whether the nightly Mexal jobs are scheduled, and
  whether account send is back on in UAT.
- **No Apex test was written, proposed or scaffolded**, per the standing instruction.
  [OI-64](../items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md),
  [OI-66](../items/OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md) and
  [the deploy risk](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md)
  are unchanged; the risk stays `resolved`.
- **OI-212 was not fixed**, an eighteenth night, in production.
- **The raw transcript of the WooCommerce call was not read line by line** — 84 KB.
  The summary, decisions, next steps and full `Dettagli` were. ⚠ **Quotations in that
  meeting note are Gemini's paraphrase unless marked.**
- **The Lead CSV, its Sheet conversion, `lead-da-importare.xlsx`, `Referenti
  Salesforce_V2.xlsx`, `Utenti Area Commerciale.xlsx`, `Contatti_Zoho_CRM_`,
  `Account Salesforce_V2.xlsx`, `Categorie Prodotto.xlsx` and the OI-265 picklist
  workbook were not opened** — real customer, contact or staff records. **Ninth day
  for the picklist workbook; OI-265 unmoved.**
- **The three PNG and two image attachments of 29/10, and `image001.png` of 30/10,
  were not opened.**
- **The 380 MB Import Ordini recording of 28/10 was still not opened** — no tool here
  reads an MP4. **Third night.**
- **`DevAnita30` has no PR and none was opened** — reporting only; opening one is not
  this run's to do.
- **The `DEVELOPMENT-RECAP` precedence headers, the `INDEX.md` Risks table, the
  duplicated tracker rows and the four missing trace rows were not repaired.**
- **`prettier:verify` was not run** (no `node_modules`); `vault:check` is
  dependency-free and was.

## Still unreachable

🆕 **Whether the WooCommerce list view was built** · 🆕 **whether the partita IVA
matching change was actually coded, or the retest merely used a different VAT
number** · 🆕 **how many orders the 30-day opportunity cookie mis-attributed** · 🆕
**what the contract status flag and chasing report are to be** · 🆕 **whether
Anticipay answers correctly in production, and whether San Marino is a sandbox
configuration or a coverage gap** · 🆕 **how many tutors there are**, and 🆕 **whether
the licences exist for them** · 🆕 **whether test access is needed for every agent in
`Utenti Area Commerciale.xlsx`** — the client's answer is awaited · 🆕 **who
re-enables the Lead duplicate rules after the import** · 🆕 **whether Elena Spini
took the maintenance line back to Andrea Galotto** · 🆕 **whether "Giuliano" is
G Lanzetti's first name, and who was actually in the WooCommerce room** · 🆕 **whether
the Performance Plus per-tranche line logic exists** · 🆕 **which 09:30 Monday
meeting Aurel Mrruku attends** · 🆕 **whether `Referenti Salesforce_V2.xlsx` is wrong,
incomplete, or simply not the tracciato** · 🆕 **what the 13 November rollback plan
is** · 🆕 **whether the Fase 2 reclassification has been applied to any item, and
whether the client has been told the margin is gone** · **whether `Asset.QR_Id__c`
can simply be created in Prod** · **what `a05MA00000GqqcPYAR` says** · **whether
account sending to Mexal is back on in UAT** · **whether UAT stops writing to the
same Mexal company as production** · **whether the three unticked production manual
steps are genuinely undone**, and **whether `QuoteNegotiationAgingBatch` was
restored** · **whether the historical data load has been run in production at all**
· **what was actually said in the 28/10 14:07 call** — 57 minutes, 380 MB, no
transcript · **what `ID riga Mexal` was agreed to mean** · **who `cdg@pienissimo.com`
is** · **whether the Salesforce My Domain was changed to `pienissimo`** · **which org
the three sharing-default changes were made in** · **what should replace the calendar
years in `Anno Accademico`, and which `Bundle Type` values to add** — 🔑 **now
sharper: the labels were renamed and nobody has shown the client** · **whether the
OLD edizione links get deleted or deactivated** · **who absorbs the ten-plus man-days
the migration cost** — 🔑 **partly answered: the project's own remaining estimate
did** · **whether Mexal's accounting-year archive behaves as the code assumes** —
never put to Kreosoft · **whether the production file will arrive with the
`610.00001` transformation already applied** · **whether the retired agent codes are
in the delivered list** · **what the Categoria Prodotto description inconsistencies
are** · **whether the product synchronisation flows are actually on** · **what
_"template completamente personalizzabili"_ means** · **who inherits
`Devmain_LeadChecks` and `Devmain_QuoteTriggerChanges`** · **who Claudio is** · **how
many commitments sit in the Zoho tutor calendars, and who re-enters them** · what
Mexal actually does with a `sconto` on a quantity-above-one line — the one
measurement that settles OI-287 · how many Azienda accounts have a blank `Agente__c`
· what happens to the data-model fields Zoho cannot fill · whether Lead consent
fields survive the migration — 🔑 **now sharper: they arrive uniformly `true` by the
client's own instruction** · whether Gianpaolo Motta's Fase 2 ruling will be said to
the client · whether the client accepts the Change Request regime (**seventh day of
silence**) · which profile the UAT user `005MA00000Gh60y` holds · where the
`rinunciato` asset write lives · which of the three dummy-edizione mechanisms is the
one · who reverses the whole-catalogue activation, and when · how many credit notes
leave the 2024 history · the contents of the picklist workbook · whether the ~80 live
Performance Plus contracts are migrated, hand-entered or abandoned · whether the
client's lawyer permits the legal-representative fields · the client's ticket
field/value structure (undertaken 21/10, **nine days**) · what `Pienissimo 360` is ·
🔴 **whether Pienissimo hold a Zoho contract past 31 October** (**twelfth run, one day
out**) · which four `Dettaglio Motivazione Uscita` values OI-259 means · whether a
contract-expiry alert rule exists in the org (OI-272) · which production user is to
be copied for the marketing tests · what _"utente metà bloccato"_ means for WhatsApp
· whether Sabatino Rinaldi's user exists · what Fabrizio Mastracci's _"nuova change
request"_ referred to · the 30/07 marketing notes
`1uJCE4NW9nbdI38ADmt66svUT1MRmkyYd24uI0hegAD0` · Zoom tier · training hours · the Woo
instance · DocuSign prod config · `Get Campaign` and the campaign-ID gap · Jira
`PIEN` · `Flows & Objects.drawio` · the _diretta_ form.
