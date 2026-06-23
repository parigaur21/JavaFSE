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
