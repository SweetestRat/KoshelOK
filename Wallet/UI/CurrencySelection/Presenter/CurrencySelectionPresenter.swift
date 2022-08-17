//
//  CurrencySelectionPresenter.swift
//  Wallet
//
//  Created by Владислава Гильде on 12.08.2022.
//

import Foundation

protocol CurrencySelectionDelegateProtocol: AnyObject {
    func updateSelectedCurrency(currency: CurrencyViewModel)
    func getSelectedRow() -> Int
    func saveSelectedRow(row: Int)
}

class CurrencySelectionPresenter: CurrencySelectionPresenterProtocol {
    weak var delegate: CurrencySelectionDelegateProtocol?
    private let service: CurrencySelectionServiceProtocol
    private let router: CurrencySelectionRouterProtocol
    weak var view: CurrencySelectionViewProtocol?
    
    var currenciesList: [CurrencyViewModel] = []
    private var selectedIndexPathRow: Int = 0
    
    init(service: CurrencySelectionServiceProtocol, router: CurrencySelectionRouterProtocol) {
        self.service = service
        self.router = router
    }
    
    func getSelectedRow() -> Int? {
        return delegate?.getSelectedRow()
    }
    
    func setSelectedRow(row: Int) {
        selectedIndexPathRow = row
        let currency = currenciesList[row]
        
        delegate?.saveSelectedRow(row: row)
        delegate?.updateSelectedCurrency(currency: currency)
    }
    
    func controllerLoaded() {
        service.loadCurrencies { [weak self] result in
            switch result {
            case .success(let currencies):
                let currenciesViewModels = currencies.map { currency -> CurrencyViewModel in
                    CurrencyViewModel(symbol: currency.shortName, fullName: currency.longName)
                }
                self?.currenciesList = currenciesViewModels
                DispatchQueue.main.async {
                    self?.view?.updateTableView()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getNumberOfRows() -> Int? {
        currenciesList.count
    }
    
    func getCurrency(index: Int) -> CurrencyViewModel {
        currenciesList[index]
    }
}
