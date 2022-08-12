//
//  CreateWalletPresenter.swift
//  Wallet
//
//  Created by Владислава Гильде on 12.08.2022.
//

import UIKit

class CreateWalletPresenter: CreateWalletPresenterProtocol {
    private var model: CreateWalletModelProtocol?
    private var router: CreateWalletRouterProtocol?
    private weak var view: CreateWalletViewProtocol?
    
    init(model: CreateWalletModelProtocol, router: CreateWalletRouterProtocol, view: CreateWalletViewController) {
        self.model = model
        self.router = router
        self.view = view
    }
    
    func createWallet() {
        model?.createWallet()
    }
    
    func openWalletsList() {
        router?.openWalletsList()
    }
    
    func cellCurrencyInfoDidTap() {
        router?.openCurrencySelection()
    }
}
