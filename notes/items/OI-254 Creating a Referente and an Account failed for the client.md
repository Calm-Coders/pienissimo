---
id: OI-254
type: open-item
status: in-progress
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: both
raised: 2026-10-16
updated: 2026-10-19
blocks: [go-live]
source: Gmail 1a1454177ff30250, 2026-10-16T15:07:59Z
---

# OI-254 - Creating a Referente and an Account failed for the client

**Fabrizio Paganelli mailed ROMI on 16 October to say that creating a Referente
and an Account had gone wrong, attached four screenshots, and deferred the
detail to a call. What the problem is, is not in the mail — and the client's own
key-user test window opens on 19 October.**

## The mail

**2026-10-16 15:07:59Z**, subject _"Referente e Account"_, from
`fabrizio.p@pienissimo.com` to Aurel Mrruku and Elena Spini,
cc `amministrazione@pienissimo.com`. The body is four lines:

> _"Abbiamo provato a creare Referente e Account._
>
> _Abbiamo avuto qualche problema_
>
> _Vi lascio sotto gli screen, poi magari vi dico in call i dettagli_
>
> _Ciao, Fabrizio"_

Four PNG attachments (`image001.png`–`image004.png`), inline, the first captioned
_"Referente"_ in the body text.

⚠ **The screenshots were not opened by this sweep.** They are inline images in a
client mail about record creation and may carry customer data; the mail is
recorded, the contents are not. **Reading them is the first step for whoever
picks this up**, and it is the only place the actual error text exists.

## What makes it a row rather than a note

- 🔴 **It is the client attempting the build unaided, and failing.** Every prior
  demonstration of Account and contact creation was driven by ROMI, in session.
  This is the first recorded attempt by the client on its own, and it did not
  work.
- 🔴 **The timing.** The key-user test week runs **19–23 October**, the
  _"Test UAT Commerciali"_ session with Marco Montesi is **Monday 19/10 15:00**
  ([OI-240](OI-240%20Marco%20Montesi%20needs%20a%20Salesforce%20user%20before%20go-live.md)),
  and Go/No-Go is **27/10**. An unexplained failure in creating the two records
  the commercial flow starts from blocks that test.
- ⚠ **`Referente` is the client's word, and it maps to more than one thing in
  this build.** It is used in the ticket flow for the person who nominates
  participants, and in the commercial flow for an Account's contact person.
  **Which is meant is not established** — the mail's own caption says
  _"Referente"_ above the first screenshot and nothing more.

## 🔑 A possible connection, recorded as a lead and not as a finding

Two things touching contact creation moved on the same day:

1. **`05cdd3b`** (Rexhina Hysi, 16/10 14:50 CEST, branch `Devmain_LeadFix`) —
   _"Lead_Email__c and chage duplicate rule"_ — rewrites Lead/Contact
   duplicate-rule metadata and the conversion Apex, and its own notes record a
   reproduced failure in which **duplicate alerts block Contact creation**.
2. **[OI-256](OI-256%20A%20test%20contact%20phone%20number%20did%20not%20reach%20the%20CRM.md)**
   — a contact's phone number silently absent in the 16/10 UAT, explained in the
   room as an existing contact being reused.

⚠ **Whether any of this is the same problem is unknown.** The mail gives no
error text, the commit is not on `DevMain`, and the environments may differ —
the client works in UAT, the commit deployed to a partial sandbox. **Stated as a
lead for the person who opens the screenshots**, not as a diagnosis.

## Open

- 🔴 **Nobody has replied.** No answer in Gmail or Slack by the close of
  16 October, and the mail proposes a call that is not booked.
- 🔴 **The error is unidentified**, and therefore so is the environment, the
  object and whether it reproduces.

## What closing it looks like

The screenshots are read, the failure is reproduced or explained, and the client
is told — before 19 October — whether it can create these records in the
key-user test.


## 🟡 2026-10-19 — explained in session, without the error ever being read

**Elena Spini opened the mail at the start of the 19/10 walkthrough and went
through the screenshots with Fabrizio Paganelli. Both halves got an explanation.
Neither explanation came from the error text, because the error text was never
produced — and on the evidence there may not have been an error at all.**

### Half one: a Referente with no Account is expected behaviour

At [the session](../meetings/2026-10-19%20Test%20UAT%20Commerciali.md)
`00:07:11`, Elena Spini: _"il primo screenshot, referente senza account, è una
cosa normale in Sales[force]"_. Fabrizio Paganelli reconstructed what he had
done — created the Contact first, then the Account, then linked them — and she
confirmed that is a supported order: _"hai fatto contact new e quindi qua hai la
libertà di collegare l'account che vuoi"_.

She then offered to remove the possibility and **the room chose to keep it**
(`00:10:31`), because a tutor meeting a new referente at an existing company
needs it: _"io forse lo lascerei, poi magari vi può servire"_. Fabrizio Paganelli
accepted — _"adesso ho capito. Va bene"_ — and Elena Spini separated the genuinely
account-less case out as a **Lead**, not a Contact.

🟢 **So half one is not a defect.** It is the product behaving as designed,
reported as a problem by a first-time user, and the design was explicitly
re-affirmed in front of him.

### Half two: the agent fields were empty because his user has none

Fabrizio Paganelli's actual complaint (`00:12:53`) was that creating an Account
left the commercial fields blank when they should inherit from the owning tutor:

> _"quando io creo un nuovo account e sono Marco Montesi e creo l'account, i quei
> campi agente, classificatore[,] rete[,] zona dovrebbero essere precompilati."_

Elena Spini's answer: _"sono quelli dell'utente. Sì, ma tu non ce l'avevi … vedi
che [è] vuoto?"_ — the fields populate from the creating user's own agent data,
and **his test user had none set**. He accepted it: _"quindi avrei dovuto … ok,
ho capito"_.

🟢 **And it drew a build response the same day.** `10fa31e` (Anita Aga,
`DevAnita19`, **19/10 17:43 CEST** — 57 minutes after the session ended) is
titled _"Logic to populate the agent related fields on account"_ and touches
`AccountTriggerHandler.cls` (+52), the Azienda flexipage, the Account layout and
the `Categoria_Provvigioni_Cliente__c` / `Codice_Agente_Esterno__c` field
definitions. `fc8a86d` adds a custom component for New Account two minutes later.
🔴 **Both are on `DevAnita19` with no PR**, so the fix is outside the integration
branch and untested against his case.

## What this row now carries

- 🟢 **Downgraded from a blocking unknown to two explained observations.** The
  `blocks: [go-live]` flag is left in place deliberately — see below.
- 🔴 **The four screenshots were still never opened**, in this sweep or any other.
  The explanations above are reconstructions from the conversation, and **both
  parties were working from Fabrizio Paganelli's memory of what he did**, not from
  the images. If a third screenshot showed something else, nobody has looked.
- 🔴 **No error text exists in any source.** His original mail said
  _"abbiamo avuto qualche problema"_ and nothing more. **On this evidence the word
  _failed_ in this row's title is stronger than what the record supports** — but
  it is kept, because the id and title are cited in the trackers and in the
  client-facing numbering, and the correction belongs in the body.
- ⚠ **The 16/10 lead that this might be the duplicate-alert failure is now
  dead.** That lead rested on OI-100's reproduced synthetic-data failure, and
  the merged 19/10 metadata and note text both settle the rules as
  `Allow` + `Report` — report-only, non-blocking. **It was not that.**

## What closing it looks like, restated

A person opens the four screenshots and confirms they contain nothing beyond the
two explanations above. Until that happens the flag stays, because what the
client reported and what was explained were never actually compared.
