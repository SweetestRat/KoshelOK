//
//  WalletsListsControllerAssembly.swift
//  Wallet
//
//  Created by Danila on 12.08.2022.
//

import UIKit

class WalletsListsControllerAssembly {
    func assembly() -> UIViewController {
        let service = WalletsListService()
        let router = WalletsListRouter()
        let presenter = WalletsListScreenPresenter(service: service, router: router)
        let viewController = WalletsListViewController(presenter: presenter)
        
        presenter.view = viewController
        router.view = viewController
        
        return viewController
    }
}
