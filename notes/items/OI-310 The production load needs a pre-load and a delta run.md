---
id: OI-310
type: open-item
status: open
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: both
raised: 2026-11-02
updated: 2026-11-05
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
