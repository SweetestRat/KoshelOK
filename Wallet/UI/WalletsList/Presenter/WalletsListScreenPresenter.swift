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
    private var currencyBalances: [CurrencyBalanceViewModel] = []
    
    private let currencyViewModelFactory: CurrencyViewModelFactory
    private let balanceViewModelFactory: BalanceViewModelFactory
    private let walletViewModelFactory: WalletViewModelFactory
    
    var userCurrencies: Set<CurrencyViewModel> = Set()
    
    init(service: WalletsListServiceProtocol, router: WalletsListRouterProtocol, userId: Int) {
        self.service = service
        self.router = router
        self.userId = userId
        
        currencyViewModelFactory = CurrencyViewModelFactory()
        balanceViewModelFactory = BalanceViewModelFactory(currencyFactory: currencyViewModelFactory)
        walletViewModelFactory = WalletViewModelFactory(balanceFactory: balanceViewModelFactory)
    }
    
    func controllerLoaded() {
        updateScreenData()
    }
    
    private func updateScreenData() {
        guard let id = UserSettings.userDefaults.userId else { return }
        
        service.getAllWallets(userId: id) { [weak self] result in
            switch result {
            case .success(let wallets):
                self?.wallets = self?.mapWallets(wallets: wallets)
                self?.updateBalances()
                DispatchQueue.main.sync {
                    self?.view?.changeLoadingIndicatorState(state: .stopped)
                    if let walletsList = self?.wallets, !walletsList.isEmpty {
                        self?.view?.changeWalletsList(isEmpty: false)
                        self?.view?.updateWalletsList()
                        self?.view?.updateBalances(commonBalance: self?.commonBalance, income: self?.income, expanse: self?.expanse)
                    } else {
                        self?.view?.changeWalletsList(isEmpty: true)
                    }
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
        router.openCreateWallet(delegate: self)
    }
    
    func createExitFromWallet() {
         router.exitFromWallet()
    }
    
    func getBalance(row: Int) -> CurrencyBalanceViewModel? {
        currencyBalances[row]
    }
    
    func getNumberOfBalanceRows() -> Int? {
        currencyBalances.count
    }
    
    func fillUserCurrencies() {
        guard let allWallets = wallets else { return }
        allWallets.forEach { wallet in
            self.userCurrencies.insert(wallet.balance.currency)
        }
    }
    
    func getNumberOfBalanceRows() -> Int {
        return self.userCurrencies.count
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
        
        currencyBalances = []
        fillUserCurrencies()
        
        var currentCurrency = ""
        var incomeValue = 0
        var expanseValue = 0
        userCurrencies.forEach { currency in
            let filtredWallets = wallets.filter { $0.balance.currency == currency }
            
            if currency.symbol != currentCurrency {
                incomeValue = 0
                expanseValue = 0
                currentCurrency = currency.symbol
            }
            
            let currencyAmount = filtredWallets.map { filtredWallet in
                incomeValue += filtredWallet.income.value
                expanseValue += filtredWallet.expanse.value
                return filtredWallet.balance.value
            }.reduce(0, +)
            
            currencyBalances.append(CurrencyBalanceViewModel(value: BalanceViewModel(value: currencyAmount, currency: currency), currency: currency, income: BalanceViewModel(value: incomeValue, currency: currency), expanse: BalanceViewModel(value: expanseValue, currency: currency)))
        }
        currencyBalances.sort { balance1, balance2 in
            return balance1.currency.symbol > balance2.currency.symbol
        }
        
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
            walletViewModelFactory.produce(from: wallet)
        }
    }
}


extension WalletsListScreenPresenter: CreateWalletPresenterDelegateProtocol {
    func walletCreated() {
        updateScreenData()
    }
}
