-- Simulasi stok tracking (query manual)
-- Total masuk:
SELECT SUM(quantity) FROM transactions 
WHERE product_id = 16 AND transaction_type = 'IN';

-- Total keluar:
SELECT SUM(quantity) FROM transactions 
WHERE product_id = 16 AND transaction_type = 'OUT';

-- TRIGGER (PostgreSQL-style)
CREATE OR REPLACE FUNCTION validate_stock_before_insert()
RETURNS TRIGGER AS $$
DECLARE
  total_in INTEGER;
  total_out INTEGER;
BEGIN
  SELECT SUM(quantity) INTO total_in FROM transactions 
  WHERE product_id = NEW.product_id AND transaction_type = 'IN';

  SELECT SUM(quantity) INTO total_out FROM transactions 
  WHERE product_id = NEW.product_id AND transaction_type = 'OUT';

  IF NEW.transaction_type = 'OUT' AND (total_out + NEW.quantity) > total_in THEN
    RAISE EXCEPTION 'Stock not sufficient for this transaction';
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_stock_trigger
BEFORE INSERT ON transactions
FOR EACH ROW EXECUTE FUNCTION validate_stock_before_insert();
