---
id: MTG-2026-09-02-anagrafica
type: meeting
status: resolved
owner: Elena Spini
org: both
raised: 2026-09-02
updated: 2026-09-02
source: Drive - "[ROMI-PIENISSIMO] - Follow-up Anagrafica Articoli - 2026/09/02 10:00 CEST - Appunti di Gemini", full transcript read 2026-09-02
---

# 2026-09-02 Follow-up Anagrafica Articoli

**Client-facing session, 2 September 2026, 10:00-11:30 CEST; the transcript runs
1h16m37s.** Booked by Elena Spini on 26 August. Present: **Elisa Migliano and
Fabrizio Paganelli together in one room** (Elisa: _"io e Fabri siamo insieme,
quindi non si connetterà per quello"_ - so Fabrizio attended and did not speak
on the recording), **Andrea Di Cicco**, **Aurel Mrruku**, **Elena Spini**, who
joined a few minutes late.

🟢 **This note replaces the action list written the same morning.** That version
was built from the Gemini summary mail alone and said the full drill was still
owed. The **Gemini notes document, including the complete transcript**, became
readable in Drive at 10:36Z and was read in full by the 2 September nightly
sweep. Everything below is from the transcript unless marked otherwise.

## The two questions the client came with, and their answers

The 1 September mail promised _"un paio di domande"_ that were in neither the
mail nor the workbook. **They were asked verbally, at the top of this call, and
both were answered.** They are:

1. **Is it worth spending a Mexal field on `tipo biglietto` for ~15 article
   codes?** Elisa Migliano: _"vale la pena di impegnare un campo di mexal per
   solo 15 codici articolo?"_ - **Answer: no.** It becomes a Salesforce-only
   field, which also retires the double-coding trick agreed on 26 August.
2. **Should bundle-only article codes carry a list price of zero?** _"prezzo di
   listino sui ci metto zero, dico bene?"_ - **Answer: no.** Keep the real list
   price; set the bundle price when the article is attached to a bundle.

⚠ **Authorship correction.** The workbook was mailed from
`fabrizio.p@pienissimo.com`, and the record has been attributing it to Fabrizio
Paganelli. Elisa Migliano says in this call: _"ieri vi ho mandato quel file"_ and
_"questo qui è un file che ho fatto io a mano"_. **She wrote it**; it was sent
from his mailbox. Both sit in the same room, so this is a mailbox, not a claim
about who owns the registry.

## Decisions

### 1. `Tipo Biglietto` is a Salesforce-only, administrator-only field

Mexal keeps **`genera biglietto` / `solo bundle`** and **`evento`**. `Tipo
biglietto` moves to Salesforce entirely, so the plan of packing two
classifications into one scarce Mexal field is dropped.

Aurel Mrruku set out the cost honestly, and it was accepted:

> _"non c'è automatismo per beccare quella problematica… se metti su un prodotto
> una tipologia di biglietto che non c'entra niente con quel prodotto, lì non ti
> posso aiutare."_

**There is no validation.** The mitigation is access, not logic: the field is
_"modificabile solo lei system admin"_, and Elisa Migliano asked for more than
that - _"questo menù dell'anagrafica prodotti deve essere visibile esclusivamente
alla all'account amministrazione@pienissimo.com"_, so that only she and Elisa
maintain it.

**Volume**: about 15 codes carry a value (_"dalla riga 5 alla riga 18"_) against
a course registry of 40-50 rows, so roughly **twenty manual updates a year**.
Aurel Mrruku drew the line explicitly - fine at 13, not at 100-200.

⚠ **Elisa Migliano also said she will need _"ulteriori cinque sei campi"_ on
Salesforce only, decoupled from Mexal.** They were not named. That is five or six
unspecified product fields landing after the Fase 1 build.

### 2. Bundle-only articles keep their real list price

Aurel Mrruku: _"quando tu scegli quel prodotto che è usabile in un bundle, lo
agganci a quel bundle che stai formando, hai il diritto di specificare qual è il
prezzo di quel prodotto in quel bundle… così sai anche il prezzo originale."_
Elisa Migliano accepted.

This answers the open question against
[OI-48](../items/OI-48%20Bundle-only%20article%20codes.md) - **the ten codes are
not unpriced by design; they are to be priced normally** - and it is the same
mechanism [OI-93](../items/OI-93%20Bundle%20components%20should%20be%20priced%20articles.md)
asks for.

### 3. `Stato Bundle` - a staging state, proposed in the room by Aurel Mrruku

> _"volete fare il bundle in modo passivo… facciamo tipo un stage del bundle,
> in lavorazione, così siamo sicuri che se state lavorando con un bundle nessuno
> lo possa usare."_

Elisa Migliano: _"Non sarebbe male… nessuno lo possa utilizzare."_ The transition
to **confermato** is either a button or a manual field change - Aurel offered
both and neither was picked.

🟢 **This confirms from the transcript what
[the build](../objects/The%20three%20generations%20of%20bundle%20article%20code.md)
had to infer**: the state lives on the **bundle product in Salesforce**, and the
values are _in lavorazione_ → _confermato_. The field's own description says it
is provisional; that caveat can now be narrowed to the exact value names.

### 4. Bundles are built by administration only, and the volumes are small

Aurel Mrruku: _"i bundle si devono fare da Elisa e Fabrizio"_ - **not by
tutors**. Elisa Migliano's own count: **9 events a year, ~6 of which carry
bundles, ~4 bundles each → 24-30 a year**, plus _"massimo altri sette"_ marketing
campaign bundles. Conclusion accepted on both sides: **manual creation is
sustainable and no automation is needed.**

She also described the existing control: before an event they run test purchases
as if they were customers.

### 5. Fiscal residence is derived automatically from the country code

**This closes the decision
[OI-97](../items/OI-97%20Fiscal%20residence%20on%20the%20customer%20registry.md)
recorded as never discussed.** Elisa Migliano: _"abbiamo la possibilità di andare
ad alimentare il tipo nazionalità in base al codice del paese"_; Andrea Di Cicco:
_"volendo sì, si può fare come mapping."_

Five values, and her reason for wanting it derived rather than typed: _"se
riusciamo già a blindarlo all'origine siamo a posto"_, after past invoices to
foreign subjects went out wrong.

| Value                |
| -------------------- |
| Italia               |
| Unione Europea       |
| Estero non-UE        |
| San Marino           |
| Vaticano             |

⚠ The country-code list is not two or three acronyms: _"sono tutte le nazioni e
sulle API dovresti avere una tabella che si chiama paese dove sono tutte
codificate."_ Andrea Di Cicco had not noticed that table - _"non ci avevo fatto
caso, poi dopo le controllo"_ - so the mapping's source list is identified but
unread.

### 6. Anticipay is called for every customer, including foreign ones

**The 1 September call left the foreign-VAT case unanswered. This one answers
it**, and not in the direction the record expected.

Aurel Mrruku restated the constraint: _"anticipi salva solo le aziende italiane…
se la partita IVA non è italiana ritorna 404."_ Andrea Di Cicco proposed the
obvious economy - _"secondo me non la facciamo proprio la chiamata se estera"_ -
and Aurel Mrruku offered a country check on the Salesforce side.

**The room chose to call every time anyway.** Elisa Migliano's reason is the good
one and it is not about Anticipay at all:

> _"nelle partite IVA estere soprattutto ci sono dei caratteri speciali… a
> prescindere secondo me è bene che ci arrivi comunque una sorta di errore per
> controllare che non abbiano scritto cose inusuali."_

So the call doubles as **input validation on a hand-typed VAT number**, and the
error is the product, not a failure. Aurel Mrruku: _"quindi io lo farei sempre la
chiamata verso anticipay."_

**The failure path was designed in the room**: Elena Spini - _"questa
informazione deve essere girata con una mail all'amministrazione, quindi voi
verrete notificati, poi sistemate a mano"_; Aurel Mrruku - _"e nella mail
mettiamo proprio il link del dato su salesforce, così se cliccate entrate e
controllate."_

🔴 **And the gap was found live.** Elena Spini went looking for the foreign-company
case in the API documentation and did not find it: _"la cosa estera in effetti
non c'è negli errori. Non so cosa può rispondere."_ **A design whose whole
mechanism is the error response now rests on an error response nobody has seen** -
which is exactly
[OI-107](../items/OI-107%20The%20Anticipay%20error%20path%20does%20not%20reach%20the%20integration%20log%20intact.md).

### 7. The Zoho customer registry gets a field-by-field review, three sessions booked

Elisa Migliano raised it herself, and the number is the point:

> _"l'anagrafica clienti estrapolata oggi da Zoho ha 150 campi… ho detto qui
> andiamo in confusione, sicuro. Sono andata in confusione io da sola con me
> stessa, su un'anagrafica che conosco."_

Her proposal - half-hour calls, one table at a time, deciding for each Zoho field
whether Salesforce needs it, what it contains and how it should be fed - was
accepted by Andrea Di Cicco and Aurel Mrruku. Andrea Di Cicco's reason is the
integration's: what sits on the customer registry must contain at least what
Mexal needs, without creating `piva` and `partita IVA` twice.

Elisa Migliano also read the registry's own history into the record: many Zoho
fields _"erano già presenti e semplicemente non sono state eliminate… dovrebbero
essere anche nascosti"_, so the cleanup should be quick.

**Sessions agreed in the room and invited the same morning**: 3 September
11:00-12:00, 4 September 16:00-17:00, 7 September 11:00-12:00 CEST.

## The Mexal integration contract, dictated field by field

The second half of the call is Elisa Migliano reading the Mexal customer and
order screens aloud while Andrea Di Cicco maps them. **The rules are recorded in
[the Mexal integration note](../flows/The%20Mexal%20integration.md)**; the
headlines:

- **`tipo fattura elettronica`**: the B2B value for Italian companies, blank
  (_"non gestita"_) for everyone else. ⚠ **The code was guessed, not read** -
  _"Potrebbe essere S"_ / _"Potrebbe essere S. Sì, esatto"_ - and never confirmed
  on screen.
- **PEC drives electronic invoicing** and is _"fondamentale"_.
- **Every customer carries a `codice agente`** for commission calculation. The
  sales network is the **tutors**: all have CRM access, some are employees, two
  have agency contracts and are paid commission.
- **Currency is Euro only**, fixed - which also retires the 26 August unknown
  about what `valuta = 1` means in practice for this client.
- **Only listino 1** is used, confirming 26 August.
- **Order sigla**: `OC` for services, **`BC` for books** - _"questa c'era
  sfuggita effettivamente"_. Books never share an order with services.
- **Causale** follows sigla and fiscal residence: OC → 1 Italy, 2 San Marino,
  3 elsewhere; BC → 4, 5, 6 on the same split.
- **Warehouse**: 1 for OC, 2 for BC. **Cost centre `costi ricavi`**: 3 (servizi)
  for OC, 1 (materie prime) for BC.
- 🔴 **Every order line must carry a `data di scadenza`, and it is the tranche
  due date** - Andrea Di Cicco: _"è per le tranche"_. Elisa Migliano: _"oggi noi
  non la gestiamo, però un domani andrà messa."_
- 🔴 **`codice agente`, `zona` and `classificatore rete` are wanted on the order
  header and Andrea Di Cicco could not find them** in the field set the Mexal
  read call returns - [OI-110](../items/OI-110%20Agent%20and%20network%20fields%20are%20missing%20from%20the%20Mexal%20order%20call.md).

## Actions

| Owner           | Action                                                                                            | State                                                                     |
| --------------- | ------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------- |
| Aurel Mrruku    | `Tipo Biglietto` on Salesforce, administrator-editable only                                       | ✅ **built and deployed the same day**                                    |
| Aurel Mrruku    | `Stato Bundle` field plus the transition on confirmation                                          | 🟡 field built; **the transition logic is not**                           |
| Elisa Migliano  | Copy every relevant Zoho field into ROMI's shared interface file and confirm by mail              | ✅ **done 2 Sept 14:05Z**, mail at 14:06Z                                 |
| Elisa Migliano  | Publish the updated data model file _"immediately after the call"_                                | ✅ same file - see [OI-24](../items/OI-24%20Data%20model%20workbook.md)   |
| Andrea Di Cicco | Add the invoicing customer fields to the interface and run a populated test                       | 🔴 not seen on any source                                                 |
| Andrea Di Cicco | Update the JSON with the agreed fields and send a test                                            | 🔴 not seen on any source                                                 |
| Elena Spini     | Send calendar invitations for tomorrow, Friday and Monday                                         | ✅ **sent 09:08-09:19Z**                                                  |
| The group       | Run the table-by-table Zoho → Salesforce mapping sessions                                         | 🟡 booked, not yet run                                                    |

## Calendar constraints stated in the room

- 🔴 **ROMI is at a company event 9-11 September** (Elena Spini: _"dal 9 all'11
  siamo a un evento aziendale"_). **Fase 1 development is supposed to end on
  10 September.** Nobody in the call connected the two.
- Pienissimo is on tour 9-10 September but _"non ci attacchiamo nulla"_.
- Elisa Migliano is on a first-aid course **17 September 09:00-13:00**.

## What this session did not do

- **The event-name mismatches and the three colliding article codes** found in
  [the workbook decode](../The%20Anagrafica%20Articoli%20workbook.md) were **not
  raised** - they were found after the meeting.
- **`Anno Solare` was never mentioned**, so the ten loaded records still carry
  `Anno Solare 2026` on ROMI's assumption alone
  ([OI-46](../items/OI-46%20Bundle%20classification%20picklists.md)).
- **Nobody asked what happens to a bundle already in use when its state goes back
  to _in lavorazione_**, or who may flip it.
- **No estimate was attached to anything**, eight days from the end of Fase 1
  development.
