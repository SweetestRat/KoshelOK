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
        updateScreenData()
    }
    
    private func updateScreenData() {
        guard let id = UserSettings.userDefaults.userId else { return }
        
        operationService.getWalletOperations(userId: id, walletId: walletId) { [weak self] result in
            switch result {
            case .success(let operations):
                self?.mapOperations(operations: operations)
                self?.setOperations(operations: operations)
                DispatchQueue.main.sync {
                    self?.view?.changeLoadingIndicatorState(state: .stopped)
                    if let walletOperations = self?.operations, !walletOperations.isEmpty {
                        self?.view?.changeWalletOperations(isEmpty: false)
                        self?.view?.updateOperationsList()
                    } else {
                        self?.view?.changeWalletOperations(isEmpty: true)
                    }
                }
            case .failure(let error):
                self?.view?.loadingError(error: error.localizedDescription)
            }
        }
        
        updateBalance(userId: id, walletId: walletId)
    }
    
    func updateBalance(userId: Int, walletId: Int) {
        guard let id = UserSettings.userDefaults.userId else { return }
        
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
        let currencyVM = wallet?.balance.currency
        router.openCreateOperation(currency: Currency(id: currencyVM?.hashValue ?? 1, shortName: currencyVM?.symbol ?? "RUB", longName: currencyVM?.fullName ?? "Российский рубль"), walletId: walletId, delegate: self)
    }
    
    func getWalletName() -> String {
        walletName
    }
    
    func removeOperation(indexPath: IndexPath) {
        guard let id = UserSettings.userDefaults.userId else { return }
        let transactions = operationService.getOperations()
        let transactionId = transactions[indexPath.section][indexPath.row].id
        
        operationService.deleteTransaction(section: indexPath.section, row: indexPath.row)
        operations?[indexPath.section].remove(at: indexPath.row)
        
        if operations?[indexPath.section].isEmpty == true {
            operationService.deleteTransactionSection(section: indexPath.section)
            operations?.remove(at: indexPath.section)
            view?.removeSection(section: indexPath.section)
        } else {
            view?.removeRow(indexPath: indexPath)
        }
        
        operationService.deleteOperation(userId: id, walletId: walletId, transactionId: transactionId) { [weak self] result in
            switch result {
            case .success(_):
                print("successfully deleted")
            case .failure(let error):
                self?.view?.loadingError(error: error.localizedDescription)
                guard let walletId = self?.walletId else { return }
                self?.updateBalance(userId: id, walletId: walletId)
            }
        }
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
    
    private func setOperations(operations: [Operation]) {
        guard !operations.isEmpty else { return }
        var operationsArray: [[Operation]] = []
        var sectionDate = dMMMDateFormatter.instance.format(timeStamp: operations[0].date)
        var sectionOperations: [Operation] = []
        
        operations.forEach { operation in
            let date = dMMMDateFormatter.instance.format(timeStamp: operation.date)
            
            if date == sectionDate {
                sectionOperations.append(operation)
            } else {
                sectionDate = date
                operationsArray.append(sectionOperations)
                sectionOperations = []
                sectionOperations.append(operation)
            }
        }
        
        operationsArray.append(sectionOperations)
        operationService.setOperations(operations: operationsArray)
    }
}

extension WalletInfoPresenter: CreateOperationPresenterDelegateProtocol {
    func operationCreated() {
        updateScreenData()
    }
}
