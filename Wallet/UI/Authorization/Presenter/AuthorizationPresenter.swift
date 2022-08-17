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
    
    private var email: String?
    
    init(service: AuthorizationServiceProtocol, router: AuthorizationRouterProtocol) {
        self.service = service
        self.router = router
    }
    
    func emailDidChange(email: String) {
        self.email = email
        let isValid = email.count < 3 || email.matches(pattern: emailRegex)
        view?.updateEmailValidationState(isValid: isValid)
        view?.updateActionButtonState(isEnabled: email.matches(pattern: emailRegex))
    }
    
    func actionButtonDidTap() {
        let user = CreateUserModel(mail: email ?? "")
        service.createUser(data: user) { [weak self] result in
            switch result {
            case .success(let user):
                UserSettings.userDefaults.userName = user.mail
                UserSettings.userDefaults.userId = user.id
                DispatchQueue.main.async {
                    self?.view?.stopLoading()
                    self?.router.openWalletsList(userId: user.id)
                }
            case .failure(let error):
                self?.view?.userCreationFailed(error: error.localizedDescription)
            }
        }
    }
}
