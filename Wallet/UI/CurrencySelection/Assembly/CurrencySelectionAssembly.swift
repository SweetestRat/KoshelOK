//
//  CurrencySelectionAssembly.swift
//  Wallet
//
//  Created by Владислава Гильде on 12.08.2022.
//

import Foundation

class CurrencySelectionAssembly {
    func assembly() -> CurrencySelectionViewController {
        let service = CurrencySelectionService()
        let router = CurrencySelectionRouter()
        let presenter = CurrencySelectionPresenter(service: service, router: router)
        let viewController = CurrencySelectionViewController()
        
        viewController.presenter = presenter
        router.view = viewController

        return viewController
    }
}
