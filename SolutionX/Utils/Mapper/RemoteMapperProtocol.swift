//
//  RemoteMapperProtocol.swift
//  SolutionX
//
//  Created by Mohamed Sliem on 05/02/2025.
//

import Foundation

protocol RemoteMapperProtocol {
    associatedtype DTO: Codable
    associatedtype Entity
    
    func map(from modelDto: DTO) -> Entity
    
    func map(from entity: Entity) -> DTO

}
