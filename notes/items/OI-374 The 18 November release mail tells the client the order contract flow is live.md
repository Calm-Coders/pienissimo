---
id: OI-374
type: open-item
status: open
owner: Aurel Mrruku
with: Elena Spini, Fabrizio Paganelli, Sabatino Rinaldi
org: ROMI
raised: 2026-11-18
updated: 2026-11-20
depends_on: [OI-322, OI-373]
blocks: []
severity: high
source: Gmail thread 1a1ef1149876f603, message 1a1ef1a15d272f94, 2026-11-18T14:40:26Z
---

# OI-374 - The 18 November release mail tells the client the order contract flow is live

**At 14:40:26Z on 18 November, ROMI told Pienissimo in writing that the automatic
contract generation for WooCommerce orders, with the DocuSign send, is released in
production. Fourteen minutes later ROMI's own manual-steps tracker was edited and
the row `Configure DocuSign in Prod for the attachment of the pdf in orders` was
still blank for production. The return path for a signed order contract has never
been built.**

## The mail

`Rilascio 18/11/2026`, Gmail thread `1a1ef1149876f603`, message
`1a1ef1a15d272f94`, sent **2026-11-18T14:40:26Z** by **Aurel Mrruku** to
`amministrazione@pienissimo.com`, **Fabrizio Paganelli** and **Sabatino Rinaldi**,
with **Elena Spini**. One inline `image.png` attachment, not opened.

> _"vi comunico che abbiamo rilasciato in produzione la Change Request (CR) per la
> generazione automatica dei contratti a seguito degli ordini ricevuti da
> WooCommerce. Nel dettaglio, il flusso prevede:_
> - _La generazione sia del contratto fisico che di quello digitale._
> - _L'invio tramite DocuSign, come richiesto, dopo la conferma di ricezione
>   dell'ordine da Mexal."_

It then lists six further items as released: the Italian date format, the Note
object on Account, the primary quote in the quote list view and the Opportunity
compact layout, the lead-source rename, the categoria/sottocategoria values, and
the admin-only Mexal sync component on the home page.

🟢 **It is the first release note ROMI has sent this client.** It is accurate about
most of what it lists, and it is cc'd to the people who asked for the changes.

## 🔴 Three things the mail does not say

1. **The configuration row is still blank.** The
   [manual-steps tracker](../Manual%20Steps%20Pienissimo%20tracker.md) was edited by
   Anita Aga at **14:54:08Z**, fourteen minutes after the mail went out, and the row
   _"Configure DocuSign in Prod for the attachment of the pdf in orders"_ still reads
   `Done` for UAT and **blank for production** →
   [OI-373](OI-373%20DocuSign%20is%20not%20configured%20in%20production%20for%20the%20order%20PDF%20attachment.md).
2. **The return path does not exist.**
   [OI-322](OI-322%20The%20DocuSign%20return%20trigger%20only%20handles%20quotes%20not%20orders.md)
   is unchanged since 3 November: the DocuSign return handling covers quotes, not
   orders. `force-app` holds `DocuSignOrderEnvelopeService` and
   `DocuSignOrderEnvelopeQueueable` — the **send** — and no order-side return
   trigger. So on the evidence in the repository the contract goes out and the
   signed document has nowhere to come back to.
3. **The code is six days old and was never smoke-tested on a real order.** The
   order PDF and DocuSign-at-order-level stack went to production on **12 November
   at 16:19Z** (quick deploy `0AfSW000001Lxnh0AC`), not today — today's delta
   `4478915..4d18d57` contains no DocuSign component at all. The developer's own
   journal entry for 12/11 ends _"No smoke test was run on a real order yet"_, and
   no record since reports one.

## What this note does not claim

⚠ **A blank tracker cell is not proof the step is undone**, and the tracker has
been wrong in both directions before — the WooCommerce default-agent row read
`done` while production was rejecting orders for exactly that gap
([OI-354](OI-354%20WooCommerce%20is%20connected%20to%20production%20by%20the%20client.md)).
The configuration may well have been completed today and the cell simply not
updated; the mail's author is also the person who would have done it.

⚠ **The org was not opened in this run.** Nothing here is an inspection of
production. No DocuSign credential, connected-app value or envelope content was
read or copied.

⚠ **ROMI's project manager was out of office when the mail went.** Elena Spini's
auto-reply to it (`1a1ef1a4e3631d44`, 14:40:40Z) states leave _"fino al 18/11
compreso"_, returning on the 19th →
[OI-348](OI-348%20Fase%201%20post%20go-live%20support%20is%20unassigned%20and%20unpriced.md).
So the client-facing claim was not reviewed by the person who owns the client
relationship.

## What is owed

- **A confirmation that DocuSign is configured in production for the order
  attachment**, with a date and a name, and the tracker cell filled in.
- **One end-to-end test on a real WooCommerce order in production** — order
  confirmed in Mexal, contract generated, envelope sent, document signed — before
  the stage sale contract has to work for Pienissimo Live on **24-26 November**
  ([OI-343](OI-343%20The%20client%20disputes%20that%20the%20stage%20sale%20contract%20was%20outside%20the%20Fase%201%20Blueprint.md)).
- **A decision on the return path**: either OI-322 is built before the event, or the
  client is told that the signed order contract comes back by hand.

## Related

- [OI-373](OI-373%20DocuSign%20is%20not%20configured%20in%20production%20for%20the%20order%20PDF%20attachment.md) — the unticked configuration row
- [OI-322](OI-322%20The%20DocuSign%20return%20trigger%20only%20handles%20quotes%20not%20orders.md) — the missing return path
- [OI-358](OI-358%20The%20org%20is%20not%20set%20to%20Italian%20date%20and%20number%20formats.md) — the date format the same mail declares done
- [The Pienissimo recap of open changes](../The%20Pienissimo%20recap%20of%20open%20changes.md)

## 🔴 2026-11-19 - ROMI's own project manager would not have made this release

**The release is now inside a legal dispute, and the person who owns the client
relationship says on the record she would not have shipped it.**

Elena Spini, marketing group DM, **08:03:35 CET**, her first working hour back
from leave:

> _"ho visto che ieri hai rilasciato … **ma avevate fatto i test di questa
> parte? non mi aspettavo un rilascio**."_

And in the thread, 09:09:28: _"dal documento condiviso era rilascio pianificato:
**18 o 19** — ma dato che poi non ci siamo + scambiati ne email ne nulla,
**non avrei fatto un rilascio cosi** comunque va beh pace ormai, **hanno
l'ennesima cosa in piu**."_ Then: _"e contestano pure."_

🟡 **The date objection resolved itself.** Aurel Mrruku answered that he had
confirmed the release in Monday's meeting with the client — _"lunedi ho
confermato nella riunione con loro"_ — and she accepted it: _"ok ottimo non
sapevo (ero rimasta al documento che li era scritto 18-19)"_. 🔴 **Her testing
objection was never answered.**

🔴 **The context has changed underneath this item.** The PEC of 17 November
suspends the 16 November go-live
([OI-375](OI-375%20Pienissimo%20sent%20a%20PEC%20contesting%20the%20implementation%20and%20suspending%20the%20go-live.md)),
so a release note sent on the 18th describes work delivered into a go-live the
client was already contesting in writing — **and ROMI did not know that when it
sent the mail**. Elena Spini's _"hanno l'ennesima cosa in piu"_ is the assessment
of the person who has to answer the PEC.

⚠ **Still unverified, a second day:** whether DocuSign is configured in Prod for
order PDFs ([OI-373](OI-373%20DocuSign%20is%20not%20configured%20in%20production%20for%20the%20order%20PDF%20attachment.md)),
whether the return path exists ([OI-322](OI-322%20The%20DocuSign%20return%20trigger%20only%20handles%20quotes%20not%20orders.md)),
and whether any real WooCommerce order has gone end to end in production. 🔴 The
freeze means nobody is now assigned to find out.

## 🟡 2026-11-20 - the release content is confirmed, and the testing objection is answered in part

🟢 **The 18/11 release contents are now stated independently**, in Elena Spini's
status post of 20/11 19:00 CET, and they match what the client was told:

> _"**Contratti da palco:** rilasciati in PROD il 18/11 **su richiesta di
> Fabrizio P.**, che lunedi ha chiesto di anticipare. Contratto fisico e digitale
> via DocuSign dopo la conferma d'ordine da Mexal. Nello stesso rilascio: **date
> in formato italiano**, Oggetto Nota sull'account, preventivo primario visibile
> in list view, **"Origine del lead" al posto di "Fonte lead"**, pulsanti di
> sincronizzazione Mexal in home per gli admin."_

🔑 **Three things that were open are closed by that paragraph:**

1. 🟢 **The release was client-requested and the acceleration was the client's
   own** — Fabrizio Paganelli asked on Monday 16/11 to bring it forward. That
   meets the _"non mi aspettavo un rilascio"_ objection of ROMI's own project
   manager: she had not expected it, but the client had asked for it.
2. 🟢 **The Italian date format is confirmed as shipped in that release**, by a
   second person → [OI-358](OI-358%20The%20org%20is%20not%20set%20to%20Italian%20date%20and%20number%20formats.md).
   ⚠ Still an account, not a verification against the org or a printed PDF.
3. 🟢 **The trigger order is stated**: physical and digital contract via DocuSign
   **after the order confirmation comes back from Mexal**.

🟡 **The testing objection is partly answered.** ROMI did walk the production
circuit — preventivo → DocuSign → ordine → Mexal → fattura → incasso — with the
client on **16/11**, two days before this release →
[OI-373](OI-373%20DocuSign%20is%20not%20configured%20in%20production%20for%20the%20order%20PDF%20attachment.md).
⚠ **That test predates the release it would have to vouch for**, so _"avevate
fatto i test di questa parte?"_ is still not answered for the stage sale contract
itself.

⚠ **The mirror risk is now live.** This item is about a release note that said
more than the delta contained. The next release — reports and dashboards, planned
for Monday 23/11 — is planned to say **nothing at all** to the users: _"senza
pero fornire spiegazioni agli utenti"_ →
[OI-381](OI-381%20The%20report%20and%20dashboard%20remediation%20is%20unmerged%20and%20due%20in%20production%20on%20a%20holiday.md).
