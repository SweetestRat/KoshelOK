//
//  CreateWalletModel.swift
//  Wallet
//
//  Created by Владислава Гильде on 12.08.2022.
//

import UIKit
import WalletNetworkKit

class CreateWalletService: CreateWalletServiceProtocol {
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func createWallet(data: CreateWalletModel, completion: @escaping (Result<Wallet, Error>) -> Void) {
        guard let data = try? JSONEncoder().encode(data) else { return }
        
        let request = CreateWalletRequest(data: data, userId: 3) // TODO: get userId from UserDefault
        
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
