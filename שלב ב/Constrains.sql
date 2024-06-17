-- Constraints.sql

-- Add a NOT NULL constraint to the Account table
ALTER TABLE Account
MODIFY COLUMN ClosingDate DATE NOT NULL;

-- Add a CHECK constraint to the Department table
ALTER TABLE Department
ADD CONSTRAINT chk_DepartmentBudget CHECK (Budget > 0);

-- Add a DEFAULT constraint to the Employee table
ALTER TABLE Employee
MODIFY COLUMN Position VARCHAR(50) NOT NULL DEFAULT 'Staff';