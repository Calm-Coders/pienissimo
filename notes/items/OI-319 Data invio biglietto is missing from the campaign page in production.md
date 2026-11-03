---
id: OI-319
type: open-item
status: open
owner: Aurel Mrruku
org: ROMI
raised: 2026-11-03
updated: 2026-11-03
depends_on: []
blocks: [go-live]
source: notes/meetings/2026-11-03 Test e2e PROD.md
---

# OI-319 - Data invio biglietto is missing from the campaign page in production

**The field that drives the ticket send is not on the campaign record page in
production, and Aurel Mrruku found he has no field-level permission on it himself. It
needs a release, not a setting. He worked around it during the call to finish the
test.**

## What happened

Creating the test edition in
[the 3 November e2e session](../meetings/2026-11-03%20Test%20e2e%20PROD.md), Aurel
Mrruku needed the field and could not find it:

> _"Una campagna figlia deve avere da data competenza, data competenza, data evento,
> data invio biglietto. Dove c'è data invio biglietto che non la vedo?"_

> _"nel record page della campagna manca il data invio"_

Then the cause:

> _"Non ho i permessi sul campo. **Devo fare per forza un rilascio.**"_

🔴 **He lacks field-level access in production on a field he owns.** He placed it on
the right-hand side to proceed and finish the test — Fabrizio Paganelli populated it
with `10/11/2026` on the test edition.

## Why it matters

1. 🔴 **It is a release, not a configuration change**, so it cannot be fixed in the
   org during a working session. It joins the list of things Aurel Mrruku still owes
   production: _"Mi mancano la community, le note, alcuni layout."_
2. 🔑 **The field drives the ticket send interval** that marketing reads — Aurel
   Mrruku on the fields below it: _"sono per marketing … intervalli che deve usare lui
   per inviare le comunicazioni"_.
3. ⚠ **It bears on [OI-313](OI-313%20The%20ticket%20nomination%20email%20fired%20for%20assets%20still%20in%20ordinato.md)**:
   a nomination mail fired in production the same day off the event-link state.
   Whether `data invio biglietto` being absent from the page contributed is
   **unestablished** — the field existed, it was not displayed.
4. ⚠ **It is one of several production permission gaps found in one session** —
   Fabrizio Paganelli also had no access to child campaigns despite holding "all
   permissions", which Aurel Mrruku granted mid-call.
