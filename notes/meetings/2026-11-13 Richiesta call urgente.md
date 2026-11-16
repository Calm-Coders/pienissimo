---
id: meeting-2026-11-13-richiesta-call-urgente
type: meeting
status: resolved
owner: Elena Spini
with: Aurel Mrruku, Elisa Migliano, Sabatino Rinaldi
org: both
raised: 2026-11-13
updated: 2026-11-16
depends_on: []
blocks: []
source: Drive 1pm6CUX3MdQEIlw2q0WomDzw-kgblbtCTPTTItoNNmcA
---

# 2026-11-13 - Richiesta call urgente

**Twenty-seven minutes, called by the client at 13:05 CET for the same
afternoon, in the middle of the final production release. The client asked for the
Opportunity to be won at the first payment instead of the last, admitted the
request came from an internal misunderstanding on their own side, and got it
implemented the same evening. It also reversed the fake-VAT decision of 10
November and settled the marketing consent on the fifty thousand imported
referenti with one sentence.**

## Attendees

- **Aurel Mrruku** (ROMI)
- **Elena Spini** (ROMI)
- **Elisa Migliano** (Pienissimo, amministrazione)
- **Sabatino Rinaldi** (Pienissimo)
- 🔴 **Fabrizio Paganelli invited and absent.** Elisa Migliano: _"Fabrizio entra
  piu tardi. Non penso neanche che faccia in tempo."_ He never joined. He is the
  one who gave ROMI the reverse-payment case the whole discussion turns on.

## Sources

| | |
| --- | --- |
| Transcript | Drive `1pm6CUX3MdQEIlw2q0WomDzw-kgblbtCTPTTItoNNmcA`, 23,318 bytes, **read in full** |
| Duration | **00:27:14** |
| Written trace | Elena Spini's recap mail to the client, Gmail `1a1d55fdf926a7b5`, 2026-11-13 14:46:20Z |
| Recording | ⚠ none found in Drive — transcript only |

## How the call came to exist

Pasted by Elena Spini into the ROMI DM at 13:19 CET, from WhatsApp:

> **Sabatino Rinaldi, 13:05:** _"Ciao elena riusciamo a sentirci dopo pranzo con
> elisa e Fabrizio? E urgente"_
> **Elena Spini, 13:09:** _"Ciao Sabatino, tema?"_
> **Sabatino Rinaldi, 13:15:** _"Opportunity"_ · _"Una regola di quando deve
> passare in vinta"_

Elena Spini's own reading of it, before the call, in the DM: _"gli odioooooo che
palle"_ · _"quando gli vogliamo sentire a questi scappati di casa?"_ · _"Metto un
meeting 14-14.30 tanto per me saranno cose assurde che non faremo ma capiamo cosa
vogliono."_ Aurel Mrruku: _"ma io sono in mezzo al deploy finale in prod."_

## The request, and whose fault it was

Sabatino Rinaldi opened by taking the blame:

> _"Mettiamo le mani avanti, **nostra culpa** perche c'e stato tra di noi non ci
> siamo capiti e sta roba non va bene."_

The rule as built, which he restated correctly: an Opportunity goes Vinta when the
order is **paid in full**. The ask: Vinta at the **first** payment, _"solo
l'opportunity, nessun'altra regola."_

Elisa Migliano gave the business reason: a Performance Plus sold over twelve
monthly tranches only closes at the twelfth, and _"questo e lato commerciale
sbagliato … non e proprio un dato corretto a livello statistico, a livello
commerciale, a livello marketing di opportunity."_

🔴 Elena Spini's answer on the record: _"Ma com'e possibile che oggi e venerdi,
oggi c'e il rilascio"_ and _"in realta c'e documento, flussi e detto e ridetto."_
See
[OI-343](../items/OI-343%20The%20client%20disputes%20that%20the%20stage%20sale%20contract%20was%20outside%20the%20Fase%201%20Blueprint.md)
for the other live dispute about what the Blueprint says.

## What was settled

| Ruling | Words on the record |
| --- | --- |
| **First invoice, not first tranche** | Aurel Mrruku: _"Prima fattura, non prima tranch perche prima tranch e per i biglietti"_ — one invoice can carry several tranches, and one tranche several events |
| **Incassata, not emessa** | Elena Spini: _"direi incassata a questo punto"_; Elisa Migliano: _"esatto"_ |
| **WooCommerce included** | Sabatino Rinaldi: _"ovviamente questo deve valere anche per Wocommerce"_ |
| **The lock comes off** | Aurel Mrruku: _"l'altra cosa da segnare che devo fare stasera e rilassare i cambiamenti che si possono fare su un'opportunity vinta"_ |
| **No reverse gear, accepted** | Aurel Mrruku: _"se un'opportunity va in vinta, quella rimane in vinta … non c'e nessuna casistica che mi fa portare indietro l'opportunity"_ → [OI-365](../items/OI-365%20The%20Opportunity%20cannot%20return%20from%20Vinta%20once%20a%20payment%20is%20reversed.md) |
| **Admin correction only** | Aurel Mrruku: _"solo per system admin e abbiamo risolto. Pero e chiaro che se qualcuno lo fa poi vedrete dei dati che non matciano con le logiche"_ |
| **The invoice-date logic is deferred** | Elisa Migliano proposed ordering invoices by date; Aurel Mrruku: _"io per il momento non ce l'ho l'informazione qual e la prima o la seconda fattura."_ Parked for Fase 2 |

🔑 Aurel Mrruku asked for it to be written down, and said why:

> _"deve essere scritto da qualche parte perche cosi rischiamo che dopo 6 mesi
> venite da noi e dite fate un'analisi cosa e successo."_

Elena Spini did write it down the same afternoon — the 14:46Z mail, which calls
the change _"in deroga a quanto previsto nel Blueprint"_ and says ROMI proceeds
unless told otherwise. See
[the decision](../decisions/Decision%20-%20the%20Opportunity%20is%20won%20at%20the%20first%20collected%20invoice.md).

⚠ Aurel Mrruku on the method: _"io lo posso fare tecnicamente adesso che con AI si
puo fare di tutto, pero poi dobbiamo anche testare insieme per vedere tutte le
casistiche. **Stiamo andando a memoria un po'.**"_

## Two things settled at the end, which were not the reason for the call

🟢 **The fake Partita IVA is dropped.** Aurel Mrruku opened the call with it:
_"la partita IVA non e obbligatoria sui lead, non so perche e stato detto da te
che e obbligatorio."_ Elena Spini: _"avevo detto io che partita IVA doveva essere
con un campo fake, mi ha ripreso, ha detto che si puo mettere anche blank, quindi
e ancora meglio."_ `Company` is still mandatory, and after weighing a progressive
number, `xx` and `da import`, the three of them chose **"Referente Importato"** —
Elena Spini: _"Peggio di cosi si capisce che non e veramente un lead."_ This
reverses
[OI-352](../items/OI-352%20Referenti%20leads%20were%20loaded%20with%20a%20placeholder%20company%20and%20no%20VAT%20value.md).

🔴 **The marketing consent on the imported leads, in two lines.** Aurel Mrruku:
_"sui lead dobbiamo tracciare … i flag per comunicazione marketing"_ →
_"**Si, li metto tutti a true.**"_ Sabatino Rinaldi: _"Chiaro, per forza tutti."_
No discussion of where the consent came from, and no written confirmation asked
for or given. See
[OI-351](../items/OI-351%20Referenti%20without%20a%20Mexal%20code%20are%20imported%20as%20marketing%20leads.md).

## Fase 2, raised in passing and still unanswered

Elena Spini chased the reply to **Andrea Galotto's mail of Tuesday 10 November**:
_"nessuno ci ha risposto"_ … _"considera che noi stiamo gia facendo cose che sono
in quel documento."_

🔑 Sabatino Rinaldi named the decision maker: _"bisogna che lo legga **Daniela**"_
([Daniela Morgese](../people/Daniela%20Morgese%20-%20Pienissimo%20direction.md)) — _"ne abbiamo parlato oggi"_,
_"gliel'ho fatto stamattina fino a un'ora fa"_, _"e qui di fianco"_, _"sollecitiamo
e prima possibile."_ Elena Spini set the expectation herself: _"Vediamo risposta
entro … **sparo martedi**"_ — i.e. **17 November**. Recorded in
[OI-342](../items/OI-342%20The%20Fase%202%20offer%20V2%20reorders%20the%20releases%20and%20contradicts%20itself.md).

⚠ Elena Spini also reported, without a source in the room, that **Fabrizio
Paganelli has put the scadenzario release in December**: _"Fabrizio ce l'ha messo a
dicembre"_, against _"quel rilascio di scadenziario detto a Fabrizio doveva essere
veloce e indolore."_ Relevant to
[OI-349](../items/OI-349%20Fase%202%20has%20no%20developer%20committed%20for%20December.md).

## Not in this record

- **No euro figures transcribed.** The Performance Plus monthly figure was said
  aloud and is deliberately not copied here.
- **The reverse-payment case itself was second-hand.** Aurel Mrruku quoted
  Fabrizio Paganelli's bank-transfer example from memory — _"se non mi sbaglio"_ —
  and Fabrizio Paganelli was not there to confirm it.
