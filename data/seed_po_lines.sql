-- PO lines: what was ORDERED. One row per PO + SKU.
-- Load AFTER seed_asn_lines.sql, into asn_db.
DROP TABLE IF EXISTS po_lines;

CREATE TABLE po_lines (
    po          TEXT          NOT NULL,
    sku         TEXT          NOT NULL,
    qty_ordered INTEGER       NOT NULL,
    unit_price  NUMERIC(10,2) NOT NULL,
    PRIMARY KEY (po, sku)
);

INSERT INTO po_lines VALUES
('PO-6001', 'SKU-A', 240, 4.50),
('PO-6001', 'SKU-B', 120, 5.00),
('PO-6002', 'SKU-A', 350, 4.50),
('PO-6002', 'SKU-C', 80, 3.10),
('PO-6003', 'SKU-B', 150, 5.00),
('PO-6003', 'SKU-E', 40, 22.00),
('PO-6004', 'SKU-A', 200, 4.50),
('PO-6005', 'SKU-D', 90, 12.00),
('PO-6005', 'SKU-F', 50, 8.75),
('PO-6006', 'SKU-C', 100, 3.10),
('PO-6007', 'SKU-A', 180, 4.50),
('PO-6007', 'SKU-G', 50, 15.00),
('PO-6007', 'SKU-H', 100, 1.25),
('PO-6008', 'SKU-G', 75, 14.00),
('PO-6008', 'SKU-H', 200, 1.25),
('PO-6009', 'SKU-H', 500, 1.25),
('PO-6010', 'SKU-A', 160, 4.50),
('PO-6010', 'SKU-B', 100, 5.00),
('PO-6011', 'SKU-B', 80, 5.00),
('PO-6011', 'SKU-C', 500, 3.10),
('PO-6011', 'SKU-E', 25, 22.00),
('PO-6012', 'SKU-C', 450, 3.10),
('PO-6013', 'SKU-E', 30, 22.00),
('PO-6014', 'SKU-J', 900, 0.85),
('PO-6014', 'SKU-K', 300, 2.40),
('PO-6015', 'SKU-J', 800, 0.85),
('PO-6016', 'SKU-J', 600, 0.85),
('PO-6016', 'SKU-K', 250, 2.40),
('PO-6017', 'SKU-L', 4, 145.00),
('PO-6017', 'SKU-M', 3, 38.50),
('PO-6018', 'SKU-L', 2, 145.00),
('PO-6018', 'SKU-M', 4, 38.50),
('PO-6019', 'SKU-M', 5, 38.50),
('PO-6020', 'SKU-G', 40, 15.00),
('PO-6020', 'SKU-H', 300, 1.25);
