---
id: OI-352
type: open-item
status: resolved
owner: Elena Spini
with: Aurel Mrruku, Sabatino Rinaldi
org: both
raised: 2026-11-10
updated: 2026-11-12
depends_on: [OI-351]
blocks: []
severity: high
source: notes/meetings/2026-11-10 Follow-up Interno.md
---

# OI-352 - The fifty thousand referenti leads are loaded with fake company and VAT values

**`Company` and `Partita IVA` are mandatory on Lead, so the roughly 50,000
referenti promised to the client as a straight import could not be loaded at all.
The resolution, chosen on 10 November and approved by the client on 11 November,
is to write invented progressive values into both fields in production and leave
the cleanup to the client's tutors. The developer's first answer to the idea was
_"nop"_.**

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

The item is resolved: a route was chosen, written down and accepted, and the
trigger was **not** modified. What it leaves behind belongs to
[OI-351](OI-351%20Referenti%20without%20a%20Mexal%20code%20are%20imported%20as%20marketing%20leads.md):

- ⚠ **Roughly 50,000 production Lead records will carry invented company names and
  invented VAT numbers** from day one of the client's operational use.
- ⚠ No cleanup owner, no deadline and no option chosen (A or B).
- ⚠ **The leads had not been imported at all** as of 10/11 — Aurel Mrruku,
  09:27:59Z: _"no i lead non li ho importati"_.
