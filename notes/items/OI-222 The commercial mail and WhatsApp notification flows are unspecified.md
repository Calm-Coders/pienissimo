---
id: OI-222
type: open-item
status: open
owner: Elena Spini
with: Marco Montesi
org: both
raised: 2026-10-08
updated: 2026-10-15
depends_on: [OI-179]
blocks: [go-live]
severity: gating
source: Gmail thread 1a0fce6a8bb04fdb message 1a11c39cd17ae456
---

# OI-222 - The commercial mail and WhatsApp notification flows are unspecified

**Answering Elena Spini's request for detail, Marco Montesi listed on 08/10 the
automated mail and WhatsApp messages Zoho sends today on the commercial funnel —
five distinct triggers plus the quote-validity reminders. None of them is in the
Business Blueprint, in the register or in the build, and go-live is 21 October.**

## How it arrived

Marco Montesi's third precisazione on the Business Blueprint (05/10) asked
whether the customer mails and WhatsApp messages have to be set up once and
afterwards changed only through support. Elena Spini replied on 07/10 at
14:57:40Z — _"Non ho capito cosa intendi. Mi puoi dettagliare nello specifico di
quale flusso parli?"_ — and on **2026-10-08 at 15:55:11Z** he answered in the
same thread, in line, cc Fabrizio Paganelli, Sabatino Rinaldi, Rebecca Marmo,
Elisa Migliano's mailbox, Aurel Mrruku and Fabrizio Mastracci.

## What he named

> _"Abbiamo diversi casi dove adesso partono mail/WA automaticamente in funzione
> di determinate condizioni"_

| Trigger | Message |
| ------- | ------- |
| Opportunity created from a form | welcome, and a tutor will take the request in hand **within 48 hours** |
| The customer does not answer | a tutor called, here are the tutor's contact details, you will be called back |
| Opportunity set to **Perso** with reason **NON RISPONDE** | informs the customer they were called several times |
| Within the **5 days** of quote validity | messages to **both the customer and the tutor** |
| At quote expiry | message at the end of validity |

⚠ He qualified the list himself: _"Magari ce ne sono altri che sono legati alla
specifica configurazione di Zoho e che potrebbero non servirci su Salesforce"_,
and deferred to Elisa Migliano for additions. **So the list is explicitly
incomplete.**

## Why this is gating and not a detail

- It is a **new requirement surface arriving 13 days before go-live**, on the
  commercial funnel, from the commercial lead.
- It is **not the marketing ticket funnel.** The 11 email + 11 WhatsApp sequence
  in [the marketing send logics](../The%20marketing%20ticket%20send%20logics%20as%20written%20by%20Marketing.md)
  fires on event participation. This set fires on **opportunity and quote
  lifecycle events** and has a different owner.
- The **48-hour** and **5-day** windows are concrete commitments to a customer,
  and neither appears in any project record before this mail.
- 🔴 **His original question is still unanswered.** Whether these are
  administrator-editable or support-only was what he asked on 05/10; the record
  held the answer for templates from 05/10 (admin-editable in Prod) and nobody
  has given it to him. It is the governance question for the 11+11 funnel too.
- **WhatsApp has no confirmed channel.** Whether the sends run in parallel with
  email or as a backup is one of the two questions put to Rebecca Marmo and
  unanswered since 06/10.

## What closing it looks like

The complete list — Marco Montesi's five plus whatever Elisa Migliano adds —
each with its trigger condition, channel, recipient, timing and template, a
ruling on whether each is Fase 1 or Fase 2, and an answer to who may edit them
after go-live.

## 🟢 2026-10-14 — answered, in the negative, after nine days

**Elena Spini replied to Marco Montesi at 17:14:01Z, cc Sabatino Rinaldi,
Rebecca Marmo, Aurel Mrruku and Fabrizio Mastracci. The answer scopes almost all
of his list out of the project.**

She opened by apologising for the delay — _"perdona innanzitutto il ritardo nella
risposta dovuto alla lavorazione delle ultime consegne"_ — then set out the
as-is, and drew the line:

> _"**E-mail incluse:** Sono incluse esclusivamente le e-mail di invio,
> accettazione e firma del preventivo."_
>
> _"**Altre e-mail e integrazione WhatsApp:** Ulteriori tipologie di e-mail o
> l'invio di messaggi WhatsApp all'interno del flusso Sales **non sono stati
> previsti né mai definiti nelle specifiche concordate**."_
>
> _"Se hai bisogno di integrare queste ulteriori funzionalità, possiamo
> valutarle volentieri come **extra-perimetro/evolutiva in una fase
> successiva**."_

### What is now settled

| Of Marco Montesi's list | Ruling |
| --- | --- |
| welcome + 48-hour tutor commitment | **out of scope**, extra-perimetro |
| "a tutor called you" on no answer | **out of scope** |
| `Perso` / `NON RISPONDE` notification | **out of scope** |
| messages inside the 5 days of quote validity, to customer and tutor | **out of scope** |
| quote-expiry message | **out of scope** |
| WhatsApp, anywhere in the Sales flow | **out of scope** |
| invio / accettazione / firma preventivo mails | **in scope** |

🔑 **And one thing survives, with a dependency on the client.** The as-is she
describes does include a reminder email to the customer two days after the
Opportunity goes to `In Trattativa`:

> _"**Invio e-mail al cliente**: promemoria per l'invio del preventivo (**di
> questo siamo tuttora in attesa del copy della mail**)."_

🔴 **The copy is owed by Marco Montesi** — _"Verrà fornito copy da MM"_, her own
words in a DM at 18:52:58 CEST — and it has not arrived. ⚠ A reminder-email copy
from Marco Montesi was recorded as **received on 25/08**; whether this is the same
artefact owed again or a different one is **not established**.

### ⚠ Three cautions on reading this as closed

1. **The scope ruling is ROMI's, not the client's.** Marco Montesi has not
   accepted it in any source, and his previous precisazione was contested for
   nine days before it was answered. The same is true of
   [OI-224](OI-224%20Mass%20Opportunity%20creation%20is%20contested%20as%20a%20Fase%202%20deferral.md).
2. 🔴 **It does not touch the marketing ticket funnel.** Her wording is scoped to
   _"all'interno del flusso Sales"_. The 11 email + 11 WhatsApp sequence in
   [the marketing send logics](../The%20marketing%20ticket%20send%20logics%20as%20written%20by%20Marketing.md)
   fires on event participation, has a different owner, and is untouched by this.
   **Rebecca Marmo's question — whether WhatsApp runs in parallel with email or
   as a backup — is still unanswered**, and
   [OI-195](OI-195%20WhatsApp%20sends%20imply%20a%20mobile%20community%20that%20was%20never%20designed.md)
   still stands.
3. 🔴 **His original governance question is still unanswered.** Whether these
   messages are administrator-editable or support-only was what he asked on
   05/10. Elena Spini answered it for the **Perso/Errato picklists** on 07/10
   (admin-editable by the Pienissimo administration user) and has never answered
   it for the templates. **Tenth day.**

🔑 **The deeper consequence is for [OI-227](OI-227%20SAL-20%20was%20rewritten%20in%20the%20signable%20requirements%20with%20no%20client%20ruling.md).**
The as-is she set out here is the **task** model — Subject `Preventivo Inviato`,
Task Subtype `Da Ricontattare`, due the next day — which is the wording `96d77de`
removed from the signable requirements two days earlier. She is describing to the
client the text the register no longer carries.

## 🟢 2026-10-15 - the client's own side de-prioritised it, and that is the first client word on this row

At [the 15/10 session](../meetings/2026-10-15%20Migrazione%20e%20Go-Live.md)
(`00:11`–`00:20`) Elena Spini raised her 14/10 reply, restating that the
automations were never specified to ROMI — _"Nessuno l'ha mai detto a noi"_,
_"ci sono degli automatismi che non sono stati proprio previsti né … mai
parlati"_. Aurel Mrruku corrected the object in passing: the asks are written
against **opportunities** and the behaviour belongs to **leads** — _"già ti dico
che la parola opportunità non mi va bene là. Stiamo parlando di lead."_

🟢 **Sabatino Rinaldi then closed it, explicitly on Marco Montesi's behalf.** He
asked only whether Salesforce can do this kind of thing at all; Elena Spini
confirmed it can, through Flows and Marketing Cloud — _"potete fare quello che
volete … avete veramente la Ferrari"_. On that answer:

> _"sulla base di questo, questo punto lo puoi tranquillamente eliminare perché è
> una cosa che uno va cambiato rispetto a come lo facciamo ora, due va fatta in
> un secondo momento che non è una nostra priorità. Rispondo io per per Marco,
> questa non è una priorità."_

> _"L'importante è che mi confermi che l'automazione si può fare … Non è proprio
> un punto che mi interessa in questa fase."_

🔑 **This is the first client-side word on this row.** Until tonight it rested on
ROMI's own _extra-perimetro_ ruling of 14/10; now the client's co-founder has
said it is not a priority and belongs to a later phase. The two positions agree
on the outcome.

⚠ **Three caveats, and they are why the row stays open rather than resolving.**

1. **It is Sabatino Rinaldi answering for Marco Montesi, who is not in the room
   and had not read the mail** — _"io questa mail non l'ho letta perché sono
   stato a fare un corso in questi giorni"_. The person who raised the asks has
   still not responded to the ruling on them.
2. **What he confirmed is capability, not scope.** He was satisfied that the
   platform _can_ do it, and the texts remain the client's to write — _"quei
   testi li dobbiamo comunque decidere noi e non è questo il momento di decidere
   quei testi"_. So the deferral is conditional on nobody needing it at go-live.
3. **It covers the Sales flow only**, as the 14/10 ruling did. The 11+11
   marketing funnel and Rebecca Marmo's parallel-or-backup question are untouched
   by anything said today.

🔴 **The reminder mail inside the agreed perimeter is still blocked, a fortnight
on.** Elena Spini, same session: _"nel momento in cui è in trattativa abbiamo
previsto un invio della mail di cui siamo sempre in attesa del suo COP[Y] che non
ci ha mai più rimandato, quindi … forse anche lui deve tararsi un po' sulle
aspettative che ha."_ The mechanism is built; the copy from Marco Montesi has
never arrived. That is the one half of this row that is in scope, and it has not
moved.

⚠ **Marco Montesi's governance question — whether the texts are admin-editable
or support-only — is unanswered an eleventh day**, and is now partly answered by
implication rather than by anyone: Elena Spini told Sabatino Rinaldi the client
can build these automations themselves _"in autonomia"_, which is a different
answer from the one Marco Montesi asked for and was not given to him.
