//
//  GetCategoryProductsRequest.swift
//  SolutionX
//
//  Created by Mohamed Sliem on 05/02/2025.
//

import Foundation

struct GetCategoryProductsRequest: EndpointProtocol {
        
    var category: String
    
    var base: String {
        "https://dummyjson.com/products/"
    }
    
    var path: String = "category/"

    
    var headers: [String : String]?

    var parameters: [String : String]?
    
    var body: Any?
    
    init(category: String) {
        self.category = category
    }
    
    mutating func build() -> EndpointProtocol {
        path.append(category)
        return self
    }
}
