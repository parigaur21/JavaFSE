
/**
 * Concrete implementation of Document for Word documents.
 * 
 * This is a Concrete Product in the Factory Method Pattern.
 */
public class WordDocument implements Document {

    @Override
    public void open() {
        System.out.println("Opening Word document...");
    }

    @Override
    public void save() {
        System.out.println("Saving Word document in .docx format...");
    }

    @Override
    public void close() {
        System.out.println("Closing Word document.");
    }

    @Override
    public String getDocumentType() {
        return "Word Document (.docx)";
    }
}
