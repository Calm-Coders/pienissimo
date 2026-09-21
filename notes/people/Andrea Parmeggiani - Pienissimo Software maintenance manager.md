---
id: person-andrea-parmeggiani
type: person
status: active
org: Pienissimo Software
updated: 2026-09-21
source: Drive - Organigrammi Pienissimo (EV - SW) (APRILE 26).pdf
---

# Andrea Parmeggiani - Pienissimo Software maintenance manager

The technical counterpart for the
[Anticipay VAT integration](../items/OI-73%20VAT%20validation%20moves%20into%20Salesforce.md).
He attended [the 25 August technical call](../meetings/2026-08-25%20Integrazione%20Anticipay.md)
and is now the **owner of a Fase 1 deliverable**: the Pienissimo middleware API
that Salesforce will call
([OI-94](../items/OI-94%20Anticipay%20is%20called%20through%20the%20Pienissimo%20middleware.md)),
its error contract, an example payload owed by **4 September**, and the test
environment ROMI has to point at.

He is a considered counterpart, not a passive one — the middleware architecture
was his proposal, on cost grounds, and he was specific about authentication and
error handling without being pushed. He joined the call late, having had no
reminder in his Apple calendar.

⚠ **He works for Pienissimo Software Srl, not Pienissimo Srl.** The April 2026
org chart places him as **Maintenance Manager** in the software company,
alongside CTO Massimo Maioli and Project Manager Nicola Pellicioni. His address
is `andrea.p@pienissimo.pro` — the `.pro` domain, not the `.com` the events
company uses.

That is worth holding in mind: Pienissimo Software Srl is the separate legal
entity at the centre of
[the phase 2 scope dispute](../risks/Risk%20-%20the%20phase%202%20scope%20dispute%20is%20unresolved.md),
which ROMI argues is not this project's client. Yet its maintenance manager is
the named technical contact for a **Fase 1** integration.

🔴 **As of 25 August that is no longer only a contact question.** His company now
owes a service Fase 1 cannot go live without. Nobody has flagged the crossover in
any session. See the risk note.

Elena Spini's own summary of the relationship, 25 Aug 10:19 CEST: Pienissimo Srl
**resells** the Pienissimo Pro software, which is owned by Pienissimo Software
Srl — a distinct legal entity.

## 🔑 2026-09-21 - he is the QR-code and scan-app counterpart, and he is being chased

Two sessions in this window put him on the critical path for the ticket flow.

At [Data Model Parte 6](../meetings/2026-09-18%20Data%20Model%20Parte%206.md)
(`01:28:13`) Aurel Mrruku established that **Salesforce has no native API flow to
receive scan data from the external scanning application**. Elisa Migliano was asked
to approach **Andrea Parmeggiani** for that integration; Elena Spini placed the
logic in **Fase 2**. Rebecca Marmo was separately asked to confirm with him that the
**infopoint registration link** is used only for free-event check-in — tour, food,
soldout (`01:04:03`, `01:18:13`), and the infopoint side is **on hold pending his
feedback**.

At [the 21/09 client call](../meetings/2026-09-21%20Test%20WooCommerce%20e%20Temi%20Mexal.md)
(`00:03:09`, `00:05:11`) Elisa Migliano reported he had **not answered**, and put it
down to the Food event the following week. She offered to walk into their office to
get a slot. ✅ **A slot was obtained**: `[ROMI-PIENISSIMO] - Temi QR Code Biglietti`,
**22/09 10:30–11:00**, invitation sent 21/09 14:17:51Z to his `pienissimo.pro`
address, with Elisa Migliano and Fabrizio Paganelli.

⚠ **Sabatino Rinaldi had to supply his address in the call** — Elena Spini could not
find him in the directory, and Sabatino Rinaldi prompted _"è andrea.pro la mail"_.

⚠ **Three Andreas now appear in this project** — Andrea Di Cicco (ROMI), Andrea
Parmeggiani (Pienissimo Software), and the "Andrea G." of the July and August status
posts. The auto-transcripts garble them freely and the 17/09 notes produced a bare
"Andre". **Attribution here rests on the calendar invitations, which carry
addresses.**
