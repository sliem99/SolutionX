//
//  Network.swift
//  SolutionX
//
//  Created by Mohamed Sliem on 04/02/2025.
//

import Factory
import Foundation

extension Container {
    
    var responseHandler: Factory<ResponseHandler> {
        Factory(self) {
            ResponseHandler()
        }
    }
    
    var decoder: Factory<JSONDecoder> {
        Factory(self) {
            JSONDecoder()
        }
    }
    
    var networkProvider: Factory<NetworkProviderProtocol> {
        Factory(self) {
            NetworkProvider()
        }
        .singleton
    }
    
    var apiClient: Factory<APIClientProtocol> {
        Factory(self) {
            APIClient()
        }
    }
    
    var requestBuilder: Factory<RequestBuilderProtocol> {
        Factory(self) {
            RequestBuilder()
        }
    }
}
