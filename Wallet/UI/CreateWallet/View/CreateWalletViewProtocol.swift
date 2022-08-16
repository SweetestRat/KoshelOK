//
//  CreateWalletViewProtocol.swift
//  Wallet
//
//  Created by Владислава Гильде on 12.08.2022.
//

import Foundation

protocol CreateWalletViewProtocol: AnyObject {
    func updateCurrency(currency: CurrencyViewModel)
    func updateActionButtonState(isActive: Bool)
}
