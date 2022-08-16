//
//  CategorySelectionAssembly.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 14.08.2022.
//

import Foundation
import WalletNetworkKit

class CategorySelectionAssembly {
    func assembly(delegate: CategorySelectionDelegateProtocol, category: CategoryViewModel) -> CategorySelectionViewController {
        let networkManager = NetworkManager()
        let router = CategorySelectionRouter()
        let service = CategoriesService(networkManager: networkManager)
        let presenter = CategorySelectionPresenter(service: service, category: category, router: router)
        let viewController = CategorySelectionViewController(presenter: presenter)

        presenter.view = viewController
        presenter.delegate = delegate
        router.view = viewController
        
        return viewController
    }
}
