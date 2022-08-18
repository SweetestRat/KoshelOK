//
//  WalletInfoPresenter.swift
//  Wallet
//
//  Created by Владислава Гильде on 13.08.2022.
//

import Foundation

class WalletInfoPresenter: WalletInfoPresenterProtocol {
    private let walletInfoService: WalletInfoServiceProtocol
    private let operationService: WalletOperationsServiceProtocol
    private let router: WalletInfoRouterProtocol
    weak var view: WalletInfoViewProtocol?
    
    private var walletId: Int
    private var operations: [[OperationViewModel]]?
    private var wallet: WalletViewModel?
    private var walletName: String
    
    private let currencyViewModelFactory: CurrencyViewModelFactory
    private let categoryViewModelFactory: CategoryViewModelFactory
    private let balanceViewModelFactory: BalanceViewModelFactory
    private let walletViewModelFactory: WalletViewModelFactory
    private let operationViewModelFactory: OperationViewModelFactory
    
    init(walletInfoService: WalletInfoServiceProtocol, operationService: WalletOperationsServiceProtocol, router: WalletInfoRouterProtocol, walletId: Int, walletName: String) {
        self.walletInfoService = walletInfoService
        self.operationService = operationService
        self.router = router
        self.walletId = walletId
        self.walletName = walletName
        
        currencyViewModelFactory = CurrencyViewModelFactory()
        categoryViewModelFactory = CategoryViewModelFactory()
        balanceViewModelFactory = BalanceViewModelFactory(currencyFactory: currencyViewModelFactory)
        walletViewModelFactory = WalletViewModelFactory(balanceFactory: balanceViewModelFactory)
        operationViewModelFactory = OperationViewModelFactory(categoryFactory: categoryViewModelFactory, balanceFactory: balanceViewModelFactory)
    }
    
    func controllerLoaded() {
        guard let id = UserSettings.userDefaults.userId else { return }
        
        operationService.getWalletOperations(userId: id, walletId: walletId) { [weak self] result in
            switch result {
            case .success(let operations):
                self?.mapOperations(operations: operations)
                DispatchQueue.main.sync {
                    self?.view?.updateOperationsList()
                }
            case .failure(let error):
                self?.view?.loadingError(error: error.localizedDescription)
            }
        }
        
        walletInfoService.getWalletInfo(userId: id, walletId: walletId) { [weak self] result in
            switch result {
            case .success(let wallet):
                self?.wallet = self?.walletViewModelFactory.produce(from: wallet)
                DispatchQueue.main.sync {
                    guard let wallet = self?.wallet else { return }
                    self?.view?.updateBalances(wallet: wallet)
                }
            case .failure(let error):
                self?.view?.loadingError(error: error.localizedDescription)
            }
        }
    }
    
    func settingsDidTap() {
        
    }
    
    func getOperation(row: Int, section: Int) -> OperationViewModel? {
        let section = operations?[section]
        return section?[row]
    }
    
    func getNumberOfRowsInSection(section: Int) -> Int? {
        operations?[section].count
    }
    
    func getNumberOfSections() -> Int {
        operations?.count ?? 0
    }
    
    func createOperationButtonDidTap() {
        router.openCreateOperation()
    }
    
    func getWalletName() -> String {
        walletName
    }
    
    private func mapOperations(operations: [Operation]) {
        guard !operations.isEmpty else { return }
        self.operations = []
        var sectionDate = dMMMDateFormatter.instance.format(timeStamp: operations[0].date)
        var sectionOperations: [OperationViewModel] = []
        operations.forEach { operation in
            let date = dMMMDateFormatter.instance.format(timeStamp: operation.date)
            
            let viewModel = operationViewModelFactory.produce(from: operation)
            
            if date == sectionDate {
                sectionOperations.append(viewModel)
            } else {
                sectionDate = date
                self.operations?.append(sectionOperations)
                sectionOperations = []
                sectionOperations.append(viewModel)
            }
        }
        
        self.operations?.append(sectionOperations)
    }
}
