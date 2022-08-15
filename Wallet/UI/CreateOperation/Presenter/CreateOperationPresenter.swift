//
//  CreateOperationPresenter.swift
//  Wallet
//
//  Created by Danila on 13.08.2022.
//

class CreateOperationPresenter: CreateOperationPresenterProtocol {
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
