//
//  ProductResponse.swift
//  SolutionX
//
//  Created by Mohamed Sliem on 05/02/2025.
//


struct ProductDto: Codable {
    let id: Int?
    let title: String?
    let description: String?
    let category: String?
    let price: Double?
    let discountPercentage: Double?
    let rating: Double?
    let stock: Int?
    let tags: [String]?
    let brand: String?
}
