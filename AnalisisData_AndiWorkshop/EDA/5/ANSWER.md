Anomali data:
1. Jumlah Barang "Nano nano" ada koma
    - Cause: 
        - Pada 2025-03-12 14:20:30, barang dari Vendor "Muthe" terdata "9.8"
        - Data type kolum transaksi menerima floating point
    - Expected: 
        - jumlah barang tidak boleh ada koma
    - Solution: 
        - Bulatkan menjadi 9, anggap 0.8 adalah barang cacat
        - Alter table transaksi column value menjadi integer
    - Solution file: anomaly_nano_nano_muthe_20250312142030.sql
