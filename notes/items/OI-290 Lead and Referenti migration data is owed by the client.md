---
id: OI-290
type: open-item
status: open
owner: Sabatino Rinaldi
with: Elena Spini
org: both
raised: 2026-10-26
updated: 2026-11-05
depends_on: [OI-244]
blocks: [go-live]
source: notes/meetings/2026-10-26 Tema Ordini Mexal.md
---

# OI-290 - Lead and Referenti migration data is owed by the client

**Lead and Referenti (Contact) data has to be migrated too, and until 26 October
the record only covered orders, invoices and tickets. The client's project
manager declined to own the extract and pointed at Sabatino Rinaldi, who was
absent from the call. The join from a Referente to its Account has no mechanism
yet beyond a promise to add the Mexal code.**

## How it surfaced

[The 26/10 call](../meetings/2026-10-26%20Tema%20Ordini%20Mexal.md). Aurel Mrruku
opened by asking whether the Contacts he will be given carry the Mexal customer
code, because without it he cannot attach a Referente to an Account. They do
not: Fabrizio Paganelli's earlier extract has a Zoho identifier in column O —
_"c'è un campo dove c'è nella colonna O il nome azienda che in realtà adesso
come adesso è un codice di X cifre."_

🟢 **Agreed mechanically in the room:**

- Fabrizio Paganelli supplies **the company list from Zoho carrying the Mexal
  code** — _"io ti passerei prese da ZO la lista delle aziende con il codice
  Mexal."_
- And **the Referenti list carrying the Mexal code** — _"facciamo in modo che
  nei referenti c'è il codice di Mexal."_
- Aurel Mrruku's fallback if that is not possible: the Zoho identifier plus a
  spreadsheet, and he joins them himself.

## Why it is open

🔴 **Fabrizio Paganelli refused to own the data**, three times:

> _"io su questi aspetti qua non so nulla. Bisogna che parliate con Sabatino."_
>
> _"i dati fatevi dare da Sabatino … ci penserà Sabatino a estrapolarli."_
>
> _"se rispondo io mi mancano delle informazioni, per cui corriamo il rischio
> che facciamo casino."_

He offered to help Sabatino Rinaldi extract from Zoho if asked, and to be cc'd
with Elisa Migliano — but the request must go directly to Sabatino Rinaldi.
⚠ **Sabatino Rinaldi did not attend**: _"C'è Sabatino stamattina che non ho
visto."_

🟢 **Elena Spini raised it the same day**: Gmail `1a1786a9c1a23757`,
**13:33:24Z**, to `sabatino.r@pienissimo.com`, cc Fabrizio Paganelli,
`amministrazione@pienissimo.com` and Aurel Mrruku:

> _"durante la call di questa mattina con Fabrizio abbiamo affrontato il tema dei
> dati relativi a **Lead** e **Referenti** … per procedere con la migrazione,
> avremmo bisogno dei dati da importare per: Lead; Referenti (ti ricordo, a
> questo proposito, l'importanza di verificare la corretta associazione tra
> l'Azienda/Account e il rispettivo Referente). Fabrizio è già allineato sul
> punto: puoi fare riferimento direttamente a lui come primo contatto per il
> passaggio dei dati."_

referencing
[the data model workbook](../The%20Campi%20Oggetti%20Flussi%20e%20Utenti%20workbook.md)
as the field structure. ⚠ **Unanswered as at this sweep.**

## The open problems

1. 🔴 **No date and no owner confirmation.** The mail asks; Sabatino Rinaldi has
   not replied, and he is the person who on 21/10 told ROMI _"mi aspetto da
   parte vostra dovete portarci una soluzione"_ about the ticket balance. The
   extract is needed before the **13 November 09:00** file deadline.
2. 🔴 **Zoho cannot fill the agreed field set.** Fabrizio Paganelli: _"questi qui
   sono campi che sono stati aggiunti e io su Zoo [Zoho] non ce li ho e io non ve
   li do vuoti dopo."_ So the data model ROMI reviewed with Sabatino Rinaldi
   asks for fields the source system does not hold, and nobody decided what
   happens to them.
3. ⚠ **The Account join is the stated risk, not the fields.** Elena Spini: _"la
   difficoltà dei referenti sarà poi quella di associare il referente all'ID di
   account corretto."_ The Mexal code is the proposed key; whether Zoho holds it
   on every Referente is unverified.
4. ⚠ **The field sets were reviewed but never exercised.** Elena Spini: _"abbiamo
   rivisto i campi con lui, non abbiamo mai visto un'estrazione di dati."_
5. 🔑 **Consents ride on the Lead.** _"tutta la storia dei consensi se li
   riprende dal lead"_ — so a Lead migration that drops consent fields has a
   compliance consequence, and nothing addresses it.
6. ⚠ **No register row covers Lead or Contact migration.** As with ticket
   migration
   ([OI-274](OI-274%20The%20historical%20ticket%20balance%20has%20no%20migration%20path.md)),
   the absence is itself the finding — and it lands four days after ROMI asked
   the client to route out-of-scope requirements through Change Requests
   ([OI-285](OI-285%20ROMI%20asked%20the%20client%20to%20route%20future%20out%20of%20scope%20requirements%20through%20change%20requests.md)).
   🔑 **Nobody called this a CR either.**

## Terminology

_"Referenti uguale contatti"_ — confirmed in the call. The client's **Referente**
is the Salesforce **Contact**.

## 2026-10-27 - a deadline exists, the join is identified, and a contacts export appeared

🟢🔑 **A hard date was set: Monday 2 November.**
[The internal follow-up](../meetings/2026-10-27%20Follow-up%20Interno.md),
`00:22:45`–`00:24:36`:

> **Aurel Mrruku:** _"Elena, là io me ne frego. **Non gli possiamo mandare 10
> mail** per avere un po' di attenzione. Andiamo in live, abbiamo finito. Amen.
> Non ci avete risposto. C'era una data entro queste. **Dobbiamo essere rigidi su
> ste cose.**"_
>
> **Elena Spini:** _"La data però manca, **quindi è colpa mia** … faccio io il
> follow up e gli dico se non mi date questa risposta entro tot."_
>
> **Aurel Mrruku:** _"lunedì prossimo o venerdì, **entro lunedì**."_
>
> **Elena Spini:** _"**Entro lunedì prossimo** dobbiamo avere questi dati."_

🔑 **This closes the "no date" half of problem 1 above** — internally. ⚠ **The
follow-up mail had not been sent as at this sweep**: nothing to
`sabatino.r@pienissimo.com` exists after the 26/10 request, and Elena Spini
acknowledged her original mail carried no deadline. **The deadline is a ROMI
intention, not yet a client commitment.**

⚠ **Sabatino Rinaldi has still not answered the 26/10 request** — second day. He
_has_ replied on the ticketing and communications thread (quoted in Slack on
27/10; see
[OI-242](OI-242%20The%20community%20Rinuncia%20button%20must%20show%20the%20public%20refusal%20text.md)
for the source caveat), so he is reachable and responsive on other subjects. 🔑
**That makes the silence on this one selective, as with the Change Request
paragraph.**

🟢🔑 **The Account join is identified — and it is not the Mexal code.**
`00:25:42`–`00:28:46`. The client's file carries `nome azienda` and a **`codice
cliente esterno`** that matches the Salesforce account:

> **Aurel Mrruku:** _"vedi che c'è qua a destra … c'è nome azienda e questo nome
> azienda qua stava su [aziende e account] … Praticamente c'è il **codice cliente
> esterno** e io gli ho chiesto di mettermi su una mia azienda il codice cliente
> esterno."_
>
> **Elena Spini:** _"basta che ci confermano sta cosa la portiamo."_

So the proposed key is the **external customer code** already present in the
client's export, proven on one test account, and **awaiting client confirmation**.
This supersedes problem 3 above, where the Mexal code was the candidate — though
⚠ both may be the same identifier under two names; nothing in the call
establishes that.

⚠ **Both admitted the referenti structure is still unclear to them.** Aurel
Mrruku: _"Io non ci ho capito un tubo sui referenti perché ha fatto quel casino
Fabrizio … Bastava prendere quell'elenco e amen."_

🆕 **A Zoho contacts export now exists in Drive.** `Contatti_Zoho_CRM_`, Google
Sheet `18Jif9_B4yEhybsS6bQLzilNu4kykvYTwqA56seugyaU`, **10,767,377 bytes**, owner
`a.mrruku@romicompany.com`, **created and last modified 2026-10-27 16:48Z** —
roughly fifteen minutes before the follow-up call, and consistent with the file
the two of them opened during it.

⚠ **Not opened. It holds real contact records** —
[docs/publishing.md](../../docs/publishing.md). Recorded by id, size, owner and
timestamp only. 🔑 **Its provenance is not established**: nothing states whether
it is the client's delivery against this request, an earlier export Fabrizio
Paganelli had already shared, or ROMI's own conversion of one. **It is not
evidence that the client has delivered.**

🔴 **Unchanged:** the Zoho source still cannot fill the agreed field set, nobody
has decided what happens to the fields it cannot fill, consent migration is
unaddressed, and no register row covers Lead or Contact migration.

## 🟢 2026-10-28 - the Referenti file arrived, and the deadline moved forward

🟢 **The follow-up mail was sent.** Elena Spini, Gmail `1a1786a9c1a23757`,
**09:18:11Z**, to Sabatino Rinaldi and Fabrizio Paganelli, cc
`amministrazione@pienissimo.com` and Aurel Mrruku — a chase on the 26/10 request,
tying it to the go-live date. ⚠ The 27/10 record noted it had **not** been sent;
it was sent the next morning.

🟢🔑 **The client answered within ninety seconds, and it was not Sabatino
Rinaldi.** `amministrazione@pienissimo.com` (Elisa Migliano), **09:19:28Z**:

> _"Ciao Elena, **ci stiamo lavorando io e Sabatino, entro domani provvederemo a
> passarvi la lista**. Rimaniamo a disposizione per ulteriori informazioni"_

Elena Spini acknowledged at 10:37:13Z. 🔑 **So the commitment is Thursday
29 October** — three days earlier than the Monday 2 November ROMI had set for
itself internally on 27/10, and this one **is** a client commitment in writing,
which the Monday date never was. ⚠ It covers _"la lista"_, singular; whether that
means Lead, Referenti or both is not stated.

🟢🔑 **The Referenti half was delivered the same afternoon.** Fabrizio Paganelli,
in the Import Ordini thread (`1a183243caec3e01`, **15:32:30Z**, cc Elena Spini,
Sabatino Rinaldi, `amministrazione@`):

> _"**Abbiamo ricreato il file dei referenti salesforce. È il V2**"_

The file is **`Referenti Salesforce_V2.xlsx`**,
`1tHPebvZvnPh0DwDSbmxtEpgOkfY_XDs-`, **14,239,851 bytes**, owner
`fabrizio.pienissimo@gmail.com`, created **15:30:32Z**, in the client's own
`REFERENTI` folder beside the 21/10 `Referenti Salesforce.xlsx` it supersedes.
Elena Spini posted the link in the ROMI DM at 16:38:29 CET as _"file referenti
che hanno dato Fabrizio e Sabatino"_ — 🔑 **naming Sabatino Rinaldi as a
co-author**, which is the first evidence in these records of him acting on this
request.

⚠ **Not opened.** It holds real contact records — see
[docs/publishing.md](../../docs/publishing.md). Recorded by id, size, owner and
timestamp only. ⚠ **It has not been checked**: Aurel Mrruku, Slack 16:40:40 CET,
_"si ho visto la mail ma lo devo analizzare appena finisco con le fatture."_
Whether it carries the `codice cliente esterno` join — the whole point of
problem 3 — is **unverified**.

🔴 **The Lead half is still outstanding**, and it grew a requirement the same
evening: see
[OI-295](OI-295%20Leads%20imported%20from%20Zoho%20must%20be%20distinguishable%20from%20new%20leads.md).

🔑 **Sabatino Rinaldi appears to have attended the 14:07 call**
([Import Ordini](../meetings/2026-10-28%20Import%20Ordini.md)), whose meeting
chat shows the data-model workbook being opened at the half-hour mark — so the
field mapping was very likely walked with him. ⚠ **The transcript is unusable**,
so what he agreed to is not recorded. The "selective silence" reading of 27/10 is
superseded: he is now engaged on this thread, through Elisa Migliano and in
person.

🔴 **Unchanged:** the Zoho source still cannot fill the agreed field set, nobody
has decided what happens to the fields it cannot fill, consent migration is
unaddressed, and no register row covers Lead or Contact migration.

## 🟢 2026-10-29 - the Lead half arrived, from Sabatino Rinaldi himself, on the day he committed to

🟢🔑 **The client met the commitment.** Sabatino Rinaldi, Gmail `1a186fc3e17d7577`,
**2026-10-29 09:27:06Z**, to Aurel Mrruku, cc Elena Spini,
`amministrazione@pienissimo.com` and Fabrizio Paganelli, with
**`lead-da-importare.csv`** attached:

> _"Buogniorno, **ho preparato il CSV dei Lead da importare**, secondo le
> indicazioni che ci siamo dati ieri. **Questi Lead sono utenti che non hanno mai
> acquistato nulla in Pienissimo.**"_

Elisa Migliano's _"entro domani"_ of 28/10 09:19Z meant Thursday 29 October, and the
file came at 09:27Z that Thursday. 🔑 **Both halves are now delivered** — Referenti
V2 on 28/10, Lead on 29/10.

🔑 **And it came from Sabatino Rinaldi directly.** Every prior reference to him in
these records was a relay — Elena Spini's report of a DM, Fabrizio Paganelli
pointing at him, a name on an invitation. **This is the first message in his own
words to reach this mailbox**, and it supersedes the "selective silence" reading
that the 27/10 record raised and the 28/10 record had already overtaken.

### The file, and what the record holds about it

- **`lead-da-importare.csv`**, attached to the 09:27:06Z mail; also in Drive as
  `1P7oWyZrfg5SlKVbTJtMDK1HDllYjs5ZH`, **1,621,714 bytes**, owner
  `a.mrruku@romicompany.com`, created 09:27:06Z.
- A Google Sheet conversion, `lead-da-importare`,
  `1yLlFmZNfn1rURAR0hHfyvlg729c1H0crX7w_jsRXTAw`, **565,809 bytes**, created
  **09:51:52Z** — so it was converted within half an hour of arriving.
- ⚠ **Neither was opened.** They hold real Lead records — see
  [docs/publishing.md](../../docs/publishing.md). Recorded by id, size, owner and
  timestamp only. **Row count unknown.**

### Two rounds of correction the same day

Aurel Mrruku, **09:55:32Z**:

> _"riesci per cortesia ad **escludere i carattiri speciali** perche mi faranno
> esplodere l'import. E ti chiedo la cortesia di **condividere il file in formato
> exel**."_

Sabatino Rinaldi, **09:56:37Z**: _"Ok a breve sistemo"_. Then **13:08:02Z**, with a
fresh attachment: _"Credo che adesso sia corretto"_.

⚠ **"Credo" is not a verification.** Nothing in the record says the second file was
checked, that the special characters are gone, or that it arrived as Excel rather
than CSV. ⚠ **The 13:08 attachment was not opened either**, for the same reason.

### What the delivery does not settle

1. 🔴 **The `codice cliente esterno` join is still unverified** — on the Referenti
   V2 of 28/10 and on this Lead file. It was the whole point of problem 3 above and
   nobody has opened either file to check.
2. 🔴 **`Lead from Zoho` still does not exist.** Every row in this file carries
   status `New` by the client's own account, which is precisely the condition
   [OI-295](OI-295%20Leads%20imported%20from%20Zoho%20must%20be%20distinguishable%20from%20new%20leads.md)
   exists to resolve — **and the field must be built before this file is loaded.**
3. 🔴 **Unchanged:** the Zoho source still cannot fill the agreed field set, nobody
   decided what happens to the fields it cannot fill, consent migration is
   unaddressed, and **no register row covers Lead or Contact migration.**
4. ⚠ **"Utenti che non hanno mai acquistato nulla" is a scope statement nobody
   agreed.** The client has decided which Zoho records count as Leads — the
   never-purchased ones. That is a reasonable rule and it is **his** rule; it is
   recorded nowhere else, and it implies the remaining Zoho contacts are expected
   to arrive as Accounts or Referenti instead.

## 🔴 2026-10-30 - the Referenti half is NOT delivered, and the 29/10 record was wrong

🔴🔑 **The "both halves are delivered" reading of 29 October does not hold.** Three
independent sources on 30 October say the Referenti/Contatti tracciato is still
outstanding.

**1. Elena Spini by mail**, Gmail `1a18be1a3980c8bd`, **08:16:11Z**, to Sabatino
Rinaldi and Fabrizio Paganelli, cc Aurel Mrruku and
`amministrazione@pienissimo.com`:

> _"Ok Sabatino grazie, torniamo da te in caso di problemi. Mentre vi ricordo che
> **rimaniamo in attesa del tracciato dei referenti/contatti.**"_

**2. The internal call**, [10:01 CET](../meetings/2026-10-30%20Rapido%20Allineamento%20Aurel%20Elena.md),
where the confusion is named outright:

> Elena Spini: _"**Io ho chiesto i contatti, lui ha mandato i lead.**"_
>
> Aurel Mrruku: _"Ma **il discorso l'avevamo fatto su contatti, non sui lead**."_

**3. The project channel**, `#tproj-pienissimo` **15:30 CET**, under _Dati del
cliente_: _"**il tracciato dei Referenti non è ancora arrivato.** Lead ok."_

### What this corrects

🔑 **`Referenti Salesforce_V2.xlsx`, delivered 28/10 15:30Z, is not the tracciato.**
The 28/10 and 29/10 records treated its arrival as satisfying the Referenti half.
It was never opened — it holds real contact records — and ROMI, who can see it, are
still asking for the deliverable. ⚠ **Whether V2 is wrong, incomplete, or simply
not what was asked for is not stated by anyone.** What is stated is that they are
waiting.

🔑 **And the 29/10 Lead file was delivered against a request for Contacts.** Sabatino
Rinaldi met a commitment — but not the one Elena Spini had made. The Lead file is
accepted (_"Lead ok"_, _"Sembra meglio di quella schifezza che ci aveva mandato"_);
the Contacts are owed.

### The new commitment

**2 November — Sabatino Rinaldi and Fabrizio Paganelli to deliver the Referenti
tracciato**, per the `#tproj-pienissimo` next steps. 🔑 **That is two days before the
13 November single-pass production import** confirmed in the same recap, and
🔴 **the join question this note opened on — whether a Referente carries the Mexal
customer code — is still unanswered**, because no tracciato has arrived to carry it.

### The Lead half

🟢 Delivered and accepted. The corrected Excel is **`lead-da-importare.xlsx`**,
`1M11As2y1bzSAWEAlqDx4qEviuSguSg6Q`, **1,002,783 B**, created 29/10 13:08:02Z,
opened by the account holder on 30/10 09:23:13Z. ⚠ **Not opened by this run** — real
Lead records; recorded by id, size and timestamp only, **row count still unknown**.

🔴 **Two things now block the Lead load**, neither of them the client's:
[OI-307](OI-307%20The%20Lead%20import%20needs%20the%20duplicate%20rules%20disabled.md)
(the masked VAT placeholders trip the duplicate rules) and
[OI-295](OI-295%20Leads%20imported%20from%20Zoho%20must%20be%20distinguishable%20from%20new%20leads.md)
(the marker field is built but sits on an unmerged branch).

## 🔴 2026-11-02 - the Referenti tracciato missed its 2 November date, and the Lead file is not loaded

Two corrections from
[the Tema Contratti WooCommerce call](../meetings/2026-11-02%20Tema%20Contratti%20WooCommerce.md),
both from the transcript.

🔴 **The Referenti tracciato did not arrive on 2 November.** Aurel Mrruku believed
it had — _"ha già inviato tutto, ha fatto un check, sembra che tutto sia a posto"_ —
and **Elena Spini corrected him on the call**: _"I lead li ha mandati, i referenti
mancano … Quindi quelli ci mancano ancora."_ **Fourth consecutive record** on which
ROMI, who can open the files, say the Referenti half is outstanding.

🔑 **And the Lead file is still not in production.** Aurel Mrruku, same breath:
_"però gli devo caricare in produzione adesso."_ The file arrived 29 October; four
days later it is loaded nowhere. 🔴 **`Lead_from_Zoho__c`, the field that must mark
these rows, is still only on `DevAnita30`
([OI-295](OI-295%20Leads%20imported%20from%20Zoho%20must%20be%20distinguishable%20from%20new%20leads.md)),
and nothing writes it.**

🆕 **A new date: Wednesday 4 November, 09:00-09:30.** Fabrizio Paganelli:
_"Adesso oggi sabatino non c'è, però io per mercoledì non c'è problema … Mercoledì
mattina alle 9:00"_; Aurel Mrruku: _"Sì, 9:30, non un problema."_ ⚠ **The commitment
comes from Fabrizio Paganelli on behalf of an absent Sabatino Rinaldi**, which is
how the 2 November date was set too.

🆕🔑 **A second extract is now expected, not just the missing half.** Aurel Mrruku
asked for _"tutti i lead e tutti [i] contatti fino a quel momento"_ to go in with
the pre-load — _"anche con quello vado su nello stesso momento"_ — so the delivered
Lead file becomes a first pass and a **refreshed Lead + Referenti extract** is owed
for the production run. See
[OI-310](OI-310%20The%20production%20load%20needs%20a%20pre-load%20and%20a%20delta%20run.md).

🔑 **The vocabulary gap that caused the original confusion was named out loud** —
Aurel Mrruku: _"Sai che ci sono i referenti che noi gli chiamiamo contatti."_ ⚠ It
is the fourth time this has had to be explained, and it is why a Lead file was sent
against a Contact request.

🔴 **Eleven days to the handover** (12-13 November), with **Fase 2 approval due the
same day**.

## 🟡🔑 2026-11-04 - the client's answer: reuse the file we already sent, update next week

**The 9:00-9:30 slot promised for 4 November produced nothing. The answer came by
mail in the afternoon instead, and it is a reversal of what ROMI has been told
for five days.**

🔑 **Fabrizio Paganelli, 15:56Z, subject `Referenti`, to Aurel Mrruku and Elena
Spini, cc amministrazione and Sabatino Rinaldi:**

> _"Per i Referenti considerate il file che vi abbiamo inviato l'ultima volta. **La
> settimana prossima con Sabatino vi invieremo l'aggiornamento.**"_

🔑 **So `Referenti_V2` is the deliverable after all.** For five consecutive records
ROMI, who can open the files, has said the Referenti half was outstanding —
_"I lead li ha mandati, i referenti mancano"_ (30/10, 02/11). The client's position
is that it was delivered and only needs refreshing. **Later evidence wins on the
question of intent: there is no second tracciato coming before next week.**

## 🔴 And Aurel Mrruku says the file cannot be used

Same thread, 16:05Z:

> _"i referenti non hanno il codice mexal del account… **Non li posso collegare in
> produzione senza quel valore.**"_

Which is the exact join this item was opened for on 26 October. Fabrizio
Paganelli's reply at 16:21Z puts the burden back on ROMI:

> _"Se non ricordo male, vi avevamo già inviato un file con il codice mexal
> dell'account. **Potete verificare?**"_

🔴 **Unanswered at this sweep.** ⚠ **The verification is a repository action nobody
has done**: the delivered workbook has not been opened here (it holds real
customer records) and no note records which columns it carries.

## 🔑 The file is a week stale, and dated for the first time

From the open line after
[the 04/11 session](../meetings/2026-11-04%20Continuazione%20Test%20e2e%20PROD.md),
Pienissimo staff among themselves: the extract ROMI holds is from **27 or 28
October** — _"quello che hai fatto te, che avevamo fatto l'altra volta, era del 27
o 28 ottobre se non ricordo male"_ — so roughly **a week of new contacts is
missing**, which they also quantified: _"in pratica una settimana in più abbiamo di
contatti."_

🟢 **Their plan matches the mail**: hand over the stale file now, refresh next week,
and re-deliver everything — _"te inizia a dargli quello, poi glielo abbiamo
aggiornato"_, _"gli dobbiamo ridare tutto dopo"_, including both the contacts
already imported and the new ones.

🔴 **And the client's own man says he cannot do it alone:** _"ho bisogno che
qualcuno su sta roba dei contatti mi dà una mano. **Non posso fare tutto da
solo.**"_ He has 12-13 November for the load and the Pienissimo 360 migration in
the same window.

## What Aurel Mrruku actually needs, restated on the call

> _"i contatti principali che si collegano agli account … **devono avere il codice
> Mexal al posto dell'ID dell'account, quindi ID Mexal sulla colonna account**, non
> i lead, i contatti, **i referenti**."_

And the owner, in his words: _"i contatti che mi deve passare Sabatino."_
⚠ **Sabatino Rinaldi has still not appeared in any source in this window**, and
Fabrizio Paganelli volunteered to produce them himself instead — _"vedo di darteli
io"_ — which is how the two previous dates were set and missed.

🔴 **Eight days to the handover** (12-13 November), **Fase 2 approval due the same
day**, and the Lead file delivered on 29 October is still not loaded into
production.

## 🟢 2026-11-05 - 17,652 Referenti loaded into Prod, each under its Azienda

`Referenti Salesforce_V2.xlsx` **does** carry a `Codice cliente Mexal` column, filled
on 17,759 of 67,547 rows. On Aurel Mrruku's rule — link by Mexal code, no link no
insert — Claude Code loaded every resolvable row into **Pienissimo Prod**. Values
are not copied here.

| Of 67,547 rows                                     | Rows   |
| -------------------------------------------------- | ------ |
| Inserted, `AccountId` = the Azienda with that code | 17,652 |
| Skipped - no Mexal code                            | 49,788 |
| Skipped - code not on any Prod Azienda             | 107    |

- **Bulk API** `750SW00000bMjSfYAK` (1-row sample, checked first) and
  `750SW00000bMr6pYAC` (17,651), 17:00-17:25Z: **0 failures.** 6,872 Aziende now
  have Referenti. No `AsyncApexJob`, no `Integration_Log__c`.
- 🆕 **`Contact.External_CRM_ID__c`** (text 18, external id, unique) created to hold
  the Zoho id, so the 12-13/11 delta can upsert instead of duplicating: deploy
  `0AfSW000001LDbB0AW`; read/edit through `Full_Permission` (FieldPermissions row
  added in Prod, same entry added to source).
- 🔑 **The `Update_Contact_Consent` flow was switched off for the load**, on Aurel
  Mrruku's choice, so the import created no Marketing email Opt-In for contacts
  without consent ([the flow](../flows/The%20Update%20Contact%20Consent%20flow%20in%20production.md)).
  ⚠ This flow type **cannot be reactivated**: it was restored as **version 2**,
  logic identical to v1 (Tooling metadata compared), plus a description, deploy
  `0AfSW000001LDjF0AW`, then activated. **Active version now `301SW00000hKT1uYAG`.**
- Mapping: owner `Amministratore Pienissimo`; `Opt-out e-mail` →
  `HasOptedOutOfEmail` (960); `Contatto amministrativo` → `Ruolo__c =
Amministrativo`; `Ruolo iscrizione` → `Ruolo_Iscrizione__c`; two-digit birth years
  read as 19xx, or 20xx up to 2008. **Where an Azienda had several principal
  contacts (143 Aziende, 158 rows) only the most recently created stayed principal**
  — the trigger keeps one anyway. 1,975 principals; 1,935 Aziende got
  `Email_Contatto_Principale__c`.
- 🔴 **Not loaded for lack of a Contact field**: the consent and privacy flags,
  `Consenso Finalita Commerciali`/`Profilazione`, `Keap Id Esterno`, `Nome Locale`,
  secondary email, owner and Tutor. ⚠ The consents are a data-protection question
  for the client; they are in the file and nowhere in Salesforce.
- The exceptions went to the client as an Excel (kept outside the repository).

**Still open:** the 49,788 uncoded Referenti — the client's own answer on 04/11 was
that the file would be refreshed _"la settimana prossima con Sabatino"_.

## 🔑 2026-11-05 evening - the figures went to the client, and the Mexal-code claim is answered

🟢 **Aurel Mrruku sent the exception breakdown by mail at 18:18 CET** (quoted in
Gmail thread `1a1a746c8e63d5ac`), with a reason per row in the attachment's first
column:

| Referenti | Rows |
| --- | --- |
| Inserted, linked to the Azienda with that Mexal code | 17,652 |
| Not inserted - Mexal code missing | 49,788 |
| Not inserted - **the Mexal code matches no Azienda in Prod** | **107** |

🆕 **The 107 are new.** They are not the uncoded half: they carry a code that
resolves to nothing in production, which is a different defect from an absent code
and has no owner.

🔑 **The client's `"Potete verificare?"` of 4 November is answered, internally.**
Fabrizio Paganelli's claim was _"vi avevamo già inviato un file con il codice mexal
dell'account"_. Aurel Mrruku checked and reported in the DM with Elena Spini,
12:12 CET: _"ieri ha detto che ha passato i contatti con id mexal dei account / **A me
non risulta**"_; she produced a screenshot at 13:06 (_"forse questo booo"_) and he
answered at 14:07: **_"no quello e id zohe"_** — the identifier in the file is the
**Zoho id**, not the Mexal customer code. 🔴 **This answer has not been sent to the
client**; the mail that went out states the counts, not the diagnosis.

🟢 **The file is identified at last.** `Referenti Salesforce_V2.xlsx`, Drive
`1tHPebvZvnPh0DwDSbmxtEpgOkfY_XDs-`, owner `fabrizio.pienissimo@gmail.com`, created
**2026-10-28 15:30Z**, **modified 2026-11-05 15:28Z** — so it moved today, and Elena
Spini re-surfaced it in the DM at 16:32 CET: _"c'è la versione 2 che ci avevano
condiviso, anche io l'avevo dimenticata"_, with _"vanno importati solo quelli con
codice mexal popolato"_. ⚠ **Not opened** — it holds real customer records. **What
changed in it today is unknown.**

🆕🔑 **Elena Spini escalated it to Pienissimo's marketing team**, 17:29:21Z, to
**Sabatino Rinaldi and Matteo Distaso** with Fabrizio Paganelli and amministrazione in
copy:

> _"soltanto **17.652 righe** sono state inserite correttamente … per poter procedere
> con l'import finale effettivo, dobbiamo **definire insieme come preferite gestire i
> contatti restanti** che risultano privi di un'azienda/codice Mexal di
> riferimento."_

🔑 **So the decision is now formally the client's and is stated as a blocker on the
final import** — seven days before the 12-13 November migration. ⚠ The refresh
promised _"la settimana prossima con Sabatino"_ has no date, and the week it refers
to is the migration week itself.
