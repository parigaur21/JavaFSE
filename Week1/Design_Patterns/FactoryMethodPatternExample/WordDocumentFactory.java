
/**
 * Concrete factory class for creating Word documents.
 * 
 * This is a Concrete Creator in the Factory Method Pattern.
 */
public class WordDocumentFactory extends DocumentFactory {

    @Override
    public Document createDocument() {
        return new WordDocument();
    }
}
