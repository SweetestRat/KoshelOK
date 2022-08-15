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
        let router = AuthorizationRouter()
        let presenter = AuthorizationPresenter(service: service, router: router)
        let viewController = AuthorizationViewController(presenter: presenter)
        
        presenter.view = viewController
        router.view = viewController
        
        return viewController
    }
}
