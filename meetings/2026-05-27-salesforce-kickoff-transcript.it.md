# [ROMI-PIENISSIMO] — Salesforce Kick-Off — 27 maggio 2026 — Trascrizione originale (italiano)

> Trascrizione grezza della registrazione (46 min). Fonte: Fathom — https://fathom.video/calls/686882530
> File originale, non modificare. Recap strutturato in `meetings/results/2026-05-27-salesforce-kickoff.md` (EN) e `.it.md` (IT).

---

0:00 - Sabatino Rinaldi (Pienissimo)
  Dicevo, Elena, noi abbiamo tre, noi sono fondamentali, da una parte il marketing, perché la nostra è un'azienda dal modello marketing first, quindi tendenzialmente tutto quello che facciamo, tutto quello che generiamo è figlio di un'azione di marketing fatta, due, la parte vendita, perché ovviamente il marketing se poi non ha il braccio armato della vendita non riesce a produrre, però un terzo tema per noi importante, è stato uno dei fattori anche decisionali di Salesforce, è l'utilizzo poi di poter del CRM per quel che riguarda la parte di vendita. Perché, come ci diceva Andrea, è cosa che è internalizzata a Salesforce, su quale non possiamo operare, perché per noi è importante tanto quanto.

0:39 - Elena Spini (ROMI Company)
  Perfetto, su questo tema avete uno use case così da condividere inizialmente per quanto riguarda i biglietti, dato che è un tema così caldo? Cos'è il use case?

0:52 - Sabatino Rinaldi (Pienissimo)
  Fammi capire la domanda.

0:53 - Elena Spini (ROMI Company)
  Che cosa vi aspettate dal sistema per rispetto al tema biglietti?

1:01 - Sabatino Rinaldi (Pienissimo)
  Allora, noi ad oggi abbiamo, diciamo che funziona così, abbiamo, l'azienda è fatta, vado di spiegotto, poi tu mi fermi, Abbiamo, l'azienda è fatta da diversi settori, no? Quindi abbiamo un settore che è quello legato all'agenzia di marketing, cioè noi siamo verticalizzati nel mondo della ristorazione e dell'oreca in generale, e quindi il nostro segmento è un segmento molto chiaro e questo comunque semplifica quella parte di marketing. Quindi noi abbiamo un segmento chiarissimo, ben focalizzato, ben chiaro, con un modello bull centrico, perché abbiamo Giuliano Aranzetti, che è il nostro frontman dell'azienda, e quindi c'è tutta questa attività dove attraverso l'esperienza, l'esperienza di Giuliano, Pienissimo, ha creato il suo metodo, il suo metodo pienissimo, che appunto è quello che riesce a dare al ristorante una sua connotazione più aziendale. Uno, riempire il locale, due, fare in modo che il ristoratore non sia schiavo del locale, terzo, fare in modo che l'azienda produca redditività. Partendo da questo che, diciamo, è il concept dell'azienda, lo sto proprio... Sintetizzando, ragazzi, partendo da quello che è il concept dell'azienda e il modello dove noi utilizziamo la figura di Giuliano come comunque persona anche autorevole nel mercato, perché lui puoi anche trovare dei banchi, insomma, ha una serie di pubbliche DPR che sono abbastanza forti. Noi da lì cosa facciamo? Facciamo la generazione, abbiamo dei corsi che sono quasi tutti tenuti da Giuliano, delle volte ci sono anch'io in sala, però lui è proprio la persona che fa veramente l'80-90% delle sale, e abbiamo dei corsi che possono riguardare, dei corsi, uno dei corsi, quello più di inizio è per esempio il cameriere di venditori, poi abbiamo un altro corso che è la mastery che è legata al mondo del marketing, poi abbiamo un altro corso che è la calendar, quindi abbiamo una serie di corsi che vengono fatti. Quando il cliente entra in contatto con noi, noi ovviamente gli facciamo una vendita, questa vendita genera, quindi abbiamo intanto una lead generation, quindi noi normalmente abbiamo più opportunity che lead veri e propri, cioè gente che ha cliccato con una lead interesse. Questa è già declinata, quindi sono più già dei prospect se volessimo usare un gergo tecnico piuttosto che un lead puro. Poi abbiamo anche i lead in altre aree, però sicuramente chi abbiamo? Abbiamo un prospect che fa una richiesta specifica che ti dice, quindi è già qualificato e sappiamo già che un ristoratore ti dice, voglio venire, mi interessa come dire i venditori. Da lì arriva l'attività commerciale, quindi c'è un primo contatto, si fa una prima colposcente, adesso lo sto semplificando, e da quel momento in cui se il cliente è mandato un preventivo, il preventivo viene accettato, c'è un acconto perché i clienti devono pagare prima di poter entrare in sala, questa cosa genera dei biglietti, che sono dei biglietti che stanno all'interno di un magazzino ad oggi, che noi abbiamo già, quindi noi se poi vi condividiamo, lo gira ora, è come vorremmo che girasse. Questo magazzino a biglietti si attiva, cioè abbiamo anche momento in cui il biglietto è un biglietto generato, ma non utilizzabile, finché il cliente lo acquista ma non ha pagato tutto, il biglietto non è utilizzabile, quindi sta lì, fa giacenza di magazzino, ma non diverso. Dopo che il cliente ha terminato il pagamento, quindi qui c'è il check con l'area amministrativa, che dice ok, il cliente ha terminato il pagamento, quel biglietto diventa utilizzabile, si può bruciare diciamo noi. Quindi poi abbiamo l'invio alla cliente del biglietto, dove fa una compilazione manuale, ed oggi quel biglietto in modalità cartacea viene consegnato al check-in del corso, viene scannerizzato, in automatico c'è un check-out, il biglietto viene scaricato, quindi noi abbiamo una sorta di magazzino, dove abbiamo biglietti acquistati da parte dell'azienda, i biglietti che vengono effettivamente utilizzati perché sono scaricati, e poi abbiamo la disponibilità di magazzino, perché magari hanno comprato 4 biglietti di camerieri venditori, ne hanno usato soltanto 2, quindi quelli rimangono in magazzino.

4:49 - Elena Spini (ROMI Company)
  Mi interrompo solo un secondo, e attualmente la generazione dei biglietti avviene sul WooCommerce, corretto?

5:00 - Sabatino Rinaldi (Pienissimo)
  Attualmente la generazione dei biglietti avviene tramite Zoff, il nostro CRM, noi abbiamo il CRM Zoff, il centro dei biglietti, che è stata fatta un'integrazione, abbiamo utilizzato uno sviluppatore interno e abbiamo creato un'integrazione magazzino che ha degli API che comunica con Zoff. Sì, sostanzialmente non appena su Zoff viene messo l'ordine, all'interno del quale sono contenute tante righe ordine, una per ogni codice articolo, quindi il codice evento, in quello stesso momento si carica il magazzino a faceva riferimento Daniela. Nel momento in cui, poi dopo dall'ordine facciamo fattura, nel momento in cui la fattura viene integralmente pagata, quel carico di magazzino diventa disponibile. Poi, sempre come diceva Daniela, nel momento in cui il cliente tramite tutto il ciclo di stampa biglietti, entra all'evento, in quel momento... Si scarica il magazzino di quel biglietto, quindi abbiamo un carico, nel momento in cui si genera l'ordine, quel carico avrà un flag di disponibilità sì o no, nel momento in cui il cliente viene, si genera un movimento di scarico, quindi la, diciamo, tra virgolette, la giacenza del magazzino per quel cliente, per quel biglietto va a zero. Perfetto.

6:26 - Elena Spini (ROMI Company)
  E l'attualmente il vostro CRM, ZOO, è quello che deve essere dismesso, che verrà cambiato con Salesforce. Esatto, esatto.

6:37 - Sabatino Rinaldi (Pienissimo)
  Perché è diventato un ZOO in tutti i sensi, il vostro CRM. Poi, è la situazione, Elena? Che ovviamente noi abbiamo un primo momento in cui il cliente compra il biglietto, poi abbiamo il tema di portare il vostro cliente seduto. E non è così. Questo scontato perché noi abbiamo dei clienti che controllano dei corsi e poi per X motivi non vengono a farli. Quindi noi abbiamo un primo task che è la vendita, un secondo task che è quello del riempimento. Quindi abbiamo poi, diciamo, il magazzino porta con sé anche un funnel di comunicazione che usiamo con WhatsApp per ricordare al cliente perché noi gli inviamo i biglietti, non in automatico, quindi il biglietto gli viene inviato a 60 giorni più o meno dall'evento perché c'è un funnel in questo. Quindi a 60 giorni, guarda, ti ricordo perché c'è gente che magari compra in un tour un biglietto a settembre che andrà a fare magari a marzo dell'anno dopo e c'è gente che se lo dimentica che ha comprato delle robe in the bundle, ok? Quindi noi cosa facciamo 60 giorni prima? Gli ricordiamo che c'erano un biglietto, c'è tutta la comunicazione di marketing, facciamo il memo perché abbiamo bisogno di capire poi qual è il tasso di no show rispetto ai vari riempimenti. Quindi una delle cose che avevo chiesto ad Andrea, che per noi era fondamentale, che oggi non abbiamo... e mi piacerebbe, è assegnare al cliente, in base alla fonte di acquisto, il grado di no-show. Cioè, noi sappiamo già che, per esempio, a settembre noi facciamo il tour, che sono delle sessioni gratuite di tre ore, dove Giuliano va in giro per l'Italia e a fine di questa sessione vende dei bundle dal parco. la gente si ricompra. Però, il tasso di, diciamo, di no-show è molto alto. Poi, per esempio, abbiamo quelli che invece comprano da sponsorizzata e sottodento, che invece hanno un buon tasso di conversione. Poi abbiamo qui, per riuscire ad avere una sorta di dashboard, che ci permette di dire, benissimo, la composizione della sala di camerieri e venditori è fatta a un 20% di quelli da tour, che immediatamente sappiamo che è il tasso di no-show è 70, piuttosto che, eccetera, eccetera, eccetera, ci permetterebbe di fare poi una buona pianificazione di azioni marketing e commerciali per andare in primo metro sala. perché tu immagini Sare anche da 1.200 persone, che portarla a 900 per noi è posto di lungualità. Quindi questo è il giro, diciamo, del nostro maschile.

9:11 - Elena Spini (ROMI Company)
  Ho recepito assolutamente il vostro bisogno e considera che su Salesforce quello che possiamo inserire come dato poi lo possiamo rappresentare a dashboard. Quindi se noi riusciamo a dire Elena Spini che ha acquistato il biglietto, l'ha acquistato o all'evento che citavi prima in presenza o da una sponsorizzata, allora noi possiamo capire poi tutta la sala da dove proviene. Quindi è molto importante arricchire la piattaforma con i dati che ci servono per capire poi cosa vogliamo andare ad analizzare.

9:49 - Sabatino Rinaldi (Pienissimo)
  Sì, ma giustamente abbiamo bisogno di automatismi nelle dashboard, perché ricapriamo poi qual è la linea strategica da utilizzare.

9:56 - Elena Spini (ROMI Company)
  Assolutamente, però ecco facciamo sempre un passaggio prima. Quindi una volta che abbiamo capito cosa vogliamo vedere nelle dashboard, pensiamo quali dati ci serve mettere in queste dashboard. Questa è un po' la base per tutti i dati. Corretto.

10:12 - Sabatino Rinaldi (Pienissimo)
  Perfetto.

10:13 - Elena Spini (ROMI Company)
  Siamo allineate anche su questo. Allora, vediamo un po' i miei appunti. Io mi ero segnata questo appunto del WooCommerce, che usate in vostro store?

10:29 - Sabatino Rinaldi (Pienissimo)
  Sì, Sì, lo utilizziamo sia per la vendita di prodotti, una shot che acquistano in autonomia i clienti, che può essere un libro o videocorsi, eccetera. E lo utilizziamo anche per la vendita del biglietto. Magari ad esempio un evento come Camerieri Venditori, piuttosto che il singolo biglietto, magari facciamo un 3x2, una promozione. Quindi il carrello è da WooCommerce che manda poi l'ordine su Zoo. Quindi abbiamo l'integrazione diretta tra WooCommerce e ZOO.

11:06 - Elena Spini (ROMI Company)
  Ok, quindi in realtà è proprio l'e-commerce che riceve poi il biglietto, è così?

11:16 - Sabatino Rinaldi (Pienissimo)
  L'utente dall'e-commerce, da WooCommerce, fa l'acquisto. Questo acquisto, una volta passato in lavorazione, arriva su ZOO, perché abbiamo collegato WooCommerce a ZOO, arriva su ZOO nella sezione ordini, abbiamo quindi l'ordine del cliente che poi verrà fatturato e da quel momento in poi quel biglietto sarà disponibile. Perfetto, la stessa cosa dovrà succedere con Salesforce. Il passaggio WooCommerce ZOO poi va con Mexal per la fatturazione, è un triplo passaggio, quindi abbiamo oltre a WooCommerce collegato a ZOO abbiamo anche Mexal, che io in realtà nel questionario probabilmente te l'ho scritto come Metal. No, infatti io poi ho fatto, questa era la domanda successiva. E' una triade, dai, tre strumenti diversi che però comunicano con un unico obiettivo. Aggiungo a quello che ha detto Sabatino, che oltre a ricevere gli ordini barra incassi da WooCommerce, noi riceviamo incassi anche direttamente tramite bonifico. Quindi non è detto che, o meglio, non è detto che, diciamo che è un 60-40, 50-50. Molti clienti ci pagano tramite bonifico nel momento in cui l'ufficio commerciale manda a loro un preventivo che poi dopo viene accettato con la ricezione dell'incasso. Abbiamo una modalità di gestione del denaro che è ibrida tra la parte online, WooCommerce, e la parte tradizionale, bonifico, eccetera, eccetera. Sì, e aggiungo ancora un'altra cosa, così hai proprio il quadro completo di come utilizziamo WooCommerce. Noi da palco a tutti i nostri eventi, alla maggior parte dei nostri eventi, facciamo una vendita da palco. Questa vendita da palco prevede di scansionare un QR code che ti manda in una landing e ti chiediamo l'anticipo della vendita. Magari una vendita da un totale di, ad esempio, 10.000 euro, noi ti chiediamo 5.000, in quel momento lì che deve essere o bonifico bancario o carta di credito. Quindi lì arriva l'anticipo da WooCommerce. Poi il completamento, cioè tutta la parte mancante, viene gestita poi in un secondo momento dai commerciali. Quindi abbiamo anche... Anche quest'altro tipo di utilizzo di WooCommerce. Magari dopo immagino che si faranno delle call dedicate a questo momento, perché abbiamo un'operazione abbastanza spinta. poi tra l'altro, e di questo ne abbiamo discusso tante volte con la Daniela, noi non è detto che vogliamo replicare su Salesforce come facciamo adesso. Magari questa per noi è l'occasione per rivedere un attimo la nostra mentalità e cercare di adottare dei processi di lavoro che siano più funzionali, più snelli, eccetera, eccetera. Quindi magari vi faremo vedere come facciamo per capire come possiamo migliorare, insomma, da questo punto di vista, aperti al cambiamento.

14:52 - Elena Spini (ROMI Company)
  Perfetto, sono molto contenta di sentirvi così propensi anche a questo, perché appunto poi magari svisceranno... Dopo a tutti quelli che sono questi aspetti, poi magari lato nostro vi possiamo proporre altre soluzioni che magari, non lo so, potrebbero secondo noi snellire la situazione, oppure magari voi avete i vostri metodi e ci direte no, così no.

15:39 - Sabatino Rinaldi (Pienissimo)
  Sì, sì, sì, sì, sì. Sì, sì, sì, sì. Quindi possono fare delle cose e altri non le possono fare e poi fare il modello di adeguamento all'utilizzo dell'istrumento, perché abbiamo fatto il contrario allora, cioè se tu vedi all'interno anche del contenitore magazzino, sono state fatte delle robe che se tu ci ragioni non hanno un senso logico, se no nel voler risolvere un problema in quel momento lì, in quella situazione specifica, senza rendersi conto che quello poi a catena avrebbe generato altri effetti sulla catena del valore. Questo per darti un modo di digrenza. Quindi è sicuro che noi dobbiamo fare diverso, cioè non è sentitevi liberi.

16:34 - Elena Spini (ROMI Company)
  Perfetto. No, chiariamo, perché cioè almeno loro lo sanno, se no c'è Ottimo, mi fa piacere, mi fa piacere. No, allora comunque giusto per tarare il focus, il focus di questa riunione era appunto, uno, conoscerci, due, snellire i punti che mi ero segnata così giusto di sistemi e cose tipo il Mexal di turno che non era presente, nel questionario e poi cosa succederà. Seguiranno dei meeting dedicati? Assolutamente sì, per rispondere a una domanda che è emersa prima, quindi non è questa la riunione per sviscerare tutti i passaggini specifici di ogni cosa, ecco. E poi, anzi, prima ancora di tutti questi meeting ci sarà a lato nostro una demo che vi facciamo vedere la piattaforma in generale come ragiona Salesforce, quindi che cosa sono gli oggetti, che cosa sono le dashboard, come è la vista all'interno di Salesforce, di questo nuovo database che voi avrete. che magari avete già visto con Salesforce, ne sono certa, però è giusto una rinfrescata, mezz'ora, un'ora, poi dipende un po' da come va la discussione. E questo sia per la parte sales che per la parte marketing, perché ci teniamo a farvi vedere effettivamente la piattaforma, e poi andiamo a costruire insieme
  ACTION ITEM: Email Elena key users list (business + technical) - WATCH: https://fathom.video/calls/686882530?timestamp=1076.9999
  E tramite meeting dedicati, anche magari un po' più tecnici, tutti quelli che sono questi aspetti che ci siamo raccontati. Quello che vi chiederò, io scriverò magari a Sabatino, non lo so, in questo meeting andiamo a parlare di, non lo so, i clienti, gli eventi, che cosa vogliamo vedere, per favore dimmi quali saranno i key user che dovranno, uno, utilizzare la piattaforma e due che magari sono un po' più tecnici che vogliamo coinvolgere. Capiamo un po' insieme di volta in volta. Oppure, questo sarà un meeting solo marketing, è inutile che arrivano, non lo so, gli agenti, per esempio, lo sparo, non lo so. Quindi, se leggiamo un po' le persone che devono partecipare ai meeting, ecco. Il frutto di tutte queste riunioni dovrà essere, lato nostro, la documentazione, che chiamiamo blueprint, quindi questo documento in cui verrà scritto sotto l'oggetto, non lo so, account, troviamo tutti i... Ci aspettiamo che riceviamo il documento in questo formato e il QR code in quest'altro, ok? E questo documento verrà poi approvato da voi e successivamente, ma in realtà lo facciamo anche in parallelo per parallelizzare un po' le cose, i nostri tecnici, noi insomma insieme, andiamo a configurare quella che è la piattaforma.
  ACTION ITEM: Schedule Salesforce demo w/ Sabatino + ROMI team - WATCH: https://fathom.video/calls/686882530?timestamp=1154.9999
  Dopodiché andrete anche voi, anche qui magari direttamente con i key user, quindi che sono quelli che utilizzano la piattaforma, andremo a fare degli incontri in cui vi facciamo vedere effettivamente negli ambienti di test, noi abbiamo fatto così, è quello che ci siamo detti o vi aspettate altro? Che così possiamo eventualmente correggere la linea che sta prendendo il progetto, senza arrivare poi ad avere sorprese, ecco. Chiediamo quindi un po' di partecipazione in questo senso, non troppa, senza troppo stress, però ecco. Magari incontri settimanali, bisettimanali, dipende un po' dal momento, ecco.

20:06 - Sabatino Rinaldi (Pienissimo)
  Noi, guarda Elena, da parte nostra hai la massima partecipazione perché è un'area nevralgica per noi, perché noi oggi siamo un'azienda che vende dati, informazione e marketing e per assurdo ci troviamo noi a necessitare di ottenere informazione, quindi per noi questa è un'area non vitale di più. in un periodo in cui tutto sommato, sì, siamo carichi, però abbiamo finito il primo pezzo di corsi, quindi possiamo seguirvi abbastanza con ritmo e tra l'altro noi abbiamo un touch point importante che dobbiamo condividere e che comunque noi a settembre partiamo con il tour e partiamo con il Furnate Team Festival, che per noi sono dei kick-off di poi come deve girare tutta l'attività formativa, quindi dobbiamo fare in modo da questo punto di vista di cominciare a poter utilizzare lo strumento in maniera un po' più fattiva, quindi diciamo che non ci aspettiamo noi a settembre di essere al 100%. Però, di cominciare a fare già qualcosa, sì, perché poi dobbiamo cominciare a testarlo e sappiamo poi che, quando è che abbiamo noi la dismissione di Zon? In ottobre, vero? A fine settembre. A fine settembre, no, fine settembre abbiamo. Ok, quindi noi abbiamo, diciamo, un tempo che è a fine settembre, in cui, particolarmente, ci scade il contratto della TCRM, quindi, in momento, dobbiamo essere molto, molto ritmici, non dico nel far tutto, però nel fare già abbastanza riguardo, insomma, adesso. Per darci dei momenti importanti, perché sono poi le ricette che poi noi disgettiamo all'altra piattaforma e siamo un po' in difficoltà.

21:42 - Elena Spini (ROMI Company)
  Certo, quindi voi avete un contratto su questa piattaforma ZOA che scade a fine settembre?

21:49 - Sabatino Rinaldi (Pienissimo)
  Sì, esatto.

21:51 - Elena Spini (ROMI Company)
  Fine settembre.

21:53 - Sabatino Rinaldi (Pienissimo)
  Abbiamo food marketing il 29 settembre. Sì, noi abbiamo, abbiamo, prima. L'evento, quello che abbiamo di Ticcoff, che è un elemento dove comunque normalmente superiamo i 1.500 clicchi, è al 29 ottobre, però quest'anno non stretto. Sì, no, no, nel senso che se cade a ridosso della scadenza di zoo, facciamo fatica poi a gestire le persone. Quindi andiamo a lavorare... Dovremmo fare il prima possibile. L'obiettivo sarebbe arrivare il prima possibile ad avere quantomeno la parte magazzino, la gestione del cliente in presenza, che è venuto all'evento, che non è venuto, quei dati lì per noi sono fondamentali.

22:39 - Elena Spini (ROMI Company)
  Ok, mi sto segnando il punto, facciamo un attimo un check interno delle fattibilità, ho recepito che, insomma, dobbiamo fare in modo di arrivare a prima di finire... Settembre, senza dubbio, e capiamo effettivamente cosa riusciamo a portare con questa timeline che ci avete dato, ecco.

23:06 - Sabatino Rinaldi (Pienissimo)
  Sì, magari capiamo su cosa mettere attenzione prima, perché non è detto che io lo fa tutto, però mettere in sicurezza i dati aziendali cosa fa e quello sì, insomma. Tu Elena, hai chiaro quindi come gestiamo noi l'utente dal momento dell'iscrizione al corso fino a quando viene in sala? Sì, per ora mi sembra di aver capito, poi magari tutti gli aspetti un po' più...

23:31 - Elena Spini (ROMI Company)
  dettagliati, cioè vi svisceriamo effettivamente quando poi andiamo a fare il, diciamo così, il comparing da quello che è Salesforce a quello che effettivamente avete voi. Però in linea generale direi di sì con oggi, con la spiegazione. E ho solo un altro dubbio se posso. Eh dai, certo. Allora, mi ero segnata un punto di cui parlavamo del centralino 3CX.

23:58 - Sabatino Rinaldi (Pienissimo)
  Sì. Lui.

23:59 - Elena Spini (ROMI Company)
  Lui. Lo usate? Lo vorreste usare?

24:03 - Sabatino Rinaldi (Pienissimo)
  Invece l'abbiamo già, centralino 3CX. Allora, domenze, l'assistenza. No, anche nella parte commerciale, che però non viene utilizzata. Che non viene utilizzata sicuro. Esatto. Invece l'idea è quella di, avendolo preso, di utilizzarlo. Invece l'abbiamo già, peccato che i nostri commerciali fanno come cazzo vogliono loro. Francesco.

24:26 - Andrea Galotto
  Ma ce l'avete, è stato completamente fatto il setup, quindi è completamente funzionante a discrezione dell'utilizzatore utilizzarlo, oppure va fatta ancora qualche cosa la 3CX centralizzata?
  ACTION ITEM: Email Elena 3CX status (commercial setup + recording) - WATCH: https://fathom.video/calls/686882530?timestamp=1467.9999

24:38 - Sabatino Rinaldi (Pienissimo)
  Andrea, ti faccio sapere, perché su quello c'è un buco nero, nel senso che io so perfettamente che dal lato assistenza, però è l'altra azienda che noi non trattiamo, viene utilizzata tranquillamente, quindi c'è già. So che era stato internalizzato per l'area commerciale, per poter integrare le comunicazioni, le varie... e attività, però i nostri commerciali sono veramente degli analfabeti digitali e quindi su questa cosa me ne occupo, io principalmente per la prossima volta possiamo anche già discuterne. Siamo anche sull'intelligenza artificiale, detto Giulia, noi siamo ancora su utilizzare il centralino, che siamo un po' prima, però sì, ti diamo informazioni su questo. Fantastici, grazie, gentilissimi.

25:26 - Elena Spini (ROMI Company)
  Perfetto, rimaniamo allora quindi in attesa un po' di vostro su questo.

25:36 - Sabatino Rinaldi (Pienissimo)
  Ecco, l'aspettativa che noi avremmo è questa, cioè fare in modo che quando il cliente viene contattato, l'utilizzo diciamo del software del centralino ci possa permettere di fare che cosa? Di registrare questa telefonata e avere dell'informazione all'interno del CRM. Noi avevamo anche pensato inizialmente a Moris, Moris, che era la I-interna, però parlando proprio con Vittorio abbiamo detto che probabilmente è sovrastimato rispetto a noi, abbiamo sei commerciali, non è che abbiamo chissà che cosa, no? Però, siccome abbiamo Sabatino, che comunque ci sta curando anche l'integrazione con l'AI interna, nulla vieta che noi facciamo un'operazione per cui l'AI si aggancia queste informazioni e restituisce ai nostri commerciali quali sarebbero le aree di attenzione, tecniche di vendita, miglioramento, eccetera, eccetera. Quindi ci vogliamo arrivare a questo. Ad oggi i nostri commerciali usano il loro telefonino, hanno la loro scheda SIM principalmente, e la metà delle cose vengono registrate male nel CRM, quindi non è che è proprio tutto sbagliato ZO, però noi ci abbiamo messo molto a riguardo. Dobbiamo usare questo. Il fatto di aver cambiato anche pelle e partire da zero è perché abbiamo detto tanto, per come siamo messi adesso, anche ZO dovrebbe essere ricostruito da zero. Facciamo prima con un prodotto nuovo, che è a ricostruire Roma piuttosto che farla nuova. Quindi abbiamo, ci siamo detti, però vorremmo dire a tutti, così, che siamo al quarto CRM, stop con questo. L'abbiamo fatto una volta, poi l'abbiamo dismesso. Poi abbiamo fatto che altro KIP, che soft costa come un rene. Poi abbiamo tolto KIP, anzi no, adesso abbiamo solo un'utenza d'automarketing, però era più una zona, abbiamo rimesso il ZOF. Adesso siamo a Salesforce. Io ho finito le… una volta buona?

27:22 - Elena Spini (ROMI Company)
  Certo. Oh, per dirvi.

27:25 - Sabatino Rinaldi (Pienissimo)
  Questo è il mio punto di mettere il mood. No, farvi capire che al quarto CRM non so quante aziende che avuto, però mi sento a capire se non al quarto CRM. Ridete, C'è da piangere qui, se per il senso di che abbiamo buttato via. Però, per ridere per non piangere. Dobbiamo imparare dai errori. Sono matto, ma devo… Scusa, buono. Io volevo aggiungere un punto di cui abbiamo parlato anche nelle volte scorse, ma oggi non abbiamo toccato. Come diceva la Daniela prima, noi abbiamo un'area del business che riguarda il tema… Ma… Della vendita dei corsi e l'altra area fondamentale è la Performance Plus, è l'agenzia di marketing. Io questa qui ce l'ho particolarmente a cuore, lo dico sempre ai miei colleghi, perché abbiamo una gestione, parlo magari più del lato amministrativo particolare, ci sono fondamentalmente, cerco di essere il più sintetico possibile, dei contratti che hanno durata un anno, di un certo importo. Esatto, ogni cliente può avere una frequenza di liquidazione, quindi di emissione dalla fattura e di incasso legato a questi contratti che può essere diversa, chi ce l'ha mensile, chi trimestrale, chi quadrimestrale, eccetera, eccetera, quindi anche questa è un'area che grazie a Salesforce avremmo piacere di gestire in modo più efficiente, più chiaro dove le informazioni siano circolate. tra tutti i reparti, reparto che produce, diciamo, il servizio, il reparto commerciale, eccetera. Sì, aspetta, guarda, giusto perché sennò rischiamo di non dare. Allora, il primo è questo. Noi abbiamo una gestione che è una gestione amministrativa del contratto che ad oggi è abbastanza farraginosa perché abbiamo un problema, Mexal non è un prodotto che riesce a fare un ordine con più scadenze. Quindi quando noi inseriamo un ordine, Mexal vorrebbe un'unica fattura, considerate che con un contratto, un contratto da 20.000 euro, fare una fattura da 20.000 euro a un cliente è follia pura. Quindi cosa facciamo? Facciamo in modo di scadenziare questi pagamenti. L'idea qual è? Fare in modo che, come ci diceva Andrea, da Salesforce noi costruiamo quello che è il modello di pagamento, cioè inseriamo l'ordine e inseriamo le varie scadenze in maniera tale che possiamo avere un memorandum di cosa fatturare. L'idea ci sarebbe da fare anche una modifica Mexal, ma arriverò a convincerlo, di fare una personalizzazione che ci permette con poco e niente di fare in realtà l'operazione di avere un unico ordine, quindi un ordine matrice con le varie scadenze, perché sarebbe la cosa più semplice da fare. Però in questo caso, in quest'area, in un terreno, sicuramente avere il fatto che il sistema ti dica, guarda che a marzo c'è da fatturare A, B e C, aiuta l'amministrazione a dire, ok, va bene, io inserisco anche manualmente l'ordine e faccio una fattura, però ho un software che mi ricorda cosa deve andare in fatturazione. Sì, poi diciamo che abbiamo anche un tema di comunicazione tra i vari reparti di qual è la situazione su quel cliente, perché poi tra l'altro questi contratti alla scadenza vanno a rinnovo, quindi spesso cosa succede? Che il commerciale non sa cosa ha fatto l'amministrazione, l'amministrazione non sa cosa ha fatto il commerciale, il reparto che eroga il servizio non sa se quel cliente ha pagato tutto, quindi ecco, vorremmo trovare il modo attraverso questo strumento di riuscire ad avere un contenitore unico dove tutti i reparti siano continuamente in tempo reale aggiornati sulla situazione del cliente.

31:13 - Andrea Di Cicco
  Diciamo che comunque Salesforce è un po' quello che tende a costruire una sorta di 360+, quindi avere una vista completa di quelle che sono tutte le informazioni del cliente in modo tale che tutti gli utenti possano vedere quelle che sono le informazioni necessarie per il loro operato e quindi avere in un'unica pagina tutto quello che vi serve. Quindi in questo caso poi ci sono anche strumenti di collaborazione, cioè nel senso strumenti che permettono di, un po' come Facebook, mettere commenti, taggare le persone, dire guarda questo cliente ha pagato oppure Elena per favore ricontatta questo cliente per la fatturazione e così via. Quindi ci sono vari strumenti, poi lo andremo ad approfondire durante la demo su questa parte per avere questa vista. La vista completa. Poi l'altra cosa importante sempre da mantenere a mente è che possiamo vedere tutto ma possiamo anche restringere la visibilità perché poi ovviamente ci sono informazioni che alcuni utenti dovranno vedere e altre informazioni che alcuni utenti non devono vedere. Ma anche i stessi clienti. Cioè magari voi avete una vista che se io sono la persona che mi occupo di un determinato cliente sono l'unico che la deve vedere. Oppure magari la devono vedere tutti quanti questo cliente. Non lo so. Comunque sono tutte cose che analizziamo. Diciamo su questo abbiamo molta flessibilità soprattutto a livello anche di informazioni, come visualizzare le informazioni e come far collaborare le varie persone tra loro. Insomma.

32:45 - Sabatino Rinaldi (Pienissimo)
  Noi diciamo che adesso abbiamo un tema sulla parte di performance classica e servizio di agenzia di poter avere informazioni soprattutto in tempo reale sullo stato del cliente. La cosa più banale è cosa devo fatturare questo mese e poter fare una proiezione. Fatturato, cosa che oggi se io devo chiedere a Fabrizio da ora fino a dicembre che cosa prevediamo di fatturare sul performance class, mi si deve mettere di certosino a fare il lavoretto della scimmia, dico male? Non è una cosa istantanea, è ancora il problema. Quindi poi dobbiamo capire se questa è una cosa che potrà essere fatta da Salesforce oppure fatta da Salesforce magari in maniera più su misura attraverso la I, perché probabilmente con la I interna noi ci potremmo muovere, considerando che noi poi in fase di acquisto abbiamo tolto la parte di project dal progetto e quindi quell'attività di projecting che viene fatta su performance class viene fatta attraverso il cuscottino AI. Quindi lì secondo me bisogna capire come integrare le tre fonti dati. Quindi magari c'è il caso che alcune cose le facciamo attraverso anche il clore interno prendendo dati come fonte da Salesforce, quindi lì ci arriviamo. Diciamo che per me è importante, da me è area direzione. Direi, ok, io ho bisogno di capire se il mio obiettivo è arrivare ai 4 milioni, 5 milioni su questa agenzia, ad oggi, da adesso, fino a fine anno, che previsione ho di fatturato e che stima dello sforzo devo fare per poi arrivare a quell'obiettivo lì. Quindi oggi io ho bisogno che lui faccia un'operazione in cui deve prendere un'esportazione e vi deve fare un Excel, non è una roba che tu fai clic e vedi. Quindi per me è un po' nel 2026 una roba come si può sentire.

34:26 - Andrea Di Cicco
  No, no, è chiara l'esigenza. Io banalmente già un'idea me la sono fatta, nel senso, magari, adesso la butto lì, poi ovviamente faremo analisi e tutto, però magari sull'ordine si vanno a inserire tutte, come dicevi tu, la fatturazione di gennaio, febbraio, marzo, aprile, e poi da semplicemente un report dici quali sono tutte le fatturazioni che devono essere fatte durante gennaio. e da lì, dal report, ti estrai tutta la fatturazione, che poi il report è fondamentalmente... E' Excel, insomma. Cioè, te lo puoi anche esportare come Excel ed è pronto per l'utilizzo. Quindi, però, adesso non voglio fare soluzioni senza conoscere tutto.

35:11 - Elena Spini (ROMI Company)
  Oggi se lo condividi con, non so, il tuo collega di turno e dici, vedi che ho fatto questo report, lo puoi vedere. Sì, o puoi anche addirittura schedulare l'invio.

35:25 - Andrea Di Cicco
  Cioè, se tu hai un report, quindi una tabella in cui hai tutta la fatturazione, tu puoi dire, mandami questo report, non lo so, una volta a settimana a questi utenti. In modo tale che neanche devi accedere alla piattaforma, ma lo ricevi direttamente via mail. Quindi, sono tutte cose che si possono abilitare. Quindi, ok, sì.

35:49 - Sabatino Rinaldi (Pienissimo)
  E ultimo, ma non ultimo, che è una cosa che a noi sta in interesse, anche le politiche dei clienti dormienti. Nell'area commerciale Baramartiti, noi oggi abbiamo tanti... Per esempio abbiamo un agente, una venditrice, che ha 1600 clienti assegnati e praticamente siccome ad oggi le opportunità vengono generate sia su un cliente fidele sia su un cliente nuovo, lei in automatico piglia senza fare operazioni. Invece io vorrei che decidendo noi qual è la regola di dormienza del cliente, a un certo punto, se sono superati 6 mesi, 7 mesi, 8 mesi, quello che decideremo che il cliente non compra, quel cliente deve avere un momento in cui mi deve riandare nel tag dormiente e io direzione commerciale devo poter avere la libertà di riassegnarlo. Perché altrimenti cosa accade? Che abbiamo dei ragazzi volenterosi, che hanno meno portafoglio, che di fatto devono stare lì sul pezzo, e altri che invece siccome hanno il cliente assegnato, il cliente si risveglia perché faccia un'attività al market, quindi noi ripaghiamo 3-4 volte l'operazione, che è figlia a caduta libera anziché fare azione commerciale. Ed è poco divertente perché nessuno vuol giocare a calcio con quello che non ti passa come la palla.

37:01 - Elena Spini (ROMI Company)
  Certo, su questo diciamo l'assegnazione dei lead, possiamo fare veramente tutto quello che ci viene in mente, possiamo creare regole, possiamo decidere al momento se voglio cambiare l'assegnazione a una coda, a un gruppo di persone, coda è un gruppo di persone, o alla persona di riferimento, assegnazione automatica, dovete solo decidere quali sono le regole che avete in mente e poi le trasferiamo senza problemi su questo, io aggiungo una cosa, ho un punto che vorrei discutere, con Andrea avete parlato del tema di avere qualcosa che vi faccia avere la firma digitale, perché da quello che ho capito, voi volete raccogliere il consenso privacy, mi sembra aver capito, una volta che la percorso

38:02 - Sabatino Rinaldi (Pienissimo)
  Non soltanto il consenso privacy, e proprio anche le condizioni contrattuali, perché noi chiediamo al cliente che arriva, la non-concorrenza, il fatto di non utilizzare i dati per poi fare corsi alternativi, perché andiamo ai visti di tutti, quindi proprio le condizioni contrattuali, non soltanto la privacy.

38:21 - Elena Spini (ROMI Company)
  Ok, perfetto. Cioè, insomma, tutte queste, diciamo, regole che deve accettare, passatemi il termine, ma ci chiedevamo, c'è un particolare motivo per la quale questo deve essere fatto esattamente in presenza, o non può essere, magari, messo nel processo di acquisto o, non so, invio del biglietto, insomma, da capire? Cioè, in un momento primo, a livello climatico, diciamo.

38:48 - Sabatino Rinaldi (Pienissimo)
  Sì, a livello climatico. Però se voi ce lo risolvete, noi facciamo la ola, nel senso che non è che abbiamo voglia di sbostare gli alberi tutta la volta, cioè mi sento responsabile dell'Amazonia tutte le volte che facciamo. In corso. Quindi non solo, poi immaginatevi quando abbiamo una situazione legale, che cosa significa andare a cercare un contratto nel mare magno del magazzino cartaceo, quindi se c'è un modo per risolverlo non c'è problema. Qual è il tema? Che quando noi firmiamo delle posizioni contrattuali abbiamo bisogno che ci sia un OTP o comunque qualcosa che il cliente mi deve accettare, perché altrimenti la sola visualizzazione non ci permette di considerare le posizioni contrattuali accettate, soprattutto quelle legate alla non concorrenza e collegate alla non divulgazione dei dati, perché è proprio una condizione che va accettata dal punto di vista politico. Su questo gli avvocati non ci hanno mai dato troppo aiuto in questo senso, e anzi ci hanno reso un po' più complicata la cosa. Due, noi abbiamo la necessità di avere i nominativi delle persone che si iscrivono, quindi abbiamo il contatto che potrebbe essere titolare, ma a volte il titolare viene con un suo collaboratore e di questo abbiamo bisogno di avere sia i dati anagrafici, ma anche un consenso firmato alle condizioni contrattuali, sempre per il tema della non concorrenza. Non perché siamo folli, però abbiamo diverse situazioni per le quali un cliente è venuto a fare formazione sul marketing, poi è diventato anche lui il duro del marketing, quindi a certo punto dobbiamo tutelare legalmente l'azienda. Quindi magari quando uno vede le nostre condizioni contrattuali pensa che siamo dei folli, ma se vi faccio vedere che cosa succede fuori è stata una necessità. Quindi il nostro tema, se noi riusciamo, abbiamo l'OTP sul cliente, va bene, ma poi va mandata questa informazione anche sul collaboratore. Qual è il punto? Quindi noi siamo nel mondo ristorativo, mentre se tu fai una mail aziendale nel mondo che tu vivi è normale, nei locali nessuno dei camerieri ha una mail aziendale, quindi la Mariana ha una mail personale della persona. Quindi se noi abbiamo un metodo per riuscire a farlo digitalmente, noi siamo già a posto, Elena. Grazie.

41:01 - Elena Spini (ROMI Company)
  Non ho capito perché, se non c'è la mail aziendale, voi non vi potete interfacciare con la persona che ha la mail personale? Non ho capito il punto.

41:10 - Sabatino Rinaldi (Pienissimo)
  No, noi abbiamo il cliente, giusto? Che compila tutti i dati della persona e noi inviamo tutti i dati al cliente, quindi alla mail aziendale, il cliente se li stampa e fa firmare, arrivano al corso con tutta questa roba stampata, modello Clicco della legge, no? Noi vorremmo evitare questa roba qui, ci piacerebbe tanto fare un clic clic per fare in modo che questi arrivano con zero informazioni, ma non solo, che noi abbiamo tutto il documentale archiviato perché ci renderebbe molto più facile la vita, però ad oggi non sappiamo come e non ci hanno risolto il tema. Ok, quindi vediamo se ho capito bene il punto.

41:48 - Elena Spini (ROMI Company)
  Allora, c'è l'azienda, voi oggi date questa informativa, condizioni di divulgazione dei dati, eccetera, tutti i vostri punti. Che abbiamo detto contrattuali, all'azienda X di turno. Poi sarà l'azienda X di turno che dà a tutti i suoi referenti, contatti che parteciperanno all'evento, confermare effettivamente questa informativa privacy. E loro arrivano all'evento, ognuno, arriva Elena, arriva Andrea, con il suo foglio e ve lo consegna. Sì, e noi lo cerchiamo, lo facciamo proprio con il QR Code e facciamo il posto.

42:29 - Sabatino Rinaldi (Pienissimo)
  Ok, grazie. Il metodo per fare meglio noi lo pieghiamo volentieri, cioè se lui basta che arrivi con il QR Code ed arriviamo tutte le informazioni, c'è un click che lui ha accettato le condizioni con accetta, accetta, a noi va benissimo lo stesso. Il problema è avere un link che c'è, l'accetta, accetta, perché a quel punto c'è il tuo nome, c'è il tuo cognome, c'è il tuo accetta, condizioni, noi siamo a posto.
  ACTION ITEM: Email Sabatino OTP/e-signature proposal for privacy + non-compete - WATCH: https://fathom.video/calls/686882530?timestamp=2565.9999
  Ma ad oggi non c'è un troppo per fare accetta, accetta.

42:56 - Elena Spini (ROMI Company)
  Perfetto, poi se facciamo un passaggio interno e vediamo. Cosa ci possiamo, cosa vi possiamo proporre, direi. Una proposta sicuramente la facciamo, poi vediamo se effettivamente abbiamo toccato tutti.

43:11 - Sabatino Rinaldi (Pienissimo)
  Perché poi sono i legali quelli che ci hanno con le palle su questa battaglia.

43:15 - Elena Spini (ROMI Company)
  Noi magari la facciamo troppo facile, poi voi ce la smontate in 3, 1. Facciamo delle proposte, poi vediamo.

43:22 - Sabatino Rinaldi (Pienissimo)
  E poi quando ci chiedono i contratti firmati, noi facciamo il preghiera in Aramaico per vedere se li troviamo, perché poi ovviamente tu immagina che quando hai un evento da 1.200 persone, i coni della legge vanno in un magazzino e io speriamo che me la cavo quando abbiamo la ricerca dei contratti. Giusto Fabri? Sono bei momenti quando dico Fabrizio che siamo in contatto della matta e li vado a mandare la bocca.

43:47 - Elena Spini (ROMI Company)
  Ecco, sicuramente una gestione magari un po' più digitale sarebbe indicata. Però va bene, ci finchiamo. Ottimo. Non so Andrea, vuoi aggiungere qualcosa? Penso che abbiamo detto tutto. O se tu hai qualche altro punto?

44:06 - Sabatino Rinaldi (Pienissimo)
  Sì, due, Andrea.

44:07 - Elena Spini (ROMI Company)
  Ah, voi entrambi, scusate. Scusate.

44:10 - Sabatino Rinaldi (Pienissimo)
  Lei è andata in un'attivizzazione, con uno e chiamati tutti e due, no? Non siete precisi quei uomini. Beh, un cittadino sull'equi.

44:22 - Andrea Galotto
  No, io, ok, tutto chiaro, Andrea, mio collega, vai.
  ACTION ITEM: Complete Salesforce account verification; share link w/ Elena + Andrea - WATCH: https://fathom.video/calls/686882530?timestamp=2663.9999

44:26 - Andrea Di Cicco
  No, io penso sia tutto chiaro, solamente se, volevo sapere se avete già ricevuto gli accessi alla piattaforma, oppure...

44:34 - Sabatino Rinaldi (Pienissimo)
  Abbiamo ricevuto la mail che ci diceva però che aspettavamo voi per fare gli accessi, giusto? Esatto. Perfetto.

44:41 - Elena Spini (ROMI Company)
  Su questo possiamo o rimanere un attimo in colla, se potete, rivediamo con chi se ne occupa, oppure possiamo schedulare dieci minuti durante la giornata e lo facciamo al volo.

44:55 - Sabatino Rinaldi (Pienissimo)
  Se non è un problema possiamo farlo anche adesso, perché l'accesso... Oh, la mail per la verifica dell'account l'ho ricevuta io all'indirizzo di fatturazione. Perfetto. Quindi, sì, poi magari quel link ce lo giriamo noi internamente e adesso più che altro.

45:14 - Andrea Galotto
  Io ragazzi mi sgancio intanto, vi lascio svolgere la parte tecnica e vi ringrazio, ci sentiamo presto. Ciao Andrea, grazie.

45:27 - Sabatino Rinaldi (Pienissimo)
  Buon lavoro, buon proseguimento.

45:28 - Elena Spini (ROMI Company)
  Ciao.

45:31 - Sabatino Rinaldi (Pienissimo)
  Quindi io dovrei rientrare in quella mail e a cliccare su verifica account, giusto? Sì, corretto.

45:38 - Elena Spini (ROMI Company)
  Guarda, se vuoi posso interrompere la registrazione e così poi magari puoi condividere lo schermo.

45:45 - Sabatino Rinaldi (Pienissimo)
  Il tema è che non mi funziona il Wi-Fi. Comunque interrompi qua e ti posso guidare. Vediamo.
