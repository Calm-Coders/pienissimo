---
id: OI-296
type: open-item
status: open
owner: Aurel Mrruku
org: ROMI
raised: 2026-10-28
updated: 2026-10-29
depends_on: []
blocks: []
source: Gmail message 1a18311817f3381e
---

# OI-296 - Account creation to Mexal failed in UAT and account send was switched off

**A customer-creation callout to Mexal failed in the UAT sandbox on 28 October
with HTTP 400 while the client was testing. The response was to switch account
sending off. Nothing in the record says why Mexal rejected the call, and nothing
records the switch being turned back on.**

## The failure

Salesforce error notification, Gmail `1a18311817f3381e`, **2026-10-28 15:12:04Z**,
to `a.mrruku@romicompany.com`, subject _"Sandbox: Errore creazione cliente Mexal -
001MA000014QQP5YAO"_:

> _"Errore creazione cliente Mexal — La chiamata di creazione cliente Mexal non
> ha collegato un codice cliente al record Account Salesforce."_
>
> Stato HTTP: **400** · Messaggio: _"Creazione cliente Mexal fallita."_ ·
> Account: `001MA000014QQP5YAO` · Log integrazione: `a05MA00000GqqcPYAR`

The org is the `--partial` sandbox (UAT). 🔑 **The callout went to the live Mexal
company**: `OrderMexalIntegrationService` still carries
`ALLOW_MEXAL_QUEUE_IN_SANDBOX = true`, documented as _"UAT testing (2026-10-06):
true runs the full integration in sandbox, customer create/update included,
against the live Mexal company."_

## The response

Twelve minutes later, Gmail `1a1831cfe82bc214`, **15:24:37Z**, Aurel Mrruku to
Fabrizio Paganelli:

> _"Ho visto che Marco stava facendo tei test in UAT creando dei account e **ho
> disabilitato l'invio dei account per il momento**."_

So the failing path was closed rather than diagnosed, while the historical load
was running in the same org.

## Why it is open

1. 🔴 **The cause is unknown.** HTTP 400 is a rejection by Mexal, not a timeout:
   something in the payload was refused. The integration log `a05MA00000GqqcPYAR`
   holds the detail and **was not read** — the org was not opened in this sweep.
2. 🔴 **No recorded re-enable.** The Mexal **order** API was explicitly reopened
   at **16:19:55Z** — _"Ho anche apperto le api verso mexal se vuooi proseguire
   con i test"_ — but that message says nothing about account sending. ⚠ Account
   send is therefore off in UAT as far as this record goes, while the client is
   being invited to continue testing.
3. ⚠ **Two different switches were moved the same afternoon** and only one is
   accounted for; see
   [OI-294](OI-294%20The%20client%20asks%20to%20run%20the%20invoice%20and%20payment%20update%20jobs%20itself.md)
   for the order-integration block told to the client at 11:27Z.
4. 🔑 **An account that reaches Mexal without a customer code is the exact
   precondition for the agent and account joins** being rehearsed this week
   ([OI-293](OI-293%20The%20agent%20registry%20for%20the%20production%20load%20may%20be%20incomplete.md)),
   and a silent failure mode here would not be visible in the load counts.
5. ⚠ **One occurrence is all the record holds.** Whether this is a single bad
   record or a class of failures is unestablished; the notification is per-record
   and only one arrived in the sweep window.

## 🟡 2026-10-29 - the integrations were re-enabled, but not in words that reach this item

🟡 **A commit says the Mexal integrations are on.** `7f648a8`, Aurel Mrruku,
**2026-10-29 18:03 CET**, titled _"abbilitato le integrazioni mexal"_. ⚠ **It
changes no code** — only `JOURNAL.md` and
[OI-267](OI-267%20Loading%20historical%20orders%20would%20push%20them%20to%20Mexal%20and%20generate%20tickets.md)
— so the enabling happened in an org and the commit records it.

⚠ **It does not answer problem 2 of this note.** What OI-267 gained that day is
about **production**: the Mexal action configuration rows were copied in, the
`MexalToken` was entered on the Prod principal, and a read-only article search
returned HTTP 200. 🔑 **This note is about account sending in the UAT sandbox**,
switched off at 15:24Z on 28/10. Neither the commit title nor the OI-267 text names
UAT account send, so **the switch still has no recorded re-enable.**

🔴 **And the environment question got sharper, not softer.** OI-267's own 29/10
entry closes on _"Still open: whether UAT stops writing to the same Mexal
company"_ — so UAT and production share a Mexal company, and turning UAT account
send back on is now a decision with a production consequence rather than a toggle.

🔴 **The HTTP 400 cause is still unknown.** Integration log `a05MA00000GqqcPYAR` is
**still unread**; the org was not opened in this run either. Four days on, nothing
says why Mexal rejected that customer.

⚠ **A second integration log now exists on a different path** —
`a05MA00000GsbhJYAR`, a WooCommerce order from a new customer that never reached
Salesforce ([OI-298](OI-298%20WooCommerce%20bundle%20orders%20from%20a%20new%20customer%20do%20not%20reach%20Salesforce.md)).
**Both are new-account failures and both logs are unread.** Recorded as a shape
worth checking together, **not as a shared cause**.
