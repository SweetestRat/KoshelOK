//
//  CategorySelectionViewController.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 14.08.2022.
//

import UIKit

class CategorySelectionViewController: UIViewController, CategorySelectionViewProtocol {
    var presenter: CategorySelectionPresenterProtocol
    
    init(presenter: CategorySelectionPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var categorySelectionView: CategorySelectionView = {
        let view = CategorySelectionView()
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background

        getData()
        setupNavigationBar()
        addSubviews()
        setConstraints()
        
        categorySelectionView.addButtonTarget(self, action: #selector(actionButtonDidTap), for: .touchUpInside)
    }
    
    private func addSubviews() {
        view.addSubview(categorySelectionView)
    }
    
    private func setConstraints() {
        categorySelectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func getData() {
        presenter.controllerLoaded()
    }
    
    private func setupNavigationBar() {
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButton))
        add.tintColor = .black
        navigationItem.rightBarButtonItem = add
        navigationItem.title = "Выбор категории"
    }
    
    @objc private func addButton() {
    }
    
    @objc private func actionButtonDidTap() {
        presenter.actionButtonDidTap()
    }
    
    func updateTableView() {
        categorySelectionView.tableView.reloadData()
    }
}

extension CategorySelectionViewController: CategorySelectionViewDelegate {
    
    func getCategory(index: Int) -> CategoryViewModel {
        presenter.getCategory(index: index)
    }
    
    func getNumberOfRows() -> Int? {
        presenter.getNumberOfRows()
    }
    
    func cellSelected(indexPathRow: Int) {
        presenter.setSelectedRow(row: indexPathRow)
    }
    
    func getSelectedRow() -> Int? {
        return presenter.getSelectedRow()
    }
}
