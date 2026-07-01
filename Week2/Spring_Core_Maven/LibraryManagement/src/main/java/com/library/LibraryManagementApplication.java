package com.library;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import com.library.service.BookService;

public class LibraryManagementApplication {
    public static void main(String[] args) {
        // Exercise 1: Load the Spring IoC Container
        // Exercise 5: Configuring the Spring IoC Container
        ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");

        System.out.println("=== Exercise 1: Basic Spring Application ===");
        System.out.println("Spring IoC Container loaded successfully!\n");

        // Exercise 7: Demonstrating Constructor Injection
        System.out.println("=== Exercise 7: Constructor Injection ===");
        BookService bookServiceConstructor = (BookService) context.getBean("bookServiceConstructor");
        bookServiceConstructor.performService();
        System.out.println();

        // Exercise 7: Demonstrating Setter Injection
        System.out.println("=== Exercise 7: Setter Injection ===");
        BookService bookServiceSetter = (BookService) context.getBean("bookServiceSetter");
        bookServiceSetter.performService();
        System.out.println();

        // Exercise 2: Verify Dependency Injection is working
        System.out.println("=== Exercise 2: Dependency Injection Verification ===");
        System.out.println("Constructor Injected BookRepository: " + bookServiceConstructor.getBookRepository());
        System.out.println("Setter Injected BookRepository: " + bookServiceSetter.getBookRepository());
        System.out.println("Both beans share the same BookRepository singleton: " +
                (bookServiceConstructor.getBookRepository() == bookServiceSetter.getBookRepository()));
    }
}
