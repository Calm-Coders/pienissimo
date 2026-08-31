---
id: OI-72
type: open-item
status: open
owner: Sabatino Rinaldi
org: Pienissimo
raised: 2026-08-06
updated: 2026-08-14
source: meetings/results/2026-08-06-chiusura-punti-aperti.md
---

# OI-72 - Partita IVA mandatory on lead forms

**Partita IVA becomes a mandatory field on the live-stream lead forms**,
accepted in the full knowledge that free-event registrants will enter junk —
`00` was the example given. The value is corrected at payment time.

The purpose is **company identification for lead-to-account conversion**: a
plausible VAT number, even a wrong one, gives the conversion something to key
on and forces the registrant to think about which company they represent.

The trade is deliberate: worse data at capture, better conversion downstream.
It runs against the older idea of **double opt-in on forms** to reduce garbage
registry data at source, which was raised on 3 June and has been stale since.

It also interacts with
[VAT validation at first order](OI-73%20VAT%20validation%20moves%20into%20Salesforce.md) —
that check is what actually corrects the junk, and it only fires for the ~250
registrants in 3,000–6,000 who buy. Everyone else keeps the junk value forever,
which matters if those records are later used for marketing segmentation or
counted as accounts.

Owner is Sabatino Rinaldi, on the form side.
