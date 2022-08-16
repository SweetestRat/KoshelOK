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
    
    func actionButtonDidTap(email: String) {
        let user = CreateUserModel(mail: email)
        guard let data = try? JSONEncoder().encode(user) else { return }
        service.createUser(data: data) { [weak self] result in
            switch result {
            case .success(let user):
                self?.router.openWalletsList(userId: user.id)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
}
