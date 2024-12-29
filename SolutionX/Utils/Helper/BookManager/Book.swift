//
//  Book.swift
//  SolutionX
//
//  Created by Mohamed Sliem on 29/12/2024.
//

import Foundation

// Book Model
struct Book {
    let id: UUID
    let title: String
    let author: Author
    let yearPublished: Int
    var isFavorite: Bool
}
