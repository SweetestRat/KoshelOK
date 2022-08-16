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
        currency = Currency(symbol: "THAI", fullName: "Thailand currency")
        operationType = .income
        
        let timestamp = Date().timeIntervalSince1970
        let myTimeInterval = TimeInterval(timestamp)
        date = Date(timeIntervalSince1970: TimeInterval(myTimeInterval))
    }
    
    func viewLoaded() {
        view?.updateCurrency(currency: currency)
        view?.updateDate(date: date)
        view?.updateOperationType(operationType: operationType)
    }
    
    func selectCategory() {
        
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
    
    func selectType() {
        
    }
    
    func createOperation() {
        
    }
    
}

extension CreateOperationPresenter: CurrencySelectionDelegateProtocol {
    func updateSelectedCurrency(currency: Currency) {
        self.currency = currency
        view?.updateCurrency(currency: currency)
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
