//
//  WalletsListPresenter.swift
//  Wallet
//
//  Created by Danila on 12.08.2022.
//

import Foundation

class WalletsListScreenPresenter: WalletsListPresenterProtocol {
    private let router: WalletsListRouterProtocol
    private let service: WalletsListServiceProtocol
    weak var view: WalletsListControllerProtocol?
    
    init(service: WalletsListServiceProtocol, router: WalletsListRouterProtocol) {
        self.service = service
        self.router = router
    }
    func controllerLoaded() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) { [weak self] in
            self?.view?.updateWalletsList(
                wallets: Array(repeating:
                                Wallet(name: "Wallet Name",
                                       icon: "",
                                       balance:
                                        Balance(
                                            value: 125,
                                            currency: Currency(symbol: "en_US", fullName: "English USD")
                                        )
                                      ),
                               count: 30
                              )
            )
        }
    }
    
    func createWalletClicked() {
        router.openCreateWallet()
    }
    
    func didTapWallet() {
        router.openWalletInfo()
    }

}
