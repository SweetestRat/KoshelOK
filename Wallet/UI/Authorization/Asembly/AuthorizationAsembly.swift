//
//  AuthorizationAsembly.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 13.08.2022.
//

import UIKit

class AuthorizationAsembly {
    func assembly() -> UIViewController {
        let model = AuthorizationModel()
        let viewController = AuthorizationViewController()
        let router = AuthorizationRouter(view: viewController)
        let presenter = AuthorizationPresenter(model: model, router: router, view: viewController)
        
        viewController.presenter = presenter
        model.presenter = presenter
        
        return viewController
    }
}
