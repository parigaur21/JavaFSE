import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class LoggingExample {
    // Create a Logger instance for this class
    private static final Logger logger = LoggerFactory.getLogger(LoggingExample.class);

    public static void main(String[] args) {
        // Exercise 1: Logging Error Messages and Warning Levels
        logger.error("This is an error message");
        logger.warn("This is a warning message");
        
        // Let's add some informational logs as well just to show it's working nicely
        logger.info("Application started successfully.");
        logger.debug("Debugging information: user triggered a process.");
    }
}
