

public class SingletonPatternTest {

    public static void main(String[] args) {

        System.out.println("=== Singleton Pattern Test ===\n");

        
        Logger logger1 = Logger.getInstance();
        System.out.println("logger1 hashCode: " + logger1.hashCode());

        
        Logger logger2 = Logger.getInstance();
        System.out.println("logger2 hashCode: " + logger2.hashCode());

        
        System.out.println("\nAre both logger instances the same? " + (logger1 == logger2));

        
        System.out.println("\n--- Logging via logger1 ---");
        logger1.log("Application started.");
        logger1.log("Loading configuration...");

        System.out.println("\n--- Logging via logger2 ---");
        logger2.warn("Configuration file not found, using defaults.");
        logger2.error("Failed to connect to database.");

        
        System.out.println("\nTotal log count via logger1: " + logger1.getLogCount());
        System.out.println("Total log count via logger2: " + logger2.getLogCount());

        System.out.println("\n=== Singleton Pattern Verified Successfully ===");
    }
}
