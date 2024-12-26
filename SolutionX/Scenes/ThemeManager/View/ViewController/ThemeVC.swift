//
//  ThemeVC.swift
//  SolutionX
//
//  Created by Mohamed Sliem on 26/12/2024.
//

import UIKit

class ThemeVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    
    let models: [ConfigurableThemeCellModelProtocol] = [ // this is dummy data just for establishing the concept
        TitledCellModel(
            title: "TitleCell"
        ),
        TitleIconCellModel(
            title: "IconCell",
            icon: "image1"
        )
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

extension ThemeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension ThemeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let model = models[indexPath.row]
        
        switch model {
        case let model as TitledCellModel:
            let cell = configureCell(
                tableView,
                indexPath: indexPath,
                model: model,
                cellType: TitledCell.self
            )
            return cell

        case let model as TitleIconCellModel:
            let cell = configureCell(
                tableView,
                indexPath: indexPath,
                model: model,
                cellType: TitleIconCell.self
            )
            return cell

        default:
            return UITableViewCell()
        }
    }
    
    private func configureCell<T: UITableViewCell & ConfigurableThemeCellProtocol>(
        _ tableView: UITableView,
        indexPath: IndexPath,
        model: T.Model,
        cellType: T.Type
    ) -> T {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: T.self),
            for: indexPath
        ) as! T
    
        cell.configure(model: model)
        return cell
    }
    
}


