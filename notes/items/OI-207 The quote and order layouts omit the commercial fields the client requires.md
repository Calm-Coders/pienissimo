---
id: OI-207
type: open-item
status: open
owner: Aurel Mrruku
with: Pienissimo
org: both
raised: 2026-10-05
updated: 2026-10-21
depends_on: [OI-205]
blocks: [go-live]
source: notes/meetings/2026-10-05 UAT Performance Plus e Gestione date pagamento.md
---

# OI-207 - The quote and order layouts omit the commercial fields the client requires

**Testing a Performance Plus renewal at the 05/10 client UAT, Fabrizio
Paganelli found that the unit list price, the quantity, the unit of measure,
the line discount and the net price are absent from the quote screen and from
the quote itself.** The client requires all of them, per line, on every
interface and every document.

## What was asked

Marco Montesi and Fabrizio Paganelli both put it as commercial transparency:
the customer must see the starting price and the discount applied for each
line, reconciling to the total value of the offer. Elena Spini extended the
list and the surfaces:

> _"le pagine della community e i documenti devono includere prezzo di listino,
> quantità, importo, sconto, totale netto e unità di misura."_

Agreed in the session, as three separate `Concordato` rulings:

- the quote carries **`Totale Listino`, `Totale Netto` and `Sconto Totale`** as
  commercial information visible to the customer;
- **list price, quantity, discount, net amount and due date** appear on every
  screen, quote and order;
- the layouts of screens, orders and quotes are **aligned**, so
  administration, sales and the customer see the same figures.

Plus the **Pienissimo logo, top left** on the quote layout.

## Why it was missing

Aurel Mrruku accepted the finding and explained it without being asked:
the build had concentrated on process logic rather than on pagination —
_"inizialmente ci si era concentrati sulla logica di processo piuttosto che
sull'impaginazione"_. ⚠ He had also **removed the negative-discount
restriction** on 01/10 with no compensating check, so any price can be entered
on a line that does not display its list price.

## State

🟢 The fields exist on the standard objects. The Campi Oggetti workbook's
`Voci offerta` and `Articoli opportunità` sheets both list `Prezzo di listino`,
`Prezzo di vendita`, `Quantità`, `Sconto`, `Totale parziale`, `Prezzo totale`
and `Unità di Misura`; its `Preventivo` sheet carries `Sconto Totale` and
`Totale Listino`. **So this was specified by the client in their own workbook
and the build did not render it** — the same pattern as
`Data invio automatico biglietti`.

🔴 `Unità di Misura` is listed in that workbook with **no API name**, and the
05/10 next steps have Aurel Mrruku adding it to the Plus products and
populating it in the next tests. The article registry
([the registry note](../The%20Articoli%20Salesforce%20article%20registry.md))
already carries a `Unità di Misura` column, so the values have a source.

🔴 **Seven surfaces are in scope**, not one: the quote screen, the order
screen, the quote PDF, the order layout, the community/participation pages, the
quote-acceptance page and the renewal summary table that the same session
decided is the only document a renewal sends.

## Why it matters now

The client begins testing in autonomy **this week**, and
[OI-205](OI-205%20The%20tranche%20carries%20no%20value%20so%20the%20client%20cannot%20see%20what%20each%20one%20is%20worth.md)
already records that the tranche carries no amount. A customer-facing quote
that shows neither a line's list price nor its tranche's value is not a
commercial document, and the Business Blueprint carrying signature lines for
both companies is already with them.

## 🟡 2026-10-06 - part of it landed, on the community-page branch

PR **#82** (`DEV_modifycomunityquotepage`, merged `59d4264` at 20:07 CEST)
carries Rexhina Hysi's three commits, whose own message states the intent:
_"bundle fic price to be fixed, **added firlds to comunity page**, fic pdf to
show always field ybder tale"_ (`95d0be0`).

What is verifiable in source:

| Landed                               | Evidence                                                                                                                                                                                                                                                              |
| ------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 🟢 **Line discount**                 | new `QuoteLineItem.Discount_Pct__c`, label **`Sconto %`**, percent(5,2) — _"Percentuale di sconto inserita durante la creazione delle tranche Performance Plus. Il prezzo finale rimane memorizzato in UnitPrice per evitare una seconda applicazione dello sconto."_ |
| 🟢 **The quote PDF**                 | `QuotePdf.page` +39 then reworked in `30fb71c`, and `QuotePdfController` +19 — the _"show always field under table"_ fix                                                                                                                                              |
| 🟢 **The quote screen**              | `quoteManageProducts` html/js/css reworked (+98 js), `QuoteManageProductsController` +53, `QuoteLineItemsController` +7                                                                                                                                               |
| 🟢 **The acceptance community page** | `quoteAcceptancePage` html/css reworked (+117 css), `QuoteAcceptanceController` +169                                                                                                                                                                                  |
| 🟢 **A quote-line record page**      | new `Quote_Line_Item_Record_Page.flexipage` (377 lines), `f84d356`                                                                                                                                                                                                    |
| 🟢 **Agente**                        | `Agente__c` added to `Account`, `Lead` and `Quote`; `Quote_Compact_Layout` created                                                                                                                                                                                    |

## 🔴 Why this row stays open

**This sweep did not verify the five named fields against the seven surfaces.**
What it establishes is that the commercial-fields work started and that the
**discount** has a field. The row named **unit list price, quantity, unit of
measure, line discount and net price**, on every layout, community page and
document, plus the logo:

- **Line discount** — 🟢 has a field now.
- **Unit list price, quantity, unit of measure, net price** — ⚠ **not confirmed.**
  Standard `QuoteLineItem` already carries `UnitPrice`, `Quantity` and
  `TotalPrice`; whether they are now _on the layouts, the community page and the
  PDF_ is a layout and page question this sweep did not open the org to answer.
- **Unit of measure** — ⚠ no field named in the diff, on `QuoteLineItem` or
  `Product2`. The likeliest genuine gap.
- **The logo** — ⚠ nothing in the diff addresses it.

⚠ **Not deployed to Prod** by anything this sweep can see, and
`Quote_Record_Page.flexipage` _lost_ 10 lines in `95d0be0` while
`Product_Record_Page` lost 10 in `f84d356` — removals this sweep did not read.

🔴 **A test class was edited, not written:** `QuoteCommercialTest.cls` **-6
lines** in `f84d356`, and `Product2.Is_Plus__c` was deleted (-10). Recorded
because coverage is the standing brief; **no test was written, proposed or
scaffolded by this run.**

**To close:** confirm the five fields on each of the seven surfaces in the org,
and settle unit of measure and the logo.

## 🟡 2026-10-08 - reviewed internally, not verified with the client

At [the 08/10 internal session](../meetings/2026-10-08%20Internal%20Test.md)
Elena Spini and Aurel Mrruku went through the quote and community fields and
**confirmed the presence of unit of measure, quantity, list price, amount, total
discount, due date and payment method**. That is the list this item was opened
for, and it includes the **unit of measure** the 06/10 entry recorded as
untouched.

⚠ **Three reasons this does not close the item.**

- It is a **ROMI-internal review**, four people, no client in the room. What
  OI-207 asks for is Fabrizio Paganelli seeing the fields on the surfaces he
  found them missing from — scheduled for the **12/10 e2e session**.
- **The logo was not mentioned.** It was an explicit part of the 05/10 ruling.
- **The seven surfaces were not enumerated.** The session reviewed the quote
  screen and the community page; orders, the PDF and the acceptance page were
  not walked through field by field.

🟢 Of record from the same session, adjacent to this item: the quote e-mail
template is split into a dynamic opening with the quote codes and a static tail
carrying the interaction buttons; and **mobile optimisation of the acceptance
page matters because 80% of recipients open the mail on a phone** — raised with
no owner and no date.

🔴 The stale-PDF problem the same session ruled on is
[OI-221](OI-221%20The%20quote%20PDF%20does%20not%20regenerate%20when%20the%20quote%20changes.md),
and it is not built.

## 2026-10-14 - quote commercial totals implemented locally

The Quote now has stored currency fields for **Totale Listino** and **Sconto
Totale**. The existing quote-line trigger recalculates them in bulk whenever a
line is inserted, updated, deleted or restored:

- `Totale Listino` is the sum of list price multiplied by quantity;
- `Sconto Totale` is `Totale Listino` minus the sum of the net line totals;
- the standard Quote `TotalPrice` remains **Totale Netto**.

The two stored fields are read-only on the Quote layout and are rendered with
`TotalPrice` on both the quote-acceptance community page and both variants of
the quote PDF. The community guest profile and the full permission set have
read access. A check-only deployment compiled all 11 components successfully
(`0AfMA00000CvNYr0AN`, no tests run), followed by a successful deployment to
the **partial sandbox** (`0AfMA00000CvO3V0AV`, `NoTestRun`). **Not deployed to
Prod, committed or pushed.** Existing Quote rows still require a line change
or an explicit backfill before the new stored fields are populated.

The acceptance page summary was then changed from one combined panel to
**three separate responsive cards**. Totale Listino and Sconto Totale use
light cards; Totale Netto is emphasized with the dark brand treatment. They
appear in one row on desktop and stack on mobile. The LWC-only deployment to
the partial sandbox succeeded (`0AfMA00000CvPvd0AF`).

This does not close OI-207: the order surfaces, participation community pages,
renewal summary, complete seven-surface review and client verification remain
open.
## 🟢 2026-10-14 — the client asked for the three totals and they were built the same evening

**At [the 14/10 e2e](../meetings/2026-10-14%20UAT%20Test%20e2e.md) (`00:44:51`)
Elisa Migliano asked, while generating the contractual PDF, for three distinct
summary rows: totale di listino, totale degli sconti, totale netto.**

Aurel Mrruku's commitment, in the room (`00:46:06`): the change would be
implemented **within a day**, on **all quote types** — rinnovo, standard and
bundle — and would show **both on the PDF and on the portal**. At `00:55:52` it
was further agreed the three totals must sit consistently in the **desktop and
mobile** views; the mobile rendering converts the column table into vertical
blocks (`00:52:17`).

🟢 **It was built the same evening.** `8186816` (Rexhina Hysi, **2026-10-14
18:14:33 +0200**, branch `DevMainOpportunityWork`), _"2 new fields in quote and
added to comunity and pdf"_:

| Added | Where |
| --- | --- |
| `Quote.Totale_Listino__c` | new field |
| `Quote.Sconto_Totale__c` | new field |
| both | `QuotePdf.page`, `QuotePdfController`, the `quoteAcceptancePage` LWC (html + css), `Quote-Quote Layout`, `Full_Permission`, `Landing Page Profile` |
| the roll-up | `QuoteLineItemTriggerHandler` + `QuoteLineItemTrigger` (+79 / +12 lines) |
| acceptance | `QuoteAcceptanceController` |

⚠ **Not in `DevMain`**, which is at `29d1002`; no PR observed. 🔑 **The author
recorded her own account of the change in this note in that commit** — a fuller
description than this section, which will arrive when the branch merges. **Do not
duplicate or overwrite it**; this section exists because the sweep had to record
the client ruling on the night it was given, and the commit is on a branch the
sweep cannot merge.

### What it does and does not close

🟢 **The quote side of the commercial-fields gap is answered for the first time
with both a ruling and a build** — and on the **portal** as well as the PDF,
which no previous round covered.

🔴 **The Mexal invoice side is untouched.**
[OI-145](OI-145%20Order%20header%20discounts%20are%20removed.md) is the same three
values on the document the customer actually receives, and the order tracciato
still has no field for the list price or the discount. ⚠ **The two must not be
read as one fix**: a quote PDF showing listino/sconto/netto and an invoice showing
only the net price is precisely the inconsistency Fabrizio Paganelli has raised
three times.

⚠ **The totals were requested by Elisa Migliano, not Fabrizio Paganelli.** Two
people on the client side have now asked for the same breakdown on two different
documents, independently. That is corroboration, and it is also a sign nobody has
told either of them the invoice cannot carry it yet.

## 🔴 2026-10-15 - the three-totals build is still outside DevMain, a third night

`Quote.Totale_Listino__c` and `Quote.Sconto_Totale__c` **do not exist in
`origin/DevMain`** (verified by `git ls-tree -r origin/DevMain`). They remain
only on `DevMainOpportunityWork`, carried by Rexhina Hysi's `8186816` of 14/10.

Tonight's commits confirm the branch is being kept alive rather than merged:
`102c098` (Rexhina Hysi, 10:18) is a **merge of `DevMain` into
`DevMainOpportunityWork`** — traffic in the wrong direction. **No PR was merged
in the window and `DevMain` did not move at all.**

🔴 So the `Concordato` taken in the room on 14/10 — the quote must show totale
listino, sconto and netto, in the PDF and the portal, for every quote type — is
built and undelivered for a third day, eighteen days before the new go-live and
under a scope freeze that would classify it as already-delivered work.

⚠ **The merge-conflict warning on this note still stands.** `8186816` carries
Rexhina Hysi's own fuller account of the build in this file, and the 14/10 sweep
appended a dated section to the `DevMain` copy. **When that branch merges, keep
her text and delete the overlap from the sweep's section.**

## 🔴 2026-10-16 — the three-totals build is outside `DevMain` a fourth night

`git ls-tree -r origin/DevMain` tonight: **`Totale_Listino__c` and
`Sconto_Totale__c` are absent.** `origin/DevMain` stands at `73a9d59` — this
procedure's own 15/10 commit — **unmoved for 48 hours**, and no PR was merged
today.

The three human commits of 16/10 are all on personal branches and none of them
carries the quote totals:

| Commit | Author | Branch | Subject |
| --- | --- | --- | --- |
| `4eadae8` | Anita Aga | `DevAnita15` | Default Agent for Woocommerce |
| `05cdd3b` | Rexhina Hysi | `Devmain_LeadFix` | Lead_Email__c and chage duplicate rule |
| `ad73d27` | Anita Aga | `DevAnita15` | Account flexipage |

⚠ **`ad73d27` is an Account flexipage change of 127 added lines**, which is
layout work on the same commercial surface this row is about — but on the
**Account**, not the quote or the order, so it is recorded as adjacent rather
than as progress here.

🔑 **The client accepted these refinements into Fase 1 on the record.** Elena
Spini's `#tproj-pienissimo` status (16/10 19:20 CEST):

> _"Accettati in Fase 1 alcuni affinamenti (layout prodotti, decimali, totali
> listino/sconto/netto sul preventivo)."_

🟢 So the three totals are explicitly **inside** the frozen Fase 1 perimeter —
this row is not at risk of being deferred. 🔴 **But the build has sat outside
the integration branch for four nights**, seventeen days from go-live, and
nothing in this sweep opened a PR for it.


## 🟢🔴 2026-10-19 — the totals landed in `DevMain`, and the client said they are still missing

**Two things happened three hours apart and they point opposite ways.**

### 🟢 The build reached the integration branch

**PR `#102` merged into `DevMain` at 12:35 CEST** (`bbe61a2`, from
`DevMainOpportunityWork`), ending four nights of this row's build sitting on a
personal branch. `git ls-tree -r origin/DevMain` now returns both fields:

- `force-app/main/default/objects/Quote/fields/Totale_Listino__c.field-meta.xml`
- `force-app/main/default/objects/Quote/fields/Sconto_Totale__c.field-meta.xml`

and the same PR carries the surfaces they feed: `QuoteLineItemTriggerHandler.cls`
(+79), `QuoteLineItemTrigger.trigger`, `QuotePdfController.cls`, `QuotePdf.page`,
`Quote-Quote Layout.layout-meta.xml` (+8), and the acceptance page's HTML and
CSS. `QuoteLineItem` already carries `Discount_Pct__c`. **`DevMain` moved for the
first time since 15/10**, from `73a9d59` to `926195c`, across four merged PRs.

⚠ The merge also resolved this note's own standing conflict warning: Rexhina
Hysi's text and the sweep's appended section are now in one file on `DevMain`.
**Read the merged body, not the branch history, from here on.**

### 🔴 The client, at 15:01 CEST, reported the same absence

At [the 19/10 walkthrough](../meetings/2026-10-19%20Test%20UAT%20Commerciali.md)
`01:09:05`, Fabrizio Paganelli, watching Marco Montesi add a product:

> _"vedo che non è comparsa la possibilità di mettere degli sconti … manca un po'
> quello che c'era anche di là: unità di misura, quantità, prezzo di prezzo di
> listino, sconto, prezzo netto, in modo tale che mano a mano che il tutor
> inserisce ulteriori righe articolo nel preventivo, [abbia] anche un minimo la
> visione di quello che sta per preventivare il cliente."_

And on the quantity case specifically (`01:10:27`): _"se qui il tutor decide di
mettere tre biglietti, bisogna che abbia la visione del prezzo di listino totale
e anche la possibilità di inserire uno sconto."_

Elena Spini confirmed the agreed shape from the bundle work — _"o metti il prezzo
che vuoi o metti la percentuale, e se metti il prezzo che vuoi ti calcola la
percentuale in automatico"_, **at line level** (both she and Marco Montesi said
_"a livello di riga"_) — and undertook to check it with Aurel Mrruku, who was not
in the call.

### Reading the two together

⚠ **Whether the UAT org carried `#102` at 15:01 CEST is not established** — this
sweep did not open the org. Three readings are live and nobody has separated
them:

1. **The deploy had not reached UAT**, so the client saw the pre-`#102` layout.
2. **It had, and the header totals are built while the _line editor_ is not** —
   the merged work adds `Totale_Listino__c` and `Sconto_Totale__c` to the
   **Quote**, and `Discount_Pct__c` exists on the line, but nothing in the diff
   adds unit of measure or net price to the add-products experience.
3. **It had, and the grid simply did not render** —
   [OI-266](OI-266%20The%20quote%20product%20grid%20does%20not%20refresh%20after%20adding%20a%20line.md)
   records that the lines were invisible until a manual reload, and after the
   reload the `totale complessivo` **did** appear (_"ecco qui così compare"_).

🔑 **Reading 3 is partly confirmed and it matters**: at least some of what the
client called missing was present but unrendered. **It does not cover the
discount control**, which Fabrizio Paganelli checked again after the refresh and
still found absent: _"però vedi anche qui manca. Se io gli voglio fare uno sconto,
non c'ha la possibilità di inserirlo."_

### 🔴 The conflict nobody has noticed

🔑 **The client is asking for something the signable register forbids.**
`requirements/pienissimo-requirements.yaml` carries, with `status: agreed`:

> **`SAL-12`** — _"Tutors on fixed price list, no discretionary discounts"_

What Fabrizio Paganelli asked for on 19/10 is a **discount control on the quote
line, operated by the tutor** — _"sicuramente gli verranno fatti degli sconti"_ —
and Marco Montesi backed him. **That is discretionary discounting by tutors, by
name.** Neither party cited `SAL-12`; Elena Spini treated the ask as a build gap,
not as a change to agreed scope.

⚠ **This is not an agent's call to resolve.** Either `SAL-12` no longer reflects
what the client wants and the Italian signable text must change, or the discount
control belongs to a role the tutors do not hold and the ask should be refused.
**A human must rule it**, and the register is left untouched tonight for that
reason.

### 🔴 And the client is visibly out of patience

Off the main thread, after the goodbyes (`01:32:28`):

> _"a me mi fanno incazzare perché vi dico le cose, no? Però anche quella roba
> degli sconti, quelle robe lì l'avevamo già affrontata, l'avevamo già vista,
> doveva essere a posto."_

**First recorded client frustration at having to re-raise a build item** — and it
is about the row the same client accepted into the frozen Fase 1 perimeter in
writing on 16 October.

## 🟢 2026-10-20 — the discount design was decided, and it reuses what already works

**The line discount Fabrizio Paganelli has asked for three times now has an agreed
design: the same mechanism already shipped for bundles and Performance Plus. It was
settled internally on 20 October and relayed to the dev group the same evening.**

At [the 17:01 internal call](../meetings/2026-10-20%20Follow-up%20Interno.md),
Aurel Mrruku stated the requirement as he now understands it:

> _"quando mettiamo i prodotti su una quot[e] standard vogliono anche lo sconto …
> quindi quando c'è la quantità, c'è il prezzo, vogliono anche lo sconto là."_

Elena Spini gave the design in one line and he accepted it:

> _"Prezzo unitario è praticamente il prezzo dello sconto, come abbiamo fatto per
> la parte bundle e performance plus. **Stessa logica.**"_

🟢 **So the answer is not a new field but an existing pattern**: the unit price on
the line carries the discounted price, as on the bundle and Performance Plus paths.
That is the first time this row has had a design rather than a restatement of the
gap.

🟢 **And he carried it to the dev group**, Slack `C0BQD34LLF4`, 20/10 17:24 CEST,
three messages in twelve seconds:

> _"duan dhe skonton kur vendos produktet"_ · _"te quota"_ · _"e kemi pass po sesht
> me"_

The first two are Albanian for *they want the discount too when you place the
products* / *on the quote*. ⚠ **The third is not reliably translatable from the
record** — it reads as *we had it but it is not there any more*, which would imply
a regression, and nothing else in any source supports that. **Recorded verbatim,
glossed as uncertain, and not treated as a finding.**

## 🔴 What this does not settle

- 🔴 **`SAL-12` is still in direct conflict with it, and still uncited.** The
  register reads _"Tutors on fixed price list, no discretionary discounts"_,
  `status: agreed`. A tutor-operated discount control on the quote line is the
  opposite. **Neither the client nor ROMI has mentioned `SAL-12` in any of the
  three sessions where the discount was asked for**, and the 20/10 call designed
  the build without anyone raising it. The register is unchanged and the conflict
  is still a human's to rule.
- 🔴 **Unit of measure and net price are still not addressed.** The 19/10 report
  was that the quote lines lack `sconto`, `unità di misura`, `listino` and `netto`;
  the 20/10 design covers the discount, and `Totale_Listino__c` / `Sconto_Totale__c`
  landed on 19/10 as header totals. **No source mentions unità di misura at all**,
  and `QuoteLineItem` still carries no net-price field.
  🔑 ⚠ **The migration field list drafted the same morning does carry the shape
  the quote lacks** — its OrderItem sheet lists `ListPrice`, `UnitPrice` and
  `TotalPrice` ([OI-244](OI-244%20Historical%20orders%20will%20be%20migrated%20from%20Mexal%20by%20spreadsheet.md)).
  So the order side models three prices per line while the quote side models one.
  Nobody has connected the two.
- 🔴 **Nothing was built for it on 20/10.** None of Anita Aga's seven commits
  touches the discount; `origin/DevMain` stands at `25629af`, a knowledge-only
  commit. **The design exists; the field does not.**
- ⚠ **The client has not been told.** Fabrizio Paganelli's _"a me mi fanno
  incazzare perché vi dico le cose … l'avevamo già affrontata, doveva essere a
  posto"_ of 19/10 is unanswered, and tomorrow's 10:00 meeting is the first
  opportunity — Elena Spini has flagged it will cover _"diversi open point che ha
  e problemi"_.


## 2026-10-21 — the full column set was stated, editability settled, and the discount shipped

🟢 **The required columns, verbatim from the client**, at `01:11:16` of
[the 10:01 session](../meetings/2026-10-21%20Check%20Dati%20Migrazione%20e%20OP.md):

> _"Codice articolo, unità di misura, quantità, prezzo di listino, totale di
> listino, sconto e totale netto. Quelle lì sono cose che ci devono essere
> sempre."_

**On every surface** — the Salesforce screen, the quote, the generated PDF — and
🔑 **inside bundles too**, which had been ambiguous: _"codice articolo, prezzo di
listino e lo sconto e il netto c'è sempre anche nei bundle."_

🟢🔑 **Editability is now settled, which it was not after the 20/10 internal
call:**

| Context | Editable |
| ------- | -------- |
| Lines inside a bundle | **Nothing.** They appear automatically and are locked — only Fabrizio Paganelli changes them, when he builds the bundle: _"Lo posso cambiare solo io quando creo il bundle."_ |
| Standard sale line | Quantity, discount %, net amount |
| Standard sale list price | 🔴 **Locked.** _"il listino deve essere non modificabile."_ Aurel Mrruku: _"Per forza."_ |

🟢 **The build landed the same day.** `4a5a4a0` (Anita Aga, 16:26:36, _"Added the
sconto on the Gestici Prodotti"_) adds the discount to `quoteManageProducts` and
`quoteLineItemsWithBundles` with **370 lines of LWC jest** across two new test
files, and merged to `DevMain` in **PR #107** (`228be1d`). Aurel Mrruku had
promised it in the call: _"abbiamo già iniziato molto prob[abil]mente entro oggi
lo finiamo."_

⚠ **Still not visibly addressed in that commit:** `unità di misura`, `prezzo di
listino`, `totale di listino` and `totale netto` as displayed columns, and the PDF
template. The commit's name and contents are about the discount. **Not verified
against the org** — this is repository arithmetic only.

🔴 **`SAL-12` is unchanged and uncited for a fourth session.** It reads _"Tutors
on fixed price list, no discretionary discounts"_, `status: agreed`, while the
build now ships a tutor-editable line discount. **Neither party mentioned it in
either of the two 21/10 client calls.** A human must rule whether the register is
amended or the build is wrong; this run did not touch `SAL-12`.
