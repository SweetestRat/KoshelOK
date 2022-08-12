//
//  WalletsListsControllerAssembly.swift
//  Wallet
//
//  Created by Danila on 12.08.2022.
//

import UIKit

class WalletsListsControllerAssembly {
    func assembly() -> UIViewController {
        let model = WalletsListModel()
        let controller = WalletsListViewController()
        let router = WalletsListRouter(view: controller)
        let presenter = WalletsListScreenPresenter(model: model, view: controller, router: router)
        
        controller.presenter = presenter
        model.presenter = presenter
        return controller
    }
}
