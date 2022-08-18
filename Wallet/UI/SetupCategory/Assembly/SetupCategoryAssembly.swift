//
//  SetupCategoryAssembly.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 18.08.2022.
//

import Foundation
import UIKit
import WalletNetworkKit

class SetupCategoryAssembly {
    func assembly(delegate: SetupCategoryPresenterDelegateProtocol) -> SetupCategoryViewController {
        let networkManager = NetworkManager()
        
        let service = SetupCategoryService(networkManager: networkManager)
        let router = SetupCategoryRouter()
        let presenter = SetupCategoryPresenter(service: service, router: router)
        let viewController = SetupCategoryViewController(presenter: presenter)
        
        presenter.view = viewController
        presenter.delegate = delegate
        router.view = viewController

        return viewController
    }
}
