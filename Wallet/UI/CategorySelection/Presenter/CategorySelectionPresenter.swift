//
//  CategorySelectionPresenter.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 14.08.2022.
//

import Foundation

class CategorySelectionPresenter: CategorySelectionPresenterProtocol {
    
    private var service: CategoriesServiceProtocol
    weak var view: CategorySelectionViewProtocol?
    
    private var selectedIndexPathRow: Int = 0
    
    private var listOfCategories: [CategoryViewModel] = []
    
    init(service: CategoriesServiceProtocol) {
        self.service = service
    }
    
    func getSelectedRow() -> Int? {
        return selectedIndexPathRow
    }
    
    func setSelectedRow(row: Int) {
        selectedIndexPathRow = row
    }
    
    func controllerLoaded() {
        service.loadCategories { [weak self] result in
            switch result {
            case .success(let categories):
                let categoriesViewModels = categories.map { category -> CategoryViewModel in
                    CategoryViewModel(name: category.name, iconName: category.iconName, iconColor: category.iconColor)
                }
                self?.listOfCategories = categoriesViewModels
                DispatchQueue.main.async {
                    self?.view?.updateTableView()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func didTapBarButton() {}
    
    func getNumberOfRows() -> Int? {
        listOfCategories.count
    }
    
    func getCategory(index: Int) -> CategoryViewModel {
        listOfCategories[index]
    }
}
