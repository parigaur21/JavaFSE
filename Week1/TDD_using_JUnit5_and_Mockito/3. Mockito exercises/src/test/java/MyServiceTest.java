import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;


public class MyServiceTest {

    private ExternalApi mockApi;
    private MyService   service;

    @BeforeEach
    public void setUp() {
        
        mockApi = Mockito.mock(ExternalApi.class);
        service = new MyService(mockApi);
    }

    
    
    
    @Test
    public void testExternalApiReturnsMockData() {
        
        when(mockApi.getData()).thenReturn("Mock Data");

        String result = service.fetchData();

        
        assertEquals("Mock Data", result, "fetchData() should return the stubbed mock value");
    }

    
    
    
    @Test
    public void testGetDataIsCalledExactlyOnce() {
        when(mockApi.getData()).thenReturn("Hello");

        service.fetchData();

        
        verify(mockApi, times(1)).getData();
    }

    
    
    
    @Test
    public void testNoOtherInteractionsAfterFetch() {
        when(mockApi.getData()).thenReturn("Test");

        service.fetchData();

        
        verify(mockApi).getData();

        
        verifyNoMoreInteractions(mockApi);
    }
}
