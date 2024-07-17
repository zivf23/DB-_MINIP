
CREATE TABLE Bank
(
  Bank_ID INT NOT NULL PRIMARY KEY CHECK (Bank_ID >= 0),
  Bank_Name VARCHAR(255),
  Bank_Address VARCHAR(255),
  Bank_Phone_Number VARCHAR(20) CHECK (Bank_Phone_Number LIKE '05%')
);

CREATE TABLE Worker
(
  Worker_ID INT NOT NULL PRIMARY KEY CHECK (Worker_ID >= 0),
  Worker_Name VARCHAR(255) CHECK (Worker_Name NOT REGEXP '[0-9]')
);

CREATE TABLE InterestRate
(
  Interest_Rate_ID INT NOT NULL PRIMARY KEY CHECK (Interest_Rate_ID >= 0),
  Benefits VARCHAR(255) CHECK (Benefits = 'None' OR Benefits = 'Long-Term Customer' OR Benefits = 'Soldier' OR Benefits = 'Student'),
  Type VARCHAR(50) CHECK (Type = 'Short-term' OR Type = 'Long-term'),
  Prime DECIMAL(10, 2) CHECK (Prime >= 0),
  Interest DECIMAL(10, 2) CHECK (Interest >= 0)
);

CREATE TABLE Deposit
(
  Deposit_ID INT NOT NULL CHECK (Deposit_ID >= 0),
  Deposit_Date DATE,
  Amount DECIMAL(10, 2),
  Account_Number INT NOT NULL,
  Interest_Rate_ID INT NOT NULL,
  Bank_ID INT NOT NULL,
  Worker_ID INT NOT NULL,
  FOREIGN KEY (Worker_ID) REFERENCES Worker(Worker_ID),
  FOREIGN KEY (Bank_ID, Account_Number) REFERENCES Account(Bank_ID, Account_Number),
  FOREIGN KEY (Interest_Rate_ID) REFERENCES InterestRate(Interest_Rate_ID),
  PRIMARY KEY (Deposit_ID, Account_Number, Bank_ID)
);

