//
//  GetCategoriesRequest.swift
//  SolutionX
//
//  Created by Mohamed Sliem on 05/02/2025.
//

import Foundation

struct GetCategoriesRequest: EndpointProtocol {
    
    var base: String {
        "https://dummyjson.com/"
    }
    
    var path: String = "products/category-list"
    
    var headers: [String : String]?

    var parameters: [String : String]?
    
    var body: Any?
    
}
