

public class SearchAlgorithms {

    
    public static Product linearSearch(Product[] products, int targetId) {
        for (int i = 0; i < products.length; i++) {
            if (products[i].getProductId() == targetId) {
                return products[i]; 
            }
        }
        return null; 
    }

    
    public static Product binarySearch(Product[] products, int targetId) {
        int low = 0;
        int high = products.length - 1;

        while (low <= high) {
            int mid = low + (high - low) / 2; 
            int midId = products[mid].getProductId();

            if (midId == targetId) {
                return products[mid]; 
            } else if (midId < targetId) {
                low = mid + 1; 
            } else {
                high = mid - 1; 
            }
        }
        return null; 
    }
}
