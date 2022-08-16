//
//  CategorySelectionAssembly.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 14.08.2022.
//

import Foundation
import WalletNetworkKit

class CategorySelectionAssembly {
    func assembly() -> CategorySelectionViewController {
        let networkManager = NetworkManager()
        let service = CategorySelectionService(networkManager: networkManager)
        let router = CategorySelectionRouter()
        let presenter = CategorySelectionPresenter(service: service, router: router)
        let viewController = CategorySelectionViewController(presenter: presenter)

        presenter.view = viewController
        router.view = viewController

        return viewController
    }
}
