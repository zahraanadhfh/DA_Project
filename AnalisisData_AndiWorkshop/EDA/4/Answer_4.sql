-- Database: warehouse_project

-- DROP DATABASE IF EXISTS warehouse_project;

CREATE DATABASE warehouse_project
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

CREATE TABLE Transaction (
    transaction_id SERIAL PRIMARY KEY,
    product_id INTEGER REFERENCES Product(product_id),
    quantity INTEGER NULL,
    unit_id INTEGER REFERENCES Unit(unit_id),
    transaction_time TIMESTAMP NOT NULL,
    vendor_id INTEGER REFERENCES Vendor(vendor_id),
    client_id INTEGER REFERENCES Client(client_id),
    manager_id INTEGER REFERENCES WarehouseManager(manager_id)
);

CREATE TABLE staging_transaksi (
    waktu TIMESTAMP,
    nama_barang TEXT,
    jumlah INTEGER,
    unit TEXT,
    vendor TEXT,
    client TEXT,
    diproses_oleh TEXT
);

copy staging_transaksi FROM 'C:\data.csv' WITH CSV HEADER;

INSERT INTO product (name)
SELECT DISTINCT nama_barang FROM staging_transaksi WHERE nama_barang IS NOT NULL
ON CONFLICT DO NOTHING;

INSERT INTO unit (name)
SELECT DISTINCT unit FROM staging_transaksi WHERE unit IS NOT NULL
ON CONFLICT DO NOTHING;

INSERT INTO vendor (name)
SELECT DISTINCT vendor FROM staging_transaksi WHERE vendor IS NOT NULL
ON CONFLICT DO NOTHING;

INSERT INTO client (name)
SELECT DISTINCT client FROM staging_transaksi WHERE client IS NOT NULL
ON CONFLICT DO NOTHING;

INSERT INTO warehousemanager (name)
SELECT DISTINCT diproses_oleh FROM staging_transaksi WHERE diproses_oleh IS NOT NULL
ON CONFLICT DO NOTHING;

INSERT INTO Transaction (transaction_time, product_id, quantity, unit_id, vendor_id, client_id, manager_id)
SELECT
    s.waktu,
    p.product_id,
    s.jumlah,
    u.unit_id,
    v.vendor_id,
    c.client_id,
    wm.manager_id
FROM staging_transaksi s
LEFT JOIN product p ON p.name = s.nama_barang
LEFT JOIN unit u ON u.name = s.unit
LEFT JOIN vendor v ON v.name = s.vendor
LEFT JOIN client c ON c.name = s.client
LEFT JOIN warehousemanager wm ON wm.name = s.diproses_oleh;