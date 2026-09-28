---
id: OI-141
type: open-item
status: open
owner: Aurel Mrruku
with: Andrea Di Cicco
org: ROMI
raised: 2026-09-17
updated: 2026-09-25
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
  the *activation field* with it (`01:11:11`).
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
