//
//  WalletsListRouter.swift
//  Wallet
//
//  Created by Владислава Гильде on 12.08.2022.
//

import UIKit

class WalletsListRouter: WalletsListRouterProtocol {
    weak var view: WalletsListControllerProtocol?
    
    func openCreateWallet() {
        let nextvc = CreateWalletAssembly().assembly()
        guard let vc = view as? UIViewController else { return }
        
        vc.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        vc.navigationController?.pushViewController(nextvc, animated: true)
    }
    
    func exitFromWallet() {
        let nextvc = StartScreenAssembly().assembly()
        guard let vc = view as? UIViewController else { return }
        
        UserSettings.userDefaults.exitFromAccount()
        vc.navigationController?.setViewControllers([nextvc], animated: false)
    }

    func openWalletInfo(walletId: Int, walletName: String) {
        let nextvc = WalletInfoAssembly().assembly(walletId: walletId, walletName: walletName)
        guard let vc = view as? UIViewController else { return }
        
        vc.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        vc.navigationController?.pushViewController(nextvc, animated: true)
    }
}
