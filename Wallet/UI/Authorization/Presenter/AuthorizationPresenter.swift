//
//  AuthorizationPresenter.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 12.08.2022.
//

import Foundation

class AuthorizationPresenter: AuthorizationPresenterProtocol {
    private let service: AuthorizationServiceProtocol
    private let router: AuthorizationRouterProtocol
    weak var view: AuthorizationViewProtocol?
    
    init(service: AuthorizationServiceProtocol, router: AuthorizationRouterProtocol) {
        self.service = service
        self.router = router
    }
    
    func actionButtonDidTap() {
        router.openWalletsList()
    }
}
