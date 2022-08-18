//
//  SetupCategoryService.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 18.08.2022.
//

import UIKit
import WalletNetworkKit

class SetupCategoryService: SetupCategoryServiceProtocol {
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func setupCategory(data: SetupCategoryModel, completion: @escaping (Result<Category, Error>) -> Void) {
        guard let data = try? JSONEncoder().encode(data),
              let id = UserSettings.userDefaults.userId else { return }
        
        let request = SetupCategoryRequest(data: data, userId: id)
        
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
