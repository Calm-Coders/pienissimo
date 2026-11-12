---
id: meeting-2026-11-12-check-pre-import
type: meeting
status: resolved
owner: Elena Spini
with: Aurel Mrruku, Fabrizio Paganelli, Elisa Migliano, Sabatino Rinaldi
org: both
raised: 2026-11-12
updated: 2026-11-12
depends_on: []
blocks: []
source: Drive 1ADtiuhZtdm4so1DDnBorhrosazV2dybPZNMTjvjGrSY
---

# 2026-11-12 - Check Pre-Import

**Two hours and six minutes with the client, the day before the production
migration. The longest client session since the 03/11 end-to-end test. It settled
the import sequence, proved the WooCommerce-to-Mexal chain in production with
Anticipay working, counted the production licences, and surfaced four things
nobody had a plan for: orders that must be deleted from production, contracts that
stop half way, the Pienissimo Live attendance that cannot reach Salesforce, and
the fact that the client's commercial lead is resigning.**

## Attendees

- **Aurel Mrruku** (ROMI)
- **Elena Spini** (ROMI)
- **Fabrizio Paganelli** (Pienissimo)
- **Elisa Migliano** (Pienissimo, amministrazione)
- **Sabatino Rinaldi** (Pienissimo) — present, left before the end
- 🔴 **Marco Montesi absent**, on the day his own change requests were being
  scheduled and his departure discussed.

## Sources

| | |
| --- | --- |
| Transcript | Drive `1ADtiuhZtdm4so1DDnBorhrosazV2dybPZNMTjvjGrSY`, 85,416 chars (124,282 as fetched), **read in full in four passes** |
| Duration | **02:06:02** |
| Recording | ⚠ none in the folder — the folder holds the transcript shortcut only |

## The import sequence as agreed

| When | What |
| --- | --- |
| **12/11, am** | Client sends Account (sent 09:44Z), Referenti (10:30Z), Locali (13:57Z); historical orders in the afternoon (sent 15:32Z) |
| **12-13/11** | Client **stops working in Zoho**. Anything keyed into Zoho on 12-13/11 must be re-entered by hand in Salesforce on Monday |
| **13/11 evening** | Fabrizio Paganelli fixes the Mexal article registry so the old asterisked codes are gone |
| **13/11 → weekend** | Aurel Mrruku loads; _"spero domani sera, altrimenti lavoro anche nel weekend"_ |
| **16/11, 09:00-09:30** | Joint check, password resets for the agents. 🟢 Most agents have already logged into Prod |

🔑 **The article trick**: Aurel Mrruku activates every Mexal product in Salesforce
for the load, then re-pulls the client's Mexal `categoria merceologica` flags on
Monday morning so they fall inactive again — _"in automatico verranno come inattivi
in sales force."_

🔴 **The delta is no longer insert-only.** Fabrizio Paganelli insisted: _"Non vale
non andare solo in update dei record mancanti, va anche in aggiornamento dei record
di quelli gia presenti."_ Aurel Mrruku agreed: _"Ok, vado in modifica."_
→ [OI-360](../items/OI-360%20Cancelled%20Mexal%20orders%20must%20be%20deleted%20from%20production.md)

## What the session proved in production

🟢🔑 **The whole WooCommerce chain ran in the production org, on the call.**
Sabatino Rinaldi placed a test order from the live shop with a real Italian VAT
number and an address in Rimini; Salesforce created the Account, **Anticipay
checked it at 11:40**, the ATECO code came back, the Pienissimo commercial agent
code was applied and the order reached Mexal. Aurel Mrruku read it out: _"Se vedete
ha gia fatto tutto il controllo con anticipate."_

🟢 **This closes [OI-312](../items/OI-312%20Anticipay%20times%20out%20in%20production.md)** —
Elena Spini wrote to Andrea Parmeggiani and Fabrizio Paganelli at 11:45:25Z:
_"confermo che oggi abbiamo fatto il test in produzione per Anticipay ed e andato
tutto ok."_

⚠ The Mexal order numerator in production **starts at 62**, not 1; Fabrizio
Paganelli noticed and the cause was left on his side — _"Quello e una cosa
vostra."_

## The four things with no plan

1. 🔴 **Orders cancelled in Mexal must be deleted from production**, and they are
   real orders, not test data — 13 of them, listed in the 15:32Z mail. The system
   was deliberately built so orders cannot be deleted: _"abbiamo fatto tutto il
   sistema in modo che gli ordini non si possono cancellare."_ Aurel Mrruku must
   tear down every related record first — assets, event links, tickets — by script,
   in production → [OI-360](../items/OI-360%20Cancelled%20Mexal%20orders%20must%20be%20deleted%20from%20production.md).
2. 🆕🔴 **A contract that stops half way cannot be unwound.** Fabrizio Paganelli's
   case: twelve monthly tranches, the client stops after six. Aurel Mrruku:
   _"**Per il momento non l'abbiamo previsto.** … forse dobbiamo creare uno stato
   dell'ordine … in automatico devi cambiare lo stato delle tranche, cambiare stati
   degli asset e cambiare i stati dei link evento."_ Elisa Migliano added the credit
   note case, where tickets must be **annullato**, not merely unavailable. Parked as
   Fase 2 — _"Lo aggiungeremo alla lista della spesa"_ →
   [OI-359](../items/OI-359%20An%20interrupted%20contract%20cannot%20unwind%20its%20tranches%20assets%20and%20tickets.md).
3. 🔴 **Pienissimo Live attendance cannot reach Salesforce.** Its tickets and QR
   codes are all Zoho's, the supplier has done nothing — Sabatino Rinaldi relayed
   Andrea Parmeggiani live: _"mi ha detto che non ha ancora fatto niente"_ — and
   Salesforce has no participant registry for it. A manual ID-matching back-fill
   was designed on the call and **Campaign Member was abandoned** for that edition:
   _"Il campaign member lo lasciamo."_ Aurel Mrruku: _"io ho il dubbio che
   succederanno dei casini. Se prendete voi la responsabilita"_ →
   [OI-361](../items/OI-361%20Pienissimo%20Live%20attendance%20cannot%20be%20recorded%20in%20Salesforce.md).
4. 🔴🔑 **Marco Montesi is resigning.** Fabrizio Paganelli, unprompted: _"Marco e
   di\[missio\]nario. **Marco Montesi.**"_ — _"se lui adesso va via, che cosa
   succede?"_ And of Sabatino Rinaldi, in the same passage: _"Sabatino va via."_
   → [OI-357](../items/OI-357%20The%20client%20commercial%20lead%20and%20the%20web%20counterpart%20are%20both%20leaving.md)

## Production users and licences

🔑 Counted live in the org by Aurel Mrruku: **12 licences, 10 used, 9 in real use,
3 free** (one of them ROMI's own, which he offered to recycle).

| In Prod today | Still needed for 16/11 |
| --- | --- |
| the generic commercial user, Sara, Barbara, Martina, Davide, Carmen, Valentina (7 agents), plus `amministrazione` and two system admins | 🔴 **a marketing user and profile** (Rebecca Marmo, `marketing@pienissimo.com`) and 🔴 **a Performance Plus user and profile** |

🔴 **Neither profile exists.** Aurel Mrruku: _"Non ce l'ho ancora un profilo, pero
lo posso fare tra settimana prossima"_ — four days after the users go live →
[OI-363](../items/OI-363%20The%20marketing%20and%20Performance%20Plus%20profiles%20do%20not%20exist.md).
🟢 Marco Montesi deliberately has **no** named production user; he will use the
generic one, which Elena Spini noted makes his departure cheaper.

🔑 **Agent-code reuse does not propagate.** Checked live: replacing a person
updates the user, but existing Accounts keep the old agent code, because _"la
modifica la stiamo facendo sull'utenza e non la vede come modifica"_. Only a mass
data-loader update fixes it →
[OI-362](../items/OI-362%20Reassigning%20an%20agent%20code%20does%20not%20update%20existing%20accounts.md).

## Also settled

- 🟢 **The ticket chain was re-explained to the client and written down by him**:
  order → invoice → collected → asset `Disponibile` → the nomination link goes out
  **only if `Data invio biglietto` is in the past and `Data fine evento` in the
  future**; then the titolare names the participants in the Community and each one
  receives their own ticket and QR code.
- 🔑 **`Data fine evento`, `Data inizio evento`, `Data invio biglietto` and `Data
  evento` existed in production but were not on the layout.** Aurel Mrruku added
  them **directly in production during the call** — _"li metto direttamente in
  produzione, poi li aggiustiamo"_ — so the client could backdate the old editions.
  ⚠ Another undocumented direct production edit.
- 🟢 Fabrizio Paganelli and Elisa Migliano then set the past editions' end dates,
  including **Pienissimo Live 2026 and Pienissimo Intensive**, and confirmed it by
  mail at 16:35:54Z: _"abbiamo sistemato l'anagrafica degli eventi/edizioni."_
- 🟢 **Articles are no longer sent by the client** — taken from Mexal directly.
- 🆕 **Marketing walkthrough booked: Thursday 19 November, 09:30**, with Matteo
  Distaso and Rebecca Marmo. Invitation sent 12:11:20Z.
- 🔑 **49,800 referenti without a Mexal code**; the Referenti file carries **67,154
  rows** in total. ⚠ The workbook itself was not opened — it holds real customer
  records.
