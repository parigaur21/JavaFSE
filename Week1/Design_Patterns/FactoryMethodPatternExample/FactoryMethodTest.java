

public class FactoryMethodPatternTest {

    public static void main(String[] args) {

        System.out.println("=== Factory Method Pattern Test ===\n");

        
        System.out.println("--- Creating Word Document ---");
        DocumentFactory wordFactory = new WordDocumentFactory();
        Document wordDoc = wordFactory.getDocument();
        wordDoc.save();
        wordDoc.close();

        System.out.println();

        
        System.out.println("--- Creating PDF Document ---");
        DocumentFactory pdfFactory = new PdfDocumentFactory();
        Document pdfDoc = pdfFactory.getDocument();
        pdfDoc.save();
        pdfDoc.close();

        System.out.println();

        
        System.out.println("--- Creating Excel Document ---");
        DocumentFactory excelFactory = new ExcelDocumentFactory();
        Document excelDoc = excelFactory.getDocument();
        excelDoc.save();
        excelDoc.close();

        System.out.println("\n=== Factory Method Pattern Verified Successfully ===");
    }
}
