//
//  CategoryDataSource.swift
//  SolutionX
//
//  Created by Mohamed Sliem on 26/02/2025.
//

import Foundation
import UIKit

class CategoryDataSource: NSObject {
    
    private weak var source: CategoryDataSourceDelegation?
    
    init(source: CategoryDataSourceDelegation?) {
        self.source = source
    }
    
}

extension CategoryDataSource: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        source?.didSelect(index: indexPath.row)
    }
    
}


extension CategoryDataSource: UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
       return source?.numOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return source?.numOfItems ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = source?.model(for: indexPath.row) else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableView.className, for: indexPath)
        cell.textLabel?.text = model // configure of the model
        return cell
    }
    
}
