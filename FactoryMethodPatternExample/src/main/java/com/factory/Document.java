package com.factory;

/**
 * Document interface defining the contract for all document types.
 * 
 * This is the Product interface in the Factory Method Pattern.
 * All concrete document types must implement this interface.
 */
public interface Document {

    /**
     * Opens the document.
     */
    void open();

    /**
     * Saves the document.
     */
    void save();

    /**
     * Closes the document.
     */
    void close();

    /**
     * Returns the type/format of the document.
     * 
     * @return the document type as a String
     */
    String getDocumentType();
}
