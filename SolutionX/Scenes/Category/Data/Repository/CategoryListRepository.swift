//
//  CategoryListRepository.swift
//  SolutionX
//
//  Created by Mohamed Sliem on 26/02/2025.
//

import Foundation
import Factory

class CategoryListRepository: CategoryListRepositoryProtocol {
    
    @Injected(\.getCategoryListRemoteDS) var remoteDS: CategoryListRemoteDSProtocol
    
    func getCategoryList(completion: @escaping (Result<[String], SolutionXException>) -> Void) {
        remoteDS.getCategoryList(completion: completion)
    }

}
