//
//  CreateOperationModel.swift
//  Wallet
//
//  Created by Danila on 13.08.2022.
//

import Foundation
import WalletNetworkKit

class CreateOperationService: CreateOperationServiceProtocol {
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func createOperation(data: CreateOperationModel, walletId: Int, completion: @escaping (Result<Operation, Error>) -> Void) {
        guard let data = try? JSONEncoder().encode(data),
              let id = UserSettings.userDefaults.userId else { return }
        
        let request = CreateOperationRequest(data: data, userId: id, walletId: walletId)
        
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
