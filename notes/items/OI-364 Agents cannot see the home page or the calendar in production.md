---
id: OI-364
type: open-item
status: open
owner: Aurel Mrruku
with: Elena Spini, Marco Montesi
org: both
raised: 2026-11-11
updated: 2026-11-12
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
