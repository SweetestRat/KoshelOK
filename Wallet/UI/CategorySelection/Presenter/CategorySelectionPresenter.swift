//
//  CategorySelectionPresenter.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 14.08.2022.
//

import Foundation

class CategorySelectionPresenter: CategorySelectionPresenterProtocol {
    
    private let router: CategorySelectionRouterProtocol
    weak var delegate: CategorySelectionDelegateProtocol?
    
    internal var category: CategoryViewModel
    
    private var service: CategoriesServiceProtocol
    weak var view: CategorySelectionViewProtocol?
    
    private var selectedIndexPathRow: Int = 0
    
    private var listOfCategories: [CategoryViewModel] = []
    
    init(service: CategoriesServiceProtocol, category: CategoryViewModel, router: CategorySelectionRouterProtocol) {
        self.service = service
        self.category = category
        self.router = router
    }
    
    func getSelectedRow() -> Int? {
        return selectedIndexPathRow
    }
    
    func setSelectedRow(row: Int) {
        selectedIndexPathRow = row
        
        let category = listOfCategories[row]
        categoryDidUpdate(category: category)
        delegate?.categorySaved(category: category)
    }
    
    func controllerLoaded() {
        service.loadCategories { [weak self] result in
            switch result {
            case .success(let categories):
                let categoriesViewModels = categories.map { category -> CategoryViewModel in
                    CategoryViewModel(name: category.name, iconName: category.iconName, iconColor: category.iconColor)
                }
                self?.listOfCategories = categoriesViewModels
                self?.selectedIndexPathRow = self?.listOfCategories.firstIndex(where: { category in
                    category.name == self?.category.name
                }) ?? 0
                DispatchQueue.main.async {
                    self?.view?.updateTableView()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func didTapBarButton() {
    }
    
    func actionButtonDidTap() {
        delegate?.categorySaved(category: category)
        router.back()
    }
    
    func categoryDidUpdate(category: CategoryViewModel) {
        self.category = category
    }
    
    func cancelDidClick() {
        router.back()
    }
    
    func getNumberOfRows() -> Int? {
        listOfCategories.count
    }
    
    func getCategory(index: Int) -> CategoryViewModel {
        listOfCategories[index]
    }
}
