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
