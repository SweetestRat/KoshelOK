//
//  StartScreenRouter.swift
//  Wallet
//
//  Created by Владислава Гильде on 12.08.2022.
//

import UIKit

class StartScreenRouter: StartScreenRouterProtocol {
    weak var view: StartScreenViewProtocol?
    
    func openWalletsList() {
        let nextvc = WalletsListsControllerAssembly().assembly()
        guard let vc = view as? UIViewController else { return }
        
        vc.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        vc.navigationController?.pushViewController(nextvc, animated: true)
    }
}
