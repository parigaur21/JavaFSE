package com.forecasting;

/**
 * Financial Forecasting Tool using Recursive Algorithms.
 * 
 * ============================================================
 * UNDERSTANDING RECURSION
 * ============================================================
 * 
 * Recursion is a programming technique where a method calls itself
 * to solve a smaller sub-problem of the original problem. Each recursive
 * call reduces the problem size until a base case is reached.
 * 
 * Key components of recursion:
 * 1. BASE CASE    - The condition that stops the recursion.
 * 2. RECURSIVE CASE - The method calls itself with a smaller input.
 * 
 * How recursion simplifies financial forecasting:
 * - Future value calculation is naturally recursive:
 *   FV(n) = FV(n-1) * (1 + growthRate)
 *   FV(0) = presentValue (base case)
 * - Each year's value depends on the previous year's value,
 *   making recursion an intuitive approach.
 * 
 * ============================================================
 * TIME COMPLEXITY ANALYSIS
 * ============================================================
 * 
 * Basic Recursive Approach:
 *   Time Complexity: O(n)  - one recursive call per period
 *   Space Complexity: O(n) - due to the call stack depth
 * 
 * Optimized Iterative Approach:
 *   Time Complexity: O(n)  - same time complexity
 *   Space Complexity: O(1) - no call stack overhead
 * 
 * OPTIMIZATION STRATEGIES:
 * 1. MEMOIZATION: Store previously computed values to avoid redundant
 *    calculations (useful when the same sub-problems are solved multiple times).
 * 2. ITERATIVE CONVERSION: Convert recursion to iteration to eliminate
 *    call stack overhead and prevent StackOverflowError for large inputs.
 * 3. TAIL RECURSION: Restructure the recursion so the recursive call is
 *    the last operation, allowing compiler optimization (tail-call optimization).
 * 4. MATHEMATICAL FORMULA: Use the direct formula FV = PV * (1 + r)^n
 *    for O(1) time when growth rate is constant.
 */
public class FinancialForecaster {

    /**
     * Calculates future value using a RECURSIVE approach.
     * 
     * Formula: FV(n) = FV(n-1) * (1 + growthRate)
     * Base case: FV(0) = presentValue
     * 
     * Time Complexity: O(n)
     * Space Complexity: O(n) due to recursive call stack
     * 
     * @param presentValue the current/initial value of the investment
     * @param growthRate   the annual growth rate (e.g., 0.05 for 5%)
     * @param periods      the number of time periods (years) into the future
     * @return the predicted future value
     */
    public static double calculateFutureValueRecursive(double presentValue, double growthRate, int periods) {
        // Base case: no more periods to calculate
        if (periods == 0) {
            return presentValue;
        }
        // Recursive case: calculate the value for the previous period,
        // then apply the growth rate
        return calculateFutureValueRecursive(presentValue, growthRate, periods - 1) * (1 + growthRate);
    }

    /**
     * Calculates future value using a MEMOIZED recursive approach.
     * 
     * Stores intermediate results in an array to avoid recomputation.
     * Particularly useful when the method is called multiple times with
     * overlapping sub-problems.
     * 
     * Time Complexity: O(n)
     * Space Complexity: O(n) for the memoization cache
     * 
     * @param presentValue the current/initial value
     * @param growthRate   the annual growth rate
     * @param periods      the number of time periods
     * @return the predicted future value
     */
    public static double calculateFutureValueMemoized(double presentValue, double growthRate, int periods) {
        double[] memo = new double[periods + 1];
        return memoizedHelper(presentValue, growthRate, periods, memo);
    }

    private static double memoizedHelper(double presentValue, double growthRate, int periods, double[] memo) {
        // Base case
        if (periods == 0) {
            return presentValue;
        }
        // Check if already computed
        if (memo[periods] != 0) {
            return memo[periods];
        }
        // Compute and store the result
        memo[periods] = memoizedHelper(presentValue, growthRate, periods - 1, memo) * (1 + growthRate);
        return memo[periods];
    }

    /**
     * Calculates future value using an ITERATIVE approach (optimized).
     * 
     * This avoids the overhead of recursive call stacks and is safe
     * for very large numbers of periods.
     * 
     * Time Complexity: O(n)
     * Space Complexity: O(1) - no extra memory needed
     * 
     * @param presentValue the current/initial value
     * @param growthRate   the annual growth rate
     * @param periods      the number of time periods
     * @return the predicted future value
     */
    public static double calculateFutureValueIterative(double presentValue, double growthRate, int periods) {
        double futureValue = presentValue;
        for (int i = 0; i < periods; i++) {
            futureValue *= (1 + growthRate);
        }
        return futureValue;
    }

    /**
     * Calculates future value using the direct MATHEMATICAL FORMULA.
     * 
     * Formula: FV = PV * (1 + r)^n
     * 
     * This is the most optimized approach with O(1) time complexity
     * (assuming Math.pow runs in constant time).
     * 
     * @param presentValue the current/initial value
     * @param growthRate   the annual growth rate
     * @param periods      the number of time periods
     * @return the predicted future value
     */
    public static double calculateFutureValueFormula(double presentValue, double growthRate, int periods) {
        return presentValue * Math.pow(1 + growthRate, periods);
    }
}
