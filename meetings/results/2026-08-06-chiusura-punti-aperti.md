# [ROMI-PIENISSIMO] Chiusura ultimi punti aperti — Closing Session on Open Points — 2026-08-06

**Sources:** `meetings/2026-08-06-chiusura-punti-aperti-transcript.it.md` (original Italian transcript, Google Meet + Gemini notes, **2h30m30s**) · [recording](https://drive.google.com/file/d/1i0M2dURQYHLB92v8SeI1uJaz7xCcTg1X/view) · [notes & transcript](https://docs.google.com/document/d/1roHKiiF8qSlvqCnStsvY9ldpQxdi0SSFNS4a0xiObxk/edit) · surfaced from the Slack `#tproj-pienissimo` canvas "Link utili Pienissimo" (updated 2026-08-07)

**Attendees:** ROMI — Elena Spini (chair), Aurel Mrruku, Andrea Di Cicco (left before the Mexal item, ~02:02). Pienissimo — Sabatino Rinaldi, Marco Montesi ("Marco"), Elisa Migliano (admin), Fabrizio Paganelli (admin/Mexal, joined 00:14).
**Not present:** Fabrizio **Mastracci** (ROMI marketing) was invited by mistake instead of Fabrizio **Paganelli** and **disconnected at 00:01:30**, before any content. He is listed in the calendar invite but contributed nothing.

> **Attribution caveats.** These are Gemini notes. Two must be corrected when reading the auto-summary:
>
> 1. The **Decisioni** block states assets "stay _Disponibile_ until actually used." That is Sabatino mid-thought at 01:32:57; he reversed himself ~40 seconds later and **explicitly kept _Assegnato_**. Elena closed the point with "documentazione più QR code. Perfetto. Quindi questo non è più rosso."
> 2. The summary attributes the participant-data landing page and several admin statements loosely. In the transcript the **operational authority throughout is Elisa Migliano** (she runs the event infopoint herself — _"lo faccio io, cioè sono io di solito l'infopoint"_), and the decisive technical corrections on invoicing and matching are hers, not Aurel's.
>
> This recap follows the transcript with timestamps, not the auto-summary.

> **Context:** the closing session `DEVELOPMENT-RECAP.md` §10.1 anticipated. It cleared the full open-points list before the Italian August break and is the most decision-dense meeting since 07/22. **Return dates agreed in-session:** Elena out 10–14 Aug · **Elisa returns 17 Aug** · **Aurel returns 24 Aug** · **Sabatino operational 25 Aug, asks to be booked from 26 Aug** · Andrea Parmeggiani away two weeks, available third week of August · Fabrizio Paganelli back ~31 Aug. Working window for everything below: **26–29 August**.

---

## Cross-meeting updates

> **① DocuSign is back — but only on the commercial document.** §10.4 recorded DocuSign as 🔴 reversed/uncertain with the paper process possibly retained. The session splits the question and settles both halves:
>
> - **Quotes / contracts → DocuSign is IN** (00:19:21–00:22:19). Email carries a **link, not buttons** → landing page shows quote + contract + general conditions → **Accetto / Rifiuto** → reject sets the quote _Rifiutato_; accept triggers a **DocuSign send** → on signature the quote goes _Accettato_ → **the order is generated**. Elena: _"una volta che pigia su accettato gli mandiamo il preventivo via mail tramite Docusign … firma e una volta che firma sarà in accettato."_
> - **Ticket / participant documentation → DocuSign is OUT** (01:26:58). Elena: _"la firma digitale c'è solo per i preventivi."_ Participants sign **on paper** at check-in. The planned "mancata firma digitale" edge case was struck outright at 01:50:41: _"mancata firma digitale non c'è più, quindi mancata firma va tolto."_
>
> ⚠ §10.4's "DocuSign may be dropped" is **superseded**: digital for the commercial document, paper for the event document.

> **② The asset state machine keeps _Assegnato_, redefined.** Signature previously drove _Assegnato_; with signature gone from the ticket flow Elena proposed deleting the state. Sabatino asked to keep it, redefined as **documentation + QR emailed to the named participant** — his justification is reporting, not process: _"ci fa statistica per capire quante persone hanno il biglietto nelle mani"_ (01:33:49).

> **③ Bundle duplication removed** (00:39:50). Bundles are created **only in Salesforce, only by administration**; single products keep coming from Mexal. The stage-sale vs tutor-recall distinction now rides on the **Opportunity typing**, not a second bundle mechanism.

> **④ The "choose your event" landing page is deleted** (01:07:16). ROMI had assumed a buyer holding a multi-event bundle would pick which event to register for. Sabatino: _"No, non scelgono mai loro. Noi gli diciamo cosa devono fare."_ Communications are per-event, fired on each event's own countdown. Elena removed the step live.

> **⑤ Ticket availability — §10's wording corrected, then re-corrected.** See Decisions §4; the agreed final wording is **"fattura pagata a livello di rata/tranche"** and the invoice↔tranche match is **not** by date.

---

## Decisions

### 1. Programme & commercial perimeter

- ✅ **Daniela approved the Phase 1 / Phase 2 timeline** (00:04:11). Sabatino: _"l'ha vista tutta, mi ha dato l'ok, quindi non mi ha chiesto niente."_
- 🔴 **But she approved it without knowing the scope dispute existed.** At 02:24:17 Sabatino states plainly: _"Tutto questo è pienissimo pro, però **Daniela non sapeva questa informazione qui**, quindi tocca rifare un altro giro, ma questo giro me lo faccio dopo le ferie."_ The disputed Phase 2 items — **GLS, Teachable, and the Zoho integration for Pienissimo Pro orders (Pienissimo Software Srl)** — still need _"valutazione economica contrattuale con Daniela per definire se il lavoro rientra in una fase aggiuntiva quotata o potrà essere gestita internamente da Pienissimo."_ Elena raised it at 00:06:08; Sabatino admitted he had not read the minuta flagging it: _"Io non l'ho nemmeno letto quello, ho preso direttamente il link."_
- 📅 **ROMI will produce a Phase 2 estimate on return from holidays**, explicitly outside the current project plan — Elena: _"non è incluso nel piano, nel progetto perché appunto erano cose esterne."_

### 2. Opportunity, quote and order lifecycle

- ✅ **Quote acceptance runs through a landing page, not email buttons** (00:19:21). The accept/reject-button idea was **Elisa's**; ROMI counter-proposed the landing page for a concrete reason Elena gave in-session: _"noi non abbiamo controllo su quello che mandiamo a livello di email, dobbiamo per forza rimanere sul CRM"_ — same mechanism already used for the event participant lists. Elisa and Fabrizio accepted immediately (_"ci cambia poco… come ci viene più comodo"_).
- ✅ **Quote + contract + general conditions travel as a single PDF** (00:31:52).
- ✅ **The quote is sent while the opportunity is _in trattativa_** — and the **5-day validity starts there** (Marco, 00:17:56: _"In trattativa da dove partono i 5 giorni"_). If the 5 days lapse the opportunity sits in _in attesa accettazione_, and **the same landing page still works** — the client can accept weeks later and the flow proceeds normally (00:21:05).
- ✅ **Order states: Ordinato → Fatturato → Incassato** (00:22:19). The previous **"Chiuso acquisito" is deleted** — Fabrizio Paganelli: _"non serve più."_
- ✅ **Opportunity goes Closed Won only when the order reaches _Incassato_**. This was Fabrizio Paganelli's own live correction: _"ti faccio una rettifica … l'opportunity deve andare in vinto quando l'ordine assume lo stato di incassato."_
- 🟡 **A fourth order state, _Perso_, was floated but not decided.** Fabrizio Paganelli, on credit notes: _"Dopo potrà avere uno stato di perso se ci faccio una nota di credito. Non lo so come funzionerà."_ Elena separately flagged the set looks thin: _"questi sono gli stati per ora degli ordini, poi capiamo perché in realtà mi sembrano troppo pochi."_ → open.
- ✅ **Performance Plus opportunities must be typed by the tutor at creation** — **attivazione** vs **rinnovo** (00:27:39). Manual and mandatory. ROMI had wanted to derive it from the product code; that was rejected because, in Elena's words back to the client, _"avevate detto che avevate troppa fantasia sui product code."_ The value is carried up to the order, where an order type "plus" triggers contract generation. Marco endorsed the principle: _"è giusto che la gestisca il tutor che poi deve andare a generare il contratto."_
- ✅ **Service start/end date is owned by the Strategist, not by the contract** (00:33:36–00:36:45). Contract signature ≠ service start; Marco: _"il cliente va in coda e magari mi firma il contratto oggi, ma io in realtà parto tra una settimana, tra 20 giorni, tra un mese."_ Aurel proposed capturing it at order-line entry; **rejected** — Marco: _"non lo possono mettere perché non lo sanno, non ce l'hanno quel dato."_ Agreed: the **Strategist** (two people; possibly a single department mailbox) enters the real date at kick-off, prompted by **both a page banner and an email alert** when the field is empty.
- ✅ **Partita IVA becomes a mandatory field on the live-stream lead forms** (00:11:11). Sabatino accepted with eyes open: _"il più delle volte mettono una partita IVA finta… c'è chi mette 00, chi mette 1111."_ It is corrected at payment time. Today the form collects name, company and venue type.

### 3. WooCommerce

- ✅ **Integration is via Webhooks** (02:06:22) — Sabatino: _"Faremo Webhook."_ Decided against polling, on the basis of the analysis document Sabatino shared. Closes the first of §10.5's three open decisions.
- ✅ **"Crea link" button on Opportunity for the "Recall tutor" opportunity type** (00:38:03), generating the WooCommerce checkout link carrying the Salesforce Opportunity id, with **product type and quantity selectable** on the button, emailed to the client.
- ✅ **ROMI supplies a provisional email template** for the link until Pienissimo provides their own (02:24:17).
- 📅 **From 26 August**: credential exchange, a product id, PHP placement and sample-payload tests. Sabatino estimates ~an hour of joint work: _"se ci mettiamo in call anche un'oretta la facciamo veloce."_ Payload mappings enriched iteratively.

### 4. Tickets, assets and events

- ✅ **A Mexal event product auto-creates the matching Salesforce Campaign** on the nightly product sync (00:46:02) — e.g. "Camerieri Venditori ottobre 2026" — so QR scans index attendance against the campaign.
- ✅ **A multi-event bundle auto-creates one asset per event** (00:49:15). Sabatino asked explicitly whether this was designed; Elena confirmed.
- ✅ **Asset (ticket) state machine, final:**

  | State                           | Trigger                                                                 |
  | ------------------------------- | ----------------------------------------------------------------------- |
  | **Ordinato**                    | Order lands in Salesforce; asset created                                |
  | **Disponibile**                 | The tranche invoice containing that order line is **collected in full** |
  | **Assegnato**                   | Documentation + QR emailed to the named participant                     |
  | **Utilizzato / Non utilizzato** | QR scan at the event                                                    |

- ✅ **Availability rule — "fattura pagata a livello di rata/tranche"** (01:33:49–01:45:43). This took ten minutes to converge and the nuance matters:
  - Elisa's rule: _"quel biglietto è disponibile quando la fattura con la quale l'ho fatturato deve essere integralmente pagata, tutta pagata."_ Partial payment releases **nothing**.
  - Her worked example: an order's lines are split into tranches by **due date** — events 1+2 → tranche 1 (31 Jan), events 3+4 → tranche 2 (28 Feb), etc. Each tranche is invoiced separately; when _that_ invoice is fully collected, _those_ tickets go Disponibile.
  - ⚠ **Tranche composition follows customer payment convenience, not events**: _"ci sono tot rate che vengono suddivise sulla base della gestione del cliente, non sulla base dell'evento"_ — a tranche can hold several events, and an event's ticket can sit behind unrelated items in the same invoice.
  - The net effect is what Elena originally intended (a five-event bundle does not require the whole annual order to be paid), so both settled on **"fattura pagata a livello di rata/tranche punto."**
- ✅ **The invoice must physically arrive in Salesforce, and the match is on order-line number — not date, not product** (01:45:43–01:49:17). Three steps here, all worth keeping:
  - Aurel first proposed matching invoice→tranche **by date**. **Elisa killed it**: the tranche date is the _presumed collection date_, and they invoice **in advance** — tranches due 31 Jan are invoiced at the start of January. Dates will not line up.
  - Aurel then asked whether matching on products would work. **Elisa killed that too**, decisively: _"coi prodotti noi siamo abbastanza ballerini, nel senso che un tutor può mettere anche lo stesso codice due volte nello stesso ordine."_
  - Resolution: the Mexal invoice carries **cliente, numero documento, riferimento numero d'ordine, codice articolo and numero di riga d'ordine**. Match on **numero di riga d'ordine** — Elisa: _"è bene lavorare su elementi che sono nascosti ai tutor."_
  - Aurel noted Salesforce could work from a "lines paid" signal alone; **Elena overruled** — the invoice itself is required for the agreed reporting logic: _"No, la vogliono. Non dire che non ci serve."_
- ✅ **Ticket type becomes a picklist on the product record** (00:51:36–00:54:15). Precise position: each ticket type **already has its own product code** (Camerieri Venditori Silver ≠ Gold), but Aurel argued a code cannot be filtered reliably — _"quel codice lo devi mappare su qualcosa"_. Elisa agreed to add the field: _"mettiamo un campo in anagrafica, un menù a tendina tipo biglietto, gold, executive, eccetera."_ Fabrizio Paganelli additionally to add an **event flag** on the product master (distinct from the existing bundle-eligibility flags).
- ✅ **Participant data collection** (01:01:03–01:30:29): the buyer — always the company owner who paid, and initial holder of **all** the tickets — receives a link to a landing page pre-built with one row per purchased ticket, and enters **name, surname, email and phone** per participant. Salesforce then links the contact to the asset, **creates the contact if absent**, and adds a **Campaign Member**. Each participant then receives **their own** documentation with embedded QR, which they print themselves.
- ✅ **Two distinct edge-case paths — do not conflate them** (01:50:41–02:02:13):
  - **Name change _before_ the event** → dedicated button on the account showing that account's available assets: cancel the old name, enter the new one. **A new QR is generated** (the QR document prints the participant name and event above the code, so it must be reissued) and the updated documentation is emailed **to the new person's address**. Elisa: _"sarebbe bello anche se si potesse rinviare la mail aggiornata."_
  - **Substitution or missing documents _at_ check-in** → staff verify ticket + order + payment at the infopoint, the attendee **re-signs the paper form** ("abbiamo anche delle stampe in evento"), and staff key the data in manually. **No QR is issued in this path** — Sabatino: _"facciamo entrare manualmente."_
  - Most common case is not substitution but **people who never printed or never received the email**. Elisa flagged a live root cause: some clients had **unsubscribed from marketing email** and so stopped receiving their tickets — _"era un cane che si mordeva la coda."_
- 🔴 **Elena flagged the tracking gap in the manual path**: if staff key in a substitute by hand, the person may not end up recorded as a Campaign Member with the ticket marked used. Agreed action: ROMI must specify what staff do at **Campaign Member** level — logged as "controllo check-in + aggiornamento manuale Campaign Member".
- ✅ **Credit notes** (00:44:23): a button at **order level** selects the order line to reverse, partial or total. For _evento_ products the operator must additionally **pick which contact/asset to cancel**, because one account may hold several tickets on the same order.
- ✅ **No per-bundle composition validation** (00:41:26–00:42:58). Precise scope: two product-level flags **do** exist (bundle-eligible, bundle-only — confirmed by Aurel when Fabrizio Paganelli challenged the point). What does **not** exist is validation that a given eligible product belongs in _this particular_ bundle. Elena: _"sarà onere dell'amministrazione capire cosa mettere in un bundle piuttosto che in un altro, senza controlli."_
- ✅ **Stage-sale bundle codes continue to be passed to WooCommerce manually and verbally** (00:41:26), by design.

### 5. Marketing

- ✅ **Event communication funnel fires 30–60 days before the event.** Sabatino: _"non è una regola scritta al 100%… io metterei un 30/60 giorni."_ It starts from a **tag** applied in the CRM to accounts that have paid and hold tickets, carried over to the marketing platform.
- ✅ **Per-event, never bundled**: _"L'azienda può in un bundle acquistare 10 eventi diversi, però poi a ridosso 30-60 giorni prima da uno degli eventi che ha acquistato, gli arriva la comunicazione esclusivamente per quell'evento."_
- ✅ **Trigger design agreed with Sabatino's enthusiastic backing**: a **nightly job** reading the Campaign start date, selecting accounts holding ≥1 ticket for that event at start-date − 60 days. Aurel proposed it; Sabatino: _"se riesci a fare una cosa così sarebbe molto [buono], così possiamo rendere il tutto automatico."_
- 🟡 **Who hosts the participant-data landing page is undecided.** Aurel asked whether marketing would use the Salesforce community; Elena's read is that marketing has its own logic and its own landing page (_"c'avranno il loro landing page"_). Rebecca's call will settle it.
- ✅ **The per-participant QR email is sent from Salesforce, not marketing** — confirmed by Elena at 02:00:54. Only the opening funnel communication is marketing-side.
- 📅 **Rebecca Marmo** (`rebecca.m@pienissimo.com`, per Sabatino in-session) owns the ticket funnels and joins **all** flow/field/ticket calls from now on. Available the week after Ferragosto; Matteo available that week too. Sabatino wants **both** of Pienissimo's ready-made funnels pointed at tickets: _"sono gli unici funnel che ci interessano già pronti; quelli marketing ce li creiamo noi."_
- ➖ **Review of the 100+ marketing forms was deprioritised by the client** — Elena raised it at 02:27:15 and got no engagement ("Vi interessa poco?").

### 6. Data quality & migration

- ✅ **VAT validation moves into Salesforce, at the first order of an account.** The as-is flow, described by Elisa (02:10:02): before invoicing, a system reads the order's client VAT, checks whether it already exists in the Mexal registry, and if not calls a **business-information service** returning **ragione sociale, address, PEC and legal representative** — giving a registry _"corretta al 99,5%"_. **Elisa proposed relocating it**: fire the call in Salesforce when the order is generated, write the official data straight into Salesforce, _"per cui quando Salesforce passa i dati a Mexal siamo sicuri che i dati sono già puliti."_ Elena: _"Questo mi piace molto."_ Same rule for WooCommerce orders.
- ✅ **Why at first order, not at account creation** — Elisa's cost argument: free events (tour, Food Marketing) draw 3,000 registrants, **6,000 at Food Marketing last year**, of whom perhaps 250 buy. Validating every registration would cost _"un sacco di soldi."_
- ✅ **Design constraints added by Aurel, all accepted**: an account already checked carries a **"consolidato" flag** and is never re-checked; failures send a **notification email to an administration address Pienissimo will provide**; and a **manual re-check button** sits on the order and on the account (account-side being a manual action, same API). Today a failed VAT blocks order generation in Mexal and admin phone the client to fix it by hand.
- ✅ **Migration volumes and the cleanup key**: the Zoho client registry holds ~**17,000 records**, of which only ~**8,500** are real clients with a registered ragione sociale; the rest is deleted up front. The operative filter is the **Mexal client code** — Elisa: _"andremo a caricare solo i clienti che hanno il codice cliente Mexal."_
- ✅ **Field mapping keeps the original Zoho labels.** The client module carries ~**150 fields of which roughly a quarter are used**; Elisa and Fabrizio will list only what is worth moving, writing the **Zoho label** in column A. Aurel does the mapping at insert time, preceded by a **joint field-by-field call** (_"10 minuti di call… su Zoho è così, su Salesforce è così"_). Mapping was ~95% complete at session time, promised for the following day.
- 🟡 **Lead and Referente/Contatti sheets are the exception** — Elisa declined to do them alone: _"corro il rischio di fare un lavoro molto sbagliato perché non sono sufficientemente competente."_ To be done three-handed with **Sabatino and Marco**.
- 🟡 **Asset fields deliberately deferred.** Elisa listed what they hold today — **evento/edizione, anno accademico, anno di competenza** (the last drives the ticket "magazzino" movement) — but declined to freeze them into the workbook before the flow review: _"può essere fase di discussione che si potrebbe cambiare il modo in cui lo facciamo."_
- 📅 Andrea Di Cicco sends a file of open **Mexal field-mapping questions**; Elisa answers, escalating to Kreosoft where needed.

### 7. Lead management

- 🟡 **Lead routing.** Today Zoho round-robins one lead per tutor and Marco says that no longer works: _"questa cosa qui non va più bene."_ Agreed direction is **queues segmented by service type and/or geography** (province/region) with automatic assignment on the fields available at lead level. Elena noted **load-based automatic assignment is not available** on their licences (it is a Case-oriented capability), so the practical answer is **rules + mass transfer**: select many leads and reassign in two clicks when a tutor is free. **Marco owes the concrete desiderata** once he has seen the real platform.

---

## Action Items

| #   | Task                                                                                                        | Owner                                         | Due                       | Status             |
| --- | ----------------------------------------------------------------------------------------------------------- | --------------------------------------------- | ------------------------- | ------------------ |
| 1   | Send Elisa the recording of the earlier call where she and Fabrizio Paganelli disagreed on order generation | Elena Spini                                   | after holidays is fine    | Open               |
| 2   | Add the Partita IVA field to the live-stream form                                                           | Sabatino Rinaldi                              | —                         | Open               |
| 3   | Update the process diagram (order states, landing-page acceptance, ticket flow) and circulate               | Elena Spini                                   | 07–08/08                  | Open               |
| 4   | Enter the real service start date on the Salesforce contract                                                | Strategist (×2, per department)               | ongoing                   | Open               |
| 5   | Build banner + email alert when the contract start-date field is empty                                      | ROMI                                          | —                         | Open               |
| 6   | Add ticket-type picklist, ticket info fields and event flag to the product master                           | Fabrizio Paganelli                            | —                         | Open               |
| 7   | Organise the marketing-funnel meeting with Rebecca Marmo, Marco, Matteo                                     | Elena Spini                                   | week of 18/08             | Open               |
| 8   | Organise the asset fields + ticket flow review meeting (Rebecca included)                                   | Elena Spini + Elisa Migliano                  | after 17/08               | Open               |
| 9   | Complete Zoho→Salesforce field mapping (Zoho labels in column A)                                            | Elisa Migliano + Fabrizio Paganelli           | 07/08 promised            | In progress (~95%) |
| 10  | Map the Lead and Referente/Contatti sheets, three-handed                                                    | Elisa + Sabatino + Marco                      | post-Ferragosto           | Open               |
| 11  | Clean Zoho data — isolate the ~8,500 clients holding a Mexal client code                                    | Elisa Migliano + Fabrizio Paganelli           | post-Ferragosto           | Open               |
| 12  | Send file of open Mexal field-mapping questions                                                             | Andrea Di Cicco                               | —                         | Open               |
| 13  | Answer the Mexal mapping questions (escalate to Kreosoft if needed)                                         | Elisa Migliano                                | —                         | Open               |
| 14  | Build the edge-case button (name change) + QR reissue + updated email                                       | Aurel Mrruku + Elena Spini                    | —                         | Open               |
| 15  | Specify Campaign Member handling for manual check-in entries                                                | ROMI                                          | —                         | Open               |
| 16  | Send list of significant articles + list of events                                                          | Elisa Migliano                                | 07/08                     | Open               |
| 17  | Send example bundles with identifying codes                                                                 | Elisa Migliano                                | 07/08                     | Open               |
| 18  | Send real catalogue prices (ROMI still using placeholders)                                                  | Fabrizio Paganelli / Elisa                    | —                         | Open               |
| 19  | Exchange WooCommerce webhook credentials + product id                                                       | Sabatino Rinaldi + Aurel Mrruku               | from 26/08                | Open               |
| 20  | Run webhook integration tests with sample payloads                                                          | Sabatino Rinaldi + Aurel Mrruku               | from 26/08                | Open               |
| 21  | Provide Andrea Parmeggiani's contact (`a.parmeggiani@pienissimo.pro`) and Rebecca's                         | Sabatino Rinaldi                              | —                         | Open               |
| 22  | Hold the technical call on the VAT-service integration (include Elisa, Rebecca)                             | Elena + Sabatino + Andrea Parmeggiani + Aurel | 3rd week Aug              | Open               |
| 23  | Provide the administration email address for VAT-validation failure notices                                 | Pienissimo                                    | —                         | Open               |
| 24  | Send invitations for the four August meetings                                                               | Elena Spini                                   | today/tomorrow            | Open               |
| 25  | Brief Rebecca on the appointment plan                                                                       | Marco Montesi                                 | immediate                 | Open               |
| 26  | Define the automatic lead-distribution/queue logic                                                          | Marco Montesi                                 | after seeing the platform | Open               |
| 27  | Re-open the Pienissimo Pro / Phase 2 scope conversation with Daniela — **she was never told**               | Sabatino Rinaldi                              | after holidays            | 🔴 Open            |
| 28  | Produce the Phase 2 cost/effort estimate                                                                    | Elena Spini + Andrea Di Cicco                 | after holidays            | Open               |

---

## Open Questions / Risks

- 🔴 **The Phase 2 commercial perimeter is not merely unresolved — the decision-maker was uninformed.** Sabatino's own words: _"Daniela non sapeva questa informazione qui, quindi tocca rifare un altro giro."_ Her timeline approval therefore cannot be read as scope or budget acceptance, and Sabatino has deferred the correcting conversation to after the holidays. Fourth consecutive meeting/status carrying this item.
- 🔴 **Everything material lands in a single week.** With returns staggered to 17/24/25/31 August, the WooCommerce webhook build, the VAT-service integration, the Zoho mapping and import, the asset-flow review and the marketing funnels all begin **26–29 August** — against a **6 October go-live** and a **31 October Zoho expiry**. Elena said it in-session: _"a voi scade il contratto di Zoho."_
- 🔴 **Manual check-in entries may break attendance reporting.** Elena raised it, Elisa waved it off on the strength of experienced infopoint staff (_"ci sono delle persone valide che capiranno cosa devono fare"_). The Campaign Member update is still undesigned — and attendance/no-show analytics is a stated project goal.
- 🟡 **The asset/ticket flow is not fully specified and Elisa had not seen it before this session** (01:26:58) — she asked for a dedicated review before committing asset fields to the workbook. Sabatino's prediction stands: _"vedrai che anche dopo lo sviluppo esce qualcosa che tocca cambiare."_
- 🟡 **Order states may be incomplete** — a _Perso_ state tied to credit notes was floated and left undecided, and Elena thinks three states are too few.
- 🟡 **Ticket delivery must not depend on marketing opt-in.** Elisa's account of clients unsubscribing and then not receiving tickets is a live defect in the as-is; the new design sends the QR email from Salesforce, which should fix it, but the funnel that precedes it is still marketing-side.
- 🟡 **Fake VAT data at lead capture is accepted by design**, which loads the burden onto the order-time validation — making its unhappy path (notification address, re-check button) more load-bearing than it looks.
- **TBD — the VAT information provider is not unambiguously named.** The audio garbles it ("Antisipei / Anticipi… Tiscay ec credit safe"); prior meetings reference **Anticipay**, and **CreditSafe** surfaces here. Elisa confirmed the service is **already live and working** and that she can hand over the existing references. → confirm provider, endpoint and credentials with Elisa.
- **TBD — who hosts the participant-data landing page** (Salesforce community vs marketing platform). Rebecca's call decides.
- **TBD — whether the Strategist alert goes to two named users or a single department mailbox.** Marco: _"probabilmente hanno una mail unica di reparto… magari mandiamo una mail unica, poi se la smazzano loro."_

---

## Notes

- Elena chaired from a written recap circulated by email beforehand, walking the group through it for confirmation before moving to open points — the reason the session produced this many closed decisions.
- Fabrizio Paganelli asked for the recording of the previous call _"dove io e Elisa non eravamo d'accordo"_ so Elisa could hear where the disagreement lay; the disagreement in question was precisely the order-generation trigger, which he then resolved in Elisa's favour at 00:15:17.
- ROMI is still building demos on **placeholder prices** — real catalogue prices remain outstanding after "800 meetings" (Elena's phrase).
- The session overran its 15:00–17:00 slot by half an hour and closed with holiday farewells. It is the last substantive working session before the August break.
