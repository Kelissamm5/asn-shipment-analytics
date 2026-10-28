-- =====================================================================
-- ASN SQL Analysis
-- Business questions about one month of inbound ASN activity (Oct 2026)
-- Table: asn_lines  (one row per SKU on an ASN, data in seed_asn_lines.sql)
-- =====================================================================


-- W: Which vendors shipped more than $5,000 in total value?
SELECT vendor, SUM(qty_shipped * unit_cost) AS total_value
FROM asn_lines
GROUP BY vendor
HAVING SUM(qty_shipped * unit_cost) > 5000;


-- Q1: How many ASNs are currently delayed?
-- Count documents, not lines: one ASN can carry several SKU lines.
SELECT COUNT(DISTINCT asn_id) AS delayed_asns
FROM asn_lines
WHERE status = 'DELAYED';


-- Q2: Units and dollar value shipped per vendor, highest value first.
-- Most units is not most value: compare UMBRELLA and STARK.
SELECT vendor,
       SUM(qty_shipped)             AS total_units,
       SUM(qty_shipped * unit_cost) AS total_value
FROM asn_lines
GROUP BY vendor
ORDER BY total_value DESC;


-- Q3: Top 3 SKUs by units shipped.
SELECT sku, SUM(qty_shipped) AS total_units
FROM asn_lines
GROUP BY sku
ORDER BY total_units DESC
LIMIT 3;


-- Q4: Average, smallest and largest line quantity per vendor.
-- A MIN of 0 flags an ASN line shipped at zero: a short-ship or backorder to review.
SELECT vendor,
       AVG(qty_shipped) AS avg_qty,
       MIN(qty_shipped) AS min_qty,
       MAX(qty_shipped) AS max_qty
FROM asn_lines
GROUP BY vendor;


-- Q5a: Which ASN lines have no received date yet?
-- Use IS NULL. "= NULL" always returns zero rows.
SELECT *
FROM asn_lines
WHERE received_date IS NULL;

-- Q5b: How many ASNs is that?
SELECT COUNT(DISTINCT asn_id) AS open_asns
FROM asn_lines
WHERE received_date IS NULL;


-- Q6: Which vendors have more than 2 delayed ASNs?
-- WHERE filters lines first, HAVING filters vendor totals after grouping.
SELECT vendor, COUNT(DISTINCT asn_id) AS delayed_asns
FROM asn_lines
WHERE status = 'DELAYED'
GROUP BY vendor
HAVING COUNT(DISTINCT asn_id) > 2;


-- Q7: Per carrier, how many ASNs arrived after their expected date?
SELECT carrier, COUNT(DISTINCT asn_id) AS late_asns
FROM asn_lines
WHERE received_date > expected_date
GROUP BY carrier
ORDER BY late_asns DESC;
