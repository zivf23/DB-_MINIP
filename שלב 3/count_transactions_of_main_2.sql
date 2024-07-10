BEGIN
  DECLARE transaction_count INT;

  SELECT COUNT(*) INTO transaction_count
  FROM Transaction
  WHERE ClientID = client_id;

  RETURN IFNULL(transaction_count, 0);
END