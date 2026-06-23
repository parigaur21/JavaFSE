package com.factory;

/**
 * Concrete factory class for creating PDF documents.
 * 
 * This is a Concrete Creator in the Factory Method Pattern.
 */
public class PdfDocumentFactory extends DocumentFactory {

    @Override
    public Document createDocument() {
        return new PdfDocument();
    }
}
