---
id: OI-367
type: open-item
status: open
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: both
raised: 2026-11-16
updated: 2026-11-16
depends_on: [OI-265]
blocks: []
severity: normal
source: notes/meetings/2026-11-16 Ultimi Check PROD.md
---

# OI-367 - Picklist values and a dependency were created directly in production

**Building the first production bundle on the go-live morning, the client found
three product picklists that could not carry the values he needed: one had no
values at all, one was missing its academic years, and one lacked the bundle types.
All three were filled in by the client inside Production Setup during the call,
with the developer reading out the click path, and the dependency between two of
them had to be rebuilt by hand afterwards. None of it came from source, and the
suspicion that the chosen value format breaks the dependency was raised and never
resolved.**

## What was changed, live in Prod

| Object / field | State found | What was done |
| --- | --- | --- |
| `Product2` → `Anno accademico` | Only `26`, `27`, `28` — the real values existed **only on Campaign**. Aurel Mrruku: _"non li hai mai creati in ambiente di prod? Li abbiamo creati solo in UAT"_ | `2026/27` added, then `2027/28` and `2028/29`; the bare year relabelled |
| `Product2` → `Tipo bundle` | Only the year bundles — _"anno con pienissimo"_, _"anno ripetenti"_ | **Performance Plus** added, and a catch-all **altri pacchetti** |
| `Product2` → `Evento di origine` | 🔴 **No values at all.** Aurel Mrruku: _"non c'e nessun valore su evento di origine"_, and the client could not edit it | Values included from the dependency controller by hand; `ND` excluded |
| Bundle record type | Fabrizio Paganelli had no access — _"Non t'ho attivato il permesso sul record bundle"_ | Permission granted live to the `Amministrazione pienissimo` user |

## The dependency broke

`Evento di origine` is dependent on `Anno accademico`. Changing the controlling
value's API name severed it. Aurel Mrruku:

> _"siccome abbiamo cambiato il nome dell'anno accademico, **c'e una dipendenza tra
> questi campi** … adesso dobbiamo andare sull'evento di origine e rimettere lo
> stesso app name che hai usato su anno accademico."_

It was then rebuilt by selecting values and pressing include / exclude, one
academic year at a time, with `tour`, `food`, `live`, `Academy` and `soldout`
kept and `ND` dropped. ⚠ The repository has a note on exactly this hazard —
[how to add a picklist value that records can actually use](../How%20to%20add%20a%20picklist%20value%20that%20records%20can%20actually%20use.md)
— and it was not consulted on the call.

## The unresolved suspicion

The new value `2026/27` contains a slash. When the product page would not show it,
Aurel Mrruku's first hypothesis was the character:

> _"forse quel slash che non gli va bene. Lo dobbiamo fare, non so, **usare un
> altro carattere**, pero voglio essere sicuro che il tuo PC il problema non e
> dappertutto."_

It turned out to be Fabrizio Paganelli's own browser — _"e il mio PC il problema"_
— and the slash question was dropped without a verdict. Earlier he had already
warned: _"quel slash di solito app name per il database."_ Whether the API name is
usable has not been checked.

## Why this is an item and not just housekeeping

- **These values are not in `force-app`.** They were typed into the live org, so
  the branch and the org now disagree on four pieces of Product2 metadata. This is
  the pattern described in
  [the build ahead of the record](../objects/The%20build%20ahead%20of%20the%20record.md),
  repeating on the day the users started.
- **The picklist workbook that would have prevented it has never arrived**
  ([OI-265](OI-265%20Opportunity%20Categoria%20and%20Sottocategoria%20values%20do%20not%20match%20the%20client%20registry.md)).
  These are precisely the values it was meant to carry.
- **`altri pacchetti` is disputed.** The transcript records both sides of the
  argument and the speaker attribution is unreliable — ⚠ one of the two voices is
  probably Elisa Migliano, not Fabrizio Paganelli. The resolution was
  _"intanto lo facciamo, dopo al massimo lo eliminiamo"_, which leaves a value in
  the production picklist that one of the client's own people argued against.

## Needs doing

1. Retrieve the four Product2 picklists from Prod into source, including the
   dependency matrix, and say whether the `/` in the API name holds.
2. Decide `altri pacchetti` with the client, by name, and remove it if rejected.
3. Check whether UAT now differs from Prod on the same fields.
