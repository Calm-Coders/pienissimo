---
id: RISK-woo-test-server
type: risk
status: resolved
owner: Sabatino Rinaldi
org: Pienissimo
raised: 2026-08-27
updated: 2026-08-27
source: meetings/2026-08-27-test-integrazione-woocommerce-transcript.it.md
---

# Risk - real WooCommerce orders reached a third-party test server

**During the 27 August integration testing, live customer orders from
Pienissimo's production shop were posted to a throwaway public test endpoint.**

Sabatino Rinaldi found it himself, mid-demo, and said so on the record:

> _"Me ne sono accorto perché mentre facevo dei test ci sono stati degli ordini
> reali e quindi io me li vedevo lì nel server finto che c'era, ho detto com'è
> possibile?"_
> — [2026-08-27 Test Integrazione WooCommerce](../meetings/2026-08-27%20Test%20Integrazione%20WooCommerce.md)

## How it happened

The plugin he built between the two sessions
([the flow](../flows/The%20WooCommerce%20order%20integration.md)) is **always
active on the live shop** and fires on any order reaching `in lavorazione` or
`completato`. During testing it was pointed at a public request-inspection
endpoint, the kind Aurel Mrruku suggested in the morning session for a quick
wire test — _"fai un test verso un server, sono quelli pubblici"_. Real
customers kept buying while the test ran, so their orders went there too.

The payload those orders carried is the same one demonstrated in the session:
customer name, **ragione sociale**, **partita IVA**, order totals, traffic
source, and the purchased lines.

**No values are recorded here, and none should be** — see
[docs/publishing.md](../../docs/publishing.md). The fact is recorded; the data
is not.

## Why it is marked resolved

Sabatino Rinaldi **deactivated the test plugin at the end of the call**,
unprompted and for exactly this reason:

> _"Nel frattempo spengo quel plugin prima che mi dimentico, sennò entrano dati
> su server non nostri."_

So the leak is stopped. It is recorded rather than dropped because the exposure
window is not the interesting part — **the shape of the mistake is.**

## What it says about the next round

The full integration tests are set for the **week of 31 August**, against a real
Salesforce endpoint
([OI-102](../items/OI-102%20Salesforce%20endpoint%20and%20token%20for%20the%20WooCommerce%20plugin.md)),
and [OI-101](../items/OI-101%20Stage%20sales%20must%20be%20in%20the%20WooCommerce%20test%20set.md)
asks for **stage sales** — the €8,900-and-up ones — to be simulated in that
round. Three things follow:

- **There is no test lane.** Testing happens on the production shop, against
  production customers, because no staging shop was ever discussed. That is the
  same shape as the Mexal problem: serie 10 is a test lane **inside production
  data**, still with no owner
  ([the 26 August trace](../traces/Source%20trace%202026-08-26%20nightly.md)).
- **The plugin is permanently on.** Any future endpoint change re-runs this
  risk, and the plugin's manual re-send button can replay an order to whatever
  it currently points at.
- **Test orders will land in Salesforce.** Sabatino Rinaldi expects it and said
  so — _"entrano tutti gli ordini anche senza l'opportunity"_. Somebody should
  decide before 31 August whether the target is a sandbox or UAT, and how the
  test records get cleaned up afterwards.

⚠ **This is a Pienissimo-side operational matter, not a ROMI deliverable.** It
is worth raising once, with the person who can decide it — Sabatino Rinaldi owns
the shop — rather than filing as a project action item.
