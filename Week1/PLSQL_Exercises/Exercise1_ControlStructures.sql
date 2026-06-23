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
-- ============================================================
-- Scenario 1: Apply Discount to Loan Interest Rates for 
--             Customers Above 60 Years Old
-- ============================================================
-- The bank wants to apply a 1% discount to the current loan
-- interest rates for customers who are above 60 years of age.
-- ============================================================

SET SERVEROUTPUT ON;

DECLARE
    -- Cursor to fetch all customers along with their loan details
    CURSOR c_customer_loans IS
        SELECT c.CustomerID, c.FirstName, c.LastName, c.DOB,
               l.LoanID, l.InterestRate
        FROM Customers c
        JOIN Loans l ON c.CustomerID = l.CustomerID;

    -- Variables
    v_age NUMBER;
    v_new_rate NUMBER(5, 2);
BEGIN
    DBMS_OUTPUT.PUT_LINE('============================================');
    DBMS_OUTPUT.PUT_LINE('Scenario 1: Senior Citizen Loan Discount');
    DBMS_OUTPUT.PUT_LINE('============================================');
    DBMS_OUTPUT.PUT_LINE('');

    -- Loop through all customers with loans
    FOR rec IN c_customer_loans LOOP
        -- Calculate age
        v_age := TRUNC(MONTHS_BETWEEN(SYSDATE, rec.DOB) / 12);

        -- Check if customer is above 60 years old
        IF v_age > 60 THEN
            -- Apply 1% discount to the interest rate
            v_new_rate := rec.InterestRate - 1;

            -- Update the loan with the new discounted rate
            UPDATE Loans
            SET InterestRate = v_new_rate
            WHERE LoanID = rec.LoanID;

            DBMS_OUTPUT.PUT_LINE('Customer: ' || rec.FirstName || ' ' || rec.LastName ||
                                 ' (Age: ' || v_age || ')');
            DBMS_OUTPUT.PUT_LINE('  Loan ID: ' || rec.LoanID ||
                                 ' | Old Rate: ' || rec.InterestRate || '%' ||
                                 ' | New Rate: ' || v_new_rate || '%');
            DBMS_OUTPUT.PUT_LINE('  >> 1% Discount Applied Successfully.');
            DBMS_OUTPUT.PUT_LINE('');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Customer: ' || rec.FirstName || ' ' || rec.LastName ||
                                 ' (Age: ' || v_age || ') - No discount (age <= 60).');
        END IF;
    END LOOP;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('>> All eligible discounts have been applied.');
END;
/
-- ============================================================
-- Scenario 2: Promote Customers to VIP Status Based on Balance
-- ============================================================
-- A customer can be promoted to VIP status if their balance
-- is over $10,000. This block iterates through all customers
-- and sets the IsVIP flag to 'TRUE' for eligible customers.
-- ============================================================

SET SERVEROUTPUT ON;

DECLARE
    -- Cursor to iterate through all customers
    CURSOR c_customers IS
        SELECT CustomerID, FirstName, LastName, Balance, IsVIP
        FROM Customers;

    -- Counter for tracking promotions
    v_promoted_count NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('============================================');
    DBMS_OUTPUT.PUT_LINE('Scenario 2: VIP Status Promotion');
    DBMS_OUTPUT.PUT_LINE('============================================');
    DBMS_OUTPUT.PUT_LINE('');

    -- Loop through all customers
    FOR rec IN c_customers LOOP
        -- Check if balance exceeds $10,000
        IF rec.Balance > 10000 THEN
            -- Promote to VIP
            UPDATE Customers
            SET IsVIP = 'TRUE'
            WHERE CustomerID = rec.CustomerID;

            v_promoted_count := v_promoted_count + 1;

            DBMS_OUTPUT.PUT_LINE('Customer: ' || rec.FirstName || ' ' || rec.LastName ||
                                 ' | Balance: $' || rec.Balance ||
                                 ' | Status: PROMOTED to VIP');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Customer: ' || rec.FirstName || ' ' || rec.LastName ||
                                 ' | Balance: $' || rec.Balance ||
                                 ' | Status: Not eligible for VIP');
        END IF;
    END LOOP;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('>> Total customers promoted to VIP: ' || v_promoted_count);
END;
/
-- ============================================================
-- Scenario 3: Send Reminders for Loans Due Within 30 Days
-- ============================================================
-- The bank wants to send reminders to customers whose loans
-- are due within the next 30 days. This block fetches all such
-- loans and prints a reminder message for each customer.
-- ============================================================

SET SERVEROUTPUT ON;

DECLARE
    -- Cursor to fetch loans due within the next 30 days
    CURSOR c_due_loans IS
        SELECT c.CustomerID, c.FirstName, c.LastName,
               l.LoanID, l.LoanAmount, l.EndDate,
               (l.EndDate - SYSDATE) AS DaysUntilDue
        FROM Customers c
        JOIN Loans l ON c.CustomerID = l.CustomerID
        WHERE l.EndDate BETWEEN SYSDATE AND SYSDATE + 30
        ORDER BY l.EndDate ASC;

    -- Counter for tracking reminders
    v_reminder_count NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('============================================');
    DBMS_OUTPUT.PUT_LINE('Scenario 3: Loan Due Reminders (Next 30 Days)');
    DBMS_OUTPUT.PUT_LINE('============================================');
    DBMS_OUTPUT.PUT_LINE('');

    -- Loop through all loans due within 30 days
    FOR rec IN c_due_loans LOOP
        v_reminder_count := v_reminder_count + 1;

        DBMS_OUTPUT.PUT_LINE('--------------------------------------------');
        DBMS_OUTPUT.PUT_LINE('REMINDER #' || v_reminder_count);
        DBMS_OUTPUT.PUT_LINE('--------------------------------------------');
        DBMS_OUTPUT.PUT_LINE('Dear ' || rec.FirstName || ' ' || rec.LastName || ',');
        DBMS_OUTPUT.PUT_LINE('');
        DBMS_OUTPUT.PUT_LINE('This is a reminder that your loan (Loan ID: ' || rec.LoanID || ')');
        DBMS_OUTPUT.PUT_LINE('of amount $' || rec.LoanAmount || ' is due on ' ||
                             TO_CHAR(rec.EndDate, 'DD-MON-YYYY') || '.');
        DBMS_OUTPUT.PUT_LINE('Days remaining: ' || TRUNC(rec.DaysUntilDue) || ' days.');
        DBMS_OUTPUT.PUT_LINE('');
        DBMS_OUTPUT.PUT_LINE('Please ensure timely payment to avoid penalties.');
        DBMS_OUTPUT.PUT_LINE('Thank you for banking with us!');
        DBMS_OUTPUT.PUT_LINE('');
    END LOOP;

    -- If no loans are due
    IF v_reminder_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No loans are due within the next 30 days.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('============================================');
        DBMS_OUTPUT.PUT_LINE('>> Total reminders sent: ' || v_reminder_count);
        DBMS_OUTPUT.PUT_LINE('============================================');
    END IF;
END;
/
