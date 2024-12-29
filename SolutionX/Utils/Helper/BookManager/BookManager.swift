//
//  BookManager.swift
//  SolutionX
//
//  Created by Mohamed Sliem on 29/12/2024.
//

import Foundation

class BookManager {
    private var books: [Book] = []
    
    init() {
        loadDummyData()
    }
    
    func addBook(_ book: Book) {
        books.append(book)
    }
    
    func getAllBooks() -> [Book] {
        return books
    }
    
    func setFavorite(for id: UUID) {
        guard let index = books.firstIndex(where: { $0.id == id }) else { return }
        books[index].isFavorite = true
    }
    
    func getAvailableBooks() -> [Book] {
        return books.filter { $0.isFavorite }
    }
    
    func getFavoriteBooks() -> [Book] {
          return books.filter { $0.isFavorite }
    }
    
    func deleteBook(with id: UUID) {
        guard let index = books.firstIndex(where: { $0.id == id }) else { return }
        books.remove(at: index)
    }
    
    func returnBook(withId id: UUID) -> Bool {
        if let index = books.firstIndex(where: { $0.id == id && !$0.isFavorite }) {
            books[index].isFavorite = true
            return true
        }
        return false
    }
    
    private func loadDummyData() {
        books = [
            Book(id: UUID(), title: "The Catcher in the Rye", author: Author(id: UUID(), name: "J.D. Salinger"), yearPublished: 1951, isFavorite: false),
            Book(id: UUID(), title: "To Kill a Mockingbird", author: Author(id: UUID(), name: "Harper Lee"), yearPublished: 1960, isFavorite: false),
            Book(id: UUID(), title: "1984", author: Author(id: UUID(), name: "George Orwell"), yearPublished: 1949, isFavorite: false),
            Book(id: UUID(), title: "Pride and Prejudice", author: Author(id: UUID(), name: "Jane Austen"), yearPublished: 1813, isFavorite: false),
            Book(id: UUID(), title: "The Great Gatsby", author: Author(id: UUID(), name: "F. Scott Fitzgerald"), yearPublished: 1925, isFavorite: false),
            Book(id: UUID(), title: "Moby-Dick", author: Author(id: UUID(), name: "Herman Melville"), yearPublished: 1851, isFavorite: false),
            Book(id: UUID(), title: "The Hobbit", author: Author(id: UUID(), name: "J.R.R. Tolkien"), yearPublished: 1937, isFavorite: false),
            Book(id: UUID(), title: "War and Peace", author: Author(id: UUID(), name: "Leo Tolstoy"), yearPublished: 1869, isFavorite: false),
            Book(id: UUID(), title: "The Odyssey", author: Author(id: UUID(), name: "Homer"), yearPublished: -700, isFavorite: false),
            Book(id: UUID(), title: "Ulysses", author: Author(id: UUID(), name: "James Joyce"), yearPublished: 1922, isFavorite: false),
            Book(id: UUID(), title: "Brave New World", author: Author(id: UUID(), name: "Aldous Huxley"), yearPublished: 1932, isFavorite: false),
            Book(id: UUID(), title: "The Divine Comedy", author: Author(id: UUID(), name: "Dante Alighieri"), yearPublished: 1320, isFavorite: false),
            Book(id: UUID(), title: "Crime and Punishment", author: Author(id: UUID(), name: "Fyodor Dostoevsky"), yearPublished: 1866, isFavorite: false),
            Book(id: UUID(), title: "The Brothers Karamazov", author: Author(id: UUID(), name: "Fyodor Dostoevsky"), yearPublished: 1880, isFavorite: false),
            Book(id: UUID(), title: "One Hundred Years of Solitude", author: Author(id: UUID(), name: "Gabriel García Márquez"), yearPublished: 1967, isFavorite: false),
            Book(id: UUID(), title: "Don Quixote", author: Author(id: UUID(), name: "Miguel de Cervantes"), yearPublished: 1605, isFavorite: false),
            Book(id: UUID(), title: "Jane Eyre", author: Author(id: UUID(), name: "Charlotte Brontë"), yearPublished: 1847, isFavorite: false),
            Book(id: UUID(), title: "Wuthering Heights", author: Author(id: UUID(), name: "Emily Brontë"), yearPublished: 1847, isFavorite: false),
            Book(id: UUID(), title: "The Iliad", author: Author(id: UUID(), name: "Homer"), yearPublished: -760, isFavorite: false),
            Book(id: UUID(), title: "Anna Karenina", author: Author(id: UUID(), name: "Leo Tolstoy"), yearPublished: 1877, isFavorite: false),
            Book(id: UUID(), title: "The Adventures of Huckleberry Finn", author: Author(id: UUID(), name: "Mark Twain"), yearPublished: 1884, isFavorite: false),
            Book(id: UUID(), title: "The Grapes of Wrath", author: Author(id: UUID(), name: "John Steinbeck"), yearPublished: 1939, isFavorite: false),
            Book(id: UUID(), title: "Frankenstein", author: Author(id: UUID(), name: "Mary Shelley"), yearPublished: 1818, isFavorite: false),
            Book(id: UUID(), title: "Dracula", author: Author(id: UUID(), name: "Bram Stoker"), yearPublished: 1897, isFavorite: false)
        ]
    }
}
