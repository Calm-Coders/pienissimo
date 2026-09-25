---
id: meeting-2026-09-25-interna-post-uat
type: meeting
status: active
owner: Elena Spini
org: ROMI
raised: 2026-09-25
updated: 2026-09-25
source: Drive, Trascrizione, 2026-09-25 17:00 CEST (doc 1PZ94I4dyufvlKhpYdPjBqPBba7L1CacnyvAW6GYgH9E, 53,502 characters, read in full)
---

# 2026-09-25 Interna post UAT Contratto e Fase Due

**Elena Spini walked Aurel Mrruku through the Business Blueprint section by
section, and they sorted it into what ships, what moves to Fase 2, and what
nobody has ever agreed.** 25/09, 17:00 CEST, **1h05m05s**, Aurel Mrruku and
Elena Spini only. Booked at 14:58Z the same afternoon, two hours after
[the UAT session](2026-09-25%20UAT%20Recall%20Tutor%20e%20Bundle.md).

⚠ **No Gemini summary exists** — only the raw transcript, which starts at
`00:05:00`. There is no recording link in the records mail. The transcript is
Italian and legible; the timestamps below are its section headings.

## The Business Blueprint was not sent to the client today

[OI-179](../items/OI-179%20The%20Business%20Blueprint%20goes%20to%20the%20client%20with%20unchecked%20points.md)
recorded the BBP as due to the client on 25/09. **It was not sent.** Elena Spini,
`00:10:00`: _"adesso abbiamo pure il documento di business che non glielo darò mai
oggi perché non se lo merita"_, and Aurel Mrruku agreed on the substantive ground:
_"ma è cambiato il flusso col cavolo che le dai oggi… Hanno cambiato sia uno status
preventivo che una logica su sui bundle."_

🟢 **The delay is the right call and it is for the right reason** — the morning
session changed the quote state machine and the bundle logic, so the document was
wrong before it went out. `Business_Blueprint_Pienissimo.docx` was **modified at
15:59:39Z**, and Elena Spini was editing it live during this call.

She and **Claudio** produced the UAT testbook instead
([OI-187](../items/OI-187%20The%20UAT%20testbook%20is%20with%20the%20client%20for%20comment.md)).

## Contratto - confirmed, narrowed, and challenged

The longest passage (`00:10:00`–`00:25:00`). It **confirms** what
[OI-141](../items/OI-141%20Contract%20object%20for%20Performance%20Plus%20orders.md)
and the BBP already say, and **narrows** two things:

- 🔑 **The Salesforce `Contract` object is for Performance Plus and nothing else.**
  Elena Spini, unprompted and twice: _"Oggetto contratto su salesforce è solo
  performance plus."_ She flagged the ambiguity that causes the confusion — the
  client calls an ordinary quote-plus-contract sale a "contract" too: _"loro a
  volte dicono che anche le vendite normali… per loro quello è un contratto"_.
  Aurel Mrruku pinned it to the object: _"stiamo parlando dell'oggetto contratto"_.
- 🔑 **It is created when the order is generated**, which is now the moment the
  quote reaches **`Firmato`** — Aurel Mrruku: _"quando il preventivo è stato
  firmato, perché abbiamo aggiunto anche il nuovo stato firmato, si crea questo
  oggetto che si chiama contratto"_, Elena Spini: _"corretto"_. This supersedes
  the 17/09 placement at Mexal transmission recorded in OI-141.
- **`data di servizio` is entered by hand** on the order after it is generated.
  Elena Spini named the role as _"un tizio che si chiama Strategy"_ — the
  **Strategist** of the BBP. ⚠ Still no person and no ROMI/Pienissimo team name.
  Aurel Mrruku's verdict on the manual step: _"Fa cagare."_ Elena Spini:
  _"Lo so, però vogliono."_
- **`stato` loses `in corso`.** Elena Spini could not source the value — _"Non so
  dove è uscito sto in corso, sinceramente"_ — and **deleted it**, leaving
  **`nuovo` / `rinnovo`**. 🟢 Aurel Mrruku supplied where they come from: the
  **opportunity record type**, since `Plus` and `Rinnovo Plus` now both exist.
- **`valore totale` is the order value.** Agreed in one line.
- **`importo fatturato`, `importo incassato`, `importo insoluto`** come from the two
  nightly Mexal calls — one for invoicing, one for **`scoperto clienti`** — and they
  **update the tranches**, which is the whole of Aurel Mrruku's objection.

### Aurel Mrruku does not think the object earns its place

`00:20:00`: _"il scoperto aggiornava le tranche, contratto non vedo nessun legame
perché tu l'informazione ce l'hai sulle tranche… che senso ha."_ Elena Spini
conceded the consequence — _"dovremmo riportare anche le righe dell'ordine su sto
cavolo di contratto"_ — and defended it only as something the client wanted:
_"Lui ci teneva così tanto."_ Aurel Mrruku's proposal is to argue it rather than
build it: the one field that genuinely needs somewhere to live is the service
start/end date, and **that can sit on the order**.

🔑 **Agreed action: put it to Fabrizio Paganelli, and ask for the Zoho structure.**
Aurel Mrruku: _"qual è la struttura attuale di questo oggetto che avete voi su
Zo[ho]? e cerchiamo di replicare quella struttura."_ Booked in the call as
**Monday 28/09 10:00** — the invitations
`[PIENISSIMO] - Aurel / Elena Aggiungere Fabrizio` and
`[ROMI-PIENISSIMO] - Tema Contratti + Open Point` both went out at 15:23Z and
16:50Z for that slot.

⚠ **Also raised and dropped:** Elena Spini's own idea of a button on the Contract
that calls the API on demand, rejected by both in favour of a live-populated record;
and a **weekly scheduled report** the client asked for, which Elena Spini noted can
hang off any object — _"chi se ne fotte se è oggetto o se è contratto o tranche"_.

## The tranche state machine, read live out of the org

Elena Spini's blueprint text said the tranche states were **`creato` / `chiuso` /
`acquisito`**. Aurel Mrruku opened the org during the call (`00:35:00`) and read the
picklist:

🔑 **`aperto` · `parzialmente pagato` · `pagato`** — three values, not the three in
the document. He undertook to send her the list. `parzialmente pagato` means **only
some of that tranche's items are paid**.

🔑 **He also confirmed, in the same breath, that the org now has two objects:**
_"abbiamo il tranch e abbiamo anche i bundle tranch"_ — which the repository
corroborates: `Bundle_Tranch__c` merged to `DevMain` the same evening
([OI-181](../items/OI-181%20Stage-sale%20bundles%20need%20their%20tranches%20defined%20at%20bundle%20creation.md)).

Other tranche rulings, all confirmations of the existing record:

- Tranches are generated **at quote level and at bundle-product level**, by the
  administrative user, then **duplicated onto the order**. Aurel Mrruku corrected
  Elena Spini's quote-only wording: _"non è vero, che vi generati anche il livello
  di prodotto bundle"_.
- Per tranche the user picks **which quote lines belong to it** and gives it a
  **due date**; each line stores the tranche reference and that date.
- **A tranche is a set of lines but may be a single line.** Elena Spini had written
  that it never coincides with one order line; Aurel Mrruku: _"Può coincidere…
  perché se tu hai tre prodotti li puoi dividere in tre trance."_ She deleted the
  sentence.
- 🔑 **The order reaches `Incassato` when every tranche is `pagato`, not when the
  last one is.** Aurel Mrruku corrected himself mid-sentence and was explicit:
  _"quando lui quando tutte le trance… perché l'ultima trance non è corretta."_
- Order states restated: **`Ordinato` → `Fatturato`** (first invoice issued in Mexal)
  **→ `Incassato`** (all invoices paid), and the **opportunity goes Closed Won at
  `Incassato`** — _"la chiude il pagamento, non la firma"_ — reconfirmed at the
  24/09 UAT.

## Moved to Fase 2, in this call

- **Note di credito and storni** — _"Fase due. Mettila su fase due."_
- **Correzione di un pagamento** (an incasso booked against the wrong tranche).
  Both feed
  [OI-157](../items/OI-157%20Credit%20notes%20and%20storni%20are%20unbuilt%20and%20undefined.md).
  🔑 Aurel Mrruku also killed the design: the asset-level button is wrong because
  **tranches live at product level and a tranche does not only hold tickets** —
  _"deve essere le trance a livello di prodotto e asset non… Ma non è detto che le
  trance hanno solo i biglietti, Elena."_
- **The check-in app** — _"quella cosa delle app non la facciamo adesso"_.

**Kept in Fase 1:** external archiving of signed quote PDFs stays _"da valutare"_,
with the documents on Salesforce for now.

⚠ **Aurel Mrruku's stated reason for the Fase 2 moves is that the client will
accept them**; nothing records the client being told. The Fase 2 perimeter dispute
is [its own risk](../risks/Risk%20-%20the%20phase%202%20scope%20dispute%20is%20unresolved.md).

## Cambio nominativo, and it is not ready for Wednesday

Specified in full at `00:45:00`–`00:55:00` and recorded as
[OI-185](../items/OI-185%20The%20participant%20name%20change%20regenerates%20the%20ticket%20as%20a%20new%20asset.md).
Aurel Mrruku, plainly: **_"Io non ce l'ho pronta questa roba"_** — and the ticket
UAT is **Wednesday 30/09**. He will try on Sunday and show a partial path:
_"cerco di inventarmi qualcosa almeno per far vedere qualcosa… anche se forse non
funziona al 100%."_

## Roles, profiles and users have never been agreed

`00:30:00`. Recorded as
[OI-186](../items/OI-186%20The%20Salesforce%20user%20list%20and%20profiles%20were%20never%20agreed%20with%20the%20client.md).
Elena Spini: _"cosa mai sentita, mai parlato? Ruoli, permessi, profili."_

## Project health, stated by both

⚠ **ROMI-internal.** Recorded because it changes what the plan can absorb, not as
an attribution of blame.

- **The project is over budget.** Elena Spini: _"stiamo sforando, però cioè non vedo
  alternativa"_, and _"è stato gestito anche da me sotto gamba questo progetto…
  doveva essere così e invece poi si è complicato sempre di più"_.
- Aurel Mrruku put the true size at about **a year of work** and said the scope grew
  from _"tre API da fare"_ to two Mexal integrations, two WooCommerce integrations,
  orders, invoices, customers and the scadenziario — plus **addresses as a separate
  entity on the client side**, still not understood.
- 🔑 **Fase 2 is to be sold together with maintenance.** Aurel Mrruku's shape: about
  **5 days a month of maintenance** plus Fase 2 development, because _"se andiamo
  live assicuro che ci chiamano tutti i giorni"_. Elena Spini reports **Fabrizio
  Paganelli does not want to spend** — _"lui non vuole spendere"_ — and that she
  still has to raise it with **Giampaolo**. ⚠ No note exists for Giampaolo; nothing
  records a proposal being written.
- Aurel Mrruku on capacity: Anita Aga full-time on Pienissimo, Rexhina Hysi lost two
  days this week to another project.

## Unresolved in this call

- ⚠ A **Slack-from-Salesforce** capability Elena Spini had tested and recorded a
  video of on 24/09 **had disappeared** by this call (`00:05:00`). She had cleared
  cache and re-checked; Aurel Mrruku guessed at licence or permission-set loss.
  **Nothing establishes whether this is in scope, whose licence it is, or whether it
  matters to a deliverable** — recorded here only so the next reader is not
  surprised by it.
- No Contratto field list was written down as a spec; it exists only in the BBP and
  in this transcript.
