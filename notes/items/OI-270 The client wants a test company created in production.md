---
id: OI-270
type: open-item
status: open
owner: Elena Spini
with: Sabatino Rinaldi
org: both
raised: 2026-10-20
updated: 2026-10-20
depends_on: [OI-161]
source: Gmail 1a158b6e3e4cee81
---

# OI-270 - The client wants a test company created in production

**The client has asked to create a test company in the production org, using
their own internal email addresses, because they cannot see the marketing
automation and ticketing flow anywhere else. ROMI has not answered, and the
internal plan is to tell them the request will not produce a usable test without
fake collected orders behind it.**

## What was asked

In [the 20/10 mail](OI-268%20The%20client%20proposed%20a%20go-live%20calendar%20of%2016%20November.md),
§2, Sabatino Rinaldi:

> _"Per testare l'intero flusso di marketing automation e biglietteria, che oggi
> non possiamo vedere perché non abbiamo accesso ad Automation, vorremmo creare
> in produzione un'azienda di test con le nostre email interne. Ci confermi che è
> fattibile o ci indichi un ambiente alternativo?"_

🟢 **The premise is correct and already on the record.** Marketing Cloud is only
testable in production on this project — that is how the invitation → nomination
→ PDF-with-QR chain was proved on 16 October, in production with fake data
([the 16/10 session](../meetings/2026-10-16%20UAT%20Flussi%20MKT%20Biglietti.md)).
So the client is asking for the same arrangement ROMI already used, for
themselves.

## 🔴 Why it is not a simple yes

ROMI's internal position, Elena Spini in Slack `C0C38JJ9D1T` at 19:33:53 CEST:

> _"per l'azienda Test che chiedono -.- ovviamente non so perchè voglio partire
> da li ma ok, posso provare a ri-spiegargli che hanno bisogno di ordini fake
> incassati per fare un giro pulito altrimenti non hanno nulla ....... QUINDI
> Aurel puoi ricreare con claudio dei ordini di test plese?"_

So the ask decomposes into three things, only one of which the client named:

1. **A test company record in production** — what they asked for.
2. **Fake collected orders behind it**, or the ticketing half has nothing to run
   on. This is ROMI's addition and the client has not been told.
3. **A production user for the marketing tests.** Same message, point 1:
   _"devo creare un'utenza di PROD per i test di Marketing -.- copio quella che
   sta usando ora Fabrizio ok? quale usi?"_ — asked of Fabrizio Mastracci and
   unanswered at the time of this sweep.

🔴 **It is production data, created deliberately, in an org already wired to
Mexal production** — see
[the admin-rights risk](../risks/Risk%20-%20client%20key%20users%20test%20with%20admin%20rights%20against%20Mexal%20production.md)
and [the Mexal integration risk](../risks/Risk%20-%20the%20Mexal%20integration%20is%20developed%20against%20the%20production%20ERP.md).
⚠ **Nobody has asked whether a test order created in production would be pushed
to Mexal**, which is exactly the behaviour
[OI-267](OI-267%20Loading%20historical%20orders%20would%20push%20them%20to%20Mexal%20and%20generate%20tickets.md)
documents for inserted orders in any org. **If it would, fake collected orders in
production create fake customers and documents in the live ERP.** No source
connects these two items; this note is the first place they are put together, and
it is a question, not a finding.

## What closing it looks like

ROMI answers the client — yes with a named environment and a stated data plan,
or an alternative — having first established whether the test orders reach Mexal.
