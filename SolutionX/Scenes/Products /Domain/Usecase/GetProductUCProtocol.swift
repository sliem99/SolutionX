//
//  GetProductUCProtocol.swift
//  SolutionX
//
//  Created by Mohamed Sliem on 26/02/2025.
//

import Foundation

protocol GetProductUCProtocol {
    func execute(completion: @escaping(Result<[Product], SolutionXException>) -> Void)
}
