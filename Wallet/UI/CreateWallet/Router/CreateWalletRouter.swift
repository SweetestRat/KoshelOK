//
//  CreateWalletRouter.swift
//  Wallet
//
//  Created by Владислава Гильде on 12.08.2022.
//

import Foundation
import UIKit

class CreateWalletRouter: CreateWalletRouterProtocol {
    var view: CreateWalletViewProtocol?
    
    init(view: CreateWalletViewController) {
        self.view = view
    }
    
    func openWalletsList() {
        // call WalletsList Assembly
    }
    
    func openCurrencySelection() {
        let nextvc = CurrencySelectionAssembly().configureViewController()
        guard let vc = view as? UIViewController else { return }
        
        vc.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        vc.navigationController?.pushViewController(nextvc, animated: true)
    }
}
