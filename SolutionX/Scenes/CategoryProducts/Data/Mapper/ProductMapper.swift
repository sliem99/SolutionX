//
//  ProductDTO.swift
//  SolutionX
//
//  Created by Mohamed Sliem on 05/02/2025.
//

import Foundation


struct ProductMapper: RemoteMapperProtocol {
    
    func map(from modelDto: ProductDto) -> Product {
        return Product(
            id: modelDto.id ?? -1,
            title: modelDto.title ?? "",
            description: modelDto.description ?? "",
            category: modelDto.category ?? "",
            price: modelDto.price ?? 0.0,
            brand: modelDto.brand ?? ""
        )
    }
    
    func map(from entity: Product) -> ProductDto {
        return ProductDto(
            id: entity.id,
            title: entity.title,
            description: entity.description,
            category: entity.category,
            price: entity.price,
            discountPercentage: 0,
            rating: 0,
            stock: 0,
            tags: [],
            brand: entity.brand
        )
    }
}
