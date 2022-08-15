//
//  CreateWalletPresenter.swift
//  Wallet
//
//  Created by Владислава Гильде on 12.08.2022.
//

import UIKit

class CreateWalletPresenter: CreateWalletPresenterProtocol {
    private let service: CreateWalletServiceProtocol
    private let router: CreateWalletRouterProtocol
    weak var view: CreateWalletViewProtocol?
    
    init(service: CreateWalletServiceProtocol, router: CreateWalletRouterProtocol) {
        self.service = service
        self.router = router
    }
    
    func createWallet() {
        service.createWallet()
    }
    
    func openWalletsList() {
        router.openWalletsList()
    }
    
    func cellCurrencyInfoDidTap() {
        router.openCurrencySelection()
    }
}
