//
//  AuthorizationViewProtocol.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 13.08.2022.
//

import Foundation

protocol AuthorizationViewProtocol: AnyObject {
    func userCreationFailed(error: String)
    func updateEmailValidationState(isValid: Bool)
    func updateActionButtonState(isEnabled: Bool)
    func stopLoading()
}
