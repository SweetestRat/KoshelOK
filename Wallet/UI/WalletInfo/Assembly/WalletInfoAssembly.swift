//
//  WalletInfoAssembly.swift
//  Wallet
//
//  Created by Владислава Гильде on 13.08.2022.
//

import Foundation
import UIKit

class WalletInfoAssembly {
    func assembly() -> WalletInfoViewController {
        let service = WalletInfoService()
        let router = WalletInfoRouter()
        let presenter = WalletInfoPresenter(service: service, router: router)
        let viewController = WalletInfoViewController(presenter: presenter)
        
        presenter.view = viewController
        router.view = viewController

        return viewController
    }
}
