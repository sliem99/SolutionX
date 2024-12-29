//
//  Icons.swift
//  SolutionX
//
//  Created by Mohamed Sliem on 26/12/2024.
//

import UIKit

enum Icon: String {
    case image1 = "image1"
    case image2 = "image2"
    case image3 = "image3"
}

extension Icon {
    var imageOrignal: UIImage? {
        return UIImage(named: self.rawValue)
    }
    
    var imageTemplate: UIImage? {
        return UIImage(named: self.rawValue)?
            .withRenderingMode(.alwaysTemplate)
    }
}
