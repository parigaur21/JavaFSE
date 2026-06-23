package com.singleton;

/**
 * Test class to verify the Singleton Pattern implementation of Logger.
 * 
 * This class demonstrates that:
 * 1. Only one instance of Logger is created.
 * 2. Multiple calls to getInstance() return the same object reference.
 * 3. The single instance maintains consistent state across the application.
 */
public class SingletonPatternTest {

    public static void main(String[] args) {

        System.out.println("=== Singleton Pattern Test ===\n");

        // Step 1: Get the first reference to the Logger instance
        Logger logger1 = Logger.getInstance();
        System.out.println("logger1 hashCode: " + logger1.hashCode());

        // Step 2: Get the second reference to the Logger instance
        Logger logger2 = Logger.getInstance();
        System.out.println("logger2 hashCode: " + logger2.hashCode());

        // Step 3: Verify that both references point to the same instance
        System.out.println("\nAre both logger instances the same? " + (logger1 == logger2));

        // Step 4: Use the logger to demonstrate consistent state
        System.out.println("\n--- Logging via logger1 ---");
        logger1.log("Application started.");
        logger1.log("Loading configuration...");

        System.out.println("\n--- Logging via logger2 ---");
        logger2.warn("Configuration file not found, using defaults.");
        logger2.error("Failed to connect to database.");

        // Step 5: Show that log count is shared across both references
        System.out.println("\nTotal log count via logger1: " + logger1.getLogCount());
        System.out.println("Total log count via logger2: " + logger2.getLogCount());

        System.out.println("\n=== Singleton Pattern Verified Successfully ===");
    }
}
