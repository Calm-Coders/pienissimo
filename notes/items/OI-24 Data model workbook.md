---
id: OI-24
type: open-item
status: open
owner: Sabatino Rinaldi
with: Elisa Migliano
org: both
raised: 2026-07-02
updated: 2026-08-14
blocks: [go-live]
severity: gating
source: meetings/open-items.md row 24
requirement: DAT-07
---

# OI-24 - Data model workbook

An Excel sheet per Salesforce object: ROMI supplies the structure, Pienissimo
extracts the field lists from Zoho and prunes what is unused — including the
nome-locale versus ragione-sociale distinction that produced
`Account.Nome_Locale__c`.

The file is `Campi Oggetti, Flussi e Utenti Salesforce - Pienissimo.xlsx` in
the `[Pienissimo] Fase Progettuale` Drive folder. Pienissimo owes the Zoho
field lists for **Account, Referente, Opportunity, Offerta, Ordine, Articoli**.

Committed by Sabatino Rinaldi on 22 July "within next week". Still open.
Mapping method and volumes settled on 2026-08-06 —
[OI-79](OI-79%20Migration%20volumes%20and%20mapping%20method.md).

Two build decisions must fold into it:
[the product flags](OI-47%20Product%20flags%20at%20import.md) `genera biglietto`
and `solo bundle`, and
[the bundle classification fields](OI-46%20Bundle%20classification%20picklists.md)
anno solare, evento and tipologia.

This gates the **~1 September import**, which gates every realistic test of the
[ticket lifecycle](../flows/The%20ticket%20lifecycle.md) before the September
events.
