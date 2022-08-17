//
//  CreateWalletAssembly.swift
//  Wallet
//
//  Created by Владислава Гильде on 12.08.2022.
//
import Foundation
import UIKit
import WalletNetworkKit

class CreateWalletAssembly {
    func assembly() -> CreateWalletViewController {
        let networkManager = NetworkManager()
        
        let service = CreateWalletService(networkManager: networkManager)
        let router = CreateWalletRouter()
        let presenter = CreateWalletPresenter(service: service, router: router)
        let viewController = CreateWalletViewController(presenter: presenter)
        
        presenter.view = viewController
        router.view = viewController

        return viewController
    }
}
