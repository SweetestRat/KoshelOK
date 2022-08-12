//
//  WalletsListPresenter.swift
//  Wallet
//
//  Created by Danila on 12.08.2022.
//

import Foundation

class WalletsListScreenPresenter: WalletsListPresenterProtocol {
    weak var view: WalletsListControllerProtocol?
    var router: WalletsListRouterProtocol?
    var model: WalletsListModelProtocol?
    
    init(model: WalletsListModelProtocol, view: WalletsListControllerProtocol, router: WalletsListRouterProtocol) {
        self.model = model
        self.router = router
        self.view = view
    }
    func controllerLoaded() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) { [weak self] in
            self?.view?.updateWalletsList(
                wallets: Array(repeating:
                                Wallet(name: "Wallet Name", icon: "", balance: Balance(value: 125, currency: Currency(symbol: "en_US"))), count: 30))
        }
    }
    
    func createWalletClicked() {
        router?.openCreateWallet()
    }
    
    func didTapWallet() {
        
    }

}
