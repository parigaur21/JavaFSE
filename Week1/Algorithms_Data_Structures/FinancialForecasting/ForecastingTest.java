
/**
 * Test class for the Financial Forecasting Tool.
 * 
 * Demonstrates and compares four approaches to calculate future value:
 * 1. Basic Recursion
 * 2. Memoized Recursion
 * 3. Iterative Approach
 * 4. Direct Mathematical Formula
 */
public class FinancialForecastingTest {

    public static void main(String[] args) {

        System.out.println("=== Financial Forecasting Tool Test ===\n");

        // --- Input Parameters ---
        double presentValue = 10000.00;  // Initial investment: $10,000
        double growthRate = 0.08;         // Annual growth rate: 8%
        int periods = 10;                 // Forecast for 10 years

        System.out.println("Initial Investment : $" + String.format("%.2f", presentValue));
        System.out.println("Annual Growth Rate : " + (growthRate * 100) + "%");
        System.out.println("Forecast Period    : " + periods + " years");
        System.out.println();

        // --- Method 1: Basic Recursive Approach ---
        System.out.println("--- Method 1: Basic Recursive Approach ---");
        long startTime = System.nanoTime();
        double result1 = FinancialForecaster.calculateFutureValueRecursive(presentValue, growthRate, periods);
        long endTime = System.nanoTime();
        System.out.println("Future Value : $" + String.format("%.2f", result1));
        System.out.println("Time taken   : " + (endTime - startTime) + " ns");
        System.out.println("Complexity   : Time O(n), Space O(n)\n");

        // --- Method 2: Memoized Recursive Approach ---
        System.out.println("--- Method 2: Memoized Recursive Approach ---");
        startTime = System.nanoTime();
        double result2 = FinancialForecaster.calculateFutureValueMemoized(presentValue, growthRate, periods);
        endTime = System.nanoTime();
        System.out.println("Future Value : $" + String.format("%.2f", result2));
        System.out.println("Time taken   : " + (endTime - startTime) + " ns");
        System.out.println("Complexity   : Time O(n), Space O(n)\n");

        // --- Method 3: Iterative Approach (Optimized) ---
        System.out.println("--- Method 3: Iterative Approach (Optimized) ---");
        startTime = System.nanoTime();
        double result3 = FinancialForecaster.calculateFutureValueIterative(presentValue, growthRate, periods);
        endTime = System.nanoTime();
        System.out.println("Future Value : $" + String.format("%.2f", result3));
        System.out.println("Time taken   : " + (endTime - startTime) + " ns");
        System.out.println("Complexity   : Time O(n), Space O(1)\n");

        // --- Method 4: Direct Formula Approach ---
        System.out.println("--- Method 4: Direct Formula FV = PV * (1 + r)^n ---");
        startTime = System.nanoTime();
        double result4 = FinancialForecaster.calculateFutureValueFormula(presentValue, growthRate, periods);
        endTime = System.nanoTime();
        System.out.println("Future Value : $" + String.format("%.2f", result4));
        System.out.println("Time taken   : " + (endTime - startTime) + " ns");
        System.out.println("Complexity   : Time O(1), Space O(1)\n");

        // --- Verification: All methods should produce the same result ---
        System.out.println("========================================");
        System.out.println("VERIFICATION: All results match?");
        System.out.println("========================================");
        boolean allMatch = (Math.abs(result1 - result2) < 0.01)
                        && (Math.abs(result2 - result3) < 0.01)
                        && (Math.abs(result3 - result4) < 0.01);
        System.out.println("All methods produce the same result: " + allMatch);

        // --- Year-by-Year Forecast using Recursion ---
        System.out.println("\n========================================");
        System.out.println("YEAR-BY-YEAR FORECAST (Recursive)");
        System.out.println("========================================");
        System.out.printf("%-6s | %-15s%n", "Year", "Projected Value");
        System.out.println("-------|----------------");
        for (int year = 0; year <= periods; year++) {
            double value = FinancialForecaster.calculateFutureValueRecursive(presentValue, growthRate, year);
            System.out.printf("%-6d | $%-14.2f%n", year, value);
        }

        System.out.println("\n=== Financial Forecasting Test Completed Successfully ===");
    }
}
