//
//  CreateWalletPresenterProtocol.swift
//  Wallet
//
//  Created by Владислава Гильде on 12.08.2022.
//

import UIKit

protocol CreateWalletPresenterProtocol: AnyObject {
    func createButtonDidTap()
    func openWalletsList()
    func cellCurrencyInfoDidTap()
    func textFieldDidChanchedValue(text: String?)
}
