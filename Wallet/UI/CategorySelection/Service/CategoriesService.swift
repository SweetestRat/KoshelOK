//
//  CategorySelectionModel.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 15.08.2022.
//

import Foundation
import WalletNetworkKit

class CategoriesService: CategoriesServiceProtocol {
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func loadCategories(completion: @escaping (Result<[Category], Error>) -> Void) {
        let request = CategoryRequest(parameters: [:])
        networkManager.makeRequest(request: request) { result in
            switch result {
                
            case .success(let resultDetails):
                completion(.success(resultDetails.categories))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
