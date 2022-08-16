//
//  CreateOperationAssembly.swift
//  Wallet
//
//  Created by Danila on 13.08.2022.
//

import Foundation

class CreateOperationAssembly {
    func assembly() -> CreateOperationViewController {
        let service = CreateOperationService()
        let router = CreateOperationRouter()
        let presenter = CreateOperationPresenter(service: service, router: router)
        let viewController = CreateOperationViewController(presenter: presenter)

        router.view = viewController
        presenter.view = viewController

        return viewController
    }
}
