---
id: meeting-2026-10-27-anagrafica-articoli
type: meeting
status: resolved
owner: Aurel Mrruku
org: both
raised: 2026-10-27
updated: 2026-10-27
depends_on: [OI-276, OI-291, OI-293]
blocks: [go-live]
source: meetings/2026-10-27-anagrafica-articoli-transcript.it.md
---

# 2026-10-27 Anagrafica Articoli

**A half-hour working call that put the production data load on a date — "entro
domani sera" — and surfaced a maintenance cost nobody had written down: changing
an edizione's date does not move its product-edition mappings, so roughly twenty
records have to be edited by hand each time a real event date is confirmed.**

- **When:** Tuesday 2026-10-27, 12:00 CET, **00:28:08**.
- **Who:** Aurel Mrruku (ROMI); Fabrizio Paganelli (Pienissimo). Elena Spini and
  `amministrazione@pienissimo.com` were invited and did not speak.
- **Source:** full raw transcript, drilled once —
  [the preserved record](../../meetings/2026-10-27-anagrafica-articoli-transcript.it.md)
  (Drive `1x9PiTol4OV3Sp7SeQc8Ve00QGC2IF8Mc-2JPL5oToYY`, 22,723 bytes, owner
  `e.spini@romicompany.com`). No recording was produced.
- **Why it happened:** Fabrizio Paganelli's 09:28:19Z mail _Inserimento
  Campagne_ raised four points; this call answered all four.

## 1. The production load has a date

Aurel Mrruku opened with it, `00:01:14`:

> _"mi sto occupando del del play [release] in produzione, sta andando
> abbastanza bene, dico la verità, quindi spero entro domani sera finiamo non
> tutto, ma almeno i metà dati e le strutture."_

🔑 **Stated to the client, unprompted.** The same statement, with more detail,
was made internally five hours later —
[the follow-up](2026-10-27%20Follow-up%20Interno.md). ⚠ **How this relates to the
agreed 9 November technical release is nowhere addressed**, by either side; see
[OI-268](../items/OI-268%20The%20client%20proposed%20a%20go-live%20calendar%20of%2016%20November.md).

## 2. The agent registry, asked for and delivered the same hour

Aurel Mrruku needs a clean agent list to create production users and to attach
migrated accounts: **nome, cognome, email, codice agente, categoria provvigione
cliente** — _"così io creo in produzione le utenze pulite e poi quando vado a
caricare gli account in base al codice agente che mi passi te riesco a fare la
mappatura"_ (`00:07:26`).

🔴 **The reason is a defect in the client's own data**, `00:03:29`–`00:07:26`:

> **Aurel Mrruku:** _"Però là ho notato che con lo stesso codice avete due
> agenti."_
>
> **Fabrizio Paganelli:** _"con lo stesso codice abbiamo due agenti nei
> movimenti storici."_
>
> **Aurel Mrruku:** _"perché quando carico io quei account non so a quali dei
> due."_

**The ask was explicitly everything, including retired agents** — _"ma di tutti
gli agenti, anche quelli che non ci sono più, perché gli account sono collegati
a un codice agente"_ — because the account-to-agent join is by code, not by
name. Zona is **not** held on the agent: _"la zona l'abbiamo spostato sull'account,
non sulla gente."_

Delivered 22 minutes after the call ended; see
[OI-293](../items/OI-293%20The%20agent%20registry%20for%20the%20production%20load%20may%20be%20incomplete.md)
for what arrived and why it may not be what was asked for.

## 3. The parent-campaign filter was fixed between the mail and the call

> _"prima questa cosa qua sul filtro l'abbiamo aggiustato, **era una mancanza
> nostra**, quindi adesso quando vai su campagna controllante … qua vedrai solo
> le campagne evento, quindi parent."_ (`00:08:27`)

🟢 Traceable in the repository: Anita Aga's `5faac77` _"Added the filter on
ParentId field on Campaign"_, **12:00 CET** — the minute the call started — one
file, `Campaign/fields/ParentId.field-meta.xml`, merged to `DevMain` by Aurel
Mrruku at 12:44 CET as PR #115. **Raised 10:28 CET, fixed 12:00 CET.**

## 4. Dates on an unscheduled event, and the cost of changing them

Fabrizio Paganelli's case is **Food Marketing Festival 2027**, which has no
confirmed date and already has orders against it. `Data evento` and `Data invio
biglietto` are required fields.

🟢 **Agreed mechanism:** enter a deliberately far-future provisional date so the
ticket-send automation does not fire, then correct it —

> _"nessuno ti vieta di mettere una data troppo in là e poi la modifichi nel
> momento in cui tu hai la data precisa … metti una data molto in là, quindi che
> sai che non scatta l'automatismo dell'invio dei biglietti."_ (`00:08:27`)

🔑 **Note the direction.** For *future* events the rule is **put the date far
ahead** so marketing does not pick it up; for the *historical import* the rule
recorded on 26/10 is the mirror image — _"l'importante è che la data non sia nel
futuro, perché altrimenti marketing prenderà il link"_
([OI-276](../items/OI-276%20Dummy%20import%20editions%20are%20needed%20to%20load%20historical%20orders.md)).
Both are the same automation seen from two sides, and **neither is written into
the requirement register.**

🔴 **The cost is manual and recurring** — see
[OI-291](../items/OI-291%20Changing%20an%20edizione%20date%20does%20not%20update%20its%20product%20mappings.md).
Aurel Mrruku, `00:11:06`–`00:14:59`:

> _"se le cambi sull'edizione non ti cambia niente sui record … sappi che tu puoi
> avere anche una ventina di prodotti, quindi una ventina di mappature con questa
> [edizione], quindi devi andare 20 volte su ogni record a cambiare sta cosa."_
>
> _"Sì, sì, **è un casino**. … Ok, è il lavoro in più per te, Fabrizio."_

🟢 **Already-generated orders and tickets are not affected** — _"se i biglietti
sono stati generati e inviati non ti cambia niente"_; Fabrizio Paganelli
confirmed that is what matters to him. The exposure is orders **not yet
created**.

🟢 Restated at the close: **campaign date ranges must not overlap** — _"le date
non devono essere sovrapposte."_

## 5. The client was taught to edit a picklist in Setup

The `anno accademico` request from the morning mail was answered by walking
Fabrizio Paganelli through **Object Manager → Campaign → Anno Accademico →
Values → New**, scoped to the Edizione record type, with the default flag
explained (`00:17:57`–`00:21:07`). Aurel Mrruku's reason: _"ti guido che è
meglio, così impari anche te."_ Fabrizio Paganelli screenshotted the path —
_"Lo sai che non me lo ricorderò mai questo percorso."_

⚠ **Recorded as it happened, not endorsed.** A client administrator adding
picklist values directly in production Setup is a configuration path that no
note, requirement or runbook covers.

## 6. Test records: deleted live, and the test products stay

Fabrizio Paganelli asked to clear the test mapping records; Aurel Mrruku did it
by code during the call (`00:23:29`), noting aloud:

> _"devo dire anche i ragazzi che stanno facendo dei test non saranno felici."_

⚠ **ROMI colleagues were testing against those records at the time.** This is
the UAT cleanup Fabrizio Paganelli had asked for by mail at 07:53Z and that Aurel
Mrruku had pushed back on as high-effort — the mapping subset was granted, the
wider cleanup was not: _"ci perdo una settimana per pullire tutto"_ /
_"non finiamo manche settimana prossima se devo fare una pulizia."_

🟢 **Products are deliberately left active** because a mapping requires an active
product: _"nelle mappature i prodotti devono essere attivi per essere collegati a
una mappatura."_

🔑 **And the `S`/`N` flag means something other than ROMI believed.** Fabrizio
Paganelli, `00:24:49`:

> _"io qui la S la S l'ho messa solo sui prodotti che sono stati movimentati dal
> primo gennaio 24"_
>
> **Aurel Mrruku:** _"Ah, ok. **Non lo sapevo.** Non lo sapevo."_

So `Gruppo Merceologico = S` marks **products moved since 1 January 2024** — the
same cut-off as the order extract
([OI-244](../items/OI-244%20Historical%20orders%20will%20be%20migrated%20from%20Mexal%20by%20spreadsheet.md))
— and not "sellable". Aurel Mrruku judged it harmless because no sales movement
references an `N` product, on Fabrizio Paganelli's word: _"nei movimenti di
vendita non hai dei prodotti con N."_ ⚠ **Unverified against the data.**

## 7. The nightly Mexal alignment was confirmed to the client

Fabrizio Paganelli, `00:25:48`:

> _"poi dopo quando tu in notte … farai l'allineamento tra Mexal e Sales Force,
> tipo se io oggi vado su Mexal e cambio … questa categoria qua … in notte quando
> mi fai l'allineamento qui si adegua a quello che c'è su Mexal[?]"_
>
> **Aurel Mrruku:** _"corretto, corretto."_

🔴 **This contradicts the standing record and nothing here resolves it.** On
23/10 Aurel Mrruku said the product sync flows were **switched off** in UAT —
_"li ho disabilit[ati] ci sto lavorando per quello"_ — and the 26/10 sweep
recorded explicitly that nothing had said they were back on. A verbal
confirmation to the client is not evidence that they are. ⚠ **The org was not
opened.** Which environment the answer refers to is also unstated.
