-- ============================================================
-- PL/SQL Exercise 1: Control Structures
-- ============================================================
-- This script creates the necessary tables and sample data
-- for all three scenarios in Exercise 1.
-- ============================================================

-- =====================
-- TABLE: Customers
-- =====================
CREATE TABLE Customers (
    CustomerID    NUMBER PRIMARY KEY,
    FirstName     VARCHAR2(50),
    LastName      VARCHAR2(50),
    DOB           DATE,
    Balance       NUMBER(15, 2),
    IsVIP         CHAR(5) DEFAULT 'FALSE'
);

-- =====================
-- TABLE: Loans
-- =====================
CREATE TABLE Loans (
    LoanID         NUMBER PRIMARY KEY,
    CustomerID     NUMBER REFERENCES Customers(CustomerID),
    LoanAmount     NUMBER(15, 2),
    InterestRate   NUMBER(5, 2),
    StartDate      DATE,
    EndDate        DATE
);

-- =====================
-- INSERT Sample Customers
-- =====================
INSERT INTO Customers (CustomerID, FirstName, LastName, DOB, Balance, IsVIP)
VALUES (1, 'Rajesh',  'Kumar',    TO_DATE('1955-03-15', 'YYYY-MM-DD'), 15000.00, 'FALSE');

INSERT INTO Customers (CustomerID, FirstName, LastName, DOB, Balance, IsVIP)
VALUES (2, 'Priya',   'Sharma',   TO_DATE('1990-07-22', 'YYYY-MM-DD'), 5000.00,  'FALSE');

INSERT INTO Customers (CustomerID, FirstName, LastName, DOB, Balance, IsVIP)
VALUES (3, 'Amit',    'Patel',    TO_DATE('1960-11-10', 'YYYY-MM-DD'), 12000.00, 'FALSE');

INSERT INTO Customers (CustomerID, FirstName, LastName, DOB, Balance, IsVIP)
VALUES (4, 'Sunita',  'Verma',    TO_DATE('1958-01-05', 'YYYY-MM-DD'), 8000.00,  'FALSE');

INSERT INTO Customers (CustomerID, FirstName, LastName, DOB, Balance, IsVIP)
VALUES (5, 'Vikram',  'Singh',    TO_DATE('1985-09-30', 'YYYY-MM-DD'), 25000.00, 'FALSE');

INSERT INTO Customers (CustomerID, FirstName, LastName, DOB, Balance, IsVIP)
VALUES (6, 'Meena',   'Gupta',    TO_DATE('1950-06-18', 'YYYY-MM-DD'), 3000.00,  'FALSE');

-- =====================
-- INSERT Sample Loans
-- =====================
INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (101, 1, 500000, 8.50, TO_DATE('2023-01-15', 'YYYY-MM-DD'), TO_DATE('2028-01-15', 'YYYY-MM-DD'));

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (102, 2, 200000, 7.00, TO_DATE('2024-06-01', 'YYYY-MM-DD'), SYSDATE + 20);

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (103, 3, 300000, 9.00, TO_DATE('2023-09-10', 'YYYY-MM-DD'), SYSDATE + 10);

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (104, 4, 150000, 8.00, TO_DATE('2024-03-20', 'YYYY-MM-DD'), SYSDATE + 25);

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (105, 5, 700000, 7.50, TO_DATE('2022-12-01', 'YYYY-MM-DD'), TO_DATE('2027-12-01', 'YYYY-MM-DD'));

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (106, 6, 100000, 9.50, TO_DATE('2024-01-10', 'YYYY-MM-DD'), SYSDATE + 5);

COMMIT;
