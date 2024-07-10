BEGIN
    DECLARE v_TransactionCount INT;

    -- Appel de la fonction pour obtenir le nombre de transactions
    SET v_TransactionCount = count_transactions(p_ClientID);
    SELECT v_TransactionCount AS TransactionCount;

    -- Appel du protocole pour mettre à jour les projets
    CALL ReplaceManager(p_ManagerID, p_ManagerID_Replacement);
END