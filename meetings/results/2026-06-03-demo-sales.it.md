# [ROMI-PIENISSIMO] Demo Sales — 03/06/2026

**Fonti:** [meetings/2026-06-03-demo-sales-transcript.it.md](../2026-06-03-demo-sales-transcript.it.md) (trascrizione originale in italiano, 93 min)

**Partecipanti:** Elena Spini (ROMI), Sabatino Rinaldi, Fabrizio Paganelli, Marco Montesi (in stanza), Elisa Migliano (Pienissimo); Daniela Morgese entrata ~16:27 e uscita ~1:20. Andrea Di Cicco citato ma non presente. Etichette dei parlanti in parte imprecise.

Scopo: demo guidata della **Sales Console** Salesforce sull'org demo di ROMI — dashboard home, viste lead/Intelligence View, pagine record, attività/task, riassegnazione owner, conversione lead, opportunità, preventivi, visibilità — più il primo abbozzo del flusso biglietti/Asset.

## Decisioni / Accordi

- **Demo sales erogata** (demo marketing fissata per il giorno dopo, 4 giugno). La piattaforma sarà usata in italiano — label standard tradotte in automatico, quelle custom da tradurre nel translation workbench.
- **Lead vs Opportunity — primo giro di allineamento.** Definizioni Pienissimo: *lead* = azione autonoma senza intento d'acquisto (iscrizione a diretta, download video gratuito); *opportunità* = interesse esplicito per un prodotto/servizio, anche da sconosciuti. Inquadramento di Daniela: **lead = ancora lavoro del marketing (nurturing, KPI marketing); opportunità = lavoro del commerciale** ("quando la palla viene schiacciata al commerciale, il cliente è già caldo"). Un lead può auto-convertirsi in poche ore tramite un form con call-to-action. Per loro non esiste lead-con-opportunità (quello è prospect/cliente). Concetto di "prospect" parcheggiato, da decidere con Daniela.
- **Tracciamento basato sui form**: ogni landing/diretta/evento ha il suo form; i form compaiono anche su video YouTube e QR code in diretta. Dimostrata la conversione Salesforce (lead → account + contatto + opportunità); lo storico campagne si conserva alla conversione (standard). **Sabatino invia un Google Sheet con i link dei form, distinti lead vs opportunità.**
- **Requisito analitico chiave di Daniela:** distinguere le opportunità generate su **clienti esistenti vs new business**, per fonte — oggi non tracciato; sospetta che la spesa ads (Meta/Google) raggiunga clienti che il marketing interno potrebbe servire ("ripaghiamo 50 volte lo stesso cliente"). Lead = anagrafica nuova senza interesse; le richieste dei clienti non devono consumare budget ads.
- **Requisiti raccolti per la pagina account:** mostrare il *nome locale* accanto alla ragione sociale (insegna ≠ entità legale); costo totale di acquisizione del contatto; **matrice RFM** visibile sull'account; origine campagna + storico costi per il lifetime del cliente.
- **Next Best Action (suggerimenti AI)** richiesta da Sabatino → Elena verifica le licenze *(risposta il 16/06: solo Einstein di Marketing Cloud, a consumo — parcheggiata)*.
- **CreditSafe/Anticipay emerge per la prima volta:** integrazione API esistente su Zoho che auto-compila l'anagrafica azienda (P.IVA, ragione sociale, sede legale, legale rappresentante) — oggi scatta al preventivo/ordine, non alla creazione account. Daniela: i dati corretti servono molto prima (marketing su dati sbagliati è inutile); emerge anche che Sabatino sta implementando il **double opt-in** sui form, che può sistemare il problema alla fonte. Timing della chiamata CreditSafe da definire.
- **Fasi opportunità (design Pienissimo):** negoziazione (con sottolivelli: primo appuntamento/trattativa, preventivo inviato, recall preventivo) → rinviata / persa / vinta. Sabatino ha inviato il diagramma via WhatsApp. Il preventivo si genera in Salesforce (oggetto Quote standard → PDF → DocuSign per la firma); task di recall/escalation con ritardi visibili al responsabile commerciale.
- **Modello di visibilità:** ~6 commerciali; default = restringere e poi ampliare (mai il contrario); gerarchia speculare all'organigramma (già fornito nella survey); le dashboard di ogni commerciale si filtrano sui suoi record.
- **Fasatura fatturazione:** opportunità vinta → si crea l'Ordine in Salesforce → scatena la fatturazione Mexal. Analisi anticipata ora, build in fase 2 (post-settembre); Fabrizio insiste che le regole di fatturazione differiscono per linea di business e vanno progettate prima di settembre. Prima menzione che **Pienissimo possiede già le licenze API Mexal** — documentazione da inviare.
- **Concetto Asset per i biglietti (proposta di Elena, da validare con Daniela):** record Asset che unisce ordine + contatti; stati stand-by (bonifico in attesa) → ready; documenti privacy/non concorrenza firmati raccolti come File sotto l'asset; **la firma genera il QR code (= il biglietto)**; scansione all'evento → check-in. Caveat di Fabrizio: il flag fattura-pagata condiziona la disponibilità; **non tutti i contatti dell'account partecipano** (decide il titolare, nel limite dei biglietti); serve un approfondimento dedicato — "è il fulcro del nostro business".

## Azioni

| Attività | Responsabile | Stato |
|---|---|---|
| Inviare Google Sheet dei link form, distinti lead vs opportunità | Sabatino | Aperta — sollecitata il 08/06 e rivista live il 16/06, lista completa ancora pendente |
| Verificare disponibilità licenze Next Best Action / Einstein | Elena | Fatta il 16/06 — non licenziata (solo Marketing Cloud, a consumo); parcheggiata |
| Definire il timing della chiamata CreditSafe/Anticipay (creazione account vs ordine) + reimplementare l'integrazione | ROMI + Fabrizio | Aperta — prosegue come punto 21 del tracker |
| Definire campi e flusso del double opt-in sui form | Sabatino + Fabrizio | Aperta |
| Definire regole di recall/escalation preventivi; poi configurare i flussi | Congiunto | Aperta — confluita nel lavoro sul flusso lead/opty |
| Definire regole territorio/visibilità; configurare sharing dall'organigramma | Congiunto | Aperta |
| Inviare la documentazione API Mexal a Elena | Fabrizio | Fatta — consegnata con gli 8 CSV (inizio luglio) |
| Validare con Daniela il flusso Asset/biglietti (QR vincolato alla firma) | Sabatino | Fatta — approfondimento tenuto il 08/06, direzione confermata in seguito |
| Inviare minuta; confermare la sessione tecnica dell'8 giugno con Daniela | Elena / Sabatino | Fatta (sessione tenuta il 08/06) |

## Note

- L'org mostrata è la demo di ROMI (visibili licenze extra, es. Einstein, Maps — "fate finta che non ci sia").
- Discusse le regole di deduplica (chiavi di matching lead↔account, es. P.IVA/società) per account multi-contatto e lead ricorrenti.
- La richiesta di automazione di Sabatino (arriva un lead → auto-task per fissare una call, mail di benvenuto) confermata fattibile via flow — regole da definire nei meeting tecnici.
