//
//  ResponseHandler.swift
//  SolutionX
//
//  Created by Mohamed Sliem on 04/02/2025.
//

import Foundation
import Factory

struct ResponseHandler {
    
    private var errorWrapper = NetworkErrorWrapper()
    
    @Injected(\.decoder) private var decoder: JSONDecoder
    
    func canDecode(_ response: URLResponse) throws(SolutionXException) { // always returns true if the response is 200
        
        guard let response = response as? HTTPURLResponse else {
            throw .networkError(.invalidResponse)
        }
        
        if !(200 ... 299).contains(response.statusCode) {
            throw errorWrapper.convert(statusCode: response.statusCode)
        }
    }
    
    func decode<Model: Codable>(_ model: Model.Type, from data: Data) throws -> Model {
        let decodedData = try decoder.decode(model, from: data)
        return decodedData
    }
}
