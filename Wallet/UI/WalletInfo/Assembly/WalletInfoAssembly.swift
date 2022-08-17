//
//  WalletInfoAssembly.swift
//  Wallet
//
//  Created by Владислава Гильде on 13.08.2022.
//

import Foundation
import UIKit
import WalletNetworkKit

class WalletInfoAssembly {
    func assembly() -> WalletInfoViewController {
        let networkManager = NetworkManager()
        let walletInfoService = WalletInfoService(networkManager: networkManager)
        let operationService = OperationService(networkManager: networkManager)
        let router = WalletInfoRouter()
        let presenter = WalletInfoPresenter(walletInfoService: walletInfoService, operationService: operationService, router: router)
        let viewController = WalletInfoViewController(presenter: presenter)
        
        presenter.view = viewController
        router.view = viewController

        return viewController
    }
}
