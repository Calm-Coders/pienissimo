---
id: OI-369
type: open-item
status: open
owner: Marco Montesi
with: Fabrizio Paganelli, Aurel Mrruku
org: Pienissimo
raised: 2026-11-16
updated: 2026-11-16
depends_on: []
blocks: []
severity: normal
source: notes/meetings/2026-11-16 Ultimi Check PROD.md
---

# OI-369 - DocuSign asks signers to register and the client expects to lose them

**Signing the first production quote on the go-live call, the client's commercial
lead saw DocuSign prompt the signer to set a password and said their customers
will not get through it. ROMI's answer was that nothing can be done about it. The
agreed mitigation is that tutors warn each customer by phone, and the client
accepted that they will be calling people who get stuck. Nobody owns writing the
briefing, and the person who raised it has resigned.**

## What was said

Mid-signature, Marco Montesi interrupted:

> _"questa cosa che viene fuori adesso di Docusign … **qui sembra quasi che uno si
> debba registrare** o qualcosa del genere, cioe su questa cosa ci dobbiamo guardare
> perche secondo me **i nostri clienti digitalmente qui si perderanno, non sapranno
> cosa fare**. Vedi che ti dice imposta una password."_

He noted the signer can proceed without registering — _"in realta se si va avanti
non c'e bisogno di registrarsi, pero qui ce li perdiamo completamente."_

Aurel Mrruku: _"**non ci puoi fare niente** a sta cosa perche non hai potere … una
cosa che fa DocuSign e lo fa apposta perche e un'utenza."_

Fabrizio Paganelli's mitigation: _"si tratta di spiegarglielo ai clienti nel
momento in cui il tutor ci parla … ti arriva il coso da firmare, ti chiedera di
registrarti."_ And: _"se non ci si puo fare niente non vedo alternative."_

Marco Montesi accepted it, with a prediction:

> _"se non si puo fare niente ce lo teniamo cosi. Pero l'importante e dire tutto
> quello che devono dire ai clienti, sennò qui non ci torna indietro niente.
> **Inizialmente tocchera chiamare i clienti ogni volta che qui si perderanno e
> succedera di ogni.**"_

## Why it stays open

- **The mitigation is a briefing nobody has written.** _"dire tutto quello che
  devono dire ai clienti"_ is the whole plan, and no owner, text or date was set
  for it.
- 🔴 **The person who raised it is leaving.** Marco Montesi is the resigning
  commercial lead ([OI-357](OI-357%20The%20client%20commercial%20lead%20and%20the%20web%20counterpart%20are%20both%20leaving.md)),
  and the tutors he would brief are his team.
- **The technical claim was not verified.** _"non ci puoi fare niente"_ was stated
  on the call and not checked against the DocuSign envelope configuration. Whether
  the recipient authentication and account-creation prompt can be reduced for this
  sending account is open — nothing in this window tested it.
- **It lands on every signed contract.** The whole quote-acceptance flow goes
  through DocuSign, so every customer meets this prompt.

## Related

- [OI-336](OI-336%20The%20quote%20PDF%20allegato%20B%20has%20no%20signature%20field.md) —
  the other unresolved signature defect, raised again on the same call
- [how the Quote acceptance email action works](../How%20the%20Quote%20acceptance%20email%20action%20works.md)
