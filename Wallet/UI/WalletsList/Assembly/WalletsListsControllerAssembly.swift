//
//  WalletsListsControllerAssembly.swift
//  Wallet
//
//  Created by Danila on 12.08.2022.
//

import UIKit
import WalletNetworkKit

class WalletsListsControllerAssembly {
    func assembly(userId: Int) -> UIViewController {
        let networkManager = NetworkManager()
        let router = WalletsListRouter()
        let service = WalletsListService(networkManager: networkManager)
        let presenter = WalletsListScreenPresenter(service: service, router: router, userId: userId)
        let viewController = WalletsListViewController(presenter: presenter)
        
        presenter.view = viewController
        router.view = viewController
        
        return viewController
    }
}
