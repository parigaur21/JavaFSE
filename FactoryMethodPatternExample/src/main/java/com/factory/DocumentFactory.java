package com.factory;

/**
 * Abstract DocumentFactory class defining the Factory Method.
 * 
 * This is the Creator in the Factory Method Pattern.
 * Subclasses must implement the createDocument() method to produce
 * specific types of Document objects.
 */
public abstract class DocumentFactory {

    /**
     * Factory Method to create a Document.
     * Subclasses override this method to instantiate specific document types.
     * 
     * @return a new Document instance
     */
    public abstract Document createDocument();

    /**
     * Template method that uses the factory method to create a document
     * and perform common operations on it.
     * 
     * @return the created Document after opening it
     */
    public Document getDocument() {
        Document doc = createDocument();
        System.out.println("Created: " + doc.getDocumentType());
        doc.open();
        return doc;
    }
}
