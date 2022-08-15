//
//  CreateWalletAssembly.swift
//  Wallet
//
//  Created by Владислава Гильде on 12.08.2022.
//
import Foundation
import UIKit

class CreateWalletAssembly {
    func assembly() -> CreateWalletViewController {
        let model = CreateWalletModel()
        let viewController = CreateWalletViewController()
        let router = CreateWalletRouter(view: viewController)
        let presenter = CreateWalletPresenter(model: model, router: router, view: viewController)
        
        viewController.presenter = presenter
        model.presenter = presenter

        return viewController
    }
}
