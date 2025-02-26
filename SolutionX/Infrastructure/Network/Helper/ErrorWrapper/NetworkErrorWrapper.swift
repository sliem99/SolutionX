//
//  NetworkErrorWrapper.swift
//  SolutionX
//
//  Created by Mohamed Sliem on 04/02/2025.
//

import Foundation

struct NetworkErrorWrapper {
    
    func convert(statusCode: Int) -> SolutionXException {
        switch statusCode {
        case 400:
            return .validationError(.invalidCredentials)
        case 403:
            return .networkError(.forbiddenAccess)
        case 500:
            return .networkError(.internalServerError)
        case 502:
            return .networkError(.badGateway)
        default:
            return .networkError(.unknownStatusCodeError)
        }
    }
}
