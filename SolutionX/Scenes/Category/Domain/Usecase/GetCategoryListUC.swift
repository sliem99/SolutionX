//
//  GetCategoryListUC.swift
//  SolutionX
//
//  Created by Mohamed Sliem on 26/02/2025.
//

import Factory
import Foundation

class GetCategoryListUC: GetCategoryListUCProtocol {
    
    @Injected(\.getCategoryListRepository) private var repository: CategoryListRepositoryProtocol
    
    func execute(completion: @escaping (Result<[String], SolutionXException>) -> Void) {
        
        repository.getCategoryList { result in
            switch result {
                case .success(let list):
                    completion(.success(list))
                    
                case .failure(let failure):
                    completion(.failure(failure))
            }
        }
    }
    
}
