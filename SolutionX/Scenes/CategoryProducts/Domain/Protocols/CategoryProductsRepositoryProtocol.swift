//
//  CategoryProductsRepositoryProtocol.swift
//  SolutionX
//
//  Created by Mohamed Sliem on 05/02/2025.
//

import Foundation

protocol CategoryProductsRepositoryProtocol {
    
    func getCategoryList(completion: @escaping(Result<[String], SolutionXException>) -> Void)
    
    func getCategoryProducts(
        for category: GetCategoryProductsRequest,
        completion: @escaping(Result<[Product], SolutionXException>) -> Void
    )
    
}
