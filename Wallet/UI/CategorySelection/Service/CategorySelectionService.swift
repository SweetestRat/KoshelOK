//
//  CategorySelectionModel.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 15.08.2022.
//

import Foundation
import WalletNetworkKit

class CategorySelectionService: CategorySelectionServiceProtocol {
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getData(complition: @escaping (Result<[Category], Error>) -> Void) {
        let request = CategoryRequest(parameters: [:])
        networkManager.makeRequest(request: request) { result in
            switch result {
                
            case .success(let resultDetails):
                complition(.success(resultDetails.categories))
            case .failure(let error):
                complition(.failure(error))
            }
        }
    }
}
