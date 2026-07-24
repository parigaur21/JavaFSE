import org.junit.Test;
import static org.junit.Assert.*;


public class AssertionsTest {

    @Test
    public void testAssertions() {
        
        assertEquals("2 + 3 should equal 5", 5, 2 + 3);

        
        assertTrue("5 should be greater than 3", 5 > 3);

        
        assertFalse("5 should NOT be less than 3", 5 < 3);

        
        assertNull("null should be null", null);

        
        assertNotNull("new Object() should not be null", new Object());
    }

    @Test
    public void testAssertArrayEquals() {
        int[] expected = {1, 2, 3};
        int[] actual   = {1, 2, 3};
        
        assertArrayEquals("Arrays should be equal", expected, actual);
    }

    @Test
    public void testAssertEqualsWithDelta() {
        double a = 0.1 + 0.2;
        
        assertEquals("0.1 + 0.2 should be close to 0.3", 0.3, a, 0.0001);
    }
}
