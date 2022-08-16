//
//  CreateWalletRouter.swift
//  Wallet
//
//  Created by Владислава Гильде on 12.08.2022.
//

import Foundation
import UIKit

class CreateWalletRouter: CreateWalletRouterProtocol {
    weak var view: CreateWalletViewProtocol?
    
    func openWalletsList() {
        guard let vc = view as? UIViewController else { return }
        
        vc.navigationController?.popViewController(animated: true)
    }
    
    func openCurrencySelection(delegate: CurrencySelectionDelegateProtocol) {
        let nextvc = CurrencySelectionAssembly().assembly(delegate: delegate)
        guard let vc = view as? UIViewController else { return }
        
        vc.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        vc.navigationController?.pushViewController(nextvc, animated: true)
    }
}
