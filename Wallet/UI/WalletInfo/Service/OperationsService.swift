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
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getWalletOperations(userId: Int, walletId: Int, completion: @escaping (Result<[Operation], Error>) -> Void) {
        let request = OperationRequest(userId: userId, walletId: walletId)
        
        networkManager.loadRequest(request: request) { result in
            switch result {
            case .success(let resultData):
                completion(.success(resultData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
