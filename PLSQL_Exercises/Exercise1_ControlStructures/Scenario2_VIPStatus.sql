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
