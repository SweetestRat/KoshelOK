//
//  CreateOperationAssembly.swift
//  Wallet
//
//  Created by Danila on 13.08.2022.
//

import Foundation

class CreateOperationAssembly {
    func assembly() -> CreateOperationViewController {
        let model = CreateOperationModel()
        let viewController = CreateOperationViewController()
        let router = CreateOperationRouter(view: viewController)
        let presenter = CreateOperationPresenter(model: model, router: router, view: viewController)

        viewController.presenter = presenter
        model.presenter = presenter

        return viewController
    }
}
