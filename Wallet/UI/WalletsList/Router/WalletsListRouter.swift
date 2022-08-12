//
//  WalletsListRouter.swift
//  Wallet
//
//  Created by Владислава Гильде on 12.08.2022.
//

import UIKit

class WalletsListRouter: WalletsListRouterProtocol {
    var view: WalletsListControllerProtocol?
    
    init(view: WalletsListControllerProtocol) {
        self.view = view
    }
    
    func openCreateWallet() {
        let nextvc = CreateWalletAssembly().configureViewController()
        guard let vc = view as? UIViewController else { return }
        
        vc.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        vc.navigationController?.pushViewController(nextvc, animated: true)
    }
}
