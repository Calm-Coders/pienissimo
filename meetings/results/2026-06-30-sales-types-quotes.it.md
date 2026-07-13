# [ROMI-PIENISSIMO] Tipologie Vendite e Preventivi — 30/06/2026

**Fonti:** meetings/2026-06-30-sales-types-quotes-transcript.it.md (trascrizione originale in italiano, 125 min)

**Partecipanti:** Elena Spini (ROMI), Andrea Di Cicco (ROMI), Sabatino Rinaldi, Fabrizio Paganelli, Marco Montesi, Elisa Migliano (Pienissimo — stessa stanza, cambio dispositivo a metà call). Nota: le etichette dei parlanti sono molto imprecise — gran parte del contenuto etichettato "Marco" è in realtà di Fabrizio o Elisa; ricostruito dal contesto.

Base della call: l'Excel + PDF delle tipologie di vendita consegnato da Pienissimo (vendite da palco, pacchetti tutor, tutor combo, tutor one-shot, Performance Plus, vendita prodotti, Pienissimo Pro), più il loro documento di workflow lead/opty.

## Decisioni

- **Allineata la semantica Lead vs Opportunity (il risultato centrale).** Il flusso attuale di Pienissimo tratta tutto come "opportunità" dal primo contatto (Zoho è opportunity-centrico; lo era anche Keap). Mappatura Salesforce concordata: le fasi iniziali del loro workflow — *in lavorazione, non risponde, primo contatto, da ricontattare, prequalifica* — sono **Lead**; l'**Opportunità** nasce quando c'è reale intenzione d'acquisto, cioè dalla fase *appuntamento/demo* in poi (Elena inizialmente la collocava al preventivo, l'ha anticipata perché a volte i preventivi nascono già in appuntamento). Le richieste dei **clienti esistenti saltano la fase lead** e diventano direttamente opportunità. **Elena riscrive il workflow in ottica Salesforce e lo ripresenta** — è l'origine della revisione flusso poi rimandata il 07/07.
- **Meccanica stati opportunità concordata:** preventivo con validità 5 giorni → il sottostato "scaduto" è routine (le trattative vere durano di più, specie lontano dagli eventi); un preventivo scaduto si può **clonare** in uno nuovo (mantenendo lo storico del tentativo fallito). Il *chiuso-perso* lo mette il tutor a mano (l'opportunità segue in automatico); il *chiuso-vinto* è guidato dal **pagamento**, confermato manualmente dall'amministrazione in tutte le tipologie di vendita. La nota di Marco (in altre aziende si chiude alla *firma* del contratto, non al pagamento) è parcheggiata come possibile policy futura.
- **"Da ricontattare" diventa un task/alert** al commerciale (regola delle 48 ore di parcheggio), non solo uno stato.
- **Aboliti gli ordini figli per rata.** Il pattern ereditato da Zoho (ordine bundle + N ordini figli "blocco", uno per scadenza, flippati a mano in *chiuso acquisito* ogni mese, esportati in TXT su FTP, importati a mano su Mexal) viene abbandonato. Direzione di design di Andrea: l'ordine è UN oggetto; le rate diventano record dedicati di scadenziario, mantenuti in Salesforce per non perdere la reportistica sul fatturato mensile e la visibilità sulle rate non pagate (flusso di ritorno da Mexal). ROMI porta proposte concrete alla riunione fatturazione (2 luglio).
- **Gli ordini diventano immodificabili una volta fatturati.** Storicamente i tutor hanno modificato ordini già fatturati. Regola: dopo la fatturazione niente modifiche — con un set ristretto di permessi (1–2 utenti admin) per le correzioni. Confermato anche: l'ordine pacchetto tutor è immodificabile una volta accettato dal cliente.
- **I passaggi manuali delle vendite da palco restano per ora** (l'amministrazione completa a mano gli ordini WooCommerce pagati con bonifico); possibile evolutiva: l'ordine entra su Salesforce a prescindere dallo stato di pagamento, con stati distinti per carta (auto-completato) vs bonifico (in attesa).
- **Fase 2 (scadenza fine ottobre):** vendita prodotti via WooCommerce/GLS (libri, videocorsi — gli ordini devono comunque entrare) e Pienissimo Pro (prodotti della software SRL).
- **Sollevata la questione tempi Data Cloud** (Power BI vs Data Cloud per la pulizia dati): Pienissimo può partire ~metà luglio se ROMI dà l'ok entro 1–2 settimane; Elena verifica fattibilità e riferisce cosa manca. *(Risposta il 07/07: import ~1 settembre, Data Cloud inutilizzabile prima.)*
- Fabrizio rivela che **Pienissimo paga già le licenze API di Mexal** e ha un manuale API — lo invierà (premessa dell'analisi file-vs-API del 02–07 luglio).

## Azioni

| Attività | Responsabile | Stato |
|---|---|---|
| Riscrivere il workflow lead/opty in ottica Salesforce e ripresentarlo | Elena | Confluita nel punto 19 — promessa "entro il 7", lì rimandata al giovedì successivo |
| Inviare template preventivo + le mail reali inviate ai clienti (tipologie diverse) | Marco / Pienissimo | Aperta — serve per i template preventivo Salesforce e i punti firma DocuSign |
| Inviare il manuale API Mexal (licenze già pagate) | Fabrizio | Fatto — consegnato con gli 8 CSV, base dell'analisi 02–07 luglio |
| Decidere internamente come combinare la firma di preventivo + condizioni contrattuali (due firme in un solo invio DocuSign vs sequenziale) e tornare con la risposta | Pienissimo (Marco/Fabrizio/Elisa) | Aperta |
| Verificare se le licenze Salesforce attuali includono l'oggetto standard nota di credito (altrimenti progettare custom) | Andrea Di Cicco | Aperta — ~30 note di credito/anno, alcune consistenti; oggi solo su Mexal con workaround su Zoho |
| Verificare fattibilità/tempi Data Cloud e riferire cosa manca | Elena / ROMI | Risolta il 07/07 — import ~1 settembre |
| Portare proposte su ordini/rateizzazione alla riunione successiva | ROMI | Fatto — presentate tra il 02/07 e il 07/07 |

## Domande aperte / Rischi

- **Conflitto sul trigger di generazione biglietti (segnalato da Elena, non risolto):** in questa call si è detto che i biglietti/movimenti di magazzino si generano all'ordine e diventano *disponibili* al pagamento; in una riunione precedente si era concordato che i biglietti si generano **solo alla firma dei documenti**. I due flussi vanno riconciliati — cambia il design asset/magazzino.
- **Policy di creazione account per i biglietti gratuiti del tour:** il tour di settembre è ~90% pubblico nuovo; i form WooCommerce per tappa creano preventivi a zero + biglietti omaggio con dati digitati dal cliente (inaffidabili). In logica Salesforce un preventivo implica un account — quindi va creato un account per tutti, e la verifica Anticipay (oggi attivata solo all'ordine) dovrebbe scattare per ogni nuovo account. Quando/come creare gli account tenendo pulita l'anagrafica è aperto.
- **Fallback firma manuale:** alcuni clienti non gestiscono la firma digitale; serve un percorso (stampa/firma/reso) accanto a DocuSign.
- **Corner case parcheggiati:** acquisto di biglietto per un'altra azienda (mai successo consapevolmente; bloccato da policy + autodichiarazione nella firma di non concorrenza); il cambio nominativo è gestito; il tracciamento del consenso foto/video agli eventi è dichiaratamente debole e va migliorato; esiste un programma referral che può interagire con queste regole.
- **Template preventivi:** uno o più (corsi vs piattaforma vs servizi marketing) — Elena giudicherà una volta ricevuti; a variare potrebbe essere solo il corpo mail.
- Debito terminologico: "ordine/preventivo/opportunità" usati in modo intercambiabile ("l'ordine È il preventivo") — fonte ricorrente di confusione; la nomenclatura Salesforce (lead → opportunità → preventivo → ordine) è la lingua di riferimento concordata da qui in poi.

## Note

- La tubatura Zoho→Mexal descritta in dettaglio (report per scadenza → flip manuale dello stato → TXT su FTP → import manuale su Mexal → flusso di ritorno notturno ~3:00) è riconosciuta da Pienissimo come un "accrocchio" ereditato di cui nessuno sa spiegare l'origine.
- Regola di business dietro le scadenze delle rate: il cliente deve sempre aver pagato i corsi **prima** di parteciparvi; la "libertà" dei tutor sulle rate è vincolata a questo (altrimenti i biglietti non si sbloccano).
- Pricing tutor: listino fisso, niente sconti discrezionali se non autorizzati; il contenuto dei pacchetti varia col calendario accademico (settembre–maggio), non a capriccio per cliente.
- Prossima riunione fissata per giovedì 2 luglio (Mexal/fatturazione — avvenuta come da programma). Andrea Di Cicco in ferie 4–10 luglio.
