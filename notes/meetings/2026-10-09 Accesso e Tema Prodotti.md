---
id: meeting-2026-10-09-accesso-tema-prodotti
type: meeting
status: resolved
owner: Aurel Mrruku
org: both
raised: 2026-10-09
updated: 2026-10-09
source: https://docs.google.com/document/d/1LqFNd0ZNQNyOAj1x6jUx3Yc0X4skdRdsS_eZekawFw0
---

# 2026-10-09 Accesso e Tema Prodotti

**A 31-minute client call that settled how the edition mapping is populated, put
a temporary stand-in on the Mexal active flag, and reopened the discount
question that OI-145 has been carrying unverified since 18 September.**

Google Meet, **09/10 10:39 CEST**, Gemini notes and verbatim transcript read in
full (~31m, transcript ends at `00:31:28` with a clean sign-off). Invited:
Fabrizio Paganelli, `amministrazione@pienissimo.com`, Elena Spini, Aurel Mrruku.
⚠ **Only Fabrizio Paganelli and Aurel Mrruku speak in the transcript** — Elena
Spini is named as having been spoken to separately that morning
(_"ho chiesto di alla Elena stamattina"_) but does not appear in the record of
this call. The invitation moved from 09:30 to 10:30 CEST the same morning
(two calendar mails, 07:24:18Z and 07:31:59Z).

⚠ Speaker labels are reliable here — it is a two-person call — but the
transcription garbles product and system names (`Zoo` for Zoho, `Maxal` /
`Maxile` / `Mexile` for Mexal, `Ses Force` / `salesce` for Salesforce,
`merciologico` for merceologico). Quoted below as transcribed.

## Concordato

1. **The gruppo merceologico stands in for the flag annullato, for the tests
   only.** Fabrizio Paganelli cannot touch `flag annullato` without breaking
   Zoho (_"sennò viene fuori casino con Zoo"_), so he set `cod_grp_merc` to `S`
   on the articles that should be active and asked Aurel Mrruku to read that
   field instead. ⚠ Aurel Mrruku accepted it **and attached a warning that is
   now [OI-226](../items/OI-226%20The%20gruppo%20merceologico%20stands%20in%20for%20the%20flag%20annullato%20only%20for%20the%20tests.md)**.
   Just over 30 article codes stay active under it.
2. **The Plus products get cleaned up to one.** Aurel Mrruku asked Fabrizio
   Paganelli to deactivate the surplus Plus products, leave a single active one,
   and set the **tranche count on Salesforce**. He agreed.
3. **The edition mapping table is populated by categoria merceologica, not by
   article code.** Fabrizio Paganelli's proposal (`00:11:45`), because the
   category groups every article code belonging to one event:
   _"anziché scrivere 1 2 3 4 5 6 righe… faccio solo una riga con la categoria
   merciologica 02."_ Aurel Mrruku accepted it as easy — _"Metto sulla ricerca
   anche codice merciologico e abbiamo finito"_ — and spelled out the
   consequence he wanted confirmed: every article sharing that category code,
   **active or not**, is attached to the edition automatically. Fabrizio
   Paganelli: _"Va bene così."_ Six rows a year instead of about fifty.

## Da approfondire

- **The discount fields, deferred to Mirko Merendi.** See
  [OI-145](../items/OI-145%20Order%20header%20discounts%20are%20removed.md); this
  is the only item Gemini files as unresolved.

## What else the call produced

🔑 **The `Natura` decode was restated and corrected in the room.** Fabrizio
Paganelli asked which letter generates a ticket. Aurel Mrruku first said the
second, then corrected himself: **the first letter is the biglietto flag, the
second is the bundle flag** (`00:10:26`). This is the decode
[OI-96](../items/OI-96%20Edition%20mapping%20table%20on%20Salesforce.md) and
[the article registry](../The%20Articoli%20Salesforce%20article%20registry.md)
record as undocumented — it is now on the record from the person who built it,
⚠ **after one false start in the same exchange**, so it is worth a code check
rather than being taken as settled.

🔴 **The article categories on Mexal are wrong and Fabrizio Paganelli is fixing
them by hand.** Reviewing the file in Drive he found collisions — he had used
`e` for consulenze and the same code elsewhere (_"Pienissimo intensive. Ho messo
la e. Sì, l'ho usata per le consulenze"_) and said he had it inverted on Mexal.
He will correct Mexal directly and tell Aurel Mrruku by mail or chat when done
(`00:14:07`). ⚠ **This is the key the whole category-based mapping now rests
on**, being hand-corrected the same day the mapping was built on it.

🟢 **He did tell him.** The 10:41:49Z mail
([OI-226](../items/OI-226%20The%20gruppo%20merceologico%20stands%20in%20for%20the%20flag%20annullato%20only%20for%20the%20tests.md))
is that notification, and Aurel Mrruku replied at 14:24:35Z that he had made the
changes and updated the products for the UAT.

⚠ **Order creation and customer anagrafica are open on Mexal.** Aurel Mrruku
warned, unprompted, that he had left them open, so any order Fabrizio Paganelli
creates in testing **will go through to Mexal** (`00:29:56`): _"se crei un
ordine, fai tutti i step, l'ordine andrà in Mexal."_ Recorded because it means
UAT activity now writes to the client's live ERP.

⚠ **Half the call was a login failure.** `00:17:55`–`00:28:29` is Aurel Mrruku
walking Fabrizio Paganelli through Proton Pass to recover Salesforce access,
ending with a passkey created and access restored. Two things surfaced that are
not login trivia: the account hit _"privilegi sufficienti"_ / _"la tua utenza
non ha i privilegi"_ on a page, and Aurel Mrruku did not know what access Elena
Spini had granted the `amministrazione@pienissimo.com` user — _"Non so cosa ha
dato Elena tua utenza"_. ⚠ Proton Pass is the credential channel adopted on
08/10; this is its first recorded use with the client, and it cost about ten
minutes of a client call.

## What it changed

| Record | Movement |
| ------ | -------- |
| [OI-96](../items/OI-96%20Edition%20mapping%20table%20on%20Salesforce.md) | 🟢 The population rule is agreed with the client and **built the same day** (`c5e4a1e`) |
| [OI-145](../items/OI-145%20Order%20header%20discounts%20are%20removed.md) | 🔴 The unverified Mexal half is now a client-raised blocker with a date |
| [OI-226](../items/OI-226%20The%20gruppo%20merceologico%20stands%20in%20for%20the%20flag%20annullato%20only%20for%20the%20tests.md) | 🆕 The stand-in flag and the production code change it implies |
| [The Mexal article sync](../objects/The%20Mexal%20article%20sync%20to%20Product2.md) | 🟢 `cod_grp_merc` → `IsActive`, built and committed |

**Next steps as Gemini recorded them:** Fabrizio Paganelli updates the Mexal
product data and cleans the Plus products; Aurel Mrruku implements the category
mapping; Fabrizio Paganelli notifies him when the category correction is done;
**the group books Mirko Merendi next week for the discount fields** — Mirko
Merendi is unavailable on Friday afternoons, which is why it slipped a week.
