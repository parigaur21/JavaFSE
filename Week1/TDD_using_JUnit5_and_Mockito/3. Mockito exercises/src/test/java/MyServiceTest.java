import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

public class MyServiceTest {

    // Exercise 1: Mocking and Stubbing
    @Test
    public void testExternalApi() {
        ExternalApi mockApi = Mockito.mock(ExternalApi.class);
        
        // Stub the method to return predefined value
        when(mockApi.getData()).thenReturn("Mock Data");
        
        MyService service = new MyService(mockApi);
        String result = service.fetchData();
        
        // Assert the result matches the stubbed data
        assertEquals("Mock Data", result);
    }

    // Exercise 2: Verifying Interactions
    @Test
    public void testVerifyInteraction() {
        ExternalApi mockApi = Mockito.mock(ExternalApi.class);
        MyService service = new MyService(mockApi);
        
        // Call the method that uses the dependency
        service.fetchData();
        
        // Verify that getData() was called exactly once
        verify(mockApi).getData();
    }
}
