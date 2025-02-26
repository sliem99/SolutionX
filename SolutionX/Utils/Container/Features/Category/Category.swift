//
//  CategoryProductsDI.swift
//  SolutionX
//
//  Created by Mohamed Sliem on 05/02/2025.
//

import Factory
import UIKit

extension Container {
    static func categoryListDI(for navigation: UINavigationController) -> CategoryListVC {
        let router = CategoryListRouter(navigationController: navigation)
        
        let viewModel = CategoryVM(router: router)
        
        let dataSourceHandler = CategoryDataSource(source: viewModel)
        
        let viewController = CategoryListVC(viewModel: viewModel)
        
        viewModel.dataSourceInjection = { [weak viewController] in
            viewController?.tableView.delegate = dataSourceHandler
            viewController?.tableView.dataSource = dataSourceHandler
        }
        
        return viewController
    }
}

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
    
    var getCategoryListRemoteDS: Factory<CategoryListRemoteDSProtocol> {
        Factory(self) {
            return CategoryListRemoteDS()
        }
    }
    
    var getCategoryListRepository: Factory<CategoryListRepositoryProtocol> {
        Factory(self) {
            return CategoryListRepository()
        }
    }
    
    var getCategoryListUC: Factory<GetCategoryListUCProtocol> {
        Factory(self) {
            return GetCategoryListUC()
        }
    }
}
