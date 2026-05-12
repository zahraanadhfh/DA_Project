-- Tambah kolom default unit di tabel produk
ALTER TABLE products ADD COLUMN default_unit_id INTEGER;

-- Update unit yang tidak sesuai ke default unit (jika diketahui)
UPDATE transactions
SET unit_id = (SELECT default_unit_id FROM products WHERE id = transactions.product_id)
WHERE product_id = 18 AND unit_id != (SELECT default_unit_id FROM products WHERE id = transactions.product_id);
