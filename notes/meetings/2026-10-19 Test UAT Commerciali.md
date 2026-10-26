---
id: meet-2026-10-19-test-uat-commerciali
type: meeting
status: resolved
owner: Elena Spini
org: both
raised: 2026-10-19
updated: 2026-10-19
source: meetings/2026-10-19-test-uat-commerciali-transcript.it.md
---

# 2026-10-19 Test UAT Commerciali

**Marco Montesi finally got into Salesforce and was walked through the whole
commercial flow — lead to quote to tranche — on the first day of the key-user
test week. The walkthrough worked, and it also produced the longest single list
of client-found defects in the record: ten items, one of them a live server
error on the quote PDF. The client then declined a ROMI session for the rest of
the week and booked one Wednesday meeting on order migration instead.**

**Source:** [meetings/2026-10-19-test-uat-commerciali-transcript.it.md](../../meetings/2026-10-19-test-uat-commerciali-transcript.it.md)
(full raw transcript plus the Gemini notes header, 108,177 bytes, 01:45:49).
Booked 15:00–16:00 CEST; the transcript opens at `00:00:52` and ends on
_"Trascrizione terminata dopo 01:45:49"_ — so the hour booked ran to nearly two.

Participants, from the transcript header and from who actually speaks:
**Elena Spini** (ROMI) and **Fabrizio Paganelli, Elisa Migliano, Sabatino
Rinaldi, Marco Montesi** (Pienissimo). `amministrazione@pienissimo.com` is on
the invitation and does not speak.

🔑 **Aurel Mrruku was invited and was not in the call.** He is on the
invitation, he never speaks, and Elena Spini says so twice while the quote PDF
is failing: _"purtroppo arrivano tutte le mail ad Aurel, quindi io non non posso
neanche vedere cosa è successo"_ and, of her live message to him,
_"non mi sta rispondendo"_. **So the one session where the client enumerated ten
build defects had no developer in the room**, and every finding reached the
build only through Elena Spini's screenshots and notes.

⚠ **Two reading caveats a reader needs.**

1. **Marco Montesi was on another call for much of this one.** From about
   `00:18` to `00:45` the transcript carries a second, unrelated conversation in
   his voice — restaurant booking, The Fork, Instagram sponsorship, subscription
   tiers — interleaved line by line with the Salesforce walkthrough. He says so
   himself: _"tolgo l'audio perché qui c'ho tre ragazze che chiamano"_. **None of
   that bleed is Pienissimo content** and none of it is recorded here. Sabatino
   Rinaldi twice asked him to move because Elena Spini could not be heard.
2. **Dictation garbling is the usual kind and is repaired in square brackets
   inside quotations.** Salesforce renders as _"Sales SOS"_, _"Sales Force"_,
   _"salesource"_, _"saleswors"_ and _"sees forse"_; Mexal as _"Maxal"_,
   _"Mixal"_, _"Mexale"_ and _"sensor"_; Anticipay as _"Antipay"_ and
   _"Anticipay"_; `passkey` as _"pasy"_, _"paski"_ and _"pas key"_; `bundle` as
   _"bando"_, _"band"_ and _"bandle"_; `preventivo`/`quote` as _"quot"_ and
   _"quotivo"_. Marco Montesi's own address is rendered
   _"marco.m@apissimo.com"_ — the real one is `marco.m@pienissimo.com`, per the
   calendar invitation. **The login tool Fabrizio Paganelli and Elisa Migliano
   installed is rendered _"Proton"_ and is not identified further** in any
   source; it is recorded as his word, not as a named product.

## What was settled

### The user exists and the first access happened

**[OI-240](../items/OI-240%20Marco%20Montesi%20needs%20a%20Salesforce%20user%20before%20go-live.md)
is answered.** Elena Spini created the user before the call and Marco Montesi
logged in during it, after the password-reset mail did not arrive and she
re-sent it directly (`00:16:42`–`00:23:10`). He holds a **super admin** profile
_"per questa prima fase di test"_, and Elena Spini drew the line explicitly:

> _"tu come diciamo ruolo commerciale non potrai andare a modificare, ma sono
> cose che andrà potrà modificare il Fabrizio di turno perché va a toccare
> l'integrazione con M[ex]al."_

🔴 **The interim-profile question that OI-240 has carried since 15/10 is
therefore still open** — he is testing on admin rights, not on the profile he
will hold, and no source names that profile.

🔴 **And the warning that came with it is the session's biggest unmitigated
risk.** Elena Spini, `00:31:03`, on the Mexal fields on the Account:

> _"fate molta attenzione … in realtà siamo collegati con l'ambiente di M[ex]al
> di produzione, quindi attenzione a tutto ciò che è M[ex]al."_

Recorded as
[the risk](../risks/Risk%20-%20client%20key%20users%20test%20with%20admin%20rights%20against%20Mexal%20production.md).

### Sabatino Rinaldi asked for an account and got one

At `00:43:18` Sabatino Rinaldi asked _"ma io posso averlo un accesso?"_,
undertaking to look and not touch — _"io non devo fare, devo solo guardare,
quindi non farò nulla"_. Elena Spini agreed, on the same admin profile and with
the same caution, and committed to create it immediately: _"appena finita questa
call faccio l'utenza"_. She repeated it at the close.
[OI-262](../items/OI-262%20Sabatino%20Rinaldi%20needs%20a%20Salesforce%20user.md).

### Three lead-qualification changes were agreed in the room

- **The standard sector picklist values must go.** Unanimous, after Fabrizio
  Paganelli listed them — _"settore chimica, trasporti, banche … secondo me van
  tolti quelli lì"_ — and Sabatino Rinaldi closed it: _"van tolti senza dubbio.
  Van tolti tutti."_
  [OI-257](../items/OI-257%20Standard%20sector%20picklist%20values%20must%20be%20removed.md).
- **Leads whose _tipologia attività_ is _agenzia di comunicazione_ must be
  auto-blacklisted.** Sabatino Rinaldi explained that the value is deliberately
  left in the public forms as a trap — _"noi quella lì la teniamo come trappola
  … chi lo mette viene bannato"_ — and asked for automatic handling. Elena Spini
  agreed the shape: on entry, status to **non qualificato** with
  _"motivazione uscita blacklist"_.
  [OI-258](../items/OI-258%20Leads%20from%20a%20communication%20agency%20must%20be%20blacklisted%20automatically.md).
- **A free-text _Motivazione_ becomes mandatory when a lead is lost as
  _non interessato_.** Elisa Migliano wanted the value removed as too vague
  (_"è veramente troppo vago"_); Sabatino Rinaldi warned a free-text field alone
  would be left empty by salespeople; Elena Spini proposed the rule that was
  taken: _"se scegli perso non interessato, allora devi compilare
  obbligatoriamente per salvare"_. Field name agreed as **Motivazione** (Marco
  Montesi: _"motivazione basta"_).
  [OI-259](../items/OI-259%20A%20lost%20lead%20marked%20non%20interessato%20must%20carry%20a%20mandatory%20free%20text%20reason.md).

### Behaviour the session confirmed rather than changed

- **Contacts without an Account are expected.** This was the first of the four
  screenshots behind
  [OI-254](../items/OI-254%20Creating%20a%20Referente%20and%20an%20Account%20failed%20for%20the%20client.md).
  Elena Spini explained it (`00:07:11`–`00:10:31`), offered to remove the
  possibility, and the room chose to keep it: _"io forse lo lascerei, poi magari
  vi può servire"_.
- **The P.IVA check runs at account creation against Anticipay, and does not
  block.** Elena Spini, `00:34:02`: an invented VAT lets the lead through and
  sends a notification to Fabrizio Paganelli and Elisa Migliano — _"attenzione
  vedete che questo tizio ha messo la partita IVA inventata, potrete avere, anzi
  avrete problemi nella fatturazione"_. Corroborates the existing record.
- **Lead conversion produced the three objects as designed** (`00:57:17`):
  Account `Montesi Srl`, the lead's data carried onto the Referente, and an
  Opportunity created automatically, with the earlier task preserved as history.
- **Quote and Opportunity states advance in parallel** — _"vivono di vite
  parallele"_ — and the quote-expiry automation fired as designed on a
  pre-existing quote: two days after `In trattativa`, an automatic task and a
  reminder mail to client and tutor.
- **Passkey enrolment will be required at the next login** for both new users.
  Elena Spini warned them and says she sent a guide (`01:29:38`).

## What the client found broken

Seven defects, all raised by Fabrizio Paganelli or by Elena Spini watching the
screen, none of them with a developer present:

| Finding | Note |
| --- | --- |
| Generating the quote PDF failed live: _"si è verificato un errore di server interno"_ | [OI-260](../items/OI-260%20Generating%20the%20quote%20PDF%20failed%20with%20an%20internal%20server%20error.md) |
| Quote lines show no sconto, unità di misura, prezzo di listino, prezzo netto or row total | [OI-207](../items/OI-207%20The%20quote%20and%20order%20layouts%20omit%20the%20commercial%20fields%20the%20client%20requires.md) |
| Test and wrong article codes pollute the product registry; bundle-only articles are selectable on a normal order | [OI-261](../items/OI-261%20Test%20article%20codes%20pollute%20the%20product%20registry.md) |
| Opportunity `Categoria`/`Sottocategoria` values do not match the client's own, and the opportunity name is free text being used as a key | [OI-265](../items/OI-265%20Opportunity%20Categoria%20and%20Sottocategoria%20values%20do%20not%20match%20the%20client%20registry.md) |
| System labels still in English — `Mark Current Stage`, `Expiration Date` | [OI-263](../items/OI-263%20Salesforce%20system%20labels%20are%20still%20in%20English.md) |
| The quote-expiry reminder mail carries a placeholder copy | [OI-264](../items/OI-264%20The%20quote%20expiry%20reminder%20email%20copy%20is%20a%20placeholder.md) |
| The product grid does not refresh after adding a line | [OI-266](../items/OI-266%20The%20quote%20product%20grid%20does%20not%20refresh%20after%20adding%20a%20line.md) |

🔑 **Two of these the client says were already raised and agreed.** Fabrizio
Paganelli on the discounts: _"mi sembra che l'avevamo già segnalato, ma
probabilmente non c'è stato il modo il tempo"_, and later, off the main thread:

> _"a me mi fanno incazzare perché vi dico le cose, no? Però anche quella roba
> degli sconti, quelle robe lì l'avevamo già affrontata, l'avevamo già vista,
> doveva essere a posto."_

That is the first recorded expression of client frustration at re-raising build
items, and it is **about the row the client accepted into Fase 1 in writing on
16 October** (OI-207).

## What was planned

- 🔴 **No ROMI session for the rest of the key-user week.** Sabatino Rinaldi
  declined one: _"non ce lo diamo il meeting questa settimana perché vogliamo
  testarla. Venerdì ci riuniamo tutti e la testiamo da noi e dacci il tempo di
  usarla."_ So the 19–23/10 key-user window runs **client-internal**, with their
  own review on **Friday 23/10**.
- 🟢 **One meeting was booked instead: order migration, Wednesday 21/10.**
  Fabrizio Paganelli raised it (_"il tema del dell'importazione massiva degli
  ordini"_), Elena Spini sized it at an hour and took the scheduling, and
  Fabrizio Paganelli confirmed it in writing the same evening.
  [OI-244](../items/OI-244%20Historical%20orders%20will%20be%20migrated%20from%20Mexal%20by%20spreadsheet.md).
- 🟢 **Fabrizio Paganelli shows the standard sale flow to his own team on the
  morning of 20/10** — _"magari prima lo guardo con loro anche domani mattina
  che c'ho la riunione, magari fagli fare sull'ultimo della vendita standard"_.
  ⚠ He also says he has **not yet tested the package/tranche path himself**:
  _"dopo la vendita dei pacchetti, quelli tranche eccetera … ancora non ho
  neanche testato"_.
- ⚠ **Fabrizio Paganelli is sharing one login with Elisa Migliano** via the
  _"Proton"_ tool, and Elena Spini asked for a real second-user test:
  _"giusto per poi effettivamente capire se anche lei poi riesce ad accedere"_.
  So Elisa Migliano's own access is **still unverified** going into the test
  week.
- ⚠ **The _diretta_ form is still not supplied.** Elena Spini asked again
  (`00:33:01`) because the hidden fields matter for testing; Sabatino Rinaldi
  said it is created per event and is identical to the food-marketing one, and
  Elena Spini let it go: _"lo farete poi, non è un problema"_. Second recorded
  ask.

## What nobody raised

- ⚠ **The go-live date.** Fabrizio Paganelli, Sabatino Rinaldi and Elisa
  Migliano were all in the room for 01:45 and **2 November was never mentioned**
  ([OI-243](../items/OI-243%20Go-live%20moved%20from%2021%20October%20to%202%20November.md)).
  Elena Spini's only forward-looking statement was about this week.
- ⚠ **Nothing about Zoho after 31 October**, in a session that spent fifteen
  minutes on importing historical orders out of Mexal.
- ⚠ **`SAL-20`** ([OI-227](../items/OI-227%20SAL-20%20was%20rewritten%20in%20the%20signable%20requirements%20with%20no%20client%20ruling.md))
  — not mentioned, by anyone, in a commercial-flow session.
- ⚠ **The agent code for agentless WooCommerce orders**
  ([OI-214](../items/OI-214%20The%20Mexal%20order%20send%20requires%20an%20agent%20code%20WooCommerce%20orders%20lack.md))
  — Marco Montesi, the person who has owed it for twelve days, was in the room
  and was not asked.
