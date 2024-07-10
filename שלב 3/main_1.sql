BEGIN
    DECLARE v_Bonus DECIMAL(15,2);

    -- Appel de la fonction pour calculer le bonus
    SET v_Bonus = calculate_bonus(p_ClientID);
    SELECT v_Bonus AS Bonus;

    -- Appel du protocole pour mettre à jour les budgets des projets
    CALL RetrieveEmployeeProjectDetails(p_DepartmentID);
    
END