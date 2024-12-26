//
//  ConfigurableThemeCell.swift
//  SolutionX
//
//  Created by Mohamed Sliem on 26/12/2024.
//

import Foundation

protocol ConfigurableThemeCellProtocol {
    associatedtype Model: ConfigurableThemeCellModelProtocol
    func configure(model: Model)
}

protocol ConfigurableThemeCellModelProtocol {
    var title: String { get set }
}
