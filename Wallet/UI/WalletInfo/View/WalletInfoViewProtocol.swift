//
//  WalletInfoViewControllerProtocol.swift
//  Wallet
//
//  Created by Владислава Гильде on 13.08.2022.
//

import Foundation

protocol WalletInfoViewProtocol: AnyObject {
    func updateOperationsList()
    func updateBalances(wallet: WalletViewModel)
    func loadingError(error: String)
    func changeLoadingIndicatorState(state: LoadingIndicatorState)
    func changeWalletOperations(isEmpty: Bool)
}
