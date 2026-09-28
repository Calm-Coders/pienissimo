---
id: MTG-2026-09-07-datamodel-3
type: meeting
status: resolved
owner: Elena Spini
org: both
raised: 2026-09-07
updated: 2026-09-07
source: Drive - "[ROMI-PIENISSIMO] - Data Model: Parte 3 - 2026/09/07 11:06 CEST - Appunti di Gemini", summary, Decisioni, details and full transcript read 2026-09-07
---

# 2026-09-07 Data Model Parte 3

**Client-facing session, 7 September 2026, 11:06 CEST; the transcript runs
1h12m02s.** The third of the deep customer-registry mapping sessions
([OI-99](../items/OI-99%20Customer%20registry%20deep%20mapping%20session.md)).
Present: **Elena Spini**, **Aurel Mrruku**, **Elisa Migliano**, with **Rebecca
Marmo** called in for roughly two minutes from 00:21:14 to settle one question.
**Andrea Di Cicco** was invited and did not attend — he said so in the ROMI group
DM at 09:12:53 CEST: _"Ragazzi io non ci sono con pienissimo oggi che ho il kick
off di un altro progetto"_. **Fabrizio Paganelli** was invited; Elisa Migliano
opened with _"E Fabri ha detto che intanto possiamo iniziare"_ and he does not
speak anywhere in the transcript. Sabatino Rinaldi was cc'd and does not appear.

⚠ **So Parte 3 did run on Monday**, with the reduced cast, which resolves the
first of the two readings [OI-99](../items/OI-99%20Customer%20registry%20deep%20mapping%20session.md)
left open on 4 September. It was not cancelled; it was held without Andrea Di
Cicco.

The session finished the **Referente (Contact)** object that Parte 2 had started.
Elena Spini's own closing count: _"Siamo a 35"_ — thirty-five fields disposed of,
one object completed.

⚠ **The recording started late.** At 00:02:40 Aurel Mrruku asks _"Scusa Elena,
puoi registrare per cortesia che non è partito la registrazione"_. The first two
and a half minutes of the call are not in the transcript.

## Concordato

### Consents live on the Contact; edition participation lives on the Campaign

The one decision Gemini records as agreed, and the substantive outcome of the
session. See
[the decision note](../decisions/Decision%20-%20consents%20live%20on%20the%20contact%20and%20editions%20on%20the%20campaign.md).

Elisa Migliano opened the problem: in Zoho, `Consenso finalità commerciali` and
`Consenso profilazione` sit inside an `ultima iscrizione` macro-area that also
carries the **edition** the consent was given against, so a second registration
**overwrites** the first — _"come campo di ultima iscrizione c'è solo quello"_.

**Rebecca Marmo settled what actually happens** (00:22:55): if a contact has
already attended a Pienissimo event and therefore already given authorisation,
_"l'autorizzazione poi nei biglietti successivi va in automatico. Cambia solo in
automatico il flag"_ — the consent carries forward, only the edition is
overwritten.

Agreed shape on Salesforce:

- **Consents stay on the Contact**, because outbound marketing runs off them —
  Aurel Mrruku: _"a livello di contatto, perché poi se si fanno logiche marketing
  outbound"_.
- **Which editions a contact took part in lives on Campaign / CampaignMember**,
  so nothing is overwritten and the full history survives.
- `Consenso finalità commerciali` and `Consenso profilazione` are **picklists**
  with values **`Autorizzo` / `Non autorizzo`** and a **blank default**, not
  checkboxes. Elena Spini asked the default question explicitly and Elisa
  Migliano confirmed blank.

### The Zoho tag vocabulary is decoded, and retired

Elisa Migliano explained the tag scheme for the first time in the record
(00:43:13): every event has its own tag, `<EVENT>_I` meaning **iscritto** and
`<EVENT>CP` meaning **contatto principale** — her examples were `FMF_I` and
`FMFCP` for the Food Marketing Festival. _"Invio ticket tag vuol dire che io
quell'evento mi sono iscritta."_

Aurel Mrruku ruled that this is **CampaignMember status natively**, not custom
tag fields, and Elena Spini deleted the whole tag block including the parent tag.
Her own framing to the client: _"non si chiamerà più Tag FM, ma sarà campaign
dell'edizione Food Marketing Festival 2026"_.

This retires the `rinuncia` / `iscritto` / `presente` tag machinery that
[OI-81](../items/OI-81%20Event%20communication%20funnel.md) records the Zoho
funnel driving off — the states move to CampaignMember.

## Deleted from the Contact

- **The whole second-address block** (`Altro indirizzo`, `Altro telefono`,
  `Altra città`, `Altra via`, `Altra provincia`). Elisa Migliano: Pienissimo
  works from the **Account** or the **preventivo**, never the contact's own
  address — _"noi facciamo fede a quello che c'è nell'azienda o al massimo nel
  preventivo … nel contatto non ci interessa"_.
- **The Google Ads block** — `Ad Group ID`, `Nome Ad Group`, `Ad Click Date`,
  `Ad Network`, `Cost per Click`, `Cost per Conversion`, `GCLID`, `Keyword`,
  `Prima visita`, `Prima pagina visitata`, `Tipo dispositivo`, `Giorni visitati`.
  Nobody in the room knew what they were for.
- **`Nome campagna di annunci`**, deliberately, after being briefly considered as
  a lookup to Campaign. Aurel Mrruku's reason is the one to keep: the
  contact-to-campaign link is made by the **community form** — email creates the
  contact, the contact is linked to the asset, the asset to the campaign — so a
  campaign name held on the Contact is a value that goes stale and, worse,
  _"puoi mandare un annuncio su una campagna che hai già finito"_.
- **`Invio email contatto principale` 1–4** and the ticket-send fields.
- **`Contatto con telefono duplicato`** — Salesforce has native duplicate
  detection, so the Zoho rule field is redundant.
- **`Spesa marketing`**, **`Tipologia contatto`**, **`Tipologia locale`**,
  **`Ufficio di competenza`**, **`Punteggio visitatore di campagna`**,
  **`Modalità/Ora iscrizione annullata`**, **`Numero di chat`**,
  **`Ticket materiale`**, **`Relatore`**, **`Ragioni sociali iscrizione`**,
  **`Cerca rete partner`**, **`Natura`**.
- **All the `CF1…CFn` fields** — Elena Spini identified these as the merge fields
  Pienissimo uses inside the ticket emails, which Salesforce supplies from
  contact, product and campaign data instead.

## Kept

- **`Contatto principale` / `Contatto amministrativo` / `Contatto commerciale`**
  checkboxes. Elisa Migliano: they were needed to configure the **solleciti**
  (reminder) sending procedure and she wants them.
- **`Auto marketer`** — and its meaning is now recorded. It is a **blocking
  flag**: Pienissimo does not deal with marketers as a matter of company privacy
  policy — _"noi non ci interfacciamo con marketers, cioè proprio contro la
  privacy aziendale"_. Elena Spini asked to have it rendered in capitals.
- **`Ruolo iscrizione`** (`titolare` / `collaboratore`). It is filled **by the
  customer** when compiling the ticket and **Pienissimo cannot edit it** — _"è lui
  che lo mette nel momento in cui compila il biglietto e noi non lo possiamo
  modificare"_. It has to exist on the community form.
- **`Tutor`**, as a lookup to User.

## The primary-contact rule, refined

Parte 2 recorded the reference contact becoming editable on the quote with a
self-deactivating `contatto principale` flag. Parte 3 sharpened **who the
participant-data link actually goes to**, and the answer is not the titolare:

- Elisa Migliano: the tag goes to _"chi è il contatto cui assegnato il preventivo
  in cui sono presenti quei biglietti"_ — whoever the quote was made out to.
- Elena Spini: it is _"quello che ha fatto l'acquisto"_, and that may be an
  assistant rather than the owner.
- 🔴 **The `contatto principale` flag is set manually by tutors and is sometimes
  simply absent** — Elisa Migliano: _"a volte succede che non ci sia, quindi può
  essere che non ci sia in alcuni casi"_.

**Agreed** (Aurel Mrruku, 00:56:52): the contact field on the form is
**mandatory**, a **free selection among the account's contacts**, **pre-filled
with the `contatto principale` where one exists**, and **user-editable**. Not a
fixed lookup, and not blank.

⚠ Aurel Mrruku also noted that the address the invitation link is sent to is
**held on the Account** and _"non è detto che la stessa mail sarà la mail del
contatto principale"_. That bears directly on
[the invitation build](../flows/Proposed%20event%20invitations%20for%20participant%20registration.md),
which resolves a recipient contact.

## Da approfondire

### The UTM fields are removed pending a reporting decision

`utm_source`, `utm_medium`, `utm_campaign`, `utm_content`, `utm_term` are
**deleted from Account and Contact for now**. Aurel Mrruku's argument: a Contact
or Account created by lead conversion **keeps the link to the converting Lead**,
so the values can be read from the Lead rather than duplicated —
_"rimane sempre il legame con l'ID da cui è stato convertito"_.

The decision is explicitly deferred to **flow testing**: whether to query them
through the Lead or store them on both objects is to be settled _"nel momento in
cui andiamo a testare i flussi"_. Elisa Migliano's only requirement is that they
remain usable as statistics on lead provenance.

⚠ Elisa Migliano had already asked **Sabatino Rinaldi** how campaign UTMs are set
on Salesforce and reports he said it is enough that they can be seen. That
conversation is not otherwise in the record.

### The questionnaire fields have nowhere to live

The largest unresolved block of the session, and a new row —
[OI-123](../items/OI-123%20The%20Zoho%20questionnaire%20fields%20have%20no%20home.md).

Elisa Migliano identified a long list of Contact fields as belonging to an
**intake questionnaire the tutors run verbally**: `Coperto medio`, `Apertura
locale`, `Attuale posizione su TripAdvisor`, `Numero collaboratori`,
`Numero coperti`, `Quanti giorni alla settimana lavori`, `Nuova apertura`,
`Tipologia cliente`, `In quale servizio lavori maggiormente`,
`La più grande difficoltà adesso`, `Provenienza iscrizione`, `Data questionario`.

Why they are on the Contact at all: _"non riuscivamo con Zo a tenerlo esterno e
perché i tutor volevano che fosse in un'unica pagina rispetto al contatto che
chiamavano … è per quello che l'abbiamo messo all'interno del contatto, perché
non volevano una pagina esterna su cui atterrare"_. Her own verdict on it:
_"che è sbagliatissimo"_.

Where they belong is **not the Contact and arguably not the Account either** —
Elisa Migliano: _"più di locale, perché un account può avere più tipologie di
locali diverse"_. There is no *locale* object in the data model.

They were all **deleted for now**, and the action is on Elisa Migliano to take it
to the **responsabile commerciale (Marco Montesi)** — _"bisogna parlare con
responsabile commerciale per capire uno se effettivamente lo stanno utilizzando e
due come gestirlo"_.

## Passaggi successivi

| Owner            | Action                                                                                  |
| ---------------- | --------------------------------------------------------------------------------------- |
| Elisa Migliano   | Take the questionnaire fields to the responsabile commerciale — use and placement         |
| Aurel Mrruku     | Build the form's primary-contact field: mandatory, pre-filled, editable                   |
| Aurel Mrruku     | Decide UTM reporting during flow testing — read from Lead, or store on Account and Contact |
| Elena Spini      | Remove spesa marketing, telefono duplicato, tipologia contatto, tipologia locale, ufficio di competenza, punteggio visitatore di campagna |

## Also recorded

⚠ **Elisa Migliano could not paste a screenshot into the Meet chat** because she
is an external participant, so she **mailed it instead** — that is the
`ultima iscrizione` mail from `amministrazione@pienissimo.com` at 09:26:50Z to
Elena Spini and Aurel Mrruku, six PNG attachments and no body text. It shows the
Zoho `ultima iscrizione` block: `edizione iscrizione`, `data iscrizione`, the two
consent fields, `ruolo iscrizione`, `natura` and `ragioni sociali iscrizione`.
🔴 **The screenshots are of a live contact record.** Their existence is recorded
here; **no value from them is copied into this repository.**

⚠ **The Salesforce demo was of unfinished work.** Elena Spini showed the client a
contact's Campaign History and had to say _"adesso è un po' tutto in fase di
costruzione, per quello non non lo volevo far vedere"_; Aurel Mrruku confirmed
_"stavamo facendo dei test l'altro ieri, ma non abbiamo finito le strutture"_ and
that he was building the parent/child campaign structures as they spoke. Elena
Spini was also not signed into her own user and had to browse on Aurel Mrruku's.

⚠ **Nothing in this session touched Utenti, Profili, the Ordine field list or the
initial-load plan** — the four gaps
[OI-24](../items/OI-24%20Data%20model%20workbook.md) has carried since 2
September survive a **fourth** session. The Lead table was not opened either.

Closing exchange: _"A posto, ci vediamo domani"_ — Parte 4, Tuesday 8 September
12:00.
