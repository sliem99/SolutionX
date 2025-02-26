//
//  CategoryListRemoteDSProtocol.swift
//  SolutionX
//
//  Created by Mohamed Sliem on 26/02/2025.
//

import Foundation

protocol CategoryListRemoteDSProtocol {
    func getCategoryList(
        completion: @escaping (Result<[String], SolutionXException>) -> Void
    )
}
