---
id: OI-263
type: open-item
status: open
owner: Elena Spini
org: ROMI
raised: 2026-10-19
updated: 2026-10-20
source: notes/meetings/2026-10-19 Test UAT Commerciali.md
---

# OI-263 - Salesforce system labels are still in English

**Parts of the interface the client's key users work in every day are still in
English. Elena Spini noticed two in the walkthrough and recorded both, one of
them a button on the lead path a tutor presses several times a day.**

## What was seen

At [the 19/10 session](../meetings/2026-10-19%20Test%20UAT%20Commerciali.md):

- `00:39:38`, on the lead stage control: _"si va in lavorazione il pulsante
  Mar[k] Current Stage. Questo dobbiamo ricordarci di tradurlo."_ Then _"lo
  segno"_.
- `01:01:48`, on the quote header: _"Expiration date. Eh, non so perché è
  rimasto[;] questi sono tutti rimasti in inglese, ora che ci penso. Faccio lo
  screenshot di questo."_

The Gemini notes carry it as an action on her — _"Tradurre la dicitura
dell'etichetta di sistema in lingua italiana"_ — in the singular, which
understates it: her own words are _"questi sono tutti rimasti in inglese"_.

## Why it is more than cosmetic

🔑 **The user's language was set deliberately.** Elena Spini, creating Marco
Montesi's account: _"mi sa che ti avevo messo l'italiano già di default"_, and
the welcome mail arrived in Italian. So the org is configured for Italian and
these labels are leaking through anyway — which means the cause is not the user's
locale but untranslated **custom** labels, field labels or flow screen text, and
a translation pass is the fix rather than a setting.

⚠ **Scope is unknown.** Two instances were spotted in one 01:45 walkthrough that
covered a fraction of the surfaces. Nobody enumerated the rest, and the key-user
training week starts 26/10.

## Open

- 🔴 **No inventory.** Which labels, on which objects, is not written down
  anywhere.
- ⚠ **Both instances are on the two paths the commercial users live in** — lead
  stage advancement and the quote header.

## What closing it looks like

A pass over the custom labels, field labels and flow screens on the Lead, Quote,
Opportunity and Order surfaces, with the Italian strings deployed — before the
training week, since the training material will show these screens.

## 🟢 2026-10-20 — decided and built within the hour

**The one label the client saw is being replaced with a custom Italian one. It was
agreed at 17:01 CEST and committed at 18:03 CEST, on both the lead and the
opportunity path.**

At [the 17:01 internal call](../meetings/2026-10-20%20Follow-up%20Interno.md),
Elena Spini raised it with the 19/10 context attached — _"Ieri condivideva Marco
che aveva le cose in italiano ed era sempre in inglese"_ — and asked only whether
it could be translated.

Aurel Mrruku established it could not, and chose to go around it:

> _"però quello è standard in teoria"_ — Elena Spini: _"dovrebbe tradursi, ma non
> lo fa"_ — _"Vabbè, lo mettiamo custom, chi se ne frega, faccio io qualcosa …
> come lo facciamo in italiano? Cambia stato."_ Elena Spini: _"Eh sì, esatto."_

🟢 **Built in `750978a`** (Anita Aga, `DevAnita20`, 20/10 18:03:16 CEST):
`label="Cambia stato"` in both `leadCustomPath.html` and
`opportunityCustomPath.html` — two files, two lines, **62 minutes after the
decision**. 🔴 **Unmerged**, on `DevAnita20`, no PR.

🟢 **It also covers the path Elena Spini predicted would spread**: she expected the
label to appear on every object — _"penso che poi andrà in tutti"_ — and the commit
pre-empts that for the opportunity.

## 🔴 What is still open

- ⚠ **This closes one label of an unknown number.** Elena Spini's 19/10 words were
  _"questi sono tutti rimasti in inglese"_ — plural, and this row recorded her
  naming two. **`Expiration Date` is not in the commit** and no source says
  whether it is standard or custom.
- ⚠ **No systematic check has been run.** Nobody has listed the English strings a
  key user actually meets, so the row cannot be closed on two fixes. 🔑 The method
  that found both was a client noticing one on screen, which is not a method.
