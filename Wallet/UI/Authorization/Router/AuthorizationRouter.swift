//
//  AuthorizationRouter.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 13.08.2022.
//

import UIKit

class AuthorizationRouter: AuthorizationRouterProtocol {
    weak var view: UIViewController?

    func openWalletsList(userId: Int) {
        let nextvc = WalletsListsControllerAssembly().assembly(userId: userId)
        guard let vc = view else { return }
        
        vc.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        vc.navigationController?.pushViewController(nextvc, animated: true)
        
        guard let navigationController = vc.navigationController else { return }
        var navigationArray = navigationController.viewControllers
        navigationArray.remove(at: navigationArray.count - 2)
        vc.navigationController?.viewControllers = navigationArray
    }
}
