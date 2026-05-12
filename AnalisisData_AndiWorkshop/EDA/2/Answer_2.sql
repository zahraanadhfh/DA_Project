--Database: warehouse_project

--DROP DATABASE IF EXISTS warehouse_project;

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

CREATE TABLE Product (
    product_id SERIAL PRIMARY KEY,
    name TEXT UNIQUE NOT NULL
);

CREATE TABLE Unit (
    unit_id SERIAL PRIMARY KEY,
    name TEXT UNIQUE NOT NULL
);

CREATE TABLE Vendor (
    vendor_id SERIAL PRIMARY KEY,
    name TEXT UNIQUE NOT NULL
);

CREATE TABLE Client (
    client_id SERIAL PRIMARY KEY,
    name TEXT UNIQUE NOT NULL
);

CREATE TABLE WarehouseManager (
    manager_id SERIAL PRIMARY KEY,
    name TEXT UNIQUE NOT NULL
);

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
