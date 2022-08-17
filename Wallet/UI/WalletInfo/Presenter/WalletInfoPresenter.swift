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
    
    private var operations: [[OperationViewModel]]?
    
    init(walletInfoService: WalletInfoServiceProtocol, operationService: WalletOperationsServiceProtocol, router: WalletInfoRouterProtocol) {
        self.walletInfoService = walletInfoService
        self.operationService = operationService
        self.router = router
    }
    
    func controllerLoaded() {
        operationService.getWalletOperations(userId: 5, walletId: 6) { [weak self] result in
            switch result {
            case .success(let operations):
                self?.operations = self?.mapOperations(operations: operations)
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
    
    func getNumberOfRows() -> Int {
        operations?.count ?? 0
    }
    
    func getNumberOfRowsInSection(section: Int) -> Int? {
        return operations?[section].count
    }
    
    func createOperationButtonDidTap() {
        router.openCreateOperation()
    }
    
    private func mapOperations(operations: [Operation]) -> [[OperationViewModel]] {
        var sectionDate = ""
        var sectionOperations: [OperationViewModel] = []
        operations.forEach { operation in
            let date = dMMMDateFormatter.instance.format(timeStamp: operation.date)
            let time = TimeFormatter.instance.format(timeStamp: operation.date)
            
            let viewModel = OperationViewModel(category: operation.category.name,
                                               balance: operation.balanceDto.amount,
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
        
        guard let allOperations = self.operations else { return [[]] }
        
        return allOperations
    }
}
