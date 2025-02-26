//
//  GetCategoryListUCProtocol.swift
//  SolutionX
//
//  Created by Mohamed Sliem on 26/02/2025.
//

import Foundation

protocol GetCategoryListUCProtocol {
    
    func execute(completion: @escaping (Result<[String], SolutionXException>) -> Void)
    
}
