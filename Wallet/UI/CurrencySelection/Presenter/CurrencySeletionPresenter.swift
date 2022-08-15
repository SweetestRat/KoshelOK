//
//  CurrencySeletionPresenter.swift
//  Wallet
//
//  Created by Владислава Гильде on 12.08.2022.
//

import Foundation

protocol CurrencySeletionDelegateProtocol: AnyObject {
    func updateSelectedCurrency(currency: Currency)
}

class CurrencySeletionPresenter: CurrencySeletionPresenterProtocol {
    weak var delegate: CurrencySeletionDelegateProtocol?
    private var model: CurrencySeletionModelProtocol?
    private var router: CurrencySeletionRouterProtocol?
    private weak var view: CurrencySeletionViewProtocol?
    
    var currenciesList: [Currency]?
    private var selectedIndexPathRow: Int = 0
    
    init(model: CurrencySeletionModelProtocol, router: CurrencySeletionRouterProtocol, view: CurrencySeletionViewProtocol) {
        self.model = model
        self.router = router
        self.view = view
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
        model?.getData()
        
        // wait for data and set it to view
        currenciesList = [Currency(symbol: "$", fullName: "USA Dollars"), Currency(symbol: "RUB", fullName: "Russian Rubles")]
        view?.updateCurrenciesList(
            currencies: currenciesList
        )
    }
}
