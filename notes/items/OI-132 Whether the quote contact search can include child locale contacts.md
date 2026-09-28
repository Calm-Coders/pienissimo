---
id: OI-132
type: open-item
status: open
owner: Aurel Mrruku
org: ROMI
raised: 2026-09-08
updated: 2026-09-08
depends_on: [OI-123]
source: notes/meetings/2026-09-08 Data Model Parte 4.md
---

# OI-132 - Whether the quote contact search can include child locale contacts

**The only thing Parte 4 left formally open: a technical check Aurel Mrruku took
on himself. It is the first consequence of the Azienda/Locale split, found in the
same hour the split was agreed.**

## The question

Recorded under `Da approfondire` — the session's sole entry there:

> _"La fattibilità tecnica di filtrare i contatti anche di tutti gli account
> figli durante la creazione del preventivo è subordinata a un controllo tecnico
> di Aurel."_

The quote's reference contact is a **free lookup defaulting to the `contatto
principale`**, agreed in Parte 2 and reconfirmed here. With locali now modelled
as **child Accounts**
([the decision](../decisions/Decision%20-%20Account%20record%20types%20split%20Azienda%20and%20Locale.md)),
the standard lookup filter scopes to the quote's own Account — the parent — and
would **not** offer contacts sitting on the child locali.

## Why it matters

Elisa Migliano's position is that the quote should ideally go to the **titolare**
of the billing company, with exceptions allowed. But the people who actually
handle a venue sit on the locale. If the search cannot reach them, the exception
case that motivated the editable contact in the first place — Aurel Mrruku's own
example of chains and franchises — is the case it cannot serve.

A partial mitigation was agreed in the same exchange: **each child account
initially inherits the parent's principal contact**. That covers the default and
not the exception.

## ⚠ It is a lookup filter question, not a data question

Salesforce lookup filters can traverse a relationship, but the traversal here is
*Contact → Account → ParentId*, evaluated against the quote's Account. Whether
that is expressible as a declarative lookup filter, or needs a custom search
component, is precisely what the check has to establish — and the answer changes
the estimate.

⚠ **No date.** Products, quotes and orders are **Parte 5, 16 September**, which is
the natural session for the answer.
