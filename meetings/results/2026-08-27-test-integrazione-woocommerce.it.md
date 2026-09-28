# [ROMI-PIENISSIMO] Test Integrazione WooCommerce — 27/08/2026

**Fonti:** [meetings/2026-08-27-test-integrazione-woocommerce-transcript.it.md](../2026-08-27-test-integrazione-woocommerce-transcript.it.md) (trascrizione originale in italiano, Google Meet + appunti Gemini, **17m13s**) · [registrazione](https://drive.google.com/file/d/1UR-NKQmIRc8rjguIKAjTbBiuJtX9nO5I/view) · [appunti e trascrizione](https://docs.google.com/document/d/1oqiqR46V77BA7GuyFnrrptgb-2zgmwSBYl4cGPZg_6o/edit) · individuata dallo sweep notturno `requirements-check` del 27/08/2026

**Partecipanti:** **due persone** — Aurel Mrruku (ROMI) e Sabatino Rinaldi (Pienissimo).
**Assenti:** Elena Spini era in invito e nella sessione del mattino aveva detto che non si sarebbe collegata (_"Io non mi collego"_); non compare nella trascrizione. A Elisa Migliano lo slot era stato proposto da Fabrizio Paganelli e non ha partecipato.

> **Cautela sull'attribuzione.** Due parlanti, nettamente distinti; qui l'attribuzione non è in dubbio. Il riassunto Gemini è corretto ma povero — omette la scoperta di Funnel Kit, il pulsante di reinvio manuale, la regola delle righe già pagate e gli ordini reali finiti sul server di test.

> ⚠ **Peso di questo record.** Nessun project manager ROMI, nessun referente business del cliente, nessuna minuta oltre a quella di Gemini. Le decisioni qui sotto sono **accordi tecnici fra due sviluppatori** e vanno riportate in una sede con il cliente prima di costruirci sopra.

> **Contesto:** fissata alle 08:46Z della stessa mattina a valle della [sessione di design delle 10:00](2026-08-27-integrazione-woocommerce.it.md), per eseguire il test sul filo lì concordato. È la **prima integrazione WooCommerce→Salesforce del progetto dimostrata funzionante end-to-end**.

---

## Il punto principale

🟢 **Funziona.** Sabatino Rinaldi ha costruito il plugin fra le due sessioni e l'ha guidato in diretta sullo shop di produzione Pienissimo: ordine creato, plugin partito, **HTTP 200**, payload completo sul filo.

---

## Cosa è stato dimostrato

- 🟢 **Un plugin WooCommerce personalizzato, versione 1.3, sempre attivo.** Sostituisce il file PHP di test concordato al mattino — _"non fare il PHP, ma creare un plugin comodo"_.
- 🟢 **Trigger: stato ordine `in lavorazione` OPPURE `completato`**, verificato in diretta e **indipendente dal metodo di pagamento** — bonifico, carta e PayPal scattano tutti. _"arrivano già se vengono effettuati con bonifico bancario, con carta o con PayPal, arrivano tutti."_
- 🟢 **HTTP 200**, registrato come nota sull'ordine WooCommerce.
- 🟢 **Un pulsante di reinvio manuale** sull'ordine — _"reinvio web a sales force"_ — così un ordine corretto può essere rimandato senza un cambio di stato. Aurel Mrruku: _"hai controllo totale sul processo anche forzando la chiamata."_ È il gemello WooCommerce del _rinvio ordine_ di Mexal.
- 🟢 **I carrelli sono costruiti con Funnel Kit** — informazione nuova per ROMI, e cambia il link di checkout. L'URL del funnel contiene già il prodotto, quindi **l'ID prodotto non va più nell'URL**: _"non serve più nell'URL inserire l'ID prodotto perché prende il nome del funnel che in questo caso contiene già il prodotto all'interno."_ Il link generato da Salesforce porta **solo l'ID opportunità**.

## Payload visto a schermo

Osservazione della demo, non uno schema. La copia autorevole è il file di testo inviato da Sabatino Rinaldi alle **14:20Z** — vedi **Ancora irraggiungibile**.

| Livello | Campi osservati |
| ------- | --------------- |
| Ordine | **order key** WooCommerce, stato/evento, totali, **sorgente di tracciamento** |
| Cliente | nome, ragione sociale, **partita IVA** — presenti **due volte**, in forma nativa WooCommerce e in forma Funnel Kit |
| Riga | **codice prodotto `SC`**, nome prodotto, quantità, subtotale, totale |

- **`SC` è il codice prodotto che Fabrizio Paganelli chiede da tempo** — _"È il codice prodotto che vuole Max, che vuole Fabrizio sempre"_. Salesforce farà il match dei prodotti su quello, il che lega la riga WooCommerce all'anagrafica articoli Mexal in fase di **ricreazione** ([OI-98](../../notes/items/OI-98%20The%20Mexal%20article%20registry%20is%20being%20re-created.md)).
- Il **blocco cliente duplicato** è stato lasciato com'è per accordo; ROMI legge la copia nativa WooCommerce.
- ⚠ **Nessuno stato a livello di riga, per costruzione** — tutto ciò che arriva è già pagato, perché su WooCommerce esistono solo ordini in lavorazione o completati.

---

## Decisioni

### 1. Disegno lato Salesforce, dichiarato da Aurel Mrruku

Una **tipologia di ordine distinta con chiave l'order key WooCommerce**, così un ordine nato su Woo è riconoscibile (_"devo creare una tipologia di ordine con quella chiave"_) · **match dei prodotti sul codice `SC`** · **creazione del cliente** se non trovato · **ogni riga in ingresso arriva pagata**.

### 2. Nessun check P.IVA sull'ordine WooCommerce in ingresso — 🔴 un'inversione

Aurel Mrruku ha prima sostenuto che servisse un check in ingresso, poi si è corretto nello stesso scambio: _"Quando l'ordine viene inviato poi a Mexal si fa il check là. È facile."_ La validazione resta sulla tratta **Salesforce → Mexal**.

⚠ **Va confermato.** [OI-73](../../notes/items/OI-73%20VAT%20validation%20moves%20into%20Salesforce.md) registra la **decisione cliente del 6 agosto** — proposta da **Elisa Migliano**, approvata da **Elena Spini** — secondo cui il check scatta **al primo ordine di un Account**, così che i dati spinti a Mexal siano già puliti. Le due formulazioni non coincidono: una è per Account e una tantum con flag `consolidato`, l'altra è per ordine; e un ordine WooCommerce che non arrivasse mai a Mexal non verrebbe mai verificato. **Né Elisa Migliano né Elena Spini erano presenti.** Sabatino Rinaldi ha nominato l'esposizione prima di concordare: _"altrimenti poi in fatturazione Fabrizio ha lo stesso problema."_

### 3. I test di integrazione completi passano su Salesforce, settimana del 31 agosto

Puntando all'endpoint Salesforce reale con autenticazione a token. Sabatino Rinaldi ha rimandato a quel giro le casistiche da palco chieste da Fabrizio Paganelli: _"anche quelli che vuole Fabrizio, li facciamo direttamente quando abbiamo il collegamento con Sales[force]"_.

---

## Azioni

| # | Owner | Azione | Stato |
| - | ----- | ------ | ----- |
| 1 | Sabatino Rinaldi | Inviare il payload come file di testo, cc Andrea Di Cicco | ✅ **consegnato il 27/08 alle 14:20Z** |
| 2 | Aurel Mrruku | Fornire **endpoint Salesforce + token di header** | 🔴 aperto — [OI-102](../../notes/items/OI-102%20Salesforce%20endpoint%20and%20token%20for%20the%20WooCommerce%20plugin.md) |
| 3 | entrambi | Test di integrazione completi **su Salesforce** | 🔴 settimana del 31 agosto |
| 4 | Sabatino Rinaldi | Disattivare il plugin di test | ✅ **fatto in sessione** |

Aurel Mrruku ha chiesto _"Andrea Tico"_ in CC; la mail delle 14:20Z ha in copia `a.dicicco@romicompany.com` e `e.spini@romicompany.com`, quindi la richiesta è stata rispettata e "Tico" è Andrea Di Cicco trascritto male.

---

## Questioni aperte / rischi

🔴 **Ordini di clienti reali sono finiti su un server di test di terzi.** Durante le prove Sabatino Rinaldi ha visto ordini veri arrivare sull'endpoint pubblico usa-e-getta a cui il plugin puntava — _"mentre facevo dei test ci sono stati degli ordini reali e quindi io me li vedevo lì nel server finto"_ — e ha disattivato il plugin a fine call proprio per questo. Fermato, ma espone la condizione di fondo: **non esiste un ambiente di test**, si prova sullo shop di produzione con clienti reali, e il plugin è sempre attivo. [La nota di rischio](../../notes/risks/Risk%20-%20real%20WooCommerce%20orders%20reached%20a%20third-party%20test%20server.md). Nessun valore è stato copiato nel record.

🔴 **Qualcuno deve decidere dove atterrano gli ordini di test del 31 agosto** — sandbox o UAT — e come si ripuliscono. Sabatino Rinaldi si aspetta che passino: _"entrano tutti gli ordini anche senza l'opportunity"_.

🔴 **Vendite da palco ancora non testate** — [OI-101](../../notes/items/OI-101%20Stage%20sales%20must%20be%20in%20the%20WooCommerce%20test%20set.md). Questa sessione ha portato un solo prodotto di test da €50 sul percorso felice.

⚠ **`INT-16` si sta decidendo da solo.** Il plugin consegnato sembra passare l'ID opportunità **in chiaro** — l'URL della demo portava un valore letterale — mentre il registro raccomanda ancora un **token firmato**. Nessuno l'ha detto in un senso o nell'altro. Va deciso esplicitamente.

---

## Note

**Del lato Salesforce non esiste nulla.** Alla verifica org del 26 agosto non c'erano Flow, named credential né righe `Integration_Configuration__c` per WooCommerce, e `Product2.WooCommerce_Product_Id__c` è popolato su 0 prodotti su 280. Il lato cliente è ora reale e in attesa di ROMI — con lo sviluppo di Fase 1 che termina il **10 settembre**.

**Modifica ai requisiti da questa sessione:** `ORD-12` corretto — un ordine WooCommerce arriva su Salesforce a **IN LAVORAZIONE oppure COMPLETATO**, non solo a COMPLETATO. Riportato in `pienissimo-requirements.yaml` (voce e blocco `orders.rules`), `REQUIREMENTS.md` e `REQUISITI.it.md`, con entrambe le date citate.
