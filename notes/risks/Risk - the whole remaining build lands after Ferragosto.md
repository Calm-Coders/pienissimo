---
id: risk-ferragosto-compression
type: risk
status: open
severity: high
owner: Elena Spini
org: both
raised: 2026-08-06
updated: 2026-09-03
blocks: [go-live]
source: meetings/results/2026-08-06-chiusura-punti-aperti.md
---

# Risk - the whole remaining build lands after Ferragosto

Everything material was pushed past the Italian August break in the 2026-08-06
session. Sabatino Rinaldi, Aurel Mrruku and Andrea Parmeggiani are out until
roughly **24–26 August**; Elisa Migliano returns **17 August**.

**The restart calendar is now fixed** (confirmed by calendar invitations and
Elena Spini's 7 August status), against a **6 October go-live** and a
**31 October** Zoho expiry:

| Date       | What                                                                                            |
| ---------- | ------------------------------------------------------------------------------------------------ |
| **19 Aug** | [Marketing funnels](../items/OI-81%20Event%20communication%20funnel.md) — both ticket-focused    |
| **20 Aug** | [Asset flow](../items/OI-82%20Asset%20flow%20needs%20a%20dedicated%20review.md) — Elisa's, on things _"di cui non abbiamo mai parlato"_ |
| **25 Aug** | [Anticipay VAT integration](../items/OI-73%20VAT%20validation%20moves%20into%20Salesforce.md) — with Andrea Parmeggiani |
| **27 Aug** | [WooCommerce webhooks](../items/OI-49%20WooCommerce%20checkout-link%20flow.md) — credential exchange |

Not yet scheduled and still due in the same window: the
[Zoho field mapping call](../items/OI-79%20Migration%20volumes%20and%20mapping%20method.md),
the [import template](../items/OI-88%20Zoho%20import%20template%20owed%20to%20Pienissimo.md)
ROMI owes, and the
[phase 2 estimate](../items/OI-83%20No%20phase%202%20estimate.md).

**Two of those four are discovery, not build.** The 20 August asset meeting
exists because administration says there are things never discussed; the
19 August marketing session has to define two flows from scratch. Design work
landing that late is worse than build work landing that late.

## The deadline is 10 September, not 6 October

`Pienissimo_Project Plan.pptx` — ROMI's own plan, 10 July, read on 2026-08-14 —
sets **"Fine sviluppi Fase 1 entro 10/09"**. The 6 October everyone quotes is
**go-live**, and the plan puts UAT, fine tuning, bug fixing, training and the
data import between the two.

So the real build window is **~24–26 August → 10 September: about two weeks**,
and into it must fit the [tranche object](../items/OI-50%20Tranche%20object.md)
(not started), the [participant flow](../items/OI-78%20Participant%20data%20collection.md)
(not designed until 20 August), [WooCommerce webhooks](../items/OI-49%20WooCommerce%20checkout-link%20flow.md)
(credentials exchanged 27 August), [VAT validation](../items/OI-73%20VAT%20validation%20moves%20into%20Salesforce.md)
(kick-off 25 August), the [quote landing page](../items/OI-68%20Quote%20acceptance%20landing%20page.md),
the [order](../items/OI-69%20Order%20state%20model.md) and
[asset](../items/OI-74%20Asset%20state%20machine.md) state models, and the
~1 September data import which depends on
[a template ROMI has not written](../items/OI-88%20Zoho%20import%20template%20owed%20to%20Pienissimo.md).

**Nobody has stated this out loud in any meeting record.** Every discussion
anchors on 6 October.

That is roughly five weeks of calendar between the restart and go-live, for
work that includes two integrations not yet started, an object
(`Tranche__c`) that does not exist, and a
[coverage debt](Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md)
that blocks deployment on its own. The data import was planned for ~1 September
and depends on a workbook Pienissimo has not finished.

Nothing about this was framed as a risk in the session — the return dates were
recorded as logistics. Elena's own status reads the go-live line drily:
_"Go-live: 6 ottobre 2026 … sta iniziando a non essere più una notizia positiva
dati tempi ahaha."_

Both **internal follow-ups on 10 and 17 August were cancelled** on 7 August, so
there is no ROMI-side checkpoint between the break and the 19 August restart.

## 2026-09-02 — ROMI is away 9-11 September, and Fase 1 development ends on the 10th

Stated by Elena Spini in the
[2 September session](../meetings/2026-09-02%20Follow-up%20Anagrafica%20Articoli.md),
while the group was picking dates:

> _"noi dal 9 all'11 siamo a un evento aziendale, quindi 9 10 11 anche noi non ci
> saremo."_

🔴 **The end of Fase 1 development, 10 September, falls in the middle of it** —
and nobody in the room connected the two. The date was not renegotiated, and the
project plan was not mentioned.

Read against the calendar this leaves, from tonight:

| Day                    | What is on it                                              |
| ---------------------- | ---------------------------------------------------------- |
| **3 Sept**             | Data Model Parte 1, client-facing                          |
| **4 Sept**             | Data Model Parte 2, client-facing                          |
| **5 Sept**             | free                                                       |
| **7 Sept**             | Data Model Parte 3, plus the internal MKT flows session     |
| **8 Sept**             | free                                                       |
| **9-11 Sept**          | 🔴 **ROMI company event** — and Pienissimo is on tour 9-10 |

So **four working days remain before the deadline**, three of which carry a
client session, and the deadline itself is inside a company offsite. Against that
sit the eleven Anticipay fields (unbuilt), the Asset build from scratch
(unstarted), the whole Salesforce side of WooCommerce (unstarted), the campaign
parent/child model (unbuilt), the tranche remainder, and now the Mexal order
tracciato agreed on 2 September.

⚠ **This is not a claim that the date will move or that it will be missed.** It
is that the plan and the calendar have never been laid over each other in
writing, and the person who owns the plan said the words in passing while
scheduling something else.

## 2026-09-03 - the offsite is confirmed in writing, and a second absence appears

🔴 **The 9-11 September ROMI company event is now corroborated in writing.**
The record carried it only from Elena Spini's passing remark on 2 September.
Gianpaolo Motta, mailing an external contact at 14:00Z on an unrelated subject:

> _"hai spazio lunedì o martedì per una call per le attività Salesforce? (da
> mercoledì a venerdì saremo out)"_

Wednesday to Friday of next week is **9-11 September**. **The Fase 1 development
deadline of 10 September falls inside it**, and the fact that ROMI's COO is
routing external calls around it while nobody has moved the deadline is the whole
problem in one sentence.

⚠ **Elena Spini is also off 14 and 15 September.** She moved the internal
follow-up on 3 September at 15:30Z with the note _"Aggiorno il ns follow-up per il
progetto perché il 14 e 15 sarò off"_ — the 14 September occurrence goes to
**Thursday 17 September, 14:15-15:15 CEST**, and the slot is now an hour rather
than 45 minutes because _"andiamo sempre lunghi"_.

So the week after the deadline opens with the project manager away for two days
and the first internal checkpoint on the 17th. **Between 9 and 17 September there
is one working day with the full team available.**

⚠ Meanwhile the 3 September session put **sixteen more actions** into the pipe,
nine of them build or integration work on Aurel Mrruku and Andrea Di Cicco
([the minute](../meetings/2026-09-03%20Data%20Model%20Parte%201.md)), and two
further client sessions are booked for 4 and 7 September.
