---
id: MTG-2026-10-07-temi-integrazione-mexal
type: meeting
status: resolved
owner: Elena Spini
org: both
raised: 2026-10-07
updated: 2026-10-07
depends_on: [OI-201, OI-209, OI-211, OI-212, OI-213]
source: Drive 1ud8rHoyY9D-5YvHDw3BCiHtGNoakbhwFjOZU643x0vY (Gemini notes)
---

# 2026-10-07 Temi Integrazione Mexal

**Vendor call, 12:16 CEST, ~48m.** Elena Spini · Aurel Mrruku ·
**Fabrizio Paganelli · Elisa Migliano** · **Mirko Merendi (Kreosoft)**.

🔑 **The call [OI-211](../items/OI-211%20Mexal%20rejects%20N%20for%20the%20electronic%20invoicing%20code.md)
was due at. It produced four `Concordato` rulings — one of which qualifies the
payment rule the repository implemented four days ago and makes the code wrong
as committed.**

## Concordato — four rulings

- 🔑 **A rate in state `E` counts as paid only if its due date is in the past.**
  Agreed by Aurel Mrruku, Fabrizio Paganelli and Mirko Merendi: _"se una rata
  presenta lo stato `E` ma la data di scadenza è futura rispetto alla data
  odierna, il sistema dovrà considerarla come 'da pagare' anziché pagata"_,
  avoiding a prematurely overdue state. **This qualifies
  [OI-201](../items/OI-201%20Ri.Ba.%20payments%20are%20read%20as%20unpaid%20because%20only%20P%20counts.md)**
  and opens
  [OI-212](../items/OI-212%20A%20Ri.Ba.%20rate%20reads%20as%20paid%20before%20its%20due%20date.md):
  the committed code tests `P || E` with no date condition.
- **The IVA rate is taken from the article registry.** The order line defaulted
  to `E01` (IVA-exempt goods) even for services, forcing manual correction.
  Mirko Merendi will change the customisation to pull the correct IVA code from
  the article registry at order generation, and gave Aurel Mrruku the API field
  names for the registry and the order lines.
- **The cost/revenue field stays set to services or raw materials.** Fabrizio
  Paganelli keeps it as is for reconciliation with the accountant, declining
  Mirko Merendi's offer of per-line cost centres in newer Mexal versions.
- 🔑 **Critical registry fields are locked in Salesforce after the first sync.**
  Billing address, partita IVA, fiscal residence and agents. Proposed by
  Fabrizio Paganelli, agreed with Aurel Mrruku and Elena Spini. **This is
  [OI-209](../items/OI-209%20Mexal%20anagrafica%20updates%20only%20propagate%20when%20an%20order%20is%20sent.md)
  confirmed with the vendor in the room**, the day after the design was agreed
  internally.

### The sync direction, stated precisely

⚠ The Gemini summary compresses this into _"l'anagrafica cliente debba
originare da Salesforce e sincronizzarsi su Mexal"_, which reads as a reversal
of the 06/10 design. **The transcript shows it is not.** Aurel Mrruku describes
both directions: the registry is created in Mexal the first time an order is
sent from Salesforce and updated on later sends — _"di notte succede il
contrario… se c'è un cambiamento su Mexal, su certi campi, quei campi vengono
portati anche sull'anagrafica del cliente su Salesforce"_. Fabrizio Paganelli
confirms the correction path with an example: noticing Italy was entered
instead of San Marino, they fix it **in Mexal** — country, electronic invoicing
type, fiscal residence — and _"la notte quando c'è il flusso di ritorno da
Mexal verso SF io mi trovo i dati su SF il giorno dopo corretti"_. So
corrections are made in Mexal and flow back nightly, exactly as recorded on
06/10, and the lock in Salesforce is what stops a manual edit racing them.

⚠ Aurel Mrruku raised the remaining hole himself: if someone changes the
billing address in Salesforce anyway, the next order send pushes it to Mexal.
The lock is what closes that, and **nothing is built**.

## OI-211 moved, and is not closed

🟢 **`N` is confirmed invalid.** Aurel Mrruku: _"Io ho cambiato adesso la N con
la S, scusa, la N con la P… per San Marino. Quindi San Marino mi è stato dato un
elenco e in quell'elenco c'era il valore N"_ — and _"io ho provato con N e mi
diceva che non esiste questo"_. He has switched the value to **`P`**.

🔴 **The admitted value set is still not documented, and two people disagree.**
Fabrizio Paganelli, reading a customer record, reports _"fattura elettronica
B2B S non gestita"_ and says he had told Aurel Mrruku **`M`**. Mirko Merendi's
only word on it is _"Giusto"_. Four values — `N`, `P`, `S`, `M` — appear in one
exchange with no transcoding table, and the formal next step assigned to Mirko
Merendi is to **investigate the country-code / fiscal-residence error and
report the solution**. OI-211 stays open on that.

## Next steps as recorded

- **Mirko Merendi** — build the Mexal customisation for line state, causale,
  contropartita, goods type and IVA rate on order lines; investigate the
  country-code / fiscal-residence error; send Aurel Mrruku the technical API
  field names.
- **Aurel Mrruku** — prepare a fresh test order with the supplied data;
  implement the scadenzario state logic (paid for past due dates, to-pay for
  future).
- **Aurel Mrruku and Fabrizio Paganelli** — test the payment-state handling the
  following week.
- **Fabrizio Paganelli and Elena Spini** — review the field-mapping document to
  decide which registry elements get locked in Salesforce.
- **Fabrizio Paganelli** — change the payment type immediately after the call.

## Of record

- **The order line state `S`/`E` problem has its parameter name.** Mirko
  Merendi named `Tipo_B_Stato_Bigga`: nothing is being passed, so it defaults to
  `S` (sospeso), and `E` must be set on every line
  ([OI-213](../items/OI-213%20Mexal%20order%20lines%20arrive%20suspended%20and%20cannot%20be%20invoiced.md)).
- **Why the date rule exists.** Fabrizio Paganelli explained that generating the
  bank flow on the twentieth of the month moves the rate from empty to `E`
  (emesso/presentato) **without the money having arrived**, and said plainly he
  feared tickets being released on Salesforce before actual payment. Mirko
  Merendi confirmed Mexal treats the rate as theoretically paid based on days of
  exposure, and that `P` is displayed from the payment date plus those days.
- **San Marino electronic invoicing is rolling out.** Mirko Merendi: the Mexal
  update is imminent, clients can proceed after a webinar, it is optional until
  the end of the year and **mandatory from the new year**. Fabrizio Paganelli
  counts seven or eight San Marino clients.
- **Commission categories are not native on the Mexal order** and must sit on
  the customer registry; Fabrizio Paganelli confirmed he had that added on
  Salesforce.
- A quote with two tranches carrying Mastery and Academy products was signed
  through DocuSign and generated the Mexal order automatically, failing first
  for a missing payment type and succeeding after correction.
