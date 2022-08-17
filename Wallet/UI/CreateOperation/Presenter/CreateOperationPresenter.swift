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
        currency = Currency(id: 0, shortName: "RUB", longName: "Российский рубль")
        
        let timestamp = Date().timeIntervalSince1970
        let myTimeInterval = TimeInterval(timestamp)
        date = Date(timeIntervalSince1970: TimeInterval(myTimeInterval))
    }
    
    func viewLoaded() {
        view?.updateCurrency(currency: currency)
        view?.updateDate(date: date)
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
