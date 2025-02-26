//
//  CategoryTableViewDelegation.swift
//  SolutionX
//
//  Created by Mohamed Sliem on 26/02/2025.
//

import Foundation
//source of data, handler of actions [did select, will display ..]
protocol CategoryDataSourceDelegation: AnyObject {
    
    var numOfItems: Int { get }
    
    var numOfSections: Int { get }
    
    func model(for index: Int) -> String
    
    func didSelect(index: Int)
}
