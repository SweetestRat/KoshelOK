//
//  WalletsListRouterProtocol.swift
//  Wallet
//
//  Created by Владислава Гильде on 12.08.2022.
//

import Foundation

protocol WalletsListRouterProtocol {
    func openCreateWallet(delegate: CreateWalletPresenterDelegateProtocol)
    func exitFromWallet()
    func openWalletInfo(walletId: Int, walletName: String)
}
