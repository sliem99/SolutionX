//
//  TitleIconCell.swift
//  SolutionX
//
//  Created by Mohamed Sliem on 26/12/2024.
//

import UIKit

class TitleIconCell: UITableViewCell, ConfigurableThemeCellProtocol {
    typealias Model = TitleIconCellModel
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(model: Model) {
        
    }
    
}
