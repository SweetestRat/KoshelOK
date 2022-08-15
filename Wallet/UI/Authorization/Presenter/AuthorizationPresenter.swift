//
//  AuthorizationPresenter.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 12.08.2022.
//

import Foundation

class AuthorizationPresenter: AuthorizationPresenterProtocol {
    var model: AuthorizationModelProtocol?
    var router: AuthorizationRouterProtocol?
    weak var view: AuthorizationViewProtocol?
    
    init(model: AuthorizationModelProtocol, router: AuthorizationRouterProtocol, view: AuthorizationViewProtocol) {
        self.model = model
        self.router = router
        self.view = view
    }
    
    func actionButtonDidTap() {
        router?.openWalletsList()
    }
}
