---
id: person-sabatino-rinaldi
type: person
status: active
org: Pienissimo
updated: 2026-08-27
---

# Sabatino Rinaldi - Pienissimo project lead

The day-to-day counterpart and the channel through which almost everything
reaches [Daniela Morgese](Daniela%20Morgese%20-%20Pienissimo%20direction.md).

His title on the April 2026 org chart is **Growth Manager**, not project lead —
"project lead" is the role he plays here, not the one he holds. Worth knowing
when judging what he can commit Pienissimo to.

He is also the largest single source of unmet inputs. Owed since the 27 May
kickoff and never delivered: the **key-user list** and the **3CX status
report**. Also owed: WooCommerce consumer keys, the form-links inventory, and
the Zoho field workbook
([OI-24](../items/OI-24%20Data%20model%20workbook.md)).

On 2026-08-06 he admitted not having read the minuta that flagged the
[phase 2 scope dispute](../risks/Risk%20-%20the%20phase%202%20scope%20dispute%20is%20unresolved.md) —
_"Io non l'ho nemmeno letto quello, ho preso direttamente il link"_ — and he is
the one who kept the _Assegnato_ ticket state for reporting.

Owns the WooCommerce checkout-link specification.

## 2026-08-27 - he writes the integration himself

🟢 **He built the WooCommerce→Salesforce plugin between two meetings on the same
day** — version 1.3, working, HTTP 200 on the wire, with a manual re-send button
he added on his own initiative
([the test session](../meetings/2026-08-27%20Test%20Integrazione%20WooCommerce.md)).
He also runs the shop's cart layer (Funnel Kit) and had already built a
WooCommerce sync into his own Pienissimo platform.

That changes how to read him. On this integration he is not a channel to a
technical team — **he is the technical team**, and Pienissimo owns and maintains
the client-side code. Elena Spini asked in session whether Pienissimo had a
WooCommerce equivalent of Kreosoft's Mirko Merendi for Mexal; the answer was no.

It does not change the record on unmet inputs — the key-user list, the 3CX
status and the Zoho workbook are still owed since May. But the WooCommerce
consumer keys are no longer straightforwardly his to owe: with the integration
pushing rather than pulling, **ROMI now owes him** the endpoint and token
([OI-102](../items/OI-102%20Salesforce%20endpoint%20and%20token%20for%20the%20WooCommerce%20plugin.md)),
and whether the CK/CS are needed at all is undecided.
