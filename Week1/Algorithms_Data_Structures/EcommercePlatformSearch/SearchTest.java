
import java.util.Arrays;
import java.util.Comparator;

/**
 * Test class for the E-commerce Platform Search Function.
 * 
 * Demonstrates and compares Linear Search and Binary Search algorithms
 * on a dataset of products.
 * 
 * ============================================================
 * ANALYSIS: COMPARING LINEAR SEARCH vs BINARY SEARCH
 * ============================================================
 * 
 * | Criteria          | Linear Search | Binary Search   |
 * |-------------------|---------------|-----------------|
 * | Time Complexity   | O(n)          | O(log n)        |
 * | Space Complexity  | O(1)          | O(1)            |
 * | Prerequisite      | None          | Array must be   |
 * |                   |               | SORTED           |
 * | Best Case         | O(1)          | O(1)            |
 * | Worst Case        | O(n)          | O(log n)        |
 * 
 * WHICH ALGORITHM IS MORE SUITABLE FOR AN E-COMMERCE PLATFORM?
 * 
 * Binary Search is more suitable for the e-commerce platform because:
 * 
 * 1. PERFORMANCE: With thousands or millions of products, binary search's
 *    O(log n) complexity vastly outperforms linear search's O(n).
 *    For 1,000,000 products: linear search may need up to 1,000,000
 *    comparisons, while binary search needs at most ~20 comparisons.
 * 
 * 2. SCALABILITY: As the product catalog grows, binary search maintains
 *    fast performance. Doubling the catalog size only adds one more
 *    comparison step in binary search, but doubles the work in linear.
 * 
 * 3. SORTED DATA: E-commerce products are typically stored in databases
 *    with indexed (sorted) fields like productId, making the sorted
 *    prerequisite of binary search naturally satisfied.
 * 
 * 4. USER EXPERIENCE: Faster search means quicker response times,
 *    leading to better customer satisfaction on the platform.
 * 
 * However, Linear Search is still useful when:
 * - The dataset is very small.
 * - The data is unsorted and sorting cost is not justified.
 * - Searching by non-indexed fields (e.g., product description).
 */
public class SearchTest {

    public static void main(String[] args) {

        System.out.println("=== E-commerce Platform Search Function Test ===\n");

        // --- Step 1: Create an array of products (unsorted) for Linear Search ---
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

        // --- Step 2: Create a sorted copy for Binary Search ---
        Product[] productsSorted = Arrays.copyOf(productsUnsorted, productsUnsorted.length);
        Arrays.sort(productsSorted, Comparator.comparingInt(Product::getProductId)); // Sorts by productId

        System.out.println("--- Products (Unsorted - for Linear Search) ---");
        for (Product p : productsUnsorted) {
            System.out.println("  " + p);
        }

        System.out.println("\n--- Products (Sorted by productId - for Binary Search) ---");
        for (Product p : productsSorted) {
            System.out.println("  " + p);
        }

        // --- Step 3: Perform Linear Search ---
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

        // --- Step 4: Perform Binary Search ---
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

        // --- Step 5: Test searching for a product that does NOT exist ---
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
