---
id: OI-177
type: open-item
status: open
owner: Elena Spini
with: Fabrizio Mastracci
org: ROMI
raised: 2026-09-24
updated: 2026-09-25
blocks: [go-live]
severity: gating
source: Slack DM D0B5QHS2T7H, Elena Spini 2026-09-24 20:18 CEST
---

# OI-177 - The marketing flow UAT needs production

**Elena Spini, DM to Aurel Mrruku, 24/09 20:18 CEST:**

> _"aggiungo che abbiamo un problema per il flusso MKT >> perchè per fare gli UAT a
> Fabrizio servono le cose in PROD --- capiamo anche questo domani"_

## Why it matters

- **The marketing UAT session is booked for 2 October** — `Flussi MKT`, one of the six
  sessions confirmed on 21/09. A pre-UAT check is booked for **Tue 29/09 09:30–10:30**
  (`[PIENISSIMO] - Pre UAT: Check giro MKT`, invitation 24/09 06:41:08Z, to Aurel Mrruku
  and Fabrizio Mastracci).
- Every other UAT topic runs in the Partial Copy sandbox. **This one cannot**, and the
  reason is structural rather than a scheduling problem: the marketing setup described in
  the Business Blueprint — the sending subdomain, DKIM/SPF authentication, the IP
  warm-up — lives on real DNS and a real sending reputation, not in a sandbox.
- 🔴 **Nothing records whether production Marketing Cloud is configured**, or who would
  authorise a client acceptance test against it.

⚠ _"a Fabrizio"_ is read here as **Fabrizio Paganelli**, the client-side referent who
takes the UAT sessions. That is an inference from the UAT context and is **not stated**;
Fabrizio Mastracci is the ROMI marketing lead on the same topic. **Confirm before acting.**

## The second half of the same problem

A hand-off between the two has stalled. Elena Spini, same DM, **08:38:52 CEST**, relaying
Fabrizio Mastracci:

> _"rimango in attesa delle indicazioni finali di aurel per completare i flussi che ci
> sono stati richiesti"_

Aurel Mrruku's answer, 08:59–09:00: _"ma di che indicazioni finali si tratta?"_,
_"a me non risulta di aver chiesto altre info"_, _"l'oggetto con i campi l'avevo
condiviso"_ — and he asked for a group to be created _"cosi tracciamo tutto"_. 🔴 **Each
believes the other owes the next move, with the marketing flows unbuilt and the session
eight days out.** Nothing records the group being created.

The Business Blueprint commits ROMI to rebuilding **two** marketing funnels — nurturing
anti no-show, and participant collection
([OI-179](OI-179%20The%20Business%20Blueprint%20goes%20to%20the%20client%20with%20unchecked%20points.md)).

## Open

- 🔴 **Establish what specifically needs to be in production**, and whether the 02/10
  session can run without it.
- 🔴 **Unblock the Aurel Mrruku → Fabrizio Mastracci hand-off.** It is two people waiting
  on each other, which no amount of waiting resolves.
- ⚠ No register row covers a UAT environment constraint.

## 2026-09-25 — the marketing session moves to 7 October

At [UAT Recall Tutor e Bundle](../meetings/2026-09-25%20UAT%20Recall%20Tutor%20e%20Bundle.md) (`02:05:08`–`02:11:52`) Elena Spini confirmed to the
client that **the marketing environment is only reachable in production**. So:

- **Fri 2 October** is no longer Flussi MKT. It becomes the re-run of the WooCommerce flow
  ([OI-181](OI-181%20Stage-sale%20bundles%20need%20their%20tranches%20defined%20at%20bundle%20creation.md)).
- **Marketing moves to 7 October**, with Rebecca Marmo. Sabatino Rinaldi is to tell her.
- **Wed 30 September stays** on campaigns and tickets in Salesforce, no marketing.
- Elena Spini: _"per te hai lunedì e martedì per fare il deploy"_ (28–29/09), meaning a
  partial production deploy (_"deploy Fabrizio"_). Aurel Mrruku: a deploy also needs its
  records, and the Account load alone took a day and a half. **Left for the two of them to
  settle afterwards.** Nothing records the outcome. An unrecorded internal call followed at
  12:30 CEST.

🔴 **7 October is one day after the UAT window closes (6/10)** and six before approval
(13/10). The pre-UAT check `Check giro MKT` on 29/09 still stands. Whether the Aurel
Mrruku ↔ Fabrizio Mastracci hand-off was unblocked is not recorded.

## ✅ 2026-09-25 — decided via drill-me: the deploy moves after 2/10

Aurel Mrruku will not use 28–29/09 for the production deploy; the week goes to
[OI-181](OI-181%20Stage-sale%20bundles%20need%20their%20tranches%20defined%20at%20bundle%20creation.md).
**Ask Elena Spini to move the partial production deploy to the week of 5/10**, ahead of
the 7/10 marketing session. 🔴 Not yet communicated to her; nothing records her agreement.

## 🔴🔑 2026-09-25 evening - the session moves again, twice, to 16 October

`[ROMI-PIENISSIMO] - UAT: Flussi MKT Biglietti` was **rescheduled twice within
nineteen minutes**, both by Elena Spini, on the same calendar event (same Meet link,
same `eid`):

| Sent   | New slot                          |
| ------ | --------------------------------- |
| 16:34Z | **Thu 15 October**, 10:00-12:00 CEST |
| 16:52Z | **Fri 16 October**, 10:00-12:00 CEST |

**Final state: Friday 16 October.** Guests: Elena Spini (organiser),
`amministrazione@`, Fabrizio Mastracci, Aurel Mrruku, Fabrizio Paganelli,
**Rebecca Marmo**, Sabatino Rinaldi (optional).

🔑 **The note on the first update is the client-facing rationale, and it settles what
this row was opened to ask.** Verbatim:

> _"Come da accordi, posticipiamo gli UAT di questo modulo. La nostra priorità
> attuale è stabilizzare e validare la piattaforma in ambiente di test, così da
> arrivare nelle migliori condizioni al passaggio in produzione, dove verranno poi
> condotti i test per i flussi Marketing."_

So: **the marketing flows will be tested in production, after the switch, and that
is now stated to the client in writing.** The environment constraint recorded above
is no longer a problem to solve — it is the plan.

### What that costs

- 🔴 **16 October is after the 13 October approval deadline** and after the UAT
  window ([OI-124](OI-124%20Go-live%20moved%20from%206%20to%2021%20October.md):
  UAT 23/09-13/10, approval by 13/10, go-live 21/10). **Marketing is now the one
  module whose acceptance test falls outside the acceptance period** — it moved from
  02/10 to 07/10 to 16/10 in two days. ⚠ Nothing records whether the client
  understands its approval is therefore conditional, or whether §13/10 covers it.
- 🟢 It removes the collision with the bundle-tranche week and with the partial
  production deploy, which the drill-me decision had pushed to the week of 5/10.
  **The deploy no longer has a 7/10 deadline behind it.**
- 🔴 **The hand-off is still not recorded as unblocked.** The Aurel Mrruku ↔ Fabrizio
  Mastracci stand-off above has nothing new against it, and the pre-UAT check
  `Check giro MKT` on **Tue 29/09 09:30** still stands with the session now 17 days
  later. ⚠ Whether that check still makes sense on its old date is not recorded.
- ⚠ **The 30/09 session still carries campaigns and tickets.** The Campaign fields
  and the `Campagna_Figlio` record type reached `DevMain` this evening
  ([OI-181](OI-181%20Stage-sale%20bundles%20need%20their%20tranches%20defined%20at%20bundle%20creation.md)),
  so that half is not affected by this move.
