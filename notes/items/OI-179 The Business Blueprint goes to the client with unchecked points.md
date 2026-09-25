---
id: OI-179
type: open-item
status: open
owner: Elena Spini
with: Aurel Mrruku
org: ROMI
raised: 2026-09-24
updated: 2026-09-24
blocks: [go-live]
severity: gating
source: Drive Business_Blueprint_Pienissimo.docx, created 2026-09-24 18:10:03Z
---

# OI-179 - The Business Blueprint goes to the client with unchecked points

**A complete Business Blueprint appeared on 24/09 and is due to reach the client on
25/09. The repository has no record of it.**

Elena Spini announced it in the group DM with Aurel Mrruku and Fabrizio Mastracci,
**24/09 20:12:48 CEST**:

> _"sto per vomitare BUT Habemus BPP signori"_

and two messages later:

> _"vorrei consegnarlo domani al cliente, lasciandogli la possibilità di commentare dove
> ci sono punti non chiusi ecc"_

She asked Fabrizio Mastracci to check the marketing chapter, and told Aurel Mrruku to
`Ctrl-F` for his own name.

## What it is

`Business_Blueprint_Pienissimo.docx`, ROMI letterhead, ten chapters, **a signature block
for ROMI Srl and Pienissimo Srl at the end**. Read in full (49,165 characters).
Chapters: project goal and Fase 1/Fase 2 perimeter · deliverables · users, roles and
profiles · the three integration flows · initial data loading · implementation detail
(lead lifecycle, quotes/contracts/orders, bundles and tranche, tickets and campaigns,
edge cases) · marketing and communication · reports · training · commercial notes.

🔑 **This is a second document bearing a signature block.** The record's standing rule is
that [REQUISITI.it.md](../../REQUISITI.it.md) is the text presented for signature and
`REQUIREMENTS.md` is its English mirror. **Nothing establishes how the BBP relates to
them** — whether it supersedes, supplements, or restates. Deciding that is a human's call.

⚠ The document is dated **03/03/2026** above the signature block, six months before it
was written. Read here as a template carry-over, not evidence of a date.

## The author's own unchecked points

The document carries **seven `● Check con Aurel` markers** — passages its author does not
consider confirmed:

1. §2 Deliverable — Sales Cloud object configuration
2. §2 Deliverable — credit notes and storni
3. §2 Deliverable — external document archiving
4. §3 the **entire** users/roles/profiles chapter
5. §6.2 the Contratto object
6. §6.3 the tranche mechanism
7. §6.5 the edge cases

and three `[Open Points]`: formal quotation of Fase 2; the quote email copy; **the web
forms to migrate, which the client has not yet shared with ROMI**.

Elena Spini flagged the same gap in the DM at 19:13:03 CEST: _"ho fatto una proposta per
il BBP ma oggi ti ho sentito dire che cose e ci dovremmo allineare"_ — she wants profiles
and roles reconciled with Aurel Mrruku **before or after the UAT session on 25/09**.

## Content that is new to the record

- 🔴 **Two WooCommerce instances**, not one — events/stage orders, and digital products
  (book, video courses) — to be treated as distinct sources in one flow. Every existing
  note assumes a single store.
- 🔴 **Legacy QR codes die with Zoho.** QR codes printed on paper and embedded in video
  courses are not migrated and stop working; remediation is at the client's cost. Not
  recorded anywhere else.
- 🔴 **Signed PDFs go to external storage** (SharePoint/Google Drive) because of the
  Salesforce 10 GB file limit, with only a link kept in the CRM. Marked `Check con Aurel`
  and unbuilt.
- 🔴 **A "Crea Nota di Credito" button at Order level**, with per-line and per-Asset
  selection — scope that
  [OI-157](OI-157%20Credit%20notes%20and%20storni%20are%20unbuilt%20and%20undefined.md)
  records as undefined.
- 🔴 **The document names an unresolved point itself**: correcting a payment or tranche
  attributed in error, with two competing proposals — a manual button on the Asset while
  it is still `Disponibile`, or a nightly routine diffing yesterday's Mexal scadenzario
  against today's — _"discusse in riunioni diverse senza convergenza"_.
- **Commercial terms with no note**: up to **20 hours of training** over at most two
  months; **one month** of post-go-live support; a clause authorising ROMI to hold the
  client's system credentials.
- **Four profiles** — Direzione/Executive, Amministrazione, Front Office & Delivery,
  Marketing — with a role hierarchy, and an explicit `NON SPECIFICATI` for HR Generalist.
- Anticipay is called **regardless of declared nationality**, with a negative result
  handled as "non applicabile" and mailed to the administration without blocking the
  order.
- A WooCommerce order syncs **only at status `COMPLETATO`**, which the document
  acknowledges delays bank-transfer orders.
- Lead closure reasons are structured into two families, **PERSO** and **ERRATO**, with
  full value lists.
- ~10 events a year, so campaigns and editions are created **by hand**.
- More than **100 Zoho forms** exist; only the principal ones migrate initially.

## Two places where it disagrees with the same day's session

- 🔴 **The quote state table omits `Firmato`.** The client agreed a `Firmato` state that
  afternoon, and §6.2's numbered flow uses it at step 4 — but the _Stati del Preventivo_
  table lists only Bozza, In Trattativa, In Attesa di Accettazione, Accettato, Rifiutato.
  **A document going to the client tomorrow contradicts itself on a state agreed today.**
- ⚠ **`Rifiutato` is presented as settled.** §6.2 states that accepting one quote sets
  the others to `Rifiutato` with a flag _"Per scelta altro preventivo"_. On the afternoon
  of the same day Fabrizio Paganelli and Marco Montesi both objected to that word and the
  label was left open.
- ⚠ Minor: §6.1 says `Non Risponde` generates the callback task **48h later**; the live
  demo created it immediately with an editable date.

## Where it asserts something the record holds open

- **Tranche ↔ Mexal invoice join is "basato sul numero di riga d'ordine"** — stated as
  settled. [OI-166](OI-166%20The%20order%20line%20needs%20a%20shared%20identifier%20for%20Mexal.md)
  holds exactly that as the open hop.
- **The Contratto does not sync to Mexal**, lives only in Salesforce, is frozen by trigger
  after invoicing, and introduces an `Insoluto` concept with weekly and monthly scheduled
  reports. [OI-168](OI-168%20Contract%20logic%20is%20not%20started%20and%20is%20on%20the%205%20October%20UAT.md)
  records contract logic as **not started**, on the 5/10 UAT agenda.

## Open

- 🔴 **Close the seven `Check con Aurel` points before delivery**, or mark them visibly as
  open in the delivered copy — which is what Elena Spini says she intends.
- 🔴 **Fix the `Firmato` omission** before it goes out.
- 🔴 **Decide the BBP's standing against the signed requirements register.** Two documents
  with signature blocks and no stated precedence is a contract problem, not a docs problem.
- ⚠ No register row covers the BBP. **Allocating a requirement id is a human's call.**
