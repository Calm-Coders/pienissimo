---
id: meeting-2026-10-30-connessione-woocommerce
type: meeting
status: resolved
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: both
raised: 2026-10-30
updated: 2026-10-30
depends_on: [OI-298, OI-302, OI-303, OI-304, OI-305, OI-306]
blocks: [go-live]
source: Google Drive 1g4-BqRteDnAzQ89T7UxUPuFaZyVB3euixAPm6Wa424E
---

# 2026-10-30 Connessione WooCommerce

**A working client call in which WooCommerce orders were placed live and watched
through to Mexal. It produced five agreed changes, one plugin fix shipped during
the call, and a referral of the contract question to a dedicated meeting. It also
disposed of [OI-298](../items/OI-298%20WooCommerce%20bundle%20orders%20from%20a%20new%20customer%20do%20not%20reach%20Salesforce.md):
the order the client could not find had arrived.**

## The record that exists

| | |
| --- | --- |
| Invite | `[ROMI-PIENISSIMO] - Connessione WooCommerce`, **30 October 15:00–16:00 CET** |
| Started | **15:01 CET** |
| Gemini notes + transcript | `1g4-BqRteDnAzQ89T7UxUPuFaZyVB3euixAPm6Wa424E`, 46,593 B, owner Elena Spini, created 15:49:45Z |
| Notes mail | Gmail `1a18d8250d203e84`, 15:51:30Z |

**Invited:** Elena Spini, Sabatino Rinaldi, Aurel Mrruku,
`amministrazione@pienissimo.com`, Fabrizio Paganelli. **Named in the notes as
taking part:** Aurel Mrruku, Fabrizio Paganelli, Sabatino Rinaldi, **Giuliano
Lanzetti** and Elisa Migliano.

🔑 **Elena Spini did not attend.** Aurel Mrruku asked her at 16:13:53 CET
(`D0B5QHS2T7H`) — _"riesci a partecipare"_ — and she declined: _"dovevo staccare
il 16 oggi -.- e sto ancora davanti al pc"_, _"se puoi rimanda"_. He answered
_"ok ti aggiorno lunedi"_. **So the project manager's account of this call is
second-hand.**

🔑 **Giuliano Lanzetti is the first name of the person held as
[G Lanzetti](../people/G%20Lanzetti%20-%20CEO%20of%20both%20Pienissimo%20companies.md)**,
and this is the first session in this record he is named in.

⚠ **This note is drilled from the Gemini summary and its `Dettagli` section, not
from the raw transcript.** The transcript is 84 KB and was not read line by line;
quotations below are Gemini's paraphrase unless marked otherwise, and the timings
are its anchors.

## What was agreed

1. 🔑 **Duplicate customer matching moves from email to partita IVA** —
   [OI-302](../items/OI-302%20WooCommerce%20matches%20customers%20by%20email%20instead%20of%20partita%20IVA.md).
   Found live at `00:15:17` when a test order attached itself to an existing
   account through a shared email address.
2. 🔑 **The opportunity id is single-use and must leave the cookie and the session
   as soon as the order completes** —
   [OI-303](../items/OI-303%20The%20WooCommerce%20plugin%20kept%20the%20opportunity%20id%20in%20cookies%20for%2030%20days.md).
   Sabatino Rinaldi built and uploaded the fix **during the call**.
3. 🔑 **Contracts from WooCommerce orders do not require a digital signature before
   the order is accepted.** A status flag and a chasing report take its place —
   [OI-304](../items/OI-304%20Contracts%20for%20WooCommerce%20stage%20sales%20are%20not%20generated.md).
4. ⚠ **The test environment question was agreed twice, in opposite directions.**
   Gemini's `Concordato` list carries both _"eseguire i test di integrazione di
   WooCommerce nell'ambiente di test anziché direttamente in produzione"_ and
   _"effettuare i test direttamente nell'ambiente di produzione di WooCommerce
   utilizzando clienti esistenti, data l'assenza di un ambiente di test
   dedicato"_. The `Dettagli` section has the meeting opening on the first
   (`00:04:05`: keep the test environment, defer the production switch using the
   documentation Aurel Mrruku supplied) and **closing on the second**. 🔑 **The
   underlying fact is not in dispute: there is one WooCommerce environment only**
   — Aurel Mrruku, `00:00:45`. What is undecided is whether Salesforce stays on
   UAT against it. **No date for the production switch was set**; the group owns
   agreeing one.
5. 🔑 **The default test agent is to be Carmine.** Only Carmine is active in Mexal;
   the code had been pointed temporarily at Aurel Mrruku's own agent value and must
   be corrected for production (`00:30:53` area). Relates to
   [OI-293](../items/OI-293%20The%20agent%20registry%20for%20the%20production%20load%20may%20be%20incomplete.md)
   and to OI-301's unticked _"WooCommerce default agent"_ step.

## What broke during the call

- 🔴 **Mexal rejected the province** on the test orders, over invalid characters or
  unrecognised values in the address fields. Aurel Mrruku owns fixing the address
  and province validation.
- 🔴 **Anticipay does not answer in UAT** for invented data or for San Marino, so
  the anagrafica cannot self-populate and **a full test cycle with a genuinely new
  customer is not possible in UAT** —
  [OI-305](../items/OI-305%20Anticipay%20does%20not%20answer%20in%20UAT%20for%20test%20data%20or%20San%20Marino.md).
  Aurel Mrruku's workaround is to test with a real existing partita IVA, which
  ⚠ **removes the new-customer path from the test** — the very path the client has
  been reporting faults on all week.
- ⚠ WooCommerce cache had to be cleared to shed data held from earlier attempts.

## What was deferred

🔑 **The contract question was too big for this call and has its own meeting:
Monday 2 November 09:30 CET**, with Elena Spini, on how contracts are generated
per bundle type — annual courses against Performance Plus. Aurel Mrruku set the
scope in Slack at 16:18:30 CET: _"tema contratti per gli ordini da woocomerce (
cntratti cartacei"_.

⚠ **A second fact surfaced inside it and is not separately recorded**: Aurel Mrruku
said that generating one line per tranche is **not native to standard bundles** and
needs specific logic for Performance Plus and its decomposition into multiple
lines. Whether that logic exists already was not established in this call.

## Next steps as recorded

| Owner | Step |
| ----- | ---- |
| Aurel Mrruku | duplicate check on partita IVA; address/province validation; default agent Carmine |
| Sabatino Rinaldi | WooCommerce plugin update clearing the opportunity id (**done in the call**) |
| Fabrizio Paganelli | ask Mirko Merendi for the order header note field code (**done, 16:11 CET**) |
| Aurel Mrruku, Fabrizio Paganelli, Elena Spini | define the paper/electronic contract flow for stage sales |
| The group | agree a date for the production switch; run production validation tests before release |
