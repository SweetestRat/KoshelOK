//
//  CurrencySelectionAssembly.swift
//  Wallet
//
//  Created by Владислава Гильде on 12.08.2022.
//

import Foundation
import WalletNetworkKit

class CurrencySelectionAssembly {
    
    func assembly(delegate: CurrencySelectionDelegateProtocol) -> CurrencySelectionViewController {
        let networkManager = NetworkManager()
        let service = CurrencySelectionService(networkManager: networkManager)
        let router = CurrencySelectionRouter()
        let presenter = CurrencySelectionPresenter(service: service, router: router)
        let viewController = CurrencySelectionViewController(presenter: presenter)
        
        presenter.delegate = delegate
        presenter.view = viewController
        router.view = viewController
        
        return viewController
    }
}
