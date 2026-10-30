---
id: OI-305
type: open-item
status: open
owner: Aurel Mrruku
org: ROMI
raised: 2026-10-30
updated: 2026-10-30
depends_on: []
blocks: []
source: notes/meetings/2026-10-30 Connessione WooCommerce.md
---

# OI-305 - Anticipay does not answer in UAT for test data or San Marino

**The Anticipay middleware does not respond correctly in UAT for invented company
data, or for San Marino, so the anagrafica cannot self-populate there. The
consequence is that the client cannot run a complete test cycle with a genuinely
new, unregistered customer in UAT — which is exactly the case he has been
reporting faults on.**

## The limitation

Aurel Mrruku, in [the 30 October WooCommerce call](../meetings/2026-10-30%20Connessione%20WooCommerce.md):
Anticipay **does not answer properly in the UAT environment** for test data or for
localities such as **San Marino**, preventing the automatic population of the
registry fields.

Fabrizio Paganelli's objection, recorded in the same section: these limits
**prevent a full test cycle with random data or with new customers not already
registered**.

🔑 **San Marino is not an edge case here.** Pienissimo is a San Marino company —
Marco Montesi's and Fabrizio Paganelli's own signatures carry
_"Legge 171/2018 della Repubblica di San Marino"_ — and Kreosoft sits in Dogana,
RSM. A middleware that cannot resolve San Marino in UAT is failing on the home
jurisdiction.

## The workaround, and what it costs

Aurel Mrruku's suggestion: **use the partita IVA of a real, existing customer** for
the later tests.

🔴 **That removes the new-customer path from the test.** The faults the client has
raised this week — [OI-296](OI-296%20Account%20creation%20to%20Mexal%20failed%20in%20UAT%20and%20account%20send%20was%20switched%20off.md)
on 28/10 and the report behind
[OI-298](OI-298%20WooCommerce%20bundle%20orders%20from%20a%20new%20customer%20do%20not%20reach%20Salesforce.md)
on 29/10 — both concern accounts that did not exist before. Testing with existing
VAT numbers cannot exercise them.

## Why it is open

1. 🔴 **No new-customer end-to-end test is possible in UAT** while this stands, and
   go-live is **16 November**.
2. ⚠ **Nothing says whether Anticipay answers correctly in production.** The
   limitation is stated of UAT only. If it is a sandbox configuration matter it may
   be fixable; if it is an Anticipay coverage gap for San Marino it is not, and
   nobody has asked.
3. ⚠ **It is one of the pressures behind testing in WooCommerce production** — see
   the contradictory environment agreement in
   [the meeting note](../meetings/2026-10-30%20Connessione%20WooCommerce.md).
4. ⚠ **Not put to the vendor.** No contact with Anticipay about this is recorded.

## Related

- [The Anticipay middleware API contract](../The%20Anticipay%20middleware%20API%20contract.md)
