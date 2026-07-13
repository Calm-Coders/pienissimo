# [ROMI-PIENISSIMO] Salesforce Kick-Off — 27/05/2026

**Fonti:** meetings/2026-05-27-salesforce-kickoff-transcript.it.md (trascrizione originale in italiano, 46 min — registrazione Fathom: https://fathom.video/calls/686882530)

**Partecipanti:** Sabatino Rinaldi (Pienissimo), Elena Spini (ROMI Company), Andrea Galotto (ROMI Company), Andrea Di Cicco (ROMI Company). Presenti/citati lato Pienissimo: Daniela (processo amministrativo/magazzino), Fabrizio (amministrazione/finanza). Citati ma non presenti: Giuliano Aranzetti (frontman Pienissimo), Vittorio, Giulia, Francesco.

## Contesto — come lavora Pienissimo oggi (as-is)

- **Modello di business:** azienda marketing-first, verticalizzata su ristorazione/HoReCa. Giuliano Aranzetti è il frontman; il "Metodo Pienissimo" viene erogato tramite corsi (Cameriere Venditore come corso d'ingresso, Mastery per il marketing, Calendar, ecc.), tenuti all'80–90% da Giuliano. Due aree di business principali: **vendita corsi/biglietti** e **Performance Plus** (l'agenzia di marketing).
- **Stack attuale (una triade):** WooCommerce (store: prodotti, videocorsi, libri, biglietti, acconti da vendita da palco) → Zoho CRM (ordini) → Mexal (gestionale, fatturazione). Un'integrazione magazzino-biglietti custom, sviluppata da uno sviluppatore interno, comunica con Zoho via API.
- **Ciclo di vita del biglietto:** ordine su Zoho (una riga ordine per ogni codice evento) carica il magazzino → il biglietto esiste ma **non è utilizzabile** finché la fattura non è integralmente pagata → una volta pagata diventa disponibile ("si può bruciare") → viene inviato al cliente ~60 giorni prima dell'evento (con funnel di reminder su WhatsApp, perché c'è chi compra a settembre per un evento a marzo) → biglietto cartaceo scansionato via QR al check-in del corso → scarico di magazzino. I biglietti non usati restano in giacenza (es. comprati 4, usati 2).
- **Incassi ibridi** (~50/50 o 60/40): pagamenti online da WooCommerce E bonifici diretti dopo preventivo dell'ufficio commerciale. Vendita da palco agli eventi: QR code → landing → acconto (es. 5.000 € su una vendita da 10.000 €) con carta o bonifico; il saldo viene gestito in seguito dai commerciali.
- **Storia CRM:** Salesforce è il **quarto CRM** (in passato anche Keap, poi ritorno a Zoho). Non vogliono replicare ciecamente i processi attuali su Salesforce — aperti a ridisegnare i flussi ("sentitevi liberi di proporre diverso").

## Decisioni

- **Salesforce sostituisce Zoho CRM.** Il contratto Zoho scade a **fine settembre 2026** — scadenza tassativa.
- **Priorità per il primo go-live:** magazzino biglietti + gestione presenze in sala (chi è venuto / chi no). Dati dichiarati "fondamentali", da rendere utilizzabili il prima possibile, prima della scadenza Zoho. Non serve il 100% a settembre, ma abbastanza per iniziare a usare e testare lo strumento.
- **Metodo di progetto concordato:** (1) demo generale Salesforce da parte di ROMI (oggetti, dashboard, viste), sia sales che marketing, ~30–60 min; (2) meeting dedicati per tema (con i key user giusti di volta in volta); (3) ROMI produce il **documento blueprint** che Pienissimo approva; (4) configurazione in parte in parallelo; (5) sessioni di verifica con i key user in ambienti di test. Cadenza: incontri settimanali/bisettimanali.
- **Principio per le dashboard:** prima si definisce cosa si vuole vedere, poi quali dati vanno raccolti per alimentarle.
- **Morris (AI esterna) scartata** perché sovradimensionata per 6 commerciali; si userà l'AI interna (curata da Sabatino), che potrà attingere dati da Salesforce (es. insight dalle chiamate, proiezioni Performance Plus — la parte "project" è stata tolta dall'acquisto Salesforce, il projecting passerà dal cruscotto AI interno).

## Azioni

| Attività | Responsabile | Stato |
|---|---|---|
| Inviare a Elena la lista dei key user (business + tecnici) per area tematica | Sabatino (Pienissimo) | Aperta |
| Schedulare la demo della piattaforma Salesforce (sales + marketing) | Elena / ROMI | Aperta |
| Verificare e comunicare a Elena lo stato del 3CX area commerciale (completezza setup, registrazione chiamate) | Sabatino (Pienissimo) | Aperta |
| Check interno di fattibilità: cosa si riesce a consegnare entro fine settembre (prima magazzino biglietti + presenze) | Elena / ROMI | Aperta |
| Proporre soluzione OTP/firma elettronica per consenso privacy + condizioni contrattuali (non concorrenza, non divulgazione), valida anche per i collaboratori con email personali | ROMI | Aperta |
| Completare la verifica dell'account Salesforce (mail ricevuta sull'indirizzo di fatturazione) e girare il link internamente e a Elena + Andrea | Sabatino (Pienissimo) | Avviata a fine call (problema Wi-Fi) — confermare completamento |

## Domande aperte / Rischi

- **Rischio scadenza:** il contratto Zoho scade a fine settembre 2026; Food Marketing è il 29 settembre e l'evento kickoff grande (1.500+ presenze) è il 29 ottobre. Tour + Fornaie Team Festival partono a settembre. Se la migrazione slitta a ridosso della scadenza Zoho, la gestione delle persone va in difficoltà.
- **Analisi no-show:** vogliono taggare ogni cliente con la fonte di acquisto (tour / sponsorizzata / ecc.) e un grado di no-show per fonte, con dashboard sulla composizione della sala (es. "20% della sala viene dal tour → tasso no-show 70%") per pianificare azioni di riempimento. Modello dati da progettare.
- **Centralino 3CX:** già acquistato, usato dal lato assistenza (altra azienda) ma NON dai 6 commerciali, che usano telefoni/SIM personali e registrano male le attività nel CRM. Obiettivo: chiamate registrate via 3CX dentro il CRM, con l'AI interna che restituisce ai commerciali aree di attenzione e tecniche di vendita. Stato reale del setup = "buco nero", Sabatino verifica.
- **Limite Mexal:** non gestisce ordini con più scadenze di fatturazione (vorrebbe un'unica fattura per ordine — impraticabile per contratti Performance Plus annuali da es. 20.000 € fatturati mensilmente/trimestralmente). Opzioni: costruire il modello scadenze in Salesforce (ordine + scadenze + report "cosa fatturare questo mese", esportabile e schedulabile via mail), e/o una piccola personalizzazione Mexal per l'ordine matrice con scadenze (Sabatino vuole spingerla).
- **Visibilità inter-reparto su Performance Plus:** commerciale, amministrazione ed erogazione non vedono lo stato reciproco sul cliente (pagamenti, rinnovi a scadenza contratto). Obiettivo: contenitore unico 360° in tempo reale. ROMI conferma che è il cuore di Salesforce (vista 360, collaborazione stile Chatter, regole di visibilità granulari).
- **Proiezione fatturato:** la direzione vuole la proiezione istantanea del fatturato da oggi a fine anno su Performance Plus (obiettivo 4–5 M€) — oggi è un lavoro manuale di export + Excel. Prima idea di Andrea Di Cicco: scadenze sull'ordine + report mensile, esportabile in Excel e schedulabile via mail. Da confermare in analisi.
- **Regole clienti dormienti:** es. una venditrice ha 1.600 clienti assegnati e prende in automatico ogni opportunità, anche i risvegli generati dal marketing. Obiettivo: regola di dormienza configurabile (6/7/8 mesi senza acquisti → tag "dormiente") con libertà per la direzione commerciale di riassegnare. Le regole di assegnazione Salesforce lo permettono — **Pienissimo deve definire le regole**.
- **Vincoli legali sulla firma:** la sola visualizzazione non basta; serve OTP o un "accetta" esplicito legato a nome/cognome. Deve coprire anche i collaboratori che accompagnano il titolare, che di solito hanno solo email personali (nel mondo HoReCa i camerieri non hanno email aziendali). Oggi: moduli cartacei stampati dal cliente, portati al corso, archiviati in un magazzino fisico (ricerca da incubo in caso di contenzioso). ROMI proporrà un flusso digitale (in fase di acquisto, di invio biglietto, o QR al check-in).

## Note

- Scopo di questo meeting: conoscersi, chiarire i sistemi mancanti dal questionario (Mexal era stato scritto "Metal") e definire il metodo di progetto. Gli approfondimenti sono rimandati a call dedicate.
- Pienissimo può seguire il progetto con buon ritmo adesso (primo blocco di corsi appena concluso) e garantisce massima partecipazione — area definita "vitale".
- I lead sono per lo più prospect già qualificati (richieste specifiche di corso) più che lead freddi.
- Il contenitore magazzino attuale ha accumulato nel tempo soluzioni tampone senza logica d'insieme — motivo dichiarato per ridisegnare invece di replicare.
