//
//  Font.swift
//  SolutionX
//
//  Created by Mohamed Sliem on 26/12/2024.
//

import UIKit

// TWO ways to create Font system
protocol DynamicFont {
    func size(_ size: CGFloat) -> UIFont
}

extension DynamicFont where Self: RawRepresentable {
    func size(_ size: CGFloat) -> UIFont {
        return UIFont(
            name: self.rawValue as? String ?? "",
            size: size
        ) ?? .systemFont(ofSize: size)
    }
}

enum Font: String, DynamicFont {
    
    case medium = "Medium"
    
    case bold = "Bold"
}

extension Font {
    func fontSize(_ size: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: 16) ?? .boldSystemFont(ofSize: size)
    }
}
