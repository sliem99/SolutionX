//
//  GetCategoryProductsUC.swift
//  SolutionX
//
//  Created by Mohamed Sliem on 05/02/2025.
//

import Foundation
import Factory

class GetCategoryProductsUC: GetCategoryProductsUCProtocol {
    
    @Injected(\.getCategoryProductsRepo) var repository: CategoryProductsRepositoryProtocol
    
    func execute(completion: @escaping ([Product], SolutionXException) -> Void) {

    }
}
