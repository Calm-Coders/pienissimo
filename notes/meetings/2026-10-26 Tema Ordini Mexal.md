---
id: meeting-2026-10-26-tema-ordini-mexal
type: meeting
status: resolved
owner: Elena Spini
org: both
raised: 2026-10-26
updated: 2026-10-26
depends_on: [OI-284, OI-276, OI-290]
blocks: [go-live]
source: meetings/2026-10-26-tema-ordini-mexal-transcript.it.md
---

# 2026-10-26 Tema Ordini Mexal

**The first meeting in this project's record attended by Kreosoft, and it
answered [OI-284](../items/OI-284%20The%20listino%20sconto%20and%20netto%20mapping%20for%20Mexal%20orders%20is%20undefined.md)
in nine minutes. It also opened a migration scope nobody had written down —
Lead and Referenti data — and the client's own project manager refused to own
it.**

- **When:** Monday 2026-10-26, 10:59 CET, **00:32:14**.
- **Who:** Aurel Mrruku, Elena Spini (ROMI); Fabrizio Paganelli, Elisa
  Migliano (Pienissimo); **Mirko Merendi (Kreosoft)**.
- **Source:** full raw transcript, drilled once —
  [the preserved record](../../meetings/2026-10-26-tema-ordini-mexal-transcript.it.md)
  (Drive `1Z-LX9HID2bDmjZvad-FmS0bZByuaB1ZTx_yA-cZzB98`, 28 KB).
- ⚠ Sabatino Rinaldi was expected and did not attend — Fabrizio Paganelli,
  `00:17`: _"C'è Sabatino stamattina che non ho visto."_

## 1. The Mexal discount mapping, answered

Mirko Merendi, at `00:05:00`, in one sentence:

> _"Mixal [Mexal] funziona così, c'ha il prezzo e c'ha lo sconto e poi lui
> ricalcola il valore della riga."_

So `prezzo` carries the **list price** and `sconto` carries the discount; Mexal
derives the line value. Two forms are accepted, and the sign distinguishes them:

> _"o te gli passi lo sconto a valore … Basta che te passi lo sconto con il meno
> davanti … €2000 di prezzo di listino, €1500 è il prezzo che gli fai al finale.
> Te gli metti nello sconto meno 500 e lui ti fa tutto c[o]rrettamente."_
>
> _"Se devi passare la percentuale basta che passi il numero senza il meno."_

Aurel Mrruku chose the amount form — _"se ti passo sconto valore ancora
meglio"_ — which **settles the 22/10 disagreement in his favour**, and without
the argument being reopened: Fabrizio Paganelli had wanted percentages and did
not press it.

🔴 **The constraint that matters, stated twice and confirmed by the client:**

> Mirko Merendi: _"lo sconto a valore va sulla quantità, quindi se ci sono due
> quantità e c'è lo sconto di €400 **devi mettere -200, devi dividere per le
> quantità**, hai capito?"_ … _"se è meno €1500 e ce ne sono tre, devi dividere
> per tre."_
>
> Fabrizio Paganelli, restating it back to be sure: _"se tu passi uno sconto
> totale sulla riga di €1500, quello sconto totale quando lo passi a Mexal **lo
> devi dividere per le quantità** sempre di quella riga. Altrimenti dopo
> sbagliamo veramente a fatturare se non è così."_

**The value in the `sconto` field is per unit.** The sender divides; Mexal does
not. 🔴 The code shipped the same day does the opposite — see
[OI-287](../items/OI-287%20The%20Mexal%20line%20discount%20is%20sent%20as%20a%20line%20total%20instead%20of%20per%20unit.md).

⚠ Aurel Mrruku's reply is the likely origin of the inversion:

> _"Poi sarà uguale per me perché io il prezzo di listino prezzo netto ce l'ho
> moltiplicato per quantità, quindi faccio la stessa cosa anch'io. Quindi anche
> lo sconto è praticamente moltiplicato per quantità."_

Nobody contradicted it, and the exchange moved on.

### Rounding: no mechanism, and a tolerance the client granted aloud

Aurel Mrruku raised two-decimal precision with round-half-up against Mexal's
third-decimal behaviour and asked whether rounding is configurable:

> Mirko Merendi: _"No, gli arrotondamenti non si toccano in Mex[al]."_

Both sides then accepted the exposure explicitly — this is a **decision, not an
omission**:

> Mirko Merendi: _"Potrebbero avere differenza di un centesimo … non credo che
> sia tutto sto problema."_
>
> Fabrizio Paganelli: _"quando facciamo la fattura, se c'è un centesimo non me
> ne frega niente. **L'importante è che non si fermino gli ordini.**"_

⚠ Aurel Mrruku's worked case is unanswered: a €1,000 discount over three units
is 333.33… per unit, _"periodico"_, so the cent is lost by construction.

### Quantities above one are not rare

🔑 Mirko Merendi estimated _"al 95% loro hanno sempre quantità uno"_; **Fabrizio
Paganelli contradicted him immediately** — _"abbiamo anche spesso diversi casi
dove abbiamo le quantità due"_, and _"magari è anche tre"_. So the condition
under which OI-287 mis-invoices is one the client says occurs often.

⚠ **The field name is still not in this record.** Aurel Mrruku asked for it —
_"Riesci a mandarmi il campo da valorizzare a livello di riga d'ordine?"_ — and
Mirko Merendi **pasted an example into the meeting chat**, not into the call:
_"questo è un esempio … Contr[o]l C."_ The Google Meet chat is not captured in
the transcript, so **what he sent is unrecorded here**. The decimal form came
separately by mail the same day (comma, two decimals max).

## 2. Lead and Referenti migration — new scope, and no owner

Aurel Mrruku opened the call needing the Mexal customer code on the Referenti
so a Contact can be joined to its Account; the client's existing extract has a
Zoho code in column O instead:

> Fabrizio Paganelli: _"c'è un campo dove c'è nella colonna O il nome azienda
> che in realtà adesso come adesso è un codice di X cifre."_

🟢 **Agreed mechanically**: Fabrizio Paganelli supplies the company list from
Zoho carrying the Mexal code, and the Referenti list carrying the Mexal code —
_"facciamo in modo che nei referenti c'è il codice di Mexal."_

🔴 **But he refused to own the data**, three times:

> _"io su questi aspetti qua non so nulla. Bisogna che parliate con Sabatino."_
>
> _"i dati fatevi dare da Sabatino … ci penserà Sabatino a estrapolarli."_
>
> _"se rispondo io mi mancano delle informazioni, per cui corriamo il rischio
> che facciamo casino."_

⚠ And he named a second problem: the ROMI data model has **fields Zoho does not
hold** — _"questi qui sono campi che sono stati aggiunti e io su Zoo [Zoho] non
ce li ho e io non ve li do vuoti dopo."_

⚠ Elena Spini's own stated worry, unresolved in the call: _"la difficoltà dei
referenti sarà poi quella di associare il referente all'ID di account
corretto."_

🟢 **She acted the same day**: mail `1a1786a9c1a23757`, 13:33:24Z, to Sabatino
Rinaldi, cc Fabrizio Paganelli, `amministrazione@` and Aurel Mrruku, pointing at
[the data model workbook](../The%20Campi%20Oggetti%20Flussi%20e%20Utenti%20workbook.md)
and asking for Lead and Referenti data. See
[OI-290](../items/OI-290%20Lead%20and%20Referenti%20migration%20data%20is%20owed%20by%20the%20client.md).

🔑 Also established: _"referenti uguale contatti"_ — the client's term for a
Contact — and Elena Spini's account that the Lead and Referente field sets were
reviewed with Sabatino Rinaldi previously but **no data extract was ever
seen**: _"abbiamo rivisto i campi con lui, non abbiamo mai visto un'estrazione
di dati."_

## 3. The dummy editions drifted a third time

[OI-276](../items/OI-276%20Dummy%20import%20editions%20are%20needed%20to%20load%20historical%20orders.md)
now has a third candidate mechanism. Aurel Mrruku offered the `old` flag again
— _"vuoi che ti metto un flag edizione vecchia? Così non genero il link"_ — and
Fabrizio Paganelli **did not remember it**: _"sinceramente non mi ricordo il
tema del flag."_ He described instead an _"edizione bidone"_ bounded by dates:

> _"creavo un'edizione bidone con la data dell'ordine antecedente alla data
> inizio del p[i]enissimo live 26."_

🟢 Aurel Mrruku accepted the date approach and **named the operative
constraint**, which is new and is the useful part:

> _"L'importante è che **la data non sia nel futuro**, perché altrimenti
> marketing prenderà il link."_

⚠ Nothing was chosen: _"dopo magari ci risentiamo su come devo creare queste
mappature."_ Three variants now coexist — dummy editions, an `old` flag, a
past-dated _edizione bidone_ — and **none was withdrawn.**

## 4. Products: the manual round trip closed

🟢 Fabrizio Paganelli had done the article registry work and sent it to Kreosoft
before the call — _"ho fatto quel lavoro su anagrafica articoli e l'ho già
mandato Mirko affinché faccia l'update su M[e]xal"_ — and Mirko Merendi
committed to it that day: _"In giornat[a] te lo faccio."_ 🟢 Aurel Mrruku
confirmed UAT is ready: _"Ho già abilitato tutti i prodotti"_, and told him to
proceed once the articles exist in Mexal. Completed by mail at 15:23Z/15:54Z the
same day.

⚠ **Still nothing says the product synchronisation flows are switched back on** —
the 23/10 finding stands, and this round trip was manual on both sides.

## 5. Access: Elisa Migliano can log in, on a shared account

~10 minutes (`00:19`–`00:28`) were spent getting Elisa Migliano into Salesforce
through Proton Pass. Two findings, recorded without any credential value:

- 🟢 **She can log in** — this closes a question open since 19/10. ⚠ But **not
  on her own account**: she uses the same user as Fabrizio Paganelli,
  `amministrazione@` — _"l'account è lo stesso di Fabri"_ — so UAT actions by
  either of them are indistinguishable in the audit trail. Nobody raised that.
- Credentials are held in **Proton Pass** with a shared vault and a passkey
  created on the 9th. ⚠ Elisa Migliano is migrating entries out of Zoho Vault,
  and Elena Spini flagged an unverified free-tier limit.

## What this changed

- [OI-284](../items/OI-284%20The%20listino%20sconto%20and%20netto%20mapping%20for%20Mexal%20orders%20is%20undefined.md)
  — the mapping is **defined**; the row's question is answered.
- 🆕 [OI-287](../items/OI-287%20The%20Mexal%20line%20discount%20is%20sent%20as%20a%20line%20total%20instead%20of%20per%20unit.md)
  — the built send contradicts the answer, and it is in production.
- 🆕 [OI-290](../items/OI-290%20Lead%20and%20Referenti%20migration%20data%20is%20owed%20by%20the%20client.md)
  — Lead and Referenti migration data, owed by Sabatino Rinaldi, no date.
- [OI-276](../items/OI-276%20Dummy%20import%20editions%20are%20needed%20to%20load%20historical%20orders.md)
  — third mechanism, plus the "date not in the future" constraint.
