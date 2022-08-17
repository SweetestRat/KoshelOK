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
    
    init(walletInfoService: WalletInfoServiceProtocol, operationService: WalletOperationsServiceProtocol, router: WalletInfoRouterProtocol, walletId: Int) {
        self.walletInfoService = walletInfoService
        self.operationService = operationService
        self.router = router
        self.walletId = walletId
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
                self?.view?.operationsLoadingError(error: error.localizedDescription)
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
    
    private func mapOperations(operations: [Operation]) {
        self.operations = []
        var sectionDate = dMMMDateFormatter.instance.format(timeStamp: operations[0].date)
        var sectionOperations: [OperationViewModel] = []
        operations.forEach { operation in
            let date = dMMMDateFormatter.instance.format(timeStamp: operation.date)
            let time = TimeFormatter.instance.format(timeStamp: operation.date)
            
            let viewModel = OperationViewModel(category: CategoryViewModel(name: operation.categoryDto.name,
                                                                           iconName: operation.categoryDto.iconName,
                                                                           iconColor: operation.categoryDto.iconColor),
                                               balance: BalanceViewModel(value: Int(operation.balanceDto.amount) ?? 0,
                                                                         currency: CurrencyViewModel(symbol: operation.balanceDto.currencyDto.shortName,
                                                                                                     fullName: operation.balanceDto.currencyDto.longName)),
                                               date: date,
                                               time: time)
            
            if date == sectionDate {
                sectionOperations.append(viewModel)
            } else {
                sectionDate = date
                self.operations?.append(sectionOperations)
                sectionOperations = []
            }
        }
        
        self.operations?.append(sectionOperations)
    }
}
