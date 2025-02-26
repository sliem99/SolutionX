//
//  NetworkProviderProtocol.swift
//  SolutionX
//
//  Created by Mohamed Sliem on 04/02/2025.
//

import Foundation

protocol NetworkProviderProtocol {
    
    func performGet<Model: Codable>(endpoint: EndpointProtocol, _ modelDto: Model.Type) async throws -> Model
    
    func performDelete<Model: Codable>(endpoint: EndpointProtocol, _ modelDto: Model.Type) async throws -> Model

    func performPut<Model: Codable>(endpoint: EndpointProtocol, _ modelDto: Model.Type) async throws -> Model

    func performPost<Model: Codable>(endpoint: EndpointProtocol, _ modelDto: Model.Type) async throws -> Model

}
