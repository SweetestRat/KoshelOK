//
//  WalletInfoRouterProtocol.swift
//  Wallet
//
//  Created by Владислава Гильде on 13.08.2022.
//

import Foundation

protocol WalletInfoRouterProtocol {
    func openCreateOperation(currency: Currency, walletId: Int, delegate: CreateOperationPresenterDelegateProtocol)
}
