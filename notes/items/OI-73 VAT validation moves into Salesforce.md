---
id: OI-73
type: open-item
status: in-progress
owner: Aurel Mrruku
with: Elisa Migliano
org: both
raised: 2026-08-06
updated: 2026-08-25
depends_on: [OI-94, OI-95]
source: meetings/results/2026-08-06-chiusura-punti-aperti.md
---

# OI-73 - VAT validation moves into Salesforce

**The VAT check moves into Salesforce and fires at the FIRST order of an
account** — not at account creation, and not deferred to phase 2.

As-is: pre-invoicing in Mexal reads the order's VAT, checks the Mexal registry,
and if absent calls a business-information service returning ragione sociale,
address, PEC and legal representative. Elisa Migliano rates that registry
_"corretta al 99,5%"_. She proposed relocating the call to order generation so
the data pushed to Mexal is already clean; Elena Spini approved.

**Not at account creation, on cost**: free events draw 3,000–6,000 registrants
of whom roughly 250 buy.

Design details: a checked account carries a **"consolidato" flag** and is never
re-checked; failures email an **administration address Pienissimo must still
supply**; a **manual re-check button** sits on both order and account, using the
same API.

✅ **The provider is settled: Anticipay, formerly CreditSafe.** They are the
same company under two names, which is what made the transcript read as two
candidates. Elena Spini's `PIENISSIMO - Project Status` document (6 August)
writes it as _"Anticipay (ex CreditSafe)"_ and marks the timing **confirmed at
order creation**; the calendar invitation for the technical call is titled
_Integrazione Anticipay_ and describes the service as CreditSafe in its body.
Either name may be used in a requirement, but prefer **Anticipay** and note the
former name once.

✅ **The technical call ran: Tuesday 25 August 2026, 10:00 CEST.** Minuted at
[2026-08-25 Integrazione Anticipay](../meetings/2026-08-25%20Integrazione%20Anticipay.md).
Present: Elena Spini, Aurel Mrruku, Andrea Di Cicco, **Andrea Parmeggiani**
(`andrea.p@pienissimo.pro`), Fabrizio Paganelli and Elisa Migliano
(`amministrazione@`); Sabatino Rinaldi optional. See the 25 August section at
the foot of this note.

A third independent confirmation: `Pienissimo_Project Plan.pptx` (10 July) lists
**"Anticipay (ex CreditSafe) → SFDC"** among the **Fase 1** integrations.

⚠ [Andrea Parmeggiani works for **Pienissimo Software Srl**](../people/Andrea%20Parmeggiani%20-%20Pienissimo%20Software%20maintenance%20manager.md),
not Pienissimo Srl — he is its Maintenance Manager, on the `.pro` domain. That
is the entity at the centre of
[the scope dispute](../risks/Risk%20-%20the%20phase%202%20scope%20dispute%20is%20unresolved.md),
yet he is the named technical contact for a Fase 1 integration. Not a problem in
itself; worth knowing before anyone bills time or touches their systems.

Still outstanding: **credentials**, and the **administration address** that
failure notifications should go to.

## 2026-08-24 - the provider is named: Anticipay

The [master design file](../The%20newest%20design%20diagram.md), re-decoded at its 2026-08-24T16:34:34Z version,
names the provider this item has carried as unconfirmed. On **both** the
LEAD-OPTY and Ordini pages:

> _"Alla generazione del primo ordine di un ACCOUNT chiamata API **Anticipay**
> per check P.iVA Account"_

with the failure path drawn beside it:

> _"Unhappy path: info con email ad amministrazione"_

So the trigger point is settled too — **the first order for an Account**, not
lead capture and not account creation.

⚠ **This cannot be dated.** The cell is present in the 24 August version and
absent from the 20 August decode write-up, but that write-up was prose rather
than a byte-level record, so absence from it is not proof of absence from the
file. Record it as **present, not previously registered**. There is an
**Anticipay meeting on 25 August**, which is consistent with the cell being
either new or long-standing.

Still open: whether Anticipay is contracted, what the API costs, and what
"unhappy path" means operationally — an email to amministrazione is a
notification, not a decision about whether the order proceeds.

## 2026-08-25 - the call ran, and the counterparty changed

The [technical session](../meetings/2026-08-25%20Integrazione%20Anticipay.md)
settled the mechanics. **The business rule in this note is unchanged** — the
check still fires at the first order of an Account, still writes back, still
notifies administration on failure. What changed is who Salesforce talks to.

🔴 **Salesforce will not call Anticipay.** It calls a **Pienissimo Software
middleware** that fronts Anticipay, caches lookups and returns a standard
payload. Full contract, and why it is a commercial question as much as a
technical one, at
[OI-94](OI-94%20Anticipay%20is%20called%20through%20the%20Pienissimo%20middleware.md).

Settled with it:

- **Auth** — a token in the HTTP request header.
- **Errors** — `404` VAT not found, `500` generic; **code and message both
  returned, stored in Salesforce for three months**, and used to raise internal
  notifications. This is the first concrete answer to what the "unhappy path"
  does: it is a stored record plus a notification, and it still does **not** say
  whether the order proceeds.
- **Conflicts** — the returned value **overwrites** what Salesforce holds.
- **Payload** — trimmed to the needed fields; which ones is
  [OI-95](OI-95%20Which%20Anticipay%20fields%20land%20in%20Salesforce.md), owned by
  Fabrizio Paganelli and Elisa Migliano.
- **Trigger** — confirmed aloud as the first order per Account, matching what the
  diagram already drew.

**Still open, unchanged by this session:** whether Anticipay is contracted and
what the API costs — neither was raised, and the middleware makes the cost
Pienissimo's problem rather than answering it. The **administration address** for
failure notifications is still not supplied. Credentials do not yet exist,
because the middleware endpoint does not yet exist.

Next: **Follow-up Integrazione Anticipay, Tuesday 1 September 2026, 10:00 CEST**,
cancellable if Andrea Parmeggiani's payload example lands first.
