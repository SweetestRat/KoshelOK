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
        let service = CategoriesService(networkManager: networkManager)
        let presenter = CategorySelectionPresenter(service: service)
        let viewController = CategorySelectionViewController(presenter: presenter)

        presenter.view = viewController

        return viewController
    }
}
