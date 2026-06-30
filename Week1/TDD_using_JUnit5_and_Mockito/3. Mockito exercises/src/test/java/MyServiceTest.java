import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

/**
 * Mockito exercises demonstrating:
 * 1. Mocking and Stubbing   — fake an external dependency
 * 2. Verifying Interactions — confirm a method was called
 * 3. Argument Matchers      — flexible matching of method arguments
 */
public class MyServiceTest {

    private ExternalApi mockApi;
    private MyService   service;

    @BeforeEach
    public void setUp() {
        // Create a mock of ExternalApi (no real network call)
        mockApi = Mockito.mock(ExternalApi.class);
        service = new MyService(mockApi);
    }

    // -------------------------------------------------------
    // Exercise 1: Mocking and Stubbing
    // -------------------------------------------------------
    @Test
    public void testExternalApiReturnsMockData() {
        // Stub — tell the mock what to return when getData() is called
        when(mockApi.getData()).thenReturn("Mock Data");

        String result = service.fetchData();

        // Verify the result matches the stubbed value
        assertEquals("Mock Data", result, "fetchData() should return the stubbed mock value");
    }

    // -------------------------------------------------------
    // Exercise 2: Verifying Interactions
    // -------------------------------------------------------
    @Test
    public void testGetDataIsCalledExactlyOnce() {
        when(mockApi.getData()).thenReturn("Hello");

        service.fetchData();

        // Verify getData() was invoked exactly once
        verify(mockApi, times(1)).getData();
    }

    // -------------------------------------------------------
    // Exercise 3: Verifying NO unexpected interactions
    // -------------------------------------------------------
    @Test
    public void testNoOtherInteractionsAfterFetch() {
        when(mockApi.getData()).thenReturn("Test");

        service.fetchData();

        // First verify the expected interaction (this "marks" it as accounted for)
        verify(mockApi).getData();

        // Now verifyNoMoreInteractions confirms nothing ELSE was called on the mock
        verifyNoMoreInteractions(mockApi);
    }
}
