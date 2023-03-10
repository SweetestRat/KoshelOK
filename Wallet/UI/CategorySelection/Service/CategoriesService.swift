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
    var categories: [Category]?
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func loadCategories(completion: @escaping (Result<[Category], Error>) -> Void) {
        guard let id = UserSettings.userDefaults.userId else { return }
        let request: CategoryRequestType = .loadCategories(userId: id)
        
        
        networkManager.loadRequest(request: request) { result in
            switch result {
            case .success(let resultDetails):
                self.categories = resultDetails
                completion(.success(resultDetails))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getCategories() -> [Category] {
        categories ?? []
    }
}
