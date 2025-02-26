//
//  NetworkProvider.swift
//  SolutionX
//
//  Created by Mohamed Sliem on 04/02/2025.
//

import Foundation
import Factory

class NetworkProvider: NetworkProviderProtocol {
    
    @Injected(\.apiClient) private var client: APIClientProtocol
    @Injected(\.requestBuilder) private var requestBuilder: RequestBuilderProtocol
    
    func performGet<Model: Codable>(
        endpoint: any EndpointProtocol,
        _ modelDto: Model.Type
    ) async throws -> Model {
        let request = try requestBuilder.build(endpoint, httpMethod: .get)
        return try await client.performRequest(request, modelDto: modelDto)
    }
    
    func performDelete<Model: Codable>(
        endpoint: any EndpointProtocol,
        _ modelDto: Model.Type
    ) async throws -> Model {
        let request = try requestBuilder.build(endpoint, httpMethod: .delete)
        return try await client.performRequest(request, modelDto: modelDto)
    }
    
    func performPut<Model: Codable>(
        endpoint: any EndpointProtocol,
        _ modelDto: Model.Type
    ) async throws -> Model {
        let request = try requestBuilder.build(endpoint, httpMethod: .put)
        return try await client.performRequest(request, modelDto: modelDto)
    }
    
    func performPost<Model: Codable>(
        endpoint: any EndpointProtocol,
        _ modelDto: Model.Type
    ) async throws -> Model {
        let request = try requestBuilder.build(endpoint, httpMethod: .post)
        return try await client.performRequest(request, modelDto: modelDto)
    }
    
    
}
