---
id: OI-310
type: open-item
status: open
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: both
raised: 2026-11-02
updated: 2026-11-12
depends_on: [OI-244, OI-290]
blocks: [go-live]
source: notes/meetings/2026-11-02 Tema Contratti WooCommerce.md
---

# OI-310 - The production load needs a pre-load and a delta run

**A full production load costs three to four hours of processing, and the window
between the client's last invoicing day and go-live is one weekend. So the plan
changed on 2 November: load the product registry, accounts and contacts in
advance, then run only the delta on 12-13 November. The advance file has no
delivery date.**

## What was agreed

Aurel Mrruku, on [2 November](../meetings/2026-11-02%20Tema%20Contratti%20WooCommerce.md):

> _"riusciamo a portarlo prima almeno [l']anagrafica dei prodotti? … E a sto punto
> faccio anche un run sugli account con quelli esistenti perché voglio caricare
> anche i contatti e il 12 13 praticamente faccio solo il delta così … perché ci
> mettono 3-4 ore a caricare tutto perché sono [delle] migliaia di contatti e di
> ordini."_

> _"così io ho un buffer di qualche giorno e non lascio tutto per venerdì."_

Fabrizio Paganelli accepted, with one cost: _"per fare questo ti dovrei
riaggiornare i file di interfaccia"_ — the extract files have to be regenerated —
and estimated it at _"non ci dovrebbe voler molto"_. He will deposit a file called
a **_"versione produzione"_** in the shared folder.

🔑 **The window named for it is Wednesday, Thursday or the following Monday** —
Aurel Mrruku: _"non so, mercoledì, giovedì o lunedì prossimo"_. ⚠ **No single date
was agreed and no owner confirmed one**, so this is a preference, not a
commitment.

## What this changes about the 13 November plan

🟢 **The single-pass plan recorded in
[OI-268](OI-268%20The%20client%20proposed%20a%20go-live%20calendar%20of%2016%20November.md)
is softened, not contradicted.** The client-facing commitment stays: **12 November
is Fabrizio Paganelli's last Mexal invoicing day, 13 November 09:00 the handover.**
What changes is that most of the volume moves earlier and the dated run becomes a
delta — which is the de-risking the two-stage plan was dropped for.

🟢 **The product registry is stable** and can go early — _"l'anagrafica dei
prodotti no, è stabile quella"_. 🔴 **Accounts cannot**: the client can create one
on the last day.

🟢 **Confidence in the order load is high**: _"Sui ordini abbiamo visto che ha
funzionato tutto a meraviglia, quindi l'unico problema che posso avere è il tempo
di processare tutti i record."_ — so the stated risk is **duration, not
correctness**.

## Why it is open

1. 🔴 **No date for the refreshed interface files**, and they gate the whole
   pre-load.
2. 🔴 **The Lead and Referenti halves are not ready for it.** Aurel Mrruku asked
   the same morning for _"tutti i lead e tutti [i] contatti fino a quel momento"_,
   so **a second, later extract is now expected** on top of the delivered Lead
   file — and the Referenti tracciato has still not arrived
   ([OI-290](OI-290%20Lead%20and%20Referenti%20migration%20data%20is%20owed%20by%20the%20client.md)).
3. ⚠ **The three-to-four-hour figure is unverified against production.** It comes
   from the UAT rehearsal of 28 October.
4. ⚠ **No rollback is recorded**, for the pre-load or for the delta — unchanged
   since the single-pass plan was adopted.

## 🟢🔑 2026-11-04 - three of the four interface files arrived, and the dates hardened

**The pre-load's missing precondition — open point 1 above, "no date for the
refreshed interface files" — is now mostly answered. Three files came by mail
within fifty minutes of
[the 04/11 session](../meetings/2026-11-04%20Continuazione%20Test%20e2e%20PROD.md)
closing, against Aurel Mrruku's list: _"aspetto i vostri dati, quindi account,
ordini, contatti."_**

| Time (UTC) | Mail                             | Attachment                                     | Note                                                                                                                             |
| ---------- | -------------------------------- | ---------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------- |
| 15:39      | `Anagrafica Account`             | `Account Salesforce (rev Agente).xlsx`         | _"vi giro l'anagrafica degli account tramite mail, mi viene più comodo"_                                                         |
| 15:50      | `Lista Locali`                   | `Locali Salesforce.xlsx`                       | _"Anche questa è provvisoria"_ → [OI-333](OI-333%20Locali%20without%20a%20Mexal%20customer%20code%20will%20not%20be%20loaded.md) |
| 16:30      | `Import ORDINI - Testata e Riga` | `Import Ordini (versione del 2026.11.04).xlsx` | TESTATA + RIGA sheets — _"Fateci sapere se va tutto a buon fine"_                                                                |

⚠ **All three hold real customer records. Their existence and their filenames are
recorded; no values are copied into the repository and none of the three was
opened.**

🔴 **The fourth — Referenti — did not arrive**, and the client's answer was to reuse
the 27/28 October extract and refresh it next week
([OI-290](OI-290%20Lead%20and%20Referenti%20migration%20data%20is%20owed%20by%20the%20client.md)).
So the pre-load's contact half is a week stale by design.

🟢 **Two preconditions confirmed closed on the call:**

- **Articles need no file** — _"gli articoli non c'è bisogno che te li do perché li
  prendi da Mexal"_, confirmed by Aurel Mrruku.
- **Campaigns are already in production**, and Fabrizio Paganelli rebuilt the
  edition mappings and product-code links by hand the same morning — _"stamattina ho
  fatto anche tutta la mappatura delle campagne, delle edizioni e l'aggancio con i
  singoli codici prodotto"_, the manual work
  [OI-320](OI-320%20Event%20and%20Edizione%20mappings%20cannot%20be%20moved%20between%20orgs.md)
  forced on him. ⚠ No volume, no duration.

## 🔑 The 12-13 November window, in the client's own words

> _"il 12 e il 13 dobbiamo ricaricare di nuovo tutto … **è il 12 e il 13 che noi
> stacchiamo tutti i bottoni e loro fanno le importazioni.** Giovedì venerdì fanno
> tutto."_

His availability: **absent Monday 9**, _"martedì e mercoledì sono in ufficio … full
su sta roba"_. ⚠ **Which collides with the training sessions of Monday 9 and
Wednesday 11, 11:30-13:00**, and with the 9 November technical go-live.

🔴 **A load nobody had costed is in the same window**: Fabrizio Paganelli also
carries the Pienissimo 360 migration — _"dal mio lato c'ho anche Pienissimo 360,
devo portarmi tutte le opportunity, tutte le robe"_ — plus _"performance plus class
da mettere su ancora"_, and has to _"fare una fotografia di Zoho fino all'11 di
novembre"_ with every open opportunity. He asked for help and nobody answered:
_"**Non posso fare tutto da solo.**"_

🆕 **The invoice numerators have to change before go-live** — _"dobbiamo modificare
i numeratori"_, said in passing when a test invoice took a real number. ⚠ **No
owner, no date, and it appears in no other record.**

⚠ **Open points 3 and 4 above are unchanged**: the 3-4 hour figure is still only
from the 28 October UAT rehearsal, and **no rollback is recorded** for either pass.

## 🟢 2026-11-05 - an Account insert does not reach Mexal; an update does

Checked in source and in **Pienissimo Prod** (read-only, 2026-11-05): Prod's
`AccountTrigger`, `AccountTriggerHandler` and `ContactTriggerHandler` are
identical to `DevMain`, and the only active Account/Contact flow is
`Update_Contact_Consent`.

- 🟢 **Insert is safe.** `AccountTrigger` has no after-insert handler, and Mexal
  customer creation runs only from an order's first send or the manual
  `mexalCustomerCreateAction` button. Inserting Aziende and Locali, coded or not,
  makes no Mexal call.
- 🟢 **Contacts are safe.** The principal-email sync updates only
  `Email_Contatto_Principale__c`, which is not a Mexal-tracked field.
- 🔴 **An update is not.** `AccountTriggerHandler.afterUpdate` queues
  `MexalCustomerUpdateQueueable` for any Mexal-coded Account whose name, VAT,
  email, phone, billing or shipping address changes. The only bypass is the static
  `setBypassMexalCustomerUpdate(true)`, which Data Loader cannot set. So the
  pre-load must be an **insert**, not an upsert, and the 12-13 November delta must
  run through anonymous Apex with the bypass on, or the bypass must become a
  switch an import user can set.
- ⚠ **Prod already holds 3 Mexal-coded Aziende** (18 Aziende, 2 Locali, 3 with no
  record type). `Codice_Cliente_Mexal__c` is an external id but **not unique**, so an
  insert of the same code duplicates silently and an upsert updates and pushes.
  Exclude those codes from the file or handle them separately.

## 🟢 2026-11-05 - the Aziende pre-load is in Prod: 8,262 inserted, no Mexal call

Loaded by Claude Code at Aurel Mrruku's request from `Account Salesforce (rev
Agente).xlsx` (the 04/11 mail; values not copied here). **Insert only**, Bulk API
jobs `750SW00000bMkdBYAS` (1-row sample, checked first) and `750SW00000bMkgPYAS`
(8,261), 15:53-16:00Z. **8,262 succeeded, 0 failed.**

| Of 8,724 source rows                          | Rows  |
| --------------------------------------------- | ----- |
| Inserted as `Azienda`                         | 8,262 |
| Skipped - no Partita IVA (validation rule)    | 457   |
| Skipped - Mexal code repeated in the file     | 4     |
| Skipped - Mexal code already on a Prod record | 1     |

- Mapping as the UAT import: owner `Amministratore Pienissimo`, `Agente__c` from
  `Codice_agente` against `User.Agente__c`. All 7 codes in the file matched exactly
  one active Prod agent user, so **no row fell back to `01`**
  ([OI-332](OI-332%20The%20account%20import%20keys%20on%20the%20Salesforce%20agent%20code%20and%20the%20client%20file%20is%20mis-coded.md)).
  The trigger set the agent code and commission category from the user; the
  per-agent counts match the file's own `Agente` sheet less the skipped rows.
- Also loaded: `Stato_Azienda__c`, `Ateco_Stato_Attivita__c`,
  `Tipologia_Attivita_Globale__c`. One invalid PEC was left blank.
- 🟢 **No `AsyncApexJob` and no `Integration_Log__c` row since the load began** -
  nothing reached Mexal. Prod now holds 8,265 Mexal-coded Accounts, all codes
  distinct.
- ⚠ **Open:** the 457 VAT-less customers (63 with only a Codice Fiscale) and the 2
  codes duplicated in the file need a client answer; the exception list and the
  created-id list are kept outside the repository. Not loaded: Locali, Referenti,
  orders.

## 2026-11-05 evening - the exception lists went back to the client, and the client is out of Prod

🟢 **Both exclusion lists were mailed the same evening**, each with a reason per row:
the Locali at 16:46Z
([OI-333](OI-333%20Locali%20without%20a%20Mexal%20customer%20code%20will%20not%20be%20loaded.md))
and the Referenti at 18:18 CET with the counts 17,652 / 49,788 / **107 whose Mexal
code matches no Azienda in Prod**
([OI-290](OI-290%20Lead%20and%20Referenti%20migration%20data%20is%20owed%20by%20the%20client.md)).
🟢 Aurel Mrruku also acknowledged the account file at 16:07Z: _"Procedo con le
verifiche del file excel relativo a Salesforce."_

🔴 **Orders are still not loaded.** `Import Ordini (versione del 2026.11.04).xlsx`
arrived on 4 November and nothing in this window says it was opened or run.

🔑 **The client owes the remaining data by Friday 6 November** — Aurel Mrruku, DM
16:11 CET: _"ci devono fornire i datti entro venerdì"_, _"abbiamo delle date
condivise con loro"_, _"abbiamo già dato un giorno"_. ⚠ **That deadline is in no mail
to the client in this window.**

🔴 **And the person who owes it was blocked out of production until Monday** while
the load ran and the Mexal API calls were switched off around it —
[OI-339](OI-339%20The%20client%20was%20locked%20out%20of%20production%20during%20the%20migration%20load.md).
Aurel Mrruku, 16:10 CET: _"ma non possono, sto caricando centinaia di account e devo
impedire che vadano su mexal"_. 🔑 **The delta run this row exists for is therefore
being set up in an org the client cannot touch, eight days before the migration
window.**

## 🟢 2026-11-06 - the order pre-load is in Prod

8,162 historical orders, 18,006 lines and 8,202 tranches loaded from the 04/11
file in 38 all-or-nothing chunks, about six minutes in total, with no Mexal call

- detail in
  [OI-244](OI-244%20Historical%20orders%20will%20be%20migrated%20from%20Mexal%20by%20spreadsheet.md).
  🔑 **The order part of the 12-13 November delta is therefore only the new
  orders**; the loader skips keys already in Prod, but it must normalise the series
  (`1` vs `1.0`) and exclude Salesforce-origin orders already sent to Mexal.
  ⚠ Changes in Mexal to orders already loaded are not picked up by a key-skip
  delta. ⚠ The 3-4 hour figure belongs to the invoice pull, which has not run in
  Prod yet.

## 🔑 2026-11-12 - the delta is now an update, and the dates are set

**Three changes to this plan, all from the
[Check Pre-Import call](../meetings/2026-11-12%20Check%20Pre-Import.md) and the
client's mails of the same day.**

1. 🔴 **The delta is no longer insert-only.** Fabrizio Paganelli: _"Non vale non
   andare solo in update dei record mancanti, **va anche in aggiornamento dei record
   di quelli gia presenti**"_. Aurel Mrruku, who had planned additive only: _"**Ok,
   vado in modifica.** Allora, faccio un controllo generale"_, _"su ordini
   soprattutto"_. Expected size: _"un delta di **200, 300, 500 record al massimo**"_,
   with Account and Order the entities he is wary of.
2. 🔴 **Deletions come first.** Thirteen real orders cancelled in Mexal must be
   removed from production before the delta runs →
   [OI-360](OI-360%20Cancelled%20Mexal%20orders%20must%20be%20deleted%20from%20production.md).
3. 🟢 **The schedule.** Load on **Friday 13/11**, _"spero domani sera, altrimenti
   lavoro anche nel weekend"_, everything ready by **Monday 16/11** with a joint
   check at 09:00-09:30. The client **stopped working in Zoho on 12-13/11**, and
   anything keyed there on those two days is to be re-entered by hand in Salesforce
   on Monday: _"tutto quello che voi fate giovedi e venerdi su Zo\[ho\], lunedi
   mattina lo rimettete dentro Sales force"_. ⚠ Those orders do **not** reach Mexal.

### The files that arrived for it, all 12/11

| Time (UTC) | File | Thread |
| --- | --- | --- |
| 09:44:26Z | `Account` — the final account list, 5.2 MB | `1a1cf252e25e8584` |
| 10:30:34Z | `Referenti Salesforce.xlsx` — 21 MB, **67,154 rows** | `1a1cf4f445a4aaf0` |
| 13:57:22Z | `Locali_CON_codice_Mexal.xlsx` — locali with partita iva, azienda, name, attivo, stagionale, stato cliente, Mexal code | `1a1d00c85ebdda02` |
| 15:32:30Z | `Import Ordini (versione del 2026.11.12).xlsx` — 41 new, 13 to delete, 19 to update | `1a1d06456c06e4f8` |

⚠ **None was opened** — all four carry real customer records. Their existence and
counts are recorded; no values are copied.

🟢 Fabrizio Paganelli checked the accounts for duplicates before sending: _"Ho
verificato anche gli account stamattina che non fossero doppi. Ce n'erano due tre
doppi, li abbiamo gia risolti."_

🟢 **Articles are no longer part of the exchange** — taken straight from Mexal:
_"gli articoli avevamo detto l'altra volta che non ve li passo piu, giusto?"_ →
_"Corretto, gia presi."_ 🔑 And an article-registry manoeuvre was agreed: Fabrizio
Paganelli cleans the Mexal registry on **Friday evening**, Aurel Mrruku activates
every product in Salesforce for the load, then re-pulls the Mexal flags on Monday
morning so the old asterisked codes fall inactive before the tutors see them.
