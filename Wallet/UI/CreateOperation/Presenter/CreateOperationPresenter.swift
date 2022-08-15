//
//  CreateOperationPresenter.swift
//  Wallet
//
//  Created by Danila on 13.08.2022.
//

class CreateOperationPresenter: CreateOperationPresenterProtocol {
    private var currency: Currency
    
    private var model: CreateOperationModelProtocol?
    private var router: CreateOperationRouterProtocol?
    private weak var view: CreateOperationViewProtocol?
    
    init(
        model: CreateOperationModelProtocol,
        router: CreateOperationRouterProtocol,
        view: CreateOperationViewController
    ) {
        self.model = model
        self.router = router
        self.view = view
        
        // set default user currency (probable get from user account request)
        currency = Currency(symbol: "THAI", fullName: "Thailand currency")
    }
    
    func viewLoaded() {
        view?.updateCurrency(currency: currency)
    }
    
    func selectCategory() {
        
    }
    
    func selectCurrency() {
        router?.openCurrencySelection()
    }
    
    func selectDate() {
        
    }
    
    func selectType() {
        
    }
    
    func createOperation() {
        
    }
    
}

extension CreateOperationPresenter: CurrencySeletionDelegateProtocol {
    func updateSelectedCurrency(currency: Currency) {
        self.currency = currency
        view?.updateCurrency(currency: currency)
    }
}
