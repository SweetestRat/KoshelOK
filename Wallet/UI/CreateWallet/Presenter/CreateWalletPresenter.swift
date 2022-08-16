//
//  CreateWalletPresenter.swift
//  Wallet
//
//  Created by Владислава Гильде on 12.08.2022.
//

import UIKit

class CreateWalletPresenter: CreateWalletPresenterProtocol {
    private var isButtonEnabled: Bool = false
    private let service: CreateWalletServiceProtocol
    private let router: CreateWalletRouterProtocol
    weak var view: CreateWalletViewProtocol?
    
    init(service: CreateWalletServiceProtocol, router: CreateWalletRouterProtocol) {
        self.service = service
        self.router = router
    }
    
    func createWallet() {
        service.createWallet()
        openWalletsList()
    }
    
    func openWalletsList() {
        router.openWalletsList()
    }
    
    func cellCurrencyInfoDidTap() {
        router.openCurrencySelection(delegate: self)
    }
    
    func textFieldDidChanchedValue(text: String?) {
        if text != "" {
            isButtonEnabled = true
        } else {
            isButtonEnabled = false
        }
        view?.updateActionButtonState(isActive: isButtonEnabled)
    }
}

extension CreateWalletPresenter: CurrencySelectionDelegateProtocol {
    func updateSelectedCurrency(currency: CurrencyViewModel) {
        view?.updateCurrency(currency: currency)
    }
}
