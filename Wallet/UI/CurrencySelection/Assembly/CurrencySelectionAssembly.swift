//
//  CurrencySelectionAssembly.swift
//  Wallet
//
//  Created by Владислава Гильде on 12.08.2022.
//

import Foundation

class CurrencySelectionAssembly {
    func configureViewController() -> CurrencySelectionViewController {
        let model = CurrencySelectionModel()
        let viewController = CurrencySelectionViewController()
        let router = CurrencySelectionRouter(view: viewController)
        let presenter = CurrencySelectionPresenter(model: model, router: router, view: viewController)

        viewController.presenter = presenter
        model.presenter = presenter

        return viewController
    }
}
