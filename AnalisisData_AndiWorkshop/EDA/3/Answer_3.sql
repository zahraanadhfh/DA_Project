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

--Dashbord Utama
SELECT 
    p.product_id,
    p.name AS product_name,
    SUM(t.quantity) AS total_quantity,
    u.name AS unit
FROM Transaction t
JOIN Product p ON t.product_id = p.product_id
JOIN Unit u ON t.unit_id = u.unit_id
GROUP BY p.product_id, p.name, u.name
HAVING SUM(t.quantity) != 0;

--Statistik Barang
SELECT 
    p.product_id,
    p.name AS product_name,
    SUM(CASE WHEN t.quantity > 0 THEN t.quantity ELSE 0 END) AS total_in,
    SUM(CASE WHEN t.quantity < 0 THEN -t.quantity ELSE 0 END) AS total_out
FROM Transaction t
JOIN Product p ON t.product_id = p.product_id
LEFT JOIN Vendor v ON t.vendor_id = v.vendor_id
LEFT JOIN Client c ON t.client_id = c.client_id
LEFT JOIN WarehouseManager wm ON t.manager_id = wm.manager_id
WHERE --filter
    (v.vendor_id = NULL OR NULL IS NULL) AND
    (c.client_id = NULL OR NULL IS NULL) AND
    (wm.manager_id = 5 OR 5 IS NULL)
GROUP BY p.product_id, p.name;

--Statistik Pelaporan Barang Harian
SELECT 
    DATE(t.transaction_time) AS date,
    SUM(CASE WHEN t.vendor_id IS NOT NULL THEN t.quantity ELSE 0 END) AS incoming,
    SUM(CASE WHEN t.manager_id IS NOT NULL THEN ABS(t.quantity) ELSE 0 END) AS processed,
    SUM(CASE WHEN t.client_id IS NOT NULL THEN ABS(t.quantity) ELSE 0 END) AS outgoing
FROM Transaction t
WHERE --filter
    (t.vendor_id = 10 OR 10 IS NULL) AND
    (t.client_id = NULL OR NULL IS NULL) AND
    (t.manager_id = NULL OR NULL IS NULL)
GROUP BY DATE(t.transaction_time)
ORDER BY date;
	