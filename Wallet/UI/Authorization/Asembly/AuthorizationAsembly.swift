//
//  AuthorizationAsembly.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 13.08.2022.
//

import UIKit

class AuthorizationAsembly {
    func assembly() -> UIViewController {
        let service = AuthorizationService()
        let viewController = AuthorizationViewController()
        let router = AuthorizationRouter(view: viewController)
        let presenter = AuthorizationPresenter(service: service, router: router)
        
        viewController.presenter = presenter
        presenter.view = viewController
        
        return viewController
    }
}
