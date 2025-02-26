//
//  APIClientProtocol.swift
//  SolutionX
//
//  Created by Mohamed Sliem on 04/02/2025.
//

import Foundation

protocol APIClientProtocol {
    func performRequest<Model: Codable>(
        _ request: URLRequest,
        modelDto: Model.Type
    ) async throws -> Model
}

