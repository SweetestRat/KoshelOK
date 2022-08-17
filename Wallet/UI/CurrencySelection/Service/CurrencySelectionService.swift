//
//  CurrencySelectionModel.swift
//  Wallet
//
//  Created by Владислава Гильде on 12.08.2022.
//

import Foundation
import WalletNetworkKit

class CurrencySelectionService: CurrencySelectionServiceProtocol {
    private let networkManager: NetworkManager
    private var currencies: [Currency]?
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func loadCurrencies(completion: @escaping (Result<[Currency], Error>) -> Void) {
        let request = CurrencyRequest(parameters: nil, method: .get)
        
        networkManager.loadRequest(request: request) { [weak self] result in
            switch result {
            case .success(let resultDetails):
                self?.currencies = resultDetails
                completion(.success(resultDetails))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getCurrencies() -> [Currency]? {
        return currencies
    }
}
