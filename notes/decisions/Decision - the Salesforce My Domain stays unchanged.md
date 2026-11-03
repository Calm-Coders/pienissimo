---
id: decision-my-domain-unchanged
type: decision
status: resolved
owner: Fabrizio Paganelli
org: Pienissimo
raised: 2026-11-03
updated: 2026-11-03
depends_on: []
blocks: []
source: notes/meetings/2026-11-03 Test e2e PROD.md
---

# Decision - the Salesforce My Domain stays unchanged

**The client refused to customise the Salesforce login URL. It stays
`ability-customization-52152`. The reason is that tutors who have already configured
their access key would have to regenerate it.**

## The offer and the refusal

In [the 3 November e2e production session](../meetings/2026-11-03%20Test%20e2e%20PROD.md),
Elena Spini offered it unprompted — the URL could carry a Pienissimo name instead of
`ability-customization-52152`:

> _"Lì prima di force.com volendo si può customizzare e mettere ad esempio pienissimo
> srl o quello che volete. Volete cambiarlo?"_

She stated the cost herself: _"la cosa che succederà è che dovrei rigenerare la
chiave"_, and Aurel Mrruku added that the **integration endpoint link** would have to
be reissued too.

**Fabrizio Paganelli refused**, twice:

> _"Mamma mia! Ti dico di no solo per tutto, solo per rigenerare la chiave."_

> _"Perché dopo devono rigenerare la chiave anche i tutor che l'hanno già fatta. Dico
> bene? … lasciamo stare così dai, chi se ne frega."_

Elena Spini accepted: _"Perfetto, va bene. Non vogliamo il cambio."_ She had noted
the timing argument — _"Prima lo facciamo, meglio è … meno persone"_ — and did not
press it.

## 🟢 What this closes

🔑 **The standing question _"whether the Salesforce My Domain was changed to
`pienissimo`"_ is answered: no, and it will not be.** It had been carried as
unreachable since the production org was stood up.

## ⚠ What it does not close

⚠ **A domain is still owed by the client, and it is not this one.** In the same
session Aurel Mrruku said _"il dominio poi lo dobbiamo aggiustare"_ and Elena Spini
_"non ce l'hanno dato, quindi mi sa che glielo dobbiamo chiedere"_ — **which domain
was never stated**. See
[OI-323](../items/OI-323%20The%20production%20domain%20has%20not%20been%20supplied%20by%20the%20client.md).
