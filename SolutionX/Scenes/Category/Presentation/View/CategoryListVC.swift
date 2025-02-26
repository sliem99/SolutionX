//
//  CategoryListVC.swift
//  SolutionX
//
//  Created by Mohamed Sliem on 26/02/2025.
//

import UIKit

class CategoryListVC: BaseViewController {
    
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: CategoryVMProtocol
    
    init(viewModel: CategoryVMProtocol) {
        self.viewModel = viewModel
        super.init(nibName: "CategoryListVC", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isMovingFromParent {
            viewModel.viewWillAppear()
        }
    }
    
    private func setupView() {
        setTitle()
        registerCells()
    }
    
    private func setTitle() {
        mainTitle.text = "Category"
    }
    
    private func registerCells() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func bindViewModel() {
        viewModel
            .errorPublisher?
            .sink {[weak self] error in
                self?.showError(error)
            }
            .store(in: &cancellables)
        
        
        viewModel.shouldReload.sink { [weak self] _ in
            self?.tableView.reloadData()
        }
        .store(in: &cancellables)
    }
}
