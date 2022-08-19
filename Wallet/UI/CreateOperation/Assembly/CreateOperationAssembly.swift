//
//  CreateOperationAssembly.swift
//  Wallet
//
//  Created by Danila on 13.08.2022.
//

import Foundation
import WalletNetworkKit

class CreateOperationAssembly {
    func assembly(currency: Currency, walletId: Int, delegate: CreateOperationPresenterDelegateProtocol) -> CreateOperationViewController {
        let networkManager = NetworkManager()
        let service = CreateOperationService(networkManager: networkManager)
        let router = CreateOperationRouter()
        let presenter = CreateOperationPresenter(service: service, router: router, walletId: walletId, currency: currency)
        let viewController = CreateOperationViewController(presenter: presenter)

        router.view = viewController
        presenter.view = viewController
        presenter.delegate = delegate

        return viewController
    }
}
