BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_ProjectID INT;
    DECLARE v_ProjectName VARCHAR(50);
    DECLARE v_StartDate DATE;
    DECLARE v_EndDate DATE;
    DECLARE cur1 CURSOR FOR SELECT ProjectID, ProjectName, StartDate, EndDate FROM Project WHERE DepartmentID = p_DepartmentID;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur1;

    read_loop: LOOP
        FETCH cur1 INTO v_ProjectID, v_ProjectName, v_StartDate, v_EndDate;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Demonstrating a simple DML operation within a loop
        UPDATE Project SET Budget = Budget * 1.05 WHERE ProjectID = v_ProjectID;

        -- Output each project detail
        SELECT v_ProjectID, v_ProjectName, v_StartDate, v_EndDate;
    END LOOP;

    CLOSE cur1;
END