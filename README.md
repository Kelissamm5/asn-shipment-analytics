# ASN Shipment Analytics

Analysis of inbound Advance Ship Notices (ASNs) to find delayed freight,
late carriers, and shipment discrepancies before they hit the receiving dock.

## The business problem

An ASN tells the warehouse what is coming, when, and in what quantity.
When ASNs are late, wrong, or not tracked, the receiving dock finds out the hard way:
trucks arrive unplanned, labor is scheduled for the wrong day, short-shipped lines
go unnoticed until inventory is off, and vendor and carrier problems repeat
because nobody has the numbers to raise them.

This project turns raw ASN lines into answers a receiving or inbound planning team
can act on.

## What this project answers

| Question | Why the dock cares |
|---|---|
| How many ASNs are delayed right now? | Open freight to chase today |
| Which vendors ship the most value, and which ship the most units? | Labor planning vs. risk and insurance |
| Which ASN lines haven't been received yet? | What the dock is still waiting on |
| Which vendors have repeated delays? | Vendor scorecard and escalation |
| Which carriers deliver late most often? | Carrier performance review |

All queries are in [`sql/asn_analysis.sql`](sql/asn_analysis.sql), each under the business question it answers.

## Data

[`data/seed_asn_lines.sql`](data/seed_asn_lines.sql): one month of inbound ASN lines
(34 lines, 20 ASNs, 5 vendors, 4 carriers, October 2026).
The data is synthetic. No real company data is used.

Each row is one SKU on one ASN:
`asn_id, vendor, po, sku, qty_shipped, unit_cost, carrier, ship_date, expected_date, received_date, status`

## Example finding: units are not value

| Vendor | Units shipped | Value shipped |
|---|---|---|
| UMBRELLA | 2,950 | $3,360.00 |
| STARK | 17 | $1,293.50 |

UMBRELLA ships the most units of any vendor but ranks 4th by value, because its SKUs cost under $3 each.
STARK ships only 17 units, yet they are worth almost $1,300.
Ranking vendors by units alone would staff the dock for UMBRELLA and overlook
the high-value STARK freight that needs careful receiving and counting.

## Lessons built into the queries

- **Count documents, not lines.** One ASN can carry several SKUs, so `COUNT(DISTINCT asn_id)` is used instead of `COUNT(*)`. Counting lines would report 9 delayed ASNs instead of 6.
- **Missing dates are `NULL`.** Open ASNs are found with `IS NULL`; `= NULL` silently returns nothing.
- **Zero-quantity lines are flagged.** An ASN line shipped at 0 points to a short-ship or backorder.

## Tools

SQL · PostgreSQL 17 · pgAdmin

## Roadmap

- [x] SQL analysis of ASN lines
- [x] Load ASN data into PostgreSQL (asn_db)
- [ ] PostgreSQL database: PO + ASN tables
- [ ] Python pipeline: load and validate ASN data
- [ ] Dashboard
