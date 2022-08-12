//
//  WalletsListsControllerAssembly.swift
//  Wallet
//
//  Created by Danila on 12.08.2022.
//

import UIKit

class WalletsListsControllerAssembly {
    func assembly() -> UIViewController {
        let presenter = WalletsListScreenPresenter()
        let controller = WalletsListViewController()
        controller.presenter = presenter
        return controller
    }
}
