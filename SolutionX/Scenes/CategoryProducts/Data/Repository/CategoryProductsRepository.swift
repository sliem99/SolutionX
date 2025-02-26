//
//  CategoryProductsRepository.swift
//  SolutionX
//
//  Created by Mohamed Sliem on 05/02/2025.
//

import Foundation
import Factory

class CategoryProductsRepository: CategoryProductsRepositoryProtocol {
    
    @Injected(\.getCategoryProductsDS) var remoteDS: CategoryProductsRemoteDSProtocol
    
    func getCategoryList(completion: @escaping (Result<[String], SolutionXException>) -> Void) {
        remoteDS.getCategoryList(completion: completion)
    }
    
    func getCategoryProducts(
        for category: GetCategoryProductsRequest,
        completion: @escaping (Result<[Product], SolutionXException>) -> Void
    ) {
        remoteDS.getCategoryProducts(for: category) { [weak self] result in
            switch result {
            case .success(let products):
                guard let products = self?.mapProducts(products: products) else {
                    return
                }
                completion(.success(products))
                
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    
    private func mapProducts(products: [ProductDto]) -> [Product] {
        let mapper = ProductMapper()
        return products.map {
             mapper.map(from: $0)
        }
    }
}

