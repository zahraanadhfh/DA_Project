-- Validasi manual (cari baris tidak ada pelaku)
SELECT * FROM transactions
WHERE vendor_id IS NULL AND client_id IS NULL AND manager_id IS NULL;

-- (Opsional, jika sistem DBMS mendukung CHECK dengan OR logic)
ALTER TABLE transactions
ADD CONSTRAINT at_least_one_actor
CHECK (
  vendor_id IS NOT NULL OR client_id IS NOT NULL OR manager_id IS NOT NULL
);
