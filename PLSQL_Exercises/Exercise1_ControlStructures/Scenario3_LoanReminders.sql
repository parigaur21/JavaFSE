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
