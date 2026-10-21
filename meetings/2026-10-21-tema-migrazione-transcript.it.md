# [ROMI-PIENISSIMO] - Tema Migrazione - 2026/10/21 14:31 CEST - Transcript

> **Preserved record.** Verbatim Google Meet transcript, retrieved 2026-10-21
> from Drive `1si77wuD-1kDzOh0b8cSdcRtN8Og8tkSfAEMtrE4v2Cw` (65,119 bytes,
> owner `e.spini@romicompany.com`, shared with `a.mrruku@romicompany.com` at
> 2026-10-21T14:37:55Z). Client call: Fabrizio Paganelli for Pienissimo;
> Elena Spini and Aurel Mrruku for ROMI. Recording length 01:57:34.
> The Gemini notes section of the same document is not reproduced here.
> **Never edit this file.** Dictation errors are repaired only inside
> quotations elsewhere, with square brackets.

# **ð Trascrizione***  
*

 ott 21, 2026

##  **\[ROMI-PIENISSIMO\] - Tema Migrazione  - Trascrizione**

### **00:01:19**

  

**Aurel mrruku:** Ciao Elena.

**Elena Spini:** Cóo. Siamo soli.

**Aurel mrruku:** A quanto pare. Ma puoi fare uno squillo qualcosa che forse ha dimenticato?

**Elena Spini:** Lo chiamo. Sì. Stavo scrivendo una mail. Chiamo. Eccolo. Elen, ciao, ti ho appena accettato. Ah, sì, sì, ok. Aspetta che non ti vedo. Ok, eccoti.

**Fabrizio Paganelli:** Buonasera a tutti,

**Elena Spini:** Buonasera.

**Fabrizio Paganelli:** anzi buon pomeriggio.

**Elena Spini:** Buon pomeriggio. Infatti, dai, dobbiamo aspettare anche Lisa Oh.

**Fabrizio Paganelli:** Te Lisa partecipi. Ah, intanto dai iniziamo.

**Aurel mrruku:** Ott

**Fabrizio Paganelli:** sta si collega brevissimo.

**Elena Spini:** Eccola, la mettiamo Ok,

**Fabrizio Paganelli:** Ok.

**Elena Spini:** allora abbiamo tre temi grossi di migrazione di cui dobbiamo parlare. Da dove vogliamo partire? Abbiamo il tema biglietti e campagne, edizioni, tema ordini e tranche, il tema ordini e di performance plus.

**Fabrizio Paganelli:** Allora, eh secondo me è tut è un argomento unico. M perché diciamo che quando noi diciamo lato pienissimo andremo a a tirar su i dati degli ordini storici, in mezzo ci sarà tutto.

  
  

### **00:08:52**

  

**Fabrizio Paganelli:** ci saranno sia gli ordini della performance plus che gli ordini della della dei corsi eccetera eccetera e più che altro è capire, come dicevamo stamattina, se riusciamo a trovare una strada per poter fare un lavoro fatto bene. E diciamo che

**Elena Spini:** E allora qua il tema c'è che il lavoro fatto bene l'abbiamo già fatto

**Fabrizio Paganelli:** No,

**Elena Spini:** per tutti quelli che sono gli ordini nuovi.

**Fabrizio Paganelli:** no, no, no, no, non mi fraendere, non mi fa intendere Elena,

**Elena Spini:** No, no, lo so, lo so, lo so. Sto cercando anche di

**Fabrizio Paganelli:** non io sto dicendo un lavoro fatto bene di importazione senza generare anomalie, casini, questo volevo dire. Cioè, senza mh tanto i dati storici è chiaro che sono dati che va vanno è un'importazione estemporanea che in linea teorica dovrebbe prescindere da tutti gli automatismi che sono stati impostati e vediamo se riusciamo a trovare il modo per poterlo fare. E che ne so io se io quando ti passo passo gli ordini passo un ordine di Performance Plus, chiaramente come se non ho capito male, come diceva Aurelstamattina, eh c'è l'importazione dell'ordine, ok, però mancano le tranche e va bene, manca il contratto e va bene.

  
  

### **00:10:25**

  

**Fabrizio Paganelli:** Come facciamo a fare in modo che io assieme agli ordini vi possa dare anche un'informazione del contratto e della tranche? possibile creare in automatico anche contratte tranche? Non lo so. Cioè,

**Aurel mrruku:** Allora Да.

**Fabrizio Paganelli:** come come la possiamo cioè tu, Aurel, magari dimmi che cosa ti potrebbe servire, poi dopo io vedo se dai nostri archivi riesco a darti le informazioni strutturate nella in una certa maniera come è più corretto l'ato sales forse, non so.

**Aurel mrruku:** Ho fatto appunti prima. Allora, sui ordini standard, prima dobbiamo dividere gli ordini chiusi dai ordini aperti,

**Fabrizio Paganelli:** Ok.

**Aurel mrruku:** quindi già la capiamo e cerchiamo di avere due liste diverse perché io non mi aspetto che gli ordini chiusi, dobbiamo ricalcolare tutto, contratti, tranche, eccetera. sugli ordini aperti. Ovviamente saranno gli ordini che o non sono stati incassati o sono stati parzialmente incassati, vero?

**Fabrizio Paganelli:** E infatti ti volevo dire, tu per ordini chiusi intendi un ordine per il quale io ho già fatto la fattura.

**Aurel mrruku:** incassato la fattura.

**Elena Spini:** completamente incassato.

**Fabrizio Paganelli:** Quindi per ordini chiusi, intenditoo segnando, eh, dove ho la fattura e incasso totale.

  
  

### **00:12:25**

  

**Aurel mrruku:** Qui non mi aspetto ordini chiusi. Sono gli ordini in cui non mi aspetto degli aggiornamenti

**Fabrizio Paganelli:** Ok, bene.

**Aurel mrruku:** e dobbiamo capire questi ordini aperti. Ordini chiusi. Io non ho capito dove si trova. Non c'è un'integrazione per prendere gli ordini chiusi, quindi in qualche modo tu li devi recuperare. Io t'avevo detto che Mirko da quello che m'ha detto che quando viene creata una fattura quell'ordine non esiste più. tu mi'hai detto che esiste, quindi vorrei proprio vedere quello che mi mi mi offri.

**Fabrizio Paganelli:** M.

**Aurel mrruku:** Ovviamente un'altra cosa che ho notato è che voi avete un identificativo dell'ordine che è praticamente quel codice OC e il numero,

**Fabrizio Paganelli:** Sì.

**Aurel mrruku:** aspetta che ce l'avevo qua sopra da qualche parte.

**Elena Spini:** è quello che non è univoco.

**Aurel mrruku:** Sì, ma te l'ho mandato nell'Excel praticamente.

**Fabrizio Paganelli:** Lo apro,

**Aurel mrruku:** Sì, se riesci.

**Fabrizio Paganelli:** condivido e lo apro.

**Aurel mrruku:** Sì, se riesci. È quello là, in teoria. Quello sotto, quello là. Vai su istruzioni. Allora, eh qui ho detto quali sono i campi.

  
  

### **00:14:29**

  

**Aurel mrruku:** Eh, c'è l'altro quello fattura codice. Ah, scusa, forse è sui ordini. È prima, è seconda colonna. Ok, qua allora la chiave è OC

**Fabrizio Paganelli:** Sì.

**Aurel mrruku:** serie e numero documento,

**Fabrizio Paganelli:** Sì.

**Aurel mrruku:** però ho notato, ne avevamo parlato pure che voi ogni per ogni anno iniziate da zero. No. Quindi quella chiave non va bene e ho chiesto di mettere anche l'ano del documento e devo io devo fare una chiave sigla serie numero documento

**Fabrizio Paganelli:** Sembra giusto.

**Aurel mrruku:** e anno documento.

**Fabrizio Paganelli:** Certo.

**Aurel mrruku:** E perché altrimenti non posso distinguere i gli ordini con lo

**Fabrizio Paganelli:** Sì.

**Aurel mrruku:** stesso tripla di di combinazione.

**Fabrizio Paganelli:** Sì.

**Aurel mrruku:** Poi, eh, ovviamente questo ID lo devo salvare in qualche modo su su in sales force, ma poi ho il problema che se spero di non avere ordini aperti degli anni scorsi, perché se così Maxal non me la dà questa questa quadrupli quadrupla. di dati. In questo modo Maxal mi dà solo sigla, serie e numero documento. Se ti ricordi come farò io in modo

  
  

### **00:16:10**

  

**Fabrizio Paganelli:** Beh, ti dà

**Aurel mrruku:** se tu hai un ordine del un ordine aperto del 2024,

**Fabrizio Paganelli:** M.

**Aurel mrruku:** spero che non ce li hai, ma se ce l'hai come devo distinguere io quando creo l'ordine in sales force o meglio quando mi dai la fattura. La fattura ha solo OC, serie e numero di documento. Non ce l'ha l'anno o filtro le fatture anch'io per l'anno a sto punto.

**Fabrizio Paganelli:** Diciamo che tu l'anno lo puoi dedurre dalla data dell'ordine, eh, perché è vero che ci sarà sigla serie e e numero, ma c'è anche il codice del cliente e c'è anche la D

**Aurel mrruku:** No, ma io non sto facendo il logico, sto facendo importazione, capito?

**Fabrizio Paganelli:** eh

**Aurel mrruku:** Non è che lo devo fare io, me lo deve fornire il sistema che mi dà questo questa informazione. Io là l'ho fatto con una formula. Se lo possiamo fare nello stesso modo, va bene.

**Fabrizio Paganelli:** Allora,

**Aurel mrruku:** Ti spiego.

**Fabrizio Paganelli:** guarda questa

**Elena Spini:** Sì.

**Aurel mrruku:** La prima colonna è una formula.

**Fabrizio Paganelli:** qui.

**Aurel mrruku:** la prima colonna,

  
  

### **00:17:22**

  

**Fabrizio Paganelli:** Ok. Sì, sì,

**Aurel mrruku:** vedi che è una formula e in qualche modo dobbiamo usare la

**Fabrizio Paganelli:** sì. Ok.

**Aurel mrruku:** stessa lo stesso modo di ragionamento perché altrimenti io non so come legare in sales force quando mi arrivano le fatture ai ordini. E il mio dubbio è se mi arriva una fattura da Maxile con l'integrazione su quella fattura ce l'ho l'anno, vero?

**Fabrizio Paganelli:** Certo,

**Aurel mrruku:** Ok.

**Fabrizio Paganelli:** perché la fattura, uno degli elementi fondamentali della fattura è la data della fattura, per cui indirettamente c'è anche l'anno. Certo.

**Aurel mrruku:** Perché? Eh? Eh, Mirko m'aveva detto a cavallo dei anni,

**Fabrizio Paganelli:** Mh.

**Aurel mrruku:** quando faccio la chiamata verso eh, come si chiama? verso Maxile. Io devo fare una chiamata per ano,

**Fabrizio Paganelli:** Sì, perché sono archivi diversi.

**Aurel mrruku:** però non e è qua, però, quindi dobbiamo fare io quando farò la chiamata nel 2027 e tu hai un ordine del 2025, io non prenderò mai le fatture di 2025. O però tu mi dici se io faccio la fattura dell'ordine del 2025, la fattura sarà del 2027

  
  

### **00:18:49**

  

**Fabrizio Paganelli:** Ti ho perso un attimo, Aurel. Non ti ho sentito per un attimo.

**Aurel mrruku:** oord del 2025.

**Fabrizio Paganelli:** Non Sì.

**Aurel mrruku:** Quando verrà fatta la fattura, la fattura c'ha la data della fattura, non è nessun legame con la data dell'ordine. Questo sto cercando di dire.

**Fabrizio Paganelli:** Sì, diciamo che può capitare che io ho un ordine del 2026 che fattura nel 2027. Quello può succedere.

**Aurel mrruku:** Sì,

**Fabrizio Paganelli:** soprattutto a cavallo di anno.

**Aurel mrruku:** ma se quell'ordine se quell'ordine ha lo stesso numero di serie con lo stesso con la stessa sigla, con lo stesso numero di documento, con un altro ordine del 2027, come Capisco la differenza. Esempio concreto.

**Fabrizio Paganelli:** Allora, a questo punto la Allora a questo punto la chiave devi fare anche considerando il cliente, se vuoi l'estrema certezza, bisogna che proprio per lo stesso cliente eh ha a capito a questo punto la chiave oltre

**Aurel mrruku:** Però non abbiamo messo in piedi. Eh, ma anche questo non è corretto, perché un cliente può avere due ordini con la stessa siglia in due anni diversi. Quando i le stasera intendo lo stesso numero documento.

  
  

### **00:20:29**

  

**Fabrizio Paganelli:** Vogliamo metterci la data? Dobbiamo avere proprio una sfiga gigante, eh, che sullo stesso cliente fatturiamo nella stessa

**Aurel mrruku:** No, no, no. Allora, guarda, poi poi se se c'è qualche anomalia io ti sto dicendo che non ti posso garantire il 100% del dato, poi se c'è qualche problematica sto cercando di

**Fabrizio Paganelli:** qui però stiamo parlando solo eh Sì, sì, stiamo parlando solo dell'importazione una tantum dei dati storici, giusto?

**Aurel mrruku:** No, questa Yeah.

**Fabrizio Paganelli:** Qualcuno Ok,

**Aurel mrruku:** parlando sui per sugli ordini aperti quello dato storico me ne frego perché ha già è già in incassato, capito?

**Fabrizio Paganelli:** ok,

**Aurel mrruku:** Quindi quello ho finito cassato,

**Fabrizio Paganelli:** ok.

**Aurel mrruku:** c'ha la fattura, c'ha il scadenziario, è tutto in regola. Il problema è che se è è un ordine aperto,

**Fabrizio Paganelli:** Ok.

**Aurel mrruku:** perché se un ordine aperto l'ordine del nel 2027, la fattura nel scusa l'ordine 2026, la fattura nel 2027 io mi baso sulla data della fattura e la fattura ha un riferimento all'ordine, ma il riferimento, per come è arrivato adesso, io per esempio prendo tutte le fatture del eh in tutte le fatture c'ho un sigla serie e numero documento e quel sigla serie numero documento coincide con un ordine in sales force.

  
  

### **00:22:03**

  

**Aurel mrruku:** Il mio problema è se per caso due ordini con la stessa sigla,

**Fabrizio Paganelli:** Bene,

**Aurel mrruku:** numero, documento e serie documento, ho il dubbio, la paura che prenderò l'ordine sbagliato. Quindi leggo la fattura con l'ordine sbagliato.

**Fabrizio Paganelli:** allora, allora Aure prendi anche il cliente come chiave perché tu avrai nel nella nel nelle fatture

**Aurel mrruku:** Ma non ce l'ho nelle regole che ho adesso il cliente. Abbiamo messo in piedi una struttura dove Sales Force manda l'ordine a

**Fabrizio Paganelli:** e non si può eh

**Aurel mrruku:** Mexal e io c'ho l'identificativo dell'ordine su

**Fabrizio Paganelli:** ok.

**Aurel mrruku:** Mexal. Quello che mi serve a me, se per qualche se in qualche modo nel tuo sistema c'hai l'ID di Zoo su Mexal e quando mi passi gli ordini mi passi anche quell'ID e in qualche modo quando mi passa la fattura riesco a avere quell'ID. Forse ci serve anche Mirko qua. Fabrizio.

**Fabrizio Paganelli:** Voglio provare a farti vedere una cosa, guarda.

**Aurel mrruku:** Sì.

**Fabrizio Paganelli:** Да. Questo qui è praticamente una tabella con i dati delle righe fattura.

  
  

### **00:24:17**

  

**Aurel mrruku:** Sì,

**Fabrizio Paganelli:** che io mi sono caricato su un data warehouse di Zo Analytics. Questo qui lo utilizzo per fare la reportistica.

**Aurel mrruku:** ok,

**Fabrizio Paganelli:** Allora,

**Aurel mrruku:** ok,

**Fabrizio Paganelli:** io qui più o meno utilizzo eh più o meno gli stessi

**Aurel mrruku:** ok.

**Fabrizio Paganelli:** dati che tu vai da No,

**Aurel mrruku:** Vedo già che l'ID documento c'ha la sigla,

**Fabrizio Paganelli:** no, però aspetta,

**Aurel mrruku:** eh.

**Fabrizio Paganelli:** aspetta, aspetta, perché questo ID qui me lo sono creato io. Questo ID qui l'ho creato io, no? È un campo calcolato questo. Io io all'interno delle fatture vedo la sigla del documento, la serie, il numero e la data del documento. Ok? Questo qui è un campo creato da me, anche questo qui. E chiaramente nella stessa riga dopo c'è il riferimento dell'ordine sulla stessa riga, perché quando fatturo fatturo un ordine, no? Per cui nell'archivio delle fatture si porta dietro anche il riferimento dell'ordine, quindi ho sigla ordine, serie ordine, numero ordine, data ordine, il cliente il cliente comune all'ordine e alla fattura e via dicendo.

  
  

### **00:25:34**

  

**Fabrizio Paganelli:** Poi dopo qua ci sono altre informazioni, codice agente, queste robe qui non ce ne frega niente. porto, codice, articolo, bla bla bla bla. Però diciamo che l'elemento che ti permette di legare eh la ehm la fattura con l'ordine e è è questo. Io all'interno della quando io ti passo i dati, ehm quando io ti passo i dati, cos'è che ho? Avrò un campo ordine, sigla, numero, eh meglio scusa, sigla, serie numero, data cliente. dopo è vero che tu dici eh sì da serie numero, date cliente. Eh no, è impossibile che ci sia lo stessa lo stesso, diciamo, eh come si dice, come si chiama in linguaggio informatico, lo stessa tupla,

**Aurel mrruku:** Satch combinazione.

**Fabrizio Paganelli:** com'è che si chiama?

**Aurel mrruku:** Sì, sì.

**Fabrizio Paganelli:** Eh,

**Elena Spini:** M.

**Aurel mrruku:** Mat Eh,

**Fabrizio Paganelli:** eh, cosa tra un anno e l'altro,

**Aurel mrruku:** italiano mi viene.

**Fabrizio Paganelli:** cioè è veramente la la vedo quasi impossibile.

**Aurel mrruku:** Ok.

**Fabrizio Paganelli:** Non lo so.

**Aurel mrruku:** E il dubbio è il dubbio è quando a me arriva la

**Fabrizio Paganelli:** Mh

  
  

### **00:27:12**

  

**Aurel mrruku:** fattura io ho semplicemente

**Fabrizio Paganelli:** mh.

**Aurel mrruku:** la sigla numero, quindi ho solo sigla numero. Come si chiama l'altro campo che ho dimenticato?

**Elena Spini:** serie.

**Aurel mrruku:** serie.

**Fabrizio Paganelli:** Ok. Sì.

**Aurel mrruku:** Non ce l'ho la data dell'ordine o la data della fattura, non la data dell'ordine. Ok, c'è un campo data ordine, però io non per il momento non faccio nessun Mi assicuri che la data dell'ordine sulla fattura è la data dell'ordine? E non è la data de fattura perché se si usa quel campo che mi hai fatto

**Fabrizio Paganelli:** No,

**Aurel mrruku:** Так.

**Fabrizio Paganelli:** no, dopo c'è di qua c'è anche la data fattura. Vedi? Io qui ho questa fattura. Quando ho fatto questa fattura, che cosa ho fatto io? Ho richiamato questo ordine. Guarda, faccio un filtro così c'è c ce la facciamo meglio. Dov'è che si mette? Qua. Qua. Se io scrivo qui 44, dov'è che era? 44 203. Ok. Quando io io dovevo fatturare questo, adesso qui tu vedi più righe perché di là c'è il codice articolo, quindi c'è il dettaglio delle righe articolo,

  
  

### **00:28:42**

  

**Aurel mrruku:** Ok.

**Fabrizio Paganelli:** però io ho detto bene devo fatturare l'ordine 203 sono andato in fatturazione, ho richiamato l'ordine, l'ho fatturato. L'ordine aveva data 25 luglio 23 il 44.203 quando ho fatto la fattura. La fattura l'ho fatta in data 4 agosto 23. Sono due cose diverse, data ordine e data fattura.

**Aurel mrruku:** A me servireb data ordine.

**Fabrizio Paganelli:** Io la data ordine te la posso passare. Vedi? Io qui ce le ho. Io te la posso passare. Ma se Sì,

**Aurel mrruku:** Non è che me lo passi te, me lo deve passare Mexal, me lo devi passare sia a te che Mexal,

**Fabrizio Paganelli:** sì,

**Aurel mrruku:** capito?

**Fabrizio Paganelli:** sì. Ma io vado a estrapolare i dati.

**Aurel mrruku:** Quindi non ti sento, Fabrizio, t'ho perso.

**Fabrizio Paganelli:** Tu che cosa leggi?

**Elena Spini:** è saltato.

**Fabrizio Paganelli:** Damexalgi che che archivio vai a leggere da Ah,

**Elena Spini:** No.

**Aurel mrruku:** Eh,

**Fabrizio Paganelli:** no. Ti dicevo tu da Mexal che archivio leggi?

**Aurel mrruku:** il problema è che io

**Fabrizio Paganelli:** Cioè che nome ha?

  
  

### **00:29:50**

  

**Aurel mrruku:** io su Mexile c'ho eh praticamente una struttura che ha sia data ordine sia Yeah. documento, però a quanto pare, da quello che ho capito io, anno documento sarebbe la data della l'anno della fattura, l'anno o è l'anno dell'ordine? Questo voglio capire

**Fabrizio Paganelli:** Ah, io questo non lo so. Dipende qual è il campo che leggi, eh. Questo te intendi nelle api, giusto? Quando fai la chiamata API,

**Aurel mrruku:** nelle api. Sì, sì,

**Fabrizio Paganelli:** dico bene?

**Aurel mrruku:** sì. Perché quello che devo fare io è ok te me lo passi questa data,

**Fabrizio Paganelli:** Ah, io

**Aurel mrruku:** mi passi l'ID dell'ordine, sigla dell'ordine, quindi numero serio, sigla e quell'altro campo dell'ordine, mi passi anche l'anno, ma io dall'epi quando mi arriva la fattura, devo andare a capire sulle piattura a quale campo coincide l'anno praticamente, perché sull'anno lo possiamo risolvere perché ogni anno cambia la numerazione, quindi non puoi avere gli stessi la stessa combinazione di numerazione dell'ordine nello stesso anno.

**Fabrizio Paganelli:** Sì.

**Aurel mrruku:** Quindi risolviamo così, solo che mi serve una conferma. Qual è il campo sulla fattura che definisce l'ano dell'ordine?

  
  

### **00:31:11**

  

**Aurel mrruku:** non della fattura, dell'ordine o una data,

**Fabrizio Paganelli:** Sì, sì, ho capito anche la

**Aurel mrruku:** non è che non è detto che è l'anno se mi fornisce

**Fabrizio Paganelli:** data.

**Aurel mrruku:** questo, se mi dai l'anno t'assicuro che non ho problemi perché se mi dai l'anno come ti ho detto ogni ordine c'è una numerazione, quella numerazione è unica per quell'anno.

**Fabrizio Paganelli:** Allora, facciamo così, guarda, visto che Mirko ho visto che ha risposto stamattina,

**Elena Spini:** ha risposta anche adesso,

**Fabrizio Paganelli:** gli gli gli gli gli scriviamo,

**Elena Spini:** quindi 18 minuti.

**Aurel mrruku:** Sì, sì.

**Fabrizio Paganelli:** eh ha sì, ha mandato questa qua. Eh, allora facciamo così, guarda. Rispondi a tutti. Abbiamo un'altra domanda.

**Aurel mrruku:** Quello che si deve chiedere nella fattura ci può indicare qual è il campo che definisce l'ano dell'ordine

**Fabrizio Paganelli:** Allora,

**Aurel mrruku:** se esiste?

**Fabrizio Paganelli:** ehm, nelle api, dimmi se scrivo bene,

**Aurel mrruku:** Sì, sì.

**Fabrizio Paganelli:** da cui sei se force

**Aurel mrruku:** sales force i dati di

**Fabrizio Paganelli:** legge, eh.

**Aurel mrruku:** fatturazione

**Fabrizio Paganelli:** eh le fatture. Ehm ci puoi dire quale è il campo ehm eh dove è contenuto la

  
  

### **00:32:36**

  

**Aurel mrruku:** e

**Fabrizio Paganelli:** data dell'ordine?

**Aurel mrruku:** data barra ano dell'ordino.

**Fabrizio Paganelli:** scritto bene,

**Aurel mrruku:** Sì, sì.

**Fabrizio Paganelli:** Sales. Yes. Ho fatto Ok,

**Aurel mrruku:** Ecco,

**Fabrizio Paganelli:** grazie.

**Aurel mrruku:** per ok. Se ci dà un campo, allora quello che si può fare è nel momento in cui io genero i ordini in modo massivo, stiamo parlando di ordini semplici, ordini aperti vuol dire che ordini che non sono stati incassati, quindi non sono chiusi. Io posso fare in modo che io genero l'ordine in Sales force e non vi e non invio l'ordine su Maxal perché c'è anche questo problema e perché c'è un automatismo.

**Fabrizio Paganelli:** M.

**Aurel mrruku:** Ogni volta che si crea un ordine su sales force viene inviato verso MEXL. Quindi devo bloccare l'invio dell'ordine su Excel, devo salvare in questa chiave le informazioni che ci sono già su Mexal, quindi l'ID dell'ordine e ogni volta che ci arriverà una fattura poi da Mexal dobbiamo fare un check nel codice che stiamo dicendo nella chiave che stiamo dicendo adesso, quindi che che sarebbe la combinazione del OC1 1 125 e

  
  

### **00:34:12**

  

**Fabrizio Paganelli:** Perché Perché provo

**Aurel mrruku:** l'anno così così da

**Elena Spini:** il codice cliente.

**Fabrizio Paganelli:** mh

**Aurel mrruku:** così da sicuro che ogni volta che arriva un cambiamento su una fattura collegato a quell'ordine in sales source vengono aggiornate le righe di quel ordine.

**Fabrizio Paganelli:** io guarda provo a dire una cosa a titolo a titolo che che non so se si può semplificare la vita questa. Allora, qui ti faccio vedere ti faccio vedere questi qui sono gli ordini che ad oggi abbiamo aperti, o meglio, sono ordini presenti nel CRM ce che ci siamo portati su Mexal e che non abbiamo ancora fatturato.

**Aurel mrruku:** Ma sono una decina, non di più.

**Fabrizio Paganelli:** E sì. E m quindi

**Aurel mrruku:** Ah, però sei nel 2025, vedi che hai hai 2025 là.

**Fabrizio Paganelli:** no c'è il 2025, ma c'è anche il 2026, guarda.

**Aurel mrruku:** Ma vedi l'elenco?

**Fabrizio Paganelli:** Ci sono i periodi tutti,

**Aurel mrruku:** Vedi l'elenco a sinistra?

**Fabrizio Paganelli:** vedi?

**Aurel mrruku:** Ok.

**Elena Spini:** Sì, sì,

**Fabrizio Paganelli:** Sì, sì,

**Elena Spini:** ce n'è uno 2025.

**Fabrizio Paganelli:** ma questo qui sì, ce n'è uno del 225. Però quello che volevo dire perché noi praticamente abbiamo ordini chiusi, fatturati e totalmente incassati.

  
  

### **00:35:50**

  

**Fabrizio Paganelli:** E poi dopo tu per ordini aperti intendevi fatturati fatturati e parzialmente incassato.

**Aurel mrruku:** Ho parzialmente fatturato.

**Fabrizio Paganelli:** parzialmente incassati

**Aurel mrruku:** o oppure parzialmente fatturato.

**Fabrizio Paganelli:** e quelli non li abbiamo.

**Aurel mrruku:** Ok,

**Fabrizio Paganelli:** Non li abbiamo per come siamo strutturati non abbiamo ordini parzialmente fatturati,

**Aurel mrruku:** ancora meglio.

**Fabrizio Paganelli:** abbiamo solo ordini ancora da fatturare.

**Aurel mrruku:** Ok,

**Fabrizio Paganelli:** Ordini ancora da fatturare.

**Aurel mrruku:** li dividiamo per cortesia,

**Fabrizio Paganelli:** Esatto.

**Aurel mrruku:** quindi perché tu riesci a div così siamo sicuri che se abbiamo un problema ce l'abbiamo solo su un sottoinsieme di quegli ordini.

**Fabrizio Paganelli:** Sì, sì.

**Aurel mrruku:** Ok.

**Fabrizio Paganelli:** Perché poi adesso stavo ragionando in questi tre blocchi, quindi fatturati e incassati, fatturati e non incassati o parzialmente incassati

**Aurel mrruku:** Incassati.

**Fabrizio Paganelli:** e e quelli ancora da fatturare, quindi perché tu mi dicevi prima di fare tutto il ciclo genera in automatico un ordine, quindi su Sales Force.

**Aurel mrruku:** No. Eh sì. Allora, praticamente quello che io mi aspetto è tu mi fornisci un Excel e più o meno quello che t'ho già mandato.

**Fabrizio Paganelli:** Sì, sì,

  
  

### **00:37:30**

  

**Aurel mrruku:** Definiamo qual è la chiave che a noi servirà quando ci arriva la

**Fabrizio Paganelli:** sì,

**Aurel mrruku:** fattura sull'ordine, quindi su Mexal ci sarà una chiave.

**Fabrizio Paganelli:** sì. Ok.

**Aurel mrruku:** Io gli ordini che mi dai su salesce, devo tenere questa chiave che serve la chiave di Mexal, così quando mi arriva la fattura da Mexal io so come legare fattura scadenziario con questo ordine. Stiamo parlando Stiamo parlando fino adesso degli

**Fabrizio Paganelli:** E quindi

**Aurel mrruku:** ordini standard semplici

**Fabrizio Paganelli:** sì M.

**Aurel mrruku:** negli ordini. Se tu mi dai nelle linee dell'ordine, se mi dai delle scadenze, quindi data scadenza, quindi mettiamo anche il campo data scadenza sulle righe dell'ordine, io posso fare in modo che generi le trunch in modo automatico. Mi stai seguendo?

**Fabrizio Paganelli:** Sì, me lo sto segnando. Più data scadenza.

**Aurel mrruku:** E su ogni riga dell'ordine,

**Fabrizio Paganelli:** Ok.

**Aurel mrruku:** se mi dai anche per esempio se ha data scadenza e se è stata pagata mi dai anche uno stato della riga, io già in automatico quando inserisco questi queste righe d'ordini in sales force posso già aggiornare i status del trash.

  
  

### **00:39:12**

  

**Aurel mrruku:** Fin qua tutto chiaro?

**Fabrizio Paganelli:** Sì, qui fino a qui non non vedo non vedo i problemi.

**Aurel mrruku:** problemi.

**Fabrizio Paganelli:** Mh,

**Aurel mrruku:** Poi quello che devo

**Fabrizio Paganelli:** nel senso che io posso prendere io posso prendere tipo una tabella simile a questa.

**Aurel mrruku:** Sì,

**Fabrizio Paganelli:** Qua avrai anche il codice articolo da qualche parte, adesso non li vedo,

**Aurel mrruku:** sì.

**Fabrizio Paganelli:** ma ci sono. e poi semplicemente ti aggiungerò una colonna con la data di scadenza presa dallo scadenziario.

**Aurel mrruku:** Sì,

**Fabrizio Paganelli:** è una colonna con lo stato della riga,

**Aurel mrruku:** sì. È una colonna con la data dell'ordine perché io la data

**Elena Spini:** M.

**Aurel mrruku:** dell'ordine lo userò per collegare l'ordine

**Fabrizio Paganelli:** però la eh

**Aurel mrruku:** alla campagna.

**Fabrizio Paganelli:** perché la data dell'ordine qua in realtà c'è già Ja.

**Aurel mrruku:** Ok, c'è già. Perfetto. Questa data dell'ordine deve coincidere, quindi devo ribaltare un po' la logica solo per l'inserimento e dire non andare a prendere a legare le campagne con eh gli ordini, quindi con i biglietti nella data della creazione dell'ordine, ma solo per l'importazione, quindi devo fare qualche condizione io.

  
  

### **00:40:39**

  

**Fabrizio Paganelli:** M.

**Aurel mrruku:** lo devi prendere dalla data dell'ordine che mi arriva che è già stata popolata. Il problema sarà e sta cosa la dobbiamo

**Fabrizio Paganelli:** Vai, facciamo da facciamo facciamolo su data fattura questa cosa. Aurel, tu mi hai detto data ordine, giusto? è è la logica che avremo che avremo, diciamo, per su Sesf, però per fare questa importazione massiva che la faremo una tantum anziché data ordine considera data fattura.

**Aurel mrruku:** basta che mi dai una data. Poi tutte le edizioni, quindi tutti i prodotti che fanno parte in questi ordini devono avere delle edizioni e una mappatura in Sales Force edizione prodotto, altrimenti non si lega con l'edizione.

**Fabrizio Paganelli:** Eh, io questa cosa qui la farei, però qui se questa qui.

**Aurel mrruku:** si deve fare prima dell'importo.

**Fabrizio Paganelli:** Questa sì, sì, prima dell'importazione, chiaro. Però io qui adesso volevo fare una un ragionamento che sia sensato perché a voler fare un lavoro fatto bene io ti dovre e per per avere quanti più possibili dati storici a all'interno io ti dovrei passare e i dati.

  
  

### **00:42:14**

  

**Fabrizio Paganelli:** E mi vien da dire dal primo di gennaio del 2024, però nel 24 era anche una società diversa, nel senso che vendevamo anche la piattaforma. Non vorrei tornare troppo indietro, ti ripasserei dal primo genere del 25.

**Aurel mrruku:** Ma stiamo parlando degli ordini aperti,

**Fabrizio Paganelli:** E ah,

**Aurel mrruku:** Fabrizio. Non siamo.

**Fabrizio Paganelli:** solo degli ordini aperti stiamo parlando.

**Aurel mrruku:** Sì, sì,

**Fabrizio Paganelli:** Eh, lo so.

**Aurel mrruku:** perché i a me serve sugli ordini aperti a me serve il collegamento poi per il link che farà la generazione del biglietto della parte di marketing.

**Fabrizio Paganelli:** Eh, lo so, Aurel, però vedi, io posso avere un ordine chiuso anche pagato che fa riferimento ad un pienissimo live di, o meglio, lasciamo stare pienissimo live che fa riferimento magari a Cameri rivenditori di marzo del 2027 e lì il biglietto ci serve a noi. capito? Quindi in realtà i biglietti andrebbero generati anche per gli ordini che sono chiusi. Magari dovremmo fare un qualche cosa di Ti dovrei creare le campagne già solo quelle dei degli eventi futuri e precedente, no?

  
  

### **00:43:41**

  

**Fabrizio Paganelli:** su eventi futuri,

**Aurel mrruku:** Ma scusa,

**Fabrizio Paganelli:** tipo dovrei creare la campagna per la eh

**Aurel mrruku:** ma ma non cioè io eh c'è C'è qualcosa che mi sfugge.

**Fabrizio Paganelli:** mh

**Aurel mrruku:** Stai dicendo dobbiamo creare le campagne per eventi futuri.

**Fabrizio Paganelli:** Sì.

**Aurel mrruku:** Ma noi allora perché usiamo la data di creazione dell'ordine per collegare

**Fabrizio Paganelli:** Perché Aurel?

**Aurel mrruku:** il biglietto a quell'edizione?

**Fabrizio Paganelli:** Perché? Perché noi cosa abbiamo? Prendiamo l'esempio proprio dell'Academy. Noi l'Academy la facciamo in in gennaio, ok? Quindi noi manderemo via, ipotizziamo alla fine di gennaio,

**Aurel mrruku:** Sì.

**Fabrizio Paganelli:** al 31 di gennaio. Noi 15 giorni prima mandiamo via i biglietti ai clienti. Ma quei biglietti si sono generati nei 365 giorni precedenti di fatturazione?

**Aurel mrruku:** Ma hai un problema?

**Fabrizio Paganelli:** Perché

**Aurel mrruku:** Allora, c'è un problema più grande.

**Fabrizio Paganelli:** mh

**Aurel mrruku:** C'è un problema più grande perché noi sulle addizioni abbiamo una data da A.

**Fabrizio Paganelli:** Eh, ma infatti quello che provavo a dirti, se io per l'Academy del 2027 creo l'edizione, creo l'edizione Academy 2027 e ci metto data dal primo di febbraio 2026 al 21 di gennaio del

  
  

### **00:45:06**

  

**Elena Spini:** У

**Fabrizio Paganelli:** 2027 la creo già.

**Aurel mrruku:** Ok. Ok. Ok,

**Fabrizio Paganelli:** Quando tu porti Quando tu porti dentro gli ordini, vuoi gli ordini adesso massivi, l'importazione dello storico, vuoi gli ordini nuovi che verranno generati su Sales Force, tu leggerai per gli ordini nuovi che verranno generati su sufazione dell'ordine. Sull'importazione massiva leggerai la data della fattura.

**Aurel mrruku:** allora facciamo così, quella datafattura. Ok, ho capito. Quindi quella data fattura deve combaciare, quindi devo coincidere con da la data sull'edizione da più o meno e

**Fabrizio Paganelli:** Esattamente.

**Aurel mrruku:** in automatico Sì. e in automatico lo leghiamo con le edizioni, quindi la data fattura di quel elemento dell'ordine,

**Elena Spini:** Что?

**Aurel mrruku:** quindi riga dell'ordine con quella di edizione.

**Fabrizio Paganelli:** Sì,

**Aurel mrruku:** Quindi se quindi dobbiamo preparare prima le edizioni,

**Fabrizio Paganelli:** sì.

**Aurel mrruku:** mettere le date sulle edizioni, fare un check sulla lista degli ordini che coincidono con le date delle edizioni.

**Elena Spini:** No, che la data di fattura sia compresa nella data di competenza dell'edizione.

**Aurel mrruku:** Sì. fare una mappatura edizione per su con tutti i prodotti che fanno parte nei ordini di quell'adizione e poi iniziare a fare gli

  
  

### **00:46:48**

  

**Fabrizio Paganelli:** Sì.

**Aurel mrruku:** import dei record, degli ordini. Quando i ordini verranno inseriti in sales force, quello che devo fare io in automatico è per ogni riga dell'ordine generare un asset in base allo stato della riga dell'ordine che me lo

**Fabrizio Paganelli:** Sì.

**Aurel mrruku:** devi passare te. dico se l'asset è stato pagato, non pagato, eccetera, incassato biglietto praticamente.

**Fabrizio Paganelli:** Sì.

**Aurel mrruku:** è il biglietto, ovviamente avrà anche una data di scadenza, quindi verranno create anche le tranche dei bigliet le tranch delle righe dell'ordine. Se i biglietti sono stati assegnati, quindi sono stati pagati, come devo capire io che marketing li deve prendere? Perché può anche aver già inviato quei biglietti sugli ordini incassati.

**Fabrizio Paganelli:** Scusa.

**Elena Spini:** M aspetta,

**Fabrizio Paganelli:** Biglietti lo sa.

**Elena Spini:** però qua c'è una domanda prima,

**Fabrizio Paganelli:** No, no,

**Elena Spini:** cioè avete già inviato la la.

**Fabrizio Paganelli:** però no,

**Aurel mrruku:** Ok,

**Fabrizio Paganelli:** no. I biglietti no, no. I biglietti li inviamo nei giorni immediatamente precedenti all'evento. Quindi io prima parlavo dell'Aemy,

**Aurel mrruku:** ma

**Fabrizio Paganelli:** non abbiamo mai non abbiamo mandato via i biglietti dell'Academy.

  
  

### **00:48:15**

  

**Fabrizio Paganelli:** Eh

**Aurel mrruku:** ok.

**Elena Spini:** Però accademy camerier venditori marzo.

**Aurel mrruku:** M.

**Elena Spini:** Non credo neanche io, infatti. Ok, però il problema potrebbe sussistere sull'evento di pienissimo live che è tra poco,

**Fabrizio Paganelli:** sì,

**Aurel mrruku:** Ok,

**Elena Spini:** o no?

**Fabrizio Paganelli:** però lì lì i biglietti gli vengono mandati via direttamente da da Zost. Li abbiamo li abbiamo già mandati posto. Li stanno mandando adesso i biglietti del pianissimo live,

**Aurel mrruku:** quindi Ok,

**Fabrizio Paganelli:** quindi ci togliamo anche il problema del pianissimo live.

**Aurel mrruku:** perfetto. Quindi stiamo dicendo che solo per le fatture

**Elena Spini:** Eh, però no, aspetta, scusa.

**Aurel mrruku:** successive, quindi nella prossima addizione noi dobbiamo pagare, quindi noi il cliente deve pagare la fattura. Quando pagherà la fattura, lo stato della riga, quindi dell'asset, andrà in assegnato e solo in quel momento la marketing può prendere gli asset da inviare.

**Fabrizio Paganelli:** Sì, in linea teorica è così. Sì.

**Elena Spini:** No, aspetta. Però perché cioè non mi torna a quest'ultimo punto se avete detto che avete già mandato i biglietti, cioè parliamo sempre di l'evento fine novembre, pienissimo live 23 24 26.

  
  

### **00:49:32**

  

**Fabrizio Paganelli:** Sì, sì. Cosa non torna?

**Elena Spini:** Quindi qua avete avete già mandato i biglietti,

**Fabrizio Paganelli:** Sì.

**Elena Spini:** quindi noi come cioè per le logiche di marketing questo, cioè sarebbero già assegnati in realtà questi biglietti.

**Aurel mrruku:** Eh, però sono sono legati a un'edizione, Elena,

**Elena Spini:** Sì.

**Aurel mrruku:** e noi per quell'edizione praticamente lo escludiamo quell'edizione su su per marketing.

**Elena Spini:** Ah, ok.

**Fabrizio Paganelli:** Cioè,

**Elena Spini:** Stian dicendo che la escludiamo pienissimo live.

**Fabrizio Paganelli:** è pienissimo live 2026 e io non la creerò l'edizione su Sales Force.

**Elena Spini:** Ok. Sì, questo era il il dubbio.

**Fabrizio Paganelli:** Sì, sì.

**Elena Spini:** Partiamo con le logiche di creazione asset, biglietti e quant'altro per ordini aperti con edizioni di Academy o camerier venditori o se c'è qualcos'altro.

**Fabrizio Paganelli:** Intensive sareb Sì, intensive sono anche poche persone, non l'abbiamo eh solito. Sì, però nell'intensifica è talmente piccolo che non l'abbiamo mai strutturato come un evento normale, insomma. M.

**Elena Spini:** Perché in realtà Ah.

**Aurel mrruku:** Ok.

**Elena Spini:** Perché noi abbiamo detto il 16 novembre, però il 16 novembre, ok, facciamo le fatture, facciamo tutte le logiche, ma però tutto quello che è biglietti e marketing non sarà su salesce.

  
  

### **00:51:12**

  

**Fabrizio Paganelli:** No, no, no, no. Per il pienissimo live del 24 di 24 25 26 di

**Elena Spini:** Ok,

**Fabrizio Paganelli:** novembre lavoriamo tutto su Zoo. Poi dopo se Sì,

**Elena Spini:** questo non l'avevo ancora capito io.

**Fabrizio Paganelli:** sì, è così, anche perché abbiamo tutto là. Poi dopo se questo lavoro che di cui stiamo parlando adesso va a buon fine,

**Elena Spini:** 4.

**Fabrizio Paganelli:** eh intendo l'importazione massiva e quando saremo a eh gennaio che ci sarà l'Academy, i biglietti li manderemo via direttamente da Salesforce.

**Elena Spini:** Speriamo.

**Aurel mrruku:** Sì, sì.

**Fabrizio Paganelli:** Volevo volevo chiedere una cosa. Se in questa importazione poi dopo io mi accorgo che magari c'è un'anomalia, un cliente anziché due biglietti ne doveva avere tre o anziché tre ne doveva avere due, io posso fare delle correzioni andando a lavorare cliente per

**Aurel mrruku:** Gli dobbiamo fare li dobbiamo fare li dobbiamo fare per forza insieme

**Fabrizio Paganelli:** cliente? Vai,

**Aurel mrruku:** perché dall'interfaccia non puoi fare un granché perché ci sono degli automatismi. Poi quando andremo in produzione dopo il caricamento massivo,

**Fabrizio Paganelli:** eh. Eh,

  
  

### **00:52:19**

  

**Aurel mrruku:** io devo ricambiare queste logiche perché

**Fabrizio Paganelli:** ok.

**Aurel mrruku:** deve stare il flusso quello normale. Quindi,

**Fabrizio Paganelli:** Ok.

**Aurel mrruku:** se ci sono delle anomalie devo in qualche modo io rimettere in funzione la logica che abbiamo appena parlato perché

**Fabrizio Paganelli:** No, no, no, non intendevo quello. Non intendevo quello. Eh, ok. Noi in in nell'ambiente di test facciamo tutto questo lavoro. Una volta che l'abbiamo fatto, magari io vedo anche di quadrare i dati eccetera eccetera, no? Poi diciamo "Ok, tutto va tutto bene, passiamo in produzione, tu sgancerai questo tipo di elaborazione in modo tale che giri solo l'elaborazione standard". Va benissimo. Però io mi chiedevo, nel caso in cui vado su un determinato cliente, vado nei suoi biglietti, non so se qui ci sono gli asset,

**Aurel mrruku:** Sì, sì.

**Fabrizio Paganelli:** vedo questo qui, visualizza tutto, lo vedo, mi accorgo che è sbagliato.

**Aurel mrruku:** Sì, puoi cambiare lo stato.

**Fabrizio Paganelli:** Lo posso modificare in qualche modo?

**Aurel mrruku:** Sì, sì, sì, sì.

**Fabrizio Paganelli:** Lo posso modificare?

**Aurel mrruku:** Te te te lo puoi modificare, ma tieni in considerazione che questa modifica non deve succedere a mano.

  
  

### **00:53:26**

  

**Fabrizio Paganelli:** Sì, sì. Ok, va benissimo, va benissimo.

**Aurel mrruku:** Se tu da amministratore lo puoi fare,

**Fabrizio Paganelli:** Quindi io vado qui, gli dico "No, non mi non mi sta bene,

**Aurel mrruku:** eh,

**Fabrizio Paganelli:** questo qui lo metto annullato".

**Aurel mrruku:** fai annullato. Sì,

**Fabrizio Paganelli:** A posto?

**Aurel mrruku:** quello lo puoi fare sempre.

**Fabrizio Paganelli:** E ok.

**Aurel mrruku:** Poi ovviamente scatterà dietro le quinte l'automatismo che è

**Fabrizio Paganelli:** Stavo dicendo, Ups.

**Aurel mrruku:** stato previsto in precedenza quando va in annullato, capito? Quindi se va in annullato, quando se per qualche motivo tu lo metti annullato, ma già il biglietto, quando andrà a scannerizzare il biglietto gli

**Fabrizio Paganelli:** Mh.

**Aurel mrruku:** darà errore.

**Fabrizio Paganelli:** No, no, ma io io intendevo se c'è se ci accorgiamo noi di un errore lo metto in annullato, dopo è chiaro che questo cliente non si presenta neanche al durante l'evento.

**Aurel mrruku:** Ok, ok, ok.

**Fabrizio Paganelli:** Oppure se mi accorgo che questo qui, anziché eh anziché avere avere come faccio a tornare indietro qua?

**Aurel mrruku:** Anche là. Sì,

**Fabrizio Paganelli:** Anzi, anziché qui vedo un biglietto, se lui ne aveva diritto a due oppure

  
  

### **00:54:40**

  

**Aurel mrruku:** perché hai perché ha un biglietto non lo puoi fare te, lo devo per forza fare io tramite script

**Fabrizio Paganelli:** Ah, ok. E questo anche mh

**Aurel mrruku:** perché il biglietto è legato a un prodotto che è legato a una campagna.

**Fabrizio Paganelli:** Ok, quindi dovrei in linea teorica mettere dentro un preventivo eh a a se se voglio creare se voglio dare un biglietto in più a un cliente, mi creo un opportunity, un preventivo,

**Aurel mrruku:** Sì,

**Fabrizio Paganelli:** un ordine a importo zero per dire se non glielo voglio far pagare,

**Aurel mrruku:** sì,

**Fabrizio Paganelli:** perfetto, va bene.

**Aurel mrruku:** sì.

**Fabrizio Paganelli:** che poi è come facciamo adesso, giusto Elisa? Più o meno. Ok, va bene. Mh, sono abbastanza sono abbastanza fiducioso. Aurel, te cosa dici?

**Elena Spini:** Aspetta che stava per arrivare la mia domanda.

**Aurel mrruku:** No,

**Elena Spini:** Aure,

**Aurel mrruku:** io non ho fatto sulla parte facile perché ci

**Elena Spini:** quanto ci

**Aurel mrruku:** mancano i bundle e il pienissimo plus.

**Elena Spini:** aspetta Aspetta.

**Fabrizio Paganelli:** Perché i bundle non è uguale?

**Aurel mrruku:** I bundle tu non ce li hai i bundle su

  
  

### **00:56:00**

  

**Fabrizio Paganelli:** No, ma i bundle facciamo finta che siano un ordine normale,

**Aurel mrruku:** ordini semplici.

**Fabrizio Paganelli:** dai,

**Aurel mrruku:** Ok, vabbè, allora sì,

**Fabrizio Paganelli:** un ordine semplice tanto.

**Aurel mrruku:** ok, ok. Perché pensavo che volevi i codici dei bundle, ma non saranno dei non saranno visti come i band gli ordini, quindi tu non avrai la categorizzazione degli ordini come ce li abbiamo

**Fabrizio Paganelli:** No, no, sui dati storici non me ne frega,

**Aurel mrruku:** dell Ok,

**Fabrizio Paganelli:** non me ne frega niente,

**Aurel mrruku:** ok, ok, ok.

**Fabrizio Paganelli:** ci arrangeremo in un altro modo se vogliono fare delle analisi statistiche sui dati storici. Io l'importante è che carichiamo lo storico affinché ogni tutor veda qual è il fatturato di quel cliente, capito? E e poi dopo se vogliono quante vendite da palco, quante vendite da bando, le faremo in un altro modo. Non è questo. Non possiamo risolverlo da qui, dai.

**Elena Spini:** ci ha risposto nel mentre Mirko del campo data ordine.

**Aurel mrruku:** M aspetta.

**Elena Spini:** Mamma, come lo vedi brutto così te,

**Aurel mrruku:** Eh,

**Elena Spini:** Fabrizio.

  
  

### **00:57:07**

  

**Fabrizio Paganelli:** Eh,

**Aurel mrruku:** infatti ti sei abituato.

**Fabrizio Paganelli:** non lo so perché voi lo vedete così.

**Aurel mrruku:** No, no,

**Elena Spini:** No,

**Aurel mrruku:** no,

**Fabrizio Paganelli:** Voi lo vedete così.

**Elena Spini:** no,

**Aurel mrruku:** no.

**Elena Spini:** tutto nero per fortuna. Cioè, mi fa venire il mal di testa. data ordine,

**Fabrizio Paganelli:** sigla ordine, serie ordine, numero ordine, data ordine.

**Aurel mrruku:** Perfetto, abbiamo tutto.

**Fabrizio Paganelli:** Eh,

**Aurel mrruku:** Quindi uso quella data ordine come chiave e siamo a posto.

**Elena Spini:** però aspetta,

**Fabrizio Paganelli:** sì.

**Elena Spini:** la chiave abbiamo quindi abbiam detto che la chiave per

**Aurel mrruku:** Qua tutte queste quattro insieme.

**Elena Spini:** e basta perché Fabrizio diceva che serviva forse anche il codice cliente,

**Aurel mrruku:** No, no, non mi serve.

**Elena Spini:** no?

**Aurel mrruku:** Non mi serve perché io il cliente ce l'ho già sull'ordine,

**Elena Spini:** Quindi sigla,

**Aurel mrruku:** cioè già.

**Elena Spini:** serie numero più data ordine fanno la chiave per legare l'ordine alla fattura.

**Aurel mrruku:** Corretto?

**Elena Spini:** per legare la fattura all'ordine.

**Aurel mrruku:** Sì, chiaro. Fabrizio,

**Fabrizio Paganelli:** Penso di sì.

  
  

### **00:58:07**

  

**Aurel mrruku:** riesci prima possibile a darmi un insim anche 10 record, 20 record.

**Fabrizio Paganelli:** No, no, io sono, passatemi il termine, state registrando?

**Elena Spini:** Sì, fa niente.

**Fabrizio Paganelli:** State registrando? Allora, io sono un t\*\*\*\*\*\*\*\*\*\*\*\*\*, quindi se te le passo te li passo tutti in una volta.

**Aurel mrruku:** Sì, sì, più più ne sono meglio è.

**Fabrizio Paganelli:** Ah, sto scherzando.

**Aurel mrruku:** Solo che mi devi passare quei campi, come ti ho detto,

**Fabrizio Paganelli:** Sì.

**Aurel mrruku:** perché io devo iniziare a cambiare la logica sulla data di fatturazione per collegarlo al Stiamo parlando sempre sugli ordini aperti.

**Elena Spini:** Aperti,

**Fabrizio Paganelli:** Massiv.

**Aurel mrruku:** Aperti vuol dire che ordini non incassati.

**Elena Spini:** aperti.

**Aurel mrruku:** E se eh tu m'hai fatto vedere gli ordini, ma le righe le righe d'ordine Ne.

**Fabrizio Paganelli:** Qui da qualche parte dovrei avere anche l'ID di riga. Qui ci sono tutti i codici prodotto.

**Aurel mrruku:** Ok.

**Fabrizio Paganelli:** Questo qui è un ordine, è un unico ordine.

**Aurel mrruku:** Ah, è un un Ok.

**Fabrizio Paganelli:** Eh, questo avevo messo il filo stato.

**Aurel mrruku:** Ma c'è uno stato per caso da qualche parte?

  
  

### **00:59:24**

  

**Aurel mrruku:** Eh,

**Fabrizio Paganelli:** In che senso?

**Aurel mrruku:** pagato, non pagato.

**Fabrizio Paganelli:** Pagato, non pagato.

**Aurel mrruku:** Sì.

**Fabrizio Paganelli:** Dopo questo te lo metto io.

**Aurel mrruku:** Ok,

**Fabrizio Paganelli:** Te lo metto io.

**Aurel mrruku:** perfetto.

**Fabrizio Paganelli:** Qui qui non c'è, ma te lo devo aggiungere. è quello che adesso prima ho fatto la battuta, però eh una volta che io imposto il lavoro, provo a fartelo con Power BI e una volta che te l'ho

**Aurel mrruku:** Ok,

**Fabrizio Paganelli:** imposto darti 10 righe o dartele tutte è indifferente, capito?

**Aurel mrruku:** allora.

**Fabrizio Paganelli:** Il tempo che mi ci vuole è uguale, per cui tanto vale che te te lo faccio tutto e amen

**Aurel mrruku:** Ok, più sonno meglio è.

**Elena Spini:** E le cose che dovresti aggiungere sono quindi Yeah.

**Fabrizio Paganelli:** M.

**Elena Spini:** Abbiamo detto la data di scadenza da cui poi noi facciamo le da cui Aurel poi farà le trance.

**Fabrizio Paganelli:** Sì,

**Elena Spini:** Perfetto. E questo status che sarebbe poi lo stato della tranche che ci permette di capire

**Fabrizio Paganelli:** è lo stato

**Elena Spini:** se effettivamente è stato pagato.

  
  

### **01:00:15**

  

**Aurel mrruku:** stato della riga che poi farò io un automatismo che in base alla data di scadenza si farà un raggruppamento sulle righe che hanno la stessa data e diranno la data del della tranch perché la stato della

**Elena Spini:** Giusto. Riga.

**Aurel mrruku:** tranch

**Fabrizio Paganelli:** Te Aurel prestato intendi quel famoso P e oppure nullo? Giusto.

**Aurel mrruku:** PE era pagato. Sì,

**Fabrizio Paganelli:** P era pagato e vuol dire che c'era la riba o ridotto vuol dire che

**Aurel mrruku:** ma anche quello l'ho tratto come pagato,

**Fabrizio Paganelli:** doveva Sì.

**Aurel mrruku:** se ti ricordi. Quindi se lo stato è nullo vuol dire che non è stato pagato.

**Fabrizio Paganelli:** Ok. Eh, allora

**Aurel mrruku:** Anzi ti dico un'altra cosa. Non mi deve manche passare lo stato,

**Fabrizio Paganelli:** perché tanto te c'è nello scadenziario.

**Aurel mrruku:** perché lo stato io ce l'ho nello scadenziario

**Fabrizio Paganelli:** Eh,

**Aurel mrruku:** e lo prenderai in automatico.

**Fabrizio Paganelli:** secondo me sì, anche la data di scadenza.

**Aurel mrruku:** E solo che quello che devo fare io adesso è prendere i scadenziari dal 2025, così aggiorno tutti.

  
  

### **01:01:38**

  

**Aurel mrruku:** ordini, tutte le fatture che con tutti gli ordini dopo il caricamento, se mai capito.

**Fabrizio Paganelli:** Eh,

**Aurel mrruku:** Quindi caricherò i ordini con tutte le righe dell'ordine,

**Fabrizio Paganelli:** sento

**Aurel mrruku:** verranno create le tranch, poi devo fare in modo di non prendere le fatture ultime due modifiche ultime due settimane, un mese, ma devo prendere dall'inizio 2025,

**Fabrizio Paganelli:** Tutto scendo.

**Aurel mrruku:** quindi da quando tu mi manderai gli ordini. Vediamo. Eh, io spero che due tre massimo 4 giorni riesco a fare tutta sta cosa in ambiente di UAT.

**Elena Spini:** E ci stiamo dicendo che questa logica che noi dobbiamo andare a ricreare trunch, asset, biglietti, link e quant'altro, lo dobbiamo fare solo per ordini aperti, ovvero di cui manca ancora una fatturazione di trano,

**Fabrizio Paganelli:** solo per solo per le fatture che hanno una data fattura compresa negli intervalli dei delle campagne che io creerò. l'abbiamo detto prima, cioè Eh, io dovrò prima creare le le edizioni le edizioni

**Elena Spini:** Beh, che corrisponde a ordini aperti di fondo.

**Fabrizio Paganelli:** figlie,

**Elena Spini:** No.

**Fabrizio Paganelli:** eh no, perché quelli perché io potrei avere anche un ordine chiuso, un ordine fatturato e incassato chiuso, ma che fa riferimento ad una ad un evento successivo.

  
  

### **01:03:21**

  

**Fabrizio Paganelli:** Era quello che dicevo prima. Io oggi ho delle fatture che degli ordini che sono stati fatturati e le fatture sono state anche incassate, ma fanno riferimento ad una edizione che si verificherà a a gennaio 2027 o a marzo 2027. era quello che dicevamo prima,

**Elena Spini:** Sì.

**Fabrizio Paganelli:** che poi dopo correggetemi se sbaglio,

**Elena Spini:** Eh

**Fabrizio Paganelli:** eh, che tantoè vero che abbiamo detto, allora la prima cosa da fare a questo punto è preparare tutte le edizioni future con data inizio, data fine, eccetera eccetera. Ma pari i prodotti e poi Aurel diceva io per per tutti gli ordini che mi passerai vado a leggere la data della fattura eccezionalmente la data della fattura. Se la data della fattura è compresa e in quelle in un range delle edizioni che andrò a inserire, allora genererà anche il biglietto perché il cliente deve ancora venire effettivamente all'evento. Sento silenzio dalla vostra parte. Ho detto delle boiate.

**Elena Spini:** No, io sto scrivendo e a me è chiaro, però cioè penso che anche per Aurel va bene, non lo so, però l'importante è quindi che noi abbiamo quindi due sorte di Excel, la dico male.

  
  

### **01:04:40**

  

**Elena Spini:** uno che saranno semplicemente ordini chiusi, tutto fatto, finito, semplicemente delle righe senza logiche, senza aggiornamenti da fare che immagino ci siano,

**Fabrizio Paganelli:** M.

**Elena Spini:** giusto? ordini legati a fatture che ordini che sono che non sono a legati a qualsiasi altro aggiornamento, tipo fatture che possono generare altri biglietti eccetera. E un altro Excel invece di cui stiamo parlando adesso possono essere sia ordini chiusi che ordini aperti perché ci possono essere appunto ordini chiusi che sono legati a fatture che sono sì state pagate ma che possono generare eh che hanno generato dei biglietti nel futuro. No.

**Fabrizio Paganelli:** Ma a me a sto punto mi viene da fare una domanda. È necessario distinguerla questa cosa? Visto quello che ci siamo appena detti? Cioè, perché dobbiamo di tenere separato ordini chiusi da ordini aperti? Perché tu, Aurel, mi dicevi adesso non c'è bisogno neanche che mi passi una colonna con la data con la con lo stato della riga, perché tanto io leggo tutto dallo Кака.

**Elena Spini:** M.

**Aurel mrruku:** M.

**Fabrizio Paganelli:** poi alla fine,

**Aurel mrruku:** Sì, sì,

  
  

### **01:06:01**

  

**Fabrizio Paganelli:** ma a sto punto non c'è neanche bisogno che io ti passi ordini aperti, ordini chiusi, ti passo tutto. Alcuni ordini saranno saranno aperti,

**Aurel mrruku:** no,

**Fabrizio Paganelli:** ma quello lì No, dimmi dimmi.

**Aurel mrruku:** ma i ordini io io volevo dividere ordini aperti, ordini chiusi per fare l'algoritmo di creazione delle tranche eccetera solo sugli ordini

**Fabrizio Paganelli:** Eh eh.

**Aurel mrruku:** aperti perché cambia per me tanto, eh. Perché se tu non vuoi,

**Fabrizio Paganelli:** Però

**Aurel mrruku:** se tu vuoi fare tutto anche per ordini chiusi, devi fare tutte le campagne, anche generare tutte le campagne in sales force dal 2025

**Elena Spini:** pure vecchie.

**Fabrizio Paganelli:** no, ma eh

**Aurel mrruku:** e fare la mappatura e ti assicuro che perderai un giorno a fare la mappatura di tutto sta roba.

**Fabrizio Paganelli:** cioè ma scusate eh, provo a ridirla. Proviamo a fare un piano, un piano. Quindi abbiam detto io pienissimo l'edizione, pienissimo live non la creerò, no?

**Aurel mrruku:** Sì.

**Fabrizio Paganelli:** Perché abbiam detto gestiamo tutto su Sales Force. Poi vado nel mio calendario e vado. Adesso vi condivido il mio calendario.

  
  

### **01:07:10**

  

**Elena Spini:** Su.

**Fabrizio Paganelli:** Vado nel mio calendario. Facciamo così, così non vi faccio vedere tutte le mie schifezze. Facciamo così. Io avrò eh qui abbiamo il pienissimo live, qui abbiamo l'intensif, l'intensive è l'ultimo dei problemi perché è un evento dove vengono inventi, quindi non è non non dice niente. Poi avrò il il 19 dal 19 di gennaio avrò l'Academy 27. Poi,

**Aurel mrruku:** Academy 27 avrà una da data da a, quindi due

**Fabrizio Paganelli:** esatto. Io lì metterò quando avrò andrò a creare l'edizione metterò dal ipotizziamo che l'abbiamo fatta negli stessi giorni dell'anno scorso. Metterò dal 22 gennaio 2026 a a 19 gennaio 2027.

**Aurel mrruku:** 27.

**Fabrizio Paganelli:** Per cui quando ti passerò tutto ipotizziamo per assurdo e che ti passo tutto un blocco senza distinguere tra aperti e chiusi, eccetera eccetera. ti passo tutto. Tu vedrai che nel nelle negli nel passami il termine nella fattura che hanno data dal 22 gennaio 26 al 19 gennaio 27 tu creerai li

**Aurel mrruku:** li collego a quella campagna.

**Fabrizio Paganelli:** collega qua la campagna. Se poi dopo avrai lo scadenziario e vedrai quella fattura è stata pagata, sì.

  
  

### **01:08:57**

  

**Fabrizio Paganelli:** Allora,

**Aurel mrruku:** E questi sono gli ordini.

**Fabrizio Paganelli:** rendi disponibile. biglietto.

**Aurel mrruku:** aperti.

**Elena Spini:** Esatto.

**Fabrizio Paganelli:** Perfetto.

**Aurel mrruku:** Se tu mi passi dei ordini con la data di fattura nel 2025,

**Fabrizio Paganelli:** Ecco,

**Aurel mrruku:** mi andrà tutto in errore,

**Fabrizio Paganelli:** ad esatto quello che hai detto creare le

**Aurel mrruku:** mi esplode tutto, perché non trova la campagna.

**Fabrizio Paganelli:** vecchie, quindi Ah, e quindi devo creare anche le campagne vecchie.

**Aurel mrruku:** Se vuoi fare tutto in questo modo

**Elena Spini:** E quello stanno cercando di dire o

**Fabrizio Paganelli:** Eh, però se creo la campagne vecchie,

**Aurel mrruku:** è questo,

**Fabrizio Paganelli:** se creo le campagne vecchie dopo

**Aurel mrruku:** ti sto dicendo, mi devi dividere. gli ordini chiusi,

**Elena Spini:** chiusi. Sì.

**Aurel mrruku:** così gli ordini chiusi non te li collego con delle campagne,

**Fabrizio Paganelli:** Ah,

**Aurel mrruku:** con dei biglietti eccetera.

**Fabrizio Paganelli:** ma allora allora la faccenda si si ingrossa perché se è così io non ti posso fare una estrazione degli ordini chiusi complessiva e un'estrazione degli ordini chiusi, degli ordini aperti complessiva. mi tocca fartela evento per evento perché le date da data a data non sono uguali, capito?

  
  

### **01:09:58**

  

**Fabrizio Paganelli:** Cioè, no,

**Aurel mrruku:** Ti sto dicendo che se gli ordini sono chiusi io non ti

**Fabrizio Paganelli:** eh.

**Aurel mrruku:** faccio neanche il collegamento con l'edizione. Non c'ha l'avra non avrai il biglietto quell'ordine chiuso, quell'ordine incassato intendo.

**Fabrizio Paganelli:** No, allora io non ho capito,

**Aurel mrruku:** А

**Fabrizio Paganelli:** scusatemi, io non ho capito, cioè rimaniamo su su questo caso qui,

**Elena Spini:** M.

**Fabrizio Paganelli:** no? Io ti passo i dati dal primo di gennaio 2026. Ipotizziamo, se tu trovi un Academy venduta il 10 di gennaio 26, quindi prima dell'inizio dell'edizione dell'Academy 27, tu dici la la procedura mi va in errore,

**Aurel mrruku:** Sì,

**Fabrizio Paganelli:** ok? A meno che io ti creo anche l'Aemy 2026,

**Aurel mrruku:** e non solo, mi devi creare l'Academ 26 e mi devi fare anche la mappatura dei prodotti su quello.

**Fabrizio Paganelli:** la mappatura. Ma bene, bene. Ok, fin qua ci siamo. Poi dopo io mi chiedo, ma se io ti creo l'Academy 2026, quando poi nella fase successiva mi andrai a leggere lo scadenziario, vedrai che con la fattura è pagata, mi renderai disponibile un biglietto legato all'Academy 26?

  
  

### **01:11:12**

  

**Fabrizio Paganelli:** Sì.

**Aurel mrruku:** Sì,

**Fabrizio Paganelli:** Eh, cosa che noi non vogliamo perché vogliamo avere solo quelli. Ah, e quindi questo qui è un ordine aperto,

**Aurel mrruku:** sì.

**Fabrizio Paganelli:** mentre invece l'ordine chiuso sarebbero le fatture dove dentro c'è l'Academy 2000 e eh un codice articolo dell'Academy, ma in cui la data fattura è antecedente al 22 gennaio 26.

**Aurel mrruku:** corretto.

**Fabrizio Paganelli:** p\*\*\*\* Madongi. Allora, qui si fa si fa molto complicata la cosa perché io ti devo fare un'estrazione per ogni singolo

**Aurel mrruku:** Что?

**Fabrizio Paganelli:** evento, poi all'interno di una fattura calcola che ci possono essere più codici prodotto dove

**Elena Spini:** Okay.

**Fabrizio Paganelli:** hanno il range di dati diverso. M è un casino. È un casino.

**Aurel mrruku:** Tu puoi avere anche diversi eventi sulla st sullo stesso ordine,

**Fabrizio Paganelli:** Ah, sì, io ho più evosso avere più eventi sullo stesso ordine.

**Aurel mrruku:** però basta che tu fai un'edizione, quindi diverse edizioni, intendevo, con diversi eventi, tu fai eh l'edizione, metti data da a e crea e la mappatura su per su tutti i prodotti per tutti i prodotti su quell'edizione.

  
  

### **01:12:34**

  

**Fabrizio Paganelli:** No, ma io non è un problema per me creare le edizioni. Te ne posso creare anche 1000.

**Aurel mrruku:** Eh, Fabrizio,

**Fabrizio Paganelli:** Il problema è che se sono Sì.

**Aurel mrruku:** ti posso ti posso chiedere eh perché ho paura che stiamo facendo tanto lavoro quando forse con pochi soldi riuscite a chiudere tutti ordini aperti su Zoo. Quindi non sarebbe possibile per questi ordini aperti tenere Zof quando c'è l'ultimo evento, così non ce l'hai questo problema. E lo storico degli ordini lo porti su Sales Force quando hai chiuso tutti gli ordini, quindi hai finito anche l'ultimo evento che è stato creato da Zo.

**Fabrizio Paganelli:** Non ce la faremo mai. Non ce la faremo mai. Non ce la

**Aurel mrruku:** Quando è l'ultimo evento che avete adesso su Zo?

**Fabrizio Paganelli:** marketing 2027. Abbiamo tutti gli eventi del 2027 su zona noi adesso perché noi a in questi ultimi mesi stiamo fatturando e e incassando fatture che sono legate ai eventi che magari ci sono in gennaio, ci sono in marzo, ci sono, guarda gennaio e febbraio non c'è. Adesso qui c'è c'è Soldout in marzo e c'è Cameritori EPeam

  
  

### **01:14:14**

  

**Aurel mrruku:** Ok.

**Fabrizio Paganelli:** in aprile, la Mastery, questa qui la stiamo fatturando eh già adesso fino a

**Aurel mrruku:** Fin dove?

**Fabrizio Paganelli:** ottobre fino a ottobre 2000 fino a eh fino a settembre del

**Aurel mrruku:** 27.

**Fabrizio Paganelli:** 27. Noi abbiamo l'anno accademico che va da settembre a a a a Sì. inizia in settembre. settembre, maggio, perché per luglio agosto non ci sono eventi, insomma, però eh

**Aurel mrruku:** Chiaro, chiaro.

**Fabrizio Paganelli:** non non se così non ce la facciamo.

**Aurel mrruku:** Vè, no, no, no, no, capisco, eh.

**Fabrizio Paganelli:** A a meno che a meno che ce ne freghiamo della ce ne freghiamo, andiamo dritto, creiamo Academy 26, Academy 27, per rimanere sul caso specifico, tu mi genererai anche i biglietti sull'Academy 26 e poi vorrà dire che dovremmo andare a mano dentro a mettere lo stato di annullato su tutti quei biglietti perché non dobbiamo dobbiamo fare in modo che quei biglietti lì poi non vengano mandati via di nuovo. Sen no, mandiamo regaliamo dei biglietti ai clienti,

**Aurel mrruku:** Piano, chiaro,

**Fabrizio Paganelli:** capito?

**Aurel mrruku:** chiaro, chiaro.

**Fabrizio Paganelli:** Non lo so se non c'è una una soluzione alternativa,

  
  

### **01:15:32**

  

**Aurel mrruku:** Ma ma ma poi c'è un altro problema.

**Fabrizio Paganelli:** dobbiamo andare a fare così.

**Aurel mrruku:** Noi nei biglietti che mandiamo da Sales Force devi praticamente scannerizzare un QR code che generi in salesce. Invece sui biglietti che hai già inviato, però tu hai detto che hai inviato solo il biglietti del prossimo evento che è il 22 e poi basta.

**Fabrizio Paganelli:** Ah, no,

**Elena Spini:** No, poi e basta.

**Fabrizio Paganelli:** sì, sì. I biglietti non li abbiamo inviati.

**Elena Spini:** Infatti no,

**Aurel mrruku:** Ok,

**Fabrizio Paganelli:** No,

**Aurel mrruku:** ok,

**Fabrizio Paganelli:** no.

**Aurel mrruku:** ok.

**Elena Spini:** per il problema di generazione dei biglietti del non mi ricordo più quale avvi fatto l'esempio di Academy 2026, cioè piuttosto sì, ok, facciamo che creiamo i biglietti e poi li annulliamo massivamente, cioè Ma sì,

**Fabrizio Paganelli:** Si possono annullare massivamente,

**Elena Spini:** facciamo un update,

**Fabrizio Paganelli:** me li potete annullare voi massivamente

**Elena Spini:** no, Aurel,

**Aurel mrruku:** Sì,

**Elena Spini:** Eh

**Aurel mrruku:** basta che mi dai l'evento, ti annullo tutti i biglietti di quell'evento.

**Fabrizio Paganelli:** per dire, no, se dico dico una boiata, eh Se io ehm supponiamo ehm potrei anche creare un'edizione tipo Academy 27, potrei creare un'edizione che la chiami in modo balordo Academy Import ipotesi,

  
  

### **01:16:52**

  

**Aurel mrruku:** Sì, sì, sì. Ha anche più senso così.

**Fabrizio Paganelli:** no? Eh,

**Aurel mrruku:** Non genero il link dei biglietti perché Academy Import

**Fabrizio Paganelli:** eh,

**Elena Spini:** No, di Academy Import Allora, è Academy Import 2026 per quella passata.

**Fabrizio Paganelli:** sì, cioè l'Academy 27 è quella buona e dove si devono generare i biglietti che ha

**Elena Spini:** Esatto. I biglietti,

**Fabrizio Paganelli:** dat che Esatto che ha la data.

**Elena Spini:** il link e tutto.

**Fabrizio Paganelli:** Lo sc lo scrivo, guarda, così vedete anche voi.

**Elena Spini:** Sì, tutto ciò che è è edizione import anno passato non

**Fabrizio Paganelli:** Io faccio così quando edizione edizioni e

**Elena Spini:** deve generare biglietti.

**Fabrizio Paganelli:** farò allora farò Academy 2027, qui ci metterò dal 2201202 al 1901. Scusate, eh. E poi che la chi ne faccio un'altra antecedente che la chiamo Academy Pippo. Vado vado per assurdo. E qui c'avrà la data dal primo gennaio 2025 se decidiamo di caricare i dati dal 25 al 21012026. Quando facciamo l'importano si devono generare i biglietti su tutto. Poi sarà male che andiamo a eliminare i biglietti su Academy Pippo e così per tutti gli altri gli eventi.

  
  

### **01:18:27**

  

**Fabrizio Paganelli:** Se potete farlo voi con un update massivo. Poi farò ad esempio facciamo l'esempio di camerieri venditori. Camerieri venditori di marzo. Marzo 2027. Questo qui, questo qui quand'è che abbiam detto che ce l'ho? Ce l'abbiamo. Ah, scusate, quindi ho sbagliato anche perché l'abbiamo spostato ad aprile quest'anno. C'è il 6 aprile, eh, scusate. Quindi, cioè il 6 aprile, quindi vuol dire che tutto quello che io fatturerò fino al 6 aprile 202 a partire dal primo di marzo 2026, perché l'anno scorso l'abbiamo fatto più o meno in quella data lì, andiamo a vedere così facciamo proprio le cose, facciamo proprio l'esempio concreto. L'anno scorso ce l'abbiamo avuto camerieri venditori il 24 di marzo, quindi qua ci va tutto quello che ho fatturato dal 25 di marzo 2026. Al aprile 27 sarà camerieri venditori aprile aprile 27. Poi qui mi creerò un camerieri venditori Pippo, come di là. Pippo che avrà dal primo di gennaio 2025 al 24032026. Facciamo l'importano i biglietti bla bla bla e poi in modo massivo andiamo a eliminare tutti i biglietti di camerieritori Pippo.

  
  

### **01:20:16**

  

**Fabrizio Paganelli:** Cosa ne dite?

**Elena Spini:** A me torna.

**Fabrizio Paganelli:** Allora, se è così carichiamo i dati dal 2024.

**Aurel mrruku:** Allora, e poi devi fare la mappatura, sai?

**Elena Spini:** Esatto.

**Fabrizio Paganelli:** Sì, sì. No,

**Elena Spini:** Eh,

**Fabrizio Paganelli:** ma la mappatura la faccio, quello non è un problema. Ma è l'ultimo dei miei problemi fare la mappatura e più che altro è trovare il metodo. Dopo il il badile non c'è problema a usarlo.

**Aurel mrruku:** Ok. Ok. Perché come a me cambia niente se c'è la mappatura e se c'è l'edizione l'inserimento, perché io come te, come tu prendi tutto, se faccio per un record, se faccio per 200 record, 2000 record, non è che mi cambia tanto.

**Fabrizio Paganelli:** Mm.

**Aurel mrruku:** Il problema è se tu non hai la mappatura in modo corretto,

**Fabrizio Paganelli:** Ok,

**Aurel mrruku:** se non trovi l'edizione esplode e devo rifare da capo.

**Fabrizio Paganelli:** ok,

**Aurel mrruku:** Per quello li volevo dividere i record aperti, scusa, gli ordini aperti, gli ordini chiusi.

**Fabrizio Paganelli:** ok. Cioè, così Aurel non c'è neanche bisogno di fare ordini aperti e ordini chiusi, dico bene?

  
  

### **01:21:26**

  

**Aurel mrruku:** Faccio per tutti gli ordini e poi quando vado a prendere il scadenziario lo prendo su tutto.

**Fabrizio Paganelli:** Eh?

**Aurel mrruku:** In automatico il scadenziario aggiorna se tutto

**Fabrizio Paganelli:** Tutto? Sì.

**Aurel mrruku:** funziona. Però un bel test da vedere anche quello che non va. Quindi possiamo fare anche pulizia in questo modo.

**Fabrizio Paganelli:** Mh. Sì, sì,

**Aurel mrruku:** Ovviamente dobbiamo avere anche account dal 2026

**Fabrizio Paganelli:** ah certo.

**Aurel mrruku:** 2024,

**Fabrizio Paganelli:** No, no,

**Aurel mrruku:** quindi devi avere

**Fabrizio Paganelli:** ma m gli K.

**Elena Spini:** E tra l'altro mi è venuto in mente gli account. Sì. E in realtà c'è anche i contatti perché i biglietti poi sono legati ai contatti.

**Aurel mrruku:** Ma niente, Elena, fa niente,

**Elena Spini:** Sì, fa niente.

**Aurel mrruku:** perché questi biglietti non sono biglietti che sono associati a un contatto.

**Elena Spini:** M quelli che cancelliamo o me ne frego, quelli nuovi servono perché c'è il referente

**Aurel mrruku:** Sì.

**Elena Spini:** di turno a cui poi dobbiamo mandare i biglietti.

**Aurel mrruku:** Ah. E ce l'hai il livello di biglietto queste la mail o non so su cosa l'ho

  
  

### **01:22:32**

  

**Fabrizio Paganelli:** M.

**Aurel mrruku:** fate. Puoi andare un attimo sulla tabella dei dei delle righe d'ordine?

**Fabrizio Paganelli:** su force.

**Aurel mrruku:** No, no,

**Fabrizio Paganelli:** No,

**Aurel mrruku:** su Power BI,

**Fabrizio Paganelli:** su quello che ti ho fatto vedere prima.

**Aurel mrruku:** non so. Sì, quello che fatto vedere prima. Cos'è c'era? Power BI, cos'è? Cos'era quello?

**Fabrizio Paganelli:** No, questo qui è Zalito,

**Aurel mrruku:** Ok. Eh, quale di questi è un biglietto?

**Fabrizio Paganelli:** ad esempio.

**Aurel mrruku:** Ok. Eh, in qualche modo è legato a un codice

**Elena Spini:** C'è il codice cliente. Se parlavamo prima del codice cliente.

**Aurel mrruku:** cliente. Codice cliente sarebbe l'account.

**Elena Spini:** account.

**Aurel mrruku:** Eh, come capisce a chi deve essere inviato questo biglietto?

**Fabrizio Paganelli:** La mail dell'account principale non si può fare.

**Aurel mrruku:** No, no, stiamo parlando. No, stiamo parlando.

**Fabrizio Paganelli:** Eh,

**Aurel mrruku:** Eh, sì, però Elena deve gli metterà lui poi gli account. Che stiamo a di'? Gli scusi i contati. Noi mandiamo il link, il primo link.

  
  

### **01:23:40**

  

**Aurel mrruku:** Sul primo link avrà tre biglietti e metterà lui eh i tre

**Elena Spini:** il referente principale.

**Aurel mrruku:** contati, i referenti.

**Elena Spini:** È vero, è vero,

**Aurel mrruku:** Sì, sì.

**Elena Spini:** è vero. Ok,

**Aurel mrruku:** Quindi noi ce l'abbiamo già il referente principali,

**Elena Spini:** va bene,

**Aurel mrruku:** quindi siamo a posto.

**Elena Spini:** va bene. che non c'è poi al CRM viene creato.

**Aurel mrruku:** Sì.

**Elena Spini:** Perfetto.

**Fabrizio Paganelli:** li metterà lui. Chi?

**Aurel mrruku:** No,

**Fabrizio Paganelli:** Sales force.

**Aurel mrruku:** no.

**Elena Spini:** Il cliente che compila i partecipanti

**Fabrizio Paganelli:** Ok. Però il biglietto quando viene spedito? A chi viene spedito?

**Elena Spini:** al tizio che compila i dati del partecipante. Quindi io, Elena Spini compilo.

**Fabrizio Paganelli:** No, no, quello ho capito,

**Elena Spini:** Ah, è vero,

**Fabrizio Paganelli:** ma quando noi da pienissimo mandiamo via i biglietti,

**Elena Spini:** ancora prima. È vero, è vero, è vero, è vero.

**Fabrizio Paganelli:** i biglietti a chi vanno? andranno alla immagino adesso non mi ricordo, vanno alla mail del contatto principale,

  
  

### **01:24:26**

  

**Aurel mrruku:** Sì,

**Fabrizio Paganelli:** alla mail del titolare,

**Aurel mrruku:** c'è c'è c'è c'è già una mail a livello di di azienda,

**Fabrizio Paganelli:** non mi ricordo,

**Aurel mrruku:** se non mi sbaglio.

**Fabrizio Paganelli:** quindi viene mandato in automatico in base a quelli,

**Aurel mrruku:** Sì, sì.

**Fabrizio Paganelli:** quindi

**Elena Spini:** Eh, ma sì,

**Aurel mrruku:** Poi facciamo anche un check a campione.

**Elena Spini:** facciamo un check perché in realtà, se non sbaglio, cioè non è che era era a livello di di contatto del contatto

**Aurel mrruku:** Sì,

**Elena Spini:** principale.

**Aurel mrruku:** sì, ma c'è cà Vai un attimo sui contatti,

**Elena Spini:** Contatto principale. Sì, c'è. U qua.

**Aurel mrruku:** c'è già un flag contatto principale.

**Elena Spini:** Sì. Ok, perfetto. Quindi, quando abbiamo portato gli account, abbiamo portato anche i contatti che ci hanno dato loro.

**Aurel mrruku:** Adesso non li ho messi tutti i contatti, ho fatto dei test,

**Elena Spini:** Alcuni,

**Aurel mrruku:** non ho inserito alcuni.

**Elena Spini:** sì. No, però tipo ne ho aperto uno a caso, tipo SNC.

**Aurel mrruku:** No, ma vai un attimo sulla tabella dei contatti che ha fornito Fabrizio.

  
  

### **01:25:13**

  

**Elena Spini:** No, ma aspetta, sta condividendo Fabrizio,eh. Gli stai dando ordini a lui,

**Aurel mrruku:** Ah, ok. Eh,

**Fabrizio Paganelli:** Ah\!

**Aurel mrruku:** avevo messo Elena in chat.

**Fabrizio Paganelli:** Ah\! referenti. Questo

**Aurel mrruku:** No,

**Elena Spini:** no?

**Aurel mrruku:** no.

**Elena Spini:** Guarda, però apriti questo qua che si vede. Non so, ne ho aperto uno a caso, sono stata fortunata e compilato bene.

**Aurel mrruku:** No, perché dobbiamo andare sul file Excel che contiene i contati e account perché sui account lì

**Elena Spini:** Bene sul contatto.

**Aurel mrruku:** c'è il non su Sì, anche là.

**Elena Spini:** No.

**Aurel mrruku:** Anche là sì. Sales force. Apriamo account. Apri account sales force V2 era V2

**Fabrizio Paganelli:** Ah, scusate.

**Aurel mrruku:** corretto. E questi sono i record di account. Se vedi qua c'è la PEC. Volendo possiamo creare un contatto con questa pecc. Se volete mandare i contatti principali, vai più a destra, c'è email amministrativa,

**Fabrizio Paganelli:** amministrativo per mandar via i

**Aurel mrruku:** noi usiamo questa, quindi creiamo un account con l'email,

  
  

### **01:26:28**

  

**Fabrizio Paganelli:** biglietti.

**Aurel mrruku:** creiamo un contatto principale con la mail amministra.

**Elena Spini:** Però scusa, anche tu hai importato anche i contatti,

**Aurel mrruku:** No,

**Elena Spini:** no?

**Aurel mrruku:** no, ho fatto dei test, però erano tanti,

**Elena Spini:** Ah,

**Aurel mrruku:** li ho lasciati in ambiente perché non volevo sovraccaricare l'ambiente di test.

**Elena Spini:** ok.

**Fabrizio Paganelli:** No,

**Aurel mrruku:** Adesso vai su Sì,

**Fabrizio Paganelli:** più che altro perché poi ne avremo tanti altri,

**Aurel mrruku:** sì,

**Fabrizio Paganelli:** immagino.

**Aurel mrruku:** ma vai sui contati.

**Fabrizio Paganelli:** in questi in quest

**Aurel mrruku:** Adesso c'è anche il file dei contati.

**Elena Spini:** preferenti forse.

**Aurel mrruku:** Sì.

**Fabrizio Paganelli:** Ah, sì,

**Elena Spini:** Ah,

**Fabrizio Paganelli:** referenti sempre

**Elena Spini:** il primo era manco lo vedevo.

**Aurel mrruku:** Ah, sì, sì,

**Fabrizio Paganelli:** questo.

**Aurel mrruku:** quello là.

**Elena Spini:** Eh

**Aurel mrruku:** E qua c'è il legame con l'account.

**Fabrizio Paganelli:** Sì.

**Aurel mrruku:** Adesso vai più a destra. Volevo capire se c'è un flag per dire che è un contatto principale o no, perché li avevamo messi contatti amministrativi. Ah, p\*\*\*\*\*\*.

**Fabrizio Paganelli:** Qui va contatto principale.

  
  

### **01:27:30**

  

**Aurel mrruku:** Contatto principale. Sì,

**Fabrizio Paganelli:** Sì.

**Aurel mrruku:** quindi in automatico noi mandiamo al contatto principale.

**Elena Spini:** E infatti va bene così,

**Fabrizio Paganelli:** Va bene.

**Elena Spini:** direi.

**Fabrizio Paganelli:** Quindi non abbiamo problemi di tracciato dati. Cioè io non ti devo aggiungere niente nel tracciato.

**Aurel mrruku:** E infatti no,

**Elena Spini:** No.

**Aurel mrruku:** infatti

**Elena Spini:** Ok, perfetto, perfetto.

**Fabrizio Paganelli:** Ok. Adesso adesso a parte gli scherzi, eh. Sto valutando, sto pensando seriamente se non passarvi anche il 24.

**Aurel mrruku:** detto a me cambia niente più lavoro per te per fare la

**Fabrizio Paganelli:** Eh eh

**Aurel mrruku:** mappatura.

**Elena Spini:** creare le diverse edizioni.

**Fabrizio Paganelli:** ma a me non me ne frega, anche quello non me ne frega perché io vi creo ritornando qui, se vi passo i dati dal 24, qui ci metto 24 e fa e fa e non mi cambia niente, capito? Anziché metterci 25 nel nella nel camerieri venditori Pippo, vi metto dal primo gennaio 24. Non so se mi sono spiegato,

**Elena Spini:** Sì, sì.

**Fabrizio Paganelli:** però ci sto ci sto pensando. Non so neanch'io perché effettivamente a livello commerciale sarebbe anche corretto che loro vedano 24 25 26 c\*\*\*\*, partono nel 27, almeno hanno gli ultimi 3 anni di vendita, non non sarebbe poco, insomma.

  
  

### **01:28:54**

  

**Fabrizio Paganelli:** L'unica cosa è che nel 24 avevamo un sacco di porcheria, avevamo la vendita dei prodotti della software, eccetera eccetera. Vi dovrei, diciamo, eliminare tutti i prodotti più bizzarri e lasciarvi soltanto i corsi, fondamentalmente, magari prima ci facciamo, eh. Ah, ma dopo tanto quando vado a tirare giù i dati lo vediamo quanta porcheria c'è. Poi nel 24 e non c'eravamo io e la e l'Elisain amministrazione e No, c'eravamo già, però facevamo un sacco di porcherie, ti ricordi? Sì, sì, perché c'era una gestione completamente diversa e m vedo dai, vedo se se m vedo se passarvi anche il 24 oppure a partire dal 25 in base alla cerco di capire la qualità dei dati, più che altro. E va bene. Prima di passare a un altro argomento che immagino che ne avrete tanti, se io qui guardo questo qua, quindi Aurel, che cosa ti devo eh alle a che ora finiamo la col? Alle 4:30, giusto?

**Elena Spini:** Sì, era le 4:00,

**Fabrizio Paganelli:** Non mi Ah ah,

**Elena Spini:** ma ci proviamo.

**Fabrizio Paganelli:** ok. No, volevo capire.

  
  

### **01:30:27**

  

**Elena Spini:** Vai.

**Fabrizio Paganelli:** Sì, in base a quello che ci siamo detti, se io qui vado avanti, quindi ti compilo i campi che sono in arancione. Aurel non mi sente più.

**Elena Spini:** Allora, aspetta.

**Aurel mrruku:** Sto parlando in muto da un bel po' di tempo,

**Fabrizio Paganelli:** Ah,

**Aurel mrruku:** non so come mai sono in muto.

**Fabrizio Paganelli:** ok.

**Elena Spini:** Ah, perfetto.

**Aurel mrruku:** Eh stavo dicendo che qu la parte più importante per me è la chiave

**Elena Spini:** ch

**Aurel mrruku:** dell'ordine,

**Fabrizio Paganelli:** M.

**Aurel mrruku:** quindi sigla serie ano, però quell'anno a sto punto lo devi mandare lo devi mandare come lo manda,

**Elena Spini:** data ordine.

**Aurel mrruku:** come me lo dà Mirko. Hai visto la mail?

**Fabrizio Paganelli:** Vai, vai.

**Aurel mrruku:** Vedi il campo là in quel modo là, quindi 20 25 30.

**Elena Spini:** Tutto unito,

**Aurel mrruku:** Tutto unito.

**Elena Spini:** senza sp senza attrezzini.

**Fabrizio Paganelli:** Quindi l'anno non ti serve.

**Aurel mrruku:** No, invece dell'anno mi serve quella data.

**Fabrizio Paganelli:** Quindi io qui ti metto 2025 e 0315 così.

**Aurel mrruku:** Sì, sì, sì.

**Fabrizio Paganelli:** E la data

  
  

### **01:31:43**

  

**Elena Spini:** Il campo si chiama data ordine.

**Aurel mrruku:** che vabbè e c'è già data ordine, però mi serve in quel formato.

**Elena Spini:** Tanto

**Fabrizio Paganelli:** faccio così. Questo lo posso eliminare.

**Aurel mrruku:** Sì, sì,

**Fabrizio Paganelli:** Quindi adesso vabbè è saltato,

**Aurel mrruku:** sì.

**Fabrizio Paganelli:** ma dice poco, insomma.

**Aurel mrruku:** Eh sì, ma metti devi mettere invece di devi mettere di no e

**Fabrizio Paganelli:** Ok.

**Aurel mrruku:** e nel Bravo.

**Fabrizio Paganelli:** Codice cliente. Questa qui non c'è bisogno che te la passo.

**Aurel mrruku:** Ce l'ho già, eh? Perché c'è codice mh sì,

**Fabrizio Paganelli:** Hai questo.

**Aurel mrruku:** codice cliente,

**Fabrizio Paganelli:** Quindi,

**Aurel mrruku:** però quindi vedi che l'ho messo là giusto per avere un'idea.

**Fabrizio Paganelli:** ok.

**Aurel mrruku:** Toglilo,

**Fabrizio Paganelli:** Codice di destinazione, anche qui non c'è bisogno.

**Aurel mrruku:** toglilo.

**Fabrizio Paganelli:** Codice agente, va bene.

**Aurel mrruku:** Sì, mi serve per forza.

**Fabrizio Paganelli:** Codice di pagamento. Qui ne avremo tanti altri,

**Aurel mrruku:** Eh,

**Fabrizio Paganelli:** ma io ti passo solo quelli che hai codificato su su SES Force.

**Aurel mrruku:** e quindi sì. quattro le quattro codifiche che abbiamo noi.

  
  

### **01:32:57**

  

**Aurel mrruku:** Poi se vuoi mettere una tipologia di ordine lo posso fare, altrimenti non metterlo.

**Fabrizio Paganelli:** Tipo ordine non ce l'abbiamo noi, purtroppo. Il tipo Ah,

**Aurel mrruku:** Ok.

**Fabrizio Paganelli:** intendi performance plus questa cosa qua o diventa

**Aurel mrruku:** Sì, sì, sì. Se se vuoi però e il e il plus l'hai detto che lo fai a

**Fabrizio Paganelli:** complicato?

**Aurel mrruku:** mano.

**Fabrizio Paganelli:** Eh sì, adesso finiamo qui, dopo ti dico i plus,

**Elena Spini:** Eh sì, non in realtà l'abbiamo lasciato.

**Aurel mrruku:** Ok,

**Fabrizio Paganelli:** eh.

**Elena Spini:** Ci manca la cosa del plus.

**Fabrizio Paganelli:** Qui io ti lascio ti lascio tutto standard,

**Aurel mrruku:** quindi togli Sì,

**Fabrizio Paganelli:** dai.

**Aurel mrruku:** sì. Ok.

**Fabrizio Paganelli:** Eh, ce ne freghiamo.

**Aurel mrruku:** Sì, sì, infatti abbiamo detto che anche i bundle palco eccetera.

**Elena Spini:** I bundle saranno standard.

**Aurel mrruku:** Sì.

**Fabrizio Paganelli:** Tutto standard. Tutto standard.

**Aurel mrruku:** Se mi vuoi mettere qualche nota, non so, qualcosa di particolare, lo puoi mettere là, altrimenti lasciamo stare.

**Fabrizio Paganelli:** Ok.

**Aurel mrruku:** Togli tutto.

**Fabrizio Paganelli:** Totale imponibile non ti serve.

  
  

### **01:33:52**

  

**Aurel mrruku:** E non mi serve perché verrà calcolato poi da dalle

**Fabrizio Paganelli:** Ok,

**Aurel mrruku:** linee.

**Fabrizio Paganelli:** è annullato. Sì, no, sì, ti serve.

**Aurel mrruku:** Mi serve, ma io direi metti tutti quelli che non sono annullati.

**Fabrizio Paganelli:** E Ah,

**Elena Spini:** E infatti,

**Aurel mrruku:** A cosa ti servono gli ordini annullati?

**Fabrizio Paganelli:** no, no, ma poi io non ce li avrò, insomma, di annullati.

**Aurel mrruku:** Ok.

**Elena Spini:** quindi via.

**Fabrizio Paganelli:** Vuoi che te lo lascio, Aurel? Lo tolgo.

**Aurel mrruku:** No, lascialo con N.

**Fabrizio Paganelli:** Ok,

**Aurel mrruku:** La stessa N vuol dire non annullato.

**Fabrizio Paganelli:** faccio così, eh.

**Elena Spini:** Ok.

**Fabrizio Paganelli:** tutto n posto. Ok, qui ci siamo. Poi vado di qua e sono le righe ordine, quindi a parità di chiave mi vien da dire qui avrò la data, quindi 2025 0315. Qui c'è ci sarà la riga. Eh, io la riga su Mexalo ho questa, non ho questa. Ho più un numero così. Mi sentite?

**Elena Spini:** Sì,

**Aurel mrruku:** Sì.

**Fabrizio Paganelli:** Ah,

**Elena Spini:** sì.

  
  

### **01:35:15**

  

**Fabrizio Paganelli:** ok. Questi qui, Aurel, sono numeri effettivi che tu hai preso o numeri?

**Aurel mrruku:** Li ho presi eh da come si

**Fabrizio Paganelli:** Ok,

**Aurel mrruku:** chiama? Da Maxile. Metti quello che vuoi. Sarà 1 2 3. Non so cosa avrai te. E cioè no boh quello che hai. Non mi interessa che sia un identificativo che io metto metterò su salesce.

**Fabrizio Paganelli:** ok, faccio così perché io adesso ho familiarità con un numero. Io almeno Allora, scusate,

**Aurel mrruku:** Quindi

**Fabrizio Paganelli:** ma c'ho il filo delle cuffie che mi sta dando fastidio sulla tastiera. Ok, questo lo tolgo. Ok,

**Aurel mrruku:** sì. Ok. No. Sì, o uno o l'altro. Quindi per me è uguale.

**Fabrizio Paganelli:** ok.

**Aurel mrruku:** Solo che se su Maxal c'è un altro ID diverso da quello che c'è su Sales force devo usare lo stesso da tutte e due le parti, ma siccome Maxal che mi sta dando gli ordini, quindi devo prendere quello di Maxal.

**Fabrizio Paganelli:** Ok.

**Aurel mrruku:** Eh, codice articolo, metti eh tipo riga la puoi

  
  

### **01:36:23**

  

**Fabrizio Paganelli:** quello che è tip lo posso togliere.

**Aurel mrruku:** togliere in teoria sì, perché se mi dai codice articolo, tutto il legame col prodotto lo faccio tramite codice articoli. Anche descrizione articoli lo puoi togliere. Unità di misura abbiamo solo numero, quindi lascialo così com'è. Il prezzo di listino è molto importante per me perché qua io mi aspetto che tutti i prodotti che mi dai saranno già, quindi lo puoi togliere perché lo prenderai in automatico dal dall'articolo, capito?

**Fabrizio Paganelli:** Mh. Ok. Allora, anche l'unità di misura a sto punto.

**Aurel mrruku:** Sì, uguale. Invece sconto, se ci sono degli sconti me li devi passare.

**Fabrizio Paganelli:** Mhm.

**Aurel mrruku:** Anzi, ti dico già, se tu mi passi il prezzo neto che verrà calcolato lo sconto in modo automatico, siamo a posto.

**Fabrizio Paganelli:** Ti posso solo prezzetto che è meglio.

**Aurel mrruku:** Passami sul prezzo netto, siamo a posto. Beh, che prezzo del listino ce l'ha dal prodotto,

**Fabrizio Paganelli:** Sì, ti passo solo prezzonetto, è meglio. M.

**Aurel mrruku:** quindi anche totale riga lo devi cancellare perché lo fai in automatico.

  
  

### **01:37:53**

  

**Aurel mrruku:** Codice IVA, toglilo, per me non ha nessuna importanza. data di scadenza, molto importante. Sì, la fattura lo prenderà in automatico, quindi

**Elena Spini:** Eh, sulla data di scadenza è corretto il formato? Sì, è quello di salesce,

**Aurel mrruku:** sì,

**Elena Spini:** scuso non ti era col trattino,

**Aurel mrruku:** quello è anno quello di salesce, quindi se me lo passi Sì,

**Elena Spini:** non mi ricordo più. Ok,

**Aurel mrruku:** così è sempre su Sales Force.

**Elena Spini:** perfetto.

**Fabrizio Paganelli:** Io qui come data di scadenza ti potrei mettere anche una data fittizia, secondo me,

**Aurel mrruku:** Non ho capito.

**Fabrizio Paganelli:** perché Sì,

**Elena Spini:** Sulle trance, eh.

**Fabrizio Paganelli:** sì, lo so, però tutti questi ordini qui io te li ho già fatturati tutti. Io li ho già fatturati tutti questi, capito? a noi la data di scadenza dell'oro. ordine ci serve per capire quando il cliente ci dovrà pagare, di conseguenza noi facciamo la fattura affinché il cliente ci paghi in quella data. Però sugli ordini storici io ti posso mettere anche una data fittizia. Non so se è giusto quello che sto dicendo.

  
  

### **01:39:25**

  

**Aurel mrruku:** Non ho capito.

**Fabrizio Paganelli:** Io se cioè la data di scadenza nel nel nella riga dell'ordine noi la mettiamo affinché l'amministrazione abbia dal commerciale l'informazione di quando il cliente dovrà pagare quella riga.

**Aurel mrruku:** Allora,

**Fabrizio Paganelli:** vista quella. Eh

**Aurel mrruku:** io ti dico ti dico che non chiamalo data tranch, chiamalo come vuoi. È la data che io devo capire per creare le tranche,

**Fabrizio Paganelli:** sì.

**Aurel mrruku:** per mettere insieme alla stessa fattura diverse righe d'ordine. Chiaro? Adesso

**Elena Spini:** Cioè che magari per i vecchi sì, ha senso mettere una fittizia se per te poi va bene vedere una data fittizia.

**Aurel mrruku:** metti la stessa su tutto l'ordine o guarda,

**Elena Spini:** Esatto. Ma poi ci sono

**Aurel mrruku:** tu puoi anche non mettere tu non puoi puoi anche non mettere una data scadenza io non ti genero delle tranch. Ti è chiaro?

**Fabrizio Paganelli:** Sì, sì, ma secondo me qui si possono anche non generare le tranche,

**Aurel mrruku:** Ma a sto

**Fabrizio Paganelli:** tanto son tutte fat S.

**Elena Spini:** però attenzione che cioè per invece gli ordini che non sono completamente fatturati, cioè quelli che arriveranno arriveranno più che altro quelli più vicini alla data dell'ultimo import.

  
  

### **01:40:46**

  

**Elena Spini:** Attenzione per quelli.

**Fabrizio Paganelli:** Perché effettivamente dopo Sì,

**Elena Spini:** Non so se mi sono spiegata.

**Fabrizio Paganelli:** sì, sì, sì. Perché poi dopo che cosa succederà? Adesso noi facciamo il test su ordini che sono già stati fatturati, poi quando ci avvicineremo al al giorno in cui questo lavoro dovrà essere fatto in produzione, magari avremo degli ordini che io mi sono portato su Mexal e che dobbiamo ancora fatturare,

**Elena Spini:** Esatto.

**Fabrizio Paganelli:** quindi la data della tranche a a che poi è è la data scadenza riga dell'ordine. Aspetta che me lo segno qui. scadenza, ordine.

**Elena Spini:** Riga ordine.

**Fabrizio Paganelli:** Sì. Liga ordine che poi è questo campo qua

**Aurel mrruku:** Ok.

**Fabrizio Paganelli:** che voi è questo campo qui. Vedete? Io questo qui oggi come oggi ce l'abbiamo tutto vuoto, ce l'abbiamo vuoto,

**Aurel mrruku:** Ok.

**Fabrizio Paganelli:** quindi però quando ci avvicineremo che dovremo in qualche modo importare sul sesso anche gli ordini che sono in sospeso più zo e che dovremmo fatturare a partire Да. Force. Eh, quella data lì dovrà essere in qualche modo popolata.

  
  

### **01:42:12**

  

**Fabrizio Paganelli:** Mi devo ricordare. Allora, importante per ordini e non fatturati. ordini zo non fatturati zo non fatturati e che verranno importati in Ok, questi qua ti servono, Aurel, a sto punto

**Aurel mrruku:** Allora, no sì, le fatture perché lo prenderà dallo scadenziario se mi passi la chiave in quel modo sulla fattura Io sono a posto.

**Fabrizio Paganelli:** m in base a questa.

**Aurel mrruku:** Sì,

**Fabrizio Paganelli:** Ma dopo questa qui tu la vai a prendere dalle dalle tue api,

**Aurel mrruku:** sì,

**Fabrizio Paganelli:** giusto? Ok.

**Aurel mrruku:** quello che faccio io poi fare un run completo dei ultimi 3 anni,

**Fabrizio Paganelli:** Ok,

**Aurel mrruku:** anno per anno ovviamente e andrò dopo l'inserimento degli ordini, quindi quando mi passi l'Excel farò un inserimento su salesce, farò un run in berchà parecchio tempo, mi aspetto 3-4 ore che aggiornerà tutti ordini con la creazione della fattura scadenzare fattura in salesce.

**Fabrizio Paganelli:** guarda, giusto per darti un'idea di quello, di quale potrebbe essere la dimensione della del lavoro. Io qui cancello. Chiudi. E beh. Ah, ecco, poi è andato via il filtro.

  
  

### **01:43:52**

  

**Fabrizio Paganelli:** Perfetto. Se io qui prendo data documento e dopo il 31 ipotizziamo di partire dal 24 e scusami da dal da dal da gennaio

**Aurel mrruku:** Ah, vent. 23.

**Fabrizio Paganelli:** da gennaio 24 faccio e dopo 31 12 23 applica. Quante righe vengono fuori? 30.000 righe, non so, 30.000 righe articolo. Eh, dopo, chiaramente il numero degli ordini è inferiore.

**Aurel mrruku:** Sì, sì, sì, è chiaro. Ah.

**Fabrizio Paganelli:** Se io qui faccio così sono molte meno. Eh, no, ho sbagliato qualcosa, scusate. E dopo il 31/12. Ecco. Questo qui sono 9,

**Aurel mrruku:** Ah, 9.000.

**Fabrizio Paganelli:** vedi? Poi fa conto che quei 9004 e quindi vuol dire che nel 24 io ho fatturato 21.000 righe articolo,

**Aurel mrruku:** Sì, chiaro, chiaro.

**Fabrizio Paganelli:** no? Eh, però di quelle 21 mig riga articolo ce ne sono una marea legate alla vendita della piattaforma. Se io vi passo anche i dati del 24, chiaramente le righe articolo delle fatture che abbiamo fatto e che sono inerenti alla piattaforma io ve le tolgo,

  
  

### **01:45:37**

  

**Aurel mrruku:** Sì,

**Fabrizio Paganelli:** metto solo No,

**Aurel mrruku:** ma sei sicuro che ce li hai tutti i prodotti che non hai cancellato qualche prodotto?

**Fabrizio Paganelli:** no, i prodotti ci sono tutti.

**Aurel mrruku:** Ok.

**Fabrizio Paganelli:** I prodotti ci sono tutti. Magari posso averlo annullato qualche prodotto,

**Aurel mrruku:** Ah, ti prendo tutti i prodotti a sto punto che io devo Ok.

**Fabrizio Paganelli:** però però l'eliminazione dei codici articolo non l'ho fatta, questo è sicuro, insomma, proprio l'eliminazione pura. Al massimo ci potrebbe essere un articolo annullato, però vedi, sono circa to una quindicina di migliaia di righe articolo,

**Aurel mrruku:** Ok,

**Fabrizio Paganelli:** secondo me, come dimensionalità. Non so dopo Aurelse questo può impattare il livello di tempistiche eccetera eccetera, però siamo su questa Sì,

**Aurel mrruku:** ma passaci tutto, ti dico dove c'ho i più grandi,

**Fabrizio Paganelli:** direi di sì.

**Aurel mrruku:** se ho errori dove dove mi mi cosa mi dà più fastidio, diciamo, e se capiamo che gli ordini vecchi hanno delle problematiche sulla grafica eccetera perché devono Dobbiamo avere anche i clienti. Spero che non avete cancellato tutti i clienti.

**Fabrizio Paganelli:** No, no, i clienti non li abbiamo cancellati.

  
  

### **01:46:49**

  

**Fabrizio Paganelli:** Anche quelli lì sono annullati,

**Aurel mrruku:** Ok,

**Fabrizio Paganelli:** capito?

**Aurel mrruku:** ok,

**Fabrizio Paganelli:** Al massimo non sono visibili, ma non sono visibili perché sono annullate proprio eliminazioni non le abbiamo fatte.

**Aurel mrruku:** ok. Capiamo poi, eh. Quando mi prepari i

**Fabrizio Paganelli:** Ah, io inizio a lavorarci subito.

**Aurel mrruku:** Ok.

**Elena Spini:** Oh.

**Fabrizio Paganelli:** Quindi questi qui non ti servono.

**Aurel mrruku:** No, non mi servono. Non mi servono perché poi se mi serviranno penso che aggiunge tre quattro

**Fabrizio Paganelli:** Va bene.

**Aurel mrruku:** campi in più non è un problema da parte.

**Fabrizio Paganelli:** No, no, no, no.

**Aurel mrruku:** Ok.

**Fabrizio Paganelli:** Di qua devo leggere qualche cosa. No,

**Aurel mrruku:** No, era quello tutto quello che hai abbiamo fatto adesso l'avevo anche scritto qua.

**Fabrizio Paganelli:** ok, quindi diciamo che io mi concentro su questi due fogli. Aspetta che mi salvo con nome sto questo file. Bene, Performance Plus io avevo una proposta da farvi.

**Aurel mrruku:** Sì.

**Fabrizio Paganelli:** Ci siete?

**Elena Spini:** Vai, concludiamo con una bella notizia. Vai.

**Fabrizio Paganelli:** Il contratto non lo posso inserire io mano?

  
  

### **01:47:59**

  

**Fabrizio Paganelli:** M. Perché?

**Aurel mrruku:** Sì,

**Fabrizio Paganelli:** Allora, vi spiego questo.

**Aurel mrruku:** che lo puoi fare.

**Fabrizio Paganelli:** Vi spiego questo.

**Elena Spini:** Questa è una bella notizia.

**Fabrizio Paganelli:** Mentre mentre quest'anno, per come abbiamo impostato le cose su Sales Force, io ho un ordine unico da €20.000 diviso in in 12 tranche e quell'ordine unico è agganciato ad un unico contratto.

**Aurel mrruku:** Ok, fai così. Vai un attimo su Sales Force.

**Elena Spini:** Ok.

**Fabrizio Paganelli:** Sì.

**Aurel mrruku:** Vai su un ordine.

**Fabrizio Paganelli:** Devo fare nuovo.

**Aurel mrruku:** Uno in Sì, ma clicca su un ordine,

**Fabrizio Paganelli:** Ah,

**Aurel mrruku:** giusto per farti vedere. Clicca, premi là, apri come Non è colpa mia,

**Fabrizio Paganelli:** ancora non mi hai messo a posto quel click lì, eh.

**Aurel mrruku:** eh. Allora, vai sui contratti a destra. Ok, non hai la possibilità, non hai permesso. Eh, c'hai una penna destra in alto a destra. Premila. Aggiungi altre voci. Altre voci. Fai tutti e scrivi contrato. Contratti. Fai più. Sì, fai aggiungi voce di navigazione.

  
  

### **01:49:37**

  

**Aurel mrruku:** Fai salva. Adesso vedi in alto a destra è apparsa un un tab in più.

**Fabrizio Paganelli:** Questi qua.

**Aurel mrruku:** Più a più in alto,

**Elena Spini:** Sopra, sopra.

**Aurel mrruku:** più in alto a destra sotto contratti

**Fabrizio Paganelli:** Ah, ok.

**Aurel mrruku:** premio sui contratti fai new nuovo e qua metti ordine. Ovviamente poi eh mo forse è meglio che ti abilito direttamente dall'ordine un nuovo contratto solo per te.

**Fabrizio Paganelli:** M.

**Aurel mrruku:** E qua praticamente puoi creare il contratto,

**Fabrizio Paganelli:** Угу.

**Aurel mrruku:** quindi eh non so, fai ordine performance plus, mi sa che si chiamava per con la P. Scrivi performance Plus,

**Fabrizio Paganelli:** Ok.

**Aurel mrruku:** vedi che c'hai gli ordini là, c'è ID degli ordini. Poi tipo di contratto, premi su tipo di contratto nuovo e poi fai stato contratto creato, lo metti in creato all'inizio, poi è data di attivazione, poi farete tutto. Quindi, però questa e poi metter anche l'account sotto, l'account nome account quello là e fai e questo praticamente il giro per fare il contratto. Però forse ti faccio meglio un ti apro direttamente sull'ordine, così ti prende in automatico l'ordine.

  
  

### **01:51:17**

  

**Fabrizio Paganelli:** No, è perché la questione è questa, è che mentre adesso in futuro, grazie a SESF, faremo un unico ordine con N tranche e a fronte di un unico ordine ci sarà un unico contratto oggi come oggi noi abbiamo a fronte di un unico contratto abbiamo più ordini,

**Aurel mrruku:** Ok,

**Fabrizio Paganelli:** quindi

**Aurel mrruku:** quindi sarà più facile gestire un unico contratto per un unico ordine.

**Fabrizio Paganelli:** sì.

**Aurel mrruku:** dice di creare direttamente là.

**Fabrizio Paganelli:** Eh,

**Aurel mrruku:** Ok.

**Fabrizio Paganelli:** quindi dopo io qui posso eventualmente posso creare a mano il contratto e associargli tutti gli ordini.

**Aurel mrruku:** Però non funziona così.

**Fabrizio Paganelli:** No, no, ma io lo dico solo per il vecchio, solo per il recupero di dati storici.

**Aurel mrruku:** Sì, lo puoi fare, però non è corretto, capito?

**Fabrizio Paganelli:** No, no,

**Aurel mrruku:** Lo puoi fare perché come hai associato quell'ordine ni non lo puoi fare.

**Elena Spini:** Eh,

**Fabrizio Paganelli:** eh era era per capire,

**Elena Spini:** perché tu devi partire dall'ordine, dovresti partire dall'ultimo ordine e associare il contratto e creare un

**Aurel mrruku:** E però poi il il valore del contratto,

  
  

### **01:52:17**

  

**Elena Spini:** contratto. Ah,

**Fabrizio Paganelli:** eh.

**Elena Spini:** già.

**Aurel mrruku:** tutta la logica sullo scadenziario va a aggiornare quando il contratto Vabbè. No, devi duplicare ne volte il contratto però.

**Fabrizio Paganelli:** Ognuno di con la validità di un mese che doni,

**Aurel mrruku:** Sì.

**Fabrizio Paganelli:** non si può neanche inserire proprio un ordine, un scusate un un contratto così in modo balordo e metterlo in uno stato che si chiama contratti vecchi e mettere i dati inizio data fine. No, eh ci deve essere

**Aurel mrruku:** Il legame che abbiamo fatto uno ad uno con l'ordin M.

**Fabrizio Paganelli:** eh vabbè. Amen. In questo qui faremo in un altro modo, dai. Tanto hanno i ragazzi che lavorano, i ragazzi del reparto di Performance Plus, hanno una loro piattaforma su cui lavorano, quindi vedremo di fare in un altro modo.

**Aurel mrruku:** Allora, ok.

**Elena Spini:** E e questi qua, scusa, questi ordini di Performance Plus, giusto per chiudere, comunque li passerai tra con l'Excel di Ordini standard o

**Fabrizio Paganelli:** Sì,

**Aurel mrruku:** No.

**Elena Spini:** no?

**Fabrizio Paganelli:** sì, sì, vi passo anche la performance Plus. No, non lo volete.

  
  

### **01:53:48**

  

**Fabrizio Paganelli:** Так.

**Aurel mrruku:** Ma no, ma verrà pensato con un ordine normale, non avrai più Allora No.

**Elena Spini:** Ecco

**Fabrizio Paganelli:** M.

**Aurel mrruku:** Non avrai una distinzione poi. Vabbè, fai te. Non è che mi interessa, dico la verità. per me gestire un ort 10 or

**Elena Spini:** Proprio alta che poi dopo esce, cioè c'è quell'order type standard,

**Fabrizio Paganelli:** No, più più che più che altro Aurel non vorrei

**Elena Spini:** cioè non vorrei che si crei confusione.

**Fabrizio Paganelli:** che vada in errore alla procedura perché poi dopo va quell'ordine deve andare a creare il contratto, il contratto non c'è perché per me è utile che i tutor vedano quanto quel cliente ha comprato di performance plus.

**Aurel mrruku:** No, ma non crea il contratto.

**Fabrizio Paganelli:** Poi se non creiamo il contratto pazienza.

**Aurel mrruku:** Se allora io farò in modo che quando si genera l'ordine non devi fare gli automatismi che ci sono adesso, capito?

**Fabrizio Paganelli:** Ok.

**Aurel mrruku:** Quindi io devo bypassare tutte le logiche che abbiamo fino adesso. Per questo dico che mi serve del tempo per fare delle condizioni sul codice solo

  
  

### **01:54:51**

  

**Fabrizio Paganelli:** Ok,

**Aurel mrruku:** in nintegrazione.

**Elena Spini:** in occasione della migrazione.

**Fabrizio Paganelli:** va bene. Se possiamo caricarli anche le righe, le righe fattura, le righe ordine che sono di performance class senza che poi dopo si generi il contratto, va bene, dai.

**Aurel mrruku:** Ok, va bene.

**Fabrizio Paganelli:** L'importante è che ci sia l'informazione sull'account che quel cliente poi dopo quando il tutor andrà sull'account e e e qui vedrà tutte le sue fatture, vedrà che cosa in qualche modo vedrà anche i tipi di prodotto che ha che ha che ha acquistato quel cliente, insomma.

**Aurel mrruku:** Kap.

**Fabrizio Paganelli:** Eh, ad esempio, qui una cosa, ma qui parliamo di fase, non so se due, ma forse anche tre. Quando il tutor va qui, non sarebbe male avere una una Adesso la dico così, la butto lì perché mi viene in mente, eh, vi ricordate quei famosi livelli 1 2 3 che avevo? Quellì sono classificatori statistici dei prodotti che magari qui il tutor si vede che tipo di acquisti ha fatto il cliente, non so se oppure magari ci sarà una reportistica di sales force dedicata, insomma.

  
  

### **01:56:12**

  

**Aurel mrruku:** Ma tieni traccia Elena,

**Elena Spini:** capiremo.

**Aurel mrruku:** poi

**Elena Spini:** Sì, sì,

**Fabrizio Paganelli:** Eh sì,

**Elena Spini:** infatti.

**Fabrizio Paganelli:** sì. Tipo questo qui ha gli abbiamo fatturato €55.000. Vabbè, questa fattura però di che cosa? Capito? Quindi corsi, non corsi, Academy, non Academy, Performance Plus, eccetera eccetera eccetera.

**Aurel mrruku:** te dici di far capire anche il prodotto sulla fattura,

**Fabrizio Paganelli:** Esatto.

**Aurel mrruku:** però o l'insieme dei prodotti si deve customizzare poi quella vista.

**Fabrizio Paganelli:** Esatto.

**Aurel mrruku:** Perché qua standard.

**Fabrizio Paganelli:** Eh o eh oppure se tanto esisterà una reportistica, immagino, no? Dopo che svilupperemo in una fase futura.

**Aurel mrruku:** Sì, ci sono alcune cose standard, ma dalla poi ne parliamo quando arriva.

**Fabrizio Paganelli:** Sì, ne parleremo,

**Elena Spini:** Sì,

**Fabrizio Paganelli:** dai. Va bene,

**Elena Spini:** esatto.

**Fabrizio Paganelli:** va bene. Posto.

**Aurel mrruku:** Ok, grazie.

**Fabrizio Paganelli:** Allora,

**Aurel mrruku:** Fammi sapere per cortesia,

**Fabrizio Paganelli:** abbiam trovato la soluzione più o meno,

**Aurel mrruku:** non lo sappiamo ancora.

**Fabrizio Paganelli:** giusto? Ah,

**Aurel mrruku:** Abbiamo parlato di una soluzione.

**Fabrizio Paganelli:** sempre pessimista.

**Aurel mrruku:** Sei un mal di testa.

**Fabrizio Paganelli:** Ecco,

**Aurel mrruku:** Capiamo.

**Fabrizio Paganelli:** va bene,

**Aurel mrruku:** Appena mi dai il file faccio dei test.

**Fabrizio Paganelli:** va bene.

**Aurel mrruku:** Grazie Fabrizio.

**Elena Spini:** Va bene,

**Fabrizio Paganelli:** Grazie a voi.

**Aurel mrruku:** Ciao.

**Elena Spini:** aggiornaci. Grazie.

**Fabrizio Paganelli:** Ciao ciao ciao ciao.

  
  

### **Trascrizione terminata dopo 01:57:34**

  

*Questa trascrizione modificabile è stata generata dal computer e potrebbe contenere errori. È possibile anche modificare manualmente il testo dopo la creaz