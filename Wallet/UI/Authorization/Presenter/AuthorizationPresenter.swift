//
//  AuthorizationPresenter.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 12.08.2022.
//

import Foundation

class AuthorizationPresenter: AuthorizationPresenterProtocol {
    var service: AuthorizationServiceProtocol
    var router: AuthorizationRouterProtocol
    weak var view: AuthorizationViewProtocol?
    
    init(service: AuthorizationServiceProtocol, router: AuthorizationRouterProtocol) {
        self.service = service
        self.router = router
    }
    
    func actionButtonDidTap() {
        router.openWalletsList()
    }
}
