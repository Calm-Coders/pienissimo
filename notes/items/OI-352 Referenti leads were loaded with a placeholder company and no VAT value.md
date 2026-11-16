---
id: OI-352
type: open-item
status: resolved
owner: Elena Spini
with: Aurel Mrruku, Sabatino Rinaldi
org: both
raised: 2026-11-10
updated: 2026-11-16
depends_on: [OI-351]
blocks: []
severity: high
source: notes/meetings/2026-11-10 Follow-up Interno.md
---

# OI-352 - Referenti leads were loaded with a placeholder company and no VAT value

**Believing `Company` and `Partita IVA` were both mandatory on Lead, ROMI told the
client on 11 November that the roughly 50,000 referenti would be loaded with
invented progressive values in both fields, and the client approved it. On 13
November, hours before the load, the premise turned out to be wrong: only `Company`
is mandatory. The VAT field was left empty and `Company` carries the words
"Referente Importato" where the file has no company. No invented value was ever
written.**

> **Retitled 2026-11-16.** The original title said the leads *are* loaded with
> fake company and VAT values. They are not, and never were. The decision below is
> kept as the record of what was agreed on 10-11 November; the outcome is in the
> 13 November section at the foot of the note.

## How it was found

🔑 **The commitment was made to the client before the blocker was known.**
Elena Spini's mapping mail went out at **18:41:48Z on 10 November**. Thirty-three
minutes later, at **19:14:25Z**, she wrote to Aurel Mrruku in the ROMI DM:

> _"mi e venuto un dubbio esistenziale"_ · _"**i lead senza company e/o senza
> p.iva potranno essere importati?**"_ · _"si puo bypassare il tuo controllo di
> obbligatorieta?"_

Aurel Mrruku: _"aggio\[r\]nando il trigger si"_ · _"tutto e fattibile ma **devo
intervenire su quello che c'e gia**."_

## The exchange that decided it

Elena Spini, 19:28:28Z:

> _"e se gli mettessimo noi un numero progressivo? tipo sul campo company:
> facciamo **az10000, az10001, az10002**, e cosi via e uguale per P.iva - non
> dobbiamo fare nulla solo creare il file con sti due campi e **0 modifiche**"_

Aurel Mrruku, 19:31:41Z: _"**nop**"_.

Elena Spini, 19:33:59Z: _"perche? **tanto stiamo portando comunque merda**"_ ·
19:35:30Z: _"quanto ti ci vuole per quella modifica? se mi dici 15min ti dico ok se
dobbiamo spendere ore e poi rischiare di rompere altro possiamo anche fare come ho
detto perche **tanto e uguale o campo vuoto o campo fake che cambia**"_.

🔴 **The DM ends there.** Nothing in it records an answer.

## What was done

🔑 **The fake-value route was taken, put to the client in writing, and approved.**
Elena Spini to Pienissimo, **2026-11-11 12:32:33Z** (thread `1a1a746c8e63d5ac`):

> _"Poiche su Salesforce i campi **Company** e **Partita IVA** sono obbligatori
> (**mandatory**), i record non possono essere caricati con campi vuoti (**blank**),
> pena il blocco dell'import. Per bypassare questo vincolo tecnico, caricheremo
> questi record valorizzando i campi mancanti con **codici fittizi progressivi**
> (es. per il campo Company: az10000, az10001, az10002... e una logica analoga per
> la Partita IVA). Questi valori fake serviranno unicamente a consentire
> l'importazione e dovranno poi essere bonificati e sostituiti con i dati reali dal
> tutor di riferimento o dal commerciale dedicato."_

🟢 **Sabatino Rinaldi, 2026-11-11 14:32:21Z: _"Si Elena, va bene"_.**

And repeated to the client's full group on the 12/11 call: _"verranno importati
questi dati con codici fake per company e partita IVA per andare comunque in insert
su questi oggetti perche **sennò il sistema bloccava**."_

## Why this is resolved and still a standing risk

The item is resolved: a route was chosen, written down and accepted, then
superseded before it was executed, and the trigger was **not** modified. What it
leaves behind belongs to
[OI-351](OI-351%20Referenti%20without%20a%20Mexal%20code%20are%20imported%20as%20marketing%20leads.md):

- ⚠ No cleanup owner, no deadline and no option chosen (A or B).
- ⚠ **The leads had not been imported at all** as of 10/11 — Aurel Mrruku,
  09:27:59Z: _"no i lead non li ho importati"_.

## 2026-11-13 - the fake values were not needed and not used

`Partita_IVA__c` is not mandatory on Lead in Prod — only `Company` is, natively —
so the 49,811 Referenti were loaded **with the VAT field empty**, and `Company`
carries the company name where the file has one (about 9,900 rows) and the text
**"Referente Importato"** otherwise (39,922). No invented progressive value was
written.

🔑 **It was caught by the developer and settled with the client the same day.**
Opening the 13/11 urgent call, before its own subject, Aurel Mrruku:

> _"la **partita IVA non e obbligatoria** sui lead, non so perche e stato detto da
> te che e obbligatorio."_

Elena Spini: _"non mi ricordo dove l'avevo visto"_ … _"forse era sul form
obbligatorio, per quello hai fatto confusione"_ (Aurel Mrruku's reading). She
restated it later in the same call, with Sabatino Rinaldi present:

> _"avevo detto io che partita IVA doveva essere con un campo fake, **mi ha
> ripreso, ha detto che si puo mettere anche blank, quindi e ancora meglio, non
> dobbiamo mettere il campo fake**."_

The three of them then chose the `Company` placeholder on the call, weighing a
progressive number, `xx` and `da import`. Sabatino Rinaldi: _"metti da import, cosi
capiamo subito che sono aziende fatte dall'import di Salesforce."_ Elena Spini:
_"facciamo referente da import"_ → Aurel Mrruku: _"**Referente importato**"_ →
Elena Spini: _"peggio di cosi si capisce che non e veramente un lead."_

## 2026-11-16 - the client was told, in writing and on the call

🟢 The earlier concern that nobody had told the client is **closed**. Sabatino
Rinaldi and Elena Spini were both in the room when it was decided on 13 November,
and Aurel Mrruku put it in the migration recap mail of 13/11 16:56Z (Gmail
`1a1d06456c06e4f8`):

> _"La Partita IVA e rimasta vuota, perche su Lead non e obbligatoria: **non
> abbiamo quindi usato i codici fittizi che avevamo ipotizzato**. Dove manca il
> nome dell'azienda abbiamo scritto 'Referente Importato'."_

Repeated to the client's full group on the
[16/11 call](../meetings/2026-11-16%20Ultimi%20Check%20PROD.md): _"non abbiamo usato
i codici fittizi per la partita IVA, come avevamo detto, perche ho pensato forse e
meglio cosi non fare confusione."_ Fabrizio Paganelli: _"Si."_

⚠ **What is still not reconciled**: the 11/11 mail the client formally approved
describes a cleanup of fake values that will never be needed, and no corrected
version of that mail was sent. Anyone reading the approval chain alone will look
for `az10000` values that do not exist.
