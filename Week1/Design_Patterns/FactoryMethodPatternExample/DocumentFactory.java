

public abstract class DocumentFactory {

    
    public abstract Document createDocument();

    
    public Document getDocument() {
        Document doc = createDocument();
        System.out.println("Created: " + doc.getDocumentType());
        doc.open();
        return doc;
    }
}
