# **ð Note**  

 ott 19, 2026

## **\[ROMI-PIENISSIMO\] - Test UAT Commerciali**

invitato <marco.m@pienissimo.com> <amministrazione@pienissimo.com> <fabrizio.p@pienissimo.com> [Elena Spini](mailto:e.spini@romicompany.com) [Aurel mrruku](mailto:a.mrruku@romicompany.com)

Allegati [\[ROMI-PIENISSIMO\] - Test UAT Commerciali](https://calendar.google.com/calendar/event?eid=N2RybTdzY3J1cnVhdjczMGE3bmp0MGduZW4gZS5zcGluaUByb21pY29tcGFueS5jb20)

Record delle riunioni [Trascrizione](https://docs.google.com/document/d/1w71EaST25pV2oxq64QQ7THZDD9KoXSJ1hur2oh_rB0g/edit?usp=drive_web&tab=t.y17oi2ce6vuf) 

  
  

### **Riepilogo**

Riunione tecnica con configurazione software e gestione lead e preventivi commerciali.  
  
**Configurazione iniziale e lead**  
Rimozione delle picklist standard non pertinenti dai settori merceologici.  
  
**Gestione preventivi e prodotti**  
Esame dei codici articolo e delle righe dei preventivi commerciali.  
  
**Sicurezza ed importazione ordini**  
Pianificazione dell'importazione ordini e configurazione delle chiavi di accesso.

  
  

### **Decisioni**

## **Da approfondire**

  - **Valutazione dell'estensione dei campi motivazionali per altre causali** I partecipanti hanno concordato di registrare e valutare successivamente l'estensione di campi motivazionali dettagliati per le altre causali di perdita dei lead, come la scelta della concorrenza.
  - **Gestione degli sconti a livello di riga nei preventivi** È stata sollevata la necessità di inserire la possibilità di applicare sconti e visualizzare i totali a livello di riga nei preventivi, con l'impegno di Elena di verificarne la configurazione.

  

## **Concordato**

  - **Rimozione dei valori standard delle picklist di settore** I partecipanti hanno concordato di rimuovere tutti i valori standard predefiniti non pertinenti dalle picklist di settore.
  - **Configurazione del blocco automatico per le agenzie di comunicazione** Il team ha stabilito di implementare un flusso automatico per classificare come non qualificati e bloccare i lead con tipologia di attività corrispondente ad agenzia di comunicazione.
  - **Obbligatorietà del campo motivazione per i lead non interessati** È stato deciso di rendere obbligatoria la compilazione di un campo di testo libero per la motivazione quando un lead viene classificato come perso per non interesse.

  
  

### **Passaggi successivi**

  - \[Elena Spini\] Rimuovere valori picklist: Rimuovere i valori standard dalle liste di selezione non pertinenti.
  - \[Elena Spini\] Automatizzare ban lead: Configurare un processo automatico per contrassegnare come non qualificato ogni nuovo lead con tipologia di attività Agenzia di comunicazione.
  - \[Elena Spini\] Tradurre etichetta sistema: Tradurre la dicitura dell'etichetta di sistema in lingua italiana.
  - \[Elena Spini\] Creare utenza Sabatino: Generare un nuovo account utente per Sabatino Rinaldi con privilegi di amministratore.
  - \[Elena Spini\] Implementazione campo motivazione: Rendere obbligatoria la compilazione del campo note quando viene selezionato non interessato nel modulo di qualifica dei lead.
  - \[Elena Spini\] Aggiunta campi motivazione: Inserire campi di testo aggiuntivi per specificare le motivazioni nelle categorie concorrenza e servizio non adatto.
  - \[Fabrizio Paganelli\] Segnalazione errori prodotti: Comunicare ad Aurel la presenza di codici articolo errati riscontrati nell'anagrafica prodotti.
  - \[Elena Spini\] Correzione logica sconti: Richiedere ad Aurel di integrare la funzionalità per l'inserimento di sconti a livello di singola riga nei preventivi.
  - \[Elena Spini\] Organizzazione riunione importazione ordini: Fissare un incontro con Aurel per discutere l'importazione massiva degli ordini.
  - \[Elena Spini\] Invio credenziali accesso: Fornire a Sabatino Rinaldi le credenziali di accesso necessarie per il sistema.
  - \[Il gruppo\] Revisione copy email: Revisionare il testo delle email di promemoria automatico per i preventivi in scadenza.
  - \[Fabrizio Paganelli\] Pulizia anagrafica prodotti: Coordinarsi con Aurel per la rimozione e la corretta ricreazione dei prodotti test nell'anagrafica.
  - \[Fabrizio Paganelli\] Testare accesso: Verificare se Elisa riesce ad accedere correttamente alla piattaforma.
  - \[Elena Spini\] Creare utenza: Procedere con la creazione dell'utenza per Sabatino.
  - \[Il gruppo\] Definire import ordini: Stabilire una modalità condivisa per importare gli ordini storici e le fatture.
  - \[Fabrizio Paganelli\] Inviare archivio: Condividere il file dell'archivio storico con il formato corretto per l'importazione.
  - \[Fabrizio Paganelli\] Formazione processo vendita: Mostrare il flusso di vendita standard al team durante la riunione di domani mattina.
  - \[Fabrizio Paganelli\] Pulire database prodotti: Rimuovere i codici prodotto errati e le voci duplicate generate dai test precedenti.

  
  

### **Dettagli**

**Installazione e configurazione di Proton**: Fabrizio Paganelli e Elisa Migliano affrontano il problema della configurazione iniziale del software Proton, confermando di aver completato l'installazione e i test preliminari con la supervisione condivisa dello schermo \` \`. Sabatino Rinaldi tenta nel frattempo di contattare Marco che risulta inizialmente assente alla riunione \` ([00:00:52](https://docs.google.com/document/d/1w71EaST25pV2oxq64QQ7THZDD9KoXSJ1hur2oh_rB0g/edit?ouid=100243958128504204165#heading=h.c41uay3zloor)) \`.

-----

**Gestione dei contatti senza account in Sales SOS**: Fabrizio Paganelli solleva il problema della creazione di contatti scollegati da un'azienda in Sales SOS, descrivendo il proprio flusso di lavoro che prevede la creazione separata del contatto e poi dell'account \` ([00:07:11](https://docs.google.com/document/d/1w71EaST25pV2oxq64QQ7THZDD9KoXSJ1hur2oh_rB0g/edit?ouid=100243958128504204165#heading=h.w14wsk1rymlb)) \`. Elena Spini spiega che i contatti senza account derivano solitamente dai lead delle campagne di marketing, ma conferma la possibilità di mantenere questa flessibilità operativa per gestire scenari in cui ciascuna persona tutor interagisce con nuovi referenti aziendali partendo da zero \` ([00:08:22](https://docs.google.com/document/d/1w71EaST25pV2oxq64QQ7THZDD9KoXSJ1hur2oh_rB0g/edit?ouid=100243958128504204165#heading=h.xnepndaq3sos)) \`.

-----

**Rimozione delle picklist standard di settori merceologici**: Elena Spini, Fabrizio Paganelli, Elisa Migliano e Sabatino Rinaldi discutono la presenza di valori standard non pertinenti nelle picklist dei settori merceologici (come ristorante, albergo, chimica, trasporti e banche) \` \`. Il gruppo concorda unanimemente di rimuovere tali voci standard per adattare lo strumento alle specifiche esigenze aziendali \` ([00:11:31](https://docs.google.com/document/d/1w71EaST25pV2oxq64QQ7THZDD9KoXSJ1hur2oh_rB0g/edit?ouid=100243958128504204165#heading=h.7xms0ybc7hp3)) \`.

-----

**Automazione del blocco per le agenzie di comunicazione**: Sabatino Rinaldi segnala il problema dell'ingresso indesiderato di lead classificati come agenzie di comunicazione attraverso i moduli di contatto, richiedendo l'implementazione di una regola di blocco automatico \` \`. Il gruppo concorda di impostare un flusso automatizzato che riconosca la tipologia di attività "agenzia di comunicazione" e aggiorni automaticamente lo stato del lead a "non qualificato" con la motivazione di uscita legata alla blacklist \` ([00:14:22](https://docs.google.com/document/d/1w71EaST25pV2oxq64QQ7THZDD9KoXSJ1hur2oh_rB0g/edit?ouid=100243958128504204165#heading=h.ajrlrk6mkmz)) \`.

-----

**Risoluzione dei problemi di accesso alla piattaforma per Marco**: Marco riscontra difficoltà di accesso alla piattaforma Sales SOS e la mancata ricezione dell'email di ripristino della password \` ([00:16:42](https://docs.google.com/document/d/1w71EaST25pV2oxq64QQ7THZDD9KoXSJ1hur2oh_rB0g/edit?ouid=100243958128504204165#heading=h.svs7bh2ox6ga)) ([00:19:56](https://docs.google.com/document/d/1w71EaST25pV2oxq64QQ7THZDD9KoXSJ1hur2oh_rB0g/edit?ouid=100243958128504204165#heading=h.eit3rlyu74po)) \`. Elena Spini invia direttamente le credenziali e un nuovo collegamento per il reset della password all'indirizzo \`marco.m@apissimo.com\` \` ([00:16:42](https://docs.google.com/document/d/1w71EaST25pV2oxq64QQ7THZDD9KoXSJ1hur2oh_rB0g/edit?ouid=100243958128504204165#heading=h.svs7bh2ox6ga)) ([00:21:47](https://docs.google.com/document/d/1w71EaST25pV2oxq64QQ7THZDD9KoXSJ1hur2oh_rB0g/edit?ouid=100243958128504204165#heading=h.u24if73w7wbd)) \`. Marco completa con successo la procedura di autenticazione e accede alla piattaforma con un'utenza da super admin per la fase di test \` ([00:18:03](https://docs.google.com/document/d/1w71EaST25pV2oxq64QQ7THZDD9KoXSJ1hur2oh_rB0g/edit?ouid=100243958128504204165#heading=h.8m2ryle7komf)) ([00:23:10](https://docs.google.com/document/d/1w71EaST25pV2oxq64QQ7THZDD9KoXSJ1hur2oh_rB0g/edit?ouid=100243958128504204165#heading=h.x8ygtmcylrne)) \`.

-----

**Navigazione e ricerca degli account in Sales SOS**: Elena Spini guida Marco nella navigazione tra gli elenchi e le viste filtrate (list view) degli account in Sales SOS, mostrando come utilizzare la ricerca generale e quella specifica per elenco utilizzando come esempio pratico la ricerca di "La pergola 2" \` ([00:26:55](https://docs.google.com/document/d/1w71EaST25pV2oxq64QQ7THZDD9KoXSJ1hur2oh_rB0g/edit?ouid=100243958128504204165#heading=h.14uueb9gpx0n)) \`. Elena Spini avverte inoltre di prestare molta attenzione alle modifiche sui campi collegati all'ambiente di produzione Mexal \` ([00:31:03](https://docs.google.com/document/d/1w71EaST25pV2oxq64QQ7THZDD9KoXSJ1hur2oh_rB0g/edit?ouid=100243958128504204165#heading=h.347sxinjj2rg)) \`.

-----

**Creazione manuale e validazione dei lead**: Marco e Elena Spini eseguono una simulazione di creazione manuale di un lead da zero inserendo i dati richiesti, inclusa la partita IVA \` \`. Elena Spini spiega che la correttezza della partita IVA viene verificata tramite una chiamata al servizio Antipay, e che in caso di dati errati o inventati vengono inviate notifiche di attenzione a Fabrizio Paganelli e Elisa Migliano per prevenire problemi di fatturazione \` ([00:32:02](https://docs.google.com/document/d/1w71EaST25pV2oxq64QQ7THZDD9KoXSJ1hur2oh_rB0g/edit?ouid=100243958128504204165#heading=h.wp9yy4jpqqxj)) ([00:34:02](https://docs.google.com/document/d/1w71EaST25pV2oxq64QQ7THZDD9KoXSJ1hur2oh_rB0g/edit?ouid=100243958128504204165#heading=h.atd68gd7pjhx)) \`.

-----

**Gestione degli stati dei lead e pianificazione dei task**: Elena Spini e Marco esaminano i diversi stati del lead (nuovo, in lavorazione, non risponde, primo contatto) e le modalità di aggiornamento dello stadio corrente \` ([00:39:38](https://docs.google.com/document/d/1w71EaST25pV2oxq64QQ7THZDD9KoXSJ1hur2oh_rB0g/edit?ouid=100243958128504204165#heading=h.nztaquaxq77b)) ([00:45:09](https://docs.google.com/document/d/1w71EaST25pV2oxq64QQ7THZDD9KoXSJ1hur2oh_rB0g/edit?ouid=100243958128504204165#heading=h.8mrcqkvbot7g)) \`. Marco richiede come gestire i richiami futuri, ed Elena Spini mostra la creazione di task interni associati a scadenze e priorità (come la scadenza fissata al 22/10) per tracciare le azioni commerciali direttamente nel calendario di Sales SOS \` ([00:46:44](https://docs.google.com/document/d/1w71EaST25pV2oxq64QQ7THZDD9KoXSJ1hur2oh_rB0g/edit?ouid=100243958128504204165#heading=h.djenuuu9si6t)) \`.

-----

**Personalizzazione delle motivazioni per i lead non qualificati**: Marco, Sabatino Rinaldi, Elisa Migliano ed Elena Spini analizzano le motivazioni di scarto per i lead non qualificati (tra cui dati errati, duplicati, fuori target o non interessati) \` ([00:50:18](https://docs.google.com/document/d/1w71EaST25pV2oxq64QQ7THZDD9KoXSJ1hur2oh_rB0g/edit?ouid=100243958128504204165#heading=h.oda3zyj9oex)) \`. Per evitare risposte vaghe, il gruppo concorda di rendere obbligatorio un campo di testo libero per specificare la motivazione quando viene selezionata l'opzione "non interessato", valutando inoltre l'estensione di dettagli specifici per altre causali come la concorrenza \` ([00:51:23](https://docs.google.com/document/d/1w71EaST25pV2oxq64QQ7THZDD9KoXSJ1hur2oh_rB0g/edit?ouid=100243958128504204165#heading=h.wda7z93sm54y)) \`.

-----

**Conversione del lead in account, referente e opportunità**: Elena Spini mostra la procedura finale di conversione di un lead qualificato (utilizzando la risorsa assegnata Carla/Carmen) in cui il lead di test "Montesi Test" viene trasformato simultaneamente nel referente dell'azienda "Montesi Srl" con la generazione automatica della relativa opportunità commerciale e il mantenimento dello storico delle azioni precedenti \` ([00:57:17](https://docs.google.com/document/d/1w71EaST25pV2oxq64QQ7THZDD9KoXSJ1hur2oh_rB0g/edit?ouid=100243958128504204165#heading=h.ddbkmz8yb5l)) \`.

-----

**Navigazione delle opportunità e visualizzazione degli oggetti correlati**: Elena Spini mostra a Marco come navigare tra i tab correlati dell'account (inclusi contatti e opportunità) per visualizzare lo storico e accedere alla pagina dell'opportunità utile al tracciamento di demo o preventivi.

-----

**Configurazione dei campi precompilati nel preventivo**: Vengono esaminati i campi precompilati del preventivo, tra cui il nome dell'opportunità, la data di scadenza (fissata a 5 giorni ma modificabile) e le condizioni di pagamento collegate alle logiche Mexal, prima di procedere con l'inserimento dei prodotti.

-----

**Gestione dei prodotti e selezione dei codici articolo**: Elena Spini illustra i bottoni presenti nella schermata dei preventivi, concentrandosi sulla gestione dei prodotti per selezionare codici articolo come "Mastery", mentre Fabrizio Paganelli individua la presenza di codici di test anomali inseriti da Aurel.

-----

**Gestione degli sconti e dei prezzi di listino nelle righe preventivo**: Fabrizio Paganelli segnala la mancanza di campi dedicati a sconti, unità di misura e prezzi netti dettagliati all'interno delle righe del preventivo; Elena Spini annota la problematica per verificarla con Aurel e analizzare il comportamento dell'aggiornamento automatico.

-----

**Creazione delle tranche di pagamento**: Viene descritta la procedura per definire e assegnare le tranche di pagamento con date specifiche (come fine novembre e fine dicembre), verificarle nella sezione dei dati correlati e visualizzare il totale complessivo intestato al preventivo.

-----

**Generazione del PDF del preventivo e gestione dei promemoria automatici**: Durante il tentativo di generazione del PDF si verifica un errore del server interno, inducendo il gruppo a esaminare un preventivo preesistente in stato di attesa accettazione, che include file allegati, richieste di firma con Docusign e la creazione automatica di task e promemoria via email dopo 2 giorni basati su un copy provvisorio.

-----

**Sincronizzazione degli stati tra preventivi e opportunità**: Viene evidenziato che lo stato del preventivo e quello dell'opportunità avanzano in parallelo, e viene pianificato un incontro specifico per mercoledì per trattare l'importazione massiva degli ordini.

-----

**Configurazione delle chiavi di accesso (Passkey) su Salesforce**: Elena Spini avvisa Marco e Sabatino Rinaldi che al momento del successivo accesso a Salesforce verrà richiesto di configurare una passkey (sistema di autenticazione basato su dispositivi personali o impronta digitale) per rafforzare la sicurezza dell'utenza.

-----

**Revisione tecnica dell'importazione degli ordini da Mexal e pulizia dei prodotti**: Fabrizio Paganelli analizza le criticità nell'importazione degli ordini storici da Mexal, sottolineando la necessità di rimuovere i codici articolo errati o di test dall'anagrafica di Salesforce e di nascondere i pacchetti bundle dalle vendite standard per evitare errori da parte dei tutor.

-----

**Gestione delle categorie e delle convenzioni di denominazione delle opportunità**: Fabrizio Paganelli discute l'organizzazione delle categorie e sottocategorie nei prodotti e nelle opportunità, criticando l'uso di testi liberi per la denominazione e ribadendo l'importanza di affidarsi a categorie e sottocategorie standardizzate per la reportistica.

  
  

*Dovresti rivedere le note di Gemini per assicurarti che siano accurate.* [*Ricevi suggerimenti e scopri come Gemini prende appunti*](https://support.google.com/meet/answer/14754931)

*Qual è la qualità di* ***queste note specifiche?*** [*Rispondi a un breve sondaggio*](https://google.qualtrics.com/jfe/form/SV_5bXzKQfylMIhSXc?confid=eXD36nfJOvTYTTqvYwOIDxIQOBEQAjIGCIoCIAAYAwg&detailLevel=standard&hasImages=False&entryPoint=footerMain&isGoogler=False&lang=it-IT)*? Facci sapere cosa ne pensi e quanto le note siano state utili per le tue esigenze.****  
***

# **ð Trascrizione***  
*

 ott 19, 2026

## **\[ROMI-PIENISSIMO\] - Test UAT Commerciali - Trascrizione**

### **00:00:52**

  

**Elena Spini:** Ciao Ah.

**Elisa Migliano:** Tchau.

**Elena Spini:** No. Ciao. Ah.

**Sabatino Rinaldi:** Ciao Oh.

**Elena Spini:** Ciao.

**Fabrizio Paganelli:** Ciao a tutti.

**Elena Spini:** Ciao Fabrizio. Buon pomeriggio.

**Fabrizio Paganelli:** Ciao anche a voi. Sì.

**Elena Spini:** Aspettiamo Marco, vero? Perché era per lui in realtà questa colla.

**Fabrizio Paganelli:** Gli gli facciamo una chiamata.

**Elena Spini:** Ti sento bassissimo, Fabrizio.

**Sabatino Rinaldi:** Adesso provo a chiamarlo.

**Fabrizio Paganelli:** Aspetta che lo chiami te.

**Sabatino Rinaldi:** Sì, sì.

**Fabrizio Paganelli:** Aspetta che avevo Così mi senti meglio?

**Elena Spini:** Sì, decisamente.

**Fabrizio Paganelli:** Ok. Avevo No,

**Elena Spini:** Intanto se se scusa.

**Fabrizio Paganelli:** no, avevo il volume basso.

**Elena Spini:** Ok. Dicevo, intanto se vuoi possiamo vedere la mail che con gli screenshot, se vuoi condivido che ci hai mandato venerdì

**Fabrizio Paganelli:** Sì,

**Elena Spini:** sera.

**Fabrizio Paganelli:** intanto mi loggo.

**Elena Spini:** Ottimo. Alla fine non ho guardato come state vi state loggando

**Fabrizio Paganelli:** Ah,

**Elena Spini:** con Sì,

**Fabrizio Paganelli:** io io ho installato Proton. Com'è che si chiama? Proton.

**Elena Spini:** Proton state usando quello?

  
  

### **00:05:42**

  

**Fabrizio Paganelli:** Poi dopo da lì sto usando quello. Sì.

**Elena Spini:** Perfetto. te anche.

**Fabrizio Paganelli:** L

**Elisa Migliano:** Sta venerdì.

**Sabatino Rinaldi:** Ah, Marco non mi risponde.

**Elisa Migliano:** Hai visto? Non gli ho dato.

**Fabrizio Paganelli:** ancora non mi ha detto niente. Digli te qualcosa, Elena.

**Elena Spini:** Ma scusa, eh,

**Fabrizio Paganelli:** No, no,

**Elisa Migliano:** Va bene.

**Fabrizio Paganelli:** ma lo sapete,

**Elisa Migliano:** E perché? E perché non Basta che dopo non si lamenta. E perché non mi fido.

**Fabrizio Paganelli:** vero? da solo.

**Elena Spini:** siamo in testa, cioè Eh

**Fabrizio Paganelli:** No, no, è che bisogna fare adesso, magari è perché non c'abbiamo un attimo di di tregua e c'è tutta quella cosa lì da installare Proton, configurarlo che mi ero segnato, spero che non di non far casini, mi ero segnato tutto come si fa. Poi dopo, comunque sia, quando abbiamo fatto i test li abbiam fatti insieme guardando il mio monitor, quindi venerdì ha anche fatto da sola lei un pezzettino.

**Elena Spini:** Ok, cos'è? st scriendo una cosa e arrivo.

**Fabrizio Paganelli:** Sì.

  
  

### **00:07:11**

  

**Sabatino Rinaldi:** Sta entrando Marco. Voilà.

**Elena Spini:** Ok. Allora, nel mentre ci sono, allora il primo screenshot ehm referente senza account è una cosa normale in Sales SOS,

**Fabrizio Paganelli:** Allora, sì.

**Elena Spini:** in realtà, se non lo volete capiamo.

**Fabrizio Paganelli:** Perché allora lì fa vedere bene che cosa avevo fatto. Aspetta che non vedo. Eh.

**Elena Spini:** Eh, guarda, lo possiamo anche rifare.

**Fabrizio Paganelli:** Ah, perché nome cognome è il nome e il nome e cognome del contatto, mentre invece nome account sarebbe il nome dell'azienda associata a quel contatto. Dico bene?

**Elena Spini:** Sì,

**Fabrizio Paganelli:** Ah, ok.

**Elena Spini:** ma questo è vuoto perché è stato creato senza account.

**Fabrizio Paganelli:** Esatto, perché facevo una prova di nuovo account e nuova azienda.

**Elena Spini:** Ok,

**Fabrizio Paganelli:** Ho capito. Allora, questa l'ho capita.

**Elena Spini:** ma in realtà, cioè, nel senso, è tra virgolette anche un falso problema, nel senso se volete, cioè tu immagino che sei andato qua, contatto e fatto nuovo.

**Fabrizio Paganelli:** Aspetta che non ti vedo.

**Elena Spini:** E vabbè,

**Marco:** per questa M.

**Fabrizio Paganelli:** Ok.

  
  

### **00:08:22**

  

**Elena Spini:** aspetta. Eh,

**Fabrizio Paganelli:** Sì,

**Elena Spini:** tu hai fatto nuovo da qua, ma in realtà,

**Fabrizio Paganelli:** sì.

**Elena Spini:** cioè,

**Fabrizio Paganelli:** Ok,

**Elena Spini:** volendo lo possiamo anche togliere se non vi piace avere i contatti senza account, perché idealmente se tu parti da un account e fai nuovo a liv nuovo contatto da questa pagina, non succederà mai quella situazione perché tu hai sempre il contatto che è collegato

**Fabrizio Paganelli:** ho capito.

**Elena Spini:** all'account.

**Fabrizio Paganelli:** Ok, perché io ti dico avevo fatto questo, non non l'ho fatto perché che avevo fatto un qualche cosa proprio da zero

**Elena Spini:** No, hai fatto questo,

**Fabrizio Paganelli:** completamente.

**Elena Spini:** hai fatto contact new e quindi qua hai la libertà di collegare

**Fabrizio Paganelli:** E esattamente esattamente quando io

**Elena Spini:** l'account che vuoi. He.

**Fabrizio Paganelli:** Ok, quindi io sono andato per step, quindi mi son creato prima il contatto, poi andavo a creare l'account e a quell'account gli andavo ad associare quel contatto. In quel caso dopo si aggiorna l'anagrafica dei contatti con l'azienda collegata, immagino. Cioè, nel senso, provo a rispiegarmi meglio perché mi sono spiegato male.

  
  

### **00:09:21**

  

**Fabrizio Paganelli:** Creo un nuovo un nuovo contatto. Creo un nuovo account. Nel momento in cui creo il nuovo account, gli associo quel contatto nuovo che ho creato. Dopo il legame si crea dopo.

**Elena Spini:** Esatto.

**Fabrizio Paganelli:** Ok.

**Elena Spini:** Cioè, ma semplicemente io ho già fatto l'azienda, sono qua account, vado su contatto, faccio new, in automatico mi propone questo account che sarebbe l'azienda.

**Fabrizio Paganelli:** Sì, sì, sì, sì, sì, sì, sì. Quindi diciamo che come flusso logico sarebbe più corretto che il tutor e No, neanche perché dopo gli acc i contatti a noi ci arrivano dalle dalle campagne di marketing, quindi ci arrivano tutti magari anche con l'azienda vuota se è un contatto nuovo.

**Elena Spini:** Quelli sono i lead.

**Fabrizio Paganelli:** Ah, giusto, quelli sono i lead.

**Elena Spini:** Sì,

**Fabrizio Paganelli:** Ma poi dopo se io quindi quindi non esisterà mai che vado a creare un contatto da zero

**Elena Spini:** oddio. M in realtà sì, può essere. Cioè, magari il tutor si accorge che, non lo so, sta parlando con Elena che è la nuova, boh, referente dell'account X,

  
  

### **00:10:31**

  

**Fabrizio Paganelli:** ok?

**Elena Spini:** va sull'account X e mette referente Elena. Cioè, ci può stare, ci possono stare entrambi le situazioni,

**Fabrizio Paganelli:** Quindi sì,

**Elena Spini:** cioè non Io forse lo lascerei,

**Fabrizio Paganelli:** sì, sì.

**Elena Spini:** poi magari vi può servire, non so, in un altro scenario,

**Fabrizio Paganelli:** No, no, adesso,

**Elena Spini:** non lo so.

**Fabrizio Paganelli:** adesso ho capito. Va bene, ho capito.

**Elena Spini:** Ok.

**Fabrizio Paganelli:** Quindi potrebbe succedere che io ho dei dei contatti senza azienda, perché magari ho telefonato, ho creato il contatto, poi dopo non è andata a buon fine alla telefonata e l'azienda e e a quel contatto non gli assocerò mai un'azienda.

**Elena Spini:** Quello in realtà se se è un contatto, cioè che non tu non sei neanche, cioè l'hai chiamato così, è è proprio un lead.

**Fabrizio Paganelli:** È un lead.

**Elena Spini:** Sì.

**Fabrizio Paganelli:** È un lead. Sì, sì.

**Elena Spini:** E e nei lead in realtà eh il campo importante è Vabbè, adesso facciamo standard così. Eh, quel cioè azienda si chiama company sarebbe che infatti è un campo obbligatorio che poi sarebbe l'azienda, l'account.

  
  

### **00:11:31**

  

**Fabrizio Paganelli:** Ho capito, ho capito, ho capito.

**Elena Spini:** Ottimo. Ciao Marco, scusa, stavamo temporeggiando con alcune cose che mi aveva chiesto Fabrizio.

**Marco:** Ah, ci mancherebbe. Scusate voi, ma ero preso affaccendato in altre cose. È arrivato Sabatino a bussarmi sulla spalla e dire sveglia.

**Elena Spini:** อื Ok,

**Marco:** Grazie mila.

**Elena Spini:** perfetto. Ehm, c'erano altre cose, scusa. Eh, queste due picklist così se non le vuoi le togliamo,

**Fabrizio Paganelli:** Esatto.

**Elena Spini:** sono standard.

**Fabrizio Paganelli:** Ah, dopo qui magari ehm per me così non quelle quegli standard

**Elena Spini:** Se non Ma sì,

**Fabrizio Paganelli:** noni abbiamo il nostro, diciamo, ristorante,

**Elena Spini:** infatti lo togliamo,

**Fabrizio Paganelli:** albergo eccetera eccetera.

**Elena Spini:** non è un problema.

**Fabrizio Paganelli:** Secondo me sì. Te cosa dici? Elisa, settore chimica, trasporti,

**Sabatino Rinaldi:** No,

**Fabrizio Paganelli:** banche,

**Sabatino Rinaldi:** chiaro chiaro. Van tolti,

**Fabrizio Paganelli:** cioè secondo me van tolti quelli lì.

**Sabatino Rinaldi:** van tolti senza dubbio. Van tolti tutti.

**Elena Spini:** Togliamo. Perfetto. Ehm, e questo in realtà era perché non c'era eh la gente che era questo, però adesso l'abbiamo sistemata, magari adesso ne ne creiamo uno e vedi che è a posto.

  
  

### **00:12:53**

  

**Fabrizio Paganelli:** Ok.

**Elena Spini:** Ok, ottimo. Allora,

**Sabatino Rinaldi:** Ah, cosa Elena? giusto per

**Fabrizio Paganelli:** Perché in realtà,

**Elena Spini:** Vai

**Fabrizio Paganelli:** scusa Sabatino, scusa Sabatino, in realtà eh l'agente dovrebbe essere inserito lì in automatico in base a chi è il tutor che sta proprietario di quel contatto, di quell'azienda. Scusate, cioè quando io creo un nuovo account e sono eh Marco Montesi e creo l'account, il quei campi agente, classificatore rete zona dovrebbero essere

**Elena Spini:** Sono quelli dell'utente. Sì,

**Fabrizio Paganelli:** precompilati.

**Elena Spini:** ma tu non ce l'avevi.

**Fabrizio Paganelli:** Ok, ho capito, ho capito.

**Elena Spini:** Vedi che vuoto?

**Fabrizio Paganelli:** Sì, sì, sì, sì. Quindi avrei dovuto Ok, ho capito. Ben

**Elena Spini:** Sabatino.

**Sabatino Rinaldi:** Scusate, stavo rispondendo per il paddle. E allora dicevo,

**Elena Spini:** Le priorità.

**Sabatino Rinaldi:** ehm, dato che noi nella tipologia di attività che lasciamo nei form, come hai visto sicuramente anche dai da da quelli che ti avevamo inviato, se non sbaglio, c'era anche agenzia di comunicazione tra le varie tipologie a tipologie di

**Elena Spini:** E ricordami il campo che lo vediamo da qua.

  
  

### **00:14:22**

  

**Elena Spini:** M.

**Sabatino Rinaldi:** attività. Tipologia. Sì, tipologia. Esatto, tipologia attività. Noi nei nostri valori dovremmo avere anche agenzia di comun Ah, sì, sì, guarda, era la prima. Era la prima. Agenzia di comunicazione. Ok, perfetto. Riusciamo a fare questo può andare anche in fase 5, non è un'urgenza,

**Elena Spini:** Shit.

**Sabatino Rinaldi:** giusto per metterci d'accordo. riusciamo a fare in modo che in automatico, ogni volta che entra un nuovo lead che ha come tipologia attività agenzia di comunicazione, riusciamo a bannarlo in automatico, cioè che non riceverà nulla, è bloccato, non lo vediamo, eccetera eccetera, lo blocchiamo, come lo banniamo in pratica applicare un banlist.

**Elena Spini:** Beh, eh possiamo fare vogliamo, quindi sì,

**Sabatino Rinaldi:** Ok,

**Elena Spini:** non non vedo

**Sabatino Rinaldi:** perfetto. No, no, perché questa cosa a noi c'è molto utile perché altrimenti ogni volta succede che ci ritroviamo alcune persone che sono agenzie eccetera che non vogliamo.

**Elena Spini:** M come si chiamava già?

**Sabatino Rinaldi:** Quindi se si può fare è perfetto.

**Elena Spini:** Tipologia,

**Sabatino Rinaldi:** Sì. Tipologia di attività.

  
  

### **00:15:25**

  

**Elena Spini:** cioè io mi immagino tipologia attività nel lead che è entrato entra come attività di comunicazione dei vari formc. Cioè possiamo mettere semplicemente non qualificato.

**Sabatino Rinaldi:** Esatto.

**Elena Spini:** Sì, sì.

**Sabatino Rinaldi:** Una sorta di blacklist in modo tale che il tutor lo capisce

**Elena Spini:** Non non quali Esatto. Esatto. Ci sarà un flusso che ogni volta che entra un leader di questo tipo

**Sabatino Rinaldi:** perché noi lo mettiamo Perfetto. Perché lo mettiamo a posto.

**Elena Spini:** ci sarà in automatico l'aggiornamento a non qualificato dettaglio della motivazione motivazione usciva uscita blacklist.

**Sabatino Rinaldi:** Esatto, perché noi quella lì la teniamo come trappola la tipologia di attività agenzia comunicazione che chi lo

**Elena Spini:** Ok,

**Sabatino Rinaldi:** mette viene bannato. Bene, giusto questo mi è venuto in mente. Adesso ritorno a organizzare il mio paddle.

**Elena Spini:** Marco, a noi dovresti aver ricevuto una mail. Ti ho creato l'utenza.

**Marco:** Sì, esatto.

**Elena Spini:** Vuoi condividere te?

**Marco:** Qui, allora, vediamo qua dove la vado a pescare.

**Elena Spini:** Allora, deve essere tipo welcome, no, benvenuto perché mi sa che ti avevo messo l'italiano già di default.

  
  

### **00:16:42**

  

**Elena Spini:** Benvenuto in sales, forse una cosa del genere.

**Marco:** Sì, ce l'ho. Mi sa l'ho aperto con quell'altro account, credo. Me l'ero salvato qui da qualche parte. Prov a recuperare. Diciamo che riprendere la tua mail. Posso chiedere? No,

**Elena Spini:** Eh sì,

**Marco:** l'imposta password non l'avevo già impostata.

**Elena Spini:** ok.

**Marco:** Allora,

**Elena Spini:** Allora, a te non l'ho mandato, quindi mando la stessa cosa. Ora la prima volta ti chiederà inserisci la password.

**Marco:** no, ma l'ho già l'ho già l'ho già sistemata. Se mi dai l'accesso di login così entro dentro direttamente da lì.

**Elena Spini:** Perfetto.

**Marco:** Lo puoi girare anche via WhatsApp se ce l'hai o la la

**Elena Spini:** Vuoi?

**Marco:** maschera di login così perché la password l'avevo già scritta,

**Elena Spini:** Guarda,

**Marco:** quindi Sì.

**Elena Spini:** la puoi la puoi trovi tutto direttamente nella mail mail. Nella mail ci sarà scritto puoi accedere da qua e poi c'è il tuo nome utente, però se vuoi te lo ripasso.

**Marco:** M Sì. No, no,

**Elena Spini:** So

**Marco:** ce l'ho, ce l'ho. Allora, eccolo qua la landing.

  
  

### **00:18:03**

  

**Marco:** Ecco qua. Ciao. Collegamento non è completo. Apri il messaggio del ricevuto. Salve. Allora, piacere la fara. Allora, perché questa qui. Ok, allora Gianco, ha spiegato fatto delle due attività, quindi uno oppure benissimo. Uno criptsima. E allora la non mi ricordo se la P è

**Elena Spini:** M.

**Marco:** maiuscola. Sì, dai. E non mi fa entrare, quindi non era maiuso. Marco, pienissimo. Fermo. Eh, mi pare ti sento un po' cosino. Allora, passo dimenticata. Faccio a sto punto, tanto ho messo dentro pienissimo uno, non è che può essere che non mi fa entrare.

**Elena Spini:** Vai\!

**Marco:** No, non è possibile.

**Elena Spini:** No, no, non è quella.

**Marco:** L'ho fatta facile così me la ricordavo, appunto. Niente.

**Elena Spini:** Hai fatto bene.

**Marco:** Allora,

**Elena Spini:** Nie.

**Marco:** eh, infatti vedi, password dimenticata. Sì, metti il tuo nome. Perfetto. Eh, quando mi chiede il nome intende la mail, giusto? Quindi pianissimo, però nasce comunque dall'esigenza di Giuliano per gestire l'agenda, quindi digitalizzare le presentazioni. Adesso è diventato un vero e proprio CR specifico per la ristorazione, quindi è possibile gestire lezioni?

  
  

### **00:19:56**

  

**Marco:** Aspetta che vi tolgo che c'è Sara qui che è distante anni luce, ma chiaramente

**Elena Spini:** Sembra che siamo nella stessa stanza anche noi.

**Marco:** Sì, qui è così tutti i giorni. Yeah.

**Fabrizio Paganelli:** F.

**Elena Spini:** Prego. in versione Halloween.

**Marco:** Sì, non riesco. Sto cerc No, sto aspettando la mail per il recupero della L'ho fatta facile. Detto così siamo già a posto. E no, sto aspettando la mail sandbox per la la password per impostarlo. È possibile avere anche una gestione del personale, quindi creare un vero e proprio manuale operativo dell'azienda dove è possibile ovviamente delegare determinati compiti.

**Elena Spini:** Ma hai già cliccato su rimposta password e non ti è arrivata?

**Marco:** e non mi è arrivata la mail del mio utente l'ho rimessa. Non vorrei farlo troppe volte che poi magari mi manda a quel paese.

**Elena Spini:** Allora, ok, aspetta, provo a rimandartelo io.

**Sabatino Rinaldi:** Senò condividi lo schermo,

**Elena Spini:** No, no, no, no,

**Sabatino Rinaldi:** Marco.

**Elena Spini:** fermo,

**Sabatino Rinaldi:** Sì,

**Elena Spini:** fermo,

**Sabatino Rinaldi:** sì.

**Elena Spini:** te lo te lo mando io.

**Marco:** Sì, sì.

  
  

### **00:21:47**

  

**Marco:** No, infatti non faccio niente. Ho fatto recupera password per impostarla, ma non mi è arrivata la mail. detto la faccio facile, è pienissimo una così me la ricordo.

**Elena Spini:** Allora, vediamo se ti vedo. Che cosa è successo?

**Marco:** Sì, adesso non riesco a andare indietro, però si esatto

**Elena Spini:** In realtà vedo che hai chiesto il password reset e c'è anche

**Marco:** poco e dopo c'è

**Elena Spini:** status.

**Marco:** anche non mi arriva la mail

**Elena Spini:** Sicuro anche nello spam per assurdo.

**Marco:** magari un Academy, una master fare animale nostro il

**Elena Spini:** Non dovrebbe, ma sen no te lo mando

**Marco:** personale. No, mandamelo te,

**Elena Spini:** io.

**Marco:** facciamo prima, sennò Sì,

**Elena Spini:** Vai. Reset.

**Marco:** vabbè,

**Elena Spini:** Vai.

**Marco:** quella è una piattaforma di kin che può essere come un già scritto quando qualcuno ha

**Elena Spini:** marco.m@apissimo.com.

**Marco:** voglia di Esatto. Eccolo qua. È arrivata, mi sa, quella di prima. Allora, è arrivata adesso.

**Elena Spini:** No, no, te l'ho mandato io.

**Marco:** Ah, ok.

**Elena Spini:** Fa niente, no problem.

**Marco:** Allora, adesso metto la mia password.

  
  

### **00:23:10**

  

**Marco:** La la rimetto uguale. Bienissimo. Ah no, c'è il codice di verifica, scusami. paghi con il punto qua invece fondamentalmente una volta che sono diventati quindi li hai pagati che può essere con lorra continuare ad utilizzare che può essere una sponsorizzata Instagram te quella giornata ne sono entrate e ci rifacciamo sto password. Ah, un deficiente. Paz, non sei su un sito dove ci sono altri due competit e quindi il cliente decide se venire da te o da qualcun altro. Qua sono tuoi i clienti, quindi per sforzarli dentro l'unico modo e faccio una sponsorizzata su Instagram con quindi invece di dare soldi a The Fork decidi tu qual è il tuo margine, quale può regalare il cliente, la regala al cliente il sesso e da lì farli prenotare direttamente oppure se tu inizi a puoi farlo fare immediato che tu immediatamente scelgono in base allora condivido. Quelli sono i suoi clienti,

**Elena Spini:** Ja.

**Marco:** quindi per non fare lo switch immediato facevano lavorare le due piattaforme, ma chiunque veniva con gli si dava un contributo e la prossima volta

**Elena Spini:** Ok.

**Marco:** se prenoterai dai oppure avrà cosa che si può voi lo vedete adesso lo schermo?

  
  

### **00:25:14**

  

**Marco:** L'abbiamo fatta.

**Elena Spini:** Sì.

**Marco:** Ottimo. Concreto.

**Elena Spini:** Eh, non sei ancora dentro, però.

**Marco:** Provo a richiamarti. C'ho lo schermo, c'ho la dashboard aperta davanti, non la vedete? No,

**Elena Spini:** Eh, vedo la pagina del login ancora. Io l'ho vista per un attimo,

**Marco:** ma io sono già dentro,

**Elena Spini:** ma poi solo

**Marco:** sono già entrato.

**Elena Spini:** io vedo come se fosse la la Ok, ora ora ci sono. Non so se ero Sì,

**Marco:** Ah,

**Elena Spini:** ora sì.

**Marco:** forse era nello schermo di sotto e non quello di sopra.

**Elena Spini:** Perfetto,

**Marco:** parte delle oppure fare analisi fisifiche nell'operatività di tutti i

**Elena Spini:** ci siamo. Allora,

**Marco:** giorni c'è l'

**Elena Spini:** questa vabbè è la pagina iniziale che attualmente vedi se tutto a zero,

**Marco:** abbonamento.

**Elena Spini:** perché dobbiamo ancora iniziare a sistemarla, ma ci interessa poco. In alto tu hai tutti gli oggetti che usi, quindi lead, account, referenti, prodotti, eccetera. Considera che per questa prima fase di test hai un'utenza da super admin, quindi puoi fare cose che in realtà poi eh poi magari quando vediamo nel dettaglio negli account, tu come eh diciamo ruolo commerciale non potrai andare a modificare, ma sono cose che andrà potrà potrà modificare il Fabrizio di turno perché va a toccare l'integrazione con Maxal.

  
  

### **00:26:55**

  

**Elena Spini:** Ma andiamo per step.

**Marco:** Ok.

**Elena Spini:** Ehm, non so, facciamo, anzi, vediamo adesso tipo un account. Vai, ad esempio, sugli account. Ok. Allora, questa e avevo fatto prima dei test io per vedere se effettivamente vedevi vedevi tutto. Eh, Sales Force ragiona con sempre con la stessa logica, quindi ogni volta che tu clicchi su il tuo oggetto lead account referenti, vedrai sempre come prima battuta i recenti. Per vedere tutti gli account ti devi portare su dove c'è la scritta ricenti c'è una piccola freccetta nera. Perfetto. Quelle si sono del tutte le list view che eh per ora sono state configurate, ciò non toglie che tu in un secondo momento ti potrai creare la tua listew. Ok? Quindi su tutti gli account vedrai tutti gli account, su solo le aziende vedrai solo le aziende, su locali vedrai solo locali. Se tu un giorno ti vuoi fare una tua list view viw particolare filtro o un dei particolari campi da far vedere, eh è come se fosse una sorta di ehm vista filtrata di tutti i record disponibili nella nella org.

  
  

### **00:28:22**

  

**Elena Spini:** Quindi prendiamo ad esempio un qualsiasi account, torniamo su tutti gli account. Perfetto. Se ne conosci uno, sei familiare con qualcuno, provi puoi anche cercarne uno. Eh, considera che in alto, dove c'è il cerca, in alto, in alto. Sì, lo puoi cercare lì o puoi cercare lì sopra. Cos'è la differenza? Questa questa ricerca cerca in tutti gli oggetti. Infatti vedi che ci sono usciti sia le opportunità che quel questo qua arancione è un'opportunità legata a questo restaurant sia gli account. Invece dove stavi andando te e cerca in questo elenco, quindi cerca solo negli account. Esatto,

**Marco:** Ok, chiaro.

**Elena Spini:** perfetto. Quindi prova a cercarti un account che tu conosci e non lo so, così magari vediamo qualcosa di un po' più familiare.

**Marco:** Allora, posso mettere il nome nome anche della persona titolare? Vedo qui il cognome

**Elena Spini:** Sì, questo in realtà è prova è sia cerca anche su il resto,

**Marco:** qualsiasi vedere.

**Elena Spini:** però vediamo se eh se lo metti il

**Marco:** Appena sentirate, voi avete il

**Elena Spini:** nome sopra nella ric.

  
  

### **00:29:52**

  

**Elena Spini:** che lì sicuro c'è.

**Marco:** prima addirittura Ma abbiamo importato tutti

**Elena Spini:** Ma poi dipende se li abbiamo portati,

**Marco:** quanti.

**Elena Spini:** eh,

**Marco:** Ah,

**Elena Spini:** non lo so.

**Marco:** ecco. Secondo me non li abbiamo portati perché adesso potrei mettere anche

**Elena Spini:** Forse sui contatti. Eh, sì, può essere. prova che è più facile il l'account, quindi l'azienda proprio,

**Marco:** Allora qui. Ah, no,

**Elena Spini:** perché secondo me sui contatti forse c' Sì,

**Marco:** qua. Allora,

**Elena Spini:** vabbè, è uguale o quio sotto.

**Marco:** no, GB ristorante non c'è.

**Sabatino Rinaldi:** Prova la pergola 2 che sicuro c'è.

**Marco:** Ah, sì,

**Sabatino Rinaldi:** C'è sempre la pergola

**Marco:** l'ho vista sotto di quindi è possibile chieder eccola qua la carta

**Elena Spini:** Bene, bye bye.

**Marco:** eventi

**Elena Spini:** Ok, quindi qua ci sono tutte le informazioni di dettaglio di questa di questa

**Marco:** potete mettere

**Elena Spini:** azienda. Se scorri, ti faccio vedere quelle che dicevo che tu adesso puoi editare, ma poi non sarà una un qualcosa che tu puoi fare un con i

**Marco:** aprile addirittura anche dei capiti

  
  

### **00:31:03**

  

**Elena Spini:** permessi corretti. Vedi questi dati Mexal?

**Marco:** quindi di fare delle domande specifiche al cliente

**Elena Spini:** in realtà sono fate molta attenzione, cioè tu adesso vedi la matitina,

**Marco:** particol

**Elena Spini:** cioè vuol dire che tu puoi andare a editarli, ma in realtà siamo collegati con l'ambiente di Mexal di produzioni,

**Marco:** è totalmente personalizzabile.

**Elena Spini:** quindi attenzione a tutto ciò che è Mexal,

**Marco:** Chiaro, chiaro,

**Elena Spini:** ok?

**Marco:** chiaro.

**Elena Spini:** Quindi fate tutti i test che volete, però mi raccomando, cioè con molta attenzione. Ehm,

**Marco:** Touch logo.

**Elena Spini:** perfetto. Yes, please. O poi devi sentirti con Fabrizio a tuo rischio e

**Marco:** No, no, no, no, no. Mi costbe. Troppe caramelle.

**Elena Spini:** pericolo.

**Marco:** Costerebbeione

**Elena Spini:** Perfetto. Ehm, ok,

**Marco:** i dati che siccome milione volte

**Elena Spini:** vogliamo provare a fare un giro dal lead dall'inizio? Vai lead anche,

**Marco:** bene succederà la stessa cosa anche ai vostri clienti.

**Elena Spini:** vedi, vedi ad esempio qua lead stessa logica,

**Marco:** Una volta che la faccio volta vedrno già i campi compilati non

  
  

### **00:32:02**

  

**Elena Spini:** vedi come se non ci fosse niente da visualizzare,

**Marco:** devono fatto un'altra volta adesso.

**Elena Spini:** ma perché sei su recenti. Questo è molto importante da ricordarsi, cioè non no panic è solo la visualizzazione recente,

**Marco:** Quindi nella fase presentazione

**Elena Spini:** soprattutto per le prime volte non vedi niente perché non hai ricercato niente,

**Marco:** scelgo fanno scegliere

**Elena Spini:** quindi tutti lead. Perfetto.

**Marco:** il giorno di prenotazione escono le fasce le

**Elena Spini:** Ed ecco qua tutti i lead. Vedete anche tutte quelle schifezze perché stiamo facendo i test.

**Marco:** modifiche giorno

**Elena Spini:** Ora nuovo. Facciamo un un esempio di un leader che creiamo noi da zero

**Marco:** fasce radi rimaste disponibili, quindi se voi mettete 10 prenotazioni a fas Lo potevate mettere un pochino

**Sabatino Rinaldi:** nuovo in alto a destra.

**Marco:** scorso?

**Elena Spini:** e questo è il standard.

**Marco:** Era giusto per rompere le scatole.

**Elena Spini:** Allora,

**Marco:** Esatto.

**Elena Spini:** facciamo eh questo. Adesso vedi diretta perché in realtà è una tipologia, ma diretta verranno creati in automaticamente dai form della diretta. Perfetto.

**Marco:** Chiaro gennaio magari oppure fate dei servizi?

  
  

### **00:33:01**

  

**Elena Spini:** Standard.

**Marco:** No,

**Elena Spini:** Tra l'altro ne approfitto per chiedere a Sabatino che c'è ci serve anche il form della diretta che così poi almeno facciamo i

**Marco:** no.

**Elena Spini:** test con dei formini perché per ora stiamo usando un form brutto.

**Sabatino Rinaldi:** Il form della diretta è identico agli altri forum,

**Elena Spini:** Ma ne avete uno?

**Sabatino Rinaldi:** no? Lo creiamo quando facciamo una diretta, ma è uguale a quelli del food marketing, cambia rivenditori, non cambia niente.

**Elena Spini:** No, lo so. Però ci sono, sai, per i campi nascosti, queste cose qua. Vabbè, ok, lo farete poi, non è un problema. Per ora per i test abbiamo creato un test. Mh, è quello che ti ho mandato, tra l'altro, Marco. Poi ne facciamo uno e lo facciamo. Vediamo la differenza dei due.

**Marco:** Non so se aveva rapidissimo

**Elena Spini:** Allora, qua puoi mettere anche solo c'è un nome e un cognome che vuoi. Mh,

**Marco:** no molto chiaro. Il mio

**Elena Spini:** come vuoi. Ora puoi sbizzarrirti e fare tutti i test che vuoi.

  
  

### **00:34:02**

  

**Elena Spini:** Quindi questo è solo un un giro che facciamo

**Marco:** Ok, ok, ok, va bene. Il telefono m'ha preso. Va bene questo. Ok. Qui sulla destra dei dati,

**Elena Spini:** e salva.

**Marco:** numero dipendenti, eccetera eccetera. Ok, va bene. 10 partita IVA.

**Elena Spini:** Ah, partita IVA. partita IVA è importante anche in quello è paese, però

**Marco:** Ah, perché c'era itaria delle orar un pochino più intimo e

**Elena Spini:** esatto.

**Marco:** faremo

**Elena Spini:** Ehm partita IVA è importante e l'abbiamo dovuto mettere perché quando andiamo a creare l'account poi facciamo anche il check e sulla

**Marco:** avete scegliere al cliente,

**Elena Spini:** partita IVA.

**Marco:** scegliere perché questo

**Elena Spini:** sul la correttezza della partita IVA con una

**Marco:** sale creare

**Elena Spini:** chiamata ad Anticipay che è il servizio che controllo se effettivamente la partita IVA è una esistente se fosse inventata poi eh tra virgolette mandiamo

**Marco:** avete bisogno di sapere chiedere,

**Elena Spini:** le notifiche a Fabrizio ed Elisa per dirgli attenzione vedete che questo tizio ha messo

**Marco:** però è per far capire che domande

**Elena Spini:** la partita IVA inventata, potrete avere, anzi avrete problemi nella fatturazione.

  
  

### **00:35:25**

  

**Marco:** Ma il fatto che dice rilevato errore è proprio per questo motivo? Già. No, chiaramente.

**Elena Spini:** Sì. No, no, no,

**Marco:** Ah ah,

**Elena Spini:** è solo perché non l'avevi messa in una prima fase.

**Marco:** ok.

**Elena Spini:** Ora puoi anche scrivere 1 1, non succede niente.

**Marco:** Ah, ok.

**Elena Spini:** anche perché tante volte nei form eh mi sembra di aver capito che a volte per eh praticità le persone mettono le cose anche abbastanza a caso solo Да.

**Marco:** sono quindi

**Elena Spini:** magari mettere le informazioni e non li blocchiamo per questo,

**Marco:** andare avanti.

**Elena Spini:** eh lo facciamo entrare e poi facciamo i controlli dopo.

**Marco:** Ok.

**Elena Spini:** Salva addirittura ne hai messo una a casa o lo sapevi la partita IVA?

**Marco:** Sarò sempre io considerazione

**Elena Spini:** Eh,

**Marco:** abbiamo bisogno. Allora, attendenti la nostra non so quanti sono, mi sa che ne manca uno. Qui non li conta, però mi hai detto sì, no, li conta. Quanti sono adesso? No,

**Elena Spini:** no, no, puoi mettere una a caso.

**Marco:** e c'è anche questa toccherà voi farlo. Forse il numero di telefono.

  
  

### **00:36:42**

  

**Marco:** Eh, ok,

**Elena Spini:** Eh,

**Marco:** metto no. Sì, sì, posso salvare tanto siamo in testa.

**Sabatino Rinaldi:** Sì, sì, puoi mettere anche nota nel senso informazioni di Google quelle.

**Elena Spini:** no, aspetta.

**Marco:** Cosa è successo? Ok. Ehm, allora la figura per me il centrale.

**Elena Spini:** No, non ho visto cosa hai detto. Metto no.

**Marco:** No,

**Sabatino Rinaldi:** No.

**Marco:** era se salvava il i dati che avevo messo. Sì, ha proprio una conversazione con loro.

**Elena Spini:** Sei riuscito a salvare? Non so, non ti vedo più io.

**Marco:** Non mi vedi più. Sono sempre qui, non mi sono mosso.

**Elena Spini:** Mh mh.

**Marco:** Interrompi condivisione.

**Elena Spini:** Ma sei riuscito a salvare?

**Marco:** Aspetta. Eh, sì, sì, sì. Aspetta che ti ricondivido. Aspetta che magari boh, se l'ha saltata.

**Elena Spini:** Ok.

**Marco:** Sì. Eh no, non credo che ci sia No, no, no, non lo dico. Non credo che ci siano a maggior ragione locale. Non so se hai già visto problematiche. No, questo è un altro. originaria delle robe siamo molto molto comp è andata a finire posto

  
  

### **00:38:20**

  

**Elena Spini:** Ok,

**Marco:** password perché adesso sto via a San Marino, però l'inia della blusa questo non c'entra niente. Giulianova ero qui adesso. Ciao Ah, va bene dai. Eccolo. Troppa roba aperta.

**Elena Spini:** perfetto.

**Marco:** E beh, come Dai come un mare che vive solo le due i due mesi d'estate

**Elena Spini:** Perfetto. Questo è il tuo lead che hai salvato. Sali in alto. Cioè,

**Marco:** che lavoro originario ma originario invece di dove

**Elena Spini:** eh vedi che c'è Mettiti al

**Marco:** sei?

**Elena Spini:** centro.

**Marco:** Sì,

**Elena Spini:** C'è la schermata.

**Marco:** ovviamente devi devi collegare un un account almeno

**Elena Spini:** Perfetto. E porta in sul Non so come dirlo.

**Marco:** €20.

**Elena Spini:** Bravo. Grazie.

**Marco:** Sì. Eh sì, lì c'è la se voi la mandare Sì,

**Elena Spini:** Mi veniva cursore, ma eri già lì, quindi no, non andava bene il cursore.

**Marco:** sì, sì, va bene, va bene.

**Elena Spini:** Perfetto. Allora, quindi qua abbiamo, diciamo, tutti gli stati dei lead. La prova che faremo dopo, quella con la simulazione della diretta, avremo invece i solo due stadi,

  
  

### **00:39:38**

  

**Marco:** Piccolo il mondo.

**Elena Spini:** due stati della diretta.

**Marco:** Perché no?

**Elena Spini:** Quindi qua abbiamo il nostro nuovo in lavorazione non risponde,

**Marco:** Guarda su alcuni della piattaforma già

**Elena Spini:** primo contatto qualificato quando effettivamente poi andiamo a convertire il nostro il nostro

**Marco:** bello che

**Elena Spini:** lead in lavorazione il momento in cui il

**Marco:** così la forma un pochino di dat ci servono,

**Elena Spini:** m chi ha a che fare con il signor

**Marco:** altrimenti quando si va a fare durante il corso tu non non

**Elena Spini:** Montesi Test effettivamente inizia a lavorarci.

**Marco:** segue. Eh,

**Elena Spini:** Quindi per far capire a

**Marco:** allora no quello mi era qua.

**Elena Spini:** il il grande capo Marco,

**Marco:** Qua è vero

**Elena Spini:** come fa a capire su quali eh su quali lead sta

**Marco:** qua entrati senza

**Elena Spini:** lavorando il il tutor di turno, il tutor deve mettere in lavorazione,

**Marco:** perché

**Elena Spini:** quindi si va in lavorazione il pulsante Marquez Current Stage.

**Marco:** fuori contatto anche

**Elena Spini:** Questo dobbiamo ricordarci di tradurlo.

**Marco:** basta con il telefono non hai nome cognome tutto il resto il telefono

  
  

### **00:40:37**

  

**Elena Spini:** Lo segno.

**Marco:** entra.

**Elena Spini:** Prova a farlo.

**Marco:** Sì, lab i partite aggiornativi e lo camminino per sollezza artificiale che già per allora con la tua versione di piattaforma hai comunque perché voi avete vabbè

**Elena Spini:** È andato.

**Marco:** non lo vedi? No, dove c'è la catenia. Allora, la differenza tra i due la sono Io ti sento.

**Elena Spini:** Mi mi senti?

**Marco:** Sì, sì. è che tolgo l'audio perché qui c'ho tre ragazze che chiamano e faccio a quest'acqua. Io ti sento, ti vedo qui ho cliccato e siamo in lavorazione.

**Elena Spini:** Perfetto. Ok. Eh, non lo so, forse ti vedo come se stavi per cliccare e si è frizzata la pagina.

**Marco:** Ah, può Ah,

**Elena Spini:** Non so perché c'è questo problema di condivisione oggi.

**Marco:** può essere, può essere può essere può essere.

**Elena Spini:** Boh. Ok. Ehm,

**Marco:** E lui glielo con lui nonce

**Elena Spini:** perfetto, mi faccio lo screen screenshot di eh il Ah,

**Marco:** così

**Elena Spini:** ok. Si è aggiornato adesso, pensa te. Cioè, vabbè,

**Marco:** Eh,

**Elena Spini:** ha i suoi tempi oggi,

  
  

### **00:41:58**

  

**Marco:** così eh ci sta,

**Elena Spini:** non lo so. Ehm,

**Marco:** ci sta.

**Elena Spini:** forse è lunedì per quello, chi lo sa.

**Marco:** può essere intanto la

**Elena Spini:** Allora, poi cosa abbiamo dopo?

**Marco:** riapro che può essere invece Allora,

**Elena Spini:** dopo abbiamo ehm il Non risponde.

**Marco:** la cosa più urgente esattiamo

**Elena Spini:** Quindi, ad esempio, magari eh avete fatto i vostri contatti e comunque non eh volete

**Marco:** quello che sono

**Elena Spini:** tracciare che questo tizio non è più da richiamare o magari è da fare un una particolare azione.

**Marco:** Ok, grazie mille a te. Ah,

**Elena Spini:** Provi a fare non risponde. Ne.

**Sabatino Rinaldi:** E Marco, ma riesci a spostarti da lì? Perché io faccio fatica a sentire Elena che parla?

**Marco:** eh, se mi sposto da qui dopo non c'ho più. Mi posso spostare? Ci provo. Solo che mi avete Ecco, mi vedete ancora?

**Sabatino Rinaldi:** No.

**Marco:** Eh,

**Elisa Migliano:** No.

**Marco:** per forza, perché avevo due schermi. Adesso cambio lo schermo. Aspettate, eh, rimanete lì. così complicato te lo permetterà che riesci a tenere tutto mentre spostato un pochettino.

  
  

### **00:43:18**

  

**Marco:** Vediamo se entr nel giro. Allora, riabilitiamo permette di avere talmente tanti sul cliente che ti permette di Faccio un esempio al Bauti che è il locale lo vedete adesso nel cucina che offre

**Elisa Migliano:** No.

**Elena Spini:** No.

**Marco:** sullo schermo PC non escono per andare a fare due parti sei d'accordo io aver fatto sicuramente nove

**Sabatino Rinaldi:** Marco capisce. Elena, ti volevo chiedere, ma io posso averlo un accesso?

**Elena Spini:** Non ho capito.

**Marco:** parlare Yeah.

**Sabatino Rinaldi:** Aspetta che disattivo Marco. Eh, dicevo, mentre aspett volevo chiedere io posso averlo un accesso?

**Elena Spini:** Beh, certo,

**Sabatino Rinaldi:** Ah, ok.

**Elisa Migliano:** Dipende cosa devi fare,

**Sabatino Rinaldi:** Come faccio?

**Elena Spini:** con la stessa accortezza,

**Elisa Migliano:** Sabatino. M.

**Sabatino Rinaldi:** Sì, sì,

**Elena Spini:** eh.

**Sabatino Rinaldi:** sì, sì, sì, sì, sì. Io faccio i miei test paralleli, però se mi dici come, come e dove faccio da solo. Ok.

**Elena Spini:** ti devo creare l'utenza e e poi con la stessa accortezza, come diceva Marco, perché verrete creati con utenza di amministratore.

**Elisa Migliano:** Perfetto.

**Sabatino Rinaldi:** Sì, sì, ma io non devo fare, devo solo guardare, quindi non farò nulla.

  
  

### **00:45:09**

  

**Elena Spini:** Perfetto.

**Sabatino Rinaldi:** Ok,

**Elena Spini:** Appena finita questa call faccio l'utenza e poi se hai problemi mi mi contatti,

**Sabatino Rinaldi:** va bene. Grazie.

**Elena Spini:** va bene?

**Marco:** Lo vedete adesso?

**Elisa Migliano:** Yes.

**Sabatino Rinaldi:** Sì, sì.

**Marco:** Ok,

**Elena Spini:** Perfetto.

**Marco:** se sentite lo sfondo ancora sentite un po' di sottofondo.

**Elena Spini:** Quindi sì,

**Sabatino Rinaldi:** Sì, non è cambiato quasi nulla,

**Elena Spini:** ma dai meno.

**Sabatino Rinaldi:** ma va bene.

**Marco:** Felice di servire.

**Elena Spini:** Perfetto.

**Marco:** però niente se lo andate vi permette di faria locale

**Elena Spini:** E ok. Quindi, dicevamo, appunto, ci sono i diversi stati, ok, del lead, avevam visto, appunto, non risponde, primo contatto e eccetera. Proviamo a fare la nostra prima conversione.

**Marco:** Ok, allora siamo qui.

**Elena Spini:** Ok.

**Marco:** Facciamo faccio l'esempio. Ah, scusami. Qui non risponde. Io qui chiaramente se non mi risponde lo voglio richiamare tra un tot perché magari mi risponde dico lo chiamo domani, lo chiamo dopodomani? Ok,

**Elena Spini:** Esatto. Puoi sempre segnarlo come non risponde come prima.

**Marco:** lo non lo guard sono ancora su uno risponde io.

  
  

### **00:46:44**

  

**Elena Spini:** Perfetto.

**Marco:** Ah, cioè non l'ho non l'ho confermato.

**Elena Spini:** Poi se se come la seconda Sì,

**Marco:** Non l'ho confermato.

**Elena Spini:** esatto,

**Marco:** Ok.

**Elena Spini:** esatto.

**Marco:** Ma se io da qui volessi segnarmi di richiamarlo fra due o tre giorni? Boh, per x motivi, come posso fare?

**Elena Spini:** C'era sempre la possibilità di creare i task.

**Marco:** Ok,

**Elena Spini:** Certo. Proviamo a creare un task, ad esempio. Ottimo.

**Marco:** ok.

**Elena Spini:** Quello è l'evento. Il task è quello verde.

**Marco:** Poi l'azienda la grafica dal dall'iPad

**Elisa Migliano:** E io nel caso non posso creare Elena anche l'evento che cioè più che

**Elena Spini:** Sì, sì,

**Marco:** in auto.

**Elisa Migliano:** altro con l'evento mi siento se io

**Elena Spini:** ma è semplicemente per come

**Marco:** Allora qui

**Elisa Migliano:** indicassi eventualmente un giorno,

**Marco:** sotto avete ununica che poi avete e

**Elisa Migliano:** l'orario eccetera, mi si collega un calendar Ok.

**Marco:** rifleto questa qui adesso l' andiamo a vedere. Ilapas serve per acquisire il contatto e non

**Elena Spini:** non ho sentito bene, ma si collega al calendario di Sales Force.

  
  

### **00:47:46**

  

**Marco:** siamo quindi passa un ambiente

**Elena Spini:** M.

**Elisa Migliano:** Yeah. Sì, era questo. Perfetto,

**Elena Spini:** Non è collegato al calendario.

**Elisa Migliano:** grazie. No, no, va bene, va bene, però è collegato al calendario di sees forse.

**Elena Spini:** Sì, sì, corretto.

**Elisa Migliano:** Ok.

**Elena Spini:** Sono eventi interni salesource.

**Marco:** e appena il tavolo è pronto lui applica un messaggio con ovviamente il tavolo è pronto, funziona un po' come se hai la fila fuori e devi aspettare che si il tavolo. far funzionare in due modi, però invece di scriverelo sul foglietto in strumento e lo questa qui mi comparirà la la campanellina rossa che lo devo richiamarcato

**Elena Spini:** Eh, non ho visto come l'hai creato.

**Marco:** anche la Si riapre modificaamente avevate detto che

**Elena Spini:** Eh no, non può crearsi la campanellina rossa perché quando l'hai messo normale è stato, cioè non c'è una data o sì, aspetta, non l'ho vista. Ecco. Ok.

**Marco:** 2210 22

**Elena Spini:** Sì, 2210. Sì, esatto.

**Marco:** priorità normale. Eh, cosa mi cambia questo?

**Elena Spini:** No, in realtà,

**Marco:** Normale è sempre quella.

  
  

### **00:49:04**

  

**Elena Spini:** cioè, sono non ci sono le logiche sotto. Esatto.

**Marco:** Perfetto, va benissimo. E a posto. Quindi rimaniamo sopra. Quindi posso mettere appunti e poi salvo. Perfetto.

**Elena Spini:** Esatto,

**Marco:** Va benissimo. Lo chiamo.

**Elena Spini:** perfetto. Avevamo detto che primo contatto era

**Marco:** Quindi io adesso se scrivo primo contatto non me lo fa fare perché prima non ho confermato il non risponde.

**Elena Spini:** No, in realtà lo puoi forzare,

**Marco:** E lo facciamo. Tac.

**Elena Spini:** soprattutto adesso che poi hai questi super permessi, puoi fare tutto quello che vuoi.

**Marco:** Sono i super poteri. Sono sono braccio di ferro.

**Elena Spini:** Sì, esatto.

**Marco:** Ok.

**Elena Spini:** E qua avevamo detto che era quel un forse un potenziale cliente, ma per ora ci sta ancora pensando e magari anche lì

**Marco:** Ehm questi due invece devi mettere

**Elena Spini:** potrebbe essere ricontattato in un secondo momento,

**Marco:** Ok. E quindi vado a a rifare un altro task nel caso in cui Perfetto.

**Elena Spini:** se vuoi. Sì, esatto.

**Marco:** Molto bene.

**Elena Spini:** Perfetto. Invece abbiamo poi qualificato e non qualificato.

  
  

### **00:50:18**

  

**Marco:** Ottico

**Elena Spini:** Mettiamo prima non qualificato perché sennò poi non possiamo tornare indietro. Sol tanto adesso puoi puoi anche tornare indietro te perché hai sempre i super poteri

**Marco:** inserisci e poi va a selezionare molto bene. Eh, ma dopo anche se mi se me li toglie dopo ci sto male.

**Elena Spini:** e eh Sì, esatto.

**Marco:** Fabri, dobbiamo fare qualcosa qui. I super poteri bisogna che me li fai lasciare.

**Elena Spini:** Allora, qua guarda se ti tornano tutte le motivazioni che abbiamo messo, che erano man quelle che avevamo condiviso. No.

**Marco:** Allora, qui c'ho perso errato in funzione di questo. si attiveranno queste, suppongo.

**Elena Spini:** Esatto.

**Marco:** Facciamo prima le errate che sono indiscutibili e quelle ha già PO e quindi mi sta chiamando per P e quindi è un un barbag e siamo già in contatto. Benissimo. Dati per il contatto inesatti duplicato da CRM. Speriamo che non succeda mai. Non in target ci sta. Richiesta inviata per errore male male, ci fa perdere tempo e software house agenzia di marketing basic che l'abbiamo accolpati tutti insieme e attività di test.

  
  

### **00:51:23**

  

**Marco:** Molto bene. Il perso abbiamo che non è interessato. Qui si sarebbe interessante mettere aggiungere, non so se è possibile un altro livello e per capire non sei più interessato per quale motivo. Noiamo che se non sei più interessato, però ce lo deve spiegare perché non è più interessato, visto che comunque siamo arrivati fino fino a qua, insomma. Poi vabbè, il prezzo alto,

**Elisa Migliano:** Io lo toglierei quasi non interessato. È veramente troppo vago.

**Marco:** eh, appunto, però se lo togliamo potemo capire,

**Elisa Migliano:** Cos'altro mette? Chiaro?

**Marco:** cioè l'ideale sarebbe avere un campo testuale di fianco,

**Elena Spini:** Eh, esatto,

**Marco:** magari solo che perché alla fine uno dice interessato,

**Elena Spini:** infatti stavo pensando

**Marco:** ma le variabili potrebbero essere tante perché le possiamo identificare anche noi, ma poi secondo me potrebbe invece starci

**Sabatino Rinaldi:** Sì, però occhio, eh, occhio, eh, perché noi ok,

**Marco:** Eh,

**Sabatino Rinaldi:** il testo libero, ma diamoci magari un campo in più, nel senso questo campo qui a tendina lo lasciamo e in più mettiamo un campo note,

**Marco:** davanti.

**Sabatino Rinaldi:** cioè un campo di testo, perché altrimenti io già lo so che poi i commerciali non metteranno niente lì dentro o

  
  

### **00:52:34**

  

**Marco:** Ah,

**Elena Spini:** No,

**Marco:** ma io glielo faccio mettere sennò

**Sabatino Rinaldi:** mettono o mettono cose a casa senza senso.

**Elena Spini:** piuttosto possiamo fare se se scegli perso non Se scegli perso non interessato, allora devi compilare obbligatoriamente per salvare questa

**Marco:** e

**Elena Spini:** impostazione motivazione di non interesse.

**Sabatino Rinaldi:** Esatto. Sì, sì, sì. Facciamo così.

**Elena Spini:** Campo testo libero.

**Sabatino Rinaldi:** Facciamo così.

**Marco:** leil sono sempre gratuite. Poi se a ai pienissimi che sono in diretta gli viene in mente che nel perso ci possa stare qualche altra macro. Per me son queste poi però ripeto,

**Elena Spini:** Vabbè, per ora va bene. Poi se se vi viene in mente qualcosa poi me lo fate sapere. Eh,

**Marco:** casomai capiamo come dici tu,

**Elena Spini:** mi sono Esatto.

**Marco:** Elena.

**Elena Spini:** Poi c'è adesso avete lo strumento, quindi potete fare tutte le vostre descrizioni.

**Marco:** Ok.

**Elena Spini:** Eh, mi dici solo come chiamiamo questo nuovo campo, perché non sono tanto con tanta fantasia. Motivazione di non interesse. Non lo so.

**Sabatino Rinaldi:** Motivazione Ia.

**Elisa Migliano:** Va bene.

  
  

### **00:53:39**

  

**Elisa Migliano:** Sì,

**Marco:** motivazione basta.

**Elisa Migliano:** sì, tanto loro già cliccano, non interessato,

**Elena Spini:** Ok.

**Elisa Migliano:** è una conseguenza.

**Marco:** for eare dopost.

**Elena Spini:** E deve essere obbligatorio solo in questo caso. No.

**Sabatino Rinaldi:** Eh,

**Marco:** Sì, perché L'unica

**Sabatino Rinaldi:** direi di sì perché è l'unico più vago.

**Elisa Migliano:** Io anche in scegliere concorrenza metterei quale concorrenza?

**Sabatino Rinaldi:** Eh, bravo.

**Elisa Migliano:** se lo sanno.

**Sabatino Rinaldi:** Sì, sì, sì, sì, sì, sì. Anche in realtà anche sul servizio non adatto andrebbe messa la motivazione perché il

**Elisa Migliano:** Sì,

**Sabatino Rinaldi:** servizio non è adatto?

**Elisa Migliano:** ma in realtà, cioè, secondo me si potrebbe mettere in tutti perché tipo anche prezzo alto si può semplicemente

**Marco:** cosa che dovete messaggio

**Elisa Migliano:** tenere monitorato l'andamento dei clienti, quanto adesso sono disposti magari a spendere,

**Marco:** direttamente

**Elisa Migliano:** se veramente il prezzo è troppo alto per loro. Quindi o lo lasciamo in tutti a sto punto e si spiega ai tutor.

**Marco:** Sì. No, considerate che in teoria il prezzo alto non è una motiva di un motivo di non acquisto, perché in realtà è più facile che nel 99% dei casi sia un'ubizione che noi dobbiamo andare a smuntare e dobbiamo andare a sfruggugliare per capire perché il prezzo è

  
  

### **00:54:50**

  

**Elisa Migliano:** Eh, esatto.

**Marco:** alto. Però è anche vero che c'è quel cliente che alla fine della fiera non ne vuole più sapere, ti dice "Per me costa troppo malgrado noi cerchiamo di fare i maghi del per andare a capire del perché e il per come". Il cliente non te lo dice. Quindi in ultima analisi diciamo che per me quella come motivazione dovrebbe essere quella meno utilizzata. Eh quindi non ci accontentiamo chiaramente di una risposta tanto che che tanto per averla, ma dobbiamo andare in profondità. Questo però è il livello che mi crea, diciamo, il cluster di riferimento e quindi, come giustamente stavano dicendo i ragazzi adesso, anche su sceglie concorrenza, quale concorrenza, cioè da chi è andato, anche quello secondo noi è un'informazione più che più che utile, più che strategica. Quindi lì ci dovrebbe essere su sceglie a concorrenza, un menù a tendina che poi tira fuori i nostri 10 interpetrivo da mano, non lo so per qual è la strada.

**Elena Spini:** Beh, forse vi conviene che lo scrivano a mano perché cioè penso che sia anche un cioè un non so un po è un campo da mantenere,

  
  

### **00:55:59**

  

**Marco:** Sì, ma lì va bene. Quello è il meno. Quello è il meno.

**Elena Spini:** quindi forse è meglio se lo mettete a mare libero.

**Elisa Migliano:** Io io lo lascerei per tutti e poi dopo si si valuta. Да.

**Elena Spini:** Va bene,

**Marco:** Stiamo lavorando per arrivare ad essere integrati al 50% vedere qua

**Elena Spini:** ottimo, segnato. Ehm,

**Marco:** censare

**Elena Spini:** questo quindi era la parte non qualificato. Se adesso invece andiamo a fare qualificato, tanto non abbiamo salvato, quindi non Allora,

**Marco:** eventualmente si potete

**Elena Spini:** qua dobbiamo inqualificato. Aspetta, cioè se tu adesso lo salvi non lo puoi salvare. Prova. Chi vuole la gente? Eh no,

**Elisa Migliano:** Yeah.

**Elena Spini:** mi sa che Aspetta, ne avevamo una, aspetta che non mi ricordo come si chiama. Carla, Caca,

**Marco:** C.

**Elena Spini:** Carmen.

**Marco:** Eccola qua.

**Elena Spini:** Eh, se non sbaglio, fammi giusto verificare se mi sembra che per te stiamo usando lei,

**Elisa Migliano:** Sì,

**Elena Spini:** se non sbaglio.

**Elisa Migliano:** l'abbiamo fatta l'altra volta. È l'unica che abbiamo fatto, mi sa.

  
  

### **00:57:17**

  

**Elena Spini:** Giusto verificare se è attiva. Sì, confermo. Puoi usare lei. Perfetto. Quindi ora cosa ci aspettiamo? Eh, che succede? Ci aspettiamo che Mister Montesi Test diventa il referente, quindi il contatto della nostra società, quindi azienda Montese srl nello stesso momento. Quindi noi avremo oggetto 1 account Montesi srl, oggetto 2 correlato il nostro lead, quindi le informazioni del lead verranno riconfiate sul referente e oggetto tre verrà in automatico creata un'opportunità.

**Marco:** e il nostro strumento per il maringizzato.

**Elena Spini:** Vai.

**Marco:** Confermo.

**Elena Spini:** Yes. Qua si è riportato anche eh il task call che avevi segnato, cioè quindi si porta lo storico delle azioni che avevi fatto prima. Perfetto. Ehm se scorri trovi tutte le informazioni che dicevamo prima. Il contatto è il lead di prima che è diventato contatto

**Marco:** Invece di cercare di voce ti

**Elena Spini:** in tesi test.

**Marco:** sei canterai eccetera

**Elena Spini:** Perfetto. E collegato hai anche l'opportunità,

**Marco:** eccetera.

**Elena Spini:** quindi la se sali,

**Marco:** puoi cantare questoaggio che sia per capire se è stato bene o non è stato bene, quindi fai

  
  

### **00:58:52**

  

**Elena Spini:** quindi nei tab di vedi dettaglio correlato,

**Marco:** ma anche allora

**Elena Spini:** fatture e scadenza fatture nel tab correlato, quindi verso sinistra.

**Marco:** Ah, questo

**Elena Spini:** Esatto, corretto. Lì vedi gli oggetti che sono correlati a questo account. Avrai tutto lo storico. Per ora hai solo il contatto e l'opportunità che sono i nostri due unici

**Marco:** certo. Ok.

**Elena Spini:** oggetti. Poi se effettivamente farai ordini, se ci saranno contratti, se ci saranno eh biglietti, troverai tutto là sotto. Perfetto. Apriamoci l'opportunità.

**Marco:** E perico

**Elena Spini:** No, aspetta, dove siamo finiti? Mi sono distratta un attimo, stavo aprendo. Eh, puoi chiudere un secondo? Ti volevo far vedere direttamente l'opportunità che si era creata. Tu dove sei andato?

**Marco:** Allora,

**Elena Spini:** Su nuovo.

**Marco:** io da nuovo

**Elena Spini:** Ok. Io in realtà volevo farti vedere l'opportunità che già hai che è quella.

**Marco:** Ok, cioè Cioè,

**Elena Spini:** Quindi se tu clicchi su Esatto,

**Marco:** questa questa è già l'opportunità.

**Elena Spini:** se tu clicchi su quel link o Montesi SRL o opportunità, come vuoi,

  
  

### **01:00:25**

  

**Marco:** Vado più faccio una leggermente

**Elena Spini:** finisci dalle in opportunità finisci nella vista generale. Se clicchi su Montesi srl entri proprio nella pagina dell'opportunità.

**Marco:** Ok.

**Elena Spini:** Perfetto. Quindi questa è la nostra pagina dell'opportunità. Abbiamo detto che un'opportunità si crea nel momento in cui il

**Marco:** è possibile creare puoi

**Elena Spini:** cliente è interessato a un preventivo,

**Marco:** uscire è possibile creare

**Elena Spini:** a un appuntamento che eh forse facevate le demo, giusto? Perfetto. Le demo e anche semplicemente magari,

**Marco:** noi

**Elena Spini:** cioè per ora vuole una demo, quindi non è che magari è un preventivo,

**Marco:** Fai inserisce e va a inserire i

**Elena Spini:** però inizi a tracciare questa questa tipologia di attività.

**Marco:** dati,

**Elena Spini:** Se invece vuoi creare un preventivo,

**Marco:** però

**Elena Spini:** hai il tasto sotto Montese srl nuovo preventivo.

**Marco:** invece oltre ad avere

**Elena Spini:** Montese srl nuovo preventivo.

**Marco:** più dritta

**Elena Spini:** Perfetto. Questo di default ti porta come nome preventivo Montesi srl. Puoi aggiungerci quello che vuoi. Quindi qua puoi scrivere test uno se ho quello che vuoi.

  
  

### **01:01:48**

  

**Marco:** come quella

**Elena Spini:** Di default abbiamo ehm

**Marco:** anche un determinato messaggi determinate email eccetera eccetera delle cose

**Elena Spini:** precompilati l'opportunità name che sarebbe

**Marco:** sono qua,

**Elena Spini:** l'opportunità sopra che sarebbe il contenitore di tutti i preventivi che poi tu vai a

**Marco:** quindi cinque dalla versione che vai a scendere m

**Elena Spini:** fare l'account name perché ovviamente è già così,

**Marco:** Sì,

**Elena Spini:** quindi tu non devi toccare niente, diciamo, dei campi grigetti. Expiration.

**Marco:** anche perché non me li fa toccare

**Elena Spini:** Esatto. Expiration date. Eh, non so perché è rimasto questi sono tutti rimasti in inglese, ora che ci penso. Faccio lo screenshot di questo. Ehm perché questo esatto di default 5

**Marco:** Questo è fra 5 giorni deverin

**Elena Spini:** giorni, ma comunque modificabile perché avevamo detto a ridosso degli eventi

**Marco:** all'interno

**Elena Spini:** potenzialmente si potrebbe non aspettare questi 5 giorni, ma serve anticipare. E condizioni di pagamento.

**Marco:** decidere se tramite

**Elena Spini:** Condizioni di pagamento sono quelle che poi si riallacciano a logiche di

**Marco:** decidere proprio la tipologia di e

**Elena Spini:** Mixal.

  
  

### **01:03:02**

  

**Marco:** diamo.

**Elena Spini:** Non chiedermi che cosa voglio dire nel dettaglio perché lo sapete sicuramente meglio di me, spero. Perfetto. Ehm, se vedi c'è anche il flag primario che viene messo di default. Perfetto. E questo per fare delle logiche quando poi effettivamente tu vai a creare diversi preventivi sotto la stessa opportunità.

**Marco:** nella

**Elena Spini:** Comunque def di default viene messo viene alzato a privario e poi fai in salvo.

**Marco:** marketing potete andare a gestire,

**Elena Spini:** Perfetto.

**Marco:** ok?

**Elena Spini:** Quindi eh anche qua stessa logica.

**Marco:** Quindi mettere diverse azioni

**Elena Spini:** finiamo nella nella pagina dei preventivi,

**Marco:** 30 giorni e gli ha risposto risposto finisce.

**Elena Spini:** nel nel dettaglio dei preventivi, dove hai le informazioni sulla sinistra di dettagli,

**Marco:** Tu inviti dopo giorni, ma tu nonamente il

**Elena Spini:** in alto i vari stati e vabbè qua incorrelato in ritineranno poi i file eccetera,

**Marco:** ritorna da capo e dopo 30 giorni gli

**Elena Spini:** le righe, le trance eccetera, ma lo vediamo mano.

**Marco:** ma carale invece tiene conto di diversi fattori fare

**Elena Spini:** Perfetto, andiamo a mettere dei prodotti.

  
  

### **01:04:18**

  

**Marco:** anzi diverseazionio,

**Elena Spini:** Vai in alto hai eh quattro bottoni,

**Marco:** quindi fare un di comunicazione attuale in base alla

**Elena Spini:** cioè scegli locale, crea tranche, genera PDF e gestisce i prodotti.

**Marco:** Quindi

**Elena Spini:** Il sligli locale l'avevamo messo perché c'erano delle logiche eh che avevamo

**Marco:** se risponde se non

**Elena Spini:** visto con Fabrizio ed Elisa che a volte il preventivo veniva fatto

**Marco:** rispondi mai dopo viene

**Elena Spini:** eh doveva essere intestato a il locale piuttosto

**Marco:** un'anno oppure addirittura da giorni tu lo vai solo a risvegliare

**Elena Spini:** che al gruppo.

**Marco:** con opp dobbiamo scegliere il locale di riferimento perché ne ha di più sotto la stessa regione sociale.

**Elena Spini:** Esatto. Esatto. E quindi quando ti serve dare un preventivo mirato a quel locale devi indicare il locale.

**Marco:** Ho una comunicazione di servizio.

**Elena Spini:** Comunque adesso non abbiamo

**Marco:** Mi si stanno scaricando gli auricolari, quindi tra un attimo metterò la la viva voce, ma mi sposto distanza, quindi insomma questo passaggio. Se non mi sentite più e devo gestire sta cosa.

**Elena Spini:** Ok.

**Marco:** E alle 22 prend No,

  
  

### **01:05:24**

  

**Elena Spini:** Vuoi farlo adesso o?

**Marco:** finché reggo. No,

**Elena Spini:** Ok.

**Marco:** tanto mi sposto però che così almeno basta soltanto che li tolgo.

**Elena Spini:** Va bene? E in realtà il bottone che serve a noi adesso è gestisci i prodotti perché dobbiamo andare a scegliere un prodotto da mettere nel nostro preventivo.

**Marco:** Vado via dalla piazza del mercato. Allora, eccomi qua. Mi sentite ancora?

**Elena Spini:** Ti sentiamo forte chiaro.

**Marco:** Passato ad unaa all l'altra, ma ancora Wi-Fi tiene grande esperimento. Eccomi, ci siamo, possiamo continuare? Grazie.

**Elena Spini:** Perfetto.

**Marco:** Oh,

**Elena Spini:** Ah,

**Marco:** che è successo?

**Elena Spini:** che pace.

**Marco:** Aspetta, eccoci qua.

**Elena Spini:** Quindi, dicevamo, bottone importante per questa prima fase è gestisci i prodotti perché noi adesso dobbiamo andare a creare il nostro preventivo. Perfetto. Quindi fai aggiungi i prodotti.

**Marco:** Cosa? Fabri, vuoi fare un bando o lo lasciamo per un'altra volta? Ok.

**Elena Spini:** Eh, allora m qua forse si fa prima di

**Elisa Migliano:** Lo lasciamo per un'altra volta dal bundle così facciamo

**Elena Spini:** che che prodotto possiamo utilizzare senza fare casini su Mexale eccetera?

  
  

### **01:07:39**

  

**Elena Spini:** anche se che forse lo sapete meglio di me

**Fabrizio Paganelli:** Scusate che avevo avevo avevo il microfono spento. Eh no, questi qui no. Vai più giù.

**Elena Spini:** o lo puoi scegliere se sai il codice o il nome.

**Marco:** Eh,

**Fabrizio Paganelli:** Questi qui sono tutti i test che aveva fatto solo Aurel.

**Marco:** F.

**Fabrizio Paganelli:** Non abbiamo neanche il codice nell'anagrafica. Vai più in su. Ecco, qui è strano che compaano anche dei codici articolo. Questo bisogna segnalarglielo ad Aurel. Compiono dei codici articolo tipo PEC 95, non lo so, però vai un pochino più in su.

**Elena Spini:** Perch è strano.

**Fabrizio Paganelli:** Ecco, ho visto Mastery. Digita Mastery, scusa. Eh, chi è Marco, vero?

**Marco:** Sì.

**Elena Spini:** Sì, Marco.

**Fabrizio Paganelli:** Eh, usa quello lì, guarda. Mastery, quello lì.

**Marco:** Me l'ha preso.

**Elena Spini:** Perfetto,

**Marco:** Ah, no, l'ha già preso.

**Elena Spini:** ne tiiamo uno.

**Marco:** Sì. Yeah. Ok.

**Elena Spini:** Sì, sì, l'ha preso, l'ha preso. Vedi che infatti sotto c'è rimuovi. Puoi fare salva.

  
  

### **01:09:05**

  

**Elena Spini:** Perfetto. Ora, eh se vuoi vedere dov'è finito il tuo il tuo preventivo incorrelato. Bravo. Il tuo preventivo.

**Fabrizio Paganelli:** Scusate,

**Elena Spini:** Sì.

**Fabrizio Paganelli:** qui bisogna guardarla un po' meglio la cosa perché magari la prossima volta che c'è anche Aurel perché vedo che non è comparsa la possibilità di mettere degli sconti, quindi lui ha ha selezionato il codice articolo, ha messo le quantità fine, però magari tutto la necessità di mettere i conti eccetera eccetera, capito?

**Elena Spini:** Sto facendo lo screen. e glielo dico. No.

**Fabrizio Paganelli:** Ad esempio, anche qui vedi manca un po' quello che c'era anche di là, unità di misura, quantità, prezzo di prezzo di listino, sconto, prezzo netto, in modo tale che il mano a mano che il tutoro inserisce ulteriori articoli righe articolo nel preventivo, anche un minimo la visione di quello che sta per andare a spendere.

**Marco:** anche

**Fabrizio Paganelli:** insomma, o meglio quello che sta per preventivare il cliente. Qui c'è prezzo, vedi? In quell'angolino c'era lì e prezzo, ma questo qui è il prezzo di listino di un biglietto.

  
  

### **01:10:27**

  

**Fabrizio Paganelli:** Se qui il tutor decide di mettere tre biglietti, bisogna che abbia la visione del del prezzo di listino totale e anche la possibilità di inserire uno sconto. Tipo prova ad esempio ad aggiungere l'Academy che ho visto che era la prima.

**Marco:** Quantità uno. Sì, l'avevamo vista sta cosa degli sconti, ne avevamo parlato.

**Fabrizio Paganelli:** Eh, mi sembra che l'avevamo già segnalato, ma probabilmente non c'è stato il modo il tempo di Comunque, visto che ci siamo

**Marco:** C'è un motivo per cui non ci sono qua.

**Elena Spini:** Eh no, in realtà glielo sto chiedendo anche live. Prova a fare un refresh. Quello non mi torna. Ci dovrebbero essere. Provo a fare un refresh e nel mentre gli sto chiedendo la cosa degli sconti.

**Fabrizio Paganelli:** Vedi qui, ad esempio, c'è totale complessivo 10.

**Marco:** Eccoli.

**Fabrizio Paganelli:** Ecco qui così compare. Però vedi anche qui manca. Se io gli voglio fare uno sconto, non c'ha la possibilità di inserirlo,

**Elena Spini:** Certo.

**Marco:** Esatto.

**Fabrizio Paganelli:** no? Se sicuramente gli verranno fatti degli sconti.

**Elena Spini:** e lo e sarebbe, cioè come l'abbiamo fatto,

  
  

### **01:11:44**

  

**Fabrizio Paganelli:** L'avevamo fatta nei bando.

**Elena Spini:** non mi ricordo dove avevamo fatto questa modifica, a livello A livello di riga o a livello totale?

**Fabrizio Paganelli:** Verdi

**Elena Spini:** A livello di riga.

**Marco:** di riga.

**Elena Spini:** Sì,

**Marco:** ogni riga,

**Elena Spini:** esatto.

**Marco:** il valore e poi il totale.

**Elena Spini:** Sui bando l'avevamo fatto Sì,

**Marco:** Ja.

**Elena Spini:** è vero. Sui band avevamo fatto quella cosa che avevamo fatto o metti il prezzo che vuoi o metti la

**Fabrizio Paganelli:** sì,

**Elena Spini:** percentuale e e se metti il prezzo che vuoi ti calcola la percentuale in automatico.

**Fabrizio Paganelli:** sì, perché era nato perché avevamo sbagliato fare il preventivo, poi abbiamo visto che non si poteva modificare, poi abbiamo giocato

**Elena Spini:** Sì, sì, sì, sì, mi sto ricordando. Ok. Eh, questa cosa qua la capisco e vi faccio sapere. Eh sì. Mh. In realtà non va bene neanche che hai dovuto refreshare. Il refresh dovrebbe essere automatico, ma questa vabbè, eh, me lo segno io.

**Marco:** Sì, qua ci dovrebbero essere anche i total,

**Elena Spini:** Cioè,

  
  

### **01:12:38**

  

**Marco:** no?

**Elena Spini:** dovrebbe essere quello

**Marco:** Poi i totali qua sotto.

**Elena Spini:** è No, in realtà queste sono solo le righe, poi dopo il totale esce dopo nel preventivo.

**Marco:** M mh.

**Elena Spini:** Eh,

**Marco:** Ok,

**Elena Spini:** questa è proprio una cosa standard che cioè non ci possiamo fare tanto, ma in realtà è cioè qua è solo per farti vedere. Ok, le hai messe,

**Fabrizio Paganelli:** M.

**Elena Spini:** poi ti faccio vedere dopo come funziona,

**Marco:** ok, ok.

**Elena Spini:** cioè come com'è il totale. Eh, questo era refresh. Ok, perfetto. Ehm, quindi torniamo nei nostri dettagli o comunque rimani lì, non è importante. e poi fare dobbiamo creare le tranche, quindi come dilazionare il pagamento di questo povero tizio che deve

**Marco:** Esatto. Sì.

**Elena Spini:** sborsare un bel po' di soldini. Quindi se faccio creat tranche ho la possibilità di eh scegliere quanti tranche abbiamo, non so, vedi tu come dividerle.

**Fabrizio Paganelli:** Qui non si può fare altro che due perché gli articoli sono due.

**Elena Spini:** Perfetto. Quindi prima tranch Sì, era uno o due.

  
  

### **01:13:51**

  

**Elena Spini:** Non non ho tanta scelta. Eh, metti tu delle

**Marco:** 34. 50. Allora, la prima trans gliela facciamo fare a fine novembre, facciamo a fine dicembre, tanto non paga nessuno qui, però intanto l'Academy ce la facciamo pagare qui. In realtà la dovremmo mettere un po' prima, ma va bene uguale.

**Elena Spini:** assegna questa tranche perché per ora hai messo la data, ma non hai segnato. Ok, perfetto. Se fa ti porti sul in alto dove c'è scritto prima tranche un di du c'è la freccetta.

**Marco:** Eh, freccetta.

**Elena Spini:** Perfetto.

**Marco:** Tac.

**Elena Spini:** Ottimo.

**Marco:** Basta.

**Elena Spini:** Ti rimane la tranche a cui che devi assegnare, quindi devi mettere data e assegnare la tranche.

**Marco:** Ok.

**Elena Spini:** Eh, vedi anche cuore fresh.

**Marco:** No,

**Elena Spini:** Perfetto.

**Marco:** non l'ho fatto. Non l'ho fatto.

**Elena Spini:** Ok. L'ha fatto in automatico o l'hai fatto te?

**Marco:** No, no,

**Elena Spini:** Non ho visto.

**Marco:** l'ha fatto in automatico.

**Elena Spini:** Ah,

**Marco:** Cioè, di là dava zero,

**Elena Spini:** ok.

**Marco:** però poi mentre andavo a fare ha avuto paura, ha fatto da solo.

  
  

### **01:15:13**

  

**Elena Spini:** Ora se andiamo comunque se ti riporti sul preventivo e puoi andare dal dal menù di

**Fabrizio Paganelli:** Так.

**Elena Spini:** navigazione quello a fianco. Vabbè, uguale,

**Marco:** Eh,

**Elena Spini:** non ti preoccupare. Non ti preoccupare. Preventivo.

**Marco:** qui.

**Elena Spini:** Sì, esatto. È che ce l'avevi anche prima,

**Marco:** Ah, ok,

**Elena Spini:** ma non è un problema.

**Marco:** ok.

**Elena Spini:** Vedrai che ti appena ti impraticherai capirai qual è la il

**Marco:** Ah, beh, sì,

**Elena Spini:** modo più veloce.

**Marco:** sì, certo, certo, certo.

**Elena Spini:** M eh se adesso vai in correlato, che era quello che stavamo vedendo prima, vedi le righe e le nostre due tranche che abbiamo creato.

**Marco:** Perfetto.

**Elena Spini:** Il totale, tra l'altro, eh, che prima dicevamo del totale, sali, sali, ce l'hai intestata. Che stupida, mi sono dimenticata. In testata, eh, vedi dove c'è numero preventivo, data di scadenza, sincronizzazione, tu hai il totale complessivo.

**Marco:** Ok.

**Elena Spini:** Ottimo. Quindi abbiamo messo i nostre righe, abbiamo messo le nostre tranche, quello che dobbiamo andare a fare è andare a creare il nostro preventivo, proprio il documento.

  
  

### **01:16:19**

  

**Marco:** Esatto. Sì.

**Elena Spini:** Quindi genera PDF e questo ci porterà in automatico lo statua in trattativa. Genera PDF. A posto. Sei verificato un errore di server interno.

**Marco:** Di chi?

**Fabrizio Paganelli:** Mi sa che oggi Elena

**Elisa Migliano:** Finito così.

**Elena Spini:** No, no,

**Sabatino Rinaldi:** Dai,

**Elena Spini:** l'ho fatto prima.

**Fabrizio Paganelli:** Come fa Google a avere residenza fiscale?

**Sabatino Rinaldi:** sarà un sarà un problema interno di

**Fabrizio Paganelli:** Scala in Italia.

**Elena Spini:** Aspetta, rimani lì. Faccio un altro bellissimo screenshot. Fatto, fatto. Eh, però purtroppo arrivano tutte le mail ad Aurel, quindi io non non posso neanche vedere cosa è successo. Possibile anche che ci stanno lavorando i ragazzi, anche perché prima l'ho fatto e funzionava.

**Marco:** Угуm.

**Elena Spini:** Allora, però vabbè, possiamo nel mentre eh prendiamo un'altra un altro preventivo che è nello stato che ti volevo far vedere perché ti volevo far vedere dove effettivamente poi finisce il il preventivo.

**Marco:** Ok.

**Elena Spini:** che è appunto la sezione file che sta sotto le attività lì. Lì sotto si carica il preventivo.

  
  

### **01:18:29**

  

**Elena Spini:** Quindi facciamo così, vai nella scheda totale dei preventivi, dove sei col cursore. Ah no, è il mio cursore, scusa. Era il mio cursore. Eh,

**Marco:** Ah,

**Elena Spini:** preventivi in alto,

**Marco:** no. Eh,

**Elena Spini:** in alto, in alto. Ah, dove vedi prodotti, opportunità preventivi. Esatto. No, devi proprio cliccare su preventivi. Esatto.

**Marco:** ok.

**Elena Spini:** Anche qua vedi che torni sempre su recenti,

**Fabrizio Paganelli:** Scusa,

**Elena Spini:** noi facciamo apriamo quella freccettina nera,

**Marco:** Ok.

**Elena Spini:** Lview, tutti preventivi. Poi in realtà ci sono anche diverse, vediamo se ne troviamo uno, tipo ad esempio il quarto in attesa accettazione.

**Fabrizio Paganelli:** una domanda. No.

**Elena Spini:** Dica.

**Elisa Migliano:** Come visualizzazione eh voi prevedete a elenco e

**Marco:** M.

**Elisa Migliano:** basta o anche Canban?

**Elena Spini:** Allora, c'è la la visualizzazione a canon,

**Elisa Migliano:** Domanda. Eh, ancora.

**Elena Spini:** però, cioè,

**Fabrizio Paganelli:** Ok.

**Elena Spini:** non è che siamo noi che lo prevendiamo, è salesw sul dopo lo vediamo.

**Elisa Migliano:** Sì, chiaro, chiaro.

**Elena Spini:** Non mi ricordo se è sull'oggetto preventivi,

  
  

### **01:19:40**

  

**Elisa Migliano:** Ok. M.

**Elena Spini:** ma c'è c'è qualcosa. Mi sa che sta sulle opportunità, se non sbaglio. Sì, adesso scorri. Marco, scendi, scendi. Perfetto. Qua che cosa è successo? Eh, è successo che è stata mand è stato generato il PDF che è quel file preventivo che se vuoi ti puoi aprire. Ora non so che poi che cosa c'è stato messo, però quello è il file di preventivo. In fondo c'è la la solita. Ok, questo vi va Food Marketing Festival Gold con i vari dati. Ehm eh vedi che qua c'è lo sconto e tutto, quindi dobbiamo capire se effettivamente lo riusciamo a spostare anche quella quella logica che abbiamo fatto sui bundle qua. Ok. Ehm,

**Fabrizio Paganelli:** Ok.

**Elena Spini:** cosa è successo? Poi è stata inviata anche la la mail per la firma Docusin e infatti qua si vede,

**Marco:** Ok.

**Elena Spini:** vedi che c'è preventivo richiesta di di accettazione. Preventivo richiesta di accettazione. Quelle sono le mail automatiche che partono quando poi effettivamente tu mandi la richiesta di firma per firmare il documento.

  
  

### **01:21:16**

  

**Elena Spini:** Ottimo. E e niente, poi finta e poi c'è il conteggio dei giorni e la cosa che ti dicevo, aspetta che non mi ricordo più com'era quella regola. Era era era eh sì,

**Marco:** 5 giorni

**Elena Spini:** se non sbaglio. Sì,

**Marco:** era la scadenza del preventivo. Dopo due manda un reminder al cliente e al tutor.

**Elena Spini:** esatto, dopo due giorni. Esatto. In trattativa,

**Marco:** Sì.

**Elena Spini:** quindi rimane in trattativa. Dopo 2 giorni dall'aggiornamento in trattativa c'è la creazione automatica del task. Creazione automatica del task. Questo poi magari lo puoi fare anche testare direttamente te in autonomia, eh,

**Marco:** Mhm.

**Elena Spini:** che era quello che ti scrivevo anche per mail e invio della mail

**Marco:** Ok,

**Elena Spini:** dove per ora la mail è un copy che che non è tanto carino. Appena ci dirai qual è il copy,

**Marco:** dobbiamo rivedere.

**Elena Spini:** noi lo mettiamo.

**Marco:** Dobbiamo rivedere. Sì, sì.

**Elena Spini:** Esatto. Esatto. Eh, vediamo se lo ritrovo. L'avevo salvato per fartelo vedere.

  
  

### **01:22:28**

  

**Elena Spini:** Eh, eh. Eh mlo a preventivo. Mi dai un secondo così almeno te lo te lo guardi. Poi lo puoi anche testare, ovviamente.

**Fabrizio Paganelli:** Вот.

**Marco:** e

**Elena Spini:** Arrivo. Eh, è lento. Non so,

**Marco:** Sì, sì.

**Elena Spini:** oggi ripeto che è lunedì. Qu reminder, eccolo qua. Eh, per ora con molta moltissima fantasia il nostro copy che abbiamo messo è questo. Lo metto in chat.

**Marco:** Ja.

**Elena Spini:** Quindi, buongiorno. Ti ricordiamo che il preventivo quot number, quot name, che sono i campi dinamici, quindi si prenderà quot number,

**Marco:** Ok.

**Elena Spini:** eh il numerino nome opportunità preventivo, eccetera e è disponibile fino a data di scadenza. Per qualsiasi chiaramento puoi rispondere direttamente a questa mail grazie e il nome dell'utente che sta creando il la quot quindi del tutor. L'ho messo in brutto piacere da cambiare non abbiamo non appena abbiamo

**Marco:** Ok.

**Elena Spini:** il copy. Ehm Ok, guardiamo giusto un attimo cosa è successo all'opportunità. Quindi da questa stessa pagina puoi andare sull'opportunità perché tu hai sotto nome opportunità.

  
  

### **01:25:15**

  

**Elena Spini:** Bravissimo. Quindi se vuoi qualche informazione veloce ci puoi solo stare in eh sovrappezione. Se invece ci vuoi cliccare e vuoi vedere cosa è successo, entri direttamente nella pagina. Ah, ma questa era l'altra, non era la nostra. Vabbè, uguale.Amo di prima.

**Marco:** Ah, la nostra quella di prima.

**Elena Spini:** Eh, ma non siamo riusciti ad avanzarla, quindi non è non è un test. No, non è vero. Questa è in trattativa perché la quot era mh firmata, non mi ricordo.

**Marco:** Questo Ok,

**Elena Spini:** comunque vivono di vite parallele, cioè quando andiamo a quando siamo in eh in trattativa nella nella quotivo, si saremo in trattativa con l'opportunità e così via. Ehm,

**Marco:** di qua torno di là. Ok.

**Elena Spini:** per ora io direi questo.

**Fabrizio Paganelli:** Ja.

**Elena Spini:** Mi spiace che non siamo riusciti a fare la quot e c'è il preventivo, però secondo me stanno lavorando i ragazzi. Comunque l'ho gliel'ho chiesto e vediamo, però non mi sta rispondendo. Essendo un ambiente di test c'è anche questa c'è questa possibilità o magari semplicemente sono stati configurati male quei quei prodotti, eh, perché anche quello può essere.

  
  

### **01:26:48**

  

**Fabrizio Paganelli:** Sì, i prodotti sono Да. rivedere. Ho visto, bisognerebbe chiedere ad Aurel di rifare un giro sui prodotti, cancellare quelli che c'erano e ricrearli da nuovo, però dopo accordiamoci con lui. Mi ha sentito, ero mutato. No, no, ci sento. Ah, ok.

**Elena Spini:** No, no, si è sentito, si è sentito. Ehm, va bene. Io per qualsiasi cosa sono qua, non scappo. Divertitevi, continuate a testare e per questa settimana non abbiamo ancora un

**Sabatino Rinaldi:** Madonna\!

**Elena Spini:** meeting.

**Sabatino Rinaldi:** No, no,

**Marco:** Braки.

**Sabatino Rinaldi:** ma non ce lo diamo il meeting questa settimana perché vogliamo testarla. Venerdì ci riuniamo tutti e la testiamo da noi e dacci il tempo di usarla.

**Fabrizio Paganelli:** a dir la verità,

**Elena Spini:** Venerdì vi riunite?

**Fabrizio Paganelli:** a dirla Per la verità ci dovevamo sentire con Aurel per capire, non so se vogliamo farlo con calma sta settimana, quando avete tempo, il tema del dell'importazione massiva degli ordini,

**Elena Spini:** per la parte di immigrazione. Infatti, infatti, infatti. Ehm,

**Sabatino Rinaldi:** Eh, facciamolo il giovedì.

  
  

### **01:28:04**

  

**Elena Spini:** ma io sinceramente un'oretta per quello lo fisserei.

**Fabrizio Paganelli:** vedete voi, cioè nel senso io a quanto mi risulta Non

**Elena Spini:** No, no, te lo so dire.

**Fabrizio Paganelli:** ho non ho impegni,

**Elena Spini:** Lo lo fissiamo.

**Fabrizio Paganelli:** fissatelo quando è meglio per voi.

**Elena Spini:** Ok, perfetto. Sento io Aurel su questo e poi vi mando il meeting. Preferenze mattina?

**Sabatino Rinaldi:** Ti ricordi di darmi gli accessi?

**Elena Spini:** Certo, lo faccio appena chiudiamo,

**Sabatino Rinaldi:** Ok,

**Elena Spini:** lo faccio subito.

**Sabatino Rinaldi:** grazie. M.

**Elena Spini:** Ehm, preferenze mattina pomeriggio?

**Fabrizio Paganelli:** Magari evitiamo domani, domani e quand'è che vengono giovedì.

**Elena Spini:** No, stavo guardando da mercoledì, in realtà.

**Fabrizio Paganelli:** Eh, mercoledì andrebbe bene. Giovedì forse no, però se non c'è alternativa va bene anche giovedì, dai.

**Elena Spini:** Mercoledì meglio,

**Marco:** Угу.

**Elena Spini:** ma anche secondo me mercoledì però ok. Ehm, una cosa importante che vi succederà, così lo dico per Marco e in realtà questo poi vale anche per Sabatino. Voi avete fiss avete settato la vostra password e va bene. E il primo accesso è giusto che sia così.

  
  

### **01:29:38**

  

**Elena Spini:** Molto probabilmente domani mattina quando vi ricollegherete, perché non vedrete l'ora di testare nuovamente tutto Sales Force,

**Marco:** Hai

**Elena Spini:** eh vi ho mandato il link e vedrete questa pagina di sales force ti blocca, ti chiede di generare una pasy.

**Fabrizio Paganelli:** He.

**Elena Spini:** Questo perché è un doppio controllo nella nella parte di autenticazione di saleswors. Cos'è una pas key? è semplicemente un tipo il riconoscimento eh solo tuo che tu ti stai collegando dal tuo PC che può essere eh l'impronta digitale,

**Marco:** Sì.

**Elena Spini:** sai, i codici di autenticazioni, queste cose qua,

**Marco:** Ok,

**Elena Spini:** per fare in modo che l'utenza sia solo tua.

**Fabrizio Paganelli:** M.

**Marco:** va bene. Ja.

**Elena Spini:** Io ho mandato comunque la guida e è tutto normale. spaventatevi, createvi la vostra paski. Se avete volete, se avete idea di di condividere l'utenza con qualcuno, chiedete a Fabrizio perché adesso è super aggiornato su come fare, perché ci sono anche i trucchi per fare quello e e

**Fabrizio Paganelli:** Fabrizio il vostro?

**Elena Spini:** va bene.

**Fabrizio Paganelli:** No, io.

**Elena Spini:** No, no, te con Proton.

  
  

### **01:30:58**

  

**Fabrizio Paganelli:** Ah, ok, ok, ok,

**Marco:** da ricontattare.

**Fabrizio Paganelli:** va bene.

**Elena Spini:** Peccato che, cioè, non la stai condividendo con la povera Elisa.

**Fabrizio Paganelli:** Eh, sì. No, no, ma l'elisa voglio è evoluto, eh? Vogliamente dire è evoluto, è evoluto.

**Elena Spini:** Però giusto per poi effettivamente capire se se anche lei poi riesce ad accedere, magari quando ti senti pronto fate anche questo test.

**Fabrizio Paganelli:** Sì, dai, adesso vedo che cosa posso fare.

**Marco:** Ok,

**Fabrizio Paganelli:** Rido perché ce l'ho qui di fronte, fra un po' mi fulmina. Ok,

**Elena Spini:** Va bene, vado a creare l'utenza Sabatino. Ok,

**Sabatino Rinaldi:** Va bene.

**Fabrizio Paganelli:** va bene.

**Marco:** va bene.

**Elena Spini:** ok.

**Fabrizio Paganelli:** Ciao.

**Elisa Migliano:** จo

**Sabatino Rinaldi:** Ciao ciao.

**Elena Spini:** Ciao.

**Marco:** Elena,

**Elena Spini:** Ciao a tutti.

**Sabatino Rinaldi:** Ciao.

**Marco:** ciao. Grazie. Ciao anche a te. Grazie. Ciao.

**Fabrizio Paganelli:** Ciao.

**Marco:** Ciao.

**Fabrizio Paganelli:** Il tuo €29. Tu vuoi il cliente, lo devi chiamare, non è che devi aspettare che hai la col devi sentire, per altro. Esatto. Eh, mi posso pagare il pennino e Ma perché qui è più semplice?

  
  

### **01:32:28**

  

**Fabrizio Paganelli:** Prendo un Sì, ancora se è carico. Sì. Perché qui così? Ah. Così mercoledì che mi è sfuggito. Non ci devo essere io, mi sa. No, dobbiamo fare il caricamento de Ok, meglio fare, non facciamo niente, però dobbiamo metterci d'accordo su come importare gli ordini, perché almeno gli ordini che sono stati anche fatturati ce li portiamo dentro come storico, però lì quello che mi dicevi ieri, sì, fa vedere comunque un un archivio storico. Sì, almeno avere le vendite vecchie dopo le opportunità, tutte quelle pugnette lì non le possiamo caricare, ma almeno le vendite. Eh, no, l'utilizzo è smart pazzesco. Rispetto adesso è una roba Sì, a me mi fanno incazzare perché vi dico le cose, no? Però anche quella roba degli sconti, quelle robe lì l'avevamo già affrontata, l'avevamo già vista, doveva essere a posto, doveva essere, però dopo è una questione tecnica, ci dobbiamo mettere d'accordo, ti passo sto archivio, qui è il campo, quello è il campo, qui è una questione formati. Io adesso pensavo di farlo provare con questo qui col mio account alle ragazze di là, perché tanto il giro è molto semplice.

  
  

### **01:35:39**

  

**Fabrizio Paganelli:** Gli dico, "Fermatevi su Mexal, magari faccio provare uno alla volta e magari prima lo guardo con loro anche domani mattina che c'ho la riunione, magari fagli fare sull'ultimo della vendita standard". Io io voglio che vedano il giro perché il giro è quello la cosa più dopo la vendita dei pacchetti, quelli tranche eccetera eccetera. una rottura di c\*\*\*\* e che ancora non ho neanche non ho neanche testato. No, ma infatti adesso ti dico, a parte che lì secondo me mancano ancora degli elementi perché quando tu visualizzi e fai le cose la possibilità di mettere gli sconti col prezza. Poi ad esempio ci sono i codici prodotto sbagliati, ma li avevi già dato quelli buoni? E cioè no, però lui o meglio, sì, perché io gli ho detto "Guarda, fai adesso l'importal a SES perché ho aggiornato tutto." Ha fatto l'importezze vecchie che c'erano non le ha non le ha cancellate perché aveva creato, vedi? Io l'ho visto da qui. Dov'è che è? Qua. Ah, l'ho chiuso. Ah, no, è qua. Nei prodotti.

  
  

### **01:36:56**

  

**Fabrizio Paganelli:** Ho detto che c\*\*\*\* è? Che non me lo ricordavo proprio. Ho detto, "Ma che c\*\*\*\* è? Cos'è che era? Era extra. C'era una cosa con scritto extra. Vedi? Questo qui è un test pienissimo live live. Vedi? Questi qui sono tutte robe porcherie. E vedi questi qui? edizione a questi li ha creati lui, capito? Poi dopo io ho detto, "Guarda, importa." Lui ha importato, però ste cose qui le ha lasciate. Ah, vabbè. E poi dopo che ne so, anche questi qui, guarda, questi qui da mettere a posto, questi tutti articoli qui sono tutti gli articoli sbagliati, non ce li abbiamo noi questi qua in anagrafica. erano quelle prove che avevamo fatto all'inizio. Quindi magari su certe cose i tutor potrebbero avere un attimo. Ad esempio, quando tu inserivi, quando tu inserivi ho visto che dentro c'erano questi codici qua, che anche lì è una cosa che c'erano i pack. Ma i pack ci devono essere perché adesso non ce li abbiamo.

  
  

### **01:38:02**

  

**Fabrizio Paganelli:** No, no, no. Sì, quello sì, ma quel pack lì non ci doveva essere. No, no, cioè gli ultimi chiaramente no, ci devono essere soltanto quelli che abbiamo costruito con dentro la piattaforma. IC da i PE per le vendite da palco quando i tutor vanno a inserire un ordine di vendita normale non li devono vedere perché sono capito è solo una questione di visualizzazione. Si dice l'ordine, invece ho visto che li tu li vedevi, quindi vuol dire, cioè praticamente nel momento che io seleziono un una un prodotto singolo che sto facendo un pacchetto io, automaticamente lui mi dovrebbe eliminare quelli che invece sono già de dei bundle, sono già dei pacchetti. Giusto che magari che da qui si capisce un po' meglio. Se io apro ad esempio questo qui, no, qui non lo vedo. No, lo vedo anche da qui. Vedi questo qui, gruppo merciologico escluso da Import. Questo qui non viene neanche caricato, però vabbè, questa è roba vecchia. Tipo, se io vado qui Academy, questo qui è un codice prodotto buono, è incluso nell'import, ok?

  
  

### **01:39:11**

  

**Fabrizio Paganelli:** genera biglietto altri ordini. Questo che cosa vuol dire? Che questo, quando viene usato questo codice articolo si genera un biglietto, si deve generare un biglietto e fa parte non delle vendite da palco, quindi i tutto questo qui lo vedono. Questo qua ad esempio genera biglietto solo bundle. Questo qui quando il tutor va a inserire l'ordine di vendita non è visualizzabile, così non lo possono caricare così non usano i prodotti sbagliati, capito? Perché uno dei problemi che abbiamo adesso è quando il tutto ormai inserire ci sono tutti 1000 codici, non si capisce un c\*\*\*\*. E poi dopo c'è anche questo qui incluso import, no? in modo tale che mano mano che noi andremo a annullare il codice articolo in anagrafica di sensor vengono annullati e quindi sono sempre presenti nelle vendite storiche ci sono, ma quando uno inserisce un nuovo ordine non compare così ci rimangono solo quei 50 100 articoli sì dobe essere una roba quando la scrolli non a parte che c'è il campo ricerca, quindi poi a parte che quello eh sì verso 10 meno è una questione veloce Quando prima sei andato Quando tu prima sei andato a inserire l'ordine vedevi tutta sta robaccia qua che in linea teorica non non la dovresti vedere, ma non perché non lo devi vedere, per facilitare.

  
  

### **01:40:33**

  

**Fabrizio Paganelli:** Sì, certo. che ci siamo, cerchiamo di lavorare sempre nel modo però vedi anche qui gli ho detto, guarda, guarda, vieni a vedere, guarda, eh, guarda, guarda, ad esempio questo che poi sono cose banali che anche qui uno, vabbè, nome prodotto bla bla bla bla descrizione prodotto. Alfa, ascolta, o me la togli o me la fai fatta bene, perché questo qui è un'altra roba. È troncato, vedi? Però questo qui me la togli sennò fa casino uno cosa capisce, anche perché non ci serve. A parte che non servono. Eh, ma qui categoria sotto categoria le pesche in automatico non ci sono qui, eh, come ce l'abbiamo su Zoo, categoria sottocategorie che le abbiamo qui sul prodotto, eh. Sull'articolo non c'è la categoria sotto categoria, sono sulle opportunity. Ah, ok. Sulle opportunity, però qui abbiamo Ma le genera qui, eh. Secondo te le genere? Anche qui le categorie sottocategorie sulle opportunity? Perché adesso che c'ero sopra non ci guardavo non mi sembrava. Non sembrava. Ah, sì.

  
  

### **01:41:44**

  

**Fabrizio Paganelli:** Categoria nuovo. Nuovo perché a me prima non me le dava. Vai su standard. Poi adesso tanto ci spattacco, poi mi rendo conto, però e qui è libero. libero. Beh, anche lì non va bene perché adesso noi ce lo genera in automatico, ce lo genera il nome e loro poi vanno a fare le modifiche che gli dico io, però se devono così diventa dopo qui è è un testo libero che c'è sul nome dell'opportunità. Quando entrano dentro ce l'hanno qua, vedi la categoria. Ah, ok. E qui c'è la m dove c\*\*\*\* è? Qua. Bra bra generica corso. Altri servizi. C Perché adesso non non ci siamo arrivati lì? Ei non ci siamo arrivati perché lei voleva finire il giro, ecco perché ci siamo fermati prima, però il nome dell'opportunità, vedi, qui c'è Academy, eh bla bla bla bla dell'opportunità non va bene, eh perché e adesso si genera in automatico e poi può essere modificata e sennò non scriv che c\*\*\*\* che io faccio, però se te hai categoria sotto categoria è quello, eh.

  
  

### **01:43:06**

  

**Fabrizio Paganelli:** Ma la categoria Sì, ho capito, metti un trattino, metti un punto, metti un 26, non ce lo metti. No, però loro mettendo le categorie sopraccategoria gli si genera il nome e poi possono aggiungere. No, adesso è così. Ah, invece qua no, uno fa la il nome dell'opportunità come c\*\*\*\* gli pare, perché magari è qualche cosa che serve solo Sì, però noi oggi stiamo andando a identificare eh le opportunità dal nome in questo momento. Ma infatti sbagliamo come facciamo oggi, perché noi abbiamo il vizio che lavoriamo sulle descrizioni come se fossero dei codici. Invece così la descrizione uno mette quello che è mia personale, diciamo. Io faccio un'opportunità, appunto, per fare le statistiche comanda la categoria e la sottocategoria, non il nome dell'opportunità, perché la sotto categoria è il nome del prodotto, la categoria è la macro, il pacchetto prevede che sia marketing pack 26 e il nome ci scrivo vate la pesca, v\*\*\*\*\*\*\*\*\*, ci scrivo quel c\*\*\*\* di Io qui ho messo testo libero, però alla fine di a livello di reportistica dopo si usa categoria sotto categoria, non il che adesso sono tutte sminchiate, domani saranno precise.

  
  

### **01:44:20**

  

**Fabrizio Paganelli:** Esatto. Se se poi dopo se uno ha esigen si crea un'altra. Però vedi qui tanto sono impostate così. Dopo io altri servizi. Avevo guardate con la cosa. Cioè altri servizi. Cassa zucchetti generica e corso. Questa che cosè? Tipo se metto generica nella sottocategoria o generica. Se nella categoria metto altri servizi. Ah, non c'è non c'è più i pacchetti o i corsi. Se metto cassa zucchetti tutto. Vedi anche qui è sminchiata, non va bene. Corso, corso, ci sono i corsi, quindi boh, non lo so, bisogna capire. Pacchetti non c'è dentro categoria, li abbiamo tolti. Qui non la vedo per c'erano i pacchetti e poi c' Perché dici io faccio recall tutor, te dici recol tutor, giusto? Sì. Poi metto categoria corso e sottocategoria pacchetti, così almeno uno sa. No, noi oggi stiamo, non so se sono corrette, però oggi da noi è corso e c'è il nome del corso. Pacchetto e c'è il nome del pacchetto. La categoria è pacchetto, la categoria è corso e poi c'è il nome del corso. Io non metto corso pacchetto, io metto corso perché sto vendendo, sto facendo uno preventivo per il corso. Tipo, qui c'è corso, cioè il corso

  
  

### **Trascrizione terminata dopo 01:45:49**

  

*Questa trascrizione modificabile è stata generata dal computer e potrebbe contenere errori. È possibile anche modificare manualmente il testo dopo la creaz