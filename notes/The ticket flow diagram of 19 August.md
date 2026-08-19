---
id: ref-dgm-biglietti-0819
type: reference
status: active
owner: Elena Spini
org: ROMI
updated: 2026-08-19
source: Drive - Flusso Biglietti.drawio, created 2026-08-19T15:00:55Z, modified 2026-08-19T15:01:55Z
---

# The ticket flow diagram of 19 August

`Flusso Biglietti.drawio` — a **new, standalone** file in
`[Pienissimo] Fase Progettuale`, created by Elena Spini on **19 August 2026 at
15:00 UTC** (17:00 CEST) and decoded in full the same evening. 30 KB, plain
uncompressed mxfile XML.

It is not a copy of the `Flusso Biglietti` **page** inside
[the master diagram](The%20newest%20design%20diagram.md) — it is a separate file
that redraws the same flow with more detail, and it carries at least two things
the master did not.

⚠ **Whether it is the output of the 19 August marketing session is not
confirmed.** The date and the subject match
[OI-81](items/OI-81%20Event%20communication%20funnel.md), and the master file was
modified 92 minutes later (16:33 UTC), but **no recording, canvas entry or
message accompanies it**: Fathom holds no Pienissimo recording after 06 August,
the Slack canvas is unchanged, and `#tproj-pienissimo` has not been posted to
since 07 August. Treat the meeting as **unminuted** until something confirms it.

## What is new here

**1. `Rinuncia` is drawn as its own state box.** The asset-status row reads
`Ordinato` · `Disponibile` · `Rinuncia` · `Assegnato` · `Utilizzato` ·
`Non utilizzato` · `Annullato` — **seven boxes, not six**, with `Rinuncia`
annotated _"Avviene nella comunicazione dei partecipanti o accetta o rinuncia"_.
That places it at the participant-communication step: the referent either
accepts or declines. See
[OI-74](items/OI-74%20Asset%20state%20machine.md) — this needs a human ruling,
not an inference.

**2. An `Aggiornamento Incasso` button, never recorded anywhere.** Now
[OI-91](items/OI-91%20Aggiornamento%20Incasso%20button.md).

**3. A second funnel communication with no date on it** — the diagram carries
both _"A **30-60 giorni** dall'evento"_ and _"A **XX giorni** dall'evento"_.
`XX` is literal, a placeholder in the file. Folded into
[OI-81](items/OI-81%20Event%20communication%20funnel.md).

**4. The participant landing page, concretely.** Marketing sends a
communication carrying a **link with the Account ID in it**, redirecting to a
landing page where the referent who bought the tickets supplies the participant
list as **"Nome Cognome Email"** — and the **number of rows to complete equals
the number of tickets purchased**. On confirmation an SFDC flow creates new
Contacts where absent (otherwise matches), adds **Campaign Members** to the
chosen campaign/event, and a mail delivers the QR code. Folded into
[OI-78](items/OI-78%20Participant%20data%20collection.md).

**5. One branch is struck through.** _"Se quell'Account ha acquistato più
eventi: scelta dell'evento al quale si fa riferimento"_ carries
`text-decoration-line: line-through` in the file — the "which event do you
mean" step was drawn and then withdrawn. A plausible reading is that it became
unnecessary once each event got its own countdown and its own communication
(OI-81), so the landing page never has to ask. **That is a reading of a struck
box, not a recorded decision.**

**6. The `Casi Limite` button, expanded into two cases.** `CASO 1` — from the
button, see every ticket for that Account, choose which to set `Annullato` and
who to enter instead; new Contact if absent from the CRM plus a Campaign Member
update; on confirmation send the name-change mail, the informativa and the QR
code. `CASO 2` — no signed documents, **no automation at all**: a check at
check-in and a manual Campaign Member update. This sharpens
[OI-84](items/OI-84%20Campaign%20Member%20handling%20for%20manual%20check-in.md),
which recorded the manual path as undesigned.

## What it restates, already held

The Mexal side (`Genera Biglietto = SI`, generally one product per event, SFDC
auto-creating the Campaign) is [OI-77](items/OI-77%20Mexal%20event%20product%20creates%20the%20Campaign.md)
and [OI-53](items/OI-53%20Asset%20generation%20rule.md). The QR carrying the
**campaign member id**, `Disponibile` on _"Fattura pagata - a livello di
tranche/rate"_, `Non utilizzato` three days after the event, the `Casi Limite`
button appearing only once an asset is `Assegnato`, one product code per event
with the ticket type in the name — all already recorded from the 06 August
master decode. Nothing there needs re-extracting.

## Method note, worth keeping

**Drive does not full-text index `.drawio` mxfiles**, so a `fullText` miss on
one is meaningless and must never be reported as absence. They are readable:
download the file and base64-decode it. This one is plain XML — not even
deflate-compressed — so the labels read directly.

Its title also has no `.drawio` suffix problem, but the older
`PIENISSIMO - Flusso Lead-Opportunità` does: its **title carries an accented
`à` and no extension**, which is why title searches for `drawio` miss it. It is
still in the folder, unmodified since 2026-07-10.
