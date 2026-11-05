# **ð Trascrizione***  
*

 nov 4, 2026

##  **\[ROMI-PIENISSIMO\] - Continuazione Test e2e PROD - Trascrizione**

### **00:00:06**

  

**Aurel mrruku:** Stro. Ciao Fabrizio,

**Fabrizio Paganelli:** Ciao Aurel.

**Aurel mrruku:** come stai?

**Fabrizio Paganelli:** Bene, mi hai fatto la lavorata stamattina, eh?

**Aurel mrruku:** Anch'io ho lavorato stamattina tantissimo. Ho avuto tanti problemi su quella nota perché la struttura che ci ha dato lui non andava bene, ma finalmente ho trovato serviva un array. Praticamente era un modo strano che che fil maker prendeva il valore. Ah, in teoria, tipo, prima di pranzo sono andato in produzione, quindi forse siamo pronti anche a fare dei test direttamente in produzione.

**Fabrizio Paganelli:** Ah, ok. Ok, ascolta allora prima di iniziare a fare i test volevo chiedere un paio di cose. Allora, io ho aggiornato i dati, tutti gli storici, come avevamo detto, no? Perché stamattina ti avrei dovuto passare tutte le anagrafiche aggiornate,

**Aurel mrruku:** Sì.

**Fabrizio Paganelli:** gli account eccetera eccetera e i movimenti che mi avevi detto me li passi una volta, li carico tutti, così quando andiamo in Sì.

**Aurel mrruku:** Movimenti di ordini.

**Fabrizio Paganelli:** gli ordini che abbiamo anche.

**Aurel mrruku:** Sì, sì, sì, sì,

**Fabrizio Paganelli:** Ok,

**Aurel mrruku:** sì, sì, sì.

  
  

### **00:03:27**

  

**Fabrizio Paganelli:** allora sui, guarda, ti condivido, eh, perché volevo capire, non volevo far dei danni o comunque sia eh farti lavorare ehm più del necessario. Purtroppo è una cosa che ehm che ehm fatta più di un mese fa e l'ho l'ho ripresa. Non son sicuro se non mi ricordo i criteri che avevamo utilizzato. Allora, gli account, questi qui sono aggiornati a questa mattina. Ehm,

**Aurel mrruku:** sono entità principale, quindi basta che hanno l'ID di

**Fabrizio Paganelli:** ok, questo qui è esattamente com'era l'altra volta, quindi questo qui è l'ID del CRM,

**Aurel mrruku:** sì

**Fabrizio Paganelli:** il codice cliente di Mexal, eccetera eccetera eccetera.

**Aurel mrruku:** e tutto,

**Fabrizio Paganelli:** Poi dopo qua Ah, dimmi dimmi.

**Aurel mrruku:** no? è tutto che praticamente io poi i contatti li collego con quel codice cliente esterno, quindi

**Fabrizio Paganelli:** Ok, qua c'è il codice agente perché mi ricordo che avevamo fatto sto sto ragionamento.

**Aurel mrruku:** Sì.

**Fabrizio Paganelli:** Qua c'è

**Aurel mrruku:** E io ho già fatto un script e gli dico ogni volta prendi l'ultimo codice agente se per qualche motivo sono due agenti con lo stesso codice, ma abbiamo già ho già il pronto.

  
  

### **00:04:48**

  

**Aurel mrruku:** Quindi se per esempio c'è un codice agente che finisce con 19, uno fa riferimento a Davide e l'altro fa riferimento a un'altra persona, prendo l'ultimo, quello il più recente, perché io ce l'ho già il codice agente in sales force, quindi quel 19 io ce l'ho già associato a Davide,

**Fabrizio Paganelli:** Ok.

**Aurel mrruku:** diciamo, su Sales Force, quindi Ok,

**Fabrizio Paganelli:** Non sono sicuro se l'ultimo è giusto perché dopo io qua mi sono fatto un incrocio, no? Dove ho messo l'azienda proprietario che è ehm che è il proprietario che c'è su Zoo.

**Aurel mrruku:** mi passi questa questa tabella e faccio faccio ranare lo script su questa tabella. Allora, mi servono solo gli prime due prime tre colone, praticamente.

**Fabrizio Paganelli:** Eh, puoi accettare la l'Elisa che c'è anche lei,

**Aurel mrruku:** Sì, sì, scusa, non l'ho visto.

**Fabrizio Paganelli:** perché vedi qui, Barbara Giordani ha un ha dei clienti a 1 2 3 4 5 codici agenti, ma sono sbagliati, va bene solo il primo.

**Aurel mrruku:** Sì, va bene. Però tu c'hai degli account con 10, 16 17. Stessa cosa per Carmine. Quindi quello che stavo t'ho detto all'inizio,

  
  

### **00:06:09**

  

**Fabrizio Paganelli:** Eh,

**Aurel mrruku:** guarda che avete lo stesso codice agente condiviso con diversi agenti.

**Fabrizio Paganelli:** ok. Ma tu qual era il criterio che hai utilizzato per fare questo abbinamento?

**Aurel mrruku:** E prendo l'ultimo. Quindi se hai un codice agente 19, vado a vedere sul sistema per il momento in salos chi è il codice agente 19 viene collegato all'utenza che ha il codice agente 19.

**Fabrizio Paganelli:** Non ho capito, Aurel, fammi un esempio pratico. Ti ti chiedo scusa, ma non ho capito perché corriamo il rischio che con questa cosa qui spostiamo i Clinti da

**Aurel mrruku:** Allora, Fabrizio, ti spiego. Barbara a Barbara.

**Fabrizio Paganelli:** una Eh mh.

**Aurel mrruku:** Barbara adesso sul sistema ha il codice 04, diciamo.

**Fabrizio Paganelli:** Ok,

**Aurel mrruku:** Se mi arriva un account con codice agente 04, quel codice agente andrà sempre a Barbara.

**Fabrizio Paganelli:** perfetto.

**Aurel mrruku:** Anche se tu sul tuo file Excel che mi passi hai il nome

**Fabrizio Paganelli:** Ok.

**Aurel mrruku:** Davide con il codice agente 04. Io non mi baso sul nome che hai tu sul file Excel, ma mi baso del codice agente che ho io su Sales Force.

  
  

### **00:07:28**

  

**Aurel mrruku:** Chiaro?

**Fabrizio Paganelli:** in quella tabellina sintetica

**Aurel mrruku:** Vai sulla sugli account. No, no, eh, non qua sui account del tuo Excel, nel tuo file Excel che mi passi.

**Fabrizio Paganelli:** qua, scusa,

**Aurel mrruku:** Qua,

**Fabrizio Paganelli:** non è questo.

**Aurel mrruku:** qua. Eh,

**Fabrizio Paganelli:** Qua

**Aurel mrruku:** il primo she. Sì, vai il primo sheet. Adesso io vado a leggere, non vado a leggere il nome a destra dove c'è il codice agente.

**Fabrizio Paganelli:** qua,

**Aurel mrruku:** Io non vado a leggere l'azienda proprietario nome, ma vado a leggere solo il codice agente.

**Fabrizio Paganelli:** quindi

**Aurel mrruku:** ne frego di del valore che c'è su azienda proprietario nome

**Fabrizio Paganelli:** ok.

**Aurel mrruku:** e se per qualche motivo io non ce l'ho un codice agente su sales force, lo collego con 01 che è quello.

**Fabrizio Paganelli:** Allora, ho capito. Allora, questi qui te li devo mettere a posto io, Aurel,

**Aurel mrruku:** Ok?

**Fabrizio Paganelli:** perché voglio te te li metto perché

**Aurel mrruku:** Non serve che non serve che li metti a posto, capito?

**Fabrizio Paganelli:** voglio f

**Aurel mrruku:** Basta che mi dai l'elenco che me l'hai già dato con quei sette agenti e il loro codice che hai su.

  
  

### **00:08:43**

  

**Fabrizio Paganelli:** Ok, perfetto. Però a quanto ho capito io, tu ti basi su questo qui, su questo campo qui che ho messo in giallo,

**Aurel mrruku:** Sì, sì,

**Fabrizio Paganelli:** codice gente.

**Aurel mrruku:** sì.

**Fabrizio Paganelli:** Cè però ehm ehm perché dico che te lo devo mettere a posto io? Perché se io provo a fare una cosa del genere, guarda, eh, ordino per azienda, proprietario name, se lo trovo, poi ordino per codice agente, eh, se lo trovo. Ok, il resto non me ne non me ne frega niente bene. Io qui vedi, ho Barbara Giord. Questo account qui, questo record qui è un account che ha Barbara Giordani e codice agente 04 è corretto. Io scendo scendendo in giù adesso qui

**Aurel mrruku:** Posso posso rispondere a una telefonata per cortesia?

**Fabrizio Paganelli:** le Certo, certo.

**Aurel mrruku:** M.

**Fabrizio Paganelli:** Grazie. Ci sono tutti i titoli delle Big Tech che sono in crollo perché erano tutti sotto al acceso. Sì, ma tes comunque ancora non so perché, ma ci sono le nostre voci. È perché siamo incompatibili io e te.

  
  

### **00:12:55**

  

**Fabrizio Paganelli:** da casa non su Discord, sai? No, ti dicevo che ci sono tutti i titoli del Adesso sospa, tranquillo. Vai. Ci sono i titoli delle big tech che sono tutti in crollo perch Yeah.

**Aurel mrruku:** Chiedo scusa, Fabrizio, ha preso più tempo di quello che pensavo. Mi senti? Se siete in muto, penso.

**Fabrizio Paganelli:** Ecco, sì, sì, siamo in muto. Ok, mi dovresti sentire?

**Aurel mrruku:** Sì, sì.

**Fabrizio Paganelli:** No, ti dicevo prima che ti volevo passare questo coso in modo preciso, nel senso se io vado qua e faccio un ordinamento per azienda proprietario name, che è il diciamo il il tutor che è collegato al poi faccio qua per codice agente e poi per non farci mancare nulla ci mettiamo anche la categoria provvigioni agente, così Così. Ok. Qui vedi, io ho Barbara Giordani. Questo account ha e ha proprietario name su Zoo, Barbara Giordani, agente e categoria provvigioni. Questo qui che è quello che andrà a finire su Self. Questo va bene. Se io scendo un po' cosa succede? Che siccome sul Zoo non siamo delle spade a a a gestire le anagrafiche, cosa succede?

  
  

### **00:20:55**

  

**Fabrizio Paganelli:** Perché Barbara Giordani ha un account dove il codice cliente Eh, vedi, è 610 che è sbagliato.

**Aurel mrruku:** Sì,

**Fabrizio Paganelli:** Allora,

**Aurel mrruku:** ma se a me arriva 610 si collegherà a Barbara

**Fabrizio Paganelli:** ok.

**Aurel mrruku:** Giordano con categoria provvisione 4, quindi a prescindere. Quindi se mi arriva 6 10 610 10 in automatico il sistema lo lega con

**Fabrizio Paganelli:** Ok.

**Aurel mrruku:** l'user che ha un ID sales force Barbar Giordani e user di sales force ha la categoria provigione 4 a prescindere di quello che mi passi te

**Fabrizio Paganelli:** Quindi qua,

**Aurel mrruku:** qua no a quella a

**Fabrizio Paganelli:** quindi quando tu fai l'importazione in realtà leggi questa questa colonna qui,

**Aurel mrruku:** destra.

**Fabrizio Paganelli:** leggi questa, ma se leggi questa su questo account,

**Aurel mrruku:** Ah no, hai ragione. Cavolo,

**Fabrizio Paganelli:** eh è quello che volevo capire. In base a quello che leggi tu cambia il comportamento, quindi e allora te li devo te li devo trasformare

**Aurel mrruku:** io leggio codice gente. Leggo codice.

**Fabrizio Paganelli:** io questi qui.

**Aurel mrruku:** Sì,

**Fabrizio Paganelli:** Io qui devo prendere e su qui Barbara Giordani.

  
  

### **00:22:01**

  

**Aurel mrruku:** sì,

**Fabrizio Paganelli:** Faccio così,

**Aurel mrruku:** sì, sì,

**Fabrizio Paganelli:** ti metto 6104 e siamo tutti contenti.

**Aurel mrruku:** sì.

**Fabrizio Paganelli:** Posto questo l'ho capito.

**Aurel mrruku:** Ma sì, so che è più il lavoro lato tu, ma il problema come ho impostato io il sales faccio il riferimento al codice agente.

**Fabrizio Paganelli:** Va bene, non c'è problema. Tanto io anche se te lo faccio altre due tre volte da qui a quando andiamo in produzione per me non è un problema. Io me lo sono segnato, ho capito il criterio e le prossime volte che te lo manderò farò la stessa

**Aurel mrruku:** Ok,

**Fabrizio Paganelli:** cosa.

**Aurel mrruku:** grazie mille.

**Fabrizio Paganelli:** Poi l'altra cosa che ti volevo chiedere perché mi sono fatto una lista di tutto quello che avevo passato l'altra volta, gli articoli non c'è bisogno che te li do perché li prendi da Mexal, dico bene?

**Aurel mrruku:** Oh,

**Fabrizio Paganelli:** quelli li hai già presi.

**Aurel mrruku:** li ho già presi in

**Fabrizio Paganelli:** Poi io avevo le campagne che queste le abbiamo già inserite in

**Aurel mrruku:** produzione, vero? Sì,

**Fabrizio Paganelli:** Sì. i lead.

  
  

### **00:22:53**

  

**Fabrizio Paganelli:** Niente, ti devo passare la lista dei locali.

**Aurel mrruku:** sì, è la lista dei locali.

**Fabrizio Paganelli:** La lista no,

**Aurel mrruku:** Non so se li hai mai visto in Sales Force. Ok,

**Fabrizio Paganelli:** non li ho mai visti.

**Aurel mrruku:** perché abbiamo fatto dei test coi locali, anche ieri con Elena stiamo facendo dei test e praticamente il locale c'aveva

**Fabrizio Paganelli:** Mh.

**Aurel mrruku:** categor c'era un campo sui locali che veniva poi ribaltato a livello di preventivo.

**Fabrizio Paganelli:** Mm.

**Aurel mrruku:** erano la tipologia del Oddio,

**Fabrizio Paganelli:** Ok.

**Aurel mrruku:** poi appena facciamo i testi ti faccio vedere come come

**Fabrizio Paganelli:** Ok, poi dopo, quindi io ti devo passare gli account, i locali e gli ordini. Basta.

**Aurel mrruku:** Ma i locali devono avere il riferimento dell'account, quindi il codice maxile dell'account.

**Fabrizio Paganelli:** Sì, fammi vedere perché anche questo stamattina l'ho fatto. È aggiornato sia al 4 novembre. Locali sales force. Ah, quindi qui ti serve il codice cliente 501 punto.

**Aurel mrruku:** Sì, sì, sì.

**Fabrizio Paganelli:** M questa la vedo più dura. Comunque ci proviamo.

  
  

### **00:24:00**

  

**Aurel mrruku:** E quello è il posto di azienda, capito?

**Fabrizio Paganelli:** Sì,

**Aurel mrruku:** Vedi il primo la prima colonna è che se un locale non ha un'azienda per me

**Fabrizio Paganelli:** sì, sì. Ok,

**Aurel mrruku:** non è collegato a un a un parent,

**Fabrizio Paganelli:** ok,

**Aurel mrruku:** quindi non verrà mai usato perché quando fai le offerte lo devi per forza collegare a un'azienda quell'offerta.

**Fabrizio Paganelli:** ok. E niente, io sono sono a posto, nel senso che poi dopo stamattina ho fatto anche tutta la mappatura delle campagne, delle edizioni e l'aggancio con i singoli codici prodotto, quindi

**Aurel mrruku:** Perfetto. Ma a sto punto facciamo dei test direttamente in produzione, se se ti va bene,

**Fabrizio Paganelli:** Ah\!

**Aurel mrruku:** così prepariamo anche dei biglietti per Fabrizio di Romi, così lui può già mettere in piedi.

**Fabrizio Paganelli:** Ok,

**Aurel mrruku:** O ha già messo in piedi, ma non ha mai testato coi dati reali in produzione l'invio dei delle mail con i biglietti.

**Fabrizio Paganelli:** così facciamo anche una prova di eh incasso.

**Aurel mrruku:** Sì, sì.

**Fabrizio Paganelli:** Ok,

**Aurel mrruku:** Non possiamo fare più di una perché a lui serviranno, se è possibile, una decina di biglietti con tre ordini diversi.

  
  

### **00:25:07**

  

**Fabrizio Paganelli:** va bene, va bene, non c'è problema.

**Aurel mrruku:** Ok.

**Fabrizio Paganelli:** Va bene.

**Aurel mrruku:** Eh, poi abbiamo fatto Ok, riesci a condividere te? Meglio che fai te, sinceramente. Se vuoi condivido anch'io, ma forse conviene che fai te.

**Fabrizio Paganelli:** No, no, così dai vede anche l'Elisa, tanto siamo qui uno di fianco all'altro.

**Aurel mrruku:** Ok.

**Fabrizio Paganelli:** Ehm,

**Aurel mrruku:** Entra in produzione, ci sei già?

**Fabrizio Paganelli:** ci ci dovrei già essere.

**Aurel mrruku:** Perfetto.

**Fabrizio Paganelli:** Sì,

**Aurel mrruku:** Ok,

**Fabrizio Paganelli:** quindi account.

**Aurel mrruku:** vai su gli account, usa quelli se vuoi facciamo eh Hai avuto notizie riguardo a quel time out limit che ricevevamo da Antipay?

**Fabrizio Paganelli:** No, no,

**Aurel mrruku:** No.

**Fabrizio Paganelli:** oggi, domani abbiamo un evento, quindi Andrea non c'è e ieri doveva preparare la cosa e non

**Aurel mrruku:** Ok,

**Fabrizio Paganelli:** non ce l'ha fatto,

**Aurel mrruku:** va bene.

**Fabrizio Paganelli:** insomma. Quindi a sto punto io continuerei a usare questo can qui.

**Aurel mrruku:** Sì,

**Fabrizio Paganelli:** Amen. Quindi siamo sempre qua. Te Lisa,

**Aurel mrruku:** sì.

**Fabrizio Paganelli:** vuoi vedere? Hai da fare?

  
  

### **00:26:11**

  

**Aurel mrruku:** Fai new opportunità. C'è il pulsante a destra.

**Fabrizio Paganelli:** А

**Aurel mrruku:** Vabbè, già che ci sei fai visualizza che di sicuro ce l'hai qualcosa là. Vabbè, opportunità a destra.

**Fabrizio Paganelli:** standard test 10411. Salva. Poi nuovo preventivo, ponifico fine mese data fattura salva. gestisci prodotti. Facciamo Academy.

**Aurel mrruku:** Ma perché ti sta uscendo quella roba là?

**Fabrizio Paganelli:** Ah, non lo so. Academy 2.

**Aurel mrruku:** Vedi che abbiamo messo anche l'importo?

**Fabrizio Paganelli:** Sì, due. E sconto 10. Ok. Poi ehm mastery. Ah, perché qui compare bisogna scorrere.

**Aurel mrruku:** Sì, sì, sì, sì. Vuoi che te li metto un per Non hai salvato il primo, capito?

**Fabrizio Paganelli:** E in che senso? Aurel

**Aurel mrruku:** Perché siccome non è salvato non l'ho inserito ancora. Vedi due prodotti selezionati. Se sono n prodotti e non li hai salvati, sei costretto a scorrere tutte tutti i prodotti che hai selezionato.

**Fabrizio Paganelli:** ok. No, questa queste finestre qui per facilitare il lavoro dei tutor non sarebbe male metterle magari più in orizzontale in modo tale che loro qui hanno meno

  
  

### **00:28:26**

  

**Aurel mrruku:** Ok,

**Fabrizio Paganelli:** meno,

**Aurel mrruku:** ok, lo possiamo fare,

**Fabrizio Paganelli:** capito?

**Aurel mrruku:** lo possiamo.

**Fabrizio Paganelli:** Eh,

**Aurel mrruku:** Se vuoi possiamo anche dividere la parte dei prodotti selezionati a sinistra, la parte dei prodotti da scegliere a destra.

**Fabrizio Paganelli:** non lo so,

**Aurel mrruku:** Ok,

**Fabrizio Paganelli:** in una maniera che il tutor possa vedere in modo più agevole che cosa va ad aggiungere, capito? Oltre che se qui lui aggiunge 10-1 prodotti diventa complicato che con una finestrina così piccola.

**Aurel mrruku:** ok, mi è chiaro.

**Fabrizio Paganelli:** Quindi salvo,

**Aurel mrruku:** Capisco cosa posso fare.

**Fabrizio Paganelli:** poi crea le tranche. Perché mi compare sta roba?

**Aurel mrruku:** Io penso che tu c'hai dei problemi o con mouse o con click o qualcosa sul tuo browser

**Fabrizio Paganelli:** Boh.

**Aurel mrruku:** perché vedi quello è il tasto destro. Quando clicchi il tasto destro esce quello, tasto destro del il click destro del mouse, intendo.

**Fabrizio Paganelli:** Eh, ok, è messo male il mio mouse. Aspetta. Va col mouse. Sai cosa faccio? Questo qui lo stacco e prendo un mouse wireless che c'è qua di dietro.

  
  

### **00:29:23**

  

**Fabrizio Paganelli:** Guarda, così facciamo prima. Ecco fatto. Così dovremmo essere a posto. Allora, data scadenza abbiamo detto qui mettiamo E nell'altra tranche mettiamo 31126. Ah, non ho messo non ho fatto così. Così devo fare e qui faccio così. Crea le tranche. Bene, quindi adesso io posso fare genera PDF. Guardo il mio PDF, bla bla bla. E qui ho il mio ordine. Ok. Al sto punto lo invio. Sono diventato esperto. Hai visto?

**Aurel mrruku:** Infatti, quindi puoi fare già i test aiuto ormai.

**Fabrizio Paganelli:** Posso venire a lavorare per voi?

**Aurel mrruku:** Sì, sai che c'è un ruolo che si chiama system admin che fa tutta sta roba?

**Fabrizio Paganelli:** Si mette si mette nei panni dell'utente,

**Aurel mrruku:** Sì, sì.

**Fabrizio Paganelli:** quindi avete vi serve qualcuno? Te dove vuoi andare?

**Aurel mrruku:** Lei no,

**Fabrizio Paganelli:** Chi lei?

**Aurel mrruku:** eh.

**Fabrizio Paganelli:** No, bellissimo.

**Aurel mrruku:** Vedi che hai tutto là?

**Fabrizio Paganelli:** Totale listino,

**Aurel mrruku:** Sì,

**Fabrizio Paganelli:** sconto totale netto. E questo io qui sono il cliente che vedo in questo in questo momento.

  
  

### **00:31:45**

  

**Aurel mrruku:** sì, sì, sì, sì.

**Fabrizio Paganelli:** Perfetto. e confermo il mio preventivo.

**Aurel mrruku:** Aurel, già confermato. Status cambiato in sales force e molto probmente adesso ti è arrivato che mail avevamo su contatto principale.

**Fabrizio Paganelli:** chiede accettato.

**Aurel mrruku:** Ok.

**Fabrizio Paganelli:** Per cui qua se nella mia mail non sta ho ricevuto questo per fare la firma digitale.

**Aurel mrruku:** Sì,

**Fabrizio Paganelli:** Eh, rivedi il documento

**Aurel mrruku:** accetta che altrimenti non ti Aspetta,

**Fabrizio Paganelli:** fermo.

**Aurel mrruku:** vediamo già. Ma firma,

**Fabrizio Paganelli:** Ah\!

**Aurel mrruku:** fa niente, pro. Sì, firma, non è un problema. Ma vediamo un po'. Oh. Lui alla fine che tutto torni. Vai, vai, vai. Infondo proprio eh è che non l'abbiamo previsto una

**Fabrizio Paganelli:** Qui perché non c'è la firma?

**Aurel mrruku:** firma là. Cos'è? Quello allegato B.

**Fabrizio Paganelli:** Che schy?

**Aurel mrruku:** Non è stato previsto una firma là. Dalle indicazioni la firma era là sopra.

**Fabrizio Paganelli:** Solo sopra.

**Aurel mrruku:** Sì, almeno da tutti i test che abbiamo fatto abbiamo avuto sempre due firme.

  
  

### **00:33:44**

  

**Fabrizio Paganelli:** Sì, infatti mi ricordo anch'io. La prima adesso mi è capitato adesso all'occhio di vederlo sta roba. Anche questa qui,

**Aurel mrruku:** Potete dare un'occhiata già che ci siete?

**Fabrizio Paganelli:** vedi?

**Aurel mrruku:** Mi date un un feedback. del documento proprio. Quindi spendete mezz'ora, un'ora e vedete tutte le righe del documento

**Fabrizio Paganelli:** Sì,

**Aurel mrruku:** e se non vi torna qualcosa anche a livello di data firma oppure qualche misspelling, quindi qualche errore ortografico.

**Fabrizio Paganelli:** perché quelli voi li avete rifatti voi praticamente sulla base del modello che avevamo dato noi.

**Aurel mrruku:** Sì, sì, sì,

**Fabrizio Paganelli:** Ok,

**Aurel mrruku:** sì. Hai già firmato.

**Fabrizio Paganelli:** quindi qua lui vado

**Aurel mrruku:** Vai su Sales Force,

**Fabrizio Paganelli:** qui,

**Aurel mrruku:** fai un refresh sempre. Perfetto.

**Fabrizio Paganelli:** firmato.

**Aurel mrruku:** Vai su correlato e c'hai l'ordine e le trunch. E c'hai ordine.

**Fabrizio Paganelli:** Ok.

**Aurel mrruku:** Clic premi su l'ordine a sinistra. a sinistra.

**Fabrizio Paganelli:** No,

**Aurel mrruku:** Numero d'ordine.

**Fabrizio Paganelli:** guardavo qui che non vedo la data l'importo l'importo della tranche, però forse non si può mettere,

  
  

### **00:34:59**

  

**Aurel mrruku:** No,

**Fabrizio Paganelli:** non mi ricordo.

**Aurel mrruku:** non l'abbiamo lasciato l'importo della trancia. Vabbè, si può mettere in teoria. Te la posso mh aspetta,

**Fabrizio Paganelli:** Eh ah

**Aurel mrruku:** non gli importa perché il trunch qua è un record di sales force,

**Fabrizio Paganelli:** ho capito.

**Aurel mrruku:** non è eh l'insieme

**Fabrizio Paganelli:** Non si può mettere la somma della della lista degli degli item.

**Aurel mrruku:** eh devo fare un collegamento degli item con delle trance, devo fare un formula che lo fai se me lo ricordi poi, ma cerchiamo di andare avanti. Sì,

**Fabrizio Paganelli:** Sì, sì,

**Aurel mrruku:** si può fare,

**Fabrizio Paganelli:** sì.

**Aurel mrruku:** però.

**Fabrizio Paganelli:** Queste qui sono cose più di rifinitura,

**Aurel mrruku:** Sì.

**Fabrizio Paganelli:** diciamo.

**Aurel mrruku:** Ok, premi sull'ordine. Perfetto.

**Fabrizio Paganelli:** Ordinato,

**Aurel mrruku:** E hai già inviato? È andato l'isso.

**Fabrizio Paganelli:** eh. Quindi se io adesso vado su Mexale, mi cerco quell'ordine นะ

**Aurel mrruku:** Sì, lo vedi? Vedi già vedi un po' l'ID. Vediamo un po' su Sales Force. E 57. M. O C157.

  
  

### **00:36:04**

  

**Fabrizio Paganelli:** È qui, guarda.

**Aurel mrruku:** Hai Hai visto da dove l'ho l'ho l'ho trovato, vero?

**Fabrizio Paganelli:** Perché mi dice azienda? Ah, è qua questo qua.

**Aurel mrruku:** E sì, è quello là. Aprilo.

**Fabrizio Paganelli:** Ah, qui adesso hai usato già il sezionale, giusto?

**Aurel mrruku:** Vai, aprilo. E hai anche notte. Vedi notte 07?

**Fabrizio Paganelli:** Ah, perfetto, perfetto.

**Aurel mrruku:** Vai un attimo su Salesp. Adesso vedi che hai eh vai sull'offerta, o meglio, apri un attimo il file che hai firmato oppure il preventivo.

**Fabrizio Paganelli:** Qui mi sono arrivati i biglietti. Sono già arrivati eh.

**Aurel mrruku:** Là dobbiamo capire cosa sta succedendo perché non è corretto. Come det non abbiamo ancora fatto il test con Fabrizio che non mi vedi che apri il documento. Deve essere 07 il documento. Vai sotto.

**Fabrizio Paganelli:** 07.

**Aurel mrruku:** Perfetto,

**Fabrizio Paganelli:** Perfetto.

**Aurel mrruku:** perfetto. Su sta cosa dell'ordine, come t'ho detto, lo traccio. Possiamo vedere una cosa? Vai un attimo su sales for, sull'ordine, eh? Ok. Vai su, puoi andare sul preventivo e ce l'hai là.

  
  

### **00:37:34**

  

**Aurel mrruku:** Clicca su preventivo. Vai su correllato, sotto non c'è. Ok. Perché arrivano i biletti status del Poi andare di nuovo sull'ordine per cortesia. Molto probmente sta facendo il filtro in modo sbagliato marketing e che non è disponibile, deve essere Aprilo. Vai su asset. Eh, vedi, non sono e sono in ordinato. Chi non sta prendendo correttamente.

**Fabrizio Paganelli:** M m tra l'altro io Academy 27 nella mappatura, se non ricordo male, ho messo data, invio biglietto, tutto quanto al 3127 per il momento per evitare di far casino.

**Aurel mrruku:** Penso che ha lasciato per lui aveva fatto un flow tipo un mese e mezzo fa, penso che non l'ha aggiornato.

**Fabrizio Paganelli:** Eh eh

**Aurel mrruku:** Questo è tutto. Ma ne faccio delle call con lui, forse appena chiudo con te o domani mattina e capisco che sta succedendo.

**Fabrizio Paganelli:** ok andiamo qua a fatturarlo questo ordine.

**Aurel mrruku:** Sì. Okay.

**Fabrizio Paganelli:** Yeah.

**Aurel mrruku:** Sì.

**Fabrizio Paganelli:** Qui ho 31 12 26. Qui ho 30 26. Non mi ricordo come si faceva a fatturare a mano, diciamo.

  
  

### **00:39:13**

  

**Fabrizio Paganelli:** Se qui faccio FT bla bla bla. Questo qui abbiam detto che scade al 3112, quindi questo qui lo mettiamo così. linea teorica mi dovrebbe fatturare solo questi 4830.

**Aurel mrruku:** Okay.

**Fabrizio Paganelli:** Perché mi dice gestisce la fattura elettronica?

**Aurel mrruku:** Ok,

**Fabrizio Paganelli:** A me qui abbiamo fatto la fattura esatto solo dei 4830. C benissimo. Qui c'è la nota riferimento al preventivo numero del bla bla bla

**Aurel mrruku:** perfetto. E lo sconto mi piace.

**Fabrizio Paganelli:** bla. Lo sconto va bene adesso.

**Aurel mrruku:** Totale torna.

**Fabrizio Paganelli:** Sì,

**Aurel mrruku:** Ok.

**Fabrizio Paganelli:** questo ordine di prima io dovrei continuare a vederlo qui per solo per il residuo. Infatti vedi qui preventivo in sola lettura. Vabbè, però qui vedo adesso bisogna capire qui che cosa succ cosa è successo. Ok, non lo so. Facciamo un refresh qui perché in linea teorica io qui dovrei essere in grado adesso di dover di poter fatturare preventivo in sola lettura perché

**Aurel mrruku:** Forse perché hai fatturato.

**Fabrizio Paganelli:** eh No, però ho fatturato solo un pezzo, vedi che l'altro prosegui senza modificare FT.

  
  

### **00:41:25**

  

**Fabrizio Paganelli:** Esegui. Ah, vediamo di qua. No, niente, non lo faccio perché volevo vedere se tu riesci a farmi il flusso eh,

**Aurel mrruku:** Sì. Eh,

**Fabrizio Paganelli:** diciamo delle fatture.

**Aurel mrruku:** sì. Prendo le fatture dell'ultimo giorno. 5 minuti. Sì.

**Fabrizio Paganelli:** Sì. Prova a parlare Aurel, voglio vedere se ti sento.

**Aurel mrruku:** Sì.

**Fabrizio Paganelli:** Ok, così la voce sente anche Lisa.

**Aurel mrruku:** 1 2 Sì.

**Fabrizio Paganelli:** Ok.

**Aurel mrruku:** Eh, prendo le ultime settimane così Ok. In teoria se vai su Sales Force vai sulle fatture sotto. No, ce l'è già là.

**Fabrizio Paganelli:** Ah, vabbè.

**Aurel mrruku:** Vai sull'ordine, vai su o sull'account come preferisci. Era 16 se non mi sbaglio,

**Fabrizio Paganelli:** No.

**Aurel mrruku:** l'ultimo da 11.000, quindi il primo premi là. Chi è sto problema? Che poi se vai sulle fatture c'è il tab fatture là. M. È arrivata la fattura da 4830. Ancora non ho fatto la cosa del fatturato e ce l'ho in ambiente di ma lo faccio oggi. E in teoria è tutto.

  
  

### **00:45:13**

  

**Fabrizio Paganelli:** Proviamo a anche far l'incasso perché adesso io gli asset ce li ho ancora in stato ordinato come avevamo visto

**Aurel mrruku:** Sì, ovviamente,

**Fabrizio Paganelli:** lui.

**Aurel mrruku:** ovviamente. Fai in casa.

**Fabrizio Paganelli:** Se io adesso eh proviamo a farlo. Allora, eh emissione prima nota 411 causale IC. Qui facciamo cassa. Quant'è che era la il 4830? 4830 cassa contante amministrazione 483. pienissimo. Potrebbe essere questo. E la incassiamo questa. Adesso tu se riaggiorni tutto qui mi dovrebbe andare indisponibile.

**Aurel mrruku:** Sì, sì.

**Fabrizio Paganelli:** Ja.

**Aurel mrruku:** Vai un attimo su scaden giusto per vedere che non era la scadenza fattura. Ok, era questo, vede? È vero.

**Fabrizio Paganelli:** Sì, sì.

**Aurel mrruku:** Quindi questa è la scadenza. Perfetto. Eh, vediamo. Poi dobbiamo anche definire il Io per il momento li ho lasciati solo alle 3:00 di mattina. Se poi dobbiamo decidere quante volte al giorno farlo sta cosa.

**Fabrizio Paganelli:** Eh, tu hai guardato quanto tempo ci mettono così.

**Aurel mrruku:** Sì. Se sono pochi stiamo parlando di un paio di minuti.

  
  

### **00:47:20**

  

**Fabrizio Paganelli:** E allora lo possiamo fare anche due o tre volte al giorno, male non ci fa.

**Aurel mrruku:** Infatti quello sta pensando ogni 6 ore tipo,

**Fabrizio Paganelli:** Ah,

**Aurel mrruku:** poi capisco come settare,

**Fabrizio Paganelli:** io qua eh

**Aurel mrruku:** però di notte ogni 6 ore non ti serve. Quindi a di sera all'inizio della giornata, tipo alle 7:00 di mattina, facciamo ora di pranzo e tipo alle 5 di sera. Ja.

**Fabrizio Paganelli:** Ma alle 5:00 di sera sarà poco, magari potrebbe se si se si possono impostare delle ore fisse potrebbe St. è una buona idea farlo eh la sera alle 8:00, così si prende tutta la giornata.

**Aurel mrruku:** Sì.

**Fabrizio Paganelli:** La mattina quando i tudo arrivano hanno già la situazione aggiornata e e poi si fa che ne so una volta ogni 2 ore alle 10 mezzogiorno, alle a alle 3:00 alle 5:00, no, adesso le 5:00. Poi dai, come ti dicevo, se ci vuole poco tempo e se abbiamo la disponibilità di elaborazione per poterlo fare, perché tu mi dicevi che c'erano un certo tipo di numero record eccetera.

**Aurel mrruku:** Sì,

**Fabrizio Paganelli:** Eh,

  
  

### **00:48:38**

  

**Aurel mrruku:** tipo ogni volta in teoria ci dobbiamo essere, quindi perché stiamo parlando Parlando di quattro colla alla volta. Abbiamo anche la chiamata di anticipay quando inviamo l'ordine. Io il problema dei picchi quando ci sono giorni in cui fai tipo 500 ordini al giorno non succedere mai.

**Fabrizio Paganelli:** non succederà mai.

**Aurel mrruku:** Ok, allora siamo a posto.

**Fabrizio Paganelli:** Al massimo ne facciamo boh, 100, ma sono quelli che arrivano da Wcommerce.

**Aurel mrruku:** No, allora non fa niente. Quelli di Wcommerce sono in entrata, quindi in uscita. Quando scende l'ordine su maxal fai quattro chiamate per ordine, siamo a 400. Facciamo 1000. No, penso che non non hai problemi.

**Fabrizio Paganelli:** Perché per dire, adesso vado per assurdo, eh, ma se si potesse fare anche una volta allora alle 9

**Aurel mrruku:** Non non esageriamo.

**Fabrizio Paganelli:** no, no.

**Aurel mrruku:** Si può fare.

**Fabrizio Paganelli:** È da è da capire da capire quanto

**Aurel mrruku:** Allora, si può fare, ma non vorrei andare vicino ai limiti.

**Fabrizio Paganelli:** troppo

**Aurel mrruku:** Io sempre, anche se qualcosa va male, tengo traccia perché c'ho quell'integration log. Quindi se qualcosa va male capisco, lo posso rimettere in piedi.

  
  

### **00:49:54**

  

**Aurel mrruku:** Meglio di non rischiare comunque.

**Fabrizio Paganelli:** adesso ci penseremo.

**Aurel mrruku:** Eh, fai un refresh adesso su di fai un

**Fabrizio Paganelli:** Allora,

**Aurel mrruku:** refresh.

**Fabrizio Paganelli:** se qui refrescio

**Aurel mrruku:** E status è pagata.

**Fabrizio Paganelli:** scadenza fattura pagato.

**Aurel mrruku:** Perfetto. Vai sugli asset a sinistra la fattura pagata.

**Fabrizio Paganelli:** Anche qui mi dice totale documento è pagato residuo bla bla bla. Gli asset sono disponibili perché ho

**Aurel mrruku:** Uno solo.

**Fabrizio Paganelli:** fatturato prima la maschera.

**Aurel mrruku:** Ah, è fatturato solo una tranch. Perfetto, perfetto.

**Fabrizio Paganelli:** Fatturato solo la maschera.

**Aurel mrruku:** Sta funzionando.

**Fabrizio Paganelli:** Adesso, eh adesso mi piacerebbe capire che cosa succede in un caso del genere, perché può darsi anche che così diciamo che sto anticipando un po' quella Che,

**Aurel mrruku:** Per il F.

**Fabrizio Paganelli:** dott.

**Aurel mrruku:** Yeah. quello che arriva nel futuro.

**Fabrizio Paganelli:** Eh, per il futuro. Però se io mi accorgo che questo incasso l'ho registrato male, cosa facciamo noi? Eliminiamo all'incasso. Questa rata qui che l'avevo chiusa, la riapro e praticamente adesso il mio cliente mi deve pagare ancora €4.830.

  
  

### **00:51:24**

  

**Aurel mrruku:** Ma c'è un problema?

**Fabrizio Paganelli:** Se tu fai un update,

**Aurel mrruku:** Eh sì,

**Fabrizio Paganelli:** che cosa succede?

**Aurel mrruku:** ma c'è un altro problema. Ti ricordi cosa abbiamo detto sul biglietto?

**Fabrizio Paganelli:** Fase due. Questo era.

**Aurel mrruku:** Sì, ma avevamo detto che il biglietto deve essere inviato quando l'ordine diventa quando l'asset diventa disponibile.

**Fabrizio Paganelli:** Sì.

**Aurel mrruku:** E se tu hai fatto hai fatto diventare disponibile quellasset, già partito la mail.

**Fabrizio Paganelli:** No, no, le le mail di invio dei biglietti non le le mandiamo via tot giorni prima dell'inizio dell'evento,

**Aurel mrruku:** Sì,

**Fabrizio Paganelli:** quindi

**Aurel mrruku:** sì, ma se qualcuno e giorni prima dell'inizio dell'evento ha fatto e hai fatto questa cosa qua, lui riceve in automatico il

**Fabrizio Paganelli:** no,

**Aurel mrruku:** biglietto parte in automatico appena

**Fabrizio Paganelli:** il biglietto non parte in automatico, eh. Aurel, il bigliato.

**Aurel mrruku:** diventa disponibile. tu sei entro la data di invio biglietto, quindi se sei più in là della data dell'invio biglietto e l'ass diventa disponibile in automatico Fabrizio il fatto che invi il biglietto.

**Fabrizio Paganelli:** Ah, ho capito cosa dici te.

  
  

### **00:52:42**

  

**Fabrizio Paganelli:** Se io data invio biglietto 4 e 1 di novembre e oggi siamo al quattro il biglietto

**Aurel mrruku:** Sì,

**Fabrizio Paganelli:** parte.

**Aurel mrruku:** sì, sì.

**Fabrizio Paganelli:** Però diciamo che nel questo qui avviene quando noi riceviamo degli incassi che sono immediatamente vicini all'inizio dell'evento. Calcola che per dire oggi qui questo caso qui era la Mastery, no? La mastery ci sarà il prossimo maggio,

**Aurel mrruku:** No, è chiaro,

**Fabrizio Paganelli:** qui.

**Aurel mrruku:** se non sei dentro la fascia dell'invio del biglietto non non deve succedere. Poi ne parlo anche con Fabrizio di di questa tematica qua,

**Fabrizio Paganelli:** Ma in questo caso qui,

**Aurel mrruku:** ma dobbiamo fare attenzione nella fase due. Per il momento faccio un refresh,

**Fabrizio Paganelli:** in quel

**Aurel mrruku:** vedo cosa arriva su Sales Force

**Fabrizio Paganelli:** dopo quando parleremo di ste cose facciamo venire anche la Rebecca.

**Aurel mrruku:** perché è molto delicata la questione, capito? Tu pensi di aver aggiustato la fattura, ma è già partito il biglietto,

**Fabrizio Paganelli:** Eh

**Aurel mrruku:** quindi o dobbiamo fare che i biglietti vengano inviati ogni sera, così hai un tutto il giorno davanti perso aggiustare la fattura oppure non

  
  

### **00:54:06**

  

**Fabrizio Paganelli:** No, no,

**Aurel mrruku:** so anche questo

**Fabrizio Paganelli:** i biglietti non possono essere mandati via ogni sera. Ah,

**Aurel mrruku:** è

**Fabrizio Paganelli:** a ridosso dell'evento forse anche sì, però normalmente no.

**Aurel mrruku:** prova, fai un refresh. Vai sulla scadenza,

**Fabrizio Paganelli:** In realtà ho fatto una scadere tornato indietro,

**Aurel mrruku:** vedi? Sì,

**Fabrizio Paganelli:** vedi?

**Aurel mrruku:** sì. Allora, se vai sull'asset e rimane

**Fabrizio Paganelli:** Il documento pagato eccetera eccetera. Eh,

**Aurel mrruku:** disponibile e dobbiamo fare il meccanismo e qua poi

**Fabrizio Paganelli:** invece qui dovrebbe tornare indietro in stato di ordinare. Ah.

**Aurel mrruku:** dobbiamo capire perché se se sei andato in incassato noi abbiamo fatto in modo che tu non puoi tornare mai più dietro indietro, capito? è tutto il meccanismo che era con un path, quindi con una via solo in avanti. Adesso dobbiamo fare in modo che anche se sei incassato tu devi poter tornare indietro se aggiorni lo scadenziario. Ja.

**Fabrizio Paganelli:** Sì, perché questa qui era tutto quel lavoro, quel quei ragionamenti che avevamo fatto, non so se vi ricordate, ormai diverso tempo fa.

  
  

### **00:55:26**

  

**Fabrizio Paganelli:** che c'era anche Mirko sul discorso delle dei read, perché noi il 20 del mese mandiamo via il flusso quando noi mandiamo via il flusso il cliente si chiude, quindi come se ci fosse stato l'incasso, però è un incasso salvo buon fine, per cui il giorno uno del mese successivo la banca ci restituisce un flusso di ritorno dove ci dice "Ah, su 100 read che mi hai mandato il giorno Solo 90 sono stati effettivamente incassati. Questi questi 10 il cliente non ha pagato. Quindi noi che cosa facciamo? Andiamo in contabilità e riapriamo la rata. Facciamo in modo automatico quello che hai mai visto fare manualmente a me adesso,

**Aurel mrruku:** Ho capito,

**Fabrizio Paganelli:** capito?

**Aurel mrruku:** ho capito. Mi è chiaro.

**Fabrizio Paganelli:** Eh

**Aurel mrruku:** Solo che dobbiamo essere molto molto attenti adesso anche con Elena, con Fabrizio di Romi, con voi Rebeca di capire quello che deve succedere quando tu vai indietro. E quando vai indietro dobbiamo capire se è mandato il biglietto cosa succede in quel caso, quando dobbiamo mandare il biglietto perché abbiamo detto in questo caso tu mandi il biglietto subito se sei nella data tra invio biglietto e la data dell'evento.

  
  

### **00:56:48**

  

**Fabrizio Paganelli:** Se sono sotto Sì, se sono sotto data mando il biglietto subito. Ah.

**Aurel mrruku:** Quindi ci sono diversi corner case che dobbiamo essere molto molto attenti a

**Fabrizio Paganelli:** Ok.

**Aurel mrruku:** gestire con dei flusi ad hoc per questi casi qua. Ok. Puoi creare altri un paio di ordini. fai, non so, fai a piacere, non so, una cinque biglietti,

**Fabrizio Paganelli:** Come fa l'el.

**Aurel mrruku:** fai diverse tranche praticamente,

**Fabrizio Paganelli:** Ah, se sei attacco.

**Aurel mrruku:** così prepariamo alcuni dati anche per Fabrizio di Romi, così lui può costruire delle logiche solide con dei dati reali in produzione e lo devi mandare di

**Fabrizio Paganelli:** Elisa

**Aurel mrruku:** nuovo in incassato questo in pagare se così

**Fabrizio Paganelli:** no.

**Aurel mrruku:** a i biglietti disponibili poi succede un casino.

**Fabrizio Paganelli:** gli serve a lui,

**Aurel mrruku:** Sì,

**Fabrizio Paganelli:** mettegli un link.

**Aurel mrruku:** gli serve a lui. No, non te non puoi fare niente. Là, lo devi fare da Maxal, devi mettere in fatturato tutto in

**Fabrizio Paganelli:** Però io io su Mexalla una volta che finiamo la call li vado a cancellare quei movimenti, non li lascio lì.

  
  

### **00:57:57**

  

**Aurel mrruku:** Sì, sì.

**Fabrizio Paganelli:** Eh,

**Aurel mrruku:** Tu li fai, io li prendo in sales force e poi fai quello che vuoi dopo il maxale

**Fabrizio Paganelli:** registra registra un incasso. Devi registrare un incasso €4.830.

**Aurel mrruku:** perché a me serve il dato in sales capito? il biglietto in sales in disponibile.

**Fabrizio Paganelli:** 8830 su è pienissimo verde. È il qu il primo 8942. Quindi normalmente partiamo dall'account per far l'ordine, per fare il Sì, per far tutto il cibo. Prendo questa. Prendo il primo.

**Aurel mrruku:** Prendi il primo che ha una partita IVA,

**Fabrizio Paganelli:** Fare un'opportunità specifica o no? Che tipo di ordine ti serve?

**Aurel mrruku:** basta che abbia dei biglietti. Quindi usa dei prodotti che ha dei biglietti e metti se riesci tipo quattro cinque prodotti in due tre tranche. Siamo vicino, eh, ci siamo quasi.

**Fabrizio Paganelli:** E questa

**Aurel mrruku:** O

**Fabrizio Paganelli:** metti ho creato i codici prodotto nuovi. iniziano hanno il codice che inizia con il nome dell'evento tipo AC Academy PLP Live.

**Aurel mrruku:** Так. Yeah.

  
  

### **01:01:03**

  

**Fabrizio Paganelli:** Questo rimane uguale che qua non potemmo mettere uno sconto. Ah, sì. No, e rimane uguale perché hai la stessa quantità. Prova a mettere quantità due perché se cambi il porto netto No, io pensavo che passo fasse lo sconto, non in in percentuale, ma in valutura. Eh, ma tu puoi, una volta che tu hai inserito le quantità tu puoi sia gestire lo sconto e ti cambi di conseguenza quello. Non ho capito. Però se io qui pensavo che qui mi potesse dare il lo sconto del valore, invece non è lo sconto del valore perché no perché quello è il prezzo unitario netto dello sconto. Prezo unitario netto dello sconto. Cosa? Lo sconto in valore non c'è la fila, però dopo vedo. Sul singolo. Ci puoi mettere Aurel un campo lì di fianco in portonetto dove ci scrivi sconto totale?

**Aurel mrruku:** Ma è sconto totale di quella

**Fabrizio Paganelli:** Mac

**Aurel mrruku:** riga. Vedi che c'è lo sconto la prima

**Fabrizio Paganelli:** la questo in percentuale, però non è a valore.

  
  

### **01:02:44**

  

**Aurel mrruku:** capendo.

**Fabrizio Paganelli:** No, perché lì c'è lo sconto in percentuale sulla riga e poi c'è il prezzo netto che però è il prezzo netto unitario al netto dello sconto.

**Aurel mrruku:** Sì. Ok.

**Fabrizio Paganelli:** Ok. Poi dopo c'è che il prezzo netto unitario lì qui, Aurel, guarda, lo vedo detto,

**Aurel mrruku:** per quantità un attimo.

**Fabrizio Paganelli:** c'è c'è c'è scritto prezzo neto con una T solo,

**Aurel mrruku:** Ok, ha visto.

**Fabrizio Paganelli:** eh.

**Aurel mrruku:** Se vedi che non sono italiano.

**Fabrizio Paganelli:** E e sulla riga, tipo, ad esempio, qui c'è il prezzo di listino che è 4,29, no? Il prezzo netto che ha imposto la l'Elisa è 3,50, quindi vuol dire che su un su una su una quantità uno lo sconto è di €79,

**Aurel mrruku:** Beh,

**Fabrizio Paganelli:** ma su due

**Aurel mrruku:** c'è c'è anche il prezzo di listino, quello è l'idea. Allora, si può mettere tutto, ma stiamo già caricando troppa roba in una schermata. E si può fare, non è un problema,

**Fabrizio Paganelli:** Vabbè,

**Aurel mrruku:** perché io ce l'ho il valore. Vedi?

**Fabrizio Paganelli:** vedi dopo io e perché poi dopo quando tu stampi.

  
  

### **01:03:48**

  

**Aurel mrruku:** C'è il prezzo del listino e c'è anche il prezzo neto.

**Fabrizio Paganelli:** Io ho capito che c'è la fine, però secondo me è giusto che ci sia la riga sui corsi. Vediamo eh pian piano, però è una cosa che io avevo detto già dall'inizio. L'avevamo detto sempre questa cosa qui dall'inizio, però dopo Aurel dice mettere tutti sti campi nella schermata di inserimento diventa complicato. Io lo so, però la percezione del cliente a sommativa a preventivo, quindi quello sconto totale che si vede o a riga prodotto è diverso. L'atto cliente è diverso.

**Aurel mrruku:** Ma non hai non è questo,

**Fabrizio Paganelli:** Gior cliente devi guardare preventivo.

**Aurel mrruku:** non è il preventivo questo.

**Fabrizio Paganelli:** Va bene, dai. Dato che lì lì devi questo qui Elisa. Sì, ma io lo so, ma io conosco i preventivi. I previ preventivi clienti, però va bene, vediamo. Ah, è vero. Se vuoi non lo faccio più, quindi non niente. No, Elisa. E e quella maschera lì Aurel l'ha fatta così perché

**Aurel mrruku:** Eh

  
  

### **01:04:52**

  

**Fabrizio Paganelli:** è una maschera di input da parte di uno commerciale. Il cliente chiaramente quella maschera lì non la vedrà. Adesso prova a vedere il preventivo, come uscirà l'atto cliente, se secondo te il cliente lo capisce bene oppure no.

**Aurel mrruku:** l'hai a destra dove ci sono i file? Vedi, c'è il sconto totale là a liv nel valore

**Fabrizio Paganelli:** Proviamo a aprirlo. L'ho già aperto. L'ho già aperto. No, no, non lo volevo lo volevo vedere anch'io. M. Ecco qui, ad esempio, non abbiamo gestito le tranche, vedi? Obbligatorie come camp le tranche Aurel non sono obbligatorie,

**Aurel mrruku:** No,

**Fabrizio Paganelli:** vero?

**Aurel mrruku:** no, avevamo detto che puoi fare anche preventivi senza tranch. Ovviamente poi deve essere pagato tutto per mettere i biglietti disponibili.

**Fabrizio Paganelli:** tutti una volta deve essere pagato perché dopo qui il rischio qual è? Che i tutor che sono degli smanati prendono, fanno fanno un ordine tipo questo, buttano dentro, lo mandano al cliente e si dimenticano di metterci qui le tranche. Vedi che in questo qui scadenza di pagamento è nulla.

  
  

### **01:06:45**

  

**Fabrizio Paganelli:** Se no io mettere obbligatorio, se noi lo rendiamo campo obbligatorio e ha ragione l'Elisa, che tipi di problemi possiamo incorrere?

**Aurel mrruku:** Dobbiamo cambiare un attimo UI quando tu inserisci i prodotti sugli ordini sui preventivi, scusa, sull'offerta praticamente.

**Fabrizio Paganelli:** Mh. Perché nelle vendite da palco il problema non si pone che lo creiamo, no? Bisogna crearlo apposta, però qui glielo metterei.

**Aurel mrruku:** Oppure forse quando generiamo il preventivo possiamo fare un check. Se non hai le trunche non puoi generare il preventivo, così li costringi a fare le trance.

**Fabrizio Paganelli:** Se ti è più facile, sì, va bene lo stesso.

**Aurel mrruku:** Eh, vai un attimo indietro, fai gestisci i prodotti, tipo, eh, aggiungi un prodotto o togli un prodotto a piacere.

**Fabrizio Paganelli:** Uno.

**Aurel mrruku:** Sì. O metti o togli. Vai. Oh,

**Fabrizio Paganelli:** Scusa, sei c\*\*\*\* come si toglie, scusa?

**Aurel mrruku:** non c'è il cestino là in alto.

**Fabrizio Paganelli:** No, almeno io non lo vedo. No,

**Aurel mrruku:** No,

**Fabrizio Paganelli:** non c'è.

**Aurel mrruku:** non c'è. Forse l'ho lasciato solo su. Benissimo. Plus aggiungi un prodotto, poi la lo gestisco io.

  
  

### **01:08:13**

  

**Aurel mrruku:** Forse c'è in ambiente DAT, non mi ricordo, ma avevo messo il un'iconicina di cestino là. Lo fai? Scegli. Ok. Eh, l'ho messo solo qua. Ok. Lo devo mettere anche nella schermata. L'altra schermata. Ok, salva. Deve andare in bozza. Vedi che c'è create tranch in alto a destra,

**Fabrizio Paganelli:** Non lo vedo.

**Aurel mrruku:** in alto a destra dove c'è genera PDF c'è anche G trans.

**Fabrizio Paganelli:** Sì.

**Aurel mrruku:** Quindi quello che posso fare io è, nel momento in cui tu non hai un una tranche non puoi generare il PD

**Fabrizio Paganelli:** Cioè, se manca la data di scadenza su almeno una riga non si può generare PDR, cioè le No,

**Aurel mrruku:** è un po' forte come

**Fabrizio Paganelli:** no, ma deve essere così Aurel, perché sennò ci fa morire gonfi. Le tranche le mettono, le devono mettere dappertutto perché dopo noi dobbiamo sapere che cosa dobbiamo fatturare.

**Aurel mrruku:** Ok, ok, siete voi. cliente. Quindi decisione vostra. Per me non cambia niente. Basta che faccia un controllo che non puoi generare il PDF.

  
  

### **01:09:36**

  

**Aurel mrruku:** Abbiamo già risolto.

**Fabrizio Paganelli:** Sì, direi di sì.

**Aurel mrruku:** Devo mettere la stessa iconcina anche sui prodotti. Quando scegli i prodotti.

**Fabrizio Paganelli:** Ti devo scrivere questa cosa. Te la ricordi?

**Aurel mrruku:** Sto già facendo, sto già tracciando tutto.

**Fabrizio Paganelli:** Yeah.

**Aurel mrruku:** Allora, tranch obbligatorio. Ok, tracciatto tutto. Procedi pure. Quindi c'era PDF. Anzi, ti posso chiedere un'altra cortesia.

**Fabrizio Paganelli:** M.

**Aurel mrruku:** Fai scegli il locale, non hai nessun locale. Vai sull'account, ce l'hai là? Sì, premi là. Eh, non c'è nessun account figlio. Vai un attimo su correllato. In teoria non c'è nessuno perché l'ha creato Fabrizio questo, se non mi sbaglio. Opportunità ordini asset e non c'è nessuno.

**Fabrizio Paganelli:** No, lo creo.

**Aurel mrruku:** Crea crea un devi creare un account, quindi vai sui account, forse ti metto un pulsante direttamente sull'account padre di creare il locale, quindi premi sugli account sulla sul Sì,

**Fabrizio Paganelli:** Faccio un nuovo account. No,

**Aurel mrruku:** fai il nuovo account, però il nuovo account deve essere un locale.

  
  

### **01:12:55**

  

**Aurel mrruku:** Ok,

**Fabrizio Paganelli:** faccio l'italicale

**Aurel mrruku:** perfetto. Sì. Eh, qua devi mettere nome locale.

**Fabrizio Paganelli:** testimo. Ah,

**Aurel mrruku:** Sì.

**Fabrizio Paganelli:** beh, no, giuppo. M.

**Aurel mrruku:** test. Sì, come vuoi. So città deve essere praticamente l'account test pienissimo, usa il primo. Eh, poi sono i campi che abbiamo scelto.

**Fabrizio Paganelli:** Perfetto.

**Aurel mrruku:** Tipologia attività molto importante perché poi sono puoi scegliere più di uno. Quindi se se premi e premi sulla freccetta c'è una freccetta

**Fabrizio Paganelli:** Ah,

**Aurel mrruku:** a destra,

**Fabrizio Paganelli:** ok.

**Aurel mrruku:** ok? Quindi poi sceglie più di una. Abbiamo fatto in modo che puoi scegliere Nutto poi viene ribaltato sull'offerta.

**Fabrizio Paganelli:** Ok. Email. Eh.

**Aurel mrruku:** Ma sono non sono campi obbligatori,

**Fabrizio Paganelli:** Ah, sono della gente.

**Aurel mrruku:** però se E Sì,

**Fabrizio Paganelli:** Ok. No, salva.

**Aurel mrruku:** salva. Adesso crea un nuovo preventivo con questo con l'account padre, quindi società correlata.

**Fabrizio Paganelli:** Quindi, eh.

**Aurel mrruku:** Società non col locale quello,

**Fabrizio Paganelli:** Ok.

  
  

### **01:14:14**

  

**Aurel mrruku:** anzi lo dovevo togliere quello giusto per devi premere su società correllata. Test i preventivi si devono creare solo sulle aziende. Nuova opportunità vendita standard. Va bene, scrivi test locale. Salva. E adesso fai nuovo preventivo a sinistra. Ti ho metto di pagamento a piacere. fa salva M aspetta,

**Fabrizio Paganelli:** No,

**Aurel mrruku:** non hai finito. Chiudi, fai scegli il locale in alto a destra e qua deve comparire il nome di locale test.

**Fabrizio Paganelli:** ok. Ma scusa, eh, Aurel, quindi io non posso eventualmente creare, visto che sarà l'opportunità, eh l'opportunità già dal locale?

**Aurel mrruku:** In teoria sì, lo possiamo fare, non cambia niente perché si collega al padre. Basta che premi sul bottone là che c'era sul locale e in teoria deve funzionare allo stesso

**Fabrizio Paganelli:** Esatto.

**Aurel mrruku:** modo.

**Fabrizio Paganelli:** Ok. Ok.

**Aurel mrruku:** Sì,

**Fabrizio Paganelli:** Quindi erano formalità,

**Aurel mrruku:** quindi ho detto di volevo farti un test com'era partendo dal dal

**Fabrizio Paganelli:** siamo

**Aurel mrruku:** padre, però facciamo anche un già che ci siamo.

  
  

### **01:15:42**

  

**Aurel mrruku:** Procedi pure. Fai usa questo locale. Clicca. No, devi cliccare. Sì, fai uso questo locale e in automatico vedi che tipologia attività e

**Fabrizio Paganelli:** dei correlati.

**Aurel mrruku:** agriturismo No, ce l'hai già su tipologia attività in più a destra dove c'è il mouse più a destra

**Fabrizio Paganelli:** Ah, ok.

**Aurel mrruku:** là. Quindi lo prendi in automatico la tipologia perché avevi scelto il locale.

**Fabrizio Paganelli:** e anche il nome

**Aurel mrruku:** A sto punto vai Sì, vai. Clicca di nuovo su nome locale test. sul locale. Premi sul locale.

**Fabrizio Paganelli:** qui.

**Aurel mrruku:** Sì,

**Fabrizio Paganelli:** Sì.

**Aurel mrruku:** così atterrizzi. Fai nuova opportunità. Ok, fai salva. Si crea l'opportunità, però se Verdi si collega col parent in automatico.

**Fabrizio Paganelli:** Eh,

**Aurel mrruku:** Le opportunità si Sì.

**Fabrizio Paganelli:** cioè in realtà alla fine è lo stesso circuito nel caso in cui, esempio, se io lo faccio dall'account creo l'opportunity, poi l'opportunity creo il preventivo, l'associo alla al nome loc al locale e come crearlo direttamente dal locale.

**Aurel mrruku:** è la stessa cosa,

  
  

### **01:16:58**

  

**Fabrizio Paganelli:** E certo.

**Aurel mrruku:** solo che sono due punti diversi di creazione delle opportunità praticamente. Quindi se adesso fai nuovo preventivo,

**Fabrizio Paganelli:** E in che Ok, quello faccio uguale. Faccio così.

**Aurel mrruku:** vedi che c'è già il locale associato a questa questo?

**Fabrizio Paganelli:** Eh, esatto. Cioè, è una via diversa, ma al fine è uguale.

**Aurel mrruku:** Sì, sì, sì.

**Fabrizio Paganelli:** Ok, perfetto.

**Aurel mrruku:** Ok. A sto punto aggiungi dei prodotti, crea il genere preventivo e facciamo scendere loren.

**Fabrizio Paganelli:** Cosa preferisci? Cosa vuoi?

**Aurel mrruku:** Basta che metti dei prodotti che hanno dei biglietti e metti quantità tipo quattro a ciascuno,

**Fabrizio Paganelli:** Ok.

**Aurel mrruku:** così esageriamo un po'.

**Fabrizio Paganelli:** All Ok,

**Aurel mrruku:** Ma fa niente sui prezzi non mi interessano i prezzi per il momento.

**Fabrizio Paganelli:** volevo essere precisa.

**Aurel mrruku:** Ma mi servono questi biglietti perché quando faremo i test con marketing domani siano dei dati reali,

**Fabrizio Paganelli:** Ma saapo sali questa col di domani?

**Aurel mrruku:** no? Eh, siamo solo io,

**Fabrizio Paganelli:** Ah,

**Aurel mrruku:** Fabrizio e Elena che non abbiamo mai fatto un test in produzione reale perché non

  
  

### **01:18:51**

  

**Fabrizio Paganelli:** ok. Non so.

**Aurel mrruku:** non abbiamo usato a creare degli ordini in produzione per questo.

**Fabrizio Paganelli:** Comunque io la data a prescindere quando ci siamo detti che io dovevo mettere la data, non la devo mettere qua, ma su quando faccio genera tranche,

**Aurel mrruku:** E quindi qua tu salvi.

**Fabrizio Paganelli:** ok? Salgo e poi vado

**Aurel mrruku:** Io farò in modo che tu non puoi fare genere a PDF qua se non hai una trunch.

**Fabrizio Paganelli:** creato le tradition.

**Aurel mrruku:** Sì,

**Fabrizio Paganelli:** Ok,

**Aurel mrruku:** quindi crea tranch.

**Fabrizio Paganelli:** perfetto.

**Aurel mrruku:** Perfetto. Poi vi aggiusto anche il cestino su quando metti il coso e cerco di farvi forse due colone un po' più ampia, quindi non dovete fare quel scroll interno. E se avete tempo date un'occhiata a questo preventivo e fateci sapere se ci sono dei cambiamenti da fare.

**Fabrizio Paganelli:** sulla visualizzazione di questo internet.

**Aurel mrruku:** Sì, sì, sì, sì,

**Fabrizio Paganelli:** Ok.

**Aurel mrruku:** sì.

**Fabrizio Paganelli:** No,

**Aurel mrruku:** Ma anche al testo sopra, perché l'abbiamo praticamente copiato quello che era stato passato.

**Fabrizio Paganelli:** dall'altro.

  
  

### **01:20:35**

  

**Aurel mrruku:** Sì,

**Fabrizio Paganelli:** Sì.

**Aurel mrruku:** sì. Ok, adesso invia per recettazione. In alto a destra c'è un pulsante in alto

**Fabrizio Paganelli:** Questo no.

**Aurel mrruku:** dove c'era genera PDF. Adesso non c'hai più genere PDF. Invio. Accettazione.

**Fabrizio Paganelli:** Ok.

**Aurel mrruku:** Sì, aspetta. Fabrizio, va, Fabrizio, metti la tua. Allora,

**Fabrizio Paganelli:** Ah, ma ho il telefono.

**Aurel mrruku:** il documento andrà al contatto principale. Il contatto principale sarà Ah,

**Fabrizio Paganelli:** Sì, sì, ma ho il computer di Fabria,

**Aurel mrruku:** ok,

**Fabrizio Paganelli:** quindi va bene.

**Aurel mrruku:** ok, lascia quello. Invia mail. Allora, perché se vuoi fare un un test con il tuo contatto, devi creare un contatto sull'account, metterlo come contatto principale e metti la tua mail là,

**Fabrizio Paganelli:** Ok, chiaro.

**Aurel mrruku:** quindi in automatico prende la mail tua.

**Fabrizio Paganelli:** Abbiam detto che in CC si ci può mettere chiunque, vero?

**Aurel mrruku:** Sì,

**Fabrizio Paganelli:** L'abbiamo già aggiunto come campo.

**Aurel mrruku:** sì, sì, sì,

**Fabrizio Paganelli:** Ok,

**Aurel mrruku:** sì. Bello cicciotto sto preventivo.

  
  

### **01:21:38**

  

**Fabrizio Paganelli:** bello, evidente. Mutuo. Conferma.

**Aurel mrruku:** Ok,

**Fabrizio Paganelli:** Ora mi è mi è arrivata di nuovo una me. Ah, abbiamo messo il pop-up, vero?

**Aurel mrruku:** non ho capito.

**Fabrizio Paganelli:** No, perché in realtà lo diceva Saba. Eh, lo diceva,

**Aurel mrruku:** Era su sulla rinuncia il popup.

**Fabrizio Paganelli:** no, era anche, ma penso che non so se poi le era stato reso nota questa cosa, perché qua al cliente arrivano due mail di fila consecutive, perché arriva questa è la citazione di conferma e subito dopo, appena noi confermiamo gli arriva l'altra mail.

**Aurel mrruku:** Sì.

**Fabrizio Paganelli:** E quindi Saba fa può essere che il cliente in questi pochi secondi, essendo che sono due schermate diverse, ma anche proprio a livello m di visuale, quando guardi il telefono proprio apri due schermate di tipologie diverse, magari qualcuno non c'ha l'avviso di email, quindi loro aprono questa schermata, confermano e poi non sanno, non vedono che gli è arrivata un'altra perché sono già all'interno delle mail. Non so se mi sono spiegata bene.

**Aurel mrruku:** Sì, ma questo non è lo la stessa fonte, capito?

  
  

### **01:22:56**

  

**Fabrizio Paganelli:** Vabbè,

**Aurel mrruku:** una tramite Dokusin

**Fabrizio Paganelli:** perché tanto qua su una pagina su

**Aurel mrruku:** non è lo st la stessa fonte, una Dokusan, l'altra è Sales Force.

**Fabrizio Paganelli:** No, sì, però lui diceva, "Se io sto aprendo questa, eh, apro questa e non mi accorgo che mi sia arrivata un'altra mail per però in realtà,

**Aurel mrruku:** Non ci puoi fare niente,

**Fabrizio Paganelli:** cioè, a meno che lui non abbia le notifiche,

**Aurel mrruku:** sono mail.

**Fabrizio Paganelli:** appunto, che quindi ha senso e poi comunque scritto qui.

**Aurel mrruku:** Sì, sono processi completamente separati, capito? Non hai controllo della seconda mail. Poi la seconda mail può arriva anche dopo due giorni.

**Fabrizio Paganelli:** Ah, sì, vbè, dipende quando accetti.

**Aurel mrruku:** Sì, sì.

**Fabrizio Paganelli:** Ok. No, no, non tiare proprio FP FP che dopo mi mandi la fattura, mi mandi te addirittura Fabrizio Paganelli così sputoratamente,

**Aurel mrruku:** Eh sì,

**Fabrizio Paganelli:** guarda che bel preventivo che abbiam fatto. Hai visto? Ha detto che serve un mutuo. Manco una macchina qua, però basta.

**Aurel mrruku:** stimmagine se poi diment Qua,

  
  

### **01:24:24**

  

**Fabrizio Paganelli:** Salvo la copia.

**Aurel mrruku:** ma lascia stare.

**Fabrizio Paganelli:** Ok,

**Aurel mrruku:** Ma sono da Sanch l'utenza. Io non lo farei.

**Fabrizio Paganelli:** quindi ora io refresh tutto.

**Aurel mrruku:** Deve essere infermata. E se siamo fortunati l'ordine è sceso.

**Fabrizio Paganelli:** Inaccettato.

**Aurel mrruku:** Vai su soccorrellato. No, non è questo. Era l'altro. Ero infilmato. Non era questo.

**Fabrizio Paganelli:** Era questo?

**Aurel mrruku:** Non era questo,

**Fabrizio Paganelli:** Sì, sì.

**Aurel mrruku:** penso.

**Fabrizio Paganelli:** A master €34.000. Cinque master hai venduto, buono. Ti mando di là. No, in amministrazione ordinato.

**Aurel mrruku:** Ah, ok. Allora, vai, vai un po' su, fai un refresh. Fai un refresh. Ah, c'è già, scusa,

**Fabrizio Paganelli:** Eh, sì, sì.

**Aurel mrruku:** era infirmato, vero? Ok,

**Fabrizio Paganelli:** inordinato.

**Aurel mrruku:** vai sull'ordine, c'è sotto, clicca sull'ordine, non basta che premi sul numero d'ordine là e il PC di Fabrizio che non so cosa ha fatto colpice.

**Fabrizio Paganelli:** No, no, è sposale

**Aurel mrruku:** Non non mi è mai successo. Quattro ragazzi qua che hanno provato con diversi browser.

  
  

### **01:25:36**

  

**Fabrizio Paganelli:** mi dovrebbe aprire.

**Aurel mrruku:** Non ho

**Fabrizio Paganelli:** Apri il link in un'altra scheda. Facci non va. No,

**Aurel mrruku:** Sì, sì,

**Fabrizio Paganelli:** non so perché non ho nulla più che par

**Aurel mrruku:** l'ha già fatto. Non va. Non so. e hai creato l'ordine 59 58. Quindi se riesci a fatturare tutto,

**Fabrizio Paganelli:** devo fatturare Fabriz fattura. Ah, dis dopo le noi le cancelliamo subito queste fatture,

**Aurel mrruku:** devi fatturare, io li prendo e poi li puoi cancellare.

**Fabrizio Paganelli:** ok? Eh no. Ah, èissimo. Io avevo già fatto il quattro. Hai fatto il quattro? Eh, non è grave. Tanto dobbiamo modificare i numeratori tutto. Ok.

**Aurel mrruku:** Cosa hai fatto, Fabrizio? Non ho capito.

**Fabrizio Paganelli:** No, no, niente, è solo sono i bisticci che facciamo i riso devo mettere i dati seri. Eh, no, no, io prima fatto caso. No, no, questa è una fattura vera che dopo dobbiamo andare a eliminare. Ma non hai cambiato da qua?

  
  

### **01:26:58**

  

**Fabrizio Paganelli:** No, no, vai. Vai, vai, vai avanti. Ah, è 20 era giusto, eh. Rid 20 però era giusto, era quello che l'azienda ha scelto nell'ordine. Io io lo cambio. Comandi lo incasso anche.

**Aurel mrruku:** Sì, per forza.

**Fabrizio Paganelli:** Posso metter? Ah, che sto vedendo. Ok, questo giustamente ci mette un po' ad aggiornarsi.

**Aurel mrruku:** No,

**Fabrizio Paganelli:** No. Ah, no.

**Aurel mrruku:** faccio io.

**Fabrizio Paganelli:** Ah, vai qua nella rotellina,

**Aurel mrruku:** Sì. Ah,

**Fabrizio Paganelli:** giusto?

**Aurel mrruku:** ce l'hai te il coso? Lo script? Ce l'hai da qualche parte?

**Fabrizio Paganelli:** Eh, sì.

**Aurel mrruku:** Puoi farlo.

**Fabrizio Paganelli:** Dov'è che era Fabri? Ti aveva dato solo quello per trasmettere le fatture, non incassi. Ah, solo quello delle fatture ci avevi dato,

**Aurel mrruku:** Tutte e due.

**Fabrizio Paganelli:** non degli incassi. No,

**Aurel mrruku:** Tutte e due.

**Fabrizio Paganelli:** il tassi noone.

**Aurel mrruku:** Tutte e due. Fidati. Sì, perché io quando faccio gli incassi e le faccio prima le fatture, poi incassi sempre allo stesso momento,

  
  

### **01:28:38**

  

**Fabrizio Paganelli:** Vabbè,

**Aurel mrruku:** quindi

**Fabrizio Paganelli:** rido, per favore, quello degli incassi. Allora, facciamo così. Dov'è l'altro?

**Aurel mrruku:** quel pezzo di codice che ho dato vale per tutte e due

**Fabrizio Paganelli:** Ah, vale per tutti e due.

**Aurel mrruku:** perché io sempre faccio fattura e incasso perché non puoi fare un incasso senza fare prima la fattura.

**Fabrizio Paganelli:** Sei sport.

**Aurel mrruku:** Ma faccio io non fa niente, eh.

**Fabrizio Paganelli:** Vai un dato model. No, però andare lì. Sì, perché non la caccetta. Avevo salvato da qualche parte. Sì, no, no, magari rimandaccelo via mail Aurel quel linkista.

**Aurel mrruku:** Un attimo. Ok. Ok. Un attimo che faccio un po' Ok.

**Fabrizio Paganelli:** No, no, no, non sono casinista.

**Aurel mrruku:** Okej.

**Fabrizio Paganelli:** Io trovo tutto nel mio robote. È questo? No, no. Perché non lo trovi? Perché adesso sono un elemento disturbatore alla mia postazione. Oddio. Aurel, se vi serve qualcuno fate un fischio. Vengo io così tolgo il disturbo all'Elisa.

  
  

### **01:30:19**

  

**Fabrizio Paganelli:** Sono un po' anziano, mi volete lo stesso?

**Aurel mrruku:** Vabbè, c'entra niente l'età.

**Fabrizio Paganelli:** Oh, questo mira in cuore. Dai,

**Aurel mrruku:** ci mette quei 2 minuti

**Fabrizio Paganelli:** adesso parlo parlo con l'E. Mandiamo il CV a lei. Mandiamo il CV all'Elena. Ci blocca come la fattura.

**Aurel mrruku:** e la fattura pure.

**Fabrizio Paganelli:** Prima di tutto alleghiamo tre file. M.

**Aurel mrruku:** Allora, eh vado un attimo in UAT che molto probalmente ce l'ho in UT. quel script.

**Fabrizio Paganelli:** Ochio per farlo e cosa succede? lazione.

**Aurel mrruku:** che non c'è. Ok, puoi puoi controllare per cortesia. Ha finito.

**Fabrizio Paganelli:** Scusa

**Aurel mrruku:** E vai su l'ordine e vai sulle fatture. È già incassato. Vedo che è incassato.

**Fabrizio Paganelli:** pagato.

**Aurel mrruku:** Perfetto. Ed vedi che è già incassato. Se vai sulla scadenza fatture deve essere anche quello perfetto,

**Fabrizio Paganelli:** pagato.

**Aurel mrruku:** pagato.

**Fabrizio Paganelli:** Ottimo.

**Aurel mrruku:** E vai sugli asset per vedere che se sono diventati disponibili. Perfetto.

  
  

### **01:32:56**

  

**Fabrizio Paganelli:** Disponibili.

**Aurel mrruku:** Una meraviglia.

**Fabrizio Paganelli:** Ottimo.

**Aurel mrruku:** Yeah. Ci siamo. Eh, per me direi che è tutto.

**Fabrizio Paganelli:** Va bene.

**Aurel mrruku:** Vi devo fare quei aggiustamenti su le tranche. Cerco di farvi una vista diversa quando aggiungete gli item, quindi i prodotti, così non dovete fare quel scroll. Cerco di capire io una soluzione là. Eh, aspetto i vostri dati,

**Fabrizio Paganelli:** Sì,

**Aurel mrruku:** quindi account,

**Fabrizio Paganelli:** per

**Aurel mrruku:** ordini, eh contati, poi Sabatino che che ha deciso con quei contatti che non ho visto niente.

**Fabrizio Paganelli:** che c'è qualcosa? Io non so niente, anche perché stamattina trò che ieri No, ieri era in fieri e lunedì eravamo via, eravamo in più era,

**Aurel mrruku:** Eh,

**Fabrizio Paganelli:** quindi proviamo a Sì,

**Aurel mrruku:** mi servono quei contatti,

**Fabrizio Paganelli:** sì,

**Aurel mrruku:** eh.

**Fabrizio Paganelli:** proviamo a sentirlo. Aurel,

**Aurel mrruku:** Ok, grazie. Se riuscite a I contatti,

**Fabrizio Paganelli:** i contatti che Sì, sì.

**Aurel mrruku:** i lead li ha passati,

**Fabrizio Paganelli:** Contatti servono. Allora,

**Aurel mrruku:** i contati però no.

  
  

### **01:34:02**

  

**Aurel mrruku:** I contatti principali che si collegano ai account gli ho chiesto di mettere il riferimento di Maxile sui contati, se vi ricordate.

**Fabrizio Paganelli:** sì, sì, sì.

**Aurel mrruku:** Ok.

**Fabrizio Paganelli:** Eh, va bene. Ah, poi Aurel, non so, ma io parteciperei alla riunione che abbiamo prestabilito per anche il commerciale mercoledì 11.

**Aurel mrruku:** Allora, vedo un attimo che come sta

**Fabrizio Paganelli:** L'abo che l'abbia inviata Elena.

**Aurel mrruku:** non so cosa fa. Venerdì 11,

**Fabrizio Paganelli:** Mercoledì 11.

**Aurel mrruku:** mercoledì 11. Eh, non c'ho nessuna riunione io.

**Fabrizio Paganelli:** Forse allora sta aspettando l'ok da Marco perché Ok,

**Aurel mrruku:** La la sento che c'ho una call con lei alle 5 oggi,

**Fabrizio Paganelli:** va bene.

**Aurel mrruku:** quindi sì.

**Fabrizio Paganelli:** I contatti ti servono?

**Aurel mrruku:** i contatti che mi dov mi deve passare il Sabatino e i contatti devono avere il codice Maxal posto dell'ID dell'account, quindi ID maxal sulla colonna account,

**Fabrizio Paganelli:** Quello lì però gliel'avevo fatto io l'altra volta.

**Aurel mrruku:** non i lead,

**Fabrizio Paganelli:** No,

**Aurel mrruku:** i contatti,

**Fabrizio Paganelli:** no,

**Aurel mrruku:** i referenti.

**Fabrizio Paganelli:** i referenti sarebbero giusto che l'avevo fatto io sabato unaltra

  
  

### **01:35:22**

  

**Aurel mrruku:** Sì, sì, sì. I referenti.

**Fabrizio Paganelli:** volta. Vedo di darteli io. Dai.

**Aurel mrruku:** Ok, grazie.

**Fabrizio Paganelli:** Ciao ciao ciao ciao

**Aurel mrruku:** Ciao. Ciao. Buona serata.

**Fabrizio Paganelli:** ciao. Ci sollecitano i contatti barra preferenti. Dov'è che li aveva presi lui l'altra volta? luglio ben presi da Z. Abbiam fatto zom 360. Ah, giusto. La graffica. Adesso fumare. Cos'è che ti ha detto? Cos'è? Ah, io guarda, ti faccio vedere la chat senza nessun problema. A parte che non si capisce un c\*\*\*\*, eh. Ma qui si capisce. Scusami state 360 parte degli insoluti, ma ho bisogno di capire se davvero abbiamo 298.000 di qui non si capisce su un c\*\*\*\*. Questo qui gliato Salvatino, chissà come. Sì, Fabri. Ciao. Ma scusa, ma poi il file che gli avevamo mandato noi non era quello che ci chiedevano loro? Sì, ma avvo bisogno di ricaricare tutto nell'ambiente di produzione, quindi tu mi dovresti ridare un aggiornamento, poi dopo io di fianco gli caccio il codice di di codice cliente e poi glielo passo.

  
  

### **01:38:58**

  

**Fabrizio Paganelli:** quello lavoro link ci dobbiamo dare aggiornato. Sì, perché stanno car perché noi quando l'abbiamo fatto gli hanno caricato tutto nell'ambiente di test. Adesso dobbiamo ricaricare tutto nell'ambiente di produzione, quindi partendo sempre da da come è settato quel file che abbiamo mandato settimana scorsa, dobbiamo rifare lo stesso lavoro affinché lo carichino in produzione. Io sono a di cosa poi domand non riesci a darmi un file dopo ci penso io. ci sono con i clienti qui, cioè ora mi sono stancato un attimo perché Daniela mi ha chiamato per dirmi di rispondersi. Gli gli diamo lo stesso file, poi dopo glielo dobbiamo riaggiornare la settimana prossima. Eh ah, glielo riaggiorneremo. Infatti io tanto alla fine eh posso provare a vedere. Vabbè, te inizia a dargli quello, poi glielhoamo aggiornato perché adesso lui sta facendo un primo caricamento, dopo lo dovrà rifare, quindi io adesso gli possiamo dare anche quelli quanto potrà essere vecchio quello quanto, non lo so quello lì di che data è quel quello che hai fatto te che avevamo fatto l'altra volta era del 27 o 28 ottobre se non ricordo male.

  
  

### **01:40:27**

  

**Fabrizio Paganelli:** 7 otto sopra, quindi di base sono meno due settimane in più. Era del 19 di Sì, 28 ottobre. Otto, quindi in pratica una settimana in più abbiamo di contatti. Sì, dopo, ripeto, dopo tu bisogna che la settimana prossima ti tieni libero perché il 12 e il 13 dobbiamo ricaricare di nuovo tutto, quindi Sì, infatti io il il lunedì non ci sono, ma martedì e mercoledì sono in ufficio, quei due giorni vengo direttamente in amministrazione, si lì e lavoriamo tutti i giorni a San Robot. Però è il 12 e il 13 che noi stacchiamo tutti i bottoni e loro fanno le importazioni, capito? Lovedì venerdì loro fa fanno tutto. Noi martedì io martedì mercoledì sono full su sta roba, ma considerate che io dal mio lato c'ho anche benissimo 360, devo portarmi tutte le opportunity, tutte le robe. A proposito di Pianissimo 360, m'ha girato un una foto alla Daniela dove c'è una pagina con un insoluto da €280.000. Ma tu da dove li hai presi quei numeri? Eh sì, da €280.000. Non lo so.

  
  

### **01:41:37**

  

**Fabrizio Paganelli:** La la la Daniela m'ha girato una foto eh di una pagina eh dove praticamente ci sono €280.000 di insoluti, che è un numero così buttato lì a caso. Volevo capire da dove l'hai preso. c\*\*\*\* di là, forse. Ah, non lo so. La immagino che l'avrei fatta. Tu l' bo l'avrà presa, vediamo. L'avrà presa da Cioè perché se te dai un robo dove praticamente la alla direzione vede €280.000 e invece è un dato che non è veritiero e non è corretto, cioè dopo creiamo dei casini. Eh no, ma te stai tranquillissimo. No, no, ma io, guarda, io io sono tranquillo, tanto è vero che a me la Daniela m'ha chiamato e m'ha detto "Guarda, ma è vero sto numero?" Ho detto no, non è assolutamente vero quel numero lì. Non so che criterio si fatto, da dove l'hai preso, dove non l'ha preso. Ma non preso da nessuna parte, perché io sto guardando ora, non c'è da nessuna parte quel numero. Allora, ti mando la schermata, guarda, così la schermata.

  
  

### **01:42:41**

  

**Fabrizio Paganelli:** Vai che Vabbè, comunque Fabio, io ho bisogno che qualcuno su sta roba dei contatti mi dà una mano. Non posso fa tutto da solo. Lo dice, no? Lo dice a me. Lo dice a me, l'Elisa? No, a te no. Però tocca che qualcuno mi aiuti, perché io quei due giorni c'ho e quei due giorni so. Se vuoi t'iuto io se vuoi. Eh, guarda mo, guarda, te l'ho appena mandata. Guarda mo questa schermata su WhatsApp. Sì, hai mandato a me. Eh, certo. Questo è il problema vostro, non mio. È la sezione che avete che mi avete fatto voi di Eh, ma perché è visibile a tutti? Allora, è visibile la direzione? No, ma questa qui era un test. Allora, adesso ho capito. Questo qui era il test che avevamo fatto per l'invio. Gli va va detto, gli va detto, gli va detto. Eh, vabbè, allora gli va detto, anzi, faccio una cosa. Se se è un test, non ce l'avete ancora in produzione che funziona, eh a sto punto questa la vedete solo voi.

  
  

### **01:43:51**

  

**Fabrizio Paganelli:** Sì, quella lì non la deve vedere nessuno, a parte noi, fintanto che non diventa una cosa che è che poi, guarda, neanche questa qui dobbiamo vedere solo noi lo dovremmo vedere perché è la nuova procedura che dovremmo mandere per mandar via gli soluti ai clienti. Ok, allora gliela nasconda, Daniele. Eh no, no, no, glielo dico io. No, è meglio che glielo dico io. Ce l'ho qui. Gli spiega a che serve. No, no, adesso gli secondo me m'ha scritto me, gli rispondo io. Dici "Guarda, quella sezione lì è ancora in testa." Ma se ci stiamo lavorando io non ti preoccupare. No, mi preoccupo, mi preoccupo perché già mi hanno detto che sei andato in crisi l'altra volta. Chi? Tu quando? Signore m'ha detto che sei andato in crisi sulla questione dei dati delle droga. ha detto che andavo No, io sono andato in crisi. Allora, eh cosa vuol dire? Sono andato in crisi tu vai via, tu vai via. Mi dicono a me che devo mettere i dati sulla 360. Io alla Daniela glio.

  
  

### **01:44:59**

  

**Fabrizio Paganelli:** Ho detto che tu mi devi trasferire determinate cose per fare in modo che se io devo mettere in mano la 360 un pezzettino devo essere capace di farlo. È chiaro che se è chiaro che se tu che è chiaro che se tu vai via e non lasci e non lasci detto nessuno, cosa che non sarà dopo non è che vado in crisi io, va in crisi l'azienda. Non è un problema di Fabrizio, è un problema dell'azienda. Non so se mi spiego. Questa importanza, ma tu sei dicendo che senza di me non va avanti questa azienda. Tu sei una persona importante. Vabbè dai dai. Quindi le scrivi te la Daniela roba è ancora in testa la state ci state lavorando e gli dice anche Sabatina adesso te la nasconde perché è inutile vederla. Ci stai ancora lavorando? Ok. Eh. Ok. Quindi per sta roba di sesso, se gli facciamo importare i dati che hanno ora, che è aggiornata al 27 ottobre, settimana prossima gli facciamo sta roba dei contatti con Elisa.

  
  

### **01:46:07**

  

**Fabrizio Paganelli:** Io devo fare in modo di fare una fotografia di Zoo fino all'11 di novembre e tra l'altro tutte le opportunità in corso, quindi mi devo creare una sezione nuova di test 360 con tutta la frontline delle opportunity tutti i contatti, avere tutte le info devi lo sai te come si deve fare AD trovare il tempo. No, perché c'ho anche performance plus class da da mettere su ancora. Vabboh, dai. Ok. Quindi glielo dici te ad Elena sta roba? A Elena a chi? Secondo me te mi hai scritto nel gruppo WhatsApp. Elena chiede: "Allora io gli dico di considerare lo stesso per il referente gli dico di usare lo stesso file dell'altra volta". Poi noi quel file lì glielo dobbiamo ricaricare. Glielo ricarichiamo sia con i contatti che loro già hanno importato, sia con quelli nuovi delle ultime due settimane. Va bene, giusto? No, gli dobbiamo ridare tutto dopo. Gli dobbiamo ridare tutto, dopo ci pensano loro eventualmente a ricaricare il solino. Facciamo. Ok. Ciao ciao ciao ciao ciao ciao. Ja.

  
  

### **Trascrizione terminata dopo 01:49:12**

  

*Questa trascrizione modificabile è stata generata dal computer e potrebbe contenere errori. È possibile anche modificare manualmente il testo dopo la creaz