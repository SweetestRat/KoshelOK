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
    
    func deleteWallet(userId: Int, data: Wallet, completion: @escaping (Result<NoReply, Error>) -> Void) {
        let request = DeleteWalletRequest(userId: userId, walletId: data.id)
        
        networkManager.loadRequest(request: request) { result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }
}
