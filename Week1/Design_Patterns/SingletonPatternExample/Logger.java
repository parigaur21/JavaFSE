

public class Logger {

    
    private static Logger instance;

    
    private int logCount = 0;

    
    private Logger() {
        System.out.println("Logger instance created.");
    }

    
    
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

    
    public void log(String message) {
        logCount++;
        System.out.println("[LOG " + logCount + "]: " + message);
    }

    
    public void warn(String message) {
        logCount++;
        System.out.println("[WARN " + logCount + "]: " + message);
    }

    
    public void error(String message) {
        logCount++;
        System.out.println("[ERROR " + logCount + "]: " + message);
    }

    
    public int getLogCount() {
        return logCount;
    }
}
