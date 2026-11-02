---
id: meet-2026-11-02-tema-contratti-woocommerce
type: meeting
status: resolved
owner: Aurel Mrruku
org: both
raised: 2026-11-02
updated: 2026-11-02
depends_on: [OI-304]
blocks: []
source: meetings/2026-11-02-tema-contratti-woocommerce-transcript.it.md
---

# 2026-11-02 Tema Contratti WooCommerce

**The meeting [OI-304](../items/OI-304%20Contracts%20for%20WooCommerce%20stage%20sales%20are%20not%20generated.md)
was deferred to. It produced a design, a date, a man-day figure and a commercial
classification: the stage-sale contract flow becomes release R0 of Fase 2, due in
production before Pienissimo Live on 24-26 November.**

09:32 CET, **00:49:50**, client meeting. Drilled from the full raw transcript
(33,836 bytes), read once in four slices.

## Attendees

Aurel Mrruku, **Elena Spini** (late, ~00:02), **Elisa Migliano**, **Fabrizio
Paganelli**. 🔴 **Sabatino Rinaldi absent** — _"Adesso oggi sabatino non c'è"_.

⚠ Speaker labels are unreliable in this project; attribution below is
reconstructed from content. The transcript also garbles names: `Arel` for Aurel,
`Elen`/`Elena` for Elisa in the greeting, `Maxal`/`Maxile`/`Exal` for Mexal.

🔑 **This answers the 30/10 question of which 09:30 invite Aurel Mrruku attended**
— this one, not the `Allineamento` with Fabrizio Mastracci sent two minutes apart.

## The flow as designed

Aurel Mrruku, in his own words, end to end:

> _"da palco viene venduto il prodotto, il prodotto scende su [Sales]force,
> [Sales]force fa scendere su [Mexal] l'ordine … dopo che [Mexal] ha inserito
> l'ordine, dà la risposta a Sales Force. Sales Force genera un contratto
> cartaceo … il file PDF deve essere inviato in automatico … al cliente. Il
> cliente firma e arriva il contratto firmato e viene tracciato su [Sales]force."_

The build, as he described it:

- Today the PDF is generated **from the Quote** — _"il PDF si genera … prendendo i
  dati dalla quot, quindi dal preventivo"_, and the whole generation chain is bound
  to the Quote entity.
- So the work is **a second template pointing at the Order instead of the Quote**,
  then an automation that sends it through DocuSign. Prerequisite: confirming the
  Order carries every field the template needs.
- **The trigger is the Mexal order id**, not the invoice — _"appena l'ordine va su
  [Mexal] e [Mexal] ci dà l'ID dell'ordine … in quel momento"_. Elena Spini
  corrected him mid-sentence from "preventivo" to "ordine" and he accepted.
- 🆕 **A resend button**, visible only after a failed send — _"ti metto forse un
  pulsante che faccio rinvio solo nel caso in cui c'era un errore prima"_.
- **Order statuses do not change**: _"gli stati d'ordine cambiano quando arriva lo
  scadenziario"_.

🟢 **The payment question was settled on the call.** Elena Spini asked whether to
wait for the invoice or its payment; Fabrizio Paganelli objected that some stage
customers pay by bank transfer, and **Elisa Migliano closed it**: _"Se ti passa
[Mexal] vuol dere che il cliente ha già pagato"_ — WooCommerce only forwards orders
in state `completato`. Elena Spini: _"la logica una volta che abbiamo l'ordine di
Mexal può partire"_.

## The Performance Plus tranche problem, and how it was avoided

The bundle component **does not handle `numero di tranche`** — that explosion only
exists on the Plus attivazione/rinnovo offer path. Aurel Mrruku described the code
change as _"completamente una logica nuova"_: block further products once a Plus
product is added, read the tranche count, generate that many elements and date
them.

🟢 **Fabrizio Paganelli proposed the cheaper route and it was taken**: instead of
one bundle-only Plus code, **create twelve of them — one per tranche, none
carrying a tranche count**. _"ne creo 12 di codici che possono essere utilizzati
solo nei bundle che non hanno le trance."_ Aurel Mrruku: _"funziona. Non devo fare
nessun intervento a livello di bundle."_

🟢 **And the exclusion he feared is already in place.** He shared his screen, built
a bundle against the client's existing code **`PLUS_B01`**, and read the result
back: _"sui bundle la posso scegliere, invece su le plus … non la posso scegliere …
quindi siamo già coperti"_. **No Salesforce change is needed for this part** —
see [OI-48](../items/OI-48%20Bundle-only%20article%20codes.md).

🔑 **A hard domain rule, stated for the first time: there are no mixed bundles.**
Fabrizio Paganelli: _"quando noi facciamo i bundle, in un bundle c'è solo la P+ …
oppure ci sono solo i corsi, non facciamo bundle misti … Se vogliono fare bundle
misti me lo dicono e faccio prima a dare le dimissioni."_

## Dates, and the pressure behind them

- **Not in the 16 November go-live.** Aurel Mrruku: _"questo non andrà il 16 live
  … il 19 te lo passo in produzione"_, because _"sono già andato in produzione con
  la prima parte … Non voglio rischiare che faccio casino su quello che c'è già"_.
- Fabrizio Paganelli pushed to **18 November** — _"Facciamo anche il 18, dai …
  almeno abbiamo qualche giorno in più per fare i test"_.
- 🔴 **The real constraint is Pienissimo Live, 24-26 November**, the next stage
  sale. Fabrizio Paganelli must **build the bundle on Monday 23 November** and
  wants certainty by then: _"noi ci dobbiamo attrezzare in modo tale che lunedì 23
  siamo sicuri che vada tutto"_.
- ⚠ **Whether Performance Plus will be sold at that event is unknown** —
  _"lo scopriremo il 24 di novembre la mattina, però secondo me sì … sono sicuro al
  99,99%"_.
- 🔴 Aurel Mrruku's own capacity warning: _"Mi servono una decina di giorni come
  minimo"_ for design, build, test and a separate production release, and on the
  go-live week _"forse avremo metà giornata per fare dei test e basta"_.
- 🔑 He states production already holds **_"il 90% delle cose"_** and that another
  production release follows **next week**.

## The commercial ruling

🔴 **Elena Spini declared it Fase 2, as the first release, on the call**: _"questo
però deve passare come primo rilascio della fase due, perché io queste giornate
poi le devo mettere da qualche parte. Noi abbiamo già finito tutte le giornate
possibili immaginabili."_ — the operational face of
[the margin decision](../decisions/Decision%20-%20new%20scope%20after%2026%20October%20goes%20to%20Fase%202.md).

⚠ **Fabrizio Paganelli agreed, but narrower than the documents record it**:
_"Sono d'accordo che lo devi aggiungere solo per la parte della Plus corsi."_ The
two Fase 2 decks price R0 for **both** standard courses and Performance Plus. **The
gap was not discussed.** See
[the Fase 2 offer](../The%20Fase%202%20offer.md).

🔑 **Everybody agreed the requirement was simply missed.** Elena Spini: _"non so
neanche come, ma ce lo siamo persi tutti questo passaggio di cosa succedeva alle
vendite da palco … non è mai uscito nel blueprint che abbiamo mandato, non è mai
uscito da nessuna parte"_. Fabrizio Paganelli: _"i contratti su vendita da palco
sono stati i primi contratti che abbiamo mandato via, quindi non so come possa
essere successo che ce lo siamo persi un po' tutti."_

🟢 **The process agreed to avoid a repeat**, Aurel Mrruku: _"Perché non vogliamo
cadere gli stessi errori di prima. Dobbiamo fare una soluzione … Prepariamo una
bozza di documento oppure anche un documento in aggiunta di blueprint. Ce la devono
confermare e poi procediamo."_ Elena Spini set the cadence: she and Aurel look at
it **today and tomorrow**, _"Mercoledì arriviamo con una proposta"_ — **Wednesday
4 November**. Confirmed in their DM at 10:07:58 CET: _"domani sera lo vediamo al
nostro allineamento"_.

## The product-activation criterion

🔑 **Salesforce decides whether a product is active from `gruppo merceologico`, not
from Mexal's `annullato` flag** — and a dated switch to the flag is owed by the
client. The whole exchange is in
[OI-309](../items/OI-309%20The%20product%20activation%20criterion%20must%20switch%20from%20gruppo%20merceologico%20to%20the%20Mexal%20flag.md).

Also settled: at migration Aurel Mrruku activates every product **in Salesforce
only**, loads, then re-applies Mexal's own configuration — _"da 100 attivi divento
di nuovo 90 non attivi e 10 attivi"_ — so **Fabrizio Paganelli does nothing in
Mexal** and the open Mexal orders stay invoiceable. From 16 November tutors see
only the `gruppo merceologico`-active products.

## The migration gains a pre-load

🆕 Aurel Mrruku asked for a **refreshed interface file by Wednesday, Thursday or
the following Monday** so he can load the product registry and the accounts and
contacts in advance and run **only the delta** on 12-13 November, because a full
load costs _"3-4 ore"_ — _"così io ho un buffer di qualche giorno e non lascio
tutto per venerdì"_. Fabrizio Paganelli agreed and will deposit a _"versione
produzione"_ file in the shared folder. See
[OI-310](../items/OI-310%20The%20production%20load%20needs%20a%20pre-load%20and%20a%20delta%20run.md).

🟢 **The product registry is stable** — _"l'anagrafica dei prodotti no, è stabile
quella"_ — while accounts can change to the last day. 🟢 **12 November confirmed as
Fabrizio Paganelli's last Mexal invoicing day, 13 November 09:00 the handover.**
🟢 **The order load is trusted**: _"Sui ordini abbiamo visto che ha funzionato tutto
a meraviglia, quindi l'unico problema che posso avere è il tempo di processare
tutti i record."_

## The Referenti gap, a fourth time

🔴 Aurel Mrruku believed the client had sent everything — _"ha già inviato tutto,
ha fatto un check, sembra che tutto sia a posto"_ — and **Elena Spini corrected him
on the call**: _"I lead li ha mandati, i referenti mancano."_ 🔑 **And the Lead file
has not been loaded into production**: _"però gli devo caricare in produzione
adesso"_. Fabrizio Paganelli committed for **Wednesday 4 November, 09:00** —
_"io per mercoledì non c'è problema"_, Aurel Mrruku: _"Sì, 9:30, non un problema"_.
⚠ **The promise comes from Fabrizio Paganelli on behalf of an absent Sabatino
Rinaldi.** See [OI-290](../items/OI-290%20Lead%20and%20Referenti%20migration%20data%20is%20owed%20by%20the%20client.md).

## Licences, answered at last

🟢 **Twelve Salesforce licences in total.** Aurel Mrruku: _"12 rimangono ancora
due, ma tieni in considerazione che la nostra poi deve essere tolta"_. The
allocation was walked on the call and comes to eleven: **seven commerciali**
(Fabrizio Paganelli named Barbara, Martina, Carmen, Valentina, Sara and Marco
among the tutors), **one amministrazione**, **one marketing**, **one PL/digital**.
Of the two left, **one is ROMI's own** working licence until the releases finish.

🔴 **Two more people want one — Rebecca and Giordano** — and the answer was to
share: Giordano on the PL account (_"potrebbe usare quello dei PL
tranquillamente"_), Rebecca probably marketing. ⚠ **Elisa Migliano questioned
whether that is proper**: _"la Rebecca non so se è corretto che lei utilizzi quello
del marketing"_. Unresolved. See
[OI-300](../items/OI-300%20Tutor%20training%20and%20tutor%20test%20access%20are%20unplanned.md).

## Maintenance

🔑 **Aurel Mrruku described the post-go-live arrangement to the client as _"quei 8
ora al mese in cui potete chiedere qualsiasi cosa"_** — eight hours a month.
Elena Spini: _"C'è anche la parte di maintenance nella proposta, però è sempre
tutta una proposta che va confermata. Sto facendo la proposta Andrea."_

🔴 **Both statements are contradicted by the documents.** The offer deck produced
the same day carries **no maintenance line at all**, and eight hours a month is
far below the **three to four days a month** the same person named on 30 October.
See [OI-308](../items/OI-308%20Fase%202%20maintenance%20was%20left%20out%20of%20the%20estimate.md).

## Outputs

🟢 **Fabrizio Paganelli acted within the hour.** At **09:31:40Z**, nine minutes
after the call ended, he mailed _"ho creato i 12 codici prodotto per PPLUS da
utilizzare solo nei bundle. Se vuoi puoi già importare. **Non dovremmo creare
nuovi codici prodotto.**"_ (Gmail `1a19b99ad8a32714`, cc
`amministrazione@pienissimo.com`).

🆕 **Aurel Mrruku undertook to draw the flow** — _"dobbiamo mettere in fare il
disegno così lo tracciamo anche il lato funzionale, forse facciamo un flusso a
parte sul nostro [draw.io]"_. ⚠ Not in the repository.
