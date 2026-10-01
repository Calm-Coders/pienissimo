export function validRows(rows) {
  return rows.every(
    (row) =>
      Number.isInteger(row.quantity) &&
      row.quantity > 0 &&
      Number.isFinite(row.spreadPrice) &&
      row.spreadPrice >= 0 &&
      Math.abs(row.spreadPrice * 100 - Math.round(row.spreadPrice * 100)) <
        0.00001
  );
}

export const PRICING_SOURCE_DISCOUNT = "discount";
export const PRICING_SOURCE_MANUAL = "manual";

export function calculateDiscountedTotal(row) {
  const total =
    Number(row.listPrice) *
    Number(row.quantity) *
    (1 - Number(row.discountPercent) / 100);
  return Math.round(total * 100) / 100;
}

export function calculateDiscountPercent(row) {
  const listTotal = Number(row.listPrice) * Number(row.quantity);
  if (listTotal <= 0 || row.spreadPrice == null) return null;
  return Math.round((1 - Number(row.spreadPrice) / listTotal) * 10000) / 100;
}

export function resolveRowPrice(row) {
  if (
    row.pricingSource === PRICING_SOURCE_DISCOUNT &&
    row.discountPercent != null
  ) {
    return { ...row, spreadPrice: calculateDiscountedTotal(row) };
  }
  return row;
}
