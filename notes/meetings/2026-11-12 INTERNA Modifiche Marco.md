---
id: meeting-2026-11-12-interna-modifiche-marco
type: meeting
status: resolved
owner: Elena Spini
with: Aurel Mrruku
org: ROMI
raised: 2026-11-12
updated: 2026-11-12
depends_on: []
blocks: []
source: Drive 1wP_soQRlhOFTjRWB5rcz0mUGNe00vWRdmJ5q_U8b9_s
---

# 2026-11-12 - INTERNA Modifiche Marco

**Forty-six minutes at the end of the day, Aurel Mrruku and Elena Spini alone,
going through the change requests Elena Spini collected during the tutor training
of 11/11. Each was sized on the spot. The session produced the client-facing recap
sheet sent out two hours later — and it opened with the news that the man who
asked for all of them is leaving.**

## Attendees

- **Aurel Mrruku** (ROMI)
- **Elena Spini** (ROMI)
- 🔴 **Nobody from Pienissimo.**

## Sources

| | |
| --- | --- |
| Transcript | Drive `1wP_soQRlhOFTjRWB5rcz0mUGNe00vWRdmJ5q_U8b9_s`, 33,944 chars, **read in full** |
| Duration | **00:46:31** |
| Recording | ⚠ none in the folder |
| Output | `Pienissimo_Recap_Modifiche_2026-11-12.xlsx` (`1D2hnr7PAysXpPR-37P6pw44dcgF7sbiV`), created 18:37Z, sent to the client 18:43Z |

## Marco Montesi is leaving

🔴🔑 Elena Spini, in the first two minutes: _"oggi hanno detto che **Marco se ne
va**. che e quello che ha chiesto le modifiche."_ And on whether the requests
could therefore be dropped — Aurel Mrruku: _"Secondo me se te li dimentichi non
nessuno si ricorda"_; Elena Spini: _"purtroppo c'era anche Fabrizio ahime, quindi
siam fregati."_ → [OI-357](../items/OI-357%20The%20client%20commercial%20lead%20and%20the%20web%20counterpart%20are%20both%20leaving.md)

## The deferral

🔑 **The changes were pushed to next week on the spot**, and the client was told so
the same evening. Elena Spini: _"io gli dico queste cose le facciamo ma settimana
prossima perche tanto sono cose inutili"_, because the morning had gone to the
migration. Aurel Mrruku objected to doing any of it now — _"mettiamo anche delle
priorita perche alcune sono delle cavolate che posso fare tranquillamente dopo il
deploy"_ — and gave the estimate: _"un paio di giorni di fa\[re\] tutto. Settimana
prossima pero."_

## The one that was nobody's request and is now a job

🆕🔴 **The org is not set to Italian formats.** Dates render American in the
Community and on the tranche screens, the decimal and thousands separators are
reversed, and the Community prints the euro symbol without a space. Aurel Mrruku:
_"devo abilitare il formato italiano nella ORG. … non e una cosa molto difficile. I
problemi li abbiamo poi se abbiamo fatto delle cose custom"_ — naming the
`Aggiungi prodotti` screen as the place to check. Both asked how it was missed:
_"**Come mai ci e sfuggito sta cosa?**"_ · _"considerando che usano un sal\[es\]force
in italiano potevamo arci\[varci\]. … Hanno anche ragione."_
→ [OI-358](../items/OI-358%20The%20org%20is%20not%20set%20to%20Italian%20date%20and%20number%20formats.md)

## The rest, as sized on the call

| Request | Verdict on the call |
| --- | --- |
| `Fonte lead` → `Origine del lead` | 🔴 **Not possible** — standard label, not translatable. The **picklist values can** go to Italian, from the list Marco Montesi sent. _"Gli possiamo dire che non si puo."_ |
| Categoria / Sottocategoria values | 🟢 Realign to the client's own file; `Altri servizi` and `Generica` to be removed, `Libro` and `Pacchetti` added. 🔑 Values _"ce li avevano gia dati"_ and ROMI had lost them at the bottom of the sheet |
| Primary quote visible in list view and compact layout | 🟢 Can be done |
| Note object on Account | 🟢 Standard Note object, Account only. Aurel Mrruku had been told before and forgotten: _"l'ho dimenticato, chiedo scusa"_ |
| Order shown in the Account's Asset related list | 🟢 Standard related-list field |
| Total of all columns in the quote related table | 🔴 **Not possible** — standard related list. The `Grand Total` in the header already exists and satisfies it |
| Running total while adding products | 🟡 Possible, _"mi spendo un paio di giorni"_ — dedicated development |
| Tranche amount live while assigning products | 🟡 More feasible, but needs recalculation on delete and move: _"E un casino, un mal di testa"_ |
| CC and multiple recipients on the quote mail | 🔑 **It was built, then removed at the client's request, and is now wanted again.** Aurel Mrruku: _"Han detto no non lo vogliamo cosi."_ → after go-live, in maintenance |
| Agents cannot see the Home page or the calendar | 🟢 Calendar is a profile tab permission. 🔴 The Home page _"e una pagina che dobbiamo costruire"_, undefined. ⚠ _"Non abbiamo mai parlato del calendario"_ → [OI-364](../items/OI-364%20Agents%20cannot%20see%20the%20home%20page%20or%20the%20calendar%20in%20production.md) |

## Two further findings

- 🔴 **There is no logo in production.** Elena Spini noticed it on screen; it was
  in the manual steps and never done → [OI-301](../items/OI-301%20Three%20production%20manual%20setup%20steps%20are%20outstanding.md).
- 🟡 **A WooCommerce link bug was reported and argued down, not resolved.** Elena
  Spini: _"non si e aggiornato il link qua … questo e il test e l'abbiamo fatto,
  quindi non dire impossibile perche l'abbiamo fatto."_ Aurel Mrruku demonstrated
  live that both an old and a new link exist on the record and concluded she had
  read the old one. It ended _"facciamo finta che mi hai quasi convinto"_ —
  ⚠ **no reproduction, no fix, no record.**

## Said in passing, and material

- 🔑 On Fase 2: _"stiamo gia sviluppando"_ R0 while _"non hanno accettato ancora la
  fase due"_, and Elena Spini's reading of the exposure — _"questa parte comunque
  l'hanno accettata, quindi … c\[e\] la devono pagare"_, while the scadenziario part
  _"magari la smantellano"_. Approval was expected **13/11**.
- 🔑 On the ticket migration: _"anche la discussione della migrazione dei biglietti
  sara un mal di testa … **Faranno dei casini.**"_
- 🔴 Aurel Mrruku objected to ROMI taking on the Salesforce-ID extraction for the
  client: _"non so perche ti sei preso il carico. … **lo devono fare loro.** …
  Invece il contrario, tu gli devi dare loro la struttura. ID li devono trovare
  loro."_ Elena Spini had accepted it to calm the room —
  [OI-361](../items/OI-361%20Pienissimo%20Live%20attendance%20cannot%20be%20recorded%20in%20Salesforce.md).
- The `Anagrafica Articoli` mail that arrived mid-call was read live and diagnosed:
  the client had not set `Numero tranche` on a `plus` product, which the new
  mandatory-tranche rule now rejects →
  [OI-329](../items/OI-329%20Tranches%20must%20be%20mandatory%20and%20the%20quote%20PDF%20blocked%20without%20them.md).
