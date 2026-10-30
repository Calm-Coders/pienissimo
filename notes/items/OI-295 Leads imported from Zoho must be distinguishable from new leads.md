---
id: OI-295
type: open-item
status: open
owner: Elena Spini
with: Sabatino Rinaldi
org: both
raised: 2026-10-28
updated: 2026-10-30
depends_on: [OI-290]
blocks: [go-live]
source: Slack D0B5QHS2T7H 2026-10-28 17:03 CET
---

# OI-295 - Leads imported from Zoho must be distinguishable from new leads

**The client asked that Leads migrated from Zoho arrive in Salesforce marked, so
that after go-live a genuinely new Lead cannot be confused with a migrated one.
He accepts them being loaded in state `New`; what he does not accept is their
being indistinguishable. ROMI settled internally on a checkbox. Nothing is built,
and the client has not been told what was decided.**

## The request

🔑 **It arrived privately, not through the project channels.** Elena Spini,
Slack DM `D0B5QHS2T7H`, **2026-10-28 17:03:12 CET**:

> _"tema LEAD invece **Sabatino mi ha scritto in privato** per capire come
> differenziare i record importati che per lui è ok se stanno a NEW **but devono
> essere diversi dai new che entreranno dopo il 16/11**"_

So the constraint is explicit and dated: the boundary is **16 November**, the
agreed go-live
([OI-268](OI-268%20The%20client%20proposed%20a%20go-live%20calendar%20of%2016%20November.md)).

⚠ **The source is a ROMI-internal relay of a private message.** As with the
ticketing answers of 27/10, this mailbox and these channels do not hold
Sabatino Rinaldi's own words — only Elena Spini's report of them. The quotation
marks above are hers, not his.

## ROMI's answer, taken internally

Elena Spini, the same minute, quoting her own earlier proposal to him:

> _"[16:49] piuttosto possiamo fare li importiamo come NEW ma mettiamo **un campo
> di checkbox `Lead from Zoho = TRUE`**"_
>
> _"[16:50] e poi si possono fare i filtri dalle list view ecc che questi sono da
> scartare / o quanto meno non nuovi e piano piano li sistemate se vorrete"_

And the decision, at **17:07:07 CET**: _"si facciamogli sta checkbox e via"_,
with Aurel Mrruku at 17:05:23 leaving the shape to her — _"sei libera di decidere
te come li vuoi gestire (possiamo creare un campo a doc)"_.

## Why it is open

1. 🔴 **Nothing is built.** No `Lead` checkbox field of this name exists in
   `force-app/`, and the migration that will set it is the one being rehearsed
   now. The field has to exist **before** the Lead load, not after.
2. 🔴 **The client has not been told what was decided.** The exchange is a ROMI
   DM. Sabatino Rinaldi stated a constraint; he has not been shown the checkbox,
   the list-view filters, or the fact that cleanup is being handed back to him
   (_"piano piano li sistemate se vorrete"_).
3. ⚠ **No register row covers Lead migration at all** — the same gap recorded
   on [OI-290](OI-290%20Lead%20and%20Referenti%20migration%20data%20is%20owed%20by%20the%20client.md),
   and this is a second requirement landing inside it.
4. ⚠ **A checkbox and a document field were both floated** (_"possiamo creare un
   campo a doc"_). Which one is to be built is Elena Spini's call and is not
   recorded anywhere but this note.
5. 🔑 **It interacts with consent.** OI-290 records that consents ride on the
   Lead. A flag that marks a Lead as migrated says nothing about whether its
   consent state survived, and nobody has connected the two.

## Related

- [OI-290](OI-290%20Lead%20and%20Referenti%20migration%20data%20is%20owed%20by%20the%20client.md)
  — the migration this rides on; the Referenti half was delivered the same day.
- [OI-268](OI-268%20The%20client%20proposed%20a%20go-live%20calendar%20of%2016%20November.md)
  — the 16 November boundary the client named.

## 🟢 2026-10-29 - the client has been told, in his own words, and the field is still not built

🟢🔑 **Problem 2 above is resolved.** Sabatino Rinaldi states the decision himself,
unprompted, in the mail that delivers the Lead file — Gmail `1a186fc3e17d7577`,
**2026-10-29 09:27:06Z**:

> _"Ieri ho sentito Elena, spiego brevemente quello che ci siamo detti e la
> soluzione che mi ha dato:_
>
> _Io nella colonna status ho messo a tutti news ma in realtà non sono news perché
> sono lead che abbiamo anche da anni e Elena mi ha dato questa soluzione:_
>
> _"possiamo fare li importiamo come NEW ma mettiamo **un campo di checkbox Lead
> from Zoho = TRUE**" In modo tale che **i commerciali sanno che non sono da
> lavorare (per il momento)**."_

🔑 **Three things this settles.** The client knows the shape — a checkbox, named —
so the note's "has not been told" no longer holds. The channel is identified: a
**phone call with Elena Spini on 28 October** (_"ieri ho sentito Elena"_), which is
why no written answer appears in the records. And he states the operational
consequence himself — the sales team will know these are not to be worked — which
is the list-view filtering half of Elena Spini's proposal, understood and accepted.

🔑 **His _"per il momento"_ carries the cleanup hand-back**, in his own words. The
note recorded that _"piano piano li sistemate se vorrete"_ had not been put to him;
his parenthesis shows he understands the flag as provisional. ⚠ **It does not show
he has accepted owning the cleanup** — only that he expects the state to change
eventually. The hand-back itself is still not stated to him in writing.

### What is still open

1. 🔴 **Nothing is built.** No `Lead` checkbox of this name exists in `force-app/`.
   🔴 **And the file it must mark has now arrived** —
   [OI-290](OI-290%20Lead%20and%20Referenti%20migration%20data%20is%20owed%20by%20the%20client.md),
   delivered 09:27Z the same morning, every row at status `New` by his own account.
   **The field has to exist before that file is loaded**, and the load is the next
   step in front of it.
2. ⚠ **The checkbox-versus-document-field question is answered by default.** He
   names a checkbox and nobody corrected him, so the checkbox is what the client
   expects. That is not the same as ROMI having decided — point 4 above stands,
   now with the client's expectation attached to one of the two options.
3. ⚠ **The exact API name is still nobody's decision on record.** _"Lead from
   Zoho"_ is a label in an Italian sentence inside a quotation of a phone call.
4. 🔑 **Consent is still unconnected.** Point 5 above is unchanged: a flag that
   marks a Lead as migrated says nothing about whether its consent state survived,
   and the file that would carry it has now been delivered unopened.

## 🟢 2026-10-30 - the field exists, with a name, on a branch nobody has merged

🟢🔑 **`Lead_from_Zoho__c` was built.** Anita Aga, commit `0717486` _"Added field
on Lead"_, **30 October 15:10:59 CET**, on branch **`DevAnita30`**:

```xml
<fullName>Lead_from_Zoho__c</fullName>
<defaultValue>false</defaultValue>
<description>Identifies Leads migrated from Zoho. Set to true when importing Zoho Leads.</description>
<label>Lead from Zoho</label>
<type>Checkbox</type>
```

🔑 **Three of this note's open points close at once.** It is a **checkbox**, not a
document field, so point 2 is answered as the client expected. The **API name is
`Lead_from_Zoho__c`** and the label is exactly the client's words, so point 3 is
answered. And the commit also adds it to the `Lead_Record_Page_Three_Column`
flexipage and grants it on the **`Agente`** and **`Full_Permission`** permission
sets — so the sales team can see and filter on it, which was the operational
purpose Sabatino Rinaldi stated.

### How the name was settled, which is less than it looks

[The 30 October internal alignment](../meetings/2026-10-30%20Rapido%20Allineamento%20Aurel%20Elena.md),
about four hours earlier. Aurel Mrruku wanted an **origin** field; Elena Spini
wanted the checkbox the client had already been promised:

> Aurel Mrruku: _"l'origine non ti è piaciuto l'origine che t'ho detto? … Quando
> dici lead from è origine del[la lead] che è Zo[ho]"_
>
> Elena Spini: _"**chiamalo come vuoi**, perché l'aveva condiviso con Sabatino, solo
> per quello. **Se lo vuoi cambiare cambialo, non mi interessa.**"_

🔑 **The client's wording governed because the client had already been told it** —
not because anyone preferred it. ⚠ Neither of them recorded a decision; Anita Aga
built the label from the sentence.

### What is still open

1. 🔴 **It is on `DevAnita30` and nowhere else.** `DevMain` is still `52ddc4c`,
   `UAT` is `8f039ce` and `Prod` is `7905945` — **none of them carries the field**.
   No PR for `DevAnita30` was seen in this sweep. **The Lead load cannot mark
   anything until this merges and deploys.**
2. 🔴 **The load itself is now blocked for a second reason** —
   [OI-307](OI-307%20The%20Lead%20import%20needs%20the%20duplicate%20rules%20disabled.md):
   the masked VAT placeholders will trip the duplicate rules.
3. ⚠ **Nothing sets the field.** The checkbox defaults to `false` and the import
   must write `true`; no import definition, data loader mapping or script in this
   record does so. 🔑 **A field that exists and is never set is indistinguishable
   from no field at all**, and the client's whole requirement is the marking.
4. 🔑 **Consent is still unconnected** — point 5 of the original note, unchanged,
   and now sharper: the delivered file sets both consent flags `true` on every row
   by the client's own instruction. See
   [OI-307](OI-307%20The%20Lead%20import%20needs%20the%20duplicate%20rules%20disabled.md).
