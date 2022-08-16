//
//  CurrencySelectionPresenter.swift
//  Wallet
//
//  Created by Владислава Гильде on 12.08.2022.
//

import Foundation

protocol CurrencySelectionDelegateProtocol: AnyObject {
    func updateSelectedCurrency(currency: Currency)
}

class CurrencySelectionPresenter: CurrencySelectionPresenterProtocol {
    weak var delegate: CurrencySelectionDelegateProtocol?
    private let service: CurrencySelectionServiceProtocol?
    private let router: CurrencySelectionRouterProtocol?
    weak var view: CurrencySelectionViewProtocol?
    
    var currenciesList: [Currency]?
    private var selectedIndexPathRow: Int = 0
    
    init(service: CurrencySelectionServiceProtocol, router: CurrencySelectionRouterProtocol) {
        self.service = service
        self.router = router
    }
    
    func getSelectedRow() -> Int? {
        return selectedIndexPathRow
    }
    
    func setSelectedRow(row: Int) {
        selectedIndexPathRow = row
        guard let currency = currenciesList?[row] else { return }
        
        delegate?.updateSelectedCurrency(currency: currency)
    }
    
    func controllerLoaded() {
        service?.getData()
        
        // wait for data and set it to view
        currenciesList = [Currency(symbol: "$", fullName: "USA Dollars"), Currency(symbol: "RUB", fullName: "Russian Rubles")]
        view?.updateCurrenciesList(
            currencies: currenciesList
        )
    }
}
