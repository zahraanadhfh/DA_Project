-- Tambah kolom transaction_type untuk menjelaskan arah transaksi
ALTER TABLE transactions ADD COLUMN transaction_type VARCHAR(10);  -- IN, OUT, RETURN

-- Ubah nilai quantity negatif menjadi positif dan tandai jenis transaksi sebagai 'OUT'
UPDATE transactions 
SET quantity = ABS(quantity), transaction_type = 'OUT'
WHERE quantity < 0;
