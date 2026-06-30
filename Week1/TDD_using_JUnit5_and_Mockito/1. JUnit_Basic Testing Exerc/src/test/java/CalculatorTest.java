import org.junit.Before;
import org.junit.After;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 * JUnit 4 tests for the Calculator class.
 *
 * Demonstrates:
 * - @Before  : setup runs before each test
 * - @After   : teardown runs after each test
 * - @Test    : marks a method as a test case
 * - assertEquals, assertTrue, assertThrows style check
 */
public class CalculatorTest {

    private Calculator calculator;

    @Before
    public void setUp() {
        // Arrange — create a fresh Calculator before every test
        calculator = new Calculator();
        System.out.println("Setting up test...");
    }

    @After
    public void tearDown() {
        System.out.println("Tearing down test...");
        calculator = null;
    }

    // -------------------------------------------------------
    // Exercise 1: Test the add() method
    // -------------------------------------------------------
    @Test
    public void testAdd() {
        int result = calculator.add(10, 20);
        assertEquals("10 + 20 should equal 30", 30, result);
    }

    @Test
    public void testAddWithNegatives() {
        int result = calculator.add(-5, 3);
        assertEquals("-5 + 3 should equal -2", -2, result);
    }

    // -------------------------------------------------------
    // Exercise 2: Test subtract()
    // -------------------------------------------------------
    @Test
    public void testSubtract() {
        int result = calculator.subtract(50, 20);
        assertEquals("50 - 20 should equal 30", 30, result);
    }

    // -------------------------------------------------------
    // Exercise 3: Test multiply()
    // -------------------------------------------------------
    @Test
    public void testMultiply() {
        int result = calculator.multiply(6, 7);
        assertEquals("6 * 7 should equal 42", 42, result);
    }

    // -------------------------------------------------------
    // Exercise 4: Test divide()
    // -------------------------------------------------------
    @Test
    public void testDivide() {
        double result = calculator.divide(10, 2);
        assertEquals("10 / 2 should equal 5.0", 5.0, result, 0.0001);
    }

    @Test(expected = ArithmeticException.class)
    public void testDivideByZeroThrowsException() {
        // Should throw ArithmeticException
        calculator.divide(10, 0);
    }
}
