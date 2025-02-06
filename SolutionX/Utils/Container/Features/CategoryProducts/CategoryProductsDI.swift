//
//  CategoryProductsDI.swift
//  SolutionX
//
//  Created by Mohamed Sliem on 05/02/2025.
//

import Factory
import Foundation

extension Container {
    
    var getCategoryProductsDS: Factory<CategoryProductsRemoteDSProtocol> {
        Factory(self) {
            return CategoryProductRemoteDataSource()
        }
    }
    
    var getCategoryProductsRepo: Factory<CategoryProductsRepositoryProtocol> {
        Factory(self) {
            return CategoryProductsRepository()
        }
    }
}
