//
//  CreateOperationPresenter.swift
//  Wallet
//
//  Created by Danila on 13.08.2022.
//

import Foundation

class CreateOperationPresenter: CreateOperationPresenterProtocol {
    private var currency: Currency
    private var date: Date
    private var operationType: OperationType
    private var category: Category
    private var amount: Int
    private let walletId: Int
    
    private let service: CreateOperationServiceProtocol
    private let router: CreateOperationRouterProtocol
    weak var view: CreateOperationViewProtocol?
    
    init(
        service: CreateOperationServiceProtocol,
        router: CreateOperationRouterProtocol,
        walletId: Int
    ) {
        self.service = service
        self.router = router
        self.walletId = walletId
        
        // set default user currency (probably get from user account request)
        operationType = .income
        currency = Currency(id: 1, shortName: "RUB", longName: "Российский рубль")
        amount = 0
        
        let timestamp = Date().timeIntervalSince1970
        let myTimeInterval = TimeInterval(timestamp)
        date = Date(timeIntervalSince1970: TimeInterval(myTimeInterval))
        category = Category(id: 1, name: "Кафе и рестораны", iconName: "fork.knife", iconColor: "#7765C0")
    }
    
    func viewLoaded() {
        view?.updateCurrency(currency: currency)
        view?.updateDate(date: date)
        view?.updateOperationType(operationType: operationType)
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
    
    func incomeDidSelected() {
        operationType = .income
        view?.updateOperationType(operationType: operationType)
    }
    
    func expanseDidSelected() {
        operationType = .expanse
        view?.updateOperationType(operationType: operationType)
    }
    
    func amountDidChange(amount: String) {
        self.amount = Int(amount) ?? self.amount
    }
    
    func createDidTap() {
        view?.updateActionButtonState(state: .loading)
        let createOperationModel = CreateOperationModel(
            balanceDto: Balance(currency: currency, amount: String(amount)),
            date: Int(date.timeIntervalSince1970),
            categoryDto: category,
            income: operationType == .income
        )
        
        print(createOperationModel)
        
        service.createOperation(data: createOperationModel, walletId: walletId) {  [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.view?.updateActionButtonState(state: .inactive)
                    self?.router.closeCreateOperationScreen()
                }
            case .failure:
                DispatchQueue.main.async {
                    self?.view?.updateActionButtonState(state: .active)
                }
                // TODO show popup
                return
            }
        }
    }
}

extension CreateOperationPresenter: CurrencySelectionDelegateProtocol {
    func updateSelectedCurrency(currency: Currency) {
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

enum OperationType {
    case income
    case expanse
}

extension CreateOperationPresenter: CategorySelectionDelegateProtocol {
    func categorySaved(category: Category) {
        self.category = category
        view?.updateCategory(category: CategoryViewModel(name: category.name, iconName: category.iconName, iconColor: category.iconColor))
    }
}
