BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE v_ProjectID INT;
    DECLARE v_ProjectName VARCHAR(50);
    DECLARE v_StartDate DATE;
    DECLARE v_EndDate DATE;
    DECLARE v_Budget DECIMAL(15, 2);
    DECLARE v_DepartmentID INT;

    DECLARE cur1 CURSOR FOR 
        SELECT ProjectID, ProjectName, StartDate, EndDate, Budget, DepartmentID 
        FROM project 
        WHERE ManagerID = p_ManagerID;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur1;

    read_loop: LOOP
        FETCH cur1 INTO v_ProjectID, v_ProjectName, v_StartDate, v_EndDate, v_Budget, v_DepartmentID;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Update the ManagerID to the replacement ManagerID
        UPDATE project
        SET ManagerID = p_ManagerID_Replacement
        WHERE ProjectID = v_ProjectID;

        -- Output the updated project details
        SELECT v_ProjectID AS ProjectID, v_ProjectName AS ProjectName, v_StartDate AS StartDate, v_EndDate AS EndDate, v_Budget AS Budget, v_DepartmentID AS DepartmentID, p_ManagerID_Replacement AS NewManagerID;
    END LOOP;

    CLOSE cur1;
END