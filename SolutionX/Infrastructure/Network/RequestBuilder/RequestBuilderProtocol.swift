//
//  RequestBuilderProtocol.swift
//  SolutionX
//
//  Created by Mohamed Sliem on 05/02/2025.
//

import Foundation

protocol RequestBuilderProtocol {
    func build(_ endpoint: EndpointProtocol, httpMethod: HTTPMethod) throws -> URLRequest
}

