//
//  WalletInfoPresenter.swift
//  Wallet
//
//  Created by Владислава Гильде on 13.08.2022.
//

import Foundation

class WalletInfoPresenter: WalletInfoPresenterProtocol {
    private let walletInfoService: WalletInfoServiceProtocol
    private let operationService: WalletInfoServiceProtocol
    private let router: WalletInfoRouterProtocol
    weak var view: WalletInfoViewProtocol?
    
    init(walletInfoService: WalletInfoServiceProtocol, operationService: WalletInfoServiceProtocol, router: WalletInfoRouterProtocol) {
        self.walletInfoService = walletInfoService
        self.operationService = operationService
        self.router = router
    }
    
    func settingsDidTap() {
        
    }
    
    func createOperationButtonDidTap() {
        router.openCreateOperation()
    }
}
