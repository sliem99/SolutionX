//
//  CategoryListRouter.swift
//  SolutionX
//
//  Created by Mohamed Sliem on 26/02/2025.
//

import UIKit

class CategoryListRouter: CategoryListRouterProtocol {

    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func navigate(to category: String) {
        
    }
    
}
