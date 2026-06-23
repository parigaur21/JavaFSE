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
