//
//  CurrencySelectionAssembly.swift
//  Wallet
//
//  Created by Владислава Гильде on 12.08.2022.
//

import Foundation

class CurrencySelectionAssembly {
    func assembly() -> CurrencySeletionViewController {
        let model = CurrencySeletionModel()
        let viewController = CurrencySeletionViewController()
        let router = CurrencySeletionRouter(view: viewController)
        let presenter = CurrencySeletionPresenter(model: model, router: router, view: viewController)

        viewController.presenter = presenter
        model.presenter = presenter

        return viewController
    }
}
