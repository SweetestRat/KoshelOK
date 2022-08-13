//
//  AuthorizationRouter.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 13.08.2022.
//

import UIKit

class AuthorizationRouter: AuthorizationRouterProtocol {
    var view: AuthorizationViewProtocol?
    
    init(view: AuthorizationViewProtocol) {
        self.view = view
    }
    
    func openWalletsList() {
        let nextvc = WalletsListsControllerAssembly().assembly()
        guard let vc = view as? UIViewController else { return }
        
        vc.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        vc.navigationController?.pushViewController(nextvc, animated: true)
    }
}
