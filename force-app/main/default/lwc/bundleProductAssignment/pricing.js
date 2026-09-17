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
