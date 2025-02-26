//
//  CategoryVM.swift
//  SolutionX
//
//  Created by Mohamed Sliem on 26/02/2025.
//

import Foundation
import Combine
import Factory

class CategoryVM: CategoryVMProtocol {
    
    @Injected(\.getCategoryListUC) private var usecase: GetCategoryListUCProtocol
    
    private var router: CategoryListRouterProtocol
    
    var dataSourceInjection: (() -> Void)?
    
    var shouldReload: Published<Bool>.Publisher {
        return $reloadData
    }
    
    @Published private var reloadData: Bool = false
    
    var errorPublisher: PassthroughSubject<String, Never>?

    private var categories: [String] = []
    
    init(router: CategoryListRouterProtocol) {
        self.router = router
    }
    
    
    func viewWillAppear() {
        dataSourceInjection?()
        usecase.execute { [weak self] result in
            switch result {
                case .success(let success):
                    self?.onSuccess(success)
                    
                case .failure(let failure):
                    self?.onFailure(failure)
            }
        }
    }
    
    private func onSuccess(_ list: [String]) {
        self.categories = list
        guard categories.count > 0 else { return }
        self.reloadData = true
    }
    
    private func onFailure(_ failure: SolutionXException) {
        guard let message = failure.errorDescription else { return }
        errorPublisher?.send(message)
    }
    
}

extension CategoryVM: CategoryDataSourceDelegation {
    
    var numOfItems: Int {
        return categories.count
    }
    
    var numOfSections: Int {
        return 1
    }
    
    func model(for index: Int) -> String {
        return categories[index]
    }
    
    func didSelect(index: Int) {
        guard index < categories.count else { return }
        router.navigate(to: categories[index])
    }
}
