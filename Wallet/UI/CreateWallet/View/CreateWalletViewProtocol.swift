//
//  CreateWalletViewProtocol.swift
//  Wallet
//
//  Created by Владислава Гильде on 12.08.2022.
//

import Foundation
import WalletDesignKit

protocol CreateWalletViewProtocol: AnyObject {
    func updateCurrency(currency: Currency)
    func updateActionButtonState(actionState: BaseButtonState)
    func getWalletName() -> String?
    func walletCreationFailed(error: String)
    func stopLoading()
}
