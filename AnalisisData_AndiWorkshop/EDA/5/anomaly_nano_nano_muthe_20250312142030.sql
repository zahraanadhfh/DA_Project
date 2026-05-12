
begin;

UPDATE "transactions" SET "value" = 9
WHERE "vendor_id" = (
    select id from "vendor" where "name" = 'muthe'
) and "created_at" = '2025-03-12 14:20:30';

ALTER TABLE "transaction" ALTER COLUMN "value" TYPE INTEGER;

rollback;
commit;