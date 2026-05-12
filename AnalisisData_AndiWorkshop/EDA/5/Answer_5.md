Anomali Data pada Tabel Transaksi

1. Kolom Quantity NULL
- Cause:  
  Pada 2024-04-30 14:00:00, 'product_id = 22' (ID 46) memiliki nilai 'quantity = NULL'.
- Expected:  
  Setiap transaksi harus memiliki 'quantity' yang valid (tidak NULL).
- Solution:  
  Tambahkan NOT NULL constraint di kolom 'quantity'.
- Solution File: anomaly_quantity_null.sql

2. Transaksi Tanpa Vendor/Client/Manager
- Cause:  
  Pada 2024-04-09 12:00:00, 'product_id = 13' (ID 9), semua pelaku ('vendor_id', 'client_id', 'manager_id') NULL kecuali 'manager_id = 8'.
- Expected:  
  Harus ada pelaku transaksi minimal satu entitas (vendor, client, atau manager).
- Solution:  
  Validasi bahwa minimal satu entitas pelaku tidak NULL.
- Solution File: anomaly_transactions.sql

3. Transaksi Duplikat Waktu dan Produk
- Cause:  
  Pada 2024-04-09 12:00:00, dua transaksi dengan 'product_id = 13' muncul (ID 9 dan 10).
- Expected:  
  Hanya satu transaksi per produk per waktu, atau perlu penanda bahwa itu koreksi.
- Solution:  
  - Tambahkan kolom 'is_correction' atau 'correction_of_id'.
  - Terapkan unique constraint pada kombinasi ('product_id', 'transaction_time') jika diperlukan.
- Solution File: anomaly_duplicate_time.sql

4. Barang Keluar Melebihi Barang Masuk
- Cause:  
  Untuk 'product_id = 16':
  - Masuk:  
    - 2024-04-02 15:00:00 (ID 1)  
    - 2024-04-17 09:20:00 (ID 19) → Total Masuk = 15
  - Keluar:  
    - 2024-04-06 11:00:00 (ID 5)  
    - 2024-04-25 14:40:00 (ID 33) → Total Keluar = 18
- Expected:  
  Barang keluar tidak boleh melebihi jumlah barang masuk.
- Solution:  
  - Tambahkan sistem pengecekan saldo barang.
  - Tolak transaksi keluar bila jumlah barang masuk tidak mencukupi.
- Solution File: anomaly_outgoing_incoming_products.sql

5. Unit ID Tidak Konsisten untuk Produk yang Sama
- Cause:  
  Untuk produk yang sama:
  - 2024-04-07 15:00:00 (ID 6): 'unit_id = 2'  
  - 2024-04-12 13:00:00 (ID 11): 'unit_id = 3'
- Expected:  
  Satu produk harus memiliki 'unit_id' yang konsisten atau sistem konversi antar unit.
- Solution:  
  Tetapkan 'default_unit_id' di tabel produk.
- Solution File: anomaly_unit_id_inconsistent.sql

6. Kuantitas Barang Negatif
- Cause:  
  Pada 2024-04-06 11:00:00, 'product_id = 16' memiliki 'quantity = -3' (ID 5).
- Expected:  
  Tidak jelas apakah ini transaksi keluar atau koreksi.
- Solution:  
  - Tambahkan kolom 'transaction_type' (contoh: 'IN', 'OUT', 'RETURN').  
  - Pastikan 'quantity' selalu bernilai positif, arah transaksi ditentukan oleh 'transaction_type'.
- Solution File: anomaly_quantity_negative.sql