//
//  AuthorizationModel.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 13.08.2022.
//

import Foundation
import WalletNetworkKit

class AuthorizationService: AuthorizationServiceProtocol {
    weak var presenter: AuthorizationPresenterProtocol?
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func createUser(data: CreateUserModel, completion: @escaping (Result<User, Error>) -> Void) {
        guard let data = try? JSONEncoder().encode(data) else { return }
        
        let request = AuthorizationRequest(data: data)
        
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
