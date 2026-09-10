---
id: DEC-2026-09-08-go-live-21-october
type: decision
status: in-progress
owner: Elena Spini
org: ROMI
raised: 2026-09-08
updated: 2026-09-08
depends_on: [OI-124, OI-128]
requirement: CTX-02
source: Gmail thread 1a0815f9a43d3b87, 2026-09-08 14:15Z
---

# Decision - go-live moves to 21 October and Fase 2 is declared out of perimeter

**ROMI told Pienissimo in writing on 8 September that Fase 1 go-live is
21 October 2026 and that everything marked Fase 2 is outside the current
perimeter. `status: in-progress` because the client has not replied.**

## The decision as sent

`[ROMI-PIENISSIMO] - Stato Avanzamento Progetto`, 8 September 14:15Z, Elena Spini
to the client, cc Aurel Mrruku and Andrea Di Cicco.

|                         |                                                              |
| ----------------------- | ------------------------------------------------------------ |
| **Go-live Fase 1**      | **21 October 2026** (was 6 October)                          |
| **UAT ready**           | by **23 September**                                          |
| **UAT and test window** | **23 September – 13 October**                                |
| **Solution approval**   | by **13 October**                                            |
| **Fase 2**              | **out of perimeter**, needs separate valuation and quotation |

The stated cause is _"diversi temi ancora pending e i lavori stanno procedendo a
rilento"_ — the data model still open, and repeated revisions to the analysis
flows. The plan is `Pienissimo_Project Plan 2.pptx`, Drive
`1tIjf-PQNgqIxnzJxsb5cTcDcPdfFuISE`, saved 14:08:27Z, six minutes before the
mail.

## What the plan deck names as Fase 2

Slide 4, `Dettaglio integrazioni`, splits the integrations explicitly:

**Fase 1 — in perimeter**

- WooCommerce (Store) → SFDC
- Mexal (ERP) ⇆ SFDC, for invoicing
- Anticipay (**"ex CreditSafe"**) → SFDC

**Fase 2 — `FUORI PERIMETRO DA QUOTARE`**

- **GLS** → shipment notifications → SFDC
- **Teachable** → video courses → SFDC
- **Ordini Pienissimo Pro** → SFDC → **Zoho Pienissimo Software SRL**

🟢 The deck **confirms in a client-facing artifact** that Anticipay replaced
Credit Safe — named for the first time on 3 September from a transcript aside,
and now written down where the client can see it.

## How this was arrived at

Elena Spini checked it with the delivery team in the ROMI group DM **32 minutes
before sending**, at 15:42 CEST:

> _"ragazzi prima che esca la mail del piano nuovo, rapido check delle cose +
> bloccanti che abbiamo per PIENISSIMO"_

She pasted the four blocking items, asked _"vi tornano? dimentico qualcosa di
super importante?"_, pinged Aurel Mrruku directly, and got **"OK da parte mia"**
at 16:03:59 CEST. She sent it eleven minutes later.

⚠ **Andrea Di Cicco was in that DM and did not answer.** The Mexal integration is
his and it is one of the nine flows scheduled for UAT.

## What this decision does and does not change

🟢 **It supersedes the 7 September internal reading.** The "21 September" and
"13 September" in that session's Gemini summary were **21 and 13 October** with
the month dropped
([OI-124](../items/OI-124%20Go-live%20moved%20from%206%20to%2021%20October.md)).

🔴 **It does not change the register.** `CTX-02`, the `M` priority definition,
both milestone tables, the Fase 2 escalation rule and `go_live:` still say
**6 October** in all three files. `REQUISITI.it.md` is the text the client signs
and it is not moved by a mail awaiting acknowledgement — that acknowledgement is
[OI-128](../items/OI-128%20Client%20confirmation%20of%20the%2021%20October%20plan%20and%20the%20Fase%202%20perimeter.md).

🔴 **It does not close the Fase 2 dispute.** ROMI has now stated the perimeter in
writing for the first time, which is real movement on a question open since July
([the dispute](../risks/Risk%20-%20the%20phase%202%20scope%20dispute%20is%20unresolved.md)).
But the client has disputed exactly the `Ordini Pienissimo Pro` item, escalated it
to Daniela Morgese, and has not yet responded. **A stated perimeter is not an
agreed perimeter.**

⚠ **The Mexal scadenzario correction path was deferred into Fase 2 on 7
September**, in the internal session, and Fabrizio Paganelli — who asked for it —
is a recipient of this mail. The mail does not mention it, and Slide 4 does not
list it among the three Fase 2 integrations. **Whether the client can tell that
his request has moved out of scope is not established.**
