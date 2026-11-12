---
id: OI-362
type: open-item
status: open
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: both
raised: 2026-11-12
updated: 2026-11-12
depends_on: [OI-345]
blocks: []
severity: normal
source: notes/meetings/2026-11-12 Check Pre-Import.md
---

# OI-362 - Reassigning an agent code does not update existing accounts

**When one commercial replaces another, changing the agent code on the user does
not propagate to the accounts that person already owns. New accounts pick up the
new code; existing ones keep the old one, because the change is made on the user
record and the account never sees an update. Checked live in production on 12
November. The client raised it because he is about to need it.**

## Why the client asked

🔑 Fabrizio Paganelli, on the
[Check Pre-Import call](../meetings/2026-11-12%20Check%20Pre-Import.md), immediately
after saying that Marco Montesi and Sabatino Rinaldi are leaving
([OI-357](OI-357%20The%20client%20commercial%20lead%20and%20the%20web%20counterpart%20are%20both%20leaving.md)):

> _"se io prendo il posto di Sara del Sordo, chiaramente avro un codice agente
> diverso … anziche avere il 610 104 avro il 610 19. **Gli ordini vecchi che hanno
> il \[codice\] 4 rimangono cosi?**"_

## What was confirmed

🟢 **Orders are safe.** The agent code is stamped at order creation, so historical
orders keep theirs. Aurel Mrruku: _"tutti gli ordini nel momento della creazione
dell'ordine si fa col codice agente … **pero se poi vai a vedere a chi e stato
collegato questo codice agente sarai te**"_ — the code stays, the person it points
to changes.

🔴 **Accounts are not.** Aurel Mrruku first said it propagated — _"in automatico in
teoria si aggiorna tutto"_ — then checked in the production org and corrected
himself:

> _"**Non si aggiorna tutto.** Aspetta che controllo. … quello che succede e che lo
> prende in automatico **solo se vede la modifica sull'account**, pero la modifica
> la stiamo facendo sull'utenza e **non la vede come modifica**. Quindi se tu crei
> un account nuovo prendera il codice agente corretto, invece su quelli esistenti
> **rimane il codice agente vecchio**."_

🔑 So replacing a person means three manual steps, as Fabrizio Paganelli summarised
them: rename the user, change the agent code on the user, **and change the agent
code inside every one of that agent's existing accounts**.

## The remedy agreed

🟡 A mass update, not a record-by-record edit. Aurel Mrruku walked him through it
live: export `Id` and the external agent-code field from Account filtered by agent,
edit in Excel, re-import through Data Import. _"Non devi andare a mano record per
\[record\]."_

Fabrizio Paganelli accepted it as a procedure to learn: _"L'importante e che
sappiamo che si puo fare, dopo impareremo a farlo."_

⚠ **Nothing was written down.** No runbook, no field name confirmed (_"Codice
agente esterno mi sa che si chiama"_), and no owner for producing one.

## Why it matters now

1. 🔴 **Two of the client's people are leaving** and their accounts will be
   reassigned, probably within weeks.
2. 🔴 **The agent code drives the Mexal order and the commission category** — the
   same field that blocked WooCommerce in production on 11/11
   ([OI-354](OI-354%20WooCommerce%20is%20connected%20to%20production%20by%20the%20client.md))
   and that blocked lead qualification in UAT
   ([OI-345](OI-345%20Lead%20qualification%20was%20blocked%20in%20UAT%20because%20the%20tutor%20users%20had%20no%20agent%20code.md)).
   A stale code on an account sends the commission to the wrong person.
3. ⚠ **8,262 Aziende and 3,918 Locali** were bulk-loaded with agent codes from the
   client's own file; any reassignment touches that whole population.

## What is owed

- A short written procedure for reassigning an agent, covering the user, the
  accounts and the verification — ideally in
  [the manual steps tracker](../Manual%20Steps%20Pienissimo%20tracker.md).
- The exact API name of the account-side agent-code field.
