---
id: OI-108
type: open-item
status: open
owner: Elena Spini
with: Fabrizio Paganelli, Elisa Migliano
org: both
raised: 2026-09-01
updated: 2026-09-01
depends_on: [OI-94]
blocks: [OI-95, OI-73]
requirement: INT-18
source: notes/The Anticipay middleware API contract.md
---

# OI-108 - The Anticipay payload carries personal data of the legale rappresentante

**Six of the eleven fields the middleware returns describe a natural person, not
a company:**

| Field                                   | What it is                                                               |
| --------------------------------------- | ------------------------------------------------------------------------ |
| `nome_legale_rappresentante`            | full name of an identified individual                                    |
| `codice_fiscale_legale_rappresentante`  | national fiscal identifier                                               |
| `data_di_dascita_legale_rappresentante` | date of birth                                                            |
| `luogo_nascita_legale_rappresentante`   | place of birth                                                           |
| `indirizzo_legale_rappresentante`       | **home address**                                                         |
| `pec`                                   | company PEC, but often a person's routing address in a ditta individuale |

Name plus codice fiscale plus date and place of birth plus home address is not
incidental personal data. It is **a complete identification of a private
individual**, and the sample in the documentation is a real one.

## Why this is raised now and was not raised on 25 August

Nobody hid anything. The 25 August session agreed the payload would be _"trimmed
to the needed fields"_ precisely because Anticipay returns _"far more information
than anyone wants"_ — and everyone reasonably pictured **company registry data**.
[OI-95](OI-95%20Which%20Anticipay%20fields%20land%20in%20Salesforce.md) recorded
the retention question as **unraised**, correctly, because at that point no field
list existed.

The list now exists, and the trimmed set turns out to be **mostly personal data
about a person who is not the customer contact and never interacted with ROMI or
Salesforce**. That changes the question from theoretical to concrete, and it is
the field-selection decision — already owned by Fabrizio Paganelli and Elisa
Migliano — that resolves it.

## The questions, none of which have answers in the record

- **What is each personal field _for_?** The business rule in
  [OI-73](OI-73%20VAT%20validation%20moves%20into%20Salesforce.md) is _validate the
  VAT number so the data pushed to Mexal is clean_. `ragione_sociale`, the
  address block and `pec` serve that. **A director's date of birth, place of
  birth and home address do not.** If a field has no stated purpose, the answer
  is to not store it.
- **How long is it kept?** The three-month retention agreed on 25 August covers
  **error codes and messages**. Nobody has ever stated a retention for the
  _returned data_, and OI-95 flagged that gap before this document arrived.
- **On what basis, and does Pienissimo's own basis extend to ROMI's copy?**
  Pienissimo already receives these fields today through the Mexal pre-invoicing
  lookup. Copying them into a second system, with different readers and different
  retention, is a separate processing activity.
- **Who can see them?** The 25 August design writes the result **onto the
  Account**, which Pienissimo administration reads routinely. There is no
  field-level security discussion anywhere in the record.
- **What does the `consolidato` flag mean for erasure?** An account is checked
  once and never re-checked. So the stored copy is frozen and, by design, never
  refreshed against the source.

## The recommendation, so the call has something to react to

**Store the company block; drop the person block.** Take `ragione_sociale`,
`indirizzo`, `citta`, `provincia`, `cap` and `pec` — every field that serves the
stated purpose of clean Mexal data. Leave the five legal-representative fields
**unmapped in Salesforce**: the middleware may return them, but nothing has to
persist them.

That is not a hard rule, and it is not this note's to impose — it is offered so
that "which fields" gets decided **with the personal-data question in view**
rather than as a convenience list. If a legal-representative field is genuinely
needed, say what for, and give it a retention.

⚠ Note that this may also close
[OI-105](OI-105%20The%20Anticipay%20date%20of%20birth%20field%20name%20is%20misspelled.md)
without anyone fixing the typo: if the date of birth is not stored, its
misspelled key stops mattering.

## The ask

**Elena Spini** — this is a client-facing processing question, not a developer
one, and it is the same shape as the entity question in
[OI-94](OI-94%20Anticipay%20is%20called%20through%20the%20Pienissimo%20middleware.md):
it wears an architecture diagram and is not an architecture problem.

**Fabrizio Paganelli and Elisa Migliano** already hold the field-selection action
from 25 August with **no date on it**. Put a date on it at the 1 September call —
they have had the full list since 31 August and are both on the thread.

🔴 **Nothing about this stops the build starting.** The company block is
uncontroversial and is most of the value. Do not let this item become the reason
the integration slips past the **10 September** end of Fase 1 development.

**No value from the sample response may be copied** into `notes/`, the recaps,
`STATUS.md` or [site/](../../site/) — see
[the publishing rules](../../docs/publishing.md) and
[the contract](../The%20Anticipay%20middleware%20API%20contract.md).

## 2026-09-01 - the decision went the other way, and this note was never in the room

**The [1 September call](../meetings/2026-09-01%20Follow-up%20Integrazione%20Anticipay.md)
decided the field selection and took all five legal-representative fields onto
the Account** — see
[OI-95](OI-95%20Which%20Anticipay%20fields%20land%20in%20Salesforce.md).

⚠ **Be precise about what happened: this was not a rejection.** The
recommendation above was written the same day and the personal-data question was
**never raised by anyone in the twenty minutes**. The room was mapping fields,
not weighing a processing decision. Recording it as "the client considered and
declined" would be a fabrication.

### 🟢 One of the five questions now has an answer

_"What is each personal field for?"_ has its first real answer on the record.
**Elisa Migliano: the legal representative's details are _"fondamentale per la
firma dei contratti"_** — contract signature. That is a legitimate, specific
purpose, it is the operational authority on administration saying it, and it
plainly justifies **the name**.

🔴 **It does not, on its face, justify the other four.** Signing a contract needs
to identify the signatory; it is not obvious why it needs the signatory's
**date of birth, place of birth, codice fiscale and home address**, and no one
gave a reason for those individually. That is now the sharpened question — not
"why any of this", but **"why these four"**.

### What is still entirely unaddressed

Unchanged and unmentioned in the call:

- **Retention.** Still nothing. The three-month rule covers error codes only.
- **Lawful basis**, and whether Pienissimo's own basis extends to ROMI's copy.
- **Field-level security.** The fields are now confirmed to be going **onto the
  Account**, which Pienissimo administration reads routinely — the exact exposure
  this note flagged — and the meeting discussed layout not once.
- **Erasure** under the `consolidato` freeze.

### The ask, revised

The build should proceed — this was never a reason to stall it, and OI-95 is now
resolved. But **the four unjustified fields are cheap to revisit before they are
created and expensive afterwards**, because a populated field is a processing
record and an empty one is a decision.

**Elena Spini**: this needs five minutes at the **data-model call** Elena Spini
herself agreed to organise at the same meeting — which is the natural forum,
already exists as an action, and has no date. Ask for one purpose sentence per
personal field, and a retention. If the answer for a field is "in case it is
useful", that is the answer OI-108 exists to catch.

Status stays `open`. The field selection is resolved; the processing question it
raised is not.
