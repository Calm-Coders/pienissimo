---
id: OI-134
type: open-item
status: open
owner: Aurel Mrruku
with: Fabrizio Mastracci
org: ROMI
raised: 2026-09-08
updated: 2026-10-04
depends_on: [OI-81, OI-124]
blocks: [go-live]
source: notes/meetings/2026-09-08 Flussi MKT Parte 2.md
---

# OI-134 - The marketing flows cannot be tested before a production release

**Fabrizio Mastracci cannot send a test email from the sandbox, and the
invitation link has nowhere to land. The workaround is to build the flow logic
blind. UAT is scheduled to begin on 23 September.**

## The three blockers, established live in the call

From [Flussi MKT Parte 2](../meetings/2026-09-08%20Flussi%20MKT%20Parte%202.md),
checked in the org during the session:

1. **No authenticated domain in the sandbox.** Fabrizio Mastracci navigated to
   Setup → authenticated domains and found none: _"non ce l'ho un dominio qua."_
   Without it Marketing Cloud cannot send.
2. **The community does not exist in production.** The invitation URL must land
   on the Experience site; Aurel Mrruku: _"devo anche creare la community per
   fare il test perché quel link ti deve portare sulla community."_
3. **The production release is two weeks out.** Aurel Mrruku: _"in produzione ci
   sono un paio di settimane come minimo"_, because the release has to carry the
   permissions and classes as well as the structures — and _"le cose a metà o
   cose spezzate"_.

## 🔴 The sentence that matters most

> _"non abbiamo ancora fatto dei UAT noi"_ — Aurel Mrruku, 8 September, ~00:21.

**Said roughly two hours before Elena Spini told the client that UAT begins on
23 September** and runs to 13 October across nine named flows
([OI-124](OI-124%20Go-live%20moved%20from%206%20to%2021%20October.md)).
`Flussi Marketing Cloud` is one of the nine. Nobody in either room connected the
two statements.

## The agreed workaround

- Fabrizio Mastracci **builds the flow logic in the sandbox with sends disabled**,
  to get familiar with the objects.
- Aurel Mrruku **writes the object name, field API names and logic into chat by
  end of day** — an action with a same-day deadline.
- Access was granted immediately, by a route that is its own problem
  ([the risk](../risks/Risk%20-%20a%20sandbox%20password%20was%20spoken%20aloud%20and%20preserved%20in%20a%20meeting%20transcript.md)).

⚠ **What this cannot test is the thing worth testing.** Fabrizio Mastracci named
it: the point is _"cliccare il link che ti arriva sulla mail e vedere se aggiorna
l'oggetto"_ — the round trip from send, through the community page, back to the
Salesforce record. Flow logic built without it verifies branching, not the
integration.

## What has to happen

1. **Someone has to decide whether a production release happens before
   23 September**, or the marketing half of UAT starts against untested flows.
2. **The authenticated domain** is a prerequisite either way and belongs to the
   subdomain work already open in
   [OI-14](OI-14%20Marketing%20forms%20and%20subdomain.md), where the DNS records
   have been owed by Matteo Distaso since **21 August**.
3. ⚠ **The production org exists and has never been deployed to.**
   `pienissimo.my.salesforce.com` was provisioned on 3 September and described as
   "ready to be deployed"; nothing has gone to it. The two-week estimate is for a
   first deploy, not an incremental one.

## 🟢 2026-09-29 — the mechanism is named, and there is a date

🔑 **The block is not "no test send from sandbox" alone — Marketing Cloud cannot be
installed in the UAT sandbox at all.** Fabrizio Mastracci, MKT group DM 24/09 09:06
and 09:22 CEST: _"io devo giusto verificare se posso fare i test in uat perche ieri
con carol abbiamo scoperto che non c'è marketing in sandbox"_, and _"il problema è
che in uat non posso installare mc e per questo non riesco a creare il flusso
secondo le logiche che prendo dall'oggetto che ha creato Aurel"_.

⚠ **That exchange is three weeks newer than this note and was never swept** — it sits
in a group DM (`C0C38JJ9D1T`, "PIENISSIMO - Interna", created 24/09) that no prior
trace lists as a source.

🟢 **Resolution path, dated.** At
[the 29/09 pre-UAT session](../meetings/2026-09-29%20Pre%20UAT%20Check%20giro%20MKT.md)
Aurel Mrruku undertook to load the objects and a clean test record set — a test
Account, five ticket rows, a contact, an order, a campaign — into **production by
Monday 5 October**, with `PIENISSIMO - Interna Check PROD per MKT` booked 05/10
09:30–10:30 CEST to verify it there. He refused to export UAT data: _"sono dati
sporchi."_

🔴 **Still blind until then.** Nothing has been tested end to end, and
[OI-195](OI-195%20WhatsApp%20sends%20imply%20a%20mobile%20community%20that%20was%20never%20designed.md)
adds a channel — WhatsApp on mobile — that this workaround does not cover at all.

## 2026-10-04 - Prod is ready for the marketing round trip

Built by Claude Code at Aurel Mrruku's request, recorded in
[JOURNAL.md](../../JOURNAL.md):

- **The community exists in Prod and is published.** The Landing Page LWR site was
  published (job `08PSW00000WggaD2AR`); before that a guest was sent to the login page.
- **The guest profile can run the page.** `ParticipantRegistrationController`,
  `AssetQrService` and `QuoteAcceptanceController` granted to `Landing Page Profile`
  in Prod (deploy `0AfSW000001Hfqz0AC`). Class access only — the controllers run in
  system mode, so no guest field access was added.
- **Test data**, all prefixed `TEST MKT`: two parent campaigns and two 2026 editions
  (event 19/11/2026, send date 05/10/2026), two ticket products, six companies with
  principal contacts on `+mkt1`–`+mkt6` aliases of Aurel Mrruku's mailbox, six
  `Incassato` orders, 13 `Disponibile` tickets and six Event Links `Pending/Ready`
  with Prod registration URLs. Nothing reached Mexal (`Integration_Log__c` 0).
- ⚠ Still open for the round trip: whether Marketing Cloud in production can send
  (authenticated domain), and `Send_After__c`, which is no longer populated on
  Event Links since `5b19caa`.
