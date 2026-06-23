package com.factory;

/**
 * Test class to demonstrate the Factory Method Pattern implementation.
 * 
 * This class verifies that:
 * 1. Different document types are created using their respective factories.
 * 2. Each factory produces the correct type of document.
 * 3. The Factory Method Pattern allows adding new document types without
 *    modifying existing code (Open/Closed Principle).
 */
public class FactoryMethodPatternTest {

    public static void main(String[] args) {

        System.out.println("=== Factory Method Pattern Test ===\n");

        // Step 1: Create a Word document using WordDocumentFactory
        System.out.println("--- Creating Word Document ---");
        DocumentFactory wordFactory = new WordDocumentFactory();
        Document wordDoc = wordFactory.getDocument();
        wordDoc.save();
        wordDoc.close();

        System.out.println();

        // Step 2: Create a PDF document using PdfDocumentFactory
        System.out.println("--- Creating PDF Document ---");
        DocumentFactory pdfFactory = new PdfDocumentFactory();
        Document pdfDoc = pdfFactory.getDocument();
        pdfDoc.save();
        pdfDoc.close();

        System.out.println();

        // Step 3: Create an Excel document using ExcelDocumentFactory
        System.out.println("--- Creating Excel Document ---");
        DocumentFactory excelFactory = new ExcelDocumentFactory();
        Document excelDoc = excelFactory.getDocument();
        excelDoc.save();
        excelDoc.close();

        System.out.println("\n=== Factory Method Pattern Verified Successfully ===");
    }
}
