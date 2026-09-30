---
id: OI-194
type: open-item
status: open
owner: Aurel Mrruku
with: Elena Spini
org: both
raised: 2026-09-29
updated: 2026-09-29
depends_on: [OI-185, OI-74]
blocks: [go-live]
severity: gating
requirement: BIG-06
source: notes/meetings/2026-09-29 Pre UAT Check giro MKT.md
---

# OI-194 - The ticket is a signed participation document not just a QR code

**The artifact the participant receives is `Pienissimo_Scheda di Partecipazione ai
corsi_da firmare.pdf` — a multi-page document carrying the QR code, dynamic event
and participant fields, and an enrolment pack. The record had carried it as "a QR
code". Elena Spini: _"noi l'abbiamo dimenticato… è imprescindibile."_**

## What the document actually is

Established at [the 29/09 pre-UAT marketing session](../meetings/2026-09-29%20Pre%20UAT%20Check%20giro%20MKT.md)
(`00:30:00`–`00:40:00`) with the file open on screen. It is Drive
`1ATj-uig8M9OsT-C6Xwf5IBBari5ENApt`, owned by Elena Spini, **created 26 June 2026**
— the client handed it over at the start of the engagement.

Its structure, read from the file's own text:

| Block | Content |
| ----- | ------- |
| `EVENTO` | event name, day/month/year |
| `PARTECIPANTE` | first and last name, mail, ragione sociale |
| `TICKET` | event name, date, venue — the block the QR sits with |
| `INFORMAZIONI AGGIUNTIVE` | static; includes _"Diamond e Vip hanno ingresso dedicato."_ |
| `MESSAGGIO DALL'ORGANIZZATORE` | static; the ticket is nominative and non-transferable |

The organiser's block states what the participant must bring to check-in: the
printed ticket, **_"i Documenti di Iscrizione al corso che sono 7 pagine da
consegnare al personale al check-in"_**, and a valid identity document. So the
deliverable is the ticket page **plus a seven-page enrolment pack**, not a page.

## Why this is a finding and not a restatement

The record has described the ticket artifact as a QR code throughout
([the ticket lifecycle](../flows/The%20ticket%20lifecycle.md),
[OI-185](OI-185%20The%20participant%20name%20change%20regenerates%20the%20ticket%20as%20a%20new%20asset.md)).
Aurel Mrruku said so in the session: _"Serviva solo il QR Code per scaneggiare col
palmare, quello che usavano loro e basta."_ Elena Spini corrected him and took the
omission herself — _"Questa è la base di tutto questo progetto, va fatto, non è una
scelta, purtroppo, perché noi l'abbiamo dimenticato."_

⚠ **The file was seen once and never written up.** It appears in
[the 14/08 external sweep trace](../traces/Source%20trace%202026-08-14%20external%20sweep.md)
and in no note, no tracker row and no register row since. It resurfaced because
Elena Spini re-posted the link into the MKT group DM at 10:05 CEST on 29/09.

🟢 **The signature is gone.** Both agree the earlier plan to have the document
signed — the DocuSign route — was dropped. What survives is generating it and
putting the QR on it.

## The build problem, as its builders state it

- **Page one is a four-quadrant layout of dynamic campaign fields.** Aurel Mrruku:
  _"Sono tutti campi di campagna e poi devi fare quella roba in quattro che non so
  manco come si fa."_ Asked whether it is hard: _"Sì che è difficile. È tanto
  difficile, ma davvero tanto difficile."_
- **The QR is a separate artifact that has to be composited onto it** — _"devi
  mettere insieme il QR code che è un altro documento su questo documento"_.
- **Fabrizio Mastracci will not paginate free text in a marketing send**: text areas
  would need their own HTML pagination system. His counter-proposal — send the QR
  image and attach the blank pack as a fixed attachment — was **not adopted and not
  rejected**.
- Approach chosen in the room: a Visualforce page rendered to an image. Rexhina Hysi
  told Aurel Mrruku during the call that she can do it.
- ⚠ **Sending an attachment from Marketing Cloud is unproven.** Fabrizio Mastracci:
  _"non mi è capitato ancora di mandare proprio delle mail di marketing con
  l'allegato… C'è la funzionalità"_ — he has to test it.

## 🟢 Work started the same day, and is not on `DevMain`

Three commits on **29/09**, none merged:

- `e2bdb1f` (Rexhina Hysi, 15:26 CEST) — `ParticipantTicketPdfController.cls` (226
  lines), `ParticipantTicketPdf.page` (251 lines), `ParticipantTicketDocumentJob.cls`,
  and a **1.26 MB `ParticipantDocumentTemplate` static resource**.
- `1e1ab6d` (Aurel Mrruku, 17:00 CEST) — the platform-event rebuild, see
  [OI-185](OI-185%20The%20participant%20name%20change%20regenerates%20the%20ticket%20as%20a%20new%20asset.md).
- `963e582` (Rexhina Hysi, 18:24 CEST, `DevMain_exposeEndpoint`) — **deletes the
  static resource and inlines it**, taking `ParticipantTicketPdf.page` from 251 to
  **7,733 lines**; adds `Asset_Ticket_Record_Page.flexipage`, an `Asset`
  pathAssistant and Asset fields.

🔴 **All three are on `DevMain_exposeEndpoint`, which has no PR.** `DevMain` at
`4c9b121` carries none of the document stack.

## Open

- **Whether the seven-page enrolment pack is generated or attached blank.** Aurel
  Mrruku's position is that it must all be one document — _"Alla fine si fa meglio
  che si fa tutto, così viene mandato solo un documento"_. Fabrizio Mastracci's is
  that the pack should be a static attachment. Not decided.
- **Whether the four-quadrant layout can be re-drawn.** Elena Spini offered to
  propose a different arrangement to the client — _"gliela riorganizziamo e
  chiediamo"_ — but would not commit, because they may insist on the given format.
- **The static blocks are unverified against the client's current text.** The file
  is three months old and nobody has asked whether it still stands.

🔴 **Ticket UAT is 30 September, 14:00–16:00 CEST**, with Fabrizio Paganelli, Elisa
Migliano and Rebecca Marmo invited. Aurel Mrruku's own forecast, in the session:
_"col cavolo che riusciamo domani, però. Andrà male anche domani."_
