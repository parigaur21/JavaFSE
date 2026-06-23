
/**
 * Logger class implementing the Singleton Design Pattern.
 * 
 * This class ensures that only one instance of the Logger exists
 * throughout the entire application lifecycle, providing consistent
 * logging across all components.
 * 
 * Key characteristics of the Singleton Pattern used here:
 * 1. Private static instance variable
 * 2. Private constructor to prevent external instantiation
 * 3. Public static method to access the single instance
 * 4. Thread-safe lazy initialization using synchronized block
 */
public class Logger {

    // Step 1: Private static instance of the Logger class
    private static Logger instance;

    // Log count to track the number of log messages
    private int logCount = 0;

    // Step 2: Private constructor to prevent instantiation from outside
    private Logger() {
        System.out.println("Logger instance created.");
    }

    // Step 3: Public static method to get the single instance of Logger
    // Uses double-checked locking for thread safety
    public static Logger getInstance() {
        if (instance == null) {
            synchronized (Logger.class) {
                if (instance == null) {
                    instance = new Logger();
                }
            }
        }
        return instance;
    }

    /**
     * Logs an informational message.
     * 
     * @param message the message to log
     */
    public void log(String message) {
        logCount++;
        System.out.println("[LOG " + logCount + "]: " + message);
    }

    /**
     * Logs a warning message.
     * 
     * @param message the warning message to log
     */
    public void warn(String message) {
        logCount++;
        System.out.println("[WARN " + logCount + "]: " + message);
    }

    /**
     * Logs an error message.
     * 
     * @param message the error message to log
     */
    public void error(String message) {
        logCount++;
        System.out.println("[ERROR " + logCount + "]: " + message);
    }

    /**
     * Returns the total number of log messages recorded.
     * 
     * @return the log count
     */
    public int getLogCount() {
        return logCount;
    }
}
