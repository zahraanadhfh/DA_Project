-- Tambah kolom untuk menandai koreksi
ALTER TABLE transactions ADD COLUMN correction_of_id INTEGER;

-- (Opsional) Tandai transaksi duplikat sebagai koreksi
UPDATE transactions 
SET correction_of_id = 9
WHERE transaction_id = 10;

-- Tambah unique constraint jika tidak ingin duplikat tanpa koreksi
CREATE UNIQUE INDEX unique_product_time 
ON transactions (product_id, transaction_time)
WHERE correction_of_id IS NULL;
