//
//  EndpointProtocol.swift
//  SolutionX
//
//  Created by Mohamed Sliem on 04/02/2025.
//

import Foundation

protocol EndpointProtocol {
    
    var base: String { get }
    
    var path: String { get set }
    
    var headers: [String: String]? { get }
        
    var parameters: [String: String]? { get set }
    
    var body: Any? { get set }
        
}

extension EndpointProtocol {
    
    var timeoutInterval: Double {
        return 100
    }
    
}
