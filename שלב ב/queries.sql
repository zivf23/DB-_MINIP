
/*Retrieve the total number of transactions and average transaction amount per client who registered in the current year, grouped by client and ordered by total transactions.*/

SELECT 
    C.ClientID,
    CONCAT(C.FirstName, ' ', C.LastName) AS ClientName,
    COUNT(T.TransactionID) AS TotalTransactions,
    AVG(T.Amount) AS AverageTransactionAmount
FROM 
    Client C
    JOIN Transaction T ON C.ClientID = T.ClientID
WHERE 
    YEAR(C.RegistrationDate) = YEAR(CURDATE())
GROUP BY 
    C.ClientID, ClientName
ORDER BY 
    TotalTransactions DESC;
	
	
	
	/*List employees managing projects with a budget higher than the average project budget, including the employee's name, project name, and project budget, ordered by budget.*/
	SELECT 
    E.EmployeeID,
    CONCAT(E.FirstName, ' ', E.LastName) AS EmployeeName,
    P.ProjectName,
    P.Budget
FROM 
    Employee E
    JOIN Project P ON E.EmployeeID = P.ManagerID
WHERE 
    P.Budget > (SELECT AVG(Budget) FROM Project)
ORDER BY 
    P.Budget DESC;
	
	
	/*Retrieve monthly transaction amounts for each account in the current year, grouped by account number and month, and ordered by account number and month.*/
	
	SELECT 
    A.AccountNumber,
    YEAR(T.TransactionDate) AS Year,
    MONTH(T.TransactionDate) AS Month,
    SUM(T.Amount) AS TotalAmount
FROM 
    Account A
    JOIN Transaction T ON A.AccountID = T.AccountID1
WHERE 
    YEAR(T.TransactionDate) = YEAR(CURDATE())
GROUP BY 
    A.AccountNumber, Year, Month
ORDER BY 
    A.AccountNumber, Month;
	
/*This query will provide the total transaction amount for each department per month for the current year*/
	SELECT 
    D.DepartmentID,
    D.DepartmentName,
    CONCAT(M.FirstName, ' ', M.LastName) AS ManagerName,
    YEAR(T.TransactionDate) AS Year,
    MONTH(T.TransactionDate) AS Month,
    SUM(T.Amount) AS TotalTransactionAmount
FROM 
    Department D
    JOIN Employee M ON D.ManagerID = M.EmployeeID
    JOIN Employee E ON D.DepartmentID = E.DepartmentID
    JOIN Account A ON E.EmployeeID = A.ClientID
    JOIN Transaction T ON A.AccountID = T.AccountID1
WHERE 
    YEAR(T.TransactionDate) = YEAR(CURDATE())
GROUP BY 
    D.DepartmentID, D.DepartmentName, ManagerName, Year, Month
ORDER BY 
    D.DepartmentName, Month;
	
	
	/*Update Query 1
Increase the budget by 10% for departments established more than ten years ago by comparing the establishment date with the current date.*/
	UPDATE 
    Department
SET 
    Budget = Budget * 1.10
WHERE 
    YEAR(EstablishedDate) < YEAR(CURDATE()) - 10;
	
	/*Set the closing date to the current date for accounts that have a zero balance and are currently open by checking the balance and closing date fields.*/
	UPDATE 
    Account
SET 
    ClosingDate = CURDATE()
WHERE 
    Balance = 0 AND ClosingDate IS NULL;
	
	
	/*Delete accounts that have no transactions and have been closed for more than three years.*/
	
	DELETE FROM 
    Account
WHERE 
    AccountID NOT IN (
        SELECT DISTINCT AccountID1 
        FROM Transaction
    )
    AND AccountID NOT IN (
        SELECT DISTINCT AccountID2 
        FROM Transaction
    )
    AND ClosingDate IS NOT NULL
    AND YEAR(ClosingDate) < YEAR(CURDATE()) - 3;
	
	/*Delete departments that have no projects and no employees associated with them.*/
	
	DELETE FROM 
    Department
WHERE 
    DepartmentID NOT IN (
        SELECT DISTINCT DepartmentID 
        FROM Project
    )
    AND DepartmentID NOT IN (
        SELECT DISTINCT DepartmentID 
        FROM Employee
    );