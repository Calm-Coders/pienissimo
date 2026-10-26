# [ROMI-PIENISSIMO] - Check Excel Migrazione - 2026/10/22 15:00 CEST - Trascrizione

Fonte: Google Doc `1L2z6cxW5yt54UmhUa3J6lNxf5ghz1u9NM-634X2APSA`
(_"[ROMI-PIENISSIMO] - Check Excel Migrazione - 2026/10/22 15:00 CEST - Appunti
di Gemini"_), proprietario Elena Spini, condiviso 2026-10-22T13:50:37Z.
Trascrizione conservata verbatim. **Non modificare.**

Invitati: amministrazione@pienissimo.com, fabrizio.p@pienissimo.com,
Elena Spini, Aurel mrruku.

---

### **00:01:16**

**Fabrizio Paganelli:** Ciao Aurel, mi senti? Aspetta che sono io che non ti sento. Io non ti sento. Te mi senti?

**Aurel mrruku:** Adesso 1 2 Ciao

**Fabrizio Paganelli:** Ok. Ok,

**Elena Spini:** Ciao,

**Fabrizio Paganelli:** a posto. Ciao.

**Elena Spini:** come va?

**Fabrizio Paganelli:** Allora, io sono andato un pochino avanti,

**Elena Spini:** Ottimo. No.

**Fabrizio Paganelli:** però ho un po' di cose di cui mi volevo confrontare con voi. Allora, io ho estrapolato i dati degli ordini, ho fatto una prova dal primo di gennaio del 2024, era quella famosa numerica che vi dicevo ieri da

**Aurel mrruku:** Sì. 9.000. Sì.

**Fabrizio Paganelli:** 30.000.

**Aurel mrruku:** M

**Fabrizio Paganelli:** Ehm sì, 9.000 era da gennaio 25.

**Aurel mrruku:** Ah, ok, ok, ok, va bene. M.

**Fabrizio Paganelli:** Ehm, allora vi faccio vedere. Guarda, dopo mi sono fatto questo file qua che diciamo è già il risultato finale, così vi faccio le domande su questo. Ce la faccio ad aprirlo?

**Aurel mrruku:** Puoi condividere pure. Eh

**Fabrizio Paganelli:** Sì. Allora Ра. Dovreste vedere, giusto?

### **00:03:07**

**Aurel mrruku:** sì. Ok,

**Fabrizio Paganelli:** Allora, qui ci sono i campi che è un po' lento perché come erano stati, diciamo, individuati al di là di qui che quando poi dopo faccio il copia incolla su Excel, vedi, compaiono questi punti qua, però dopo questi sono cose che vado a sistemare, insomma, non è un problema.

**Aurel mrruku:** ma se vuoi li sistemo anch'io, non è un problema.

**Fabrizio Paganelli:** No, no, ma dai. E allora io quello che ho fatto ho detto voglio fare la prova sul 24. Cosa succede? che ci sono alcune righe ordine. Adesso questo qui è il tracciato delle righe delle righe ordine.

**Aurel mrruku:** Sì, sì.

**Fabrizio Paganelli:** Ci sono alcune righe ordine, quindi anche alcune testata ordine dove vedete non c'è qui valorizzato il il tipo documento, la sigla del documento. Vedi? sigla è nullo, serie è a zero, numero documento è nullo,

**Aurel mrruku:** Eh, aspetta, aspetta,

**Fabrizio Paganelli:** non c'è la data.

**Aurel mrruku:** aspetta. Eh, a me interessa non non mi interessa il livello di riga.

**Fabrizio Paganelli:** Ok.

**Aurel mrruku:** La riga deve avere solo l'identificativo del dell'ordine.

### **00:04:26**

**Aurel mrruku:** Ne.

**Fabrizio Paganelli:** Però quello che cercavo di dire è questo. Siccome qui ci sono diverse righe che sono dove questi primi quattro sono tutti uguali, vedi?

**Elena Spini:** che doveva essere la chiave questa.

**Fabrizio Paganelli:** In questo caso qui. Esatto. Però quello che vi volevo chiedere è nella chiave oltre a queste quattro c'è anche il codice cliente perché

**Aurel mrruku:** No, perché il codice cliente è a livello di ordine, ti sto dicendo se Allora, anche qua tu a te non serviranno tutte e quattro le righe, ti basta solo la chiave dell'ordine. Vabbè, se poi fai le quattro colonne, poi fai una formula, va bene uguale,

**Elena Spini:** Eh, ma lui sta dicendo che sigla E questi qua,

**Aurel mrruku:** ma mancano

**Elena Spini:** cioè, sono sigla,

**Aurel mrruku:** proprio.

**Elena Spini:** eh, sigla vuoto.

**Fabrizio Paganelli:** Sì.

**Elena Spini:** Questi doc e numero stanno a zero, quindi Sì.

**Aurel mrruku:** Com'è possibile?

**Fabrizio Paganelli:** in questo. Allora, è possibile perché perché quando ci arrivano gli ordini su alcuni codici articolo, vedete qui la maggior parte è questo codice articolo LI eccetera eccetera,

**Elena Spini:** Ja.

### **00:05:36**

**Aurel mrruku:** Sì.

**Fabrizio Paganelli:** no? ci arriva l'ordine direttamente su Maxal e noi lo fatturiamo. E quindi m non si genera un ordine OC eccetera eccetera. Però io quello che vi volevo chiedere, provo a a completare il ragionamento è questo qui. Ho fatto un lavoro di questo tipo dove mi sono messo qua per capire se la chiave era sostenibile tutto qui mi sono messo qua un campo flag, chiamiamolo così, dove mi fa il concatena di queste quattro qui. 1 2 3 4 e poi gli ho aggiunto anche il cliente.

**Aurel mrruku:** Non mi serve il cliente, sto dicendo. Да.

**Elena Spini:** Eh,

**Fabrizio Paganelli:** Eh,

**Elena Spini:** però per quelle

**Fabrizio Paganelli:** ma io è proprio quello che ti sto dicendo. Se noi non consideriamo anche il cliente nella chiave, abbiamo degli ordini su clienti diversi dove tu hai la chiave duplicata. Capito cosa voglio dire? Se io faccio così, se io faccio così la chiave,

**Elena Spini:** Qu?

**Fabrizio Paganelli:** questa chiave qui ce l'ho duplicata su clienti diversi. Ho la stessa chiave su clienti diversi.

### **00:06:59**

**Aurel mrruku:** Ma non tecnicamente è impossibile avere una

**Fabrizio Paganelli:** Oddio,

**Aurel mrruku:** chiave uguale.

**Fabrizio Paganelli:** io ho capito che tecnicamente è impossibile aver la chiave uguale. Eh, eh, lo so. che è tecnicamente impossibile avere la chiave uguale. Però negli archivi, in questi casi qui, siccome abbiamo delle fatture che non passano da ordine, abbiamo il campo, quei campi, questi campi qua che fanno riferimento all'ordine sono vuoti perché abbiamo fatto delle fatture senza ordine. Allora, quello che chiedevo io,

**Elena Spini:** M.

**Fabrizio Paganelli:** quando tu fai l'elaborazione come diciamo campi che determinano la chiave, oltre alla combinazione di questi quattro qui, ossia sigla, serie, numero e data, come campi chiave utilizzi anche il codice cliente quando leghi testate,

**Aurel mrruku:** No,

**Fabrizio Paganelli:** righe,

**Aurel mrruku:** m No,

**Fabrizio Paganelli:** ordine?

**Aurel mrruku:** no, no, perché io non ho non faccio legame con il cliente. Il cliente viene preso direttamente praticamente quando tu colleghi l'ordine col cliente, non quando prendi la fattura di quell'ordine. La fattura è di quell'ordine, anzi la fattura è di un pezzo di quell'ordine e che tu puoi avere diverse fatture sullo stesso ordine per gli stessi clienti.

### **00:08:27**

**Fabrizio Paganelli:** No,

**Elena Spini:** Ma di quanto tempo fa sono questi ordini?

**Aurel mrruku:** Sì.

**Fabrizio Paganelli:** Allora, scusate, eh scusate, noi oggi fino ad oggi, quindi fino al momento in cui faremo l'importazione di questo storico, se ce la facciamo a farlo, ehm ad ogni un ad un ordine corrisponde una sola fattura.

**Aurel mrruku:** Sì,

**Fabrizio Paganelli:** ad un ordine corrisponde

**Aurel mrruku:** ma com'è la struttura adesso in Sales Force? con quello che abbiamo. abbiamo sviluppato, abbiamo fatto in modo che un una fattura, diverse fatture possono essere collegato allo stesso ordine per lo stesso cliente.

**Fabrizio Paganelli:** Questo questo è corretto da quando Salesfall sarà

**Aurel mrruku:** Sì, ma c'è c'è già così.

**Fabrizio Paganelli:** live.

**Aurel mrruku:** Questo ti sto dicendo è già implementata così.

**Fabrizio Paganelli:** Ok,

**Aurel mrruku:** È una cosa strutturale che non posso cambiare. Non è una cosa che si fa con uno script.

**Fabrizio Paganelli:** quindi come faccio io a tirarti fuori sti dati? Devo eliminare

**Aurel mrruku:** Ma poi questi non sono manche ordini. Questo mi mi il dubbio mio è noi stiamo parlando di migrazione degli ordini, ma questi non sono ordini.

### **00:09:41**

**Fabrizio Paganelli:** Chi l'ha detto che non sono ordini?

**Aurel mrruku:** Se sono ordini c'hanno un codice ordine per forza.

**Fabrizio Paganelli:** Ma scusa,

**Aurel mrruku:** Qualcuno che salva in DB quello

**Fabrizio Paganelli:** scusa Aurel, scusa. Eh, questo qui è la sigla dell'ordine o C?

**Aurel mrruku:** sì, quello che non ha noci. Queste sono righe d'ordine, vero?

**Fabrizio Paganelli:** Sì. E se io ecco,

**Aurel mrruku:** Quel

**Fabrizio Paganelli:** allora quello che ti voglio chiedere è se io ce lo metto io C qui ce lo metto io.

**Aurel mrruku:** però mi devi mettere sia OC che numero che serie

**Fabrizio Paganelli:** Perfetto, te la metto,

**Aurel mrruku:** e deve essere unico per quell'anno.

**Fabrizio Paganelli:** te lo metto.

**Aurel mrruku:** Allora, siamo a posto perché no

**Fabrizio Paganelli:** Va bene, me lo invento io. Tanto qui non c'è bisogno.

**Aurel mrruku:** no,

**Fabrizio Paganelli:** Eh, no.

**Aurel mrruku:** no. deve essere sul database perché poi quando arriverà la fattura per collegarsi a quell'ordine deve coincidere.

**Fabrizio Paganelli:** Questi qui le fatture sono già state emesse. Questi qui sono ordini storici. Su questi ordini qui le fatture sono già state emesse.

### **00:10:42**

**Aurel mrruku:** Ma ieri hai detto che volevi tutti il legame anche sui ordini vecchi, ordini chiusi. Abbiamo detto così ieri, vero?

**Fabrizio Paganelli:** Ieri abbiamo detto che facciamo un'importazione per tutti gli ordini di cui abbiamo già emesso la fattura e un'importazione di degli ordini di cui non abbiamo ancora emesso la fattura. Ok,

**Aurel mrruku:** Sì.

**Fabrizio Paganelli:** perfetto. Allora, guarda gli ordini di cui inseriti in macchina, di cui oggi non abbiamo ancora emesso la fattura, sono cinque. Cinque sono.

**Aurel mrruku:** Ok.

**Fabrizio Paganelli:** Poi quando dovremmo fare la migrazione saranno di più,

**Elena Spini:** อ

**Aurel mrruku:** Ok.

**Fabrizio Paganelli:** però adesso vi ti faccio vedere questo qui. Questi qui sono gli ordini. Eh, facciamo così. Questi qua sono gli ordini. Questi qui sono gli ordini di cui non abbiamo ancora emesso la fattura. Sono questi qua, 1 2 3 4 5 6 7. Ne avremo di più. Questi qui saranno assolutamente tutti popolati in questo caso qui. E qui è giusto che io ti metta questa cosa qui perché la fattura ancora non l'abbiamo emessa.

### **00:11:55**

**Fabrizio Paganelli:** Quindi tu farà quando farai girare, quando poi dopo metteremo la fattura su SESF. Qui deve avere questi riferimenti qua compilati. In quest'altro caso invece questi qui, qui noi la fattura l'abbiamo già fatta. Vedi che qua ho lasciato per mia verifica questo campo? Qui noi la fattura su questi ordini l'abbiamo già emessa, quindi qui noi non dovremmo fare girare nulla se non quel ciclo della disponibilità dei biglietti andandoli a incrociare con il tipo di lo scadenziario.

**Aurel mrruku:** Sì, ma tu dici "Io ho fatto la fattura,

**Fabrizio Paganelli:** Ah!

**Aurel mrruku:** ma lo scadenziale lo devo ricevere e io devo avere per forza un aggiornamento su quell'ordine per lo scadenziario. Per avere quell'aggiornamento mi serve per forza l'identificativo di quell'ordine con quella quei quattro campi che abbiamo detto e quei quattro campi li definisce mexal, non li definisci te a mano.

**Fabrizio Paganelli:** Però il legame tra il legame tra con lo scadenziario non è fatto in base alla fattura, in base al numero dato.

**Aurel mrruku:** Ma la fattura c'ha l'ordine. La fattura ha un riferimento all'ordine e io vado sul sistema ad aggiornare le righe dell'ordine che stanno sulla fattura che stanno sul scadenziario.

### **00:13:13**

**Fabrizio Paganelli:** Bene, però nello scadenziario hai il riferimento della fattura, non del numero dell'ordine.

**Aurel mrruku:** Ma la fattura ha il riferimento del numero dell'ordine? Ti sto dicendo

**Fabrizio Paganelli:** Ah, ho capito, ho capito. Giusto, perché tu leggi prima lo scadenziario, vedi quali sono le fatture che sono state pagate o no e risali fatture e nelle fatture recuperi il numero dell'ordine e quindi aggiorni se è pagato o no in base al numero dell'ordine che c'è. Ho capito,

**Aurel mrruku:** anzi le righe del numero dell'ordine

**Fabrizio Paganelli:** ho capito. Sì, sì. Allora, io lo sai come la risolvo che queste righe qua non te le passo e ce ne

**Elena Spini:** Ah. Yeah.

**Fabrizio Paganelli:** freghiamo.

**Aurel mrruku:** Possiamo fare un'altra cosa sporchissima. La possiamo fare se vuoi ti creo solo gli ordini e quindi se vuoi uno storico di ordine, però non è un legame con la fattura.

**Fabrizio Paganelli:** Sì, sì,

**Aurel mrruku:** Questo questo sto cercando di dirti.

**Fabrizio Paganelli:** sì, sì, sì. Ma guarda, io questi qui stiamo parlando di vedi

**Aurel mrruku:** Eh,

**Fabrizio Paganelli:** che sono tutti importini piccoli da €27.

### **00:14:18**

**Fabrizio Paganelli:** Questo qui è il libro,

**Aurel mrruku:** il libro.

**Fabrizio Paganelli:** capito?

**Aurel mrruku:** Ok,

**Fabrizio Paganelli:** Che è una cagata. Cioè, scusate il termine. Dopo sì, abbiamo anche altre cose un pochino più

**Elena Spini:** Abbiamo odiato fin dall'inizio sto libro.

**Aurel mrruku:** aspetta, vediamo un po' la data perché sono curioso di sapere.

**Elena Spini:** Ma esatto. Io volevo sapere Esatto la di quanto tempo fa parliamo di sti ordini.

**Fabrizio Paganelli:** Questo qui è il 24. Dopo c'è anche qualcosa sul 25.

**Elena Spini:** A 25. Sì. No,

**Aurel mrruku:** Sì, sì.

**Elena Spini:** infatti 25.

**Fabrizio Paganelli:** sul 26 c'è praticamente nulla a parte il libro

**Aurel mrruku:** Ah, ok.

**Fabrizio Paganelli:** perché ho provato a fare, lo sapevo che nel 24 un po' di casini c'erano, eh, questo lo sapevo, eh,

**Aurel mrruku:** Ma come hanno fatto?

**Fabrizio Paganelli:** però

**Aurel mrruku:** Scusa, sono curioso perché anche se tu fai una fattura, quella fattura per forza lo devi collegare a un ordine, altrimenti non fatto direttamente la fattura senza

**Elena Spini:** Ma secondo me e il problema era che hanno forse no. Eh sì,

**Aurel mrruku:** l'ordine.

### **00:15:10**

**Fabrizio Paganelli:** esatto.

**Elena Spini:** ma è che Mexale forse è collegato solo al Wcommerce, quello dove ci sono Ah,

**Fabrizio Paganelli:** No, no, non c'entra niente.

**Elena Spini:** ok.

**Fabrizio Paganelli:** Non c'entra niente.

**Aurel mrruku:** No,

**Elena Spini:** No,

**Aurel mrruku:** penso che non hanno proprio fatto l'ordine.

**Fabrizio Paganelli:** Wcommerce c'entra che C'entra che Esatto.

**Aurel mrruku:** Hanno fatto la fattura e hanno mandato la fattura.

**Elena Spini:** eh no,

**Fabrizio Paganelli:** Esatto. Noi possiamo fare Noi possiamo fare

**Elena Spini:** pensavo che l'ordine non fosse sceso dal WCommerce corretto, per quello dicevo Wcommerce.

**Aurel mrruku:** Poi Fabrizio, io le fatture li prenderò a prescindere, quindi tu lo storico delle fatture l'avrai sempre, solo che quelle fatture non sono collegate ai ordini, questo è il problema. Mi capisci? Mi mi segui?

**Fabrizio Paganelli:** le fatture le prenderai comunque.

**Aurel mrruku:** Sì, perché io non prendo eh solo le fatture che sono collegate all'ordine, io prendo tutte le fatture all'inizio e tutti scadenziari. Quindi scadenziali e fattura sono sempre collegate tra di loro, anche se non c'è un ordine.

**Fabrizio Paganelli:** Mh. Tu prendi anche la riga fattura,

### **00:16:10**

**Aurel mrruku:** Sì, sì.

**Fabrizio Paganelli:** anche l'articolo che c'è nella fattura.

**Aurel mrruku:** Eh no, perché l'articolo sta sulla riga dell'ordine, però l'import c'è e lo stato.

**Fabrizio Paganelli:** No, ma io la risolvo che la risolvo che su queste righe, su questi record dove non è compilato questi quattro dove dove questi quattro campi qui non sono compilati,

**Aurel mrruku:** Ok,

**Fabrizio Paganelli:** io questi non te li passo così non abbiamo anomalie.

**Aurel mrruku:** ok, ok, perfetto.

**Fabrizio Paganelli:** Non abbiamo anomalie. Quindi questo è è la prima cosa,

**Aurel mrruku:** Ma già che ci sei,

**Fabrizio Paganelli:** poi sì.

**Aurel mrruku:** perché io ho fatto 3 ore fa ho fatto un aggiornamento di tutti di tutti i prodotti da produzione con tutti stati eccetera. Eh,

**Elena Spini:** c****.

**Aurel mrruku:** tu per mettere gli stati in scusa per mettere i prodotti sulla maporia i prodotti devono essere attivi praticamente. Io ti devo abilitare prima tutti i prodotti,

**Fabrizio Paganelli:** Va bene.

**Aurel mrruku:** poi tu gli devi mettere fare le edizioni e se vuoi ti faccio un campo sull'edizione lo chiamo old, quindi vecchio, edizione vecchia. E per non generare il link sulle edizioni vecchie, intendo, e devi fare questa mappatura.

### **00:17:26**

**Fabrizio Paganelli:** M adesso, adesso io faccio fatica a seguirti perché sto pensando a questo tracciato qui che ho ancora tante

**Aurel mrruku:** Ok,

**Fabrizio Paganelli:** altre domande,

**Aurel mrruku:** vai,

**Fabrizio Paganelli:** magari il discorso dei eh poi L'altra cosa

**Aurel mrruku:** procedi pure.

**Fabrizio Paganelli:** che volevo chiedere qua, noi ieri avevamo detto che la data della tranche, la data della tranche dove ho messo quel foglio

**Aurel mrruku:** Sì, c la data della trunch ci ci servirà praticamente per creare le trunch su sui ordini. Quindi se un se diverse righe di ordine hanno date diverse verranno create diverse trance.

**Fabrizio Paganelli:** Mh. E se io me la posso inventare questa data della tranche?

**Aurel mrruku:** Sì, basta che sia una data coerente, quindi non mettere date a caso 2030,

**Fabrizio Paganelli:** Ok. E qui,

**Aurel mrruku:** tipo.

**Fabrizio Paganelli:** è qui, è qui,

**Aurel mrruku:** Sì, ok,

**Fabrizio Paganelli:** guarda.

**Aurel mrruku:** ok, perfetto.

**Fabrizio Paganelli:** È questa qui che corrisponde praticamente alla data della fattura.

**Aurel mrruku:** Sì, sì.

**Fabrizio Paganelli:** Quindi questo a posto, questa è un'altra cosa. Poi niente. Poi l'altra cosa che ti volevo dire per il discorso della condizione di pagamento, questa qua, questo campo qua, io qui ho forzato tutto a 12, ossia che bonifico bonifico data fattura.

### **00:18:55**

**Fabrizio Paganelli:** Anche questo, secondo me, non ce ne frega poco su sullo storico.

**Aurel mrruku:** Non ci dà non ci dà problemi, basta che ci sia un valore.

**Fabrizio Paganelli:** Perfetto. Quindi questa è un'altra cosa. Ehm, idem, codice agente, posso fare? Vedi che in alcuni casi manca il codice gente.

**Aurel mrruku:** Sì, ovviamente usa un codice agente già esistente, non inventi codici agenti nuovi perché poi mi causa problemi a trovare l'utente che è un agente. Quindi usa un agente che esiste già.

**Fabrizio Paganelli:** Quindi ti metto il 610, non mi ricordo qual è il 4 o l'11 che è l'agente generico di segreteria e così siamo a posto. Poi, ecco l'altra cosa, noi qui oltre le fatture abbiamo chiaramente anche delle note di credito, vedi? Abbiamo delle note di credito. Che cosa faccio qui?

**Aurel mrruku:** Cosa sono Ti credo.

**Fabrizio Paganelli:** Eh, le note di credito è l'opposto della fattura, è uno storno di una vendita. Il cliente compra un corso e ci scrive che non può venire e vuole rinunciare al corso, noi gli facciamo una nota di credito.

### **00:20:16**

**Aurel mrruku:** Ok. Eh, quindi le avevamo pensato a fase 2,

**Elena Spini:** Fase due.

**Aurel mrruku:** 3, eccetera.

**Elena Spini:** Sì.

**Aurel mrruku:** Ok,

**Fabrizio Paganelli:** Esatto.

**Aurel mrruku:** allora mi escludi questi qua,

**Fabrizio Paganelli:** Esatto.

**Aurel mrruku:** li salviamo su un file Excel e li importiamo quando implementiamo note di credito.

**Fabrizio Paganelli:** Allora, note di credito escludo.

**Aurel mrruku:** salva da qualche parte, altrimenti Sì.

**Fabrizio Paganelli:** Sì,

**Elena Spini:** Avevamo detto che non erano tantissime all'anno, corretto.

**Fabrizio Paganelli:** allora nel 2024 sono parecchie perché nel 2000 però ecco queste qui mi ricollego all'altra domanda. Noi qua abbiamo una serie di codici articolo che sono tutta questa parte qua che inizia con SV, faccio così,

**Aurel mrruku:** Eh M.

**Fabrizio Paganelli:** inizia con SW che sono praticamente la vendita della piattaforma. Quindi abbiamo parecchie di righe, vedi, sono un migliaio e la maggior parte di queste risalgono al 2024. Io le posso eliminare queste righe qua?

**Aurel mrruku:** Sì, per me allora no.

**Fabrizio Paganelli:** Te non hai problemi di quadratura o robe o robe varie.

**Aurel mrruku:** Eh, per me il problema è il contrario. Se c'è qualcosa in più che non trova il

### **00:21:31**

**Elena Spini:** che non torna,

**Fabrizio Paganelli:** Ok.

**Elena Spini:** che non trova il codice.

**Aurel mrruku:** codice?

**Fabrizio Paganelli:** Ok. Quindi queste qui le andiamo a eliminare, tanto non ce ne frega niente. Bene, questo qui era quel discorso sul codice cliente perché io avevo fatto Aurel anche la prova di mettendo nella nella chiave anche il codice cliente non c'erano neanche record duplicati perché questi ehm è vero che che m come dire seri in questo numero, in questo caso sigla serie numero e data, è un duplicato. su clienti diversi, no? Però a livello di cliente non ho due duplicati sullo stesso cliente, quindi la chiave sarebbe stata unica se si se si potesse se si poteva considerare anche il codice all'interno della chiave, però se non si può amen.

**Aurel mrruku:** Il problema è la struttura che abbiamo implementato non ci permette di fare sta

**Fabrizio Paganelli:** Ok,

**Aurel mrruku:** cosa.

**Fabrizio Paganelli:** va bene. Eh direi che non ho nient'altro.

**Aurel mrruku:** Ok.

**Fabrizio Paganelli:** Tutto quello che volevo chiedere l'avevo chiesto.

**Aurel mrruku:** Ma quindi queste sono le righe d'ordine.

**Fabrizio Paganelli:** Queste qui sono le righe d'ordine.

### **00:22:46**

**Aurel mrruku:** Ok? Ovviamente mi deve passare prima l'ordine, poi il riferimento.

**Fabrizio Paganelli:** Sì, sì, l'ha testate.

**Aurel mrruku:** Sì,

**Fabrizio Paganelli:** Sì, sì.

**Aurel mrruku:** quindi poi il riferimento delle righe d'ordine a quello.

**Fabrizio Paganelli:** No, ma io io io ho fatto il lavoro al contrario perché andando a recuperare in modo corretto le righe ordine, poi dalle righe ordine ti passo le testate

**Aurel mrruku:** Ok, perfetto.

**Fabrizio Paganelli:** e direi che basta. Non non ho altre domande a meno che non che mi vengono in mente dopo io stamattina mi son messo un po' a smanettare su su sales force e voi qui ci state ancora lavorando, giusto?

**Aurel mrruku:** Ovviamente ho fatto un rilascio 20 minuti fa,

**Fabrizio Paganelli:** Eh,

**Aurel mrruku:** l'ho aggiustato il la descrizione,

**Fabrizio Paganelli:** perché?

**Aurel mrruku:** ho fatto un aggiornamento sui prodotti, ho messo quel campo S che sarebbe tipologia merceologica, mi sa che si chiamava. Eh,

**Fabrizio Paganelli:** M.

**Aurel mrruku:** abbiamo tolto le ho messo i livelli sul prodotto, ho fatto alcuni campi modificabili sul prodotto,

**Fabrizio Paganelli:** Ok,

**Aurel mrruku:** ho aggiustato un paio di cambi sull'account, ho fatto fatto un bel po' di cambiamenti.

### **00:23:55**

**Aurel mrruku:** Sì.

**Fabrizio Paganelli:** perché io dopo oggi Zo. che ha a fare ho fatto altre prove eh eh sbagliando volutamente. Eh che cosa ho visto?

**Aurel mrruku:** Sì,

**Fabrizio Paganelli:** Che adesso vedo se riesco a trovare Ciao, ciao Giuliano. Vedo se riesco a trovare la

**Aurel mrruku:** test che hai fatto?

**Fabrizio Paganelli:** il test che ho fatto. Ecco questo qua. Test vendita normale.

**Aurel mrruku:** Sì.

**Fabrizio Paganelli:** Praticamente io qui ho queste. Vedi che cosa ho cosa ho fatto? Io qui ho messo prima dentro una un ordine con questo codice prodotto prezzo di listino. Eh,

**Aurel mrruku:** Sì,

**Fabrizio Paganelli:** non gli ho messo gli sconti,

**Aurel mrruku:** sì.

**Fabrizio Paganelli:** poi sono andato a mettergli gli sconti, però qui lui non non mi ha modificato.

**Aurel mrruku:** No, fai fai gestisci i prodotti un attimo. No,

**Fabrizio Paganelli:** Vedi? Ah,

**Aurel mrruku:** non eh vai dietro perché non è

**Fabrizio Paganelli:** scusa.

**Aurel mrruku:** ancora carici. Ok, quindi Ma tu gli vuoi togliere come prodotti? Non ho capito.

**Fabrizio Paganelli:** No, no, io ho inserito un ordine, ho generato il PDF,

### **00:25:13**

**Aurel mrruku:** Sì,

**Fabrizio Paganelli:** mi sono messo nei panni di un tutor. Inserisco un ordine,

**Aurel mrruku:** sì,

**Fabrizio Paganelli:** genero un PDF prima di mandarlo al cliente, lo guardo. Mi accorgo che ho sbagliato,

**Aurel mrruku:** sì.

**Fabrizio Paganelli:** mi sono dimenticato di mettergli uno sconto. Prendo e vado a provare a mettergli lo sconto, no? Tipo vado qui, ad esempio.

**Aurel mrruku:** Sì. Ma lì è la trunch, praticamente. Sì, sì,

**Fabrizio Paganelli:** Eh,

**Aurel mrruku:** la tranch. Devi andare su la riga sopra.

**Fabrizio Paganelli:** dov'è che devo andare?

**Aurel mrruku:** Gestisci i prodotti. fai gestisci i prodotti che qua stavamo lavorando oggi che ti dovevamo mettere lo sconto qua sopra tipo praticamente.

**Fabrizio Paganelli:** Niente, allora se ci state lavorando è inutile che m evidentemente

**Aurel mrruku:** Anzi chiedo un attimo ai ragazzi, forse l'hanno fatto Regina e modific sconto

**Elena Spini:** Ma e tu qua la modifica come pensavi di farla, Fabrizio?

**Aurel mrruku:** M.

**Elena Spini:** Così.

**Fabrizio Paganelli:** no, io non visto che ci state lavorando non dico niente. Niente ancora perché sennò corro rischio di dire delle stupidate.

### **00:26:29**

**Fabrizio Paganelli:** Vedi, ad esempio, qui vedi che c'è 2005, no? Il il il prodotto a 3000 3450.

**Elena Spini:** E no, infatti ho capito il problema.

**Fabrizio Paganelli:** Eh,

**Aurel mrruku:** No,

**Elena Spini:** C

**Aurel mrruku:** mi hanno detto che hanno fatto fino adesso solo quando li aggiungi, quindi non quando li modifichi.

**Fabrizio Paganelli:** a posto, a posto.

**Aurel mrruku:** Fai un attimo aggiungi prodotto, giusto per vedere se lo vedi correttamente. Fai aggiungi prodotto.

**Fabrizio Paganelli:** Adesso sta aggiornando.

**Aurel mrruku:** Scegli un prodotto.

**Fabrizio Paganelli:** Scrivo un messaggio e cato tutte le vendite.

**Aurel mrruku:** Ok, quindi l'hanno sta succedendo là.

**Fabrizio Paganelli:** Ah, sono io che ho i soliti problemi.

**Aurel mrruku:** Ok. Ok. Vedi? L'hanno messo solo qua e hanno messo anche il tasto cancella a destra, però non c non l'hanno ancora finito su modifiche.

**Fabrizio Paganelli:** No, no. Ok, perché se io qui metto Esatto.

**Aurel mrruku:** Sarà così praticamente.

**Fabrizio Paganelli:** Ok, va bene.

**Aurel mrruku:** Quindi sceglierei le trunch.

**Fabrizio Paganelli:** Ok. Dopo Aurel io anche sulla scorta, ma questo ce l'eravamo già detti, quando si fa eh si genera l'ordine bisogna che ci portiamo tutte queste informazioni, eh prezzo di listino, sconti, netto,

### **00:27:37**

**Aurel mrruku:** Ma ce l'hai?

**Fabrizio Paganelli:** non possiamo fare eh e non possiamo fare delle fatture solo al netto,

**Aurel mrruku:** Ce l'hai per forza? Ce l'hai?

**Fabrizio Paganelli:** questo mi raccomando,

**Aurel mrruku:** Eh sì. No,

**Fabrizio Paganelli:** Eh,

**Aurel mrruku:** ma quello non non dipende da me. Io t' ho detto che ce li ho i campi.

**Fabrizio Paganelli:** ok.

**Aurel mrruku:** Dovevi parlare con Mirko.

**Fabrizio Paganelli:** No, no, ho capito, però dobbiamo è una cosa che dobbiamo fare quella,

**Aurel mrruku:** Come ripeto, scusa se ripeto, ma non io ce li ho i campi.

**Fabrizio Paganelli:** eh. Ok.

**Aurel mrruku:** Basta che mi Mirko mi dica quello,

**Fabrizio Paganelli:** Quali sono?

**Aurel mrruku:** quali sono da mappare,

**Fabrizio Paganelli:** Dove li devi mettere?

**Aurel mrruku:** se esistono quelli campi da se si può fare.

**Fabrizio Paganelli:** No, no, esistono per forza.

**Aurel mrruku:** Ok, va bene. Quindi o manda direttamente una mail adesso a Mirko, così ci indica. Poi in teoria non ti serve lo sconto, basta che ti dà prezzo netto, prezzo listino e sconto viene calcolato in automatico per non avere problemi

### **00:28:32**

**Fabrizio Paganelli:** Eh sì,

**Aurel mrruku:** di scontistica.

**Fabrizio Paganelli:** questo sì,

**Aurel mrruku:** Sai che c'è il rotondamento per difetto, arrotondamento per cesto.

**Fabrizio Paganelli:** sì, sì. Questa qui gliela chiediamo a lui tecnicamente come si può fare, insomma, però anche qui dobbiamo trovare il modo di poterlo fare perché Maxal è un po' ignorante quando si devono gestire gli sconti. Quindi, ad esempio, le percentuali, se uno definisce sconto 20% deve deve scrivere 20. Se invece voglio fare una riduzione diretta del prezzo,

**Aurel mrruku:** Mm.

**Fabrizio Paganelli:** devo mettere meno una cifra in valore assoluto. Quindi è un po' ha delle regole abbastanza stringenti.

**Aurel mrruku:** Ah, per questo ti dico di non usare il percentuale, ma usiamo i prezzi, quindi l'amount, il valore del prezzo,

**Fabrizio Paganelli:** Invece invece sarebbe più corretto usare solo la percentuale perché eh

**Aurel mrruku:** ma non è corretto perché con tutti i RP c'è il problema di arrotondamento. 25,2% in sales force non coincide con 25,2% in ERP.

**Fabrizio Paganelli:** vabbè, dopo se è 0,01 di differenza sul totale fattura cambia poco. Insomma, però ehm

**Aurel mrruku:** Ok. Sì, stiamo parlando di arrotondamento, quindi la seconda cifra dopo la virgola.

### **00:29:45**

**Fabrizio Paganelli:** Sì, sì, sì, va bene.

**Aurel mrruku:** Ok.

**Elena Spini:** Noi dobbiamo scappare.

**Fabrizio Paganelli:** E posto io.

**Aurel mrruku:** Eh, appena finisci mandami l'el Poi ti dico di procedere con la mappatura

**Fabrizio Paganelli:** Eh sì,

**Aurel mrruku:** dei Ok.

**Fabrizio Paganelli:** sì, va bene.

**Aurel mrruku:** E dobbiamo abilitare tutti i prodotti.

**Fabrizio Paganelli:** Dopo mi dici. Sì,

**Aurel mrruku:** Sapilo in sta.

**Fabrizio Paganelli:** sì, va bene, va bene, ma se è una cosa temporanea, non è un problema, insomma.

**Aurel mrruku:** Ok,

**Fabrizio Paganelli:** Va bene,

**Aurel mrruku:** grazie.

**Fabrizio Paganelli:** a posto.

**Elena Spini:** Va bene,

**Aurel mrruku:** Ciao.

**Fabrizio Paganelli:** Grazie a voi.

**Elena Spini:** grazie. Buon lavoro.

**Fabrizio Paganelli:** Ciao Cau!

**Elena Spini:** Ciao.

**Fabrizio Paganelli:** Ja. Quindi questo è il passaggio. Vai No, c'è lei, ragazzi, che non la sopporto più, eh. Untigione la strozza. Ah, ci si mette a fare delle domande, porta fuori tema alle persone, gioc. M. M. Sì, perché Ok, comunque quandoore Ok, non so comunque di ogni materiale il fornitore direitore No, per della ricetta. No.

### **Trascrizione terminata dopo 00:40:19**
