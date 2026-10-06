---
id: OI-208
type: open-item
status: resolved
owner: Fabrizio Paganelli
with: ROMI
org: both
raised: 2026-10-05
updated: 2026-10-06
depends_on: [OI-201, OI-206]
source: notes/meetings/2026-10-05 UAT Performance Plus e Gestione date pagamento.md
---

# OI-208 - Overdue and upcoming payments are not distinguished on the contract

**At the 05/10 client UAT Fabrizio Paganelli asked that unsettled amounts be
split between `scaduto` — a due date already past — and `a scadere`.** The
contract today reports `ordinato`, `fatturato` and `incassato` and knows
nothing of the difference.

Recorded in the session's `Da approfondire`:

> _"È stata avanzata la proposta di differenziare i pagamenti non saldati tra
> scaduti e a scadere, subordinando la conferma definitiva alla verifica dei
> campi dello scadenziario con Mirko."_

## What exists

🟢 Aurel Mrruku found the mechanism in the room: the Mexal scadenziario carries
**`data scadenza`** per deadline, and he believes the calculation can be
automated on the contract.

🔴 But the due date is read **transiently**. `MexalScadenzarioSearchService`
reads `dt_sca_pg` per deadline only to pair a scadenziario row with an order
line; nothing persists an invoice-level due date on a Salesforce record. That
is the same hole as
[OI-206](OI-206%20The%20Insoluto%20concept%20has%20no%20invoice%20due%20date%20and%20no%20invoice%20record.md),
and this item is the client asking for the reporting that item says the
Blueprint already promised. **OI-206 recorded a promise with no owner; this
gives it a client requester and a date.**

## The blocker in front of it

Confirmation was made **conditional on agreeing the scadenziario fields with
Mirko Merendi**, and the session assigned Fabrizio Paganelli the matching
action:

> _"Mappare stati scadenziario: Identificare tutti i possibili stati e codici
> presenti nello scadenziario di Mexal. Fornire una lista completa per
> configurare correttamente la distinzione tra fatturato e incassato nel
> database."_

🔑 **That is the client-side counterpart of
[OI-201](OI-201%20Ri.Ba.%20payments%20are%20read%20as%20unpaid%20because%20only%20P%20counts.md).**
Mirko Merendi already answered the same question in writing on 02/10 — the
states are empty, `P` and `E`, and `E` counts as paid — and the code still
tests only `'P'`. So the state list is now owed twice, by the vendor who has
given it and by the client who has been asked for it, while the one line that
consumes it is unchanged.

🔴 **And the dependency runs the wrong way for reporting.** While `E` reads as
unpaid, every Ri.Ba.-settled invoice past its due date lands in `scaduto`. A
view that shows paying customers as overdue is worse than no view, and this one
is for Fabrizio Paganelli himself.

## Next

`[ROMI-PIENISSIMO] - Temi Integrazione Mexal`, **Wed 07/10 12:15–13:00**, with
`mirko@kreosoft.com`, `amministrazione@` and `fabrizio.p@`. Elena Spini booked
it in the session; Aurel Mrruku owes test orders prepared in advance.
⚠ It overlaps the WooCommerce and Mexal UAT booked 10:00–13:00 the same day.

## 🟢 2026-10-06 - built in source, in the commit that cites this row

`731c7ac` ("Preparazione UAT invio ordine") adds the new `Scadenza_Fattura__c`
object and with it the exact distinction this row asked for. The field's own
description names the item:

```
Stato_Scadenza__c  —  "Pagata, Scaduta (non pagata e oltre la data) o A scadere (OI-208)."
IF(Pagata__c, "Pagata",
   IF(AND(NOT(ISBLANK(Data_Scadenza__c)), Data_Scadenza__c < TODAY()), "Scaduta", "A scadere"))
```

Alongside it:

- **`Giorni_Ritardo__c`** — days elapsed since the due date, for unpaid rates.
- Three list views: **`Scadenze_scadute`**, **`Scadenze_a_scadere`** and
  `Tutte_le_scadenze`.
- A `Scadenze Fatture` tab, and the related list on
  `Account_Azienda_Two_Column`.

🟢 **The `scaduto` / `a scadere` report Fabrizio Paganelli asked for now has a
field and two list views behind it**, driven off a persisted due date rather
than computed at read time.

🟢 **And it reads the right way round.** This row recorded that while
[OI-201](OI-201%20Ri.Ba.%20payments%20are%20read%20as%20unpaid%20because%20only%20P%20counts.md)
was open the report would have shown every Ri.Ba. payer as overdue — _for the man
who asked for it_. `Pagata__c` is now set from `P` **or** `E`, so the formula is
fed correctly.

## ⚠ What is not done

- **Not in Prod.** The invoice sync classes were deployed to Pienissimo UAT with
  the job **not scheduled**; Prod has no `Integration_Configuration2__c` rows for
  Mexal and no Mexal job. So the fields exist in source and UAT, and no Prod
  record is populated.
- **Unverified against real data.** No Ri.Ba. invoice has been checked end to
  end; `Scadenziario (GET)` is on the **07/10** client agenda.
- The contract-level presentation — where the client actually reads
  `scaduto` vs `a scadere` — is not evidenced by this sweep. The fields and list
  views exist; nothing says they are on the surface the client was shown.

Resolved on the build, not on the demonstration.
