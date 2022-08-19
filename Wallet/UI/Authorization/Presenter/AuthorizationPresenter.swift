//
//  AuthorizationPresenter.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 12.08.2022.
//

import Foundation
import WalletDesignKit

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
        let isValid = email.count > 3
        view?.updateEmailValidationState(isValid: true)
        view?.updateActionButtonState(baseButtonState: isValid ? .active : .inactive)
    }
    
    func actionButtonDidTap() {
        guard isValidEmail() else { return }
        view?.updateActionButtonState(baseButtonState: .loading)
        
        let user = CreateUserModel(mail: email ?? "")
        service.createUser(data: user) { [weak self] result in
            switch result {
            case .success(let user):
                UserSettings.userDefaults.userName = user.mail
                UserSettings.userDefaults.userId = user.id
                DispatchQueue.main.async {
                    self?.view?.updateActionButtonState(baseButtonState: .inactive)
                    self?.router.openWalletsList(userId: user.id)
                }
            case .failure(let error):
                self?.view?.userCreationFailed(error: error.localizedDescription)
                DispatchQueue.main.async {
                    self?.view?.updateActionButtonState(baseButtonState: .active)
                }
            }
        }
    }
    
    func isValidEmail() -> Bool {
        guard let email = email else { return false }
        let isValid = email.count < 3 || email.matches(pattern: emailRegex)
        view?.updateEmailValidationState(isValid: isValid)
        return isValid
    }
}
