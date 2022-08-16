//
//  CurrencySelectionAssembly.swift
//  Wallet
//
//  Created by Владислава Гильде on 12.08.2022.
//

import Foundation

class CurrencySelectionAssembly {
    
    func assembly(delegate: CurrencySelectionDelegateProtocol) -> CurrencySelectionViewController {
        let service = CurrencySelectionService()
        let router = CurrencySelectionRouter()
        let presenter = CurrencySelectionPresenter(service: service, router: router)
        let viewController = CurrencySelectionViewController(presenter: presenter)
        
        presenter.delegate = delegate
        presenter.view = viewController
        router.view = viewController
        
        return viewController
    }
}
