---
id: meeting-2026-10-23-import-ordini-migrazione
type: meeting
status: resolved
owner: Aurel Mrruku
org: both
raised: 2026-10-23
updated: 2026-10-23
source: meetings/2026-10-23-import-ordini-migrazione-transcript.it.md
---

# 2026-10-23 Import Ordini Migrazione

**A six-and-a-half-minute call, called the same afternoon because a mail thread
was going nowhere. It settled who fixes the product registry and in which
system, and it produced two things the written record did not have: the whole
Mexal-Salesforce product synchronisation is switched off in UAT, and the net
amount already reaches Mexal while the list price does not.**

| | |
| --- | --- |
| **When** | 2026-10-23, 16:00 CEST (14:00Z), **00:06:29** |
| **Invited** | `amministrazione@pienissimo.com`, Fabrizio Paganelli, Elena Spini, Aurel Mrruku |
| **Spoke** | Aurel Mrruku, Fabrizio Paganelli |
| **Source** | full raw transcript, preserved at [meetings/2026-10-23-import-ordini-migrazione-transcript.it.md](../../meetings/2026-10-23-import-ordini-migrazione-transcript.it.md) |
| **Cost** | Google Doc `1UMjx0vHYEyknv_7cj9ntmX43P6Sej0tpG5d5t-mbIsU`, ~12.3 KB, read once |

⚠ **Elena Spini scheduled it and did not attend**, by her own choice — Slack DM
`D0B5QHS2T7H` 15:45:36 CEST: _"io non ci sono ahaha lo vuoi ascoltare te?"_ The
third time in the record she books a client call she is absent from.

## Why it happened

The mail thread `Import Ordini` (Gmail `1a168166785585be`) ran four rounds in
forty minutes without resolving a single question. Aurel Mrruku's reaction to
the last of them, in DM at 15:36:11 CEST:

> _"facci fare una call che con questo non se ne esce"_

🔑 **So the call is the mail thread's failure, not an addition to it** — and it
took six minutes to settle what four mails could not.

## What was decided

🟢 **Fabrizio Paganelli updates the product registry in Mexal, not in
Salesforce, and ROMI re-imports afterwards.** Aurel Mrruku opened on the other
side of it — _"i prodotti ci sono, te li ho messi tutti attivi, quindi devi
semplicemente fare la mappatura e hai fatto"_, and then _"è una un test, non è
un in produzione … ma qua non serve"_ — and conceded once Fabrizio Paganelli
insisted the data has to end up right in the ERP regardless:

> _"ma va bene che è un test, però visto che devo mettere la in mano
> l'anagrafica prodotti, tanto vale che lo faccio una volta per tutte"_

🔑 **The reason the client needs it is the edizione mapping**: the Mexal
`categoria statistica` is what identifies the event, and the old article codes
do not carry one. _"La categoria statistica individua l'evento."_ Aurel
Mrruku's first proposal — assign categories in bulk, _"prendi tutte le
categorie … saranno tre, quattro, penso"_ — was refused on the facts:
_"c'è una categoria per ogni evento, Aurel, più le categorie della della PL."_

### The agreed sequence, with its handoffs

| # | Who | What |
| - | --- | ---- |
| 1 | Fabrizio Paganelli | Extract the full product registry from Mexal, update the `categoria statistica` values in an Excel file. **He expects to finish Monday** — _"io lunedì riesco."_ |
| 2 | Fabrizio Paganelli | Send that file to Mirko Merendi at Kreosoft, who had already agreed to the route _"tempo fa."_ |
| 3 | Mirko Merendi | Run the mass update on Mexal. |
| 4 | Fabrizio Paganelli | **Mail Aurel Mrruku the moment it is done** — _"appena finisce Mirko, mandami una mail."_ |
| 5 | Aurel Mrruku | Re-import the products into Salesforce — _"lo prendo in quell'esatto momento e faccio io poi l'importazione dei prodotti."_ |
| 6 | Fabrizio Paganelli + Mirko Merendi | Agree which fields the order lines must carry (continues at [the Monday call](../items/OI-284%20The%20listino%20sconto%20and%20netto%20mapping%20for%20Mexal%20orders%20is%20undefined.md)). |

🔴 **Step 4 is a mail, and it is the only thing connecting steps 3 and 5.**
Nothing else detects that Mexal has changed, because of the next finding.

## 🔴🔑 The product synchronisation flows are switched off

Stated by the client as an assumption and confirmed:

> **Fabrizio Paganelli:** _"Perché adesso i flussi di sincronizzazione sono
> disabilitati, chiaramente."_
>
> **Aurel Mrruku:** _"li ho disabilit[ati] ci sto lavorando per quello."_

🔑 **This was not in the record.** The client's opening assumption had been the
opposite — _"io per fare queste modifiche le faccio su Maxal e poi questa notte
viene tutto sincronizzato"_ — i.e. that the nightly sync would carry his Mexal
edits into Salesforce by itself. It will not.

Consequences, none of them stated in the call:

- The whole registry update of steps 1–3 reaches Salesforce **only** through
  Aurel Mrruku's manual re-import at step 5. If the mail at step 4 is missed,
  the mapping is built against stale categories.
- ⚠ **Nobody said when the flows go back on, or who checks.** It is the fifth
  migration-only condition of this kind, after the Mexal-send bypass
  ([OI-267](../items/OI-267%20Loading%20historical%20orders%20would%20push%20them%20to%20Mexal%20and%20generate%20tickets.md)),
  the edizione date reversal, the Performance Plus bypass
  ([OI-280](../items/OI-280%20Performance%20Plus%20contract%20generation%20must%20be%20bypassed%20for%20migrated%20orders.md))
  and the whole-catalogue activation
  ([OI-276](../items/OI-276%20Dummy%20import%20editions%20are%20needed%20to%20load%20historical%20orders.md)).
  Unlike those four, **this one has an owner by his own statement** — he
  disabled it and is working in it.
- 🟢 It also confirms the catalogue activation actually happened:
  _"ieri ti avevo detto ti metto tutti i prodotti attivi in sales force … adesso
  anche i prodotti vecchi attivi."_

## 🟢🔑 The net amount already travels to Mexal; the list price does not

The one substantive movement on
[OI-284](../items/OI-284%20The%20listino%20sconto%20and%20netto%20mapping%20for%20Mexal%20orders%20is%20undefined.md):

> _"io aspetto a sto punto solo Mirco di indicarmi qual è il campo sull'ordine,
> sulla riga dell'ordine più che sull'ordine te la posso far passare anche
> l'amount netto, quindi di listino, scusa che il netto lo passiamo già"_

Read against the 22/10 record, this says three things:

1. 🟢 **`netto` is already sent.** The gap is narrower than the 22/10 note
   implies — what is missing is the **list price**, and the discount.
2. 🔑 **The missing mapping is on the order _line_, not the order header** —
   _"sulla riga dell'ordine più che sull'ordine."_
3. 🔴 **ROMI is blocked on Kreosoft and on nothing else.** The only named
   dependency is Mirko Merendi naming the field.

⚠ **The percentage-versus-amount disagreement was not reopened**, so it stands
where 22/10 left it, unresolved, and goes to the Monday call.

## 🟡 The discount does not recalculate on screen, and the edit path exists

The client ran a live test during the call and reported a second symptom on the
`Gestisci Prodotti` component:

> _"prezzo di listino, sconto e nuovo prezzo. Se io qui ci metto il 20%, vedi,
> non si non si aggiornava sta cosa"_

⚠ **He ran it on a new Opportunity**, not on an existing order — _"vado
direttamente a a inserire una nuova opportunità sull'azienda"_ — which is the
path [OI-283](../items/OI-283%20Discounts%20cannot%20be%20edited%20on%20an%20existing%20order.md)
recorded as **untested**. So that note's open question is answered on the quote
side: the same component is incomplete there too.

🟢 **And an edit path was demonstrated.** Aurel Mrruku walked him to it:
_"Fai gestisci i prodotti adesso. Eh, vedi che c'è la matita a destra?"_ →
_"Fai modifica, vedi che la puoi modificare."_ Fabrizio Paganelli accepted it —
_"Ah, perfetto. Così lo posso modificare"_, _"Va benissimo, dai, va
benissimo."_

🔑 **This does not close OI-283.** Three reasons, all from the record:

- Aurel Mrruku was describing **work in progress**, twice — _"È proprio su
  questa schermata che sto lavorando"_ and _"sto lavorando proprio su questo
  componente"_ — and _"questo stavo aggiustando stamattina"_.
- The demonstration was on the **quote**; OI-283 was raised against an
  **existing order**, after a PDF had been generated. That path was not retried.
- 🔴 **The build is not on `DevMain`.** Anita Aga's `3c66b27` _"Modified the
  Gestici Prodotti Component"_ (16:26 CEST, 25 minutes after the call) touches
  `quoteManageProducts` and its controller and sits unmerged on `DevAnita22`.

## After the call

| When (CEST) | Where | What |
| ----------- | ----- | ---- |
| 16:07:04 | DM `D0B5QHS2T7H` | Aurel Mrruku: _"risolto"_ (❤ from Elena Spini) |
| 16:08:16 | same | Elena Spini: _"facile?"_ |
| 17:01:33 | same | Aurel Mrruku: _"niente è facile con lui"_ |
| 17:01:50 | same | _"sta aggiornando tutti i prodotti su mexal e li prendo da la"_ — the sequence above, confirmed as under way |

## What it did not touch

- 🔴 **[OI-212](../items/OI-212%20A%20Ri.Ba.%20rate%20reads%20as%20paid%20before%20its%20due%20date.md)** — not mentioned.
- ⚠ **[OI-274](../items/OI-274%20The%20historical%20ticket%20balance%20has%20no%20migration%20path.md)**,
  the ticket balance, not mentioned — a second consecutive client call, and the
  same morning ROMI put its scope position on the subject in writing
  ([OI-285](../items/OI-285%20ROMI%20asked%20the%20client%20to%20route%20future%20out%20of%20scope%20requirements%20through%20change%20requests.md)).
- ⚠ **Zoho** — not named. Seventh consecutive run.
- ⚠ **The picklist workbook** ([OI-265](../items/OI-265%20Opportunity%20Categoria%20and%20Sottocategoria%20values%20do%20not%20match%20the%20client%20registry.md))
  — not raised, although `categoria` values were the subject of the call. 🔑 The
  two are different registries (Mexal `categoria statistica` vs the Opportunity
  picklists) and nobody connected them.

## Dictation caveats

Gemini renders Mexal as _"Maxal"_/_"Maxale"_/_"Maxile"_/_"Maxali"_, Salesforce
as _"sales force"_/_"salce"_/_"sal"_, Mirko as _"Mirco"_, and emits stray
tokens (_"Ja"_, _"Что"_). Repairs inside quotations are bracketed. ⚠ The
speaker labels in the discount exchange interleave oddly — _"e sto lavorando
proprio su questo componente"_ is attributed to Aurel Mrruku mid-way through
Fabrizio Paganelli's sentence — and are read by content, per the standing
caveat.
