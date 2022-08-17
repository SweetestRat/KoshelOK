//
//  WalletsListModel.swift
//  Wallet
//
//  Created by Владислава Гильде on 12.08.2022.
//

import Foundation
import WalletNetworkKit

class WalletsListService: WalletsListServiceProtocol {
    private let networkManager: NetworkManager
    private var walletsList: [Wallet]?
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getWalletsModels() -> [Wallet]? {
        walletsList
    }
    
    func getAllWallets(userId: Int, completion: @escaping (Result<[Wallet], Error>) -> Void) {
        let request = WalletsListRequest(userId: userId)
        
        networkManager.loadRequest(request: request) { [weak self] result in
            switch result {
            case .success(let resultData):
                self?.walletsList = resultData
                completion(.success(resultData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
