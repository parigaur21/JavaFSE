package com.library.service;

import com.library.repository.BookRepository;

public class BookService {
    private BookRepository bookRepository;

    
    public BookService(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
        System.out.println("BookService: Constructor Injection used");
    }

    
    public BookService() {
    }

    
    public void setBookRepository(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
        System.out.println("BookService: Setter Injection used");
    }

    public BookRepository getBookRepository() {
        return bookRepository;
    }

    public void performService() {
        System.out.println("BookService is working...");
        if (bookRepository != null) {
            bookRepository.performAction();
        } else {
            System.out.println("BookRepository is null - no injection occurred!");
        }
    }
}
