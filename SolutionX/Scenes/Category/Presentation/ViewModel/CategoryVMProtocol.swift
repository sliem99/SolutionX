//
//  CategoryVMProtocol.swift
//  SolutionX
//
//  Created by Mohamed Sliem on 26/02/2025.
//

import Foundation
import Combine

protocol CategoryVMProtocol {
    
    var errorPublisher: PassthroughSubject<String, Never>? { get set }
    
    var shouldReload: Published<Bool>.Publisher { get }
    
    func viewWillAppear()
    
}
