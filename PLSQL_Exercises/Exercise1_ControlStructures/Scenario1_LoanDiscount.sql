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
