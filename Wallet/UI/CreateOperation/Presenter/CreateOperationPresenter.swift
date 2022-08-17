//
//  CreateOperationPresenter.swift
//  Wallet
//
//  Created by Danila on 13.08.2022.
//

import Foundation

class CreateOperationPresenter: CreateOperationPresenterProtocol {
    private var currency: CurrencyViewModel
    private var date: Date
    private var category: Category
    
    private let service: CreateOperationServiceProtocol
    private let router: CreateOperationRouterProtocol
    weak var view: CreateOperationViewProtocol?
    
    init(
        service: CreateOperationServiceProtocol,
        router: CreateOperationRouterProtocol
    ) {
        self.service = service
        self.router = router
        
        // set default user currency (probable get from user account request)
        currency = CurrencyViewModel(symbol: "THAI", fullName: "Thailand currency")
        
        let timestamp = Date().timeIntervalSince1970
        let myTimeInterval = TimeInterval(timestamp)
        date = Date(timeIntervalSince1970: TimeInterval(myTimeInterval))
        category = Category(id: 0, name: "Кафе и рестораны", iconName: "fork.knife", iconColor: "#7765C0")
    }
    
    func viewLoaded() {
        view?.updateCurrency(currency: currency)
        view?.updateDate(date: date)
        view?.updateCategory(category: CategoryViewModel(name: category.name, iconName: category.iconName, iconColor: category.iconColor))
    }
    
    func selectCategory() {
        router.openCategorySelection(delegate: self, currentCategory: category)
    }
    
    func selectCurrency() {
        router.openCurrencySelection(delegate: self)
    }
    
    func selectDate() {
        router.openDateSelection(delegate: self, currentDate: date)
    }
    
    func dateDidChanged(date: Date) {
        self.date = date
    }
    
    func selectType() {
        
    }
    
    func createOperation() {
        
    }
    
}

extension CreateOperationPresenter: CurrencySelectionDelegateProtocol {
    func updateSelectedCurrency(currency: CurrencyViewModel) {
        self.currency = currency
        view?.updateCurrency(currency: currency)
    }
    
    func getSelectedRow() -> Int {
        return 0
    }
    
    func saveSelectedRow(row: Int) {
        
    }
}

extension CreateOperationPresenter: DatePickerDelegateProtocol {
    func dateSaved(date: Date) {
        self.date = date
        view?.updateDate(date: date)
    }
}

extension CreateOperationPresenter: CategorySelectionDelegateProtocol {
    func categorySaved(category: Category) {
        self.category = category
        view?.updateCategory(category: CategoryViewModel(name: category.name, iconName: category.iconName, iconColor: category.iconColor))
    }
}
