/**
 * Calculator class providing basic arithmetic operations.
 * Used for JUnit 4 testing exercises.
 */
public class Calculator {

    // Add two integers
    public int add(int a, int b) {
        return a + b;
    }

    // Subtract two integers
    public int subtract(int a, int b) {
        return a - b;
    }

    // Multiply two integers
    public int multiply(int a, int b) {
        return a * b;
    }

    // Divide two integers — throws exception if divisor is zero
    public double divide(int a, int b) {
        if (b == 0) {
            throw new ArithmeticException("Cannot divide by zero");
        }
        return (double) a / b;
    }
}
