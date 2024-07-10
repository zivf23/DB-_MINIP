BEGIN
  DECLARE bonus DECIMAL(15, 2);
  DECLARE total_balance DECIMAL(15, 2);

  SELECT Balance INTO total_balance
  FROM Account
  WHERE ClientID = client_id;

  IF total_balance IS NULL THEN
    SET total_balance = 0;
  END IF;

  SET bonus = total_balance * 0.05; -- 5% bonus on total balance

  RETURN bonus;
END