//
//  CurrencySelectionPresenter.swift
//  Wallet
//
//  Created by Владислава Гильде on 12.08.2022.
//

import Foundation

protocol CurrencySelectionDelegateProtocol: AnyObject {
    func updateSelectedCurrency(currency: Currency)
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
    
    private let currencyViewModelFactory: CurrencyViewModelFactory
    
    init(service: CurrencySelectionServiceProtocol, router: CurrencySelectionRouterProtocol) {
        self.service = service
        self.router = router
        self.currencyViewModelFactory = CurrencyViewModelFactory()
    }
    
    func getSelectedRow() -> Int? {
        return delegate?.getSelectedRow()
    }
    
    func setSelectedRow(row: Int) {
        selectedIndexPathRow = row
        let currencyViewModel = currenciesList[row]
        
        delegate?.saveSelectedRow(row: row)
        guard let currencyModels = service.getCurrencies() else { return }
        
        guard let currencyModel = currencyModels.first(where: { currency in
            currency.longName == currencyViewModel.fullName
        }) else { return }
        
        delegate?.updateSelectedCurrency(currency: currencyModel)
    }
    
    func controllerLoaded() {
        service.loadCurrencies { [weak self] result in
            switch result {
            case .success(let currencies):
                self?.currenciesList = self?.mapCurrencies(currencies: currencies)
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
    
    private func mapCurrencies(currencies: [Currency]) -> [CurrencyViewModel] {
        currencies.map { currency in
            currencyViewModelFactory.produce(from: currency)
        }
    }
}
