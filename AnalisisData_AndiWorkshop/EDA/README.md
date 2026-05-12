# ANDI'S WAREHOUSE PROJECT
## Requirement
Andi ingin membangun sistem manajemen gudang untuk melacak alur barang dari vendor ke gudang, kemudian ke client. Setiap perubahan barang (prosesing) harus tercatat. Setiap transaksi melibatkan unit konversi yang berbeda.

- Andi mempunyai beberapa Warehouse Manager sebagai karyawannya
- Andi mempunyai beberapa Vendor yang mengirim barang ke gudangnya
- Andi hanya mengirim barang ke Client
- Warehouse manager tugasnya untuk  memproses barang. Proses barang yang dimaksud adalah merubah barang menjadi unit lebih kecil, contoh: 1 box -> 30 strip, 1 strip -> 12 kaplet
- Barang yang masuk dan keluar BISA beda unit, misalkan yang masuk 1 box, yang keluar 5 selop, sisanya masih di gudang

- tampilan yang dibutuhkan Andi: 
   - dashboard utama: 
        * ID barang, 
        * Nama Barang, 
        * Sisa Barang di Gudang, 
        * Unit satuan barang yang tersisa di gudang (box, selop, piece, dll)
   - statistik barang: 
        * ID Barang, 
        * Nama barang, 
        * jumlah barang masuk, 
        * jumlah barang keluar (karna diproses atau dikirim). 
        * Bisa difilter berdasarkan vendor, warehouse manager, maupun client
   - statistik pelaporan barang harian: 
        * jumlah barang masuk, 
        * jumlah barang diproses, 
        * jumlah barang dikirim per hari. 
        * Bisa difilter berdasarkan vendor, warehouse manager, maupun client

## Soal 
1. Buatkan ER Diagram untuk sistem database yang dibutuhkan oleh Andi
2. Buatlah database menggunakan PostgreSQL berdasarkan ER Diagram anda
3. Buatlah SQL Query untuk menampilkan apa yang dibutuhkan Andi
4. Buatlah SQL Query untuk memasukan data berdasarkan dari csv yang sudah diberikan 
    - [OPTIONAL] sertakan transaction 
5. Sebutkan anomali-anomali data yang ada di data tersebut dan cara anda untuk memperbaiki data tersebut
6. Buatlah SQL Query untuk mengubah data:
    - ubah nama barang "Termos Air Panas" jadi "Termos Air Atau Bukan Yaa?"
    - ubah unit barang "Helm anti tampan" dari piece jadi helm
    - hapus data client Gusti
    - hapus data vendor RestoSupply
    - hapus data manager Rusli

[OPTIONAL]

7. buatlah visualisasi statistik pelaporan harian
8. buatlah program untuk bulk insert ke sistem memakai CSV
9. buatlah program yang dapat memvisualisasikan apa yang dibutuhkan Andi (table, statistik, dan filtering) [VIEW ONLY]

## Important Note
- Kumpulkan kedalam 1 private repository github lalu invite (`kamil5b`,`justarya`) kedalam repository anda
- Ketentutan menjawab ada di README di masing masing folder jawaban
- Kirim link github repository anda ke HR

Semangat menjawab dan sukses!xxx
