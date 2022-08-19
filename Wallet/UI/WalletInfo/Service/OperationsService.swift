//
//  OperationsService.swift
//  Wallet
//
//  Created by Владислава Гильде on 17.08.2022.
//

import Foundation
import WalletNetworkKit

class OperationService: WalletOperationsServiceProtocol {
    private let networkManager: NetworkManager
    private var operations: [[Operation]]
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        self.operations = [[]]
    }
    
    func getWalletOperations(userId: Int, walletId: Int, completion: @escaping (Result<[Operation], Error>) -> Void) {
        let request = GetOperationRequest(userId: userId, walletId: walletId)
        
        networkManager.loadRequest(request: request) { result in
            switch result {
            case .success(let resultData):
                completion(.success(resultData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func deleteOperation(userId: Int, walletId: Int, transactionId: Int, completion: @escaping (Result<NoReply, Error>) -> Void) {
        let request = DeleteOperationRequest(userId: userId, walletId: walletId, transactionId: transactionId)
        
        networkManager.loadRequest(request: request) { result in
            switch result {
            case .success(let resultData):
                completion(.success(resultData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getOperations() -> [[Operation]] {
        return operations
    }
    
    func setOperations(operations: [[Operation]]) {
        self.operations = operations
    }
    
    func deleteTransaction(section: Int, row: Int) {
        operations[section].remove(at: row)
    }
    
    func deleteTransactionSection(section: Int) {
        operations.remove(at: section)
    }
}
