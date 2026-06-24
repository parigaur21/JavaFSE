import org.junit.Before;
import org.junit.After;
import org.junit.Test;
import static org.junit.Assert.assertEquals;

public class CalculatorTest {
    
    private Calculator calculator;

    @Before
    public void setUp() {
        // Arrange
        calculator = new Calculator();
        System.out.println("Setting up test...");
    }

    @After
    public void tearDown() {
        System.out.println("Tearing down test...");
        calculator = null;
    }

    @Test
    public void testAdd() {
        // Arrange is done in setUp()

        // Act
        int result = calculator.add(10, 20);

        // Assert
        assertEquals("10 + 20 should equal 30", 30, result);
    }
}
