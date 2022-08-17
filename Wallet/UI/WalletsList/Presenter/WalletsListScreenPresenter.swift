//
//  WalletsListPresenter.swift
//  Wallet
//
//  Created by Danila on 12.08.2022.
//

import Foundation

class WalletsListScreenPresenter: WalletsListPresenterProtocol {
    weak var view: WalletsListControllerProtocol?
    private let router: WalletsListRouterProtocol
    private let service: WalletsListServiceProtocol
    private var userId: Int?
    
    init(service: WalletsListServiceProtocol, router: WalletsListRouterProtocol, userId: Int) {
        self.service = service
        self.router = router
        self.userId = userId
    }
    
    func controllerLoaded() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) { [weak self] in
            self?.view?.updateWalletsList(
                wallets: Array(repeating:
                                WalletViewModel(name: "Wallet Name",
                                                icon: "",
                                                balance:
                                                    BalanceViewModel(
                                                            value: 125,
                                                            currency:
                                                                CurrencyViewModel(symbol: "en_US",
                                                                                  fullName: "English USD")
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
