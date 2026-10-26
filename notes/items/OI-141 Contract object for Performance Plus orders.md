---
id: OI-141
type: open-item
status: open
owner: Aurel Mrruku
with: Andrea Di Cicco
org: ROMI
raised: 2026-09-17
updated: 2026-10-02
depends_on: [OI-140]
blocks: [go-live]
source: notes/meetings/2026-09-17 Follow-up Interno.md
---

# OI-141 - Contract object for Performance Plus orders

Decided at [the 17/09 internal follow-up](../meetings/2026-09-17%20Follow-up%20Interno.md).
**Nothing builds it.**

## The decision

When an order of type **Performance Plus** or **attivazione/rinnovo** is
generated, a **Contract record linked to the order is created automatically**
(`00:40:30`, `00:47:16`). Aurel Mrruku placed the creation **at the moment the
order is transmitted to Mexal**.

Elena Spini's reason for wanting the object at all: these orders need their
**state, total value, invoiced amount and collected amount** tracked over a life
longer than a single order. She gave an order-count and a per-order value for the
category; **neither figure is recorded here** — see
[docs/publishing.md](../../docs/publishing.md).

## How it is meant to be populated

🔴 **Through Mexal APIs that nobody at ROMI has the contract for.** The financial
fields — invoiced, collected, overdue, unpaid issued invoices — come from the
`scoperto clienti` / `scadenziario` calls, returned **aggregated per customer
code** (`00:58:46`, `01:00:43`). The notes' own `Da approfondire` block records
the alignment as **deferred to a session with Andrea** (`00:51:43`, `00:57:12`).

🟢 **That session is booked.** `[PIENISSIMO] - Temi Mexal`, **Friday 18 September
10:00–11:00 CEST**, Elena Spini organising, Aurel Mrruku and **Andrea Di Cicco**
invited — the invitation went out at 13:17:39Z the same afternoon. It is the
first thing to put Andrea Di Cicco back in a room since
[OI-139](OI-139%20Andrea%20Di%20Cicco%20is%20winding%20down%20with%20four%20integration%20questions%20unanswered.md).

⚠ **A one-hour slot now carries five outstanding questions plus this one.**
OI-110, OI-102, OI-125 and OI-135 are all his, all older, and none is on that
invitation's subject line.

## Dates are manual

The **signature date does not coincide with the start of service**. The
operational team — the notes say _"user strategies"_, the transcript
_strategist_ — enters contract **start and end dates by hand through a banner**
on the order (`00:55:19`, `01:11:11`). ⚠ Which team that is in ROMI's or
Pienissimo's own naming is **not established**; both sources use the English
term loosely and no person is named.

## What decides that a contract is needed

A **specific product code** on the offer determines whether a contract is
generated automatically (`01:04:06`). 🔴 **That code does not exist yet.** Elena
Spini: only ~2,000 sample codes and a further ~200 products have been sent, so
there is still no definitive product-code file, and a **dedicated parameter** has
to stand in for it. This is the same gap as **the article codes the client has
owed since the 14/08 sweep**.

## Open

- 🔴 **The contract data model is undefined** — the notes say so explicitly, and
  the _activation field_ with it (`01:11:11`).
- 🔴 **No register row covers it.** Nothing in
  `requirements/pienissimo-requirements.yaml` describes a Contract object. This
  is new scope stated internally by ROMI, eight days before UAT opens, and it is
  **not for a sweep to allocate a requirement id.**
- 🔴 **No Mexal test environment is known to exist** for exercising
  `scoperto clienti` — the standing finding of the 14/09 DM still holds.
- ⚠ The financial figures come back **per customer code, not per contract**
  (`00:58:46`), so how one customer's several contracts are told apart is
  unanswered.

## 🔑 2026-09-25 - narrowed, re-placed, and challenged by its own builder

At [the 17:00 internal session](../meetings/2026-09-25%20Interna%20post%20UAT%20Contratto%20e%20Fase%20Due.md)
(`00:10:00`-`00:25:00`) Elena Spini read her Business Blueprint section aloud and
Aurel Mrruku worked through it field by field. Four changes to what this note says:

1. 🔑 **`Performance Plus` only.** Elena Spini, twice and unprompted: _"Oggetto
   contratto su salesforce è solo performance plus."_ The **`attivazione/rinnovo`**
   breadth recorded above narrows to the Plus family, and she named the confusion
   that caused it — the client calls an ordinary quote-plus-contract sale a
   "contract" too.
2. 🔑 **Created at `Firmato`, not at Mexal transmission.** This **supersedes** the
   17/09 placement recorded above. Aurel Mrruku: _"quando il preventivo è stato
   firmato, perché abbiamo aggiunto anche il nuovo stato firmato, si crea questo
   oggetto che si chiama contratto"_ — Elena Spini: _"corretto"_. The trigger is
   therefore [OI-151](OI-151%20Quote%20signature%20step%20before%20the%20order%20is%20generated.md),
   which is itself **still not in `force-app`** (verified at `a5f9370`).
3. 🟢 **`stato` is `nuovo` / `rinnovo`.** The BBP's third value **`in corso` was
   deleted in the call** — Elena Spini could not source it: _"Non so dove è uscito
   sto in corso, sinceramente"_. 🟢 **And the population question above is answered:**
   Aurel Mrruku takes it from the **opportunity record type**, since `Plus` and
   `Rinnovo Plus` now both exist. The order carries the opportunity, so the Contract
   reads it through the order.
4. 🟢 **`valore totale` is the order value**, agreed in one line. The financial
   fields keep their Mexal origin — `importo fatturato`, `importo incassato` and
   `importo insoluto` from the two nightly calls, one for invoicing and one for
   **`scoperto clienti`**.

### 🔴 The builder's objection is on the record

Aurel Mrruku does not think the object earns its place (`00:20:00`): the Mexal
returns **update the tranches**, and the tranches already hold the information, so
_"contratto non vedo nessun legame… che senso ha."_ Elena Spini conceded the
consequence — _"dovremmo riportare anche le righe dell'ordine su sto cavolo di
contratto"_ — and defended it only as a client wish: _"Lui ci teneva così tanto."_
Aurel Mrruku's counter-proposal: the one field that genuinely needs a home is the
**service start/end date, and it can sit on the order**.

🔑 **Agreed action, and it is the right one:** put it to **Fabrizio Paganelli and ask
for the Zoho structure** — _"qual è la struttura attuale di questo oggetto che avete
voi su Zo[ho]? e cerchiamo di replicare quella struttura"_ — rather than invent a
data model. **Booked for Monday 28/09 10:00**: the invitations
`[PIENISSIMO] - Aurel / Elena Aggiungere Fabrizio` (15:23Z) and
`[ROMI-PIENISSIMO] - Tema Contratti + Open Point` (16:50Z) both cover that slot.

### Still open after this session

- 🔴 **`data di servizio` stays manual.** Aurel Mrruku: _"Fa cagare."_ Elena Spini:
  _"Lo so, però vogliono."_ The role remains unnamed — she called it _"un tizio che
  si chiama Strategy"_, the BBP's **Strategist**. ⚠ Still no person, still no team.
- 🔴 **No field spec exists in writing.** The list lives in the BBP and in this
  transcript; nothing in `requirements/` covers it, and **it is not for a sweep to
  allocate a requirement id.**
- ⚠ Elena Spini's alternative — a button on the Contract that calls the API on
  demand — was **raised and rejected** by both in favour of a live-populated record.
- ⚠ The **weekly scheduled report** the client asked for was left unassigned to any
  object: _"chi se ne fotte se è oggetto o se è contratto o tranche"_.
- ⚠ The per-customer-code aggregation problem recorded above **was not revisited.**

## 🔑 2026-09-28 - the client was asked whether it should exist, and gave it a different purpose

[The 28/09 session](../meetings/2026-09-28%20Tema%20Contratti%20e%20Open%20Point.md)
(10:02 CEST, 1h03m, Aurel Mrruku · Elena Spini · **Fabrizio Paganelli**) is the
session this note booked. **The builder's objection recorded above was put to the
client directly, and the client answered it.**

🔑 **The object survives, and its justification is the one nobody had stated.** It
is not a per-order appendix — it is the **customer's contractual history across
years and renewals**. Fabrizio Paganelli:

> _"l'importante è che noi da qualche parte abbiamo un contenitore dove per ogni
> cliente io posso vedere quando è stato attivato da data a data, qual era
> l'importo complessivo, si è pagato tutto."_

and _"se magari è un cliente storico, io potrei avere anche 5 6 rinnovi, almeno in
un unico quadro, ho tutte le informazioni della storia contrattuale del cliente,
non solo del contratto collegato a quell'ordine."_

🟢 **Aurel Mrruku accepted it on that reasoning** and restated it himself: _"il
contratto praticamente non è che è collegato all'ordine, è collegato al cliente,
quindi serve un'entità."_ **The objection above is discharged — not overruled.**
His alternative (put the five fields on the order) was offered to the client and
declined for a stated reason.

### What this changes in the record

1. 🔑 **One Contract per order**, with the multi-year view read off the Account's
   several Contracts. Fabrizio Paganelli: _"Ogni ordine avrà il suo contratto e
   ogni ordine avrà i suoi tre quattro valori."_ He had floated 1:N as well
   (_"1 a 1 ordine con contratto oppure … 1 a n"_) and left the shape to ROMI;
   both then worked from 1:1.
2. 🔑 **`data di attivazione` is a separate, manual field and the term runs from
   it** — not from signature and not from the order. Customers defer activation:
   _"attivatemi a marzo quando riaprirò il locale"_, and _"da lì decorreranno i 12
   mesi."_ This sharpens the _dates are manual_ section above: `data inizio` /
   `data fine` are the order's, `data di attivazione` is the one a human fills.
3. 🟢 **The financial fields are confirmed as three, with a stated purpose each:**
   `ordinato` (the order value), `fatturato` and `incassato` (both from the
   nightly Mexal reads). `ordinato − fatturato` is what remains to invoice;
   **`fatturato − incassato` is how punctual the customer is.** Aurel Mrruku
   checked that no cleverer logic was expected and was told no. **Amounts used as
   illustrations in the call are not recorded** — see
   [docs/publishing.md](../../docs/publishing.md).
4. 🔑 **New fields: `strategist` and `digital`, as plain text.** Fabrizio
   Paganelli asked for the two roles that follow a contract — a supervisor
   (`strategist`) and the operator they oversee (`digital`), **about fifteen
   people**. **Deliberately not lookups:** they have no Salesforce licence and
   will not get one — _"Questi non avranno un'utenza sales force perché la
   userebbero solo per andare a metterci quel nome lì dentro … Non ha senso."_
   Aurel Mrruku twice offered a `Strategist` object; Fabrizio Paganelli chose text
   _"poi magari … nella fase tre o quattro o sette."_ Pienissimo's own internal
   platform already holds the assignment and could later feed Salesforce via
   Sabatino Rinaldi — **not committed, no date.**
5. 🟢 **The product-code gap recorded above is closed**, and it is not a new code:
   Performance Plus is identified by the Mexal **`categoria articolo`** — `C10`
   attivazione, `C11` rinnovo. See
   [OI-188](OI-188%20Performance%20Plus%20products%20are%20identified%20by%20the%20Mexal%20article%20category.md).

### What the client will do with it

Three reporting uses, at three levels: **direction** — how many customers are
active today; **commercial** — whose contract expires at the end of a given month
(_"a fine di ottobre avete 10 clienti che scadono, quindi contattateli"_);
**administration** — who to invoice this month. ⚠ These are the scheduled reports
the Business Blueprint specified, recorded in
[OI-168](OI-168%20Contract%20logic%20is%20not%20started%20and%20is%20on%20the%205%20October%20UAT.md).
**Nothing said who builds them or when.**

### Still open after this session

- 🔴 **The Zoho structure was never produced.** The agreed action above was to ask
  for it and replicate it. Fabrizio Paganelli answered from first principles
  instead and the question was not pressed. **There is still no reference
  implementation** — but the requirement is now stated well enough not to need
  one.
- 🔴 **`Firmato` is still absent from `force-app`** at `DevMain` `55101d2`, and
  the Contract creation depends on it. Fourth run flagging this.
- 🔴 **Nothing is built.** No commit in this window touches Contract.
- ⚠ **The field list is explicitly not frozen.** Aurel Mrruku: _"quando faremo i
  test possiamo anche indicare … più campi o meno campi. A me interessava proprio
  il concetto, il legame tra le entità account, ordine, contratto."_ The
  **entity relationship** is what was agreed.
- ⚠ **`strategist` still has no named person**, and the earlier open question —
  who fills the service dates by hand — was not asked. The role now has a
  definition and a headcount, which is more than it had.
- ⚠ **The per-customer-code aggregation problem was not revisited**, third run.

## 2026-10-02 - built and deployed to UAT, three days before the 5 October session

Built to the 28/09 agreement and deployed to Pienissimo UAT (`0AfMA00000CqC9R0AV`,
validation rule re-deployed `0AfMA00000CqCFt0AN`); **not committed, not in Prod**.

- **Creation:** `PerformancePlusContractService`, called from `QuoteTriggerHandler`
  right after the order and its lines are created at **`Firmato`**. An order is
  Performance Plus when a line's `Product2.Categoria_Articolo__c` maps to a
  `Performance Plus - ...` type in `Product_Category_Rule__mdt` (`C10` → **Nuovo**,
  `C11` → **Rinnovo**; a renewal line wins). One Contract per order, `Status` Draft,
  `StartDate` = order date. **Account ← Contract ← Order** uses the standard
  `Order.ContractId`; `Contract.Ordine__c` points back for the amounts. No Mexal sync.
- **Fields on Contract:** `Tipo_Contratto__c`, `Data_Attivazione__c` (manual),
  `Data_Fine_Servizio__c` (activation + 12 months − 1 day), `Ordinato__c`
  (= order total), `Fatturato__c`, `Incassato__c`, `Da_Fatturare__c`,
  `Da_Incassare__c`, `Prima_Scadenza_Non_Pagata__c`, `Insoluto__c` (an `Unpaid` line
  past its due date), `Strategist__c` / `Digital__c` (free text),
  `Avviso_Attivazione__c` (the banner, shown at the top of the layout while the
  activation date is empty).
- **Invoiced / collected are maintained by Apex** from the Mexal payment status on the
  order lines (`OrderItemTriggerHandler.afterUpdate`). 🔑 **Roll-up summaries on
  `Order` were tried first and rejected:** with any `OrderItem` roll-up present,
  `MexalIntegrationTest` failed two payment-sync tests with an _Internal Salesforce
  Error_, because that sync also updates the Order (`Incassato`) in the same
  transaction.
- **Freeze:** validation rule `Contratto_bloccato_dopo_fatturazione` — once invoiced,
  order, customer, type and start date are locked; activation date, strategist and
  digital stay editable (a deferred activation can follow the first invoice).
- **Verified in UAT** by a rolled-back anonymous run: contract created and linked,
  Unpaid line past due → invoiced 1,000 / insoluto true, Paid → collected 1,000 /
  insoluto false, activation 2027-03-01 → end 2028-02-29 and banner cleared, start-date
  change after invoice refused. `MexalIntegrationTest` 50/50 in the dry-run.
- 🟢 **Real `Firmato` path verified in UAT** the same day, at Aurel Mrruku's request:
  his test quote `Preventivo - 43rreffrefe` (four C10 lines) was set to `Firmato`;
  order `00000271` was created with its lines and payment condition, and Contract
  `00000110` (_Nuovo_, Draft) was created and linked both ways, banner showing. The
  records stay in UAT.
- The four reports were **removed** at Aurel Mrruku's request (source and UAT), and
  the standard Contract `Name` was added to the layout with read/edit in
  `Full_Permission`.
  ⚠ The running user has no field access to the standard Contract `Name`, which the
  service fills.
- **Related lists** (requested the same day): _Contratti_ on the Order layout (via
  `Contract.Ordine__c`: number, type, status, activation and end date) and a
  _Contracts_ related-list component on the three Account Lightning pages (Azienda,
  Locale, Three Column). Deployed to UAT `0AfMA00000CqDdO0AV`.
- **Path** (requested the same day): `Stato_Contratto__c` — **Creato → Parzialmente
  Incassato → Incassato** — computed by Apex with the amounts (_Creato_ until something
  is collected, _Incassato_ once collected ≥ ordered), read-only, shown by Path
  `Contract_Stato` on a new **`Contract_Record_Page`** made the desktop default via the
  Contract `View` override (path update button hidden). Deployed `0AfMA00000CqEJK0A3`;
  transitions verified by a rolled-back run (600 of 1,000 paid → Parzialmente
  Incassato, all paid → Incassato); Contract `00000110` set to _Creato_.

## 2026-10-02 - demonstrated against the Blueprint, and one dependency named

Walked through clause by clause at
[the 02/10 Interna Pre-UAT Plus](../meetings/2026-10-02%20Interna%20Pre-UAT%20Plus.md)
on a five-tranche Performance Plus order, with Elena Spini reading the Blueprint
text alongside. 🟢 Everything the Blueprint names was present: data inizio/fine
attivazione, valore totale, importo fatturato, importo incassato, `tipo contratto`
nuovo/rinnovo, a status of creato / parzialmente incassato / incassato, the
activation-date alert banner, the post-invoice freeze, and the contract surfaced on
the Account.

🔴 **Its numbers inherit the payment-state defect.** `fatturato` and `incassato` are
maintained from `OrderItem.Mexal_Payment_Status__c`, which is `Paid` only when the
scadenziario returns `P`. Any Ri.Ba.-settled invoice therefore leaves the contract
under-reporting what has been collected, indefinitely —
[OI-201](OI-201%20Ri.Ba.%20payments%20are%20read%20as%20unpaid%20because%20only%20P%20counts.md).
Aurel Mrruku saw this coming in the session: _"if we get fattura emessa but non
pagata we should have a different fatturato/incassato … but we need confirm by
them."_

⚠ Two things the Blueprint promises on the Contract that are **not** built: the
`Insoluto` concept and its scheduled reports
([OI-206](OI-206%20The%20Insoluto%20concept%20has%20no%20invoice%20due%20date%20and%20no%20invoice%20record.md)) —
the reports were built during the day and then removed on request.
