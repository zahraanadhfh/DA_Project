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

UPDATE Product SET name = 'Termos Air Atau Bukan Yaa?' 
WHERE name = 'Termos Air Panas';

select * from product;

UPDATE Unit SET name = 'helm'
WHERE name = 'piece' AND unit_id IN (
  SELECT unit_id FROM Transaction t
  JOIN Product p ON t.product_id = p.product_id
  WHERE p.name = 'Helm anti tampan'
);

select * from unit;

DELETE FROM Client WHERE name = 'Gusti';

select * from client;

DELETE FROM Vendor WHERE name = 'RestoSupply';

select * from vendor;

ALTER TABLE warehousemanager ADD COLUMN is_active BOOLEAN DEFAULT TRUE;
UPDATE warehousemanager SET is_active = FALSE WHERE manager_id = 8;

select * from warehousemanager;