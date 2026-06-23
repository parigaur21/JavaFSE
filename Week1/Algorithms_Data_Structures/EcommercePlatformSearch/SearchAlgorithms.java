
/**
 * SearchAlgorithms class implementing Linear Search and Binary Search
 * for finding products on an e-commerce platform.
 * 
 * ============================================================
 * UNDERSTANDING ASYMPTOTIC NOTATION (Big O Notation)
 * ============================================================
 * 
 * Big O notation is a mathematical notation used to describe the 
 * upper bound (worst-case) of an algorithm's time or space complexity 
 * as the input size grows. It helps us understand how an algorithm 
 * scales and allows us to compare the efficiency of different algorithms.
 * 
 * Common Big O complexities (from fastest to slowest):
 *   O(1)       - Constant time   (e.g., array index access)
 *   O(log n)   - Logarithmic     (e.g., binary search)
 *   O(n)       - Linear          (e.g., linear search)
 *   O(n log n) - Linearithmic    (e.g., merge sort)
 *   O(n^2)     - Quadratic       (e.g., bubble sort)
 *   O(2^n)     - Exponential     (e.g., naive recursion)
 * 
 * ============================================================
 * SEARCH OPERATION SCENARIOS
 * ============================================================
 * 
 * LINEAR SEARCH:
 *   Best Case:    O(1)   - Target is the first element.
 *   Average Case: O(n)   - Target is somewhere in the middle.
 *   Worst Case:   O(n)   - Target is the last element or not present.
 * 
 * BINARY SEARCH:
 *   Best Case:    O(1)     - Target is the middle element.
 *   Average Case: O(log n) - Target found after several halvings.
 *   Worst Case:   O(log n) - Target is at the extreme end or not present.
 *   Prerequisite: The array must be SORTED.
 */
public class SearchAlgorithms {

    /**
     * LINEAR SEARCH
     * 
     * Sequentially checks each element of the array until a match is found
     * or the entire array has been searched.
     * 
     * Time Complexity: O(n)
     * Space Complexity: O(1)
     * 
     * @param products array of Product objects to search through
     * @param targetId the productId to search for
     * @return the Product if found, null otherwise
     */
    public static Product linearSearch(Product[] products, int targetId) {
        for (int i = 0; i < products.length; i++) {
            if (products[i].getProductId() == targetId) {
                return products[i]; // Found the product
            }
        }
        return null; // Product not found
    }

    /**
     * BINARY SEARCH
     * 
     * Efficiently searches a SORTED array by repeatedly dividing the 
     * search interval in half. Compares the target with the middle element;
     * if not equal, eliminates the half where the target cannot lie.
     * 
     * Time Complexity: O(log n)
     * Space Complexity: O(1)
     * 
     * PREREQUISITE: The products array must be sorted by productId.
     * 
     * @param products sorted array of Product objects to search through
     * @param targetId the productId to search for
     * @return the Product if found, null otherwise
     */
    public static Product binarySearch(Product[] products, int targetId) {
        int low = 0;
        int high = products.length - 1;

        while (low <= high) {
            int mid = low + (high - low) / 2; // Avoids integer overflow
            int midId = products[mid].getProductId();

            if (midId == targetId) {
                return products[mid]; // Found the product
            } else if (midId < targetId) {
                low = mid + 1; // Target is in the right half
            } else {
                high = mid - 1; // Target is in the left half
            }
        }
        return null; // Product not found
    }
}
