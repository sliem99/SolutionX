//
//  GetCategoryProductsUCProtocol.swift
//  SolutionX
//
//  Created by Mohamed Sliem on 05/02/2025.
//

import Foundation

protocol GetCategoryProductsUCProtocol {
    func execute(completion: @escaping([Product], SolutionXException) -> Void)
}
