---
id: trace-2026-11-03-nightly
type: reference
status: active
updated: 2026-11-03
watermark_used: 2026-11-02T22:00Z
external_watermark: 2026-11-03T22:00Z
account: a.mrruku@romicompany.com
---

# Source trace 2026-11-03 nightly

**Watermark for the next `requirements-check` run: 2026-11-03T22:00Z, single
value.**

**Watermark used: 2026-11-02T22:00Z**, the `external_watermark` stated by
[the 02/11 nightly trace](Source%20trace%202026-11-02%20nightly.md), selected by
`updated:` frontmatter. Scheduled nightly run, executed 2026-11-03 ~22:00Z. **One
day — and the densest in the project record.**

🔑 **The headline: the whole Salesforce → Mexal → invoice chain ran end to end in
production with the client driving, and almost everything around it failed.**

🟢 **Environment note.** The clone opened on a detached `main` (two commits, config
only) with none of the knowledge layer in the working tree; `DevMain` did not exist
locally and was created with `git checkout DevMain` against the fetched remote
branch. **Twenty-eight runs, same opening pattern.**

## Sources searched

| Source | Query / scope | Result |
| ------ | ------------- | ------ |
| **Gmail** | `pienissimo after:2026/11/02 -in:draft`, 50 requested, 11 estimated | 🔑 **Nine threads moved on 03/11**, against two on the whole previous window. All read in full |
| **Gmail** | `get_message 1a1a291d143128a7` (PLAIN_TEXT) | 🟢🔑 **The R0 specification, sent 18:00:14Z** to Fabrizio Paganelli, `amministrazione@pienissimo.com` and Sabatino Rinaldi, cc Aurel Mrruku — **a day before the 04/11 deadline**. Links the analysis doc and 🆕 **a new meeting Thu 05/11 12:00-12:30** → [the analysis note](../The%20stage%20sale%20contract%20functional%20analysis.md) |
| **Gmail** | `get_message 1a1a131d3129e774` + `1a1a14926202e9c3` (PLAIN_TEXT) | 🔴🔑 **The production incident.** `SPAM EDIZIONE TEST: i tuoi biglietti sono pronti.` reached Fabrizio Paganelli at **12:33 CET**, forwarded 12:35, Elena Spini's confirmation 13:01 — _"Non ci sono biglietti disponibili per questo account"_ → [OI-313](../items/OI-313%20The%20ticket%20nomination%20email%20fired%20for%20assets%20still%20in%20ordinato.md). ⚠ No tracking URL or token is copied into the records |
| **Gmail** | `get_message 1a1a13322fc6fb23` + `1a1a149924bdaff4` | 🟢🔑 **The asset-state question closed by the client**, 12:37 CET: _"mi sono confrontato con Rebecca … **Va bene così come impostato ad oggi**"_ → [the decision](../decisions/Decision%20-%20asset%20states%20stay%20as%20built%20and%20the%20ordinato%20label%20is%20not%20renamed.md) |
| **Gmail** | `get_message 1a1a1b96a6f63a3f` + `1a1a24155145940d` | 🔴 **Two client asks, neither answered on 03/11**: delete this morning's production tests before the mapping, and enable field-display editing ([OI-315](../items/OI-315%20Production%20test%20records%20cannot%20be%20deleted.md)); and a validation message when `Anno Accademico` is set to _"nessuno"_ — _"Ne parliamo domani"_. ⚠ **Both carry `image001.png` screenshots, not opened** |
| **Gmail** | `Trasferimento dati` thread, 4 new messages 11:18Z-17:20Z | 🟢🔑 **Training dates and the profile switch.** Mon+Wed next week, **11:30-13:00**, 1.5-hour sessions, awaiting Marco Montesi's confirmation; 🟢 he confirms **six** users. 🟢🔑 **Marco Montesi moved from System Administrator to Agente** — _"i campi sincronizzati con Mexal non sono più editabili manualmente da layout"_ → [OI-300](../items/OI-300%20Tutor%20training%20and%20tutor%20test%20access%20are%20unplanned.md), [the permission note](../objects/The%20Agente%20permission%20set%20gained%20Mexal%20and%20Anticipay%20access.md) |
| **Gmail** | `get_message 1a1a12aad5256527` (Gemini notes, Test e2e PROD) | Summary plus **eighteen action items** — used as a cross-check, **not as the source**; the skill's warning held and 🔑 **four of its claims are wrong**, recorded in the meeting note |
| **Gmail** | `get_message 1a1a269396bff466` (Meet records, Follow-up Interno) | Transcript link only; artifacts found by Drive search |
| **Gmail** | invitation `1a1a2662cea3f834` | 🆕 `[ROMI-PIENISSIMO] - Continuazione Test e2e PROD`, **Wed 4 Nov 14:30-16:00 CET**, to Aurel Mrruku, amministrazione and Fabrizio Paganelli |
| **Drive** | `read_file_content 1A-sYQEZvbp2ShVbVL1XQPkPottBQKCuI` | 🟢🔑 **The R0 analysis, an uploaded `.docx`** — seven RF, four flow tables, four edge cases, seven dated steps, four open points. Read in full. **No euro figure and no catalogue price transcribed** |
| **Drive** | `title contains 'Test e2e PROD'` | Meeting folder `1xgs6XSFD1omGmMhcsmNLZ2CeIsHMn5pt`, containing **only a Gemini-notes shortcut** — ⚠ **no recording and no separate transcript document**, second session in a row with that pattern |
| **Drive** | `read_file_content 1-Dh-MKr_NRaigj8BQ-UyiI9qGaOJzmEU9-K9qH0Gr_I`, **153,684 chars** | 🟢🔑 **Too large to return; written to scratch and read in six slices with python** — notes + `Dettagli` (19k) and the **full 02:49:39 transcript (128k), read once, in order, in full** → [the meeting note](../meetings/2026-11-03%20Test%20e2e%20PROD.md) and `meetings/2026-11-03-test-e2e-prod-transcript.it.md` |
| **Drive** | `title contains 'Follow-up Interno'`, then `parentId` on both folders | 🟢 **Today's transcript** `1GLXt51dxdjb3VG6b4drYz3hm6fViNu_0DRCscHdWQ2Y`, read in full → [the meeting note](../meetings/2026-11-03%20Follow-up%20Interno.md). ⚠ **No Gemini notes document exists for this session** — the reverse of the usual pattern, and the third artifact asymmetry this week |
| **Slack** | `slack_read_channel C0B5T3RB4FM` (`#tproj-pienissimo`), `oldest` 1793656800 | **0 messages.** 🔴 **Silent a second consecutive sweep**, and no human message since its 30/10 status post |
| **Slack** | `slack_read_channel D0B5QHS2T7H` (Elena Spini DM), same bound | **16 messages, all 03/11** — logistics around the e2e call and the evening Fase 2 call. 🔑 11:47 _"puoi fare questa cosa a livello di riga ordine?"_ / _"ti prendi un stato di Mexal?"_ — **the `fatturato` design question, mid-call**. 16:54-17:29 the setup for the internal follow-up |
| **Slack** | `slack_read_channel C0C38JJ9D1T` (marketing group DM), same bound | **8 messages.** 🔴🔑 **12:44-12:47 the incident diagnosis** — _"abbiamo fatto un test in PROD con il cliente - biglietti in stato ORDINATO dice che hanno ricevuto la mail di nomina biglietti"_ → _"secondo me il problema qui è che il link era in PRONTO"_, on order `801SW00000hBue3YAC`. 🟢 12:48 Aurel Mrruku: _"ho portato su la community"_. 🆕 18:14 Elena Spini to Fabrizio Mastracci: **tomorrow's orders are the clean test records** → [OI-311](../items/OI-311%20The%20marketing%20flow%20update%20needs%20clean%20test%20records.md) |
| **Slack** | `slack_read_channel C0BQD34LLF4` (dev group), same bound | 🟢 **2 messages, and they are the first human ones in the channel for days** — **Rexhina Hysi**, 16:34:46 CET, a file `lead-web-to-lead (2).html` (24.6 KB), then 16:34:57 _"no settore"_. ⚠ **No context, no addressee and no reply.** ⚠ **The file was not opened** — a web-to-lead form plausibly tied to `Devmain_LeadChecks`, but nothing says so |
| **Slack** | `slack_read_canvas F0BD2H5A9HT` (`Link utili Pienissimo`) | **Unchanged.** Newest entry still 20.08.2026 — **75 days**. Re-read per the skill |
| **Fathom** | `list_meetings created_after 2026-11-02T22:00Z`, 3 pages | **0 meetings.** 🔴 **Nothing, a thirty-first consecutive run** — on a day with a 02:49:39 client call and a 00:36:20 internal one, both recorded through Google Meet |
| **Git** | `fetch origin`, `branch -r`, `ls-remote --heads` | **No branch moved since `f77a850`.** `DevMain` at `f77a850` (merge of PR #120), `UAT` `8f039ce`, `Prod` `7905945`. 🟢 **PR #120 merged `DevAnita30`** — ⚠ the 02/11 reading that it had no PR is now stale |
| **Repo** | `ls notes/items` max-id scan | Max existing id **311**, so this run allocated **312**–**328**; next free is **329** |

## Found

1. 🟢🔑 **[The 3 November Test e2e PROD session](../meetings/2026-11-03%20Test%20e2e%20PROD.md)
   ran the entire chain in production and it worked.** 09:31 CET, **02:49:39** — the
   longest session the project has. Fabrizio Paganelli drove from his own user:
   account → opportunity → quote with two tranche → PDF → sent for acceptance →
   **DocuSign, the real connector** → signed → quote `Firmato` asynchronously →
   **Salesforce order 113** → `Mexal Integration Status = inviato` → **Mexal order
   `OC155` with the discounts correct** → invoice, payment condition code **20** →
   **new Mexal customer, fiscal residence RSM** → invoice back in Salesforce unpaid
   with its due date. 🔑 **The first discounted order ever tested** — _"non avevo mai
   fatto un test con lo sconto"_ — and it reconciled. ⚠ **No price or discount value
   is recorded.**
2. 🔴🔑 **[Anticipay times out in production](../items/OI-312%20Anticipay%20times%20out%20in%20production.md).**
   120 seconds, no answer, **after Anticipay confirmed production in writing** —
   _"ha detto confermo, tutto ok, portate direttamente in produzione"_. 🔑 **The
   pointings are theirs, not ROMI's.** Fabrizio Paganelli phoned Andrea live; ⚠ no
   deadline, no update by end of day. 🔑 **And what Anticipay is was stated plainly
   for the first time**: not a validation but a lookup, a result only for an Italian
   P.IVA it can find, **only on an account's first order**, and a failure never
   blocks the order. ⚠ **So a wrong-but-Italian P.IVA cannot be detected** — Elena
   Spini's unanswered case, _"devono saperlo"_.
3. 🔴 **[Production could not be cleaned](../items/OI-315%20Production%20test%20records%20cannot%20be%20deleted.md).**
   About twenty records went; **orders are blocked by permission and some were marked
   collected**, and the accounts are held by them. The client asked again by mail and
   **will not start his real configuration until they are gone**.
4. 🔴🔑 **[The UAT mappings cannot be migrated](../items/OI-320%20Event%20and%20Edizione%20mappings%20cannot%20be%20moved%20between%20orgs.md)
   because Evento and Edizione have no external id** — _"Se avessi un ID esterno
   l'avrei fatto in 10 minuti"_. 🟢 The missing-mapping guard worked. 🔴 Fabrizio
   Paganelli rebuilds everything by hand: _"Però è un lavoro cinese. Io l'avevo detto
   che era una cosa che non dovevamo rifare"_, and twice, half in jest, that he would
   invoice ROMI the hours. ⚠ **No date and no volume**, which is the whole cost.
5. 🔴🔑 **[A ticket-nomination email went to the client twelve minutes after the call](../items/OI-313%20The%20ticket%20nomination%20email%20fired%20for%20assets%20still%20in%20ordinato.md)**
   for an order whose assets were still `ordinato`. 🔑 **The cause was diagnosed the
   same hour** — the event link had reached `pronto`, which Elena Spini and Aurel
   Mrruku had both seen during the test and checked as harmless. 🔴 **ROMI promised an
   answer and sent none.**
6. 🟢🔑 **[The R0 specification went to the client a day early](../The%20stage%20sale%20contract%20functional%20analysis.md)**,
   18:00:14Z: seven RF, four open points, **release 18 or 19 November, confirmation
   due 05/11**, 🆕 **a new meeting Thu 05/11 12:00-12:30**. 🟢 **RF7 separates paper
   from electronic at last** — `contratto informatico` is **the Contract record, Plus
   only**. 🟢 **OP-2 gives the 30 October status flag an owner and a date** —
   Fabrizio Paganelli, 05/11 — pushed to the client on purpose.
7. 🟢🔑 **The scope worry of 2 November is retired.** In
   [the internal follow-up](../meetings/2026-11-03%20Follow-up%20Interno.md) Aurel
   Mrruku opened believing only Plus generates a contract, Elena Spini challenged
   him, and **he checked the 2 November transcript himself**: _"il contratto lo vuole
   per tutte le vendite da palco, quindi sia per i corsi sia per la plus"_. **So
   pricing courses and Plus in R0 matches what was agreed**, and Fabrizio Paganelli's
   _"solo per la parte della Plus corsi"_ did not narrow it.
8. 🔴🔑 **The chasing report was deleted, not forgotten.** It stood in the draft as
   Open Point 5 and **Aurel Mrruku had it struck**: _"toglili pure di tutto che poi là
   non finiamo mai"_. 🔑 **This is a sharper fact than the 2 November reading that it
   was "never mentioned again"** — and the client has never been told it was in scope.
9. 🔴 **Three further pieces of scope were left out of the delivered document**: the
   RF1 **product check** (absence noted by Elena Spini before sending), **two
   templates rather than one**
   ([OI-326](../items/OI-326%20A%20second%20PDF%20template%20is%20needed%20for%20corsi%20and%20for%20Plus.md),
   the open point deleted because it had never been raised with the client), and the
   **DocuSign return-trigger rewiring**
   ([OI-322](../items/OI-322%20The%20DocuSign%20return%20trigger%20only%20handles%20quotes%20not%20orders.md))
   with the **bundle Plus classification** it needs
   ([OI-328](../items/OI-328%20A%20bundle%20containing%20a%20Plus%20product%20must%20be%20flagged%20as%20a%20Plus%20bundle.md)).
10. 🔴🔑 **R0 is 6-7 days and Aurel Mrruku does not believe it** — _"Ho la paura che
    abbiamo messo davvero poche giornate … Sai quanto mettevo per un template? da 10 a
    15 giorni"_, _"2-3 giorni"_ with AI. Elena Spini: _"non posso chiedere più i
    giorni, mi sa che già m'ammazzano."_ 🔴 **And he is alone** — _"Regina su un
    progetto, Ana e Sara su un altro … e il lavoro lo devo fare io. Amen."_ ⚠ Names
    as transcribed and **marked uncertain**.
11. 🟢🔑 **The asset-state dispute was argued for twenty minutes and closed by the
    client the same afternoon.** Fabrizio Paganelli wanted a third `fatturato` state
    on the asset; the build has two, with `disponibile` only on collection. 🔑 **The
    technical obstacle is real** — several assets hang off one order line, so no
    one-to-one link to an invoice line exists. 🔴 **Not settled on the call**: Aurel
    Mrruku left, Fabrizio Paganelli went to phone Rebecca, Elena Spini floated
    renaming to `non ancora disponibile`. 🟢 **Settled by mail at 12:37 CET** —
    _"Va bene così come impostato ad oggi"_ →
    [the decision](../decisions/Decision%20-%20asset%20states%20stay%20as%20built%20and%20the%20ordinato%20label%20is%20not%20renamed.md).
    🆕 **What survives is an order-level `fatturato`**
    ([OI-314](../items/OI-314%20The%20order%20line%20fatturato%20status%20is%20not%20implemented.md)),
    ⚠ **agreed knowing it is imperfect** — it keys on all order lines and Fabrizio
    Paganelli said so.
12. 🔑 **The product registry, counted from the org**: **1093 products**, about **500**
    activated, and **`gruppo merceologico`** confirmed as the criterion by live
    inspection → [OI-309](../items/OI-309%20The%20product%20activation%20criterion%20must%20switch%20from%20gruppo%20merceologico%20to%20the%20Mexal%20flag.md).
    🔴 **And its risk has already materialised** — the client mis-set the whole `blow`
    family and activated it by accident
    ([OI-327](../items/OI-327%20The%20blow%20product%20codes%20carry%20the%20wrong%20gruppo%20merceologico.md)),
    which **blocks the mapping rebuild**.
13. 🔑 **The API integrations and the nightly refresh are off in production by
    decision** — _"non voglio spaccare qualcosa adesso perché dobbiamo fare dei giri
    completi, poi alla fine devo abilitare gli API"_; Elena Spini pushed to enable
    them and was overruled. 🟢 **This answers the standing question of whether the
    product synchronisation flows are on: they are not, deliberately.**
14. 🟢🔑 **Seven agent users are live in production** and four had verified by the end
    of the call; links expire after 72 hours. 🔴 **In production, not a test
    environment**, against the 30 October undertaking, and ⚠ **nobody reconciled the
    two**. 🔴 One of them **ceases his engagement on 31 December**
    ([OI-324](../items/OI-324%20An%20agent%20user%20leaves%20on%2031%20December%20and%20the%20licence%20must%20be%20reassigned.md)).
    ⚠ **Seven provisioned against Marco Montesi's confirmed six**, unexplained.
15. 🟢🔑 **The `Agente` change is in a live org.** Elena Spini told Marco Montesi at
    17:20Z that his profile moved from System Administrator to **Agente** and that
    Mexal-synced Account fields are **no longer editable from layout** — _"per
    preservare la coerenza dell'integrazione"_. 🔑 **First evidence, and the first
    documented rationale.** ⚠ **Nothing says whether the Apex half is deployed**, and
    🔴 **who asked for it remains unanswered.**
16. 🟢🔑 **The shared-account pattern was reproposed and died within hours.** Because
    Marco Montesi has no agent code, the call's answer was that he use the
    **`segreteria`** user, readable only by Martina and Elisa Migliano — Fabrizio
    Paganelli's own _"Che casino, che casinisti che siamo"_. **Elena Spini objected
    and prevailed**: by 17:20Z he had his own Agente user.
17. 🆕 **Training has dates: Mon 09/11 and Wed 11/11, 11:30-13:00, 1.5 hours**,
    awaiting Marco Montesi's confirmation with the tutors. ⚠🔑 **Monday 9 November is
    the technical go-live and Wednesday 11 the eve of the data migration. Nobody noted
    the collision.**
18. 🟢 **Two standing unknowns closed.** **The Salesforce My Domain stays unchanged** —
    the client refused because tutors would have to regenerate their keys
    ([decision](../decisions/Decision%20-%20the%20Salesforce%20My%20Domain%20stays%20unchanged.md)).
    ⚠ **But a different domain is still owed by the client and nobody could say what
    it is for**
    ([OI-323](../items/OI-323%20The%20production%20domain%20has%20not%20been%20supplied%20by%20the%20client.md)).
19. 🆕 **Four layout and field changes agreed** — `importo netto` and `prezzo netto`
    ([OI-316](../items/OI-316%20The%20quote%20line%20needs%20a%20net%20amount%20column.md)),
    the payment-condition description becoming `note preventivo`
    ([OI-317](../items/OI-317%20The%20payment%20condition%20description%20field%20must%20become%20quote%20notes.md)),
    `data competenza` → `data ordine` asked _"74 volte"_
    ([OI-318](../items/OI-318%20The%20data%20competenza%20labels%20must%20be%20renamed%20to%20data%20ordine.md)),
    and `data invio biglietto` missing from the campaign page with **no field
    permission even for Aurel Mrruku**
    ([OI-319](../items/OI-319%20Data%20invio%20biglietto%20is%20missing%20from%20the%20campaign%20page%20in%20production.md)).
20. 🔑 **[OI-306](../items/OI-306%20The%20WooCommerce%20order%20number%20must%20reach%20Mexal%20in%20the%20order%20header%20note.md)
    has its purpose confirmed and is still not built**, four days on — the invoice
    must carry the quote reference and the Mexal order number. Aurel Mrruku's own list
    of what production lacks: _"Mi mancano la community, le note, alcuni layout."_
    🟢 **He brought the community up during the day.**
21. 🔴 **[The full order sync to Mexal has never run](../items/OI-321%20The%20full%20order%20synchronisation%20to%20Mexal%20has%20not%20been%20run.md)**
    — only the last five days, and the whole set takes about **five hours**. ⚠
    **Distinct from OI-310's 3-4 hour migration load.**
22. 🔴 **The client's verdict on the state of it**: _"rifacciamole queste test perché,
    come hai visto, anche oggi mancava la metà delle robe"_, and **Performance Plus and
    the bundles have not been tested at all** — _"Dobbiamo secondo me rivedere la
    Performance Plus, i pacchetti"_. A further session with **Rebecca** is owed.
23. 🆕🔑 **Fase 2 governance was fixed.** Andrea Galotto told Elena Spini to do a pass
    with the project's owner before a direct call with **Daniela**; agreed that **Elena
    Spini and Fabrizio Paganelli review the activity list first** — already defined —
    then **Andrea Galotto and Daniela take the quote and the numbers**. ⚠ **Daniela
    appears to be Pienissimo-side**; marked **inferred, not established**.
24. ⚠🔑 **The 150-vs-58-78 Fase 2 discrepancy is known to ROMI and unresolved** —
    _"Metteranno una media o il 58?"_ / _"lo scopriremo"_. **Not an oversight nobody
    noticed.**
25. 🆕 **Tomorrow**: the e2e continuation **Wed 04/11 14:30-16:00**, capped at 90
    minutes, **Aurel Mrruku and Fabrizio Paganelli alone** since Elena Spini is
    unavailable. 🔑 **And Fabrizio Paganelli owes the data tracciati tomorrow
    morning** — _"Vi devo dare tutti i tracciati dati"_ — which corroborates the
    04/11 09:00-09:30 Referenti slot promised on 2 November.
26. 🟢 **PR #120 merged `DevAnita30` into `DevMain`** as `f77a850`. ⚠ **The 2 November
    reading that the branch had no PR is stale.** No branch moved in this window.

## The register

⚠ **Nothing found tonight calls for a register change, and nothing was changed.**
Version stays **1.6**; `go_live: 2026-11-16` unchanged, with **09/11** as the
technical go-live.

🔴 **`SAL-12` was not amended and is now uncited for a thirteenth session.** ⚠
**`DM-07`'s competitor-list conflict is unchanged.**

🔑 **The absences remain findings, and seventeen new ones join tonight.** No register
row covers **Anticipay availability in production** (OI-312), **ticket-send gating**
(OI-313), **order line states** (OI-314), **production test data** (OI-315), **quote
line layout** (OI-316), **quote notes** (OI-317), **field labels** (OI-318), **the
campaign ticket-send date** (OI-319), **cross-org mapping migration** (OI-320), **the
order sync** (OI-321), **DocuSign document routing** (OI-322), **the production
domain** (OI-323), **licence handover** (OI-324), **order line due dates** (OI-325),
**contract templates** (OI-326), **registry classification errors** (OI-327) or
**bundle Plus classification** (OI-328) — on top of the standing set from OI-274
onward.

⚠ **The Italian wording in `REQUISITI.it.md` still needs a human's eye** —
unchanged, twelve runs on.

## Corrections to the record

- 🔑 **The 02/11 reading that the chasing report was "never mentioned again" is
  superseded and sharpened: it was raised on 03/11 and deliberately deleted.** Both
  dates are cited on OI-304.
- 🔑 **The 02/11 reading that payment timing was "settled by Elisa Migliano" is
  qualified.** Aurel Mrruku struck the claim from the draft — _"Non è detto … Noi non
  ce l'abbiamo l'informazione … lo sappiamo a mezzanotte"_. **The order-state rule
  stands; ROMI does not hold the payment fact.**
- 🔑 **The 02/11 question of whether Fabrizio Paganelli's agreement covered Plus or
  only the courses is answered: both.** Verified by Aurel Mrruku against the 02/11
  transcript, not inferred.
- 🔑 **The 02/11 reading that `DevAnita30` had no PR is stale** — PR #120 merged it,
  and `DevMain` is `f77a850`.
- 🔑 **The 02/11 reading that the `Agente` changes were in no org is qualified**: the
  **field-level half is in production**, described to the client by Elena Spini. ⚠
  **The Apex half is still unevidenced.**
- 🔑 **"Whether Anticipay answers in production" is answered: it does not.** Carried
  as unreachable for weeks.
- 🔑 **"Whether the Salesforce My Domain was changed to `pienissimo`" is answered: no,
  and it will not be.** The client refused.
- 🔑 **"Whether the product synchronisation flows are actually on" is answered: they
  are off, by decision.**
- 🔑 **"Whether 'Giuliano' is G Lanzetti's first name" is answered**: the production
  sender's display name is **Giuliano Lanzetti**, on the 12:33 CET nomination mail.
- ⚠ **The Gemini auto-notes for the e2e session contradict the transcript in four
  places**, recorded in the meeting note: production deletion was only partial;
  Valentina's activation mail was resolved on the call, not outstanding; the check
  with Rebecca happened **after** Aurel Mrruku left; and the asset-state exchange was
  a disagreement, not a clarification, with its technical reason absent entirely.
  🔑 **The skill's warning about auto-summaries held.**
- 🔴 **The pre-existing defects are unchanged**: rows **163-174 remain duplicated** in
  `meetings/open-items.md` **and** `.it.md` with the copies still differing; the
  **Risks table in `INDEX.md` is still malformed**; row `| 83  |` is still padded;
  **both `DEVELOPMENT-RECAP` files still carry a precedence line ending at §45** while
  they now end at **§76** — ninth run flagged, still an editorial ruling rather than a
  mechanical edit. ⚠ **And §74 (30/10) still sorts after §75 (02/11)** in both files.
- ⚠ **`INDEX.md` trace rows**: the 23/10, 26/10, 27/10 and 28/10 gaps flagged on
  29/10, 30/10 and 02/11 **were not backfilled**; tonight's row was added. **Fourth
  run flagged.**
- ⚠ **`JOURNAL.md` holds ~143 entries against the protocol's "keep the twenty most
  recent"**, and is ~436 KB. **Eighth run to flag it.**
- ⚠ **`MAP.md` still carries two `## Where the project stands` headings**; tonight's
  entry went into the **first**, which is the live block. **`AGENTS.md` still calls it
  _"under 5 KB"_** against ~360 KB.
- ⚠ **Row 48's Italian tracker row carried a stale `12/10/2026` "last touched" date in
  `DD/MM/YYYY`** while the newer Italian rows use ISO; set to `03/11/2026` in the
  file's own format. **The two conventions still coexist in that column.**

## Not done in this run

- The org was **not** opened. `STATUS.md` was not regenerated and the Notion mirror
  stays stale. 🔑 **What it would settle tonight**: whether the `Agente` Apex grants
  are in production, whether the `blow` codes are still active, whether the test
  orders can be cancelled, whether `data invio biglietto` reached the campaign page,
  whether the twelve `PLUS_B` codes are in `Product2`, whether order `00016059` was
  resent, whether `Asset.QR_Id__c` exists in Prod, whether OI-301's manual steps are
  done, whether the nightly Mexal jobs are scheduled, and whether account send is back
  on in UAT.
- **No Apex test was written, proposed or scaffolded**, per the standing instruction.
  [OI-64](../items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md),
  [OI-66](../items/OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md) and
  [the deploy risk](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md)
  are unchanged; the risk stays `resolved`.
- **OI-212 was not fixed**, a twenty-second night, in production.
- **OI-265 is unmoved, a twelfth day**, and the picklist workbook is still unopened.
- **The `lead-web-to-lead (2).html` file Rexhina Hysi posted was not opened**, and
  **nobody asked her what it is for.**
- **The two `image001.png` screenshots on Fabrizio Paganelli's mails were not
  opened** — the `Anno Accademico` validation message and the Eventi/Edizioni one.
- **The twelve `PLUS_B` code values were not requested from the client**, a second
  day.
- **`Referenti Salesforce_V2.xlsx`, the Lead CSV and `lead-da-importare.xlsx`,
  `Utenti Area Commerciale.xlsx`, `Contatti_Zoho_CRM_`, `Account Salesforce_V2.xlsx`,
  `Categorie Prodotto.xlsx` and the OI-265 picklist workbook were not opened** — real
  customer, contact or staff records. **Twelfth day for the picklist workbook.**
- **The 380 MB Import Ordini recording of 28/10 was still not opened** — no tool here
  reads an MP4. **Fifth night.**
- **No `meetings/results/` recap was written** for either 03/11 session, as on every
  nightly run since September; the drills live in `notes/meetings/` and in the two
  trackers.
- **The `DEVELOPMENT-RECAP` precedence headers, the §74/§75 ordering, the `INDEX.md`
  Risks table, the duplicated tracker rows and the four missing trace rows were not
  repaired.**
- **`prettier:verify` was not run** (no `node_modules`); `vault:check` is
  dependency-free and was.

## Still unreachable

🆕 **Whether Pienissimo confirms R0 by 5 November, and whether the 05/11 12:00
meeting closes the four open points** · 🆕 **what Fabrizio Paganelli answers on OP-2,
the signature status or flag and where the signed PDF is stored** · 🆕 **whether the
client will be told that two templates, the DocuSign rewiring and the bundle
classification are in R0, or will discover it** · 🆕 **when Andrea fixes the Anticipay
production endpoint** · 🆕 **whether Pienissimo already check Anticipay on the
WooCommerce side**, which Aurel Mrruku speculated and nobody confirmed · 🆕 **how ROMI
will cancel the undeletable production test orders** · 🆕 **how many events and
editions Fabrizio Paganelli must rebuild by hand** · 🆕 **whether an external id will
ever be added to Evento and Edizione** · 🆕 **what ROMI tells the client about the
12:33 ticket mail** · 🆕 **which domain the client still owes, and what it is for** ·
🆕 **whether the `Agente` Apex grants are deployed, and who asked for them** · 🆕
**what `lead-web-to-lead (2).html` is and what "no settore" meant** · 🆕 **what the
`Anno Accademico` "nessuno" validation message says** · 🆕 **whether Marco Montesi
confirms Mon 09/11 and Wed 11/11 for training, on the technical go-live day** · 🆕
**who replaces the agent leaving on 31 December** · 🆕 **why `data scadenza` is empty
on that production order** · 🆕 **when the full five-hour order sync will run** · 🆕
**whether a tranche-level `fatturato` will be asked for once the order-level one
disappoints** · **which Fase 2 day count is real, 150 or 58-78** · **whether the
maintenance line will be added before 13 November, and at eight hours or three to
four days a month** · **whether Performance Plus will be sold at Pienissimo Live at
all** · **the twelve `PLUS_B` code values, and whether they and the ten `SF` codes are
one scheme or two** · **the date Fabrizio Paganelli owes for the `annullato` switch** ·
**when the refreshed interface file arrives** · **who supplies Fabrizio Mastracci's
clean records, and which flow he has rebuilt** · **whether `Referenti
Salesforce_V2.xlsx` is wrong, incomplete or simply not the tracciato** — five records
on · **whether the 12 licences are assigned, and whether sharing the PL and marketing
accounts is acceptable to anyone but the person who proposed it** · **whether the
WooCommerce list view was built** · **whether the partita IVA matching change was
coded** · **how many orders the 30-day opportunity cookie mis-attributed** · **whether
San Marino is a sandbox configuration or a coverage gap** · **how many tutors there
are** · **whether test access is needed for every agent in `Utenti Area
Commerciale.xlsx`** · **who re-enables the Lead duplicate rules after the import** ·
**whether Elena Spini took the maintenance line back to Andrea Galotto** · **what the
13 November rollback plan is** · **whether `Asset.QR_Id__c` can simply be created in
Prod** · **what `a05MA00000GqqcPYAR` says** · **whether account sending to Mexal is
back on in UAT** · **whether UAT stops writing to the same Mexal company as
production** · **whether the three unticked production manual steps are genuinely
undone**, and **whether `QuoteNegotiationAgingBatch` was restored** · **whether the
historical data load has been run in production at all** · **what was actually said in
the 28/10 14:07 call** — 57 minutes, 380 MB, no transcript · **what `ID riga Mexal`
was agreed to mean** · **who `cdg@pienissimo.com` is** · **which org the three
sharing-default changes were made in** · **what should replace the calendar years in
`Anno Accademico`, and which `Bundle Type` values to add** · **whether the OLD edizione
links get deleted or deactivated** · **whether Mexal's accounting-year archive behaves
as the code assumes** — never put to Kreosoft · **whether the production file will
arrive with the `610.00001` transformation already applied** · **whether the retired
agent codes are in the delivered list** · **what the Categoria Prodotto description
inconsistencies are** · **what _"template completamente personalizzabili"_ means** ·
**who inherits `Devmain_LeadChecks` and `Devmain_QuoteTriggerChanges`** · **who Claudio
is** · **how many commitments sit in the Zoho tutor calendars, and who re-enters
them** · what Mexal does with a `sconto` on a quantity-above-one line in a
**successful** document — the one measurement that would close OI-287, **and order
`00016059` has still not been resent** · how many Azienda accounts have a blank
`Agente__c` · what happens to the data-model fields Zoho cannot fill · whether
Gianpaolo Motta's Fase 2 ruling will be said to the client in full · whether the client
accepts the Change Request regime (**tenth day of silence**) · which profile the UAT
user `005MA00000Gh60y` holds · where the `rinunciato` asset write lives · which of the
three dummy-edizione mechanisms is the one · who reverses the whole-catalogue
activation, and when · how many credit notes leave the 2024 history · the contents of
the picklist workbook · whether the ~80 live Performance Plus contracts are migrated,
hand-entered or abandoned · whether the client's lawyer permits the legal-representative
fields · the client's ticket field/value structure (undertaken 21/10, **thirteen
days**) · what `Pienissimo 360` is · 🔴 **whether Pienissimo hold a Zoho contract past
31 October** (**fourteenth run — the date has passed and no source mentions it**) ·
which four `Dettaglio Motivazione Uscita` values OI-259 means · whether a
contract-expiry alert rule exists in the org (OI-272) · which production user is to be
copied for the marketing tests · what _"utente metà bloccato"_ means for WhatsApp ·
whether Sabatino Rinaldi's user exists · what Fabrizio Mastracci's _"nuova change
request"_ referred to · the 30/07 marketing notes
`1uJCE4NW9nbdI38ADmt66svUT1MRmkyYd24uI0hegAD0` · Zoom tier · training hours · the Woo
instance · DocuSign prod config · `Get Campaign` and the campaign-ID gap · Jira `PIEN` ·
`Flows & Objects.drawio` · the _diretta_ form.
