

public class FinancialForecaster {

    
    public static double calculateFutureValueRecursive(double presentValue, double growthRate, int periods) {
        
        if (periods == 0) {
            return presentValue;
        }
        
        
        return calculateFutureValueRecursive(presentValue, growthRate, periods - 1) * (1 + growthRate);
    }

    
    public static double calculateFutureValueMemoized(double presentValue, double growthRate, int periods) {
        double[] memo = new double[periods + 1];
        return memoizedHelper(presentValue, growthRate, periods, memo);
    }

    private static double memoizedHelper(double presentValue, double growthRate, int periods, double[] memo) {
        
        if (periods == 0) {
            return presentValue;
        }
        
        if (memo[periods] != 0) {
            return memo[periods];
        }
        
        memo[periods] = memoizedHelper(presentValue, growthRate, periods - 1, memo) * (1 + growthRate);
        return memo[periods];
    }

    
    public static double calculateFutureValueIterative(double presentValue, double growthRate, int periods) {
        double futureValue = presentValue;
        for (int i = 0; i < periods; i++) {
            futureValue *= (1 + growthRate);
        }
        return futureValue;
    }

    
    public static double calculateFutureValueFormula(double presentValue, double growthRate, int periods) {
        return presentValue * Math.pow(1 + growthRate, periods);
    }
}
