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
    private var wallets: [WalletViewModel]?
    
    init(service: WalletsListServiceProtocol, router: WalletsListRouterProtocol, userId: Int) {
        self.service = service
        self.router = router
        self.userId = userId
    }
    
    func controllerLoaded() {
        guard let id = UserSettings.userDefaults.userId else { return }
        service.getAllWallets(userId: id) { [weak self] result in
            switch result {
            case .success(let wallets):
                self?.wallets = self?.mapWallets(wallets: wallets)
                DispatchQueue.main.sync {
                    self?.view?.updateWalletsList()
                }
            case .failure(let error):
                self?.view?.walletsLoadingError(error: error.localizedDescription)
            }
        }
    }
    
    func getWallet(at row: Int) -> WalletViewModel? {
        wallets?[row]
    }
    
    func getNumberOfRows() -> Int {
        wallets?.count ?? 0
    }
    
    func createWalletClicked() {
        router.openCreateWallet()
    }
    
    func didTapWallet(at row: Int) {
        let selectedWalletName = wallets?[row].name
        guard let walletId = service.getWalletsModels()?.first (where: { wallet in
            wallet.name == selectedWalletName
        })?.id else { return }
        router.openWalletInfo(walletId: walletId)
    }

    private func mapWallets(wallets: [Wallet]) -> [WalletViewModel] {
        wallets.map { wallet in
            WalletViewModel(
                name: wallet.name,
                balance: BalanceViewModel(
                    value: Int(wallet.balance.amount) ?? 0,
                    currency: CurrencyViewModel(
                        symbol: wallet.balance.currency.shortName,
                        fullName: wallet.balance.currency.longName
                    )
                )
            )
        }
    }
}
