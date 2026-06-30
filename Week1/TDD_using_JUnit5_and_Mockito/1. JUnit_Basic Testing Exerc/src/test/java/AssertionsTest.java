import org.junit.Test;
import static org.junit.Assert.*;

/**
 * AssertionsTest — demonstrates the key JUnit 4 assertion methods.
 *
 * Exercises covered:
 * - assertEquals  : checks two values are equal
 * - assertTrue    : checks a condition is true
 * - assertFalse   : checks a condition is false
 * - assertNull    : checks a value is null
 * - assertNotNull : checks a value is not null
 * - assertArrayEquals : checks two arrays are equal
 */
public class AssertionsTest {

    @Test
    public void testAssertions() {
        // Assert equals — checks exact value match
        assertEquals("2 + 3 should equal 5", 5, 2 + 3);

        // Assert true — checks boolean condition
        assertTrue("5 should be greater than 3", 5 > 3);

        // Assert false — checks opposite condition
        assertFalse("5 should NOT be less than 3", 5 < 3);

        // Assert null — checks reference is null
        assertNull("null should be null", null);

        // Assert not null — checks object is created
        assertNotNull("new Object() should not be null", new Object());
    }

    @Test
    public void testAssertArrayEquals() {
        int[] expected = {1, 2, 3};
        int[] actual   = {1, 2, 3};
        // Checks every element of both arrays matches
        assertArrayEquals("Arrays should be equal", expected, actual);
    }

    @Test
    public void testAssertEqualsWithDelta() {
        double a = 0.1 + 0.2;
        // delta = tolerance for floating-point comparison
        assertEquals("0.1 + 0.2 should be close to 0.3", 0.3, a, 0.0001);
    }
}
