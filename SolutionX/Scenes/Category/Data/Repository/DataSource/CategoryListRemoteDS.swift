//
//  CategoryListRemoteDS.swift
//  SolutionX
//
//  Created by Mohamed Sliem on 26/02/2025.
//

import Foundation
import Factory

class CategoryListRemoteDS: CategoryListRemoteDSProtocol {
    
    @Injected(\.networkProvider) private var networkProvider: NetworkProviderProtocol
    
    private var categoryListTask: Task<Void, Never>?

    func getCategoryList(
        completion: @escaping (Result<[String], SolutionXException>) -> Void
    ) {
        categoryListTask = Task {
            do {
                let categoryRequest = GetCategoriesRequest()
                let categories = try await networkProvider.performGet(
                    endpoint: categoryRequest,
                    [String].self
                )
                
                if Task.isCancelled {
                    return
                }
                
                completion(.success(categories))
            } catch let error as SolutionXException {
                completion(.failure(error))
            } catch {
                completion(.failure(.networkError(.unknownStatusCodeError)))
            }
        }
    }
    
}
