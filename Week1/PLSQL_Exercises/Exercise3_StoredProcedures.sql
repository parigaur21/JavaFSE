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
-- ============================================================
-- Scenario 1: Process Monthly Interest for Savings Accounts
-- ============================================================
-- Stored procedure ProcessMonthlyInterest calculates and updates
-- the balance of all savings accounts by applying an interest
-- rate of 1% to the current balance.
-- ============================================================

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest
IS
    -- Cursor to fetch all savings accounts
    CURSOR c_savings IS
        SELECT AccountID, Balance
        FROM Accounts
        WHERE AccountType = 'Savings';

    v_new_balance   NUMBER(15, 2);
    v_interest      NUMBER(15, 2);
    v_count         NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('============================================');
    DBMS_OUTPUT.PUT_LINE('Processing Monthly Interest (1%) for Savings');
    DBMS_OUTPUT.PUT_LINE('============================================');
    DBMS_OUTPUT.PUT_LINE('');

    FOR rec IN c_savings LOOP
        -- Calculate 1% interest
        v_interest := rec.Balance * 0.01;
        v_new_balance := rec.Balance + v_interest;

        -- Update the balance
        UPDATE Accounts
        SET Balance = v_new_balance,
            LastModified = SYSDATE
        WHERE AccountID = rec.AccountID;

        v_count := v_count + 1;

        DBMS_OUTPUT.PUT_LINE('Account ID : ' || rec.AccountID);
        DBMS_OUTPUT.PUT_LINE('  Old Balance : $' || TO_CHAR(rec.Balance, '99,999,999.99'));
        DBMS_OUTPUT.PUT_LINE('  Interest    : $' || TO_CHAR(v_interest, '99,999,999.99'));
        DBMS_OUTPUT.PUT_LINE('  New Balance : $' || TO_CHAR(v_new_balance, '99,999,999.99'));
        DBMS_OUTPUT.PUT_LINE('');
    END LOOP;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('>> Monthly interest applied to ' || v_count || ' savings accounts.');
END;
/

-- ============================================================
-- Execute the procedure
-- ============================================================
BEGIN
    ProcessMonthlyInterest;
END;
/
-- ============================================================
-- Scenario 2: Update Employee Bonus Based on Performance
-- ============================================================
-- Stored procedure UpdateEmployeeBonus updates the salary of
-- employees in a given department by adding a bonus percentage
-- passed as a parameter.
-- ============================================================

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus (
    p_department    IN VARCHAR2,
    p_bonus_percent IN NUMBER
)
IS
    -- Cursor to fetch employees in the specified department
    CURSOR c_employees IS
        SELECT EmployeeID, FirstName, LastName, Salary
        FROM Employees
        WHERE Department = p_department;

    v_bonus       NUMBER(15, 2);
    v_new_salary  NUMBER(15, 2);
    v_count       NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('============================================');
    DBMS_OUTPUT.PUT_LINE('Updating Employee Bonus');
    DBMS_OUTPUT.PUT_LINE('Department : ' || p_department);
    DBMS_OUTPUT.PUT_LINE('Bonus %    : ' || p_bonus_percent || '%');
    DBMS_OUTPUT.PUT_LINE('============================================');
    DBMS_OUTPUT.PUT_LINE('');

    FOR rec IN c_employees LOOP
        -- Calculate bonus amount
        v_bonus := rec.Salary * (p_bonus_percent / 100);
        v_new_salary := rec.Salary + v_bonus;

        -- Update the salary with the bonus
        UPDATE Employees
        SET Salary = v_new_salary
        WHERE EmployeeID = rec.EmployeeID;

        v_count := v_count + 1;

        DBMS_OUTPUT.PUT_LINE('Employee   : ' || rec.FirstName || ' ' || rec.LastName);
        DBMS_OUTPUT.PUT_LINE('  Old Salary : $' || TO_CHAR(rec.Salary, '99,999,999.99'));
        DBMS_OUTPUT.PUT_LINE('  Bonus      : $' || TO_CHAR(v_bonus, '99,999,999.99'));
        DBMS_OUTPUT.PUT_LINE('  New Salary : $' || TO_CHAR(v_new_salary, '99,999,999.99'));
        DBMS_OUTPUT.PUT_LINE('');
    END LOOP;

    -- Handle case where no employees found in the department
    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No employees found in department: ' || p_department);
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('>> Bonus applied to ' || v_count || ' employees in ' || p_department || ' department.');
    END IF;
END;
/

-- ============================================================
-- Execute the procedure with sample parameters
-- ============================================================
-- Apply 10% bonus to IT department
BEGIN
    UpdateEmployeeBonus('IT', 10);
END;
/

-- Apply 15% bonus to Finance department
BEGIN
    UpdateEmployeeBonus('Finance', 15);
END;
/
-- ============================================================
-- Scenario 3: Transfer Funds Between Accounts
-- ============================================================
-- Stored procedure TransferFunds transfers a specified amount
-- from one account to another. It checks that the source account
-- has sufficient balance before making the transfer.
-- ============================================================

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE TransferFunds (
    p_source_account  IN NUMBER,
    p_target_account  IN NUMBER,
    p_amount          IN NUMBER
)
IS
    v_source_balance  NUMBER(15, 2);
    v_target_balance  NUMBER(15, 2);
    v_source_exists   NUMBER;
    v_target_exists   NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('============================================');
    DBMS_OUTPUT.PUT_LINE('Fund Transfer Request');
    DBMS_OUTPUT.PUT_LINE('From Account : ' || p_source_account);
    DBMS_OUTPUT.PUT_LINE('To Account   : ' || p_target_account);
    DBMS_OUTPUT.PUT_LINE('Amount       : $' || TO_CHAR(p_amount, '99,999,999.99'));
    DBMS_OUTPUT.PUT_LINE('============================================');
    DBMS_OUTPUT.PUT_LINE('');

    -- Validate transfer amount
    IF p_amount <= 0 THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: Transfer amount must be positive.');
        RETURN;
    END IF;

    -- Check if source account exists
    SELECT COUNT(*) INTO v_source_exists
    FROM Accounts WHERE AccountID = p_source_account;

    IF v_source_exists = 0 THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: Source account ' || p_source_account || ' does not exist.');
        RETURN;
    END IF;

    -- Check if target account exists
    SELECT COUNT(*) INTO v_target_exists
    FROM Accounts WHERE AccountID = p_target_account;

    IF v_target_exists = 0 THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: Target account ' || p_target_account || ' does not exist.');
        RETURN;
    END IF;

    -- Check if source and target are different
    IF p_source_account = p_target_account THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: Source and target accounts cannot be the same.');
        RETURN;
    END IF;

    -- Get the current balance of the source account
    SELECT Balance INTO v_source_balance
    FROM Accounts WHERE AccountID = p_source_account;

    -- Check if sufficient balance is available
    IF v_source_balance < p_amount THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: Insufficient balance in source account.');
        DBMS_OUTPUT.PUT_LINE('  Available Balance : $' || TO_CHAR(v_source_balance, '99,999,999.99'));
        DBMS_OUTPUT.PUT_LINE('  Requested Amount  : $' || TO_CHAR(p_amount, '99,999,999.99'));
        RETURN;
    END IF;

    -- Get the current balance of the target account
    SELECT Balance INTO v_target_balance
    FROM Accounts WHERE AccountID = p_target_account;

    -- Perform the transfer: Debit source account
    UPDATE Accounts
    SET Balance = Balance - p_amount,
        LastModified = SYSDATE
    WHERE AccountID = p_source_account;

    -- Credit target account
    UPDATE Accounts
    SET Balance = Balance + p_amount,
        LastModified = SYSDATE
    WHERE AccountID = p_target_account;

    COMMIT;

    -- Print confirmation
    DBMS_OUTPUT.PUT_LINE('>> Transfer Successful!');
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('Source Account (' || p_source_account || '):');
    DBMS_OUTPUT.PUT_LINE('  Previous Balance : $' || TO_CHAR(v_source_balance, '99,999,999.99'));
    DBMS_OUTPUT.PUT_LINE('  New Balance      : $' || TO_CHAR(v_source_balance - p_amount, '99,999,999.99'));
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('Target Account (' || p_target_account || '):');
    DBMS_OUTPUT.PUT_LINE('  Previous Balance : $' || TO_CHAR(v_target_balance, '99,999,999.99'));
    DBMS_OUTPUT.PUT_LINE('  New Balance      : $' || TO_CHAR(v_target_balance + p_amount, '99,999,999.99'));

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('ERROR: Transfer failed - ' || SQLERRM);
END;
/

-- ============================================================
-- Test Case 1: Successful Transfer
-- ============================================================
BEGIN
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('>>> TEST 1: Successful Transfer <<<');
    TransferFunds(1001, 1002, 5000);
END;
/

-- ============================================================
-- Test Case 2: Insufficient Balance
-- ============================================================
BEGIN
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('>>> TEST 2: Insufficient Balance <<<');
    TransferFunds(1004, 1003, 999999);
END;
/

-- ============================================================
-- Test Case 3: Same Account Transfer (Error)
-- ============================================================
BEGIN
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('>>> TEST 3: Same Account Transfer <<<');
    TransferFunds(1001, 1001, 1000);
END;
/
