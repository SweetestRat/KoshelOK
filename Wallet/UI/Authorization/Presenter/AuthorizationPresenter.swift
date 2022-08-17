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
        service.createUser(data: user) { [weak self] result in
            switch result {
            case .success(let user):
                UserSettings.userDefaults.userName = user.mail
                UserSettings.userDefaults.userId = user.id
                DispatchQueue.main.async {
                    self?.router.openWalletsList(userId: user.id)
                }
            case .failure(let error):
                self?.view?.userCreationFailed(error: error.localizedDescription)
            }
        }
    }
}
