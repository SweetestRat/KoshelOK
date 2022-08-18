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
    
    internal var category: Category
    
    private var service: CategoriesServiceProtocol
    weak var view: CategorySelectionViewProtocol?
    
    private var selectedIndexPathRow: Int = 0
    
    private var listOfCategories: [CategoryViewModel] = []
    
    init(service: CategoriesServiceProtocol, category: Category, router: CategorySelectionRouterProtocol) {
        self.service = service
        self.category = category
        self.router = router
    }
    
    func getSelectedRow() -> Int? {
        return selectedIndexPathRow
    }
    
    func setSelectedRow(row: Int) {
        selectedIndexPathRow = row
        
        let categorySelected = listOfCategories[row]
        categoryDidUpdate(category: categorySelected)
        
        let categories = service.getCategories()
        
        let category = categories.first(where: { category in
            category.name == categorySelected.name
        }) ?? Category(id: 0, name: category.name, iconName: category.iconName, iconColor: category.iconColor)
        
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
    
    func addNewCategory() {
        router.openSetupCategoryScreen()
    }
    
    func actionButtonDidTap() {
        delegate?.categorySaved(category: category)
        router.closeCAtegorySelectionScreen()
    }
    
    func categoryDidUpdate(category: CategoryViewModel) {
        let categoriesVM = service.getCategories()
        
        self.category = categoriesVM.first(where: { categoryVM in
            categoryVM.name == category.name
        }) ?? Category(id: 0, name: category.name, iconName: category.iconName, iconColor: category.iconColor)
    }
    
    func cancelDidClick() {
        router.closeCAtegorySelectionScreen()
    }
    
    func getNumberOfRows() -> Int? {
        listOfCategories.count
    }
    
    func getCategory(index: Int) -> CategoryViewModel {
        listOfCategories[index]
    }
}
