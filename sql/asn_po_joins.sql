-- J2: ASN lines where shipped qty is different from ordered qty
--     diff < 0 = short-ship, diff > 0 = over-ship
SELECT a.asn_id, a.po, a.sku, a.qty_shipped, p.qty_ordered,
       a.qty_shipped - p.qty_ordered AS diff
FROM asn_lines AS a
INNER JOIN po_lines AS p
  ON a.po  = p.po
 AND a.sku = p.sku
WHERE a.qty_shipped != p.qty_ordered;

-- J3: ASN lines with a SKU that is not on the PO (shipped, never ordered)
SELECT *
FROM asn_lines AS a
LEFT JOIN po_lines AS p
  ON a.po  = p.po
 AND a.sku = p.sku
WHERE p.po IS NULL;

-- J4: PO lines that were never shipped (ordered, no ASN line)
SELECT *
FROM po_lines AS p
LEFT JOIN asn_lines AS a
  ON p.po  = a.po
 AND p.sku = a.sku
WHERE a.qty_shipped IS NULL;

-- J5: Mismatched lines per vendor, most first
SELECT a.vendor, COUNT(*) AS mismatched_lines
FROM po_lines AS p
INNER JOIN asn_lines AS a
  ON p.po  = a.po
 AND p.sku = a.sku
WHERE p.qty_ordered != a.qty_shipped
GROUP BY a.vendor
ORDER BY mismatched_lines DESC;