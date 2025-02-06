//
//  CategoryProductRemoteDataSource.swift
//  SolutionX
//
//  Created by Mohamed Sliem on 05/02/2025.
//

import Foundation
import Factory

class CategoryProductRemoteDataSource: CategoryProductsRemoteDSProtocol {
 
    @Injected(\.networkProvider) var networkProvider: NetworkProviderProtocol
    
    private var categoryListTask: Task<Void, Never>?
    private var categoryProductsTask: Task<Void, Never>?

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
    
    func getCategoryProducts(
        for request: GetCategoryProductsRequest,
        completion: @escaping (Result<[ProductDto], SolutionXException>) -> Void
    ) {
        categoryProductsTask = Task {
            do {
                let products = try await networkProvider.performGet(
                    endpoint: request,
                    ProductResponse.self
                )
        
                if Task.isCancelled {
                    
                    return
                }
                
                completion(.success(products.products))
            } catch let error as SolutionXException {
                completion(.failure(error))
            } catch {
                completion(.failure(.networkError(.unknownStatusCodeError)))
            }
            
        }
    }
    
    
    func cancelOngoingRequests() {
        categoryListTask?.cancel()
        categoryProductsTask?.cancel()
    }
    
}
