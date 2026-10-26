---
id: OI-279
type: open-item
status: open
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: both
raised: 2026-10-21
updated: 2026-10-22
depends_on: []
blocks: []
severity: normal
source: notes/meetings/2026-10-21 Check Dati Migrazione e OP.md
---

# OI-279 - The tutor account creation screen must be simplified

**Fabrizio Paganelli created a test company on screen while thinking aloud as a
tutor, and produced a list of layout changes: fields to hide, fields to move,
two renames and one deletion. Elena Spini wrote them down as nine numbered
points and relayed them to Aurel Mrruku the same afternoon. None is built.**

Agreed across `01:27:26`–`02:02:22` of
[the 21/10 morning session](../meetings/2026-10-21%20Check%20Dati%20Migrazione%20e%20OP.md)
while he created the account `test 2210`. His framing: _"mi sto mettendo nei
panni di un tutor … in modo tale che mi sia più semplice per me possibile quando
creo un nuovo account."_

## The list, as Elena Spini recorded it

Relayed verbatim in her DM to Aurel Mrruku at 12:49:07 CEST:

| #   | Change                                                                                                                                                                                      |
| --- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1   | Filter the product picker to `BO` or `NO` only — everything bundle-only hidden. _(tracked separately as [OI-261](OI-261%20Test%20article%20codes%20pollute%20the%20product%20registry.md))_ |
| 2   | Opportunity record type: `Plus Rinnovo/attivazione` == `Performance Plus`                                                                                                                   |
| 3a  | Move the `Zona` field down, into the Mexal / commission-data section                                                                                                                        |
| 3b  | Remove the standard fields `Tipo` and `Settore`                                                                                                                                             |
| 4   | Delete the `IBAN` field                                                                                                                                                                     |
| 5   | Move `P.IVA` and `PEC` up, above the addresses                                                                                                                                              |
| 6   | Remove the Mexal data block from the account **creation** screen                                                                                                                            |
| 7   | Move `Anticipay consolidato` down into the Mexal section                                                                                                                                    |
| 8   | Rename `Codice Agente Esterno` → `Codice Agente`, and `Codice Cliente Mexal` → `Codice Cliente`                                                                                             |
| 9   | Add the `Mandato RID` field — _(tracked separately as [OI-277](OI-277%20A%20read-only%20Mandato%20RID%20field%20is%20required%20on%20the%20account.md))_                                    |

🔑 **Items 3b and 7 apply to two screens, not one.** Aurel Mrruku flagged the
distinction and Fabrizio Paganelli asked for both: _"prima è la schermata di
inserimento, questo è la schermata di dettaglio" … "gli togliamo anche da qua."_

## The reasoning worth keeping

- **`Zona` stays, empty and locked.** It is not used today but Fabrizio
  Paganelli wants it held for future commission rules: _"adesso la zona noi non
  la gestiamo … però è un campo che può diventare fondamentale … io preferisco
  avere il campo, lo mettiamo lì, blindato, vuoto, non gestito."_ ⚠ **This
  reverses an earlier call made with Mirko Merendi**, which Aurel Mrruku raised:
  _"quando abbiamo fatto la call con Mirko, abbiamo detto che la zona non deve
  essere su l'agente, ma si deve compilare a mano … a livello di anagrafica
  cliente."_ The reversal was not minuted as such.
- **`IBAN` is deleted, not hidden.** Fabrizio Paganelli: _"Cancelliamolo, sennò
  dopo i tutor mi fa un casino … Dopo gli IBAN ce li gestiamo noi da
  quest'altra parte."_ Aurel Mrruku confirmed nothing depends on it: _"Non
  abbiamo nessuna logica sull['I]ban."_
- **`P.IVA` and `PEC` are the two fields that matter before the address**, and
  PEC stays visible even though Anticipay usually supplies it, because
  _"se tu non sei italiano, Anti[ci]pay non la trova."_
- The commission fields autofill from the chosen agent and are locked; a tutor
  who is themselves an agent gets them filled with their own data without
  choosing.
- Everything below is removable because it is derived: _"il tutor residenza
  fiscale non sa neanche che cosa sia" … "poi viene calcolato in automatico quando
  fai il calcolo sull'indirizzo."_

## Still open

- 🔴 Nothing is built. Aurel Mrruku is holding all screen changes for a single
  cumulative push to avoid conflicts: _"stiamo facendo dei cambiamenti su tutte
  le schermate e andrà tutto un stesso push, altrimenti ho dei conflitti."_
- 🟢 **Two further screen items were raised that are not in Elena Spini's nine:
  the truncated product description, and the `livelli 0–6` from the tracciato.
  Both were done in UAT on 2026-10-22.** **Description is fixed, not removed**
  (Aurel Mrruku's call, against Fabrizio Paganelli's "remove it" on 19/10).
  - **Cause:** Mexal splits a long name, with the first 30 characters in
    `descrizione` and the tail in `descrizione_agg`. The sync wrote that tail
    alone into `Description`, e.g. `IVE`.
  - **Fix:** `Description` now holds the full name (`descr_completa`), plus
    Mexal's extended description `descr_estesa` on a new line when there is
    one. No article has one today.
  - **UAT data:** 713 product descriptions were rewritten from Mexal.

  On the product page (`Product_Record_Page`, Item record type), a new section, _"Classificazione statistica prodotti"_,
  sits before system information and holds `Categoria_Articolo__c`, `Livello_0…6__c`
  and a new read-only `Gruppo_Merceologico__c`. The article sync now stores
  Mexal's `cod_grp_merc` in that field, and it was filled on 1,080 UAT products.
  ⚠ **Not in Prod.** 🟢 The 13/10 _"categoria merceologica"_ is
  `Categoria_Articolo__c`, the Mexal categoria statistica (`sigla_cat_sta` +
  `nr_cat_sta`). Confirmed by Aurel Mrruku on 2026-10-22.

- ⚠ The `Zona` reversal should be reconciled against whatever the Mirko Merendi
  call recorded. No record of that call names the field.
