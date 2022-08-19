//
//  AuthorizationViewProtocol.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 13.08.2022.
//

import Foundation
import WalletDesignKit

protocol AuthorizationViewProtocol: AnyObject {
    func userCreationFailed(error: String)
    func updateEmailValidationState(isValid: Bool)
    func updateActionButtonState(baseButtonState: BaseButtonState)
}
