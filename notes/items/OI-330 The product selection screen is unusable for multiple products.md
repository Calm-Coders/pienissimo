---
id: OI-330
type: open-item
status: open
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: both
raised: 2026-11-04
updated: 2026-11-04
depends_on: []
blocks: []
source: notes/meetings/2026-11-04 Continuazione Test e2e PROD.md
---

# OI-330 - The product selection screen is unusable for multiple products

**Putting two products on a quote in production exposed four defects in the
Gestisci Prodotti selection window: it scrolls internally instead of listing, it
has no delete icon on that screen, its columns are too narrow, and it shows the
line discount only as a percentage. Aurel Mrruku accepted all four plus a fifth
ask — a quick action on the parent Account to create a Locale. None is built.**

## What happened

Fabrizio Paganelli added Academy 2 and Mastery with a 10% discount in
[the 04/11 production session](../meetings/2026-11-04%20Continuazione%20Test%20e2e%20PROD.md)
and hit the limit immediately: _"Ah, perché qui compare bisogna scorrere."_ Aurel
Mrruku explained the cause — unsaved selections stay in the panel, so _"se sono n
prodotti e non li hai salvati, sei costretto a scorrere tutti i prodotti che hai
selezionato"_.

Fabrizio Paganelli's case is the tutors, not himself:

> _"queste finestre qui per facilitare il lavoro dei tutor non sarebbe male
> metterle magari più in orizzontale."_
>
> _"in una maniera che il tutor possa vedere in modo più agevole che cosa va ad
> aggiungere … Oltre che se qui lui aggiunge 10 prodotti diventa complicato con
> una finestrina così piccola."_

## The five asks, and Aurel Mrruku's answers

| #   | Ask                                                             | Answer                                                                                                           |
| --- | --------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- |
| 1   | Horizontal layout, or split selected-left / available-right     | 🟢 _"lo possiamo fare … possiamo anche dividere la parte dei prodotti selezionati a sinistra"_                     |
| 2   | A delete icon to remove a product from the selection screen      | 🟢 Exists on one screen only — _"Forse l'ho lasciato solo su … Lo devo mettere anche nell'altra schermata"_        |
| 3   | Wider columns so the inner scroll goes away                      | 🟢 _"cerco di farvi forse due colonne un po' più ampie, quindi non dovete fare quel scroll interno"_              |
| 4   | A line-total discount **in value** beside the net price          | 🟡 Agreed possible, resisted on crowding — see below                                                              |
| 5   | A button on the parent Account to create a Locale                | 🟢 _"forse ti metto un pulsante direttamente sull'account padre di creare il locale"_                             |

Ask 4 is the one with an argument behind it. Fabrizio Paganelli: the row shows a
percentage discount and a **unit** net price, not the line's discount in euro —
_"lo sconto in valore non c'è"_, _"Ci puoi mettere Aurel un campo lì di fianco al
prezzo netto dove ci scrivi sconto totale?"_ Aurel Mrruku: _"si può mettere tutto,
ma stiamo già caricando troppa roba in una schermata. E si può fare, non è un
problema, perché io ce l'ho il valore."_ His counter is that the **quote** already
shows the total discount in value — _"l'hai a destra dove ci sono i file. Vedi,
c'è lo sconto totale là nel valore"_ — and that the selection screen is an
internal input mask the customer never sees, which Fabrizio Paganelli conceded:
_"è una maschera di input da parte di un commerciale. Il cliente chiaramente quella
maschera lì non la vedrà."_

⚠ **Fabrizio Paganelli says he has asked for this from the start** — _"è una cosa
che io avevo detto già dall'inizio. L'avevamo detto sempre questa cosa qui
dall'inizio"_ — and the project record contains no earlier instance of it. The
claim is recorded, not confirmed.

## Where it stands

🔴 **Nothing built.** Aurel Mrruku closed the session with the list as his own:
_"Vi devo fare quegli aggiustamenti sulle tranche. Cerco di farvi una vista
diversa quando aggiungete gli item, quindi i prodotti, così non dovete fare quel
scroll."_ The working tree was clean at this sweep.

⚠ **Ask 2 may already exist somewhere.** Aurel Mrruku was not sure which
environment carries the icon — _"Forse c'è in ambiente DEV, non mi ricordo"_ — so
**the org, the branch and the record disagree and none of the three was checked
here.**

## Related

- [OI-205](OI-205%20The%20tranche%20carries%20no%20value%20so%20the%20client%20cannot%20see%20what%20each%20one%20is%20worth.md)
  — the tranche amount on the order, asked for by the client in the same hour
- [OI-287](OI-287%20The%20Mexal%20line%20discount%20is%20sent%20as%20a%20line%20total%20instead%20of%20per%20unit.md)
  — the same per-unit-versus-line-total distinction, on the Mexal side
- [OI-333](OI-333%20Locali%20without%20a%20Mexal%20customer%20code%20will%20not%20be%20loaded.md)
  — ask 5 is the creation path for the records that note is about

**Closing it:** a tutor adding ten products without an internal scroll, able to
remove one from the same screen, and a Locale created from its parent Account in
one click.
