---
id: OI-315
type: open-item
status: open
owner: Aurel Mrruku
org: ROMI
raised: 2026-11-03
updated: 2026-11-12
depends_on: []
blocks: [go-live]
source: notes/meetings/2026-11-03 Test e2e PROD.md
---

# OI-315 - Production test records cannot be deleted

**Test orders created in the production org cannot be removed — deletion was
deliberately blocked by permission, and some rows were marked collected to generate
tickets. The accounts behind them cannot be deleted either. The client has asked
twice for the environment to be cleaned before he does the real configuration.**

## What happened

In [the 3 November e2e session](../meetings/2026-11-03%20Test%20e2e%20PROD.md) Aurel
Mrruku set out to clear production before handing it to the client's team — _"i flussi
devono essere puliti, altrimenti succede un casino"_ — and cleared about twenty
records: event invitations, tickets, opportunities and quotes.

🔴 **Orders would not go:**

> _"non hai i permessi perché abbiamo fatto in modo che non puoi cancellare gli
> ordini"_

> _"li abbiamo messi incassati per i biglietti in qualche modo poi devo trovare le
> possibilità di annullarli o non so"_

🔴 **And the accounts are held by the orders**: _"non posso cancellare gli account
adesso perché sono collegati gli ord[ini]"_. Elena Spini's response was to leave them
and create new ones alongside — _"Poi capiamo come fare questa cosa"_.

Later in the call, on the test event and edition: _"gli cancello tutte per forza"_ —
🔑 **so Aurel Mrruku has undertaken to remove them, with no stated route for the
orders.**

## 🔴 The client has asked twice

By mail at **14:04:03Z**, Gmail `1a1a1b96a6f63a3f`:

> _"sto creando in ambiente produzione gli Eventi e le Edizioni. Prima di fare la
> mappatura, mi puoi cancellare i test fatti questa mattina?"_

🔑 **The sequence matters**: Fabrizio Paganelli must rebuild every event, edition and
mapping by hand in production ([OI-320](OI-320%20Event%20and%20Edizione%20mappings%20cannot%20be%20moved%20between%20orgs.md)),
and he will not start until the test rows are gone. Aurel Mrruku's own order of work
was the same — the mapping comes after the product registry is corrected.

⚠ **The same mail asks for a second thing**: _"Mi potete anche abilitare la
possibilità di modificare i campi da visualizzare?"_ — permission to change which
fields are displayed. **Not answered on 3 November.**

## Why it is open

1. 🔴 **Production carries undeletable test orders, some marked collected**, plus the
   accounts behind them, three days before the 9 November technical go-live and nine
   before the data migration.
2. 🔴 **No route is recorded** for removing or cancelling them. Aurel Mrruku said he
   would have to find one.
3. ⚠ **The delete block is deliberate** and presumably wanted at go-live, so the fix
   is a one-off cancellation path, not a permission change — **unstated either way.**
4. ⚠ **It compounds [OI-310](OI-310%20The%20production%20load%20needs%20a%20pre-load%20and%20a%20delta%20run.md)**:
   the pre-load moves the product registry, accounts and contacts into production
   early, into an org that already holds test accounts that cannot be deleted.

## 🔑 2026-11-12 - deletion is happening anyway, for the client's own orders

**The 12/11 client call did not solve this item, but it has made the work
unavoidable: thirteen real orders cancelled in Mexal must be deleted from
production before the delta runs →
[OI-360](OI-360%20Cancelled%20Mexal%20orders%20must%20be%20deleted%20from%20production.md).**

The cost is now stated plainly by the person who built the constraint:

> _"**io non cancello mai ordini.** Fabrizio, abbiamo fatto tutto il sistema in modo
> che gli ordini non si possono cancellare dagli utenti oppure da integrazioni.
> Ovviamente li posso cancellare perche io sono sistema\[dmin\], \[ma\] devo fare **un
> po' di porcherie sul sistema**"_

> _"il sistema non ti permette a cancellare l'ordine se non hai pulito prima tutta la
> struttura dietro. Quindi gli asset … gli eventi, i biglietti … **sono costretto a
> fare una pulizia totale.**"_

🟢 **And he distinguished ROMI's test orders as the easy case**: _"tutti gli ordini
che sono collegati alle offerte che abbiamo fatto noi li posso cancellare, non e un
problema perche tutti sono ordini di test."_ The quotes are the key.

🔴 **Still no plan, date or owner** for actually removing the 03/11 and 04/11
production test orders and freeing the accounts the client is waiting on. The
scripts written for OI-360 would do it; nothing says they will be used for it.

⚠ And the related question is **still unanswered**: whether the client may add more
test records by running quote tests in production →
[OI-355](OI-355%20Nobody%20answered%20whether%20quote%20tests%20can%20be%20run%20in%20production.md).
