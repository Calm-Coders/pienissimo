---
id: OI-271
type: open-item
status: open
owner: Fabrizio Mastracci
with: Matteo Distaso
org: both
raised: 2026-10-20
updated: 2026-10-20
blocks: [go-live]
source: Slack C0C38JJ9D1T 2026-10-20
---

# OI-271 - WhatsApp cannot be connected to Salesforce

**An attempt to connect WhatsApp to Salesforce on 20 October failed: the client's
number is already registered against a part-blocked user account, so it cannot be
registered again and cannot be linked. The client's own mail the same morning
lists WhatsApp among the automatic messages they intend to configure.**

## What happened

Fabrizio Mastracci to the marketing group, Slack `C0C38JJ9D1T`, 20/10
11:51:49–11:52:58 CEST:

> _"Elena ti dico una cosa nuova: stamani ho provato con Matteo a collegare
> whatsapp a Salesforce ma ha registrato il numero su un suo utente metà
> bloccato"_
>
> _"Quindi non può registrare il numero e di conseguenza io non posso collegarlo
> a Salesforce"_

⚠ **What "metà bloccato" means is not established** — whether the account is
suspended, partially verified, or restricted by WhatsApp Business policy. No
error text or screenshot exists in any source. Matteo Distaso then proposed
connecting his private number as well, which Fabrizio Mastracci reported as a
joke and Elena Spini reacted to with a facepalm; **no decision was taken.**

## 🔴 Why it is a row

[The client's 20/10 mail](OI-268%20The%20client%20proposed%20a%20go-live%20calendar%20of%2016%20November.md),
§8, assigns themselves the transactional messages and names the channel:

> _"I messaggi automatici (email/WhatsApp) legati alla creazione delle
> opportunità e il reminder sulla validità dei preventivi (5 giorni) li
> rivediamo noi e li configuriamo"_

So on the same day the client took ownership of configuring WhatsApp messages,
the channel could not be connected at all. 🔑 **Neither side has connected the
two facts** — the mail was written before the attempt, and the attempt was
reported only in an internal Slack group the client cannot see.

⚠ **No requirement row covers WhatsApp.** A register grep finds no WhatsApp
requirement, so there is no acceptance criterion to test this against and no
record of whether the channel is Fase 1 scope at all. That absence is itself the
finding.

## What closing it looks like

Either the number is registered against an unblocked account and the channel
links, or WhatsApp is stated — to the client, in writing — not to be available
for Fase 1, before they configure messages that cannot send.
