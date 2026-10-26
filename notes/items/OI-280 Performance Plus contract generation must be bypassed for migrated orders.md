---
id: OI-280
type: open-item
status: open
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: both
raised: 2026-10-21
updated: 2026-10-21
depends_on: [OI-244]
blocks: [go-live]
severity: normal
source: notes/meetings/2026-10-21 Tema Migrazione.md
---

# OI-280 - Performance Plus contract generation must be bypassed for migrated orders

**Salesforce links one contract to one order. The client's Performance Plus
history links one contract to many orders. Hand-entering the historical
contracts was tried on screen and abandoned, so the agreed answer is to load
the Performance Plus order lines with the contract automation switched off and
accept that migrated history carries no contract records.**

Settled at `01:47:59`–`01:54:51` of
[the 21/10 afternoon session](../meetings/2026-10-21%20Tema%20Migrazione.md).

## The model mismatch

Fabrizio Paganelli:

> _"mentre adesso in futuro, grazie a S[ale]SF[orce], faremo un unico ordine con N
> tranche e a fronte di un unico ordine ci sarà un unico contratto[,] oggi come
> oggi noi abbiamo a fronte di un unico contratto abbiamo più ordini."_

Aurel Mrruku walked him through creating a contract by hand — the Contracts tab
had to be added to his navigation first, because the permission was missing — and
then explained why it will not reconstruct the history: the link is one-to-one
with the order, the contract value and the scadenzario logic update through that
link, and reproducing the old shape means duplicating the contract per order.
_"Lo puoi fare, però non è corretto … devi duplicare n volte il contratto."_

Fabrizio Paganelli's fallback of a single inert contract in a `contratti vecchi`
state was rejected on the same grounds, and he dropped it: _"vabbè. Amen. In
questo qui faremo in un altro modo, dai. Tanto … i ragazzi del reparto di
Performance Plus[ ]hanno una loro piattaforma su cui lavorano."_

## What was agreed instead

- The Performance Plus orders **do** come across, in the same standard-order
  file: _"vi passo anche la performance Plus."_
- 🔑 **Contract creation is bypassed during the migration.** Aurel Mrruku: _"io
  farò in modo che quando si genera l'ordine non devi fare gli automatismi che ci
  sono adesso … devo bypassare tutte le logiche che abbiamo fino adesso."_ Elena
  Spini pinned the scope: _"in occasione della migrazione."_
- The purpose is narrow and stated: the tutor must see what the customer bought.
  _"per me è utile che i tutor vedano quanto quel cliente ha comprato di
  performance plus … L'importante è che ci sia l'informazione sull'account."_
- Without the bypass the import fails: _"non vorrei che vada in errore alla
  procedura perché … quell'ordine deve andare a creare il contratto, il contratto
  non c'è."_

## ⚠ The ~80 contracts are still unaccounted for

In [the morning session](../meetings/2026-10-21%20Check%20Dati%20Migrazione%20e%20OP.md)
Fabrizio Paganelli had proposed doing them by hand with Elisa Migliano —
_"sui clienti che hanno la P[erformance ]P[lus] e che c'è il contratto sono 80 e
ci mettiamo io e l'Elisa, quelli li facciamo [a] mano"_ — and the afternoon call
established that hand-entry does not reproduce the structure. **Neither session
closed the loop.** So the active live Performance Plus contracts have no agreed
home: not migrated, not hand-entered, and the Performance Plus team's own
platform was named but not scoped.

## Also decided here

🟡 **Migrated orders lose their type.** Everything comes in as standard, bundles
included — _"I bundle saranno standard"_ — and Aurel Mrruku warned the
consequence: _"Non avrai una distinzione poi."_ Elena Spini was uneasy
(_"non vorrei che si crei confusione"_); Fabrizio Paganelli accepted it for
history and will do statistics elsewhere: _"sui dati storici non me ne frega
niente … ci arrangeremo in un altro modo."_

## Still open

- 🔴 The bypass is not built; it is part of the same unbuilt import work.
- 🔴 What happens to the ~80 live Performance Plus contracts.
- ⚠ The bypass is a migration-only condition in integration code and **must be
  removed afterwards**, like the edizione date reversal in
  [OI-276](OI-276%20Dummy%20import%20editions%20are%20needed%20to%20load%20historical%20orders.md).
  Nothing records who removes it or when.
