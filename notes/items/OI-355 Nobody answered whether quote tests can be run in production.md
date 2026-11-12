---
id: OI-355
type: open-item
status: open
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: both
raised: 2026-11-10
updated: 2026-11-12
depends_on: [OI-315]
blocks: []
severity: normal
source: Gmail 1a1c50aa4e66d4e8
---

# OI-355 - Nobody answered whether quote tests can be run in production

**The client asked, in writing, whether he may run quote-insertion tests directly
in the production org. Three days later the question has had no answer, and the
thread it sits in has moved on without it. He may reasonably read the silence as a
yes.**

## The question

Fabrizio Paganelli, **2026-11-10 10:58:29Z**, into the `Collegamento Woo -
Salesforce` thread (`1a1c50aa4e66d4e8`), to Aurel Mrruku and Sabatino Rinaldi:

> _"Aurel, **i test di inserimento preventivi li possiamo fare direttamente in
> produzione?**"_

## What happened next

🔴 Fifteen seconds later, at **10:58:44Z**, Elena Spini posted in the same thread
on an unrelated point (asking Sabatino Rinaldi to delay the WooCommerce
connection). The thread then ran on for fourteen more messages about WooCommerce
and ended on 11/11 at 15:36Z. **The question was never addressed by anyone.**

Re-checked in this run: the thread carries **17 messages** and no answer to it.

## Why it matters

1. 🔴 **Production test records cannot be deleted.** That is the standing finding of
   [OI-315](OI-315%20Production%20test%20records%20cannot%20be%20deleted.md), and the
   12/11 client call confirmed how expensive it is: orders cannot be deleted by
   design, and removing one means tearing down its assets, event links and tickets
   by script — _"sono costretto a fare una pulizia totale"_
   ([OI-360](OI-360%20Cancelled%20Mexal%20orders%20must%20be%20deleted%20from%20production.md)).
2. 🔴 **He is already working in production.** The 12/11 call shows him and Elisa
   Migliano editing live Edizione records, and Sabatino Rinaldi ordering through the
   live shop. Quote tests would add records to the same org **two working days
   before the client's own users start on 16 November**.
3. ⚠ **Silence is the worst available answer.** Nothing told him not to, and the
   `Anagrafica Articoli` mail of 12/11 16:51Z shows him testing quotes and
   products anyway — _"ci sono alcune cose su cui non mi ritrovo, anche rispetto ai
   test che avevo fatto"_.

## What is owed

A one-line answer from Aurel Mrruku, with the cleanup consequence stated: whether
quote tests in production are allowed, and if so how the records come out again.
