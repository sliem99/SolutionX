//
//  APIClient.swift
//  SolutionX
//
//  Created by Mohamed Sliem on 04/02/2025.
//

import Foundation
import Factory

class APIClient: APIClientProtocol {
    
    @Injected(\.responseHandler) private var handler: ResponseHandler
    
    func performRequest<Model: Codable>(
        _ request: URLRequest,
        modelDto: Model.Type
    ) async throws -> Model {
        let (data, response) = try await URLSession.shared.data(for: request) 
        try handler.canDecode(response) // check if there an error
        return try handler.decode(modelDto, from: data)
    }
    
}
