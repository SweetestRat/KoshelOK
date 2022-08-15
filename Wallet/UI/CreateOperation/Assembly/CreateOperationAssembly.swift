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
        let viewController = CreateOperationViewController()
        let router = CreateOperationRouter(view: viewController)
        let presenter = CreateOperationPresenter(service: service, router: router)

        presenter.view = viewController
        viewController.presenter = presenter

        return viewController
    }
}
