//
//  WalletInfoRouter.swift
//  Wallet
//
//  Created by Владислава Гильде on 13.08.2022.
//

import UIKit

class WalletInfoRouter: WalletInfoRouterProtocol {
    weak var view: WalletInfoViewProtocol?
    
    func openCreateOperation() {
        let nextvc = CreateOperationAssembly().assembly()
        guard let vc = view as? UIViewController else { return }
        
        vc.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        vc.navigationController?.pushViewController(nextvc, animated: true)
    }
}
