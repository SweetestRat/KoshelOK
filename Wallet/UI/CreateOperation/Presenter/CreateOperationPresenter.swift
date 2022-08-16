//
//  CreateOperationPresenter.swift
//  Wallet
//
//  Created by Danila on 13.08.2022.
//

class CreateOperationPresenter: CreateOperationPresenterProtocol {
    private var currency: CurrencyViewModel
    
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
    }
    
    func viewLoaded() {
        view?.updateCurrency(currency: currency)
    }
    
    func selectCategory() {
        
    }
    
    func selectCurrency() {
        router.openCurrencySelection(delegate: self)
    }
    
    func selectDate() {
        
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
}
