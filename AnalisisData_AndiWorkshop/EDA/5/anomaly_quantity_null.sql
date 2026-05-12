-- Perbaiki nilai NULL dengan nilai default (misal 0 atau validasi manual)
UPDATE transactions
SET quantity = 0  -- atau nilai sebenarnya jika diketahui
WHERE quantity IS NULL;

-- Tambah constraint agar ke depan tidak terjadi lagi
ALTER TABLE transactions 
ALTER COLUMN quantity SET NOT NULL;
