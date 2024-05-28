CREATE TABLE Client
(
  ClientID INT NOT NULL,
  DateOfBirth DATE NOT NULL,
  RegistrationDate DATE NOT NULL,
  Email VARCHAR(255) NOT NULL,
  PhoneNumber VARCHAR(15) NOT NULL,
  FirstName VARCHAR(50) NOT NULL,
  LastName VARCHAR(50) NOT NULL,
  PRIMARY KEY (ClientID)
);

CREATE TABLE Account
(
  AccountID INT NOT NULL,
  AccountNumber VARCHAR(20) NOT NULL,
  ClientID INT NOT NULL,
  AccountType VARCHAR(50) NOT NULL,
  Balance DECIMAL(15, 2) NOT NULL,
  OpeningDate DATE NOT NULL,
  ClosingDate DATE,
  PRIMARY KEY (AccountID),
  FOREIGN KEY (ClientID) REFERENCES Client(ClientID)
);

CREATE TABLE Department
(
  DepartmentID INT NOT NULL,
  DepartmentName VARCHAR(50) NOT NULL,
  ManagerID INT NOT NULL,
  Budget DECIMAL(15, 2) NOT NULL,
  EstablishedDate DATE NOT NULL,
  LastReviewDate DATE NOT NULL,
  PRIMARY KEY (DepartmentID),
  UNIQUE (DepartmentName)
);

CREATE TABLE Employee
(
  EmployeeID INT NOT NULL,
  DateOfBirth DATE NOT NULL,
  HireDate DATE NOT NULL,
  Position VARCHAR(50) NOT NULL,
  DepartmentID INT NOT NULL,
  FirstName VARCHAR(50) NOT NULL,
  LastName VARCHAR(50) NOT NULL,
  ManagedByDepartmentID INT NOT NULL,
  PRIMARY KEY (EmployeeID),
  FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
  FOREIGN KEY (ManagedByDepartmentID) REFERENCES Department(DepartmentID)
);

CREATE TABLE Transaction
(
  TransactionID INT NOT NULL,
  TransactionDate DATE NOT NULL,
  Amount DECIMAL(15, 2) NOT NULL,
  AccountID1 INT NOT NULL,
  AccountID2 INT NOT NULL,
  EmployeeID INT NOT NULL,
  ClientID INT NOT NULL,
  PRIMARY KEY (TransactionID),
  FOREIGN KEY (ClientID) REFERENCES Client(ClientID),
  FOREIGN KEY (AccountID1) REFERENCES Account(AccountID),
  FOREIGN KEY (AccountID2) REFERENCES Account(AccountID),
  FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

CREATE TABLE Project
(
  ProjectID INT NOT NULL,
  ProjectName VARCHAR(50) NOT NULL,
  StartDate DATE NOT NULL,
  EndDate DATE,
  Budget DECIMAL(15, 2) NOT NULL,
  DepartmentID INT NOT NULL,
  ManagerID INT,
  PRIMARY KEY (ProjectID),
  FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
  FOREIGN KEY (ManagerID) REFERENCES Employee(EmployeeId)
);



CREATE TABLE WorksOn
(
  ProjectID INT NOT NULL,
  EmployeeID INT NOT NULL,
  PRIMARY KEY (ProjectID, EmployeeID),
  FOREIGN KEY (ProjectID) REFERENCES Project(ProjectID),
  FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

CREATE TABLE Service
(
  ClientID INT NOT NULL,
  EmployeeID INT NOT NULL,
  PRIMARY KEY (ClientID, EmployeeID),
  FOREIGN KEY (ClientID) REFERENCES Client(ClientID),
  FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);