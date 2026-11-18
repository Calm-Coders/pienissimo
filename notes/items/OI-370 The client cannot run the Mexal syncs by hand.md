---
id: OI-370
type: open-item
status: in-progress
owner: Aurel Mrruku
with: Anita Aga, Fabrizio Paganelli
org: ROMI
raised: 2026-11-16
updated: 2026-11-18
depends_on: [OI-334]
blocks: []
severity: normal
source: notes/meetings/2026-11-16 Ultimi Check PROD.md
---

# OI-370 - The client cannot run the Mexal syncs by hand

**The Mexal syncs now run twice a day, so a change made in Mexal can wait hours
before it reaches Salesforce. The client asked, in writing and on the call, for a
way to trigger them himself and for instructions. The attempt to show him
`execute anonymous` failed live in the call, and the developer promised buttons on
the home page by 18 November instead. A home-page component that looks like exactly
that was committed to a developer branch the same afternoon and has not been merged
or deployed.**

## The request

Fabrizio Paganelli wrote it into the mail thread during the call,
**2026-11-16 09:01:12Z** (Gmail `1a1d06456c06e4f8`), as the third bullet of
`PUNTO 5`:

> _"**Darci le istruzioni per lanciarlo manualmente al bisogno.**"_

And asked for more than instructions on the call: _"tu che possibilita hai di
personalizzare l'aggiornamento?"_ … _"ci crei dei pulsanti da qualche parte. Va
bene, ancora meglio."_

## Why instructions are not enough

Aurel Mrruku's first answer was to hand over the anonymous-Apex scripts —
_"fate copia incolla, li lanciate su Anonymous"_ — and it did not work when they
tried it together:

> _"Se non ha cambiato interfaccia … ah oddio, si, l'ha cambiato."_
>
> _"**Bene, non l'ha fatto.** Devo capire che cosa si deve installare."_

He then ruled the script route out himself, on the risk, not the mechanics:

> _"vi devo creare due pulsanti per forza, altrimenti rischiamo di sbagliare quei
> script"_ · _"**ho sbagliato anch'io un paio di volte con gli script**, copia
> incolla, non capisci quale script fa cosa."_

## What was promised

> _"molto probabilmente **entro il 18** ti preparo anche quei pulsanti."_
>
> _"Te li metto nella homepage … ti metto una sezione **sincronizza con Mexal**, ti
> scrivo sincronizza prodotti, sincronizza articoli, sincronizza clienti,
> sincronizza fatture scadenziario."_

Plus documentation — _"poi vi do anche una documentazione"_ — and the permission
question was left as an assumption: _"vedo i permessi su admin e admin possono
rannare il job."_

## What exists as of this sweep

🟢 **Commit `f2a3294`, Anita Aga, 2026-11-16 14:28 CET, on `DevAnita16` only** —
_"Changed the Home Page added the custom component for the sync with Mexal"_:
a `mexalSyncPanel` LWC with two Jest specs, a `salesHomeTemplate` Aura component,
`MexalSyncController.cls` (≈400 lines), the `Getting_Started_Home` flexipage, a
utility-bar change, a `Full_Permission` addition and three home-page reports.

🔴 **It is not on `DevMain`, not merged and not deployed.** `DevMain` is at
`4478915`. So on the day the client was told he would have buttons, the buttons
exist on one developer's branch and not in the org.

⚠ `MexalSyncController.cls` is new Apex with **no Apex test class**. Recorded
here as state, per the standing instruction; **not acted on**. See
[OI-64](OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md) and
[OI-66](OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md).

## Also owed from the same point

**Sabatino Rinaldi asked for the final job times by mail**, so the client's own
nightly procedures do not collide with them:

> _"quando poi con Fabrizio ti sei accordato e avete stabilito bene i job, **manda
> una mail con gli orari precisi**, cosi evitiamo di accavallarci, perche noi ne
> facciamo abbastanza poi di questi di notte."_

Nothing in this sweep records that mail sent. It matters because the collision is
what broke the syncs in the first place — see
[the sync window](../The%20Mexal%20sync%20window%20and%20the%20year%20boundary.md).

## Also asked, same breath

Fabrizio Paganelli wants the standard components off the home page: _"magari Aurel
mi elimini tutto quello che c'e qui che vedo adesso."_ Aurel Mrruku pushed back on
the recent-records list and agreed to the rest. Tracked with the home page in
[OI-364](OI-364%20Agents%20cannot%20see%20the%20home%20page%20or%20the%20calendar%20in%20production.md).

## 🟢 2026-11-17 - the buttons are merged, one day before the promise

**`f2a3294` reached `DevMain` in pull request #128 at 10:15 CET**, merged by
`aureliii`. What yesterday sat stranded on `DevAnita16` is now on the integration
branch, a day ahead of the **18 November** commitment:

- `mexalSyncPanel` LWC — `.html`, `.js` (169 lines), `.css` (164 lines), meta, and
  **two Jest specs** (`mexalSyncPanel.test.js`, 258 lines;
  `mexalSyncPanelUnauthorized.test.js`, 28 lines);
- `MexalSyncController.cls` — **400 lines**;
- `salesHomeTemplate` Aura component and the `Getting_Started_Home` flexipage that
  hosts the panel;
- `LightningSales_UtilityBar` and `standard__LightningSales` app changes, three
  home-page reports, and additions to the `Agente` profile and the `Agente` and
  `Full_Permission` permission sets.

🔑 **The unauthorized-path Jest spec is the interesting one.** It says the panel was
built with a permission check rather than on the assumption Aurel Mrruku voiced on
the call — _"vedo i permessi su admin e admin possono rannare il job"_ — so the
question of who may press the buttons appears to have been answered in code.
⚠ Which permission it tests, and whether the client's `Amministrazione pienissimo`
user holds it, was **not** verified in this run.

🔴 **It is still not deployed.** `DevMain` is at `92899c3`; nothing here shows a
production deployment, and the client has buttons only when the 18/11 release goes
in. The promise was _"entro il 18"_, so this is on track, not complete.

⚠ `MexalSyncController.cls` is **400 lines of new Apex with no Apex test class**,
now on the integration branch. Recorded as state per the standing instruction;
**not acted on**. See
[OI-64](OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md),
[OI-66](OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md) and
[the deploy risk](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md).

### Still owed from the same point

- 🔴 **The documentation** — _"poi vi do anche una documentazione"_. No trace.
- 🔴 **The mail to Sabatino Rinaldi with the exact job times**, so the client's own
  nightly procedures do not collide with the 05:00 round. Asked on 16/11; **no such
  mail was sent in this window**, and the mailbox was read only — nothing here
  sends it.

## 🟢 2026-11-18 - deployed to production, and the client has been told

**The panel is in production and the promise `entro il 18` was kept. Two things the
same commitment carried are still missing.**

### What happened

The Mexal home-page bundle was **not** in the first deploy of the day. Validation
`0AfSW000001MafN0AS` of the whole `DevMain` delta against **Pienissimo Prod**
(`RunLocalTests`) passed 40/40 components and 176/176 tests but returned **74.55%**
org-wide coverage — **65 covered lines short of the floor** — because
`MexalSyncController` had 211 lines at 0%. The non-Apex subset went in without it
(`0AfSW000001Malp0AC`, 13:43:49Z).

On Aurel Mrruku's request a test class was then written, and the bundle followed:

| | |
| --- | --- |
| Validation | `0AfSW000001MbMv0AK`, `RunLocalTests`, **186/186 tests, 76.36%** |
| Quick deploy | **`0AfSW000001MbQ90AK`**, **2026-11-18 14:23:28Z**, 10/10 components |
| Contents | `MexalSyncController` + its test, `mexalSyncPanel`, `Getting_Started_Home`, `salesHomeTemplate`, the three `Home_*_Donut` reports, the Sales app with the Admin home assignment, and `Full_Permission` with the class grant |
| Verified after | the class grant present, the home page modified at 14:23Z |

🟢 **The client was told the same afternoon.** The release mail of 14:40:26Z lists
_"Sincronizzazione: è stato creato un componente custom nella home page (visibile
esclusivamente agli amministratori) per supportare la sincronizzazione di articoli,
clienti, fatture e scadenziario"_ → [OI-374](OI-374%20The%2018%20November%20release%20mail%20tells%20the%20client%20the%20order%20contract%20flow%20is%20live.md).

⚠ **`MexalSyncControllerTest` was written by the developer's own session on his
explicit request** — _"cover the test classes and deploy the rest"_. It is recorded
here as state. Eleven tests, 11/11 in UAT, the controller at **92%** (194 of 211
lines). See [the deploy risk](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md),
which the developer updated himself in `1a46bf2`.

### 🔴 Still owed from the same point

Unchanged, a second day:

- **The documentation** — _"poi vi do anche una documentazione"_. No trace in mail,
  Slack or Drive.
- **The mail to Sabatino Rinaldi with the exact job times**, so the client's own
  nightly procedures do not collide with the 05:00 round
  ([OI-334](OI-334%20The%20Mexal%20sync%20frequency%20is%20undecided%20and%20no%20job%20is%20scheduled%20in%20production.md)).
  The release mail does not carry them.

⚠ **Which user can press the buttons is still not verified against the org.** The
panel is gated on `Full_Permission` — the Jest specs test the authorized and
unauthorized paths, and the deploy granted the class on that permission set — but
whether the client's `Amministrazione pienissimo` user holds `Full_Permission` was
**not** checked in this run, and the mail promises the component to administrators.

**Status stays `in-progress`:** the build is live, the two commitments around it are
not met, and nobody has watched the client press a button.
