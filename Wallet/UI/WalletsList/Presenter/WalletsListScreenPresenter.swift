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
    private var commonBalance: BalanceViewModel?
    private var income: BalanceViewModel?
    private var expanse: BalanceViewModel?
    
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
                self?.updateBalances()
                DispatchQueue.main.sync {
                    self?.view?.updateWalletsList()
                    self?.view?.updateBalances(commonBalance: self?.commonBalance, income: self?.income, expanse: self?.expanse)
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
    
    func createExitFromWallet() {
         router.exitFromWallet()
    }
    
    func didTapWallet(at row: Int) {
        guard let selectedWalletName = wallets?[row].name,
              let walletId = service.getWalletsModels()?.first (where: { wallet in
            wallet.name == selectedWalletName
        })?.id else { return }
        router.openWalletInfo(walletId: walletId, walletName: selectedWalletName)
    }
    
    private func updateBalances() {
        guard
            let wallets = wallets,
            wallets.count > 0
        else { return }
        
        let currency = wallets[0].balance.currency
        var income = 0
        var expanse = 0
        wallets.forEach { wallet in
            income += wallet.income.value
            expanse += wallet.expanse.value
        }
        
        self.income = BalanceViewModel(value: income, currency: currency)
        self.expanse = BalanceViewModel(value: expanse, currency: currency)
        self.commonBalance = BalanceViewModel(value: income - expanse, currency: currency)
    }
    
    private func mapWallets(wallets: [Wallet]) -> [WalletViewModel] {
        wallets.map { wallet in
            WalletViewModel(
                name: wallet.name,
                balance: BalanceViewModel(
                    value: Int(wallet.balance.amount) ?? 0,
                    currency: CurrencyViewModel(
                        symbol: wallet.balance.currencyDto.shortName,
                        fullName: wallet.balance.currencyDto.longName
                    )
                ),
                income: BalanceViewModel(
                    value: Int(wallet.income.amount) ?? 0,
                    currency: CurrencyViewModel(
                        symbol: wallet.income.currencyDto.shortName,
                        fullName: wallet.income.currencyDto.longName
                    )
                ),
                expanse: BalanceViewModel(
                    value: Int(wallet.expense.amount) ?? 0,
                    currency: CurrencyViewModel(
                        symbol: wallet.expense.currencyDto.shortName,
                        fullName: wallet.expense.currencyDto.longName
                    )
                )
            )
        }
    }
}
