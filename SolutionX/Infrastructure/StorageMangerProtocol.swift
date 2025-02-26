//
//  StorageMangerProtocol.swift
//  SolutionX
//
//  Created by Mohamed Sliem on 12/02/2025.
//

import Foundation
import CoreData

protocol LocalEntity {}

extension NSManagedObject: LocalEntity {
    
}

protocol StorageMangerProtocol {
    associatedtype Entity: LocalEntity
    func create(configure: @escaping(Entity) -> Void, completion: @escaping(Result<Void, Error>) -> Void)
    func read()
    func update()
    func delete()
}

