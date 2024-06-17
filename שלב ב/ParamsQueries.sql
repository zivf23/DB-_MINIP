
/*Retrieve all clients who registered in the last year.*/
SELECT 
    ClientID, 
    FirstName, 
    LastName, 
    RegistrationDate 
FROM 
    Client 
WHERE 
    RegistrationDate BETWEEN DATE_SUB(CURDATE(), INTERVAL 1 YEAR) AND CURDATE();
	
	
/* Retrieve all accounts with specific types ('Savings', 'Checking') and balance greater than 1000.	*/

    AccountID, 
    AccountNumber, 
    AccountType, 
    Balance 
FROM 
    Account 
WHERE 
    AccountType IN ('Savings', 'Checking') 
    AND Balance > 1000;
	
	/*Retrieve all departments with a budget between 100,000 and 50000,000.*/
SELECT 
    DepartmentID, 
    DepartmentName, 
    Budget 
FROM 
    Department 
WHERE 
    Budget BETWEEN 100000 AND 50000000;
	
	/*Retrieve all projects along with the department name and manager's full name, for projects that started after January 1, 2023.*/
	
	SELECT 
    Project.ProjectID, 
    Project.ProjectName, 
    Project.StartDate, 
    Department.DepartmentName, 
    CONCAT(Employee.FirstName, ' ', Employee.LastName) AS ManagerName 
FROM 
    Project 
JOIN 
    Department ON Project.DepartmentID = Department.DepartmentID 
LEFT JOIN 
    Employee ON Project.ManagerID = Employee.EmployeeID 
WHERE 
    Project.StartDate > '2023-01-01';