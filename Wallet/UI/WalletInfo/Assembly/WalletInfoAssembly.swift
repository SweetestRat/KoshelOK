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
        let model = WalletInfoModel()
        let viewController = WalletInfoViewController()
        let router = WalletInfoRouter(view: viewController)
        let presenter = WalletInfoPresenter(model: model, router: router, view: viewController)
        
        viewController.presenter = presenter
        model.presenter = presenter

        return viewController
    }
}
