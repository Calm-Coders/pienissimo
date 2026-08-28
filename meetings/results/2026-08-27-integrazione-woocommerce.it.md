# [ROMI-PIENISSIMO] Integrazione WooCommerce — 27/08/2026

**Fonti:** [meetings/2026-08-27-integrazione-woocommerce-transcript.it.md](../2026-08-27-integrazione-woocommerce-transcript.it.md) (trascrizione originale in italiano, Google Meet + appunti Gemini, **48m20s**) · [registrazione](https://drive.google.com/file/d/1UjJNRMmX73UGC-ZFOu_ngWIKJVSwDUwv/view) · [appunti e trascrizione](https://docs.google.com/document/d/1EgEzGO3qtD8r0eC_uleobil6WnJgknpRvoZDG--IPIw/edit) · individuata dallo sweep notturno `requirements-check` del 27/08/2026

**Partecipanti:** ROMI — Elena Spini (conduce), Aurel Mrruku, Andrea Di Cicco. Pienissimo — Sabatino Rinaldi, Fabrizio Paganelli, Elisa Migliano. `amministrazione@pienissimo.com` era in invito.

> **Cautela sull'attribuzione.** Le etichette dei parlanti in questo progetto sono cronicamente inaffidabili. In questa trascrizione sono leggibili e le sei voci sono distinguibili; questo recap segue la trascrizione e usa il riassunto Gemini solo come controprova. Dove i due divergono, vale la trascrizione.

> **Contesto:** è la sessione tecnica che [OI-49](../../notes/items/OI-49%20WooCommerce%20checkout-link%20flow.md) attendeva dal **31 luglio** e la quarta riunione di ripartenza post-Ferragosto. Una seconda sessione operativa si è tenuta lo stesso pomeriggio — [Test Integrazione WooCommerce](2026-08-27-test-integrazione-woocommerce.it.md).

---

## Il punto principale

🟢 **La direzione dell'integrazione è decisa: è WooCommerce a scrivere su Salesforce. E non è un webhook standard.**

Dal 6 agosto il record portava "webhook, ROMI lo raccomanda" senza che nessuno l'avesse verificato contro ciò che WooCommerce sa davvero fare. In questa sessione è stato provato a schermo e scartato:

| Opzione | Esito |
| ------- | ----- |
| Job pull schedulato da Salesforce | ❌ scartato — Salesforce non ha nessun ordine da interrogare |
| Webhook standard di WooCommerce | ❌ **valutato in diretta e scartato** — un solo argomento per webhook, nessuna selezione multipla, nessun controllo sul body |
| **Plugin personalizzato, action hook PHP sul cambio stato ordine** | ✅ **concordato** |

Sabatino Rinaldi, lavorando nell'admin WooCommerce: _"non è che mi fa fare una multiselection, mi fa fare solo una selezione."_ Un webhook standard invierebbe **ogni ordine in ogni stato** e non potrebbe portare affatto la struttura del cliente. Aurel Mrruku ha letto ad alta voce la documentazione di WooCommerce: sconsiglia il webhook standard proprio per questo e raccomanda un piccolo plugin la cui action controlla lo stato dell'ordine.

Registrato in [l'integrazione ordini WooCommerce](../../notes/flows/The%20WooCommerce%20order%20integration.md). Chiude `INT-14`.

---

## Decisioni

### 1. Direzione e meccanismo

**WooCommerce scrive; Salesforce riceve.** Aurel Mrruku: _"è una comunicazione outbound lato vostro, inbound lato sales force."_

Vale la pena conservare lo scambio che l'ha prodotta. Alla domanda su come la sua piattaforma Pienissimo sappia che un ordine è passato _in lavorazione_, Sabatino Rinaldi ha descritto un **cron che interroga WooCommerce ogni pochi minuti** — _"ho un [cron] che ogni tot di minuti va a controllare che è un sync"_. Aurel Mrruku ha nominato i due problemi: è **asincrono**, e la chiamata va **dalla sua piattaforma verso WooCommerce**, direzione inutile per Salesforce, che non ha nessun ordine da interrogare. La conclusione l'ha tratta Sabatino Rinaldi stesso: _"deve essere WooCommerce che scrive su Sales Force."_

⚠ Questo **supera il mu-plugin** di `Integrazione_Salesforce_WooCommerce.docx`. Il componente lato cliente è il plugin di Sabatino Rinaldi, scritto e mantenuto da Pienissimo.

### 2. I tre scenari di business, dichiarati dal cliente e approvati

Li ha esposti Elena Spini; Aurel Mrruku ha riformulato il flusso end-to-end e lei l'ha approvato a voce — _"A me torna."_

| # | Caso | Cosa deve ricevere Salesforce |
| - | ---- | ----------------------------- |
| 1 | Cliente **sconosciuto** a Salesforce | anagrafica aziendale completa **+** contatto **+** cosa sta comprando |
| 2 | Account e contatto **già esistenti** | solo l'ordine |
| 3 | Opportunità di **recall tutor** | un link generato da Salesforce che porta l'**ID Opportunità**, che torna sull'ordine |

Lo scenario 3 è OI-49 end-to-end: Salesforce crea un'opportunità di una certa tipologia → genera una mail con un link che porta l'ID → il cliente clicca e arriva sul carrello WooCommerce → quando l'ordine raggiunge lo stato di trigger il plugin lo invia, con l'ID, a Salesforce. Gli scenari 1 e 2 sono lo stesso meccanismo **senza la prima tratta**.

### 3. Forma del payload

**Un unico JSON, tre sotto-strutture: ordine, cliente, righe d'ordine.** Aurel Mrruku fa la mappatura sui wrapper lato Salesforce e ha chiesto solo che un primo test porti _"un dato sulla struttura dell'ordine, un dato sulla struttura del cliente, un dato sulla struttura del prodotto"_ prima di congelare i campi.

Andrea Di Cicco ha chiesto se conviene dividerlo in un webhook per il cliente e uno per l'ordine. Aurel Mrruku: il costo è più o meno lo stesso — _"non è che cambia tanto avere due rapper complessi oppure avere un rapper gigantesco"_ — ma una sola chiamata significa un solo punto di rottura da tracciare. Di fatto si è chiuso su un unico payload, quello poi dimostrato nel pomeriggio.

### 4. Le vendite da palco sono obbligatorie nel set di test

Richiesta spontanea di Fabrizio Paganelli in chiusura. Tracciata come [OI-101](../../notes/items/OI-101%20Stage%20sales%20must%20be%20in%20the%20WooCommerce%20test%20set.md) — vedi **Questioni aperte**.

---

## Azioni

| # | Owner | Azione | Stato |
| - | ----- | ------ | ----- |
| 1 | Sabatino Rinaldi | Costruire il plugin e fare un test sul filo verso un endpoint usa-e-getta | ✅ **fatto lo stesso pomeriggio** |
| 2 | Aurel Mrruku | Mappare i campi del payload su Salesforce | 🔴 aperto — serve il file del payload |
| 3 | Sabatino Rinaldi, Aurel Mrruku, Elisa Migliano | Test tecnico dell'integrazione | 🟡 parziale — la sessione delle 16:00 si è svolta senza Elisa Migliano |
| 4 | Sabatino Rinaldi, Aurel Mrruku | **Simulare le vendite da palco** | 🔴 aperto — [OI-101](../../notes/items/OI-101%20Stage%20sales%20must%20be%20in%20the%20WooCommerce%20test%20set.md) |
| 5 | Andrea Di Cicco | Unificare i set di campi WooCommerce e Mexal | 🔴 aperto, **non assegnato in sessione** — [OI-103](../../notes/items/OI-103%20WooCommerce%20and%20Mexal%20field%20overlap.md) |

---

## Questioni aperte / rischi

🔴 **Le vendite da palco sono il fatturato e non sono state testate.** Fabrizio Paganelli: _"se ci blocchiamo su una vendita di un libro o di uno stream che costa €97, pazienza. Ma se ci blocchiamo su una vendita da palco che magari sono in gioco anche €8.900 €900 o più, dopo lì diventa un problema grosso."_ WooCommerce è usato *pesantemente* per le vendite da palco — il cliente in sala scansiona un QR code e acquista — e una vendita da palco **innesca meccanismi a valle, tra cui l'invio del contratto**. Ha chiesto di simulare entrambe le casistiche. Aurel Mrruku ha accettato il test tecnico ma ha distinto il **test funzionale sulle diverse casistiche, che è lavoro separato** e non è pianificato. [OI-101](../../notes/items/OI-101%20Stage%20sales%20must%20be%20in%20the%20WooCommerce%20test%20set.md).

🔴 **I set di campi WooCommerce e Mexal si scontreranno.** Andrea Di Cicco l'ha sollevato all'inizio — _"dovremmo fare un attimo il un merge... onde evitare di creare 12.000 campi"_ — e **nessuno l'ha ripreso**. Non compare nei next step di nessuna delle due sessioni né in nessuna lista di decisioni Gemini. [OI-103](../../notes/items/OI-103%20WooCommerce%20and%20Mexal%20field%20overlap.md).

🔴 **Le credenziali non sono state scambiate.** L'invito prometteva _"integrazione tecnica con WooCommerce tramite Webhook, comprensiva dello scambio di credenziali"_ e sono attese dal 14 luglio. Non sono mai state nominate. L'esito stesso della sessione lo spiega in parte — la credenziale bloccante è ora l'**endpoint Salesforce e il token**, che deve ROMI ([OI-102](../../notes/items/OI-102%20Salesforce%20endpoint%20and%20token%20for%20the%20WooCommerce%20plugin.md)). Se le CK/CS WooCommerce servano ancora per una rilettura resta **non deciso**.

⚠ **Due istanze WooCommerce** risultano in `INT-11`; entrambe le sessioni hanno trattato un solo shop. Mai ripreso.

⚠ **Pienissimo non ha uno specialista WooCommerce.** Elena Spini ha chiesto se esistesse un equivalente WooCommerce di Mirko Merendi di Kreosoft per Mexal; Sabatino Rinaldi: _"no, non abbiamo mai avuto bisogno."_ Su questa integrazione il team tecnico è lui.

---

## Note

**La specifica aveva già risposto in parte, e la stanza non l'aveva.** Nella group DM ROMI parallela alla call, Elena Spini ha postato il link a `Integrazione_Salesforce_WooCommerce.docx` alle 10:08 CEST. Andrea Di Cicco ha risposto _"ma io non l ho mai visto sto documento XD"_, poi _"io sto andando a braccio"_. Elena Spini: _"queste sono le casistiche io non so manco cosa sia sto webhook."_ Il documento è nella canvas Slack dal 31 luglio. Non è una decisione — ma spiega perché la sessione abbia ri-derivato un'architettura che la specifica già proponeva, ed è la seconda volta in quattro giorni che un documento già nel record manca alle persone che lo usano.

**Modifiche ai requisiti da questa sessione:** `INT-14` aperto → **concordato**; `INT-13` mu-plugin superato e selezione prodotto/quantità del generatore link eliminata; `INT-11` direzione della credenziale invertita. Tutte riportate in `pienissimo-requirements.yaml`, `REQUIREMENTS.md` e `REQUISITI.it.md`.
