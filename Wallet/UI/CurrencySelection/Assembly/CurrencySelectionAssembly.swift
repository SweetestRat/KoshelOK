//
//  CurrencySelectionAssembly.swift
//  Wallet
//
//  Created by Владислава Гильде on 12.08.2022.
//

import Foundation

class CurrencySelectionAssembly {
    func assembly() -> CurrencySeletionViewController {
        let service = CurrencySeletionService()
        let router = CurrencySeletionRouter()
        let presenter = CurrencySeletionPresenter(service: service, router: router)
        let viewController = CurrencySeletionViewController(presenter: presenter)

          presenter.view = viewController
          router.view = viewController

        return viewController
    }
}
