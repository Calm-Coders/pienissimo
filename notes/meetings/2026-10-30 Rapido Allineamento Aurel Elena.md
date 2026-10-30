---
id: meeting-2026-10-30-rapido-allineamento
type: meeting
status: resolved
owner: Elena Spini
with: Aurel Mrruku
org: ROMI
raised: 2026-10-30
updated: 2026-10-30
depends_on: [OI-290, OI-295, OI-298, OI-300, OI-307, OI-308]
blocks: []
source: Google Drive 1QqwvLMX8XvSq9sXa9ynaG8a-g0JxpYyKNzpQ9bTyiko
---

# 2026-10-30 Rapido Allineamento Aurel Elena

**A 27-minute ROMI-internal call booked the evening before to cover users and
permissions, which Elena Spini had forgotten in the previous day's session. It
settled the tutor access plan, overturned [OI-298](../items/OI-298%20WooCommerce%20bundle%20orders%20from%20a%20new%20customer%20do%20not%20reach%20Salesforce.md)
by reading the log on screen, and surfaced two things nobody had written down: the
Lead import will trip the duplicate rules, and Fase 2 maintenance was left out of
the estimate.**

## The record that exists

| | |
| --- | --- |
| Invite | `PIENISSIMO - Rapido Allineamento Aurel / Elena`, **30 October 10:00–10:30 CET**, sent 29/10 17:29:27Z |
| Ran | **00:27:40**, from 10:01 CET |
| Transcript | `1QqwvLMX8XvSq9sXa9ynaG8a-g0JxpYyKNzpQ9bTyiko`, 24,343 B, owner Elena Spini |
| Records mail | Gmail `1a18c2842ea3c06e`, 09:33:30Z |

**Participants:** Aurel Mrruku, Elena Spini. Elena Spini's reason for booking it,
in the invite body: _"Oggi mi sono dimenticata di parlare del tema
utenza/permessi ecc quindi facciamo un rapido allineamento per questo"_.

🟢 **The transcript is complete and in Italian** — unlike
[the 28/10 client call](2026-10-28%20Import%20Ordini.md), which Gemini lost.

## OI-298 was not a fault

🔑 **The log was read on screen and it is a success.** Elena Spini had sent Aurel
Mrruku the integration log on 29/10 believing it showed an error. He opened it:

> Aurel Mrruku: _"Vedi error è true. **Ha già fatto tutto, ha già creato
> l'ordine.**"_ … _"ordine Wcommerce ordinato. Fatto il 29."_

Elena Spini: _"Response non era 200, non era l'errore. … Io ho visto una cosa boa
di popolato 200, ho detto vabbè in errore sicuro. **Che scema.**"_

⚠ The transcription garbles the polarity (_"error è true"_ against her _"non era
200"_), but the conclusion is unambiguous and repeated: the order was created, its
id is in the log, and Aurel Mrruku read the order number back.

🔑 **Two further corrections to the 29/10 record.** The account and contact
**already existed, created on 20 October** by `amministrazione` — so the
"new customer" condition was never met: _"non è vero perché [Salesforce] non ti
lascia mentire."_ And **Fabrizio Paganelli had placed four test orders**, all
present; he simply could not find them. The remedy proposed is a **WooCommerce
list view on Orders**. ⚠ **Nothing says it was built.**

## Tutor users and permissions

🔑 **The permissions already exist.** Built by **Rexhina Hysi**, not Aurel Mrruku:
an `Agente` profile and permission set, with restrictive test users that could not
touch bundles or orders. Testable in UAT.

🔴 **And Rexhina Hysi is gone from the project** — _"Regina ormai è su un altro
progetto full time"_, leaving **Anita Aga as the only developer on Pienissimo**.
🔑 She has not left ROMI; she is reassigned. See
[her note](../people/Rexhina%20Hysi%20-%20Salesforce%20developer%20ROMI.md).

**The plan, in order:**

1. **Tuesday 3 November 14:30–15:30 CET** — Elena Spini, Aurel Mrruku and Anita Aga
   walk the permissions, Rexhina Hysi optional. Booked in the call as a TBD
   placeholder and renamed; it is the `Test PS Tutor` invite (Gmail
   `1a18c2bf516096d6`).
2. **From Wednesday 4 November** — Marco Montesi's own user loses admin and takes
   the restricted `Agente` profile. Elena Spini: _"gli toglierei la cosa di admin
   … vedi che da adesso tu sei il ruolo corretto con il profilo … ristretto"_.
3. **On his confirmation** — the other agents get users of their own.

🔑 **So the shared-account proposal of [OI-300](../items/OI-300%20Tutor%20training%20and%20tutor%20test%20access%20are%20unplanned.md)
is refused in substance.** Aurel Mrruku: _"non è che lo devi fare con tutti, Elena
… non lo possono fare perché non possono entrare"_, and in the mail that followed,
_"Anche gli altri tutor avranno un'utenza dedicata e profilata"_.

🔴 **Licences are not confirmed.** Aurel Mrruku's answer to whether they have them:
_"disabilitiamo qualcosa che abbiamo noi"_ — free one of ROMI's. ⚠ **And Elena
Spini still does not know how many tutors there are**: _"devo capire innanzitutto
quanti sono sti cavoli di tutor."_ The count on hand is **six agent codes
supplied, so five agents plus Marco Montesi**.

🔑 **Tutors test in UAT, not production** — _"Non in produzione"_.

⚠ **Training is sized twice and differently.** Here Elena Spini says _"in 2 ore me
la cavo"_, for the commercial part only; the `#tproj-pienissimo` recap four hours
later says _"rifare **un'ora** di formazione ai commerciali"_. **Nothing reconciles
them.** The date is the week of 2 November or the one after, before go-live.

## The 29/10 invoice bug, in the author's words

🔑 **It had matched on the date, and it hit about a third of the orders.** Aurel
Mrruku: _"avevo fatto il match con la data della scadenza … quelli erano già
pagati, invece tutto il resto non era [pagato], anche se la fattura era pagata"_,
and the orders stayed `Disponibile`. Scale: _"Stavamo parlando di un terzo di tutti
gli ordini"_. 🔑 **He had first blamed the missing contact**, then reasoned that the
invoice references the **order line id**, not the contact — which is what sent him
to the real cause. Reloaded, cleaned, released to production, update run.

Already on [OI-244](../items/OI-244%20Historical%20orders%20will%20be%20migrated%20from%20Mexal%20by%20spreadsheet.md)
by way of `882f53c`; the **one-third magnitude and the false trail are new here**.

## The two things nobody had written down

- 🔴🔑 **The Lead import will trip the duplicate rules.** The masked
  `XXXXXXXXXXX` in the P.IVA column collides. Aurel Mrruku: _"Partita IVA quando
  c'è xx … duplicati. **Devo togliere le regole di duplicazione solo per
  l'import.**"_ →
  [OI-307](../items/OI-307%20The%20Lead%20import%20needs%20the%20duplicate%20rules%20disabled.md).
- 🔴🔑 **Fase 2 maintenance was omitted from the estimate.** Aurel Mrruku expects
  _"almeno … 3-4 giorni al mese"_ — a day a week — and warns that a day-a-week
  retainer is not priced like scattered hours: _"fai un passaggio anche con chi
  decide i prezzi"_. Elena Spini: _"questa me la sono dimenticata di mettere, però
  gliela dico subito a **Andrea Galotto** che gli avevo mandato la stima."_ →
  [OI-308](../items/OI-308%20Fase%202%20maintenance%20was%20left%20out%20of%20the%20estimate.md).
  🔑 **And that names the Andrea**: the Fase 2 estimate went to **Andrea Galotto**.

## Also said

- 🔑 **The `Lead from Zoho` name was never really decided.** Aurel Mrruku wanted an
  origin field, Elena Spini wanted the checkbox Sabatino Rinaldi had been promised:
  _"chiamalo come vuoi, perché l'aveva condiviso con Sabatino … Se lo vuoi cambiare
  cambialo, non mi interessa."_ Anita Aga built `Lead_from_Zoho__c` at 15:10 CET —
  [OI-295](../items/OI-295%20Leads%20imported%20from%20Zoho%20must%20be%20distinguishable%20from%20new%20leads.md).
- 🔑 **Lead against Contatti, stated plainly.** Elena Spini: _"**Io ho chiesto i
  contatti, lui ha mandato i lead.**"_ Aurel Mrruku: _"il discorso l'avevamo fatto
  su contatti, non sui lead."_ →
  [OI-290](../items/OI-290%20Lead%20and%20Referenti%20migration%20data%20is%20owed%20by%20the%20client.md).
- 🔑 **The DocuSign ceiling is a count, not a cost.** Aurel Mrruku: _"non è a euro,
  è con numero … hanno 2500 se non mi sbaglio"_, a couple already spent on
  configuration, and _"loro non nostro"_ if it ever bites. 🔑 **A signature-free
  test path exists**: `pienissimo rinnovo` and `plus rinnovo` do not fire DocuSign.
  ⚠ The client wants every signature tested anyway.
- ⚠ **Aurel Mrruku is losing work in his inbox**, by his own account: _"ho già
  perso ordini perché mi arrivano 100 mail al giorno."_ Recorded as a stated
  process risk, not as an item.
