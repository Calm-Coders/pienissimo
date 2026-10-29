---
id: OI-298
type: open-item
status: open
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: both
raised: 2026-10-29
updated: 2026-10-29
depends_on: []
blocks: [go-live]
source: Gmail 1a187fc40582fdda
---

# OI-298 - WooCommerce bundle orders from a new customer do not reach Salesforce

**The client tested bundle sales through WooCommerce on 29 October and the order
did not arrive in Salesforce. The failing case is specific: a bundle order placed
by a customer who does not yet exist. An integration log was produced and has not
been read. The WooCommerce meeting already scheduled for 30 October was widened
to cover it.**

## The report

Fabrizio Paganelli, Gmail `1a187fc40582fdda`, **2026-10-29 14:06:57Z**, to Aurel
Mrruku and Elena Spini, cc `amministrazione@pienissimo.com` and Sabatino Rinaldi:

> _"stiamo facendo test Vendite Bundle tramite woocommerce / c'è qualcosa che non
> mi torna. / Non so se sbaglio qualcosa io o altro. / **Ci possiamo sentire in
> call, se potete?**"_

🔑 **The mail does not say what failed** — only that something does not add up.
The diagnosis comes from Elena Spini a little under two hours later.

## What is actually failing

Elena Spini, Slack DM `D0B5QHS2T7H`, **2026-10-29 16:02:51 CET**, reporting the
call she took with him:

> _"per i problemi di WooCommerce: dice che **quando fa un ordine bundle con
> cliente nuovo non scende in SFDC** ed infatti c'è l'errore >>
> [Integration_Log\_\_c `a05MA00000GsbhJYAR`]"_

So the record holds three things: the symptom (the order does not descend into
Salesforce), the discriminating condition (**a new customer**, not an existing
one), and a log id.

⚠ **The log was not read.** The org was not opened in this run, so nothing here
says *why* the call failed. The link Elena Spini posted points at
`ability-customization-52152--partial.sandbox.lightning.force.com` — **the
Pienissimo UAT sandbox**, which this project reaches as `a.mrruku@pienissimo.uat`
on exactly that host (see the org-verification header of
[the tracker](../../meetings/open-items.md)). So this is **not** production: the
failure is in the environment the client has been testing in all week.

## Why it is open

1. 🔴 **Nobody has read `a05MA00000GsbhJYAR`.** It is the one artifact that would
   separate the readings below, and it exists.
2. ⚠ **Bundle and new-customer are not separated.** The report names both
   conditions at once. Whether a non-bundle order from a new customer also fails,
   or a bundle order from an existing customer succeeds, is untested in this
   record.
3. 🔑 **The client was left without support on the day.** Elena Spini at
   **15:20:54 CET**: _"Fabrizio ha bisogno di supporto per i test woocommerce -.-
   tu ci sei? io mezz'ora tra 10min gliela posso dedicare"_; Aurel Mrruku at
   **15:27:42**: _"ciao , sono in call"_; Elena Spini at **15:36:49**: _"okok, lo
   chiamo e lo bidonerò cosi perchè anche me ora sono usciti altri cazzi su
   altro"_. She took the call anyway — the 16:02 report is its product — but the
   half hour she had was explicitly rationed.
4. 🟢 **It has a meeting.** Elena Spini, same message: _"**ho esteso il meeting di
   domani pomeriggio anche ad Elisa e Fabrizio** cosi parlate anche di questo"_ —
   the **30 October 15:00 CET** `Connessione WooCommerce` session, which until now
   was about the production endpoints. ⚠ **Not yet held.**

## Possibly related, not established

- ⚠ **[OI-296](OI-296%20Account%20creation%20to%20Mexal%20failed%20in%20UAT%20and%20account%20send%20was%20switched%20off.md)**
  is also a new-account failure — a Mexal customer create rejected HTTP 400 on
  28/10 — and account sending to Mexal was switched off in response. 🔑 **It is the
  same org**, one day apart, and both logs sit unread in it (`a05MA00000GqqcPYAR`
  and `a05MA00000GsbhJYAR`, consecutive enough to be near neighbours). ⚠ **The
  direction is opposite** — Salesforce → Mexal there, WooCommerce → Salesforce
  here — so a shared cause is **not** established. But 🔑 **a new customer that
  cannot be created in Mexal and a new customer whose order never lands are the
  same business event seen from two ends**, and if account send is still off in
  UAT ([OI-296](OI-296%20Account%20creation%20to%20Mexal%20failed%20in%20UAT%20and%20account%20send%20was%20switched%20off.md)
  problem 2, still unanswered) then the client is testing new-customer flows in an
  org where one leg is deliberately disabled. **That is a reading, not a finding;
  the logs would settle it.**
- ⚠ **[OI-301](OI-301%20Three%20production%20manual%20setup%20steps%20are%20outstanding.md)**
  records that _"Add the default agent for Accounts and Orders created from
  WooCommerce"_ is marked done in UAT and **blank for production**. That is a
  different environment from the one failing here, so it does not explain this
  failure — but it is the same path, unfinished, in the org that goes live.
