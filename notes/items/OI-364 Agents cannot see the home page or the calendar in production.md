---
id: OI-364
type: open-item
status: open
owner: Aurel Mrruku
with: Elena Spini, Marco Montesi
org: both
raised: 2026-11-11
updated: 2026-11-18
depends_on: []
blocks: []
severity: normal
source: notes/meetings/2026-11-12 INTERNA Modifiche Marco.md
---

# OI-364 - Agents cannot see the home page or the calendar in production

**The commercial agents found at training that they can see neither the Salesforce
calendar nor any home page. The calendar is a profile permission and is promised
for the start of next week. The home page does not exist — it was never designed,
and the man who asked for it is leaving.**

## What the users found

Elena Spini, reading her training notes on the
[12/11 internal call](../meetings/2026-11-12%20INTERNA%20Modifiche%20Marco.md):

> _"non so per quale ragione **Valentina e Martina, gli agenti, non vedono la pagina
> iniziale ne il calendario** … a parte il tab \[non riescono a\] cercare, quindi non
> ha la visibilita"_

On why they want the calendar: _"loro vanno in lead, i commerciali dico, fanno tipo
evento, tipo chiamare o meeting con il cliente, lo segnano qua."_

🔑 Nobody specified it. Aurel Mrruku: _"**Non abbiamo mai parlato del calendario**
Elena."_ Elena Spini: _"E lo so, pero l'\[h\]a\[n\]no trovato. Lo vogliono."_ Aurel
Mrruku: _"Eh, se l'hanno trovato lo vogliono e mettiamo."_ And on who showed it to
them: _"non so chi gliel'ha fatto vedere il calendario. **Io no, di certo.**"_

## The two halves

| | State |
| --- | --- |
| **Calendar** | 🟢 a profile tab and permission question — _"li deve mettere su i tab praticamente a livello di profilo"_. Committed for **start of next week** |
| **Home page** | 🔴 **does not exist and is not specified** — _"e una pagina che dobbiamo costruire"_, _"non \[hanno\] deciso che cosa vogliono"_. Deferred: _"questo sara un passo ancora successivo"_ |

## What the home page was asked to contain

🔑 Marco Montesi's mail of **2026-11-11 15:32:27Z** (`Visualizzazione Pagina
Principale`), the only written specification there is:

> _"come ha chiesto Martina stamattina, sarebbe utile capire com'e possibile avere
> una visualizzazione rapida e intuitiva nella **Pagina Iniziale** in merito alla
> situazione dei **lead** e delle **opportunity**. In questo modo i tutor
> eviterebbero di andare a vedere ogni volta le relative pagine di Lead e
> Opportunity e in piu si ritroverebbero con una sorta di **coda di lavoro** da
> poter consultare rapidamente"_

It is row 21 of [`Modifiche flussi Sales`](OI-344%20The%20client%20sent%20sixteen%20Sales%20flow%20changes%20and%20none%20is%20triaged.md).

🔴 **Marco Montesi is resigning**
([OI-357](OI-357%20The%20client%20commercial%20lead%20and%20the%20web%20counterpart%20are%20both%20leaving.md)),
and the request originates with Martina, an agent, relayed through him. Nobody has
been named to specify it once he goes.

## Committed to the client

Row 8 of `Pienissimo_Recap_Modifiche_2026-11-12.xlsx`, 12/11 18:43Z:

> _"Home page e calendario non visibili agli agenti"_ — **Da implementare**,
> _"Verifichiamo permessi e tab a livello di profilo per rendere visibile il
> calendario. **La home page vera e propria sara da definire in una fase
> successiva.**"_ · **Calendario: inizio settimana prossima. Home: da definire**

## Also missing on the same surfaces

🔴 **There is no logo in production.** Noticed on the same call — Elena Spini,
_"non c'e logo sulla produzione"_; Aurel Mrruku, _"ovviamente non c'e … l'avevamo
gia, era nei **manual step** da fare"_. Tracked at
[OI-301](OI-301%20Three%20production%20manual%20setup%20steps%20are%20outstanding.md).

## What is owed

- The calendar permission, before or with the 16/11 start.
- A decision on who specifies the home page now, and whether it is Fase 1 or Fase 2
  under ROMI's own triage rule (_"le modifiche di layout e di campi le facciamo in
  Fase 1, il resto va in una Fase 2 successiva"_).

## 2026-11-16 - a home page was built the same afternoon, on a branch

🟢 **Commit `f2a3294`, Anita Aga, 2026-11-16 14:28 CET, on `DevAnita16`** —
_"Changed the Home Page added the custom component for the sync with Mexal"_:

- `mexalSyncPanel` LWC with two Jest specs, plus a `salesHomeTemplate` Aura
  component and its design and CSS
- `MexalSyncController.cls`, ≈400 lines of new Apex
- the `Getting_Started_Home` flexipage, a `LightningSales_UtilityBar` change and the
  `standard__LightningSales` app
- three home-page reports: **Activity, Lead Source and Pipeline donuts**
- a `Full_Permission` addition

🔴 **It is not on `DevMain`, not merged and not deployed.** `DevMain` is at
`4478915`. So the home page the agents could not see this morning exists on one
developer's branch by the evening of the same day, and not in the org.

⚠ `MexalSyncController.cls` is new Apex with **no Apex test class**. Reported as
state, per the standing instruction; **not acted on**.

**What the client asked for on the call, beyond the sync buttons:**

- 🔑 **strip the standard components**: _"tutte queste cose che ci sono adesso le
  puoi anche eliminare … magari Aurel mi elimini tutto quello che c'e qui che vedo
  adesso."_ Aurel Mrruku defended only the recent-records list — _"sono praticamente
  record recenti, quello che ti aiuta se vuoi riprendere il lavoro da dove sei
  partito"_ — and agreed to the rest
- the **Mexal sync section** itself →
  [OI-370](OI-370%20The%20client%20cannot%20run%20the%20Mexal%20syncs%20by%20hand.md)

🔴 **The work-queue request is still untriaged.** The row on
`Modifiche flussi Sales` asking for a home-page section grouping lead requests and
opportunities _"cosi si crea una coda di lavoro che il tutor puo seguire
quotidianamente"_ has **no verdict** in the `Lavorato` column as of 16/11 15:50Z —
see [OI-344](OI-344%20The%20client%20sent%20sixteen%20Sales%20flow%20changes%20and%20none%20is%20triaged.md).
Nothing in this window mentions the agent calendar.

## 🟢 2026-11-17 - the home page now exists in source

The half of this item that was _"una pagina che dobbiamo costruire"_ has been
built. Merged into `DevMain` in **pull request #128** at 10:15 CET (commit
`f2a3294`, Anita Aga, 16/11):

- **`Getting_Started_Home.flexipage`** — 288 lines, the home page itself;
- **`salesHomeTemplate`** Aura component with its own `.css` and `.design`;
- **three home-page reports**: `Home_Activity_Donut`, `Home_Lead_Source_Donut`,
  `Home_Pipeline_Donut`;
- the `mexalSyncPanel` component the client asked for →
  [OI-370](OI-370%20The%20client%20cannot%20run%20the%20Mexal%20syncs%20by%20hand.md);
- changes to the **`Agente` profile** and the `Agente` and `Full_Permission`
  permission sets, and to `standard__LightningSales` and its utility bar.

🔑 **So the home page was specified by building it**, not by the client deciding
what they wanted — _"non \[hanno\] deciso che cosa vogliono"_ remains true, and the
three donut reports are ROMI's own choice of content. ⚠ Whether this is what the
agents wanted is untested, and **the man who asked for it is leaving** →
[OI-357](OI-357%20The%20client%20commercial%20lead%20and%20the%20web%20counterpart%20are%20both%20leaving.md).

### 🟢 And the calendar half landed too

The `Agente` profile gained exactly one thing in this window:

```xml
<tabVisibilities>
    <tab>standard-Event</tab>
    <visibility>DefaultOn</visibility>
</tabVisibilities>
```

and the `Agente` permission set gained `tabSettings` for **`standard-Event`** and
**`standard-home`**. 🔑 **So both halves of this item are now built**: the calendar
is the `standard-Event` tab turned on by default for agents, and the home tab is
granted alongside it. This was the half actually committed to the client for
_"start of next week"_.

🔴 Not deployed. Agents see neither until the 18 November release goes in.

## 🟢 2026-11-18 - both halves are in production

The `Getting_Started_Home` flexipage, the `salesHomeTemplate` Aura component, the
three `Home_*_Donut` reports and the Admin home-page assignment went to
**Pienissimo Prod** in quick deploy **`0AfSW000001MbQ90AK`** at **14:23:28Z**,
alongside the Mexal panel they host
([OI-370](OI-370%20The%20client%20cannot%20run%20the%20Mexal%20syncs%20by%20hand.md)). The
home page was verified modified at 14:23Z.

The calendar half went in earlier, with the non-Apex subset
(`0AfSW000001Malp0AC`, 13:43:49Z), as part of the `Agente` and `Full_Permission`
permission sets.

### 🔴 The calendar grant was lost for about two minutes, then restored

Between the two, agents briefly lost more than they gained. The branch's `Agente`
permission set carries the Event and Task grants **read-only** and `standard-Event`
as `Available`, while production had them **editable** and `DefaultOn`. The deploy
omitted those entries on the assumption that omitted permission-set entries survive;
they do not. Production lost **15 Event/Task field grants and the Event tab**.

Restored at **13:45:39Z** with production's pre-deploy permission set plus
`Asset.Ordine__c` (`0AfSW000001Map30AC`), and verified by SOQL: 15 grants back and
editable, `standard-Event` `DefaultOn`. Exposure was about two minutes, inside the
working day, on the third day of live use. No user report exists either way.

🟢 **The source was then aligned to production** — `Agente` and `Full_Permission`
were retrieved from Prod into `force-app` and committed in `1a46bf2` — so
redeploying either file no longer revokes anything. The `Agente` **profile** remains
a standing deployment exclusion; its only change here, the Event tab, is already
granted by the permission set.

⚠ **The home page is still ROMI's own choice of content.** Nothing in this window
specifies what the agents wanted, the three donut reports were picked by ROMI, and
the man who asked for the page is leaving
([OI-357](OI-357%20The%20client%20commercial%20lead%20and%20the%20web%20counterpart%20are%20both%20leaving.md)).
The client was told the sync component exists; **the home page itself is not
mentioned in the release mail** →
[OI-374](OI-374%20The%2018%20November%20release%20mail%20tells%20the%20client%20the%20order%20contract%20flow%20is%20live.md).

**Both halves are deployed. Nobody has confirmed an agent can see either.**
