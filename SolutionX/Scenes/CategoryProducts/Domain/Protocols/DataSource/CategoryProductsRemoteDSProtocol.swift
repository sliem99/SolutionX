//
//  CategoryProductsRemoteDSProtocol.swift
//  SolutionX
//
//  Created by Mohamed Sliem on 05/02/2025.
//

import Foundation

protocol CategoryProductsRemoteDSProtocol {
    
    func getCategoryList(completion: @escaping(Result<[String], SolutionXException>) -> Void)
    
    func getCategoryProducts(
        for request: GetCategoryProductsRequest,
        completion: @escaping(Result<[ProductDto], SolutionXException>) -> Void
    )
    
    func cancelOngoingRequests()
}
