---
id: OI-340
type: open-item
status: open
owner: Fabrizio Mastracci
with: Elena Spini
org: both
raised: 2026-11-05
updated: 2026-11-12
depends_on: []
blocks: []
source: Slack C0C38JJ9D1T, 2026-11-05 17:26 CET thread
---

# OI-340 - The website lead forms have no field for the marketing consent

**Two public website forms are built and delivering leads into Salesforce, and the
marketing-consent tick on them has nowhere to land. Fabrizio Mastracci asked for a
field or a nomination on 5 November; the answer offered was the client's existing
profiling flag, and the mapping question was left open overnight.**

## What exists now

Fabrizio Mastracci → Elena Spini, marketing group DM, **17:26 CET**:

> _"Ho creato i due form del sito (**Camerieri Venditori** e **Pienissimo Live**).
> Quando qualcuno li compila, il contatto arriva come lead con tutti i dati."_

🟢 **So the forms work and leads arrive.** Both names are events on the Fase 2
timeline — Camerieri e Venditori and Pienissimo Live 24-26/11 — so these are live
acquisition forms, not tests.

## The three open points, as he stated them

1. 🔴 **The consent checkbox has no field.** The form carries _"Acconsento
   all'utilizzo dei dati per essere informato su servizi, prodotti ed eventi"_ and
   _"in Salesforce manca il campo dove salvarla, nemmeno qui la vedo"_ — pointing at
   [`Campi Oggetti, Flussi e Utenti Salesforce - Pienissimo.xlsx`](../The%20Campi%20Oggetti%20Flussi%20e%20Utenti%20workbook.md).
   _"Bisogna crearlo oppure indicarmi un campo su dove indirizzare l'input del
   cliente, altrimenti **quella spunta non viene registrata**."_
   ⚠ The workbook has not been touched since **2026-10-26 13:27Z**, so his reading of
   it is current.
2. 🟢 **Lead source `Sito` does not exist.** He used `Website` instead; Elena Spini
   accepted it (_"2. ok"_). If `Sito` is wanted it must be added to the picklist.
3. 🟡 **`Interessato a` was saved into `Servizio Interesse`** and he asked for
   confirmation. Elena Spini: _"ti faccio sapere domani"_ — **unanswered**. 🔑 In the
   same hour Aurel Mrruku told her the opposite in their DM, 18:01 CET: _"da creare
   su lead il campo **'interessato a'** e dare permesso permessi a full e agente"_,
   i.e. **a new field rather than reuse**. ⚠ **Two ROMI answers, not reconciled, and
   neither given to the person building the form.**

## The consent answer offered, and why it is not settled

Elena Spini, 18:01 CET:

> _"loro hanno specificato più volte che gli unici consensi che hanno sono: **Flag
> Consenso Profilazione - Flag Informativa Privacy** >> quindi **profilazione =
> marketing?**"_

Fabrizio Mastracci, 18:10 CET:

> _"questa è la loro formula nella chebox, è un po' ambigua ma potrebbe anche fungere
> come profilazione. Se loro sono d'accordo posso usare quella"_

Elena Spini, 19:18 CET: _"cosi mi hanno detto 🙂 poi magri consigliali qualcosa di
meglio nel caso io ho preso quello che m hanno detto"_.

🟢 **Both fields he was offered exist in source**, on Lead and on Account:
`Consenso_Profilazione__c` and `Informativa_Privacy__c`
(`force-app/main/default/objects/{Lead,Account}/fields/`), and
`LeadConversionTriggerHandler` already carries both from Lead to the converted
Account. **So the gap is not a missing field but an undecided mapping**: nobody has
ruled that a tick worded as service/product/event information is the same consent as
`Consenso_Profilazione__c`.

🔴 **Until that is ruled, the tick is collected on a public form and discarded.** That
is the part that cannot wait: it is a consent record, and
[OI-307](OI-307%20The%20Lead%20import%20needs%20the%20duplicate%20rules%20disabled.md)
already notes the imported consent flags arriving uniformly `true`, so the stored
value will not distinguish these leads either.

⚠ **Whether these forms are the ones behind `lead-web-to-lead (2).html`**, posted by
Rexhina Hysi in the dev group on 03/11 and still unexplained, **is not established**.
The timing and subject are compatible; nobody has said so.

## Related

- [OI-14](OI-14%20Marketing%20forms%20and%20subdomain.md)
- [OI-176](OI-176%20Web%20to%20Lead%20assigns%20every%20lead%20the%20Diretta%20record%20type.md)
- [The Zoho Forms mapping workbook](../The%20Zoho%20Forms%20mapping%20workbook.md)
- [The Update Contact Consent flow in production](../flows/The%20Update%20Contact%20Consent%20flow%20in%20production.md)

## ⚠ 2026-11-12 - a third window with no decision, and the owner is leaving

The mapping question — whether `profilazione` is the marketing consent, and which of
`Consenso_Profilazione__c` or `Informativa_Privacy__c` the public forms should write
— is **unmentioned by any source in this window**.

🔴 Two things have changed around it:

1. **Sabatino Rinaldi, who owns the two live forms, is leaving** →
   [OI-357](OI-357%20The%20client%20commercial%20lead%20and%20the%20web%20counterpart%20are%20both%20leaving.md).
   He holds the site configuration and was the counterpart for the HTML.
2. ⚠ **The landing-page HTML forms are still not evidenced delivered.** Fabrizio
   Mastracci was to send them directly to Sabatino Rinaldi and Matteo Distaso in a
   new chat on 10/11 — _"Mandagli direttamente te … dicendo che dovranno mettere
   l'HTML nel loro sito"_ — and nothing in this sweep shows it done. They were
   promised _"entro fine gg"_ on 09/11 and again on 10/11.

🔑 **The adjacent field question did get an answer, for a different field.** On the
lead source, Fabrizio Mastracci's position of 5 November was quoted back on the
12/11 internal call: the forms send `sito`, Salesforce has no such value, and he set
`website` as a stopgap → [the lead source values](../The%20Pienissimo%20lead%20source%20values.md).
That list is still not reconciled with what the forms actually send.
