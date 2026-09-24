---
id: OI-163
type: open-item
status: in-progress
owner: Aurel Mrruku
with: Elena Spini
org: ROMI
raised: 2026-09-22
updated: 2026-09-24
depends_on: [OI-149]
blocks: [go-live]
severity: gating
source: notes/meetings/2026-09-22 Update Interno Aurel Elena.md
---

# OI-163 - Lead conversion has no agreed duplicate rule

**Raised by the developers during testing on 22/09**, relayed by Aurel Mrruku at
[the internal update](../meetings/2026-09-22%20Update%20Interno%20Aurel%20Elena.md).
**Lead and Opportunity UAT is 24 September.**

Conversion creates **Account + Contact + Opportunity**. What happens when the
counterpart already exists is undefined.

| Case | Behaviour |
| ---- | --------- |
| Account already exists | the contact attaches to it — both agreed |
| **Contact exists, different `partita IVA`** | undecided |
| **Contact exists, different `ragione sociale`** | undecided |
| **Same P.IVA, two different ragioni sociali** | undecided |
| **Same ragione sociale, two different P.IVA** | undecided |

Aurel Mrruku: the same contact on two accounts _"non può essere. Non ha senso."_

## The working direction, not yet a decision

**Deduplicate on `partita IVA` alone**, not on the pair with `ragione sociale`:

- the P.IVA is also what drives the **Anticipay** call at first order, so two
  accounts with the same P.IVA must not exist;
- a typo is far likelier in the company name than in the VAT number — Elena Spini:
  _"è più facile sbagliare a scrivere qualcosa di diverso sulla ragione sociale che
  sulla partita IVA"_;
- ⚠ **the behaviour already happens this way**: the 21/09 Anticipay test attached to
  the pre-existing account carrying that P.IVA, and that was the reason.

## Why it is gating

- **Conversion uses custom trigger logic with deduplication**, not the standard
  component ([OI-149](OI-149%20Two%20Lead%20record%20types.md)), so there is no
  platform default to fall back on.
- Rejecting a Lead leaves it **stuck in its state** with no defined exit. Elena
  Spini's only concrete proposal was an error message; Aurel Mrruku's objection:
  _"rimarrai in quello stato."_
- Lead data quality is **deliberately unconstrained** — leads arrive from public
  forms. Aurel Mrruku: _"sulla qualità dei dati me ne frego."_
- The client has never been asked. Elena Spini's plan is to raise it **as a point of
  attention during UAT**; Aurel Mrruku's position is that the case will certainly
  occur, because a mistyped ragione sociale or P.IVA is routine.

## Open

- 🔴 **Rule the duplicate cases before 24 September**, or accept that UAT will hit
  them live.
- 🔴 **Define the failure path** for a Lead that cannot convert.
- ⚠ No register row covers Lead deduplication.

## 🟢 2026-09-24 — a duplicate rule exists, it fired in front of the client, and the client approved it

**The question this note raised was answered by demonstration rather than by ruling.**
At [UAT: Lead e Opportunità](../meetings/2026-09-24%20UAT%20Lead%20e%20Opportunita.md)
`00:29:22`–`00:33:41`, Aurel Mrruku converted a direct lead and the duplicate check
stopped him.

What it does, in his own description:

> _"Qua ha fatto il check sul nome, sulla mail, se esisteva già una mail sui lead oppure
> sui contatti oppure sui account, ti dà l'indicazione che guarda che hai un duplicato"_

and the dialogue offered:

> _"Ho trovato un account simile al tuo… vuoi mettere il contatto sotto quell'account
> oppure vuoi creare un nuovo account?"_

🟢 **Fabrizio Paganelli walked the behaviour back and confirmed it:**

> _"quindi quando si converte il lead fa la verifica se c'è già l'azienda, la verifica se
> c'è già il contatto, se sono presenti si fa il merge, se sono assenti ti dà la
> possibilità di creare"_

Aurel Mrruku chose merge; the conversion produced a contact, an account and a
`Vendita Standard` opportunity at state `Qualificato`.

### What this closes and what it does not

- 🟢 **Matching criteria are established**: name and email, evaluated across **Leads,
  Contacts and Accounts**.
- 🟢 **The client has now seen it and accepted it.** This note's open item _"the client has
  never been asked"_ is discharged: the rule was shown during acceptance and validated by
  the client's own referent.
- ⚠ **A clean end-to-end run was still owed.** Aurel Mrruku: _"Poi facciamo un giro pulito
  con un vostro nome, così siamo sicuri"_; Elena Spini agreed. The session's action items
  carry it as **_"\[Il gruppo\] Eseguire test completi… con dati reali"_**. Nothing
  records it being done.
- 🔴 **The failure path is still undefined.** Nothing establishes what happens to a Lead
  that cannot convert — the merge-or-create dialogue assumes a human is present, and the
  record holds no ruling for the unattended case.
- ⚠ **P.IVA is not part of the match.** Aurel Mrruku creating a Standard lead at
  `00:44:08`: _"Come partita IVA metto questa roba qua. Non abbiamo nessun controllo per
  il momento."_ The check runs at account creation, against Mexal and Anticipay. This
  note's original worry — a mistyped P.IVA or ragione sociale — is unaddressed by the
  name-and-email rule.
- ⚠ Still no register row covers Lead deduplication.
