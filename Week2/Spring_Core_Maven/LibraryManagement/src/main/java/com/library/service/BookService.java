package com.library.service;

import com.library.repository.BookRepository;

public class BookService {
    private BookRepository bookRepository;

    // Setter method for Dependency Injection (Exercise 2)
    public void setBookRepository(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
    }

    public void performService() {
        System.out.println("BookService is working...");
        if (bookRepository != null) {
            bookRepository.performAction();
        } else {
            System.out.println("BookRepository is null!");
        }
    }
}
