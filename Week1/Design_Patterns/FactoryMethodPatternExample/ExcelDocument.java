
/**
 * Concrete implementation of Document for Excel documents.
 * 
 * This is a Concrete Product in the Factory Method Pattern.
 */
public class ExcelDocument implements Document {

    @Override
    public void open() {
        System.out.println("Opening Excel document...");
    }

    @Override
    public void save() {
        System.out.println("Saving Excel document in .xlsx format...");
    }

    @Override
    public void close() {
        System.out.println("Closing Excel document.");
    }

    @Override
    public String getDocumentType() {
        return "Excel Document (.xlsx)";
    }
}
