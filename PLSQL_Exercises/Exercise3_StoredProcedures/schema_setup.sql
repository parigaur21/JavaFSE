-- ============================================================
-- PL/SQL Exercise 3: Stored Procedures
-- ============================================================
-- This script creates the necessary tables and sample data
-- for all three scenarios in Exercise 3.
-- ============================================================

-- =====================
-- TABLE: Accounts
-- =====================
CREATE TABLE Accounts (
    AccountID     NUMBER PRIMARY KEY,
    CustomerID    NUMBER,
    AccountType   VARCHAR2(20),   -- 'Savings', 'Current'
    Balance       NUMBER(15, 2),
    LastModified  DATE DEFAULT SYSDATE
);

-- =====================
-- TABLE: Employees
-- =====================
CREATE TABLE Employees (
    EmployeeID    NUMBER PRIMARY KEY,
    FirstName     VARCHAR2(50),
    LastName      VARCHAR2(50),
    Department    VARCHAR2(50),
    Salary        NUMBER(15, 2)
);

-- =====================
-- INSERT Sample Accounts
-- =====================
INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance)
VALUES (1001, 1, 'Savings', 50000.00);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance)
VALUES (1002, 2, 'Current', 30000.00);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance)
VALUES (1003, 3, 'Savings', 75000.00);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance)
VALUES (1004, 4, 'Savings', 20000.00);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance)
VALUES (1005, 5, 'Current', 100000.00);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance)
VALUES (1006, 1, 'Savings', 45000.00);

-- =====================
-- INSERT Sample Employees
-- =====================
INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, Salary)
VALUES (201, 'Ankit',    'Mehta',    'IT',        60000.00);

INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, Salary)
VALUES (202, 'Sneha',    'Rao',      'IT',        55000.00);

INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, Salary)
VALUES (203, 'Ravi',     'Desai',    'Finance',   70000.00);

INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, Salary)
VALUES (204, 'Pooja',    'Nair',     'HR',        50000.00);

INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, Salary)
VALUES (205, 'Karan',    'Joshi',    'Finance',   65000.00);

INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, Salary)
VALUES (206, 'Divya',    'Kapoor',   'IT',        58000.00);

COMMIT;
