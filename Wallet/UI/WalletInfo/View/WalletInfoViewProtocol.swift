//
//  WalletInfoViewControllerProtocol.swift
//  Wallet
//
//  Created by Владислава Гильде on 13.08.2022.
//

import Foundation

protocol WalletInfoViewProtocol: AnyObject {
    func updateOperationsList()
    func operationsLoadingError(error: String)
}
