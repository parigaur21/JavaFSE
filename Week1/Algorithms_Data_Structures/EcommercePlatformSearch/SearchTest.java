
import java.util.Arrays;
import java.util.Comparator;


public class SearchTest {

    public static void main(String[] args) {

        System.out.println("=== E-commerce Platform Search Function Test ===\n");

        
        Product[] productsUnsorted = {
            new Product(105, "Laptop",        "Electronics"),
            new Product(203, "Smartphone",    "Electronics"),
            new Product(42,  "Running Shoes", "Footwear"),
            new Product(310, "Backpack",      "Accessories"),
            new Product(78,  "Headphones",    "Electronics"),
            new Product(156, "Novel Book",    "Books"),
            new Product(289, "Water Bottle",  "Kitchen"),
            new Product(15,  "Desk Lamp",     "Home"),
            new Product(432, "Yoga Mat",      "Fitness"),
            new Product(67,  "Sunglasses",    "Accessories")
        };

        
        Product[] productsSorted = Arrays.copyOf(productsUnsorted, productsUnsorted.length);
        Arrays.sort(productsSorted, Comparator.comparingInt(Product::getProductId)); 

        System.out.println("--- Products (Unsorted - for Linear Search) ---");
        for (Product p : productsUnsorted) {
            System.out.println("  " + p);
        }

        System.out.println("\n--- Products (Sorted by productId - for Binary Search) ---");
        for (Product p : productsSorted) {
            System.out.println("  " + p);
        }

        
        int searchId1 = 78;
        System.out.println("\n========================================");
        System.out.println("LINEAR SEARCH for productId: " + searchId1);
        System.out.println("========================================");

        long startTime = System.nanoTime();
        Product result1 = SearchAlgorithms.linearSearch(productsUnsorted, searchId1);
        long endTime = System.nanoTime();

        if (result1 != null) {
            System.out.println("Found: " + result1);
        } else {
            System.out.println("Product not found.");
        }
        System.out.println("Time taken: " + (endTime - startTime) + " nanoseconds");

        
        int searchId2 = 78;
        System.out.println("\n========================================");
        System.out.println("BINARY SEARCH for productId: " + searchId2);
        System.out.println("========================================");

        startTime = System.nanoTime();
        Product result2 = SearchAlgorithms.binarySearch(productsSorted, searchId2);
        endTime = System.nanoTime();

        if (result2 != null) {
            System.out.println("Found: " + result2);
        } else {
            System.out.println("Product not found.");
        }
        System.out.println("Time taken: " + (endTime - startTime) + " nanoseconds");

        
        int searchId3 = 999;
        System.out.println("\n========================================");
        System.out.println("SEARCH for non-existent productId: " + searchId3);
        System.out.println("========================================");

        System.out.println("\nLinear Search:");
        startTime = System.nanoTime();
        Product result3 = SearchAlgorithms.linearSearch(productsUnsorted, searchId3);
        endTime = System.nanoTime();
        System.out.println(result3 != null ? "Found: " + result3 : "Product not found.");
        System.out.println("Time taken: " + (endTime - startTime) + " nanoseconds");

        System.out.println("\nBinary Search:");
        startTime = System.nanoTime();
        Product result4 = SearchAlgorithms.binarySearch(productsSorted, searchId3);
        endTime = System.nanoTime();
        System.out.println(result4 != null ? "Found: " + result4 : "Product not found.");
        System.out.println("Time taken: " + (endTime - startTime) + " nanoseconds");

        System.out.println("\n=== Search Function Test Completed Successfully ===");
    }
}
